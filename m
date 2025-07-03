Return-Path: <bpf+bounces-62321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BA4AF8076
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 20:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799404A1FA3
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 18:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519372F271A;
	Thu,  3 Jul 2025 18:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ftu3KUDq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82127293B42
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568336; cv=none; b=Oho8nwvidOD0YKGaWehyU/AcQs1Cc9Vqlz8cssRiogqU8lzq8NLCKfakAoQA94elpdUqjHBebYTisQXM6y31Zm/ci/V8Z/64qrQMXhef8UOsJOj74fsKQ3fxwrcs2lVJVtmafGW5qMKOB30y1sJnauPqZjJFfoFL3q2xDibfL2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568336; c=relaxed/simple;
	bh=/Xd1T8wiq9QS2PQrB8TihU9vnBp9oQciJWaaT5AJXMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYsjL2EJwa6ePQ1wzkdJkIkGW/+8GN39pjIwl4/gKyrCXoKUUBI1znZPxYtjDwsVz/A0zD6WrcJhusmE0fehmoEWYKjf/s2PmmReoNEf2l2xZ0ZxYfQLqg0Mdpu1IzvHw0AxQwU+HpMhS9kGXRtq+iH9YSNHyXb6PHnJgKisCQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ftu3KUDq; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bY5061CGMzVXd;
	Thu,  3 Jul 2025 20:29:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1751567382;
	bh=kXS5gqoeMvo9Iem3RQHQuwFAC/FZUccj8O/swd8K6zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ftu3KUDqesHolrP4UGRnQ2kMVc2Bgl+OIjrXZgpC8wphuh4NghJNqFUl+7I3vFYEi
	 jBPaYrbyol6zEF3gIhL5srGNviC+B29weXrFOnj3wnYrRcyiiNnRktoLDTK6cVAALV
	 B91fu/zJ9sgBrXyUbgWiynegCtuiP2sgY0gVqQ/c=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4bY5050gtRzt9F;
	Thu,  3 Jul 2025 20:29:40 +0200 (CEST)
Date: Thu, 3 Jul 2025 20:29:40 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Song Liu <song@kernel.org>, brauner@kernel.org
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, viro@zeniv.linux.org.uk, jack@suse.cz, kpsingh@kernel.org, 
	mattbobrowski@google.com, m@maowtm.org, neil@brown.name, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v5 bpf-next 2/5] landlock: Use path_walk_parent()
Message-ID: <20250703.ogh0eis8Ahxu@digikod.net>
References: <20250617061116.3681325-1-song@kernel.org>
 <20250617061116.3681325-3-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250617061116.3681325-3-song@kernel.org>
X-Infomaniak-Routing: alpha

On Mon, Jun 16, 2025 at 11:11:13PM -0700, Song Liu wrote:
> Use path_walk_parent() to walk a path up to its parent.
> 
> No functional changes intended.

Using this helper actualy fixes the issue highlighted by Al.  Even if it
was reported after the first version of this patch series, the issue
should be explained in the commit message and these tags should be
added:

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Closes: https://lore.kernel.org/r/20250529231018.GP2023217@ZenIV
Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control")

I like this new helper but we should have a clear plan to be able to
call such helper in a RCU read-side critical section before we merge
this series.  We're still waiting for Christian.

I sent a patch to fix the handling of disconnected directories for
Landlock, and it will need to be backported:
https://lore.kernel.org/all/20250701183812.3201231-1-mic@digikod.net/
Unfortunately a rebase would be needed for the path_walk_parent patch,
but I can take it in my tree if everyone is OK.

However, users of path_walk_parent() would still have to properly deal
with such disconnected directories.  The Landlock fix I sent takes a
safe approach by handling disconnected directories such as only their
mount point is actually taken into account for access control decision
(see rationale in the patch series).  I'm wondering if
path_walk_parent() should not help its users avoid the same issue, or at
least force them to make an explicit and informed choice.

> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  security/landlock/fs.c | 30 ++++++++----------------------
>  1 file changed, 8 insertions(+), 22 deletions(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 6fee7c20f64d..e26ab8c34dd4 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -837,8 +837,8 @@ static bool is_access_to_paths_allowed(
>  	 * restriction.
>  	 */
>  	while (true) {
> -		struct dentry *parent_dentry;
>  		const struct landlock_rule *rule;
> +		struct path root = {};
>  
>  		/*
>  		 * If at least all accesses allowed on the destination are
> @@ -895,34 +895,20 @@ static bool is_access_to_paths_allowed(
>  		/* Stops when a rule from each layer grants access. */
>  		if (allowed_parent1 && allowed_parent2)
>  			break;
> -jump_up:
> -		if (walker_path.dentry == walker_path.mnt->mnt_root) {
> -			if (follow_up(&walker_path)) {
> -				/* Ignores hidden mount points. */
> -				goto jump_up;
> -			} else {
> -				/*
> -				 * Stops at the real root.  Denies access
> -				 * because not all layers have granted access.
> -				 */
> -				break;
> -			}
> -		}
> -		if (unlikely(IS_ROOT(walker_path.dentry))) {
> +
> +		if (unlikely(IS_ROOT(walker_path.dentry)) &&
> +		    (walker_path.mnt->mnt_flags & MNT_INTERNAL)) {

This would not fit well with the ongoing Landlock fix because
!MNT_INTERNAL root directories should also be handled specifically, but
only if they are not mount points.

>  			/*
>  			 * Stops at disconnected root directories.  Only allows
>  			 * access to internal filesystems (e.g. nsfs, which is
>  			 * reachable through /proc/<pid>/ns/<namespace>).
>  			 */
> -			if (walker_path.mnt->mnt_flags & MNT_INTERNAL) {
> -				allowed_parent1 = true;
> -				allowed_parent2 = true;
> -			}
> +			allowed_parent1 = true;
> +			allowed_parent2 = true;
>  			break;
>  		}
> -		parent_dentry = dget_parent(walker_path.dentry);
> -		dput(walker_path.dentry);
> -		walker_path.dentry = parent_dentry;
> +		if (path_walk_parent(&walker_path, &root))
> +			break;
>  	}
>  	path_put(&walker_path);
>  
> -- 
> 2.47.1
> 
> 

