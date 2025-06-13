Return-Path: <bpf+bounces-60584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2439FAD8403
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 09:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1AA16953B
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 07:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23102C3262;
	Fri, 13 Jun 2025 07:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ceGxDqcU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882671D90A5
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 07:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749799449; cv=none; b=fDe6D/B7p4a8TTRwxOId/cpwh0DMNpTg9FSAhEyvUlu62+fhxZi7sESvq32QQFttAe9OsunvARNJogp1f0utoN5wjZ7IJzTWkwSzuTPl8DoJF8dgy5B0/uIbhNQuIG2vsP98aw22T5fQQZJDHoWGWPVoWBoMFB3s61e6niYDrmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749799449; c=relaxed/simple;
	bh=Ps9VT8d+yn71/IuIwXfpi0x7b4jT4m+bmEHXowTMwus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ucw1BgnCsZ0Oe/r6gq7vPsG+HMHjkdqm+fVZi2UehB2/iPDswKrWCtobZuKSdV59fzp08k4BRJao4F5umo2i/9lk7XP/4d45jCo/F2sspi/OCzUovns34pC5zxSfDWE2zgQOGM8Xy49OMhy6WOp3wGjcbVDrOckrhIQ6GzmIKSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ceGxDqcU; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-adb2e9fd208so355994166b.3
        for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 00:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749799446; x=1750404246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2oSTi7mi8e44HurXR8h5oczd9yxuz9DcTvQTS7aP+qI=;
        b=ceGxDqcU6vNMYPpjztO+TS2KxDk8Qyv5undL9zjJA8hplTygEXly3FSEQnQNMtDJM6
         UYXKiZF+FjkJOjsmVbPG3vxBL2B8VDLGnjCZrOeuBvQ076YxbsUZZF5tkk+Q60u+1gyC
         6nTCkh8r6JEs1lmhR+gZUfQ0FwYxHnLicp1UJXXph3iPA8r4dUfW/waOUXWLwMHsrozY
         z3haczsADpZaT/0p2Grvc3xFzHptBTJzo9FCHKEgmLZ1eevXskTguHFJKsMn4HAd2aIL
         ikaRmymnETiPka/SqjDC6hm9tVLDtbIm+7/hSZ2Jz2xtNRxw8LOsZHzacy4uWAMNR2eX
         coZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749799446; x=1750404246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oSTi7mi8e44HurXR8h5oczd9yxuz9DcTvQTS7aP+qI=;
        b=TAXEZNMOP4auyL6BoBKxThKbuD1hxJqIh7u8Ga7lC+iOsDH414uwRrbeozKGc1k11C
         UxSHu0AmBdMHqCafCdCsfRqbTNn+uyzyAd7N7GLHVpmP0hbX3JngfxHRoErzH+N69p10
         JO/c0ZrdraZ1zyb0Km5+yYRdBPXWZcyzC5Cq2Tr2CoxCrdbLYeLfZUm9gHajcVxFrsQM
         IGnNfRKuBdClNXSBDa2Lsu+a3h6oYdMrTgsi5k0BMUZwrSe32+ih17UdPmLOspcQJAmY
         OCnyEJDjneEJqW8185epsMlFxaz+PfTEuUtk02LGgDsnuWo4E+mZXqvgDy/PeKGjaeCk
         jjAQ==
X-Gm-Message-State: AOJu0YyWUH9F2LJyGDmSH/ibgwH13Qr9WLq/yy/tPti+tCOyyOaM95gk
	o5vqNq6Sz1O6VOXRHcR/1nDUrxS984FLB2Un7NSxUFt855bs/QwJ2qmWv7CzmXDpPQ==
X-Gm-Gg: ASbGncv7rdAECWxAjV8i1UnDLlDhrTFZ1v5JsCt1wXDAl0L92SKc4VqrzBvDQVdHVyU
	9WSHHWAee9OnIkjm+46VPeHzMN62pYoNVbOZtTIExbAJksK3y+8QCMHBuOJheRZQklAPX/0ZmtD
	r65R0H/wO3aMVb3oFmyPrGFISwW4u//VAjdnFFOunSx6nvRhezw0A0VMxeRT1OKv+eF6Y5ye3lF
	DYemNuI/GUttUjDTAY+f23kT1tiUtaLgTEoDtJUL+cA5Ah7/yqaEKqszhUPpTX3MdSktNXowhuk
	3ISBOIoqSb3SxDphDWPUKOSWeg5bxusinzN/l1XgNpgxRINVhsJEe7409/eQO+bt2Xdb7kNMdyR
	5yGLv+rNtzlZ/ebb9SAjAiHhcxg==
X-Google-Smtp-Source: AGHT+IGFZSrWQZH0T1iikDYv5+RWby8SI7hNOZO3MSky0Nzi/guK5x2Mz0mx7B89HVTYbx3waydHOg==
X-Received: by 2002:a17:907:7f29:b0:ade:6e9:8ad4 with SMTP id a640c23a62f3a-adec5d216c1mr190885166b.33.1749799445649;
        Fri, 13 Jun 2025 00:24:05 -0700 (PDT)
Received: from google.com (57.35.34.34.bc.googleusercontent.com. [34.34.35.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88fee60sm82282666b.85.2025.06.13.00.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 00:24:04 -0700 (PDT)
Date: Fri, 13 Jun 2025 07:24:00 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	eddyz87@gmail.com, kpsingh@kernel.org
Subject: Re: [PATCH bpf-next] bpf: Mark dentry->d_inode as trusted_or_null
Message-ID: <aEvSEKFtK3skVWj6@google.com>
References: <20250613052857.1992233-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613052857.1992233-1-song@kernel.org>

On Thu, Jun 12, 2025 at 10:28:56PM -0700, Song Liu wrote:
> LSM hooks such as security_path_mknod() and security_inode_rename() have
> access to newly allocated negative dentry, which has NULL d_inode.
> Therefore, it is necessary to do the NULL pointer check for d_inode.
> 
> Also add selftests that checks the verifier enforces the NULL pointer
> check.

Thank you for correcting this. Looks OK to me.

Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>

> Signed-off-by: Song Liu <song@kernel.org>
>
> ---
>  kernel/bpf/verifier.c                          |  5 ++---
>  .../selftests/bpf/progs/verifier_vfs_accept.c  | 18 ++++++++++++++++++
>  .../selftests/bpf/progs/verifier_vfs_reject.c  | 15 +++++++++++++++
>  3 files changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 14dd836acb13..5c7775cf1259 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7104,8 +7104,7 @@ BTF_TYPE_SAFE_TRUSTED(struct file) {
>  	struct inode *f_inode;
>  };
>  
> -BTF_TYPE_SAFE_TRUSTED(struct dentry) {
> -	/* no negative dentry-s in places where bpf can see it */
> +BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry) {
>  	struct inode *d_inode;
>  };
>  
> @@ -7143,7 +7142,6 @@ static bool type_is_trusted(struct bpf_verifier_env *env,
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct bpf_iter__task));
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct linux_binprm));
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct file));
> -	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct dentry));
>  
>  	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id, "__safe_trusted");
>  }
> @@ -7153,6 +7151,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
>  				    const char *field_name, u32 btf_id)
>  {
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
> +	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
>  
>  	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
>  					  "__safe_trusted_or_null");
> diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
> index a7c0a553aa50..3e2d76ee8050 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
> @@ -2,6 +2,7 @@
>  /* Copyright (c) 2024 Google LLC. */
>  
>  #include <vmlinux.h>
> +#include <errno.h>
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>  
> @@ -82,4 +83,21 @@ int BPF_PROG(path_d_path_from_file_argument, struct file *file)
>  	return 0;
>  }
>  
> +SEC("lsm.s/inode_rename")
> +__success
> +int BPF_PROG(inode_rename, struct inode *old_dir, struct dentry *old_dentry,
> +	     struct inode *new_dir, struct dentry *new_dentry,
> +	     unsigned int flags)
> +{
> +	struct inode *inode = new_dentry->d_inode;
> +	ino_t ino;
> +
> +	if (!inode)
> +		return 0;
> +	ino = inode->i_ino;
> +	if (ino == 0)
> +		return -EACCES;
> +	return 0;
> +}
> +
>  char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
> index d6d3f4fcb24c..4b392c6c8fc4 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
> @@ -2,6 +2,7 @@
>  /* Copyright (c) 2024 Google LLC. */
>  
>  #include <vmlinux.h>
> +#include <errno.h>
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>  #include <linux/limits.h>
> @@ -158,4 +159,18 @@ int BPF_PROG(path_d_path_kfunc_non_lsm, struct path *path, struct file *f)
>  	return 0;
>  }
>  
> +SEC("lsm.s/inode_rename")
> +__failure __msg("invalid mem access 'trusted_ptr_or_null_'")
> +int BPF_PROG(inode_rename, struct inode *old_dir, struct dentry *old_dentry,
> +	     struct inode *new_dir, struct dentry *new_dentry,
> +	     unsigned int flags)
> +{
> +	struct inode *inode = new_dentry->d_inode;
> +	ino_t ino;
> +
> +	ino = inode->i_ino;
> +	if (ino == 0)
> +		return -EACCES;
> +	return 0;
> +}
>  char _license[] SEC("license") = "GPL";
> -- 
> 2.47.1
> 

