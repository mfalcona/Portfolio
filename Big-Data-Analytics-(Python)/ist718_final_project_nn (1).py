# -*- coding: utf-8 -*-
"""IST718_Final_Project_NN.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1MK0uMFiNuM5j6qEyCuGqa54cQ-k5hdiW
"""

# neural network code for IST718 Final Project

!pip install eli5

import tensorflow as tf
from tensorflow import keras
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense
from tensorflow.keras.layers import Dropout
from tensorflow.keras.layers import Flatten
from tensorflow.keras.layers import Conv2D
from tensorflow.keras.layers import MaxPooling2D
from tensorflow.keras import utils
from tensorflow.keras import backend as K
K.image_data_format()

from tensorflow.keras import layers
from tensorflow.keras.layers.experimental import preprocessing

from sklearn.model_selection import train_test_split

import matplotlib.pyplot as plt
import time

import pandas as pd
import numpy as np

from keras.wrappers.scikit_learn import KerasClassifier, KerasRegressor
import eli5
from eli5.sklearn import PermutationImportance
from sklearn.metrics import classification_report, confusion_matrix

# loading data from local file directory

data = pd.read_csv('/pub_Hs_lean.csv')

# observing df structure

data.head()

# shape of dataframe

data.info()
data.shape

# dropping non-feature columns

model_data = data.drop(columns=['District','NCES_ID'])

model_data.head()

# establishing predictor variables and column we are predicting for

y = model_data.PURCHASED
x = model_data.drop('PURCHASED', axis = 1)

# establishing x/y test/train splits at 80/20 split

x_train,x_test,y_train,y_test=train_test_split(x,y,test_size=0.2)

# defining model function

def base_model():
    model = Sequential()
    model.add(Dense(7, kernel_initializer='normal',activation='relu'))
    model.add(Dropout(.35)) # 35% dropout gave me best results
    model.add(Dense(1, kernel_initializer='normal',activation='sigmoid')) # sigmoid == logistic for binary output
    model.compile(loss='binary_crossentropy', optimizer = 'adam',metrics=['accuracy']) # purchased = binary variable
    return(model)

# model fitting

from numpy.random import seed

start = time.time()  # TRACK TIME
seed(1)
model = base_model()
history = model.fit(x_train, y_train, validation_data=(x_test, y_test), epochs=40, batch_size=400, verbose=2)

# MODEL - RESULTS

scores = model.evaluate(x_test, y_test, verbose=0)
print("Baseline Error: %.2f%%" % (100-scores[1]*100))

end = time.time()
final_time = end-start
print(final_time)

print(model.summary())

# plotting training and validation accuracy

def plot_train_curve(history):
    colors = ['#e66101','#fdb863','#b2abd2','#5e3c99']
    accuracy = history.history['accuracy']
    val_accuracy = history.history['val_accuracy']
    loss = history.history['loss']
    val_loss = history.history['val_loss']
    epochs = range(len(accuracy))
    with plt.style.context("ggplot"):
        plt.figure(figsize=(8, 8/1.618))
        plt.plot(epochs, accuracy, marker='o', c=colors[3], label='Training accuracy')
        plt.plot(epochs, val_accuracy, c=colors[0], label='Validation accuracy')
        plt.title('Training and validation accuracy')
        plt.legend()
        plt.figure(figsize=(8, 8/1.618))
        plt.plot(epochs, loss, marker='o', c=colors[3], label='Training loss')
        plt.plot(epochs, val_loss, c=colors[0], label='Validation loss')
        plt.title('Training and validation loss')
        plt.legend()
        plt.show()
    
plot_train_curve(history)

# feature importance

perm = PermutationImportance(model, random_state=1,scoring='r2').fit(x_train,y_train)
eli5.show_weights(perm, feature_names = x.columns.tolist())

!pip3 install ann_visualizer
!pip install graphviz

from ann_visualizer.visualize import ann_viz

nn_viz = ann_viz(model, view = True, filename = 'nn_viz.gv', title="Neural Network Model for Predicting SAM Labs Purchase")

# confusion matrix

from sklearn.metrics import confusion_matrix

yhat = model.predict_classes(x_test, verbose=0)

cm = confusion_matrix(y_test, yhat)

cm

# links

https://www.tensorflow.org/api_docs/python/tf/keras/activations
https://stackoverflow.com/questions/48618879/whats-the-dimensionality-of-the-output-space-in-tensorflows-docs
https://www.tensorflow.org/api_docs/python/tf/keras/Model
https://www.tensorflow.org/api_docs/python/tf/keras/losses/binary_crossentropy
https://www.tensorflow.org/api_docs/python/tf/keras/Model
https://colab.research.google.com/drive/1hvNqUTT44E8w0B71TPzxUZpWHJTiQbby#scrollTo=cmXnvyHCDv-g
https://stackoverflow.com/questions/45361559/feature-importance-chart-in-neural-network-using-keras-in-python
https://scikit-learn.org/stable/modules/model_evaluation.html
https://machinelearningmastery.com/rectified-linear-activation-function-for-deep-learning-neural-networks/ 
https://machinelearningmastery.com/how-to-choose-loss-functions-when-training-deep-learning-neural-networks/