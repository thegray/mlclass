theta = 1.0 #
eps = 0.01 #

def Jfunc(thetaIn): #
    return (3 * (thetaIn ** 4)) + 4

derivative = (Jfunc(theta+eps) - Jfunc(theta-eps) ) / (2 * eps)

print("derivative val: {}".format(derivative))
