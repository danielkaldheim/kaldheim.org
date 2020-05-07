import React from 'react';
import PropTypes from 'prop-types';
import { Link } from 'gatsby';
import Img from 'gatsby-image';
import Navigation from './navigation';
import { toKebabCase } from '../helpers';

import style from '../styles/post.module.scss';

const Post = ({
  title,
  date,
  path,
  coverImage,
  author,
  excerpt,
  tags,
  html,
  github,
  type,
  previousPost,
  nextPost,
}) => {
  const previousPath = previousPost && previousPost.frontmatter.path;
  const previousLabel = previousPost && previousPost.frontmatter.title;
  const nextPath = nextPost && nextPost.frontmatter.path;
  const nextLabel = nextPost && nextPost.frontmatter.title;

  return (
    <div className={style.post}>
      <div className={style.postContent}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <h1 className={style.title}>
            {excerpt ? <Link to={path}>{title}</Link> : title}
          </h1>
          {github && (
            <>
              <a
                href={github}
                style={{
                  display: 'flex',
                  flexDirection: 'column',
                  textAlign: 'center',
                  textDecoration: 'none',
                }}
              >
                <i className="fab fa-github" style={{ fontSize: 30 }} />
                <span style={{ fontSize: 10 }}>Fork repo on github</span>
              </a>
            </>
          )}
        </div>
        <div className={style.meta}>
          {type === 'post' && (
            <>
              {date && <>{date}</>} {author && <>— Written by {author}</>}
            </>
          )}
          {tags ? (
            <div className={style.tags}>
              {tags.map(tag => (
                <Link to={`/tag/${toKebabCase(tag)}/`} key={toKebabCase(tag)}>
                  <span className={style.tag}>#{tag}</span>
                </Link>
              ))}
            </div>
          ) : null}
        </div>

        {coverImage && (
          <Img
            fluid={coverImage.childImageSharp.fluid}
            className={style.coverImage}
          />
        )}

        {excerpt ? (
          <>
            <p>{excerpt}</p>
            <Link to={path} className={style.readMore}>
              Read more →
            </Link>
          </>
        ) : (
          <>
            <div dangerouslySetInnerHTML={{ __html: html }} />
            {type === 'post' && (
              <>
                <Navigation
                  previousPath={previousPath}
                  previousLabel={previousLabel}
                  nextPath={nextPath}
                  nextLabel={nextLabel}
                />
              </>
            )}
          </>
        )}
      </div>
    </div>
  );
};

Post.propTypes = {
  title: PropTypes.string,
  date: PropTypes.string,
  path: PropTypes.string,
  coverImage: PropTypes.object,
  author: PropTypes.string,
  type: PropTypes.string,
  github: PropTypes.string,
  excerpt: PropTypes.string,
  html: PropTypes.string,
  tags: PropTypes.arrayOf(PropTypes.string),
  previousPost: PropTypes.object,
  nextPost: PropTypes.object,
};

export default Post;
