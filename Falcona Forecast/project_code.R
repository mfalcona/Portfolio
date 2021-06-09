# Matthew Falcona
# IST-707 Final Project Code

# pre-processing

# download past 3 years of results from this link: https://fbref.com/en/comps/11/1476/schedule/2015-2016-Serie-A-Scores-and-Fixtures

# save as xls

# in excel, delete the blank rows
# insert columns on either side of "score" column
# using 'LEFT' and 'RIGHT' functions, extract the home and away team's scores for each match
# then read in tables to R

results_2019 <- read.csv('/Users/matthewfalcona/School/IST-707 Analytics/IST707 Data Mining/ist707_project/serieA_2019_results.csv')
results_2018 <- read.csv('/Users/matthewfalcona/School/IST-707 Analytics/IST707 Data Mining/ist707_project/serieA_2018_results.csv')
results_2017 <- read.csv('/Users/matthewfalcona/School/IST-707 Analytics/IST707 Data Mining/ist707_project/serieA_2017_results.csv')
test_2020 <- read.csv('/Users/matthewfalcona/School/IST-707 Analytics/IST707 Data Mining/ist707_project/serieA_2020_test.csv')

# eliminating unused columns/rows and renaming remaining

results_2019 <- results_2019[,6:9]
results_2018 <- results_2018[,6:9]
results_2017 <- results_2017[,6:9]

results <- rbind(results_2019, results_2018)
results <- rbind(results, results_2017)

colnames(results) <- c("hxG", "hScore", "aScore","axG")

results["xMargin"] <- results$hxG - results$axG
results["actMargin"] <- results$hScore - results$aScore

results["xResult"] <- ifelse(results$hxG > results$axG, "Home", ifelse(results$hxG < results$axG, "Away", "Draw"))
results["actResult"] <- ifelse(results$hScore > results$aScore, "Home", ifelse(results$hScore < results$aScore, "Away", "Draw"))
results["Error"] <- results$xMargin - results$actMargin
results$Error <- round(results$Error, digits = 1)
results["corResult"] <- ifelse(results$xResult == results$actResult, "Same", "Diff")

test_2020["xMargin"] <- test_2020$hxG - test_2020$axG
test_2020["actMargin"] <- test_2020$hScore - test_2020$aScore

test_2020["xResult"] <- ifelse(test_2020$hxG > test_2020$axG, "Home", ifelse(test_2020$hxG < test_2020$axG, "Away", "Draw"))
test_2020["actResult"] <- ifelse(test_2020$hScore > test_2020$aScore, "Home", ifelse(test_2020$hScore < test_2020$aScore, "Away", "Draw"))
test_2020["Error"] <- test_2020$xMargin - test_2020$actMargin
test_2020$Error <- round(test_2020$Error, digits = 1)
test_2020["corResult"] <- ifelse(test_2020$xResult == test_2020$actResult, "Same", "Diff")

test_2020 <- test_2020[1:88,]
test_2020 <- test_2020[,-8]
test_2020 <- test_2020[,-10]
test_2020 <- test_2020[,-9]

# decision tree

library(rpart)

results_train <- results[,-10]

# creating training data specific to margin of victory
results_train_marg <- results_train[,-8]

# removing unused columns from training data

results_train <- results_train[,-2:-3]
results_train_res <- results_train[,-4]
results_train_res <- results_train_res[,-6]

# removing unused columns from testing data

pred_data <- test_2020[,-2:-3]
pred_data <- pred_data[,-4]
pred_data <- pred_data[,-5]

# creating decision tree for predicting result of match
dt_res <- rpart(actResult~., data = results_train_res)
dt_pred_res <- predict(dt_res, newdata = pred_data, type=c("class"))
serieA_res_pred <- cbind(pred_data, dt_pred_res)
serieA_res_pred_acc <- cbind(test_2020, dt_pred_res)

# writing csv file with the predictor accuracy
write.csv(serieA_res_pred_acc, file="/Users/matthewfalcona/School/IST-707 Analytics//IST707 Data Mining/ist707_project/serieA_res_pred.csv", row.names=FALSE)


results_train_marg <- results_train[-6:-7]

dt_marg <- rpart(actMargin~., data = results_train_marg)
dt_pred_marg <- predict(dt_marg, newdata = pred_data, type = c("vector"))
serieA_marg_pred <- cbind(pred_data, dt_pred_marg)
serieAmarg_pred_acc <- cbind(test_2020, dt_pred_marg)


# writing csv file with the predictor accuracy
write.csv(serieAmarg_pred_acc, file="/Users/matthewfalcona/School/IST-707 Analytics//IST707 Data Mining/ist707_project/serieA_marg_pred.csv", row.names=FALSE)


#############################
# buidling a model based on team performance

# team stats: npxDiff/90, npxG/shot, prog passes, GCA/90, SCA/90, poss

# need to build team profiles from multiple tables from FBref.

# only relevant for current season

team_results_2020 <- read.csv('/Users/matthewfalcona/School/IST-707 Analytics/IST707 Data Mining/ist707_project/serieA_2020_results_team.csv')
team_results_2020 <- team_results_2020[,-1]
team_results_2020 <- team_results_2020[,-7]
team_results_2020 <- team_results_2020[1:93,]

ros_2020 <- read.csv('/Users/matthewfalcona/School/IST-707 Analytics/IST707 Data Mining/ist707_project/serieA_ROS_2020.csv')
ros_2020 <- ros_2020[,-1]
ros_2020 <- ros_2020[,-7]

dt_team <- rpart(margin~., data = team_results_2020, method = "anova", control = rpart.control(minbucket = 3, cp = .0001, xval = 30))
dt_pred_team <- predict(dt_team, newdata = ros_2020, type = c("vector"))
ros_pred <- cbind(ros_2020, dt_pred_team)
write.csv(ros_pred, file="/Users/matthewfalcona/School/IST-707 Analytics//IST707 Data Mining/ist707_project/ros_pred.csv", row.names=FALSE)

dt_team$variable.importance

library(rpart.plot)

rpart.plot(dt_team, box.palette="RdBu", shadow.col="gray", nn=TRUE)

