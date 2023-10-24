from builtins import object
import io
import pytest
from psychopy.tools.wizard import ConfigWizard, BenchmarkWizard

import psychopy.tools.wizard

# py.test -k wizard --cov-report term-missing --cov wizard.py

@pytest.mark.wizard
class TestWizard(object):

    def setup(self):
        pass

    def teardown(self):
        pass

    def test_firstrunWizardWithBadCard(self):
        def notOkay():
            return False
        tmpcardOkay = psychopy.tools.wizard.cardOkay
        psychopy.tools.wizard.cardOkay = notOkay  # fake function to simulate a bad graphics card
        try:
            con = ConfigWizard(firstrun=False, interactive=False, log=False)
            with io.open(con.reportPath, 'r', encoding='utf-8-sig') as f:
                result = f.read()
            assert 'This page was auto-generated by the PsychoPy configuration wizard' in result
        finally:
            psychopy.tools.wizard.cardOkay = tmpcardOkay

    def test_firstrunWizard(self):
        con = ConfigWizard(firstrun=False, interactive=False, log=False)
        with io.open(con.reportPath, 'r', encoding='utf-8-sig') as f:
            result = f.read()
        assert 'This page was auto-generated by the PsychoPy configuration wizard' in result

    def test_benchmarkWizard(self):
        ben = BenchmarkWizard(fullscr=False, interactive=False, log=False)
        with io.open(ben.reportPath, 'r', encoding='utf-8-sig') as f:
            result = f.read()
        assert 'This page was auto-generated by the PsychoPy configuration wizard' in result
