import React, { useState, useEffect } from "react";


import { makeStyles } from "@material-ui/core/styles";
import {
  Button,
  Dialog,
  Link,
  Typography,
  DialogActions,
  DialogContent,
  DialogTitle
} from "@material-ui/core";

import { i18n } from "../../translate/i18n";
import useAuth from "../../hooks/useAuth.js";
import { useTheme } from "@material-ui/core/styles";

import { loadJSON } from "../../helpers/loadJSON";
import api from "../../services/api";

const frontendGitInfo = loadJSON('/gitinfo.json');
const logo = "/vector/logo.svg";
const logoDark = "/vector/logo-dark.svg";

const useStyles = makeStyles(theme => ({
	root: {
		display: "flex",
		flexWrap: "wrap",
	},
	multFieldLine: {
		display: "flex",
		"& > *:not(:last-child)": {
			marginRight: theme.spacing(1),
		},
	},
  logoImg: {
    width: "100%",
    margin: "0 auto",
    content: `url("${theme.calculatedLogo()}")`
  },
  ticketzLogoImg: {
    width: "100%",
    margin: "0 auto",
    content: "url(" + (theme.mode === "light" ? logo : logoDark) + ")"
  },
  textCenter: {
    textAlign: "center",
  }

}));

const AboutModal = ({ open, onClose }) => {
	const classes = useStyles();
  const { getCurrentUserInfo } = useAuth();
  const [currentUser, setCurrentUser] = useState({});
  const [backendGitInfo, setBackendGitInfo] = useState(null);
  const theme = useTheme();


	const handleClose = () => {
		onClose();
	};

  useEffect(() => {
    getCurrentUserInfo().then(
      (user) => {
        setCurrentUser(user);
      }
    );

    api.get("/").then(
      (response) => {
        setBackendGitInfo(response.data);
      }
    )
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

	return (
		<div className={classes.root}>
			<Dialog
				open={open}
				onClose={handleClose}
				maxWidth="sm"
				fullWidth
				scroll="paper"
			>
			</Dialog>
		</div>
	);
};

export default AboutModal;
