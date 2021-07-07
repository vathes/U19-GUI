function [mazes, criteria, globalSettings, vr] = PoissonPatchesV2(vr)
  
  %________________________________________ 1 _________ 2 _________ 3 _________ 4 _________ 5 _________ 6 _________ 7 __________ 8 __________ 9 __________ 10 ______________
  mazes     = struct( 'lStart'          , {6         , 30        , 30        , 30        , 30        , 30        , 30         , 30         , 30         , 30         }   ...
                    , 'lCue'            , {40        , 60        , 120       , 200       , 300       , 300       , 300        , 300        , 300        , 300        }   ...
                    , 'lMemory'         , {10        , 20        , 40        , 70        , 100       , 100       , 100        , 100        , 100        , 100        }   ...
                    , 'lTurn'           , {5         , 15        , 35        , 65        , 50        , 50        , 50         , 50         , 50         , 50         }   ...
                    , 'tri_turnHint'    , {1         , 1         , 1         , 1         , 1         , 2         , 2          , 2          , 2          , 2          }   ...
                    , 'hHint'           , {40        , 40        , 35        , 25        , 15        , 15        , 15         , 15         , 15         , 15         }   ...
                    , 'cueVisibleRange' , {nan       , nan       , nan       , nan       , nan       , nan       , nan        , nan        , inf        , 14         }   ...
                    , 'cueProbability'  , {inf       , inf       , inf       , inf       , inf       , inf       , 2.5        , 1.2        , 1.2        , 1.2        }   ...
                    , 'cueDensityPerM'  , {1         , 2         , 2         , 2.5       , 2.5       , 2.5       , 3          , 3.5        , 3.5        , 3.5        }   ...
                    );                                                                                                                                               
  criteria  = struct( 'numTrials'       , {20        , 80        , 100       , 100       , 100       , 100       , 100        , 100        , 100        , 100        }   ...
                    , 'numTrialsPerMin' , {3         , 3         , 3         , 3         , 3         , 3         , 3          , 3          , 3          , 3          }   ...
                    , 'warmupNTrials'   , {[]        , []        , []        , []        , []        , 40        , [10  ,15  ], [10  ,15  ], [10  ,15  ], [10  ,15  ]}   ...
                    , 'numSessions'     , {0         , 0         , 0         , 0         , 2         , 3         , 2          , 2          , 1          , 1          }   ...
                    , 'performance'     , {0         , 0         , 0.6       , 0.6       , 0.8       , 0.8       , 0.75       , 0.7        , 0.7        , 0.65       }   ...
                    , 'maxBias'         , {inf       , 0.2       , 0.2       , 0.2       , 0.1       , 0.1       , 0.15       , 0.15       , 0.15       , 0.15       }   ...
                    , 'warmupMaze'      , {[]        , []        , []        , []        , []        , 5         , [5   ,6   ], [5   ,7   ], [5   ,7   ], [5   ,7   ]}   ...
                    , 'warmupPerform'   , {[]        , []        , []        , []        , []        , 0.8       , [0.85,0.8 ], [0.85,0.8 ], [0.85,0.8 ], [0.85,0.8 ]}   ...
                    , 'warmupBias'      , {[]        , []        , []        , []        , []        , 0.1       , [0.1 ,0.1 ], [0.1 ,0.1 ], [0.1 ,0.1 ], [0.1 ,0.1 ]}   ...
                    , 'warmupMotor'     , {[]        , []        , []        , []        , []        , 0         , [0.75,0.75], [0.75,0.75], [0.75,0.75], [0.75,0.75]}   ...
                    );

  globalSettings          = {'cueMinSeparation', 16, 'cueVisibleAt', 6, 'yCue', 8};
  vr.numMazesInProtocol   = numel(mazes);
  vr.stimulusGenerator    = @PoissonStimulusTrain;
  vr.stimulusParameters   = {'cueVisibleAt', 'cueDensityPerM', 'cueProbability', 'nCueSlots', 'cueMinSeparation', 'panSessionTrials'};
  vr.inheritedVariables   = {'cueVisibleRange'};

  
  if nargout < 1
    figure; plot([mazes.lStart] + [mazes.lCue] + [mazes.lMemory], 'linewidth',1.5); xlabel('Shaping step'); ylabel('Maze length (cm)'); grid on;
    hold on; plot([mazes.lMemory], 'linewidth',1.5); legend({'total', 'memory'}, 'Location', 'east'); grid on;
    figure; plot([mazes.lMemory] ./ [mazes.lCue], 'linewidth',1.5); xlabel('Shaping step'); ylabel('L(memory) / L(cue)'); grid on;
    figure; plot([mazes.cueDensityPerM], 'linewidth',1.5); set(gca,'ylim',[0 6.5]); xlabel('Shaping step'); ylabel('Tower density (count/m)'); grid on;
    hold on; plot([mazes.cueDensityPerM] .* (1 - 1./(1 + exp([mazes.cueProbability]))), 'linewidth',1.5);
    hold on; plot([1 numel(mazes)], [1 1].*(100/globalSettings{2}), 'linewidth',1.5, 'linestyle','--');
    legend({'\rho_{L} + \rho_{R}', '\rho_{salient}', '(maximum)'}, 'location', 'southeast');
  end

end
