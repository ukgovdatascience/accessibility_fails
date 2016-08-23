# Accessibility Fails

## Quick brief

The Accessibility team are using a number of automated services to check pages for their accessibility.
They have made an assessment of ten of these tools [here](https://cfq.github.io/accessibility-fails/).

What they want to know is:
* What are the best combinations of the different tools
* How does this change when you consider different scoring criteria?

### Scoring criteria

The three scoring criteria are:
* error found
* error found + warning reported
* /error found + warning reported + manual inspection

## Outline of method

* Hash the various accessibility fails to make them easier to work with
* Create three dataframes and binarise for the three success criteria
* Compute rowsums for all the possible combinations of accessibility tools
* Visualise this data somehow


