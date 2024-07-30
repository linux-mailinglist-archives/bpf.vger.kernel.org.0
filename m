Return-Path: <bpf+bounces-36078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D61942058
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 21:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06F41F24DB5
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 19:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049E518C920;
	Tue, 30 Jul 2024 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="cskqiIVA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88BA18A6BC
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 19:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722366630; cv=none; b=c5Zo0s9Tn7Jd/4OJxRHfiKThl3slBNlngfNfH/rLW0dSd/cBxBDFcARgg8RE6Xcj2Xg3rWcsBe5xJP84SBzekA1VU8n7JeCGfKNhgaolKSQK9W/N8oikqhrwPKGyfnYU88KPPoSndXve4UHFucf767C+UVE8+5HhIck07pWknUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722366630; c=relaxed/simple;
	bh=cprG9uguQ5xQAd65VG0OmI1dSJ/AIFZZf/rzJXIqOG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2jEEnNa2OozsIiDbZCc3Y1I9RW5I7xjhN73vyf2Oipx6q4ceycqKEYRhjeu1shSCJhdWMOI+BC/tx45hfj0GODYb0K1nXJ3SFW9F/jpLVDp4Z3rwBpqN0Glj9xhoAYmHt0ecOsBtvauuGHC9DNtpv+LFj+4a/+RtApnUO3PZIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=cskqiIVA; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-65f9e25fffaso37377767b3.3
        for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 12:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722366627; x=1722971427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6GUnz9l9Hov01YwHIE/X99jR0yCQ8jWPdAfQd5kTxAs=;
        b=cskqiIVAToN8u5ifsNa0Ulq7laX0u7m8tS/Wl+D6PimGeNtq+U5Z0/BwHUtu4/JtCb
         aW1LvkVXUqvQeVwsETU8Fo3LKdiWzlzXJx/mEumEGJduxRJIsXyiVENDoBZDHQb3cKx2
         gNNvvVey/3/LdT17UM5DEqAyHhnzvdGno5iy1GaVFnRZF0CxCFpHAzsTI+wZcyhvEiJN
         CrI+T4hxjE3hUA/dYsEmDhOS4O6DsihpgpKyqG8CDvqbTxMMWONvy75dv1yZOr9kj8ZY
         oE0asvQyZ/OBGG321K2Bz18mjufhZpGO35gOC5Rgsvju5PhA+VxPOMcF5vGGK6SMk4ta
         gnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722366627; x=1722971427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GUnz9l9Hov01YwHIE/X99jR0yCQ8jWPdAfQd5kTxAs=;
        b=B7l2g4xx6z71i9U0QSB4tHSCJ9QtazAHZ+G0EcIdC8tCxLEGiMwFY+mi8yTuuBEQFl
         VvtL47NZFswUZMdcKlFDjhKo3FmfRzYxWoH10ywfGlznVhx++JQzYduib4XNJaOF8aj/
         8xzOlZRWaMoDpU1o0KZn6EMWu23/K38Do2oA5wm9/GJNiWQPVckpZdFZ2X+fEQndgIiQ
         +gib7Wf7Olfr0a8E8YLcHS9u3Z6blaAZuPJmB7d4TzZqUJXevuDfR8lSS+2VCFP+iEM6
         5kwp6KLgq05tWUtYx2G4IeXvK3KknFzhdbp20QPBHU9bnkWfOYxDJ3gIEEyZxsM5v7yf
         ukAg==
X-Forwarded-Encrypted: i=1; AJvYcCUZe2ecAtDJ7fxbgY58uSH5xtY6RrtFDoVO9Uwh6KeYAnnKpEiXQVTm4J4mTH7vZBglv0iyyGd56MAwhi3gVajK0lJ1
X-Gm-Message-State: AOJu0YyFbhDIeEScdY8NJ8Akce9+IBCuZtssvWI6Pq8vOtqwrf1FrHxW
	7s+SiMQs0BGhiFf8aoFteeKO5ON1KE1BaaJtQkyzi5VZIOqe53iBi+mqUzWvALM=
X-Google-Smtp-Source: AGHT+IFlD3BEKMaeWaD720WWKRAG4+pH3jrjmCrAEylXJ2sjoD6Kq8sCVxrr8pWB9p2fWNe43d139w==
X-Received: by 2002:a0d:dac6:0:b0:618:95a3:70b9 with SMTP id 00721157ae682-67a09592d49mr116965087b3.36.1722366626922;
        Tue, 30 Jul 2024 12:10:26 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756c44ceb7sm26204097b3.140.2024.07.30.12.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 12:10:26 -0700 (PDT)
Date: Tue, 30 Jul 2024 15:10:25 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org,
	brauner@kernel.org, cgroups@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 08/39] experimental: convert fs/overlayfs/file.c to
 CLASS(...)
Message-ID: <20240730191025.GB3830393@perftesting>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-8-viro@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-8-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:15:54AM -0400, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> There are four places where we end up adding an extra scope
> covering just the range from constructor to destructor;
> not sure if that's the best way to handle that.
> 
> The functions in question are ovl_write_iter(), ovl_splice_write(),
> ovl_fadvise() and ovl_copyfile().
> 
> This is very likely *NOT* the final form of that thing - it
> needs to be discussed.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/overlayfs/file.c | 72 ++++++++++++++++++---------------------------
>  1 file changed, 29 insertions(+), 43 deletions(-)
> 
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 4b9e145bc7b8..a2911c632137 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -132,6 +132,8 @@ static struct fderr ovl_real_fdget(const struct file *file)
>  	return ovl_real_fdget_meta(file, false);
>  }
>  
> +DEFINE_CLASS(fd_real, struct fderr, fdput(_T), ovl_real_fdget(file), struct file *file)
> +
>  static int ovl_open(struct inode *inode, struct file *file)
>  {
>  	struct dentry *dentry = file_dentry(file);
> @@ -174,7 +176,6 @@ static int ovl_release(struct inode *inode, struct file *file)
>  static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
>  {
>  	struct inode *inode = file_inode(file);
> -	struct fderr real;
>  	const struct cred *old_cred;
>  	loff_t ret;
>  
> @@ -190,7 +191,7 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
>  			return vfs_setpos(file, 0, 0);
>  	}
>  
> -	real = ovl_real_fdget(file);
> +	CLASS(fd_real, real)(file);
>  	if (fd_empty(real))
>  		return fd_error(real);
>  
> @@ -211,8 +212,6 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
>  	file->f_pos = fd_file(real)->f_pos;
>  	ovl_inode_unlock(inode);
>  
> -	fdput(real);
> -
>  	return ret;
>  }
>  
> @@ -253,8 +252,6 @@ static void ovl_file_accessed(struct file *file)
>  static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  {
>  	struct file *file = iocb->ki_filp;
> -	struct fderr real;
> -	ssize_t ret;
>  	struct backing_file_ctx ctx = {
>  		.cred = ovl_creds(file_inode(file)->i_sb),
>  		.user_file = file,
> @@ -264,22 +261,18 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	if (!iov_iter_count(iter))
>  		return 0;
>  
> -	real = ovl_real_fdget(file);
> +	CLASS(fd_real, real)(file);
>  	if (fd_empty(real))
>  		return fd_error(real);
>  
> -	ret = backing_file_read_iter(fd_file(real), iter, iocb, iocb->ki_flags,
> -				     &ctx);
> -	fdput(real);
> -
> -	return ret;
> +	return backing_file_read_iter(fd_file(real), iter, iocb, iocb->ki_flags,
> +				      &ctx);
>  }
>  
>  static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
>  {
>  	struct file *file = iocb->ki_filp;
>  	struct inode *inode = file_inode(file);
> -	struct fderr real;
>  	ssize_t ret;
>  	int ifl = iocb->ki_flags;
>  	struct backing_file_ctx ctx = {
> @@ -295,7 +288,9 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	/* Update mode */
>  	ovl_copyattr(inode);
>  
> -	real = ovl_real_fdget(file);
> +	{

Is this what we want to do from a code cleanliness standpoint?  This feels
pretty ugly to me, I feal like it would be better to have something like

scoped_class(fd_real, real) {
	// code
}

rather than the {} at the same indent level as the underlying block.

I don't feel super strongly about this, but I do feel like we need to either
explicitly say "this is the way/an acceptable way to do this" from a code
formatting standpoint, or we need to come up with a cleaner way of representing
the scoped area.  Thanks,

Josef

