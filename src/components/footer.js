import React from 'react';
import PropTypes from 'prop-types';

const Footer = ({ copyrights }) => (
  <footer>
    <span className="footerCopyrights">&copy; 2020 &ndash; {copyrights}</span>
    <span className="footerCopyrights soscialIcons">
      <a href="https://www.instagram.com/dark.makes/">
        <i className="fab fa-instagram" />
      </a>
      <a href="https://www.youtube.com/channel/UCZMleiZH9L-lUjNOLQAJsWA">
        <i className="fab fa-youtube" />
      </a>
      <a href="https://github.com/danielkaldheim">
        <i className="fab fa-github" />
      </a>
    </span>
  </footer>
);

Footer.propTypes = {
  copyrights: PropTypes.string,
};

export default Footer;
