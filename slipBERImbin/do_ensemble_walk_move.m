function [ m_trial ] = do_ensemble_walk_move( m_curr, walkernumber, otherwalkers)
% This function takes a current model parameter and performs a 'walk
% move' to draw a new trial.
% For efficiency, each model parameter has n 'walkers', and a perturbation
% is added to the current walker. This perturbation is generated using the
% three otherwalkers. A triangle is formed using the three otherwalkers and
% the perturbation is generated by randomly summing multiples of the vector
% from the centre of the triangle to the three otherwalkers.
% This is based on the method described by Goodman & Weare 2010 in
% 'Communications in Applied Mathematics and Computational Science'
%
% Inputs =
%   m_curr = Current model parameter. Can just be one number, or can be a
%            matrix where each row is another model parameter (e.g. slip on
%            patch 1, slip on patch 2, slip on patch 3...) and each column
%            is another walker
%   walkernumber = the current walker upon which the walk move is acting
%   otherwalkers = the otherwalkers that are involved in creating a perturbation for the current walker
%
%
% Ruth Amey (ruthmjamey@gmail.com) based on a code by Andy Hooper
% 22/1/18

triangle_centre = (((m_curr(:,otherwalkers(1)) + m_curr(:,otherwalkers(2)))/2 ) + m_curr(:,otherwalkers(3)))/2;
arrows = [m_curr(:,otherwalkers(1)) m_curr(:,otherwalkers(2)) m_curr(:,otherwalkers(3))] - triangle_centre;
perturbation = sum((rand(size(m_curr,1),3) .* arrows),2);
m_trial = m_curr(:,walkernumber)+ perturbation;

end

