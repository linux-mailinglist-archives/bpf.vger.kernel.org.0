Return-Path: <bpf+bounces-50207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B50A23AAE
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 09:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EDF2167F9D
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 08:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47699165F1A;
	Fri, 31 Jan 2025 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oCjnKWSn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA171531D2
	for <bpf@vger.kernel.org>; Fri, 31 Jan 2025 08:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738312383; cv=none; b=TG+cLjJctOfLN6Y8Ceb4yvxAon25SDPZpY+7tJ71mKgCFUM56soTt2krrEpHwgjN1x/038LNarvy/F3FUs0pocp7TSoR/q1SkEnnacURLQKV3iSvDKoTo86llfXYxiKGKgFOIU+ytcSxXx8gugA01kLC1Me3YPu6WnY7V7V4yi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738312383; c=relaxed/simple;
	bh=sdw8l8+NwkV6INk3+hpf0YRFmqr5W8dwp/CmE3pzgZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7bYe4kH+ata9KqujgcNI9sfo1U2hKGE/jUkDzWr5xJLBgK8q8Mb2Y0kXFvRtLoiOvGYPmhyD1hhz1L2tgPLN5SSuVlOjIeAn7+i1rp+D/k7Q3x8Cl0C+4cjunJ5WEm+Ji+GFD43j4jwJ12ndFaahJjGWs6M6xLoj5l3VfiIazs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oCjnKWSn; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so344887366b.3
        for <bpf@vger.kernel.org>; Fri, 31 Jan 2025 00:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738312380; x=1738917180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=egqRvUyLfakli10+ggYKvwxMdmYV8I7LQkQH/AIbN90=;
        b=oCjnKWSnw0xz3XdYd0AUlrrzmdINHwwUmy5LAVsB5tzVjuacFz7dBVgD8ARiDae1Uu
         b3tHfbI+ODwOE+ua8eQOWJg+KjVFVLx5ebHS6ldiAXX+i2HZvrdft4cVkv/8McyjOQ9J
         3a/lEG5AvYvSaUcKXJ+mn0ylCDkjoJ0PfMIYVJfPjIvj4+hH37cEW/sJcaCoXK+CY4ZI
         /73I8f4Kr9VCVMD46DfqkLzv855mSo0ucs0sNk78EQKQ9HpyByYx9U0yyOfKJIWZ5jcK
         eHIZtKqnYl5jyVcow/euGp/iwowUSRh4tUI5sO+hF1mTLKuma00FEfsZEpb1S9GnnEy/
         eVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738312380; x=1738917180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egqRvUyLfakli10+ggYKvwxMdmYV8I7LQkQH/AIbN90=;
        b=tTHqT5MOWbhPuDyVxlP0I1DP+qRUtdt43D8r9xrSbUKU44DpNwRjhy2O+/gAQChBE1
         tZ3iKwzX62dOtxa9GVjj08JZAIf2LdQCB2d1Xo2J+Y58pG19Hvj5z+HWsrRqmmVllBJY
         11/N1ew5n6/JDifVSZn90v/LYPua1GSPO9euZJiCTMAkOQCix1CIfaKcKEv5a5mRwZMt
         iCypqvVyyPRX4TaOVcNgcKw00DawE1IoDcj7yVHqVgF70kTenVfxqDz6povW1J7FG1HP
         PAK/OCiaE8b7P+jtimDn6Tbpo5iqlaIpZgmCQHLcejPGY6xFsWfWhthnKtVEHUnmGesx
         FycA==
X-Forwarded-Encrypted: i=1; AJvYcCWnMoZU56vjckAtYU8++H17Y+fbUSRE6hyifjGGxrzGKgwQOSmmYSi2XlnU2JvW9p9PHuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhJ+z3/SFJIQvvP4BfNb30ieU4A7MjtKFVfH4uv5L4S19zb68Y
	kwNq22EOJHQ3H3cVDHPQ3VigAOSirYZIiNBq1QulaxrdKspPGxzerdCdqG2YLQ==
X-Gm-Gg: ASbGnctv3YBN7P37YtP3HGsHEZuMHMiwgQ9gsaR3SVw3PsPFRE6g/UcfNcxUunizgOq
	y0VcqRMLuOYGH8V1VRluuka0cCfrUcilxcWBO9PiOJmae5KRINB7/nVQOkLmFyu93rsxBmc4FsX
	yq8n1ZnszOLLQpMPVsvXMgYfDyy4ppz3doZPRUug5da6AKPrrWD3de/b/ul2MUXYYKwbkrX+nXl
	CcBQcfNJ7eZN3ol+W5bpNIsqQNGn6RgjJoPZF/OXdEZJH3vFY86i0nJpoOMAaPgryynLJ6+RfSR
	QMpZovqZitOH0FiTncuPbolpbj+crrn1if1WQ1tquJkf4IsU/dqKO0fXhw==
X-Google-Smtp-Source: AGHT+IFEGaNvReG5vJZPY7iYHQObTDw/0zJqyBDYrLORPticbg6pyTqk9VcPWTbvbKqoh+zEKTKFpg==
X-Received: by 2002:a17:907:7fa6:b0:ab6:b848:2ab with SMTP id a640c23a62f3a-ab6cfcdf2a3mr922586166b.16.1738312380051;
        Fri, 31 Jan 2025 00:33:00 -0800 (PST)
Received: from google.com (201.31.90.34.bc.googleusercontent.com. [34.90.31.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a5635bsm253140566b.164.2025.01.31.00.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 00:32:59 -0800 (PST)
Date: Fri, 31 Jan 2025 08:32:55 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, kernel-team@meta.com,
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk,
	jack@suse.cz, kpsingh@kernel.org, liamwisehart@meta.com,
	shankaran@meta.com
Subject: Re: [PATCH v11 bpf-next 1/7] fs/xattr: bpf: Introduce security.bpf.
 xattr name prefix
Message-ID: <Z5yKtyJN3xLQRUNH@google.com>
References: <20250129205957.2457655-1-song@kernel.org>
 <20250129205957.2457655-2-song@kernel.org>
 <Z5tbH13qK6rLJVUI@google.com>
 <20250130-erklimmen-erstversorgung-93daf77c9dc4@brauner>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130-erklimmen-erstversorgung-93daf77c9dc4@brauner>

On Thu, Jan 30, 2025 at 04:20:04PM +0100, Christian Brauner wrote:
> On Thu, Jan 30, 2025 at 10:57:35AM +0000, Matt Bobrowski wrote:
> > On Wed, Jan 29, 2025 at 12:59:51PM -0800, Song Liu wrote:
> > > Introduct new xattr name prefix security.bpf., and enable reading these
> > > xattrs from bpf kfuncs bpf_get_[file|dentry]_xattr().
> > > 
> > > As we are on it, correct the comments for return value of
> > > bpf_get_[file|dentry]_xattr(), i.e. return length the xattr value on
> > > success.
> > 
> > Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>
> > 
> > > Signed-off-by: Song Liu <song@kernel.org>
> > > Acked-by: Christian Brauner <brauner@kernel.org>
> > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  fs/bpf_fs_kfuncs.c         | 19 ++++++++++++++-----
> > >  include/uapi/linux/xattr.h |  4 ++++
> > >  2 files changed, 18 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> > > index 3fe9f59ef867..8a65184c8c2c 100644
> > > --- a/fs/bpf_fs_kfuncs.c
> > > +++ b/fs/bpf_fs_kfuncs.c
> > > @@ -93,6 +93,11 @@ __bpf_kfunc int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz)
> > >  	return len;
> > >  }
> > >  
> > > +static bool match_security_bpf_prefix(const char *name__str)
> > > +{
> > > +	return !strncmp(name__str, XATTR_NAME_BPF_LSM, XATTR_NAME_BPF_LSM_LEN);
> > > +}
> > 
> > I think this can also just be match_xattr_prefix(const char
> > *name__str, const char *prefix, size_t len) such that we can do the
> > same checks for aribitrary xattr prefixes i.e. XATTR_USER_PREFIX,
> > XATTR_NAME_BPF_LSM.
> > 
> > >  /**
> > >   * bpf_get_dentry_xattr - get xattr of a dentry
> > >   * @dentry: dentry to get xattr from
> > > @@ -101,9 +106,10 @@ __bpf_kfunc int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz)
> > >   *
> > >   * Get xattr *name__str* of *dentry* and store the output in *value_ptr*.
> > >   *
> > > - * For security reasons, only *name__str* with prefix "user." is allowed.
> > > + * For security reasons, only *name__str* with prefix "user." or
> >       	  	   	    	 	     	  ^ prefixes
> > 						  
> > > + * "security.bpf." is allowed.
> >                       ^ are
> > 
> > Out of curiosity, what is the security reasoning here? This isn't
> > obvious to me, and I'd like to understand this better. Is it simply
> > frowned upon to read arbitrary xattr values from the context of a BPF
> > LSM program, or has it got something to do with the backing xattr
> > handler that ends up being called once we step into __vfs_getxattr()
> > and such?  Also, just so that it's clear, I don't have anything
> > against this allow listing approach either, I just genuinely don't
> > understand the security implications.
> 
> I've explained this at lenghts in multiple threads. The gist is various
> xattrs require you to have access to properties that are carried by
> objects you don't have access to (e.g., the mount) or can't guarantee
> that you're in the correct context and interpreting those xattrs without
> this information is either meaningless or actively wrong.

Oh, right, I see. Thank you Christian!

