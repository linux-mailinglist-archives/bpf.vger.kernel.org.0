Return-Path: <bpf+bounces-13186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35397D5E8A
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 01:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68FDA281C07
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 23:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5EE41E3B;
	Tue, 24 Oct 2023 23:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjVSkAbh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC653D3B9;
	Tue, 24 Oct 2023 23:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD95FC433C7;
	Tue, 24 Oct 2023 23:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698188619;
	bh=UflsIYby5OVu0+2C1AD6UA+4keuELFavjbAhfphMyVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kjVSkAbhBfB65qGX6RC5uky3yvKbCMXCsFZPu/Bchhke8vNtvl6oakDdDLlWi1kao
	 6GJnfwkGQ9V18MKhCpbzzbr5oFmQQzsEEfZh85L111Rz8VKxk1hNVMA5Or6BrYwzTF
	 j+ugfqRfjqPzFKMQwV6AlkTKaaXWF3/oa/Bi46nOpIRidBwgQw5zHLYRPNgdjUBqaM
	 GmVK9z0mSInJM+u49f6ijpr5/wsjuR++cuZDKKm1oAIPJC8aiXvTe7iR4sp0TOWvII
	 wBRGtkYEwPttm5YfWf0IxAi1Je+k7aA0OKhDzkQCyef1ZAxtWRweGlFTdsctHpDjam
	 jzVbPhpbybC+g==
Date: Tue, 24 Oct 2023 16:03:37 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	kernel-team@meta.com, tytso@mit.edu, roberto.sassu@huaweicloud.com
Subject: Re: [PATCH v5 bpf-next 5/9] bpf, fsverity: Add kfunc
 bpf_get_fsverity_digest
Message-ID: <20231024230337.GA2320@sol.localdomain>
References: <20231024063056.1008702-1-song@kernel.org>
 <20231024063056.1008702-6-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024063056.1008702-6-song@kernel.org>

On Mon, Oct 23, 2023 at 11:30:52PM -0700, Song Liu wrote:
> fsverity provides fast and reliable hash of files, namely fsverity_digest.
> The digest can be used by security solutions to verify file contents.
> 
> Add new kfunc bpf_get_fsverity_digest() so that we can access fsverity from
> BPF LSM programs. This kfunc is added to fs/verity/measure.c because some
> data structure used in the function is private to fsverity
> (fs/verity/fsverity_private.h).
> 
> To avoid recursion, bpf_get_fsverity_digest is only allowed in BPF LSM
> programs.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  fs/verity/fsverity_private.h | 10 +++++
>  fs/verity/init.c             |  1 +
>  fs/verity/measure.c          | 85 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 96 insertions(+)
> 
> diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
> index d071a6e32581..f7124f89ab6f 100644
> --- a/fs/verity/fsverity_private.h
> +++ b/fs/verity/fsverity_private.h
> @@ -145,4 +145,14 @@ static inline void fsverity_init_signature(void)
>  
>  void __init fsverity_init_workqueue(void);
>  
> +/* measure.c */
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +int __init fsverity_init_bpf(void);
> +#else
> +static inline int fsverity_init_bpf(void)
> +{
> +}
> +#endif

This does not compile when !CONFIG_BPF_SYSCALL.

fsverity_init_bpf() probably shouldn't have a return value, given that this code
cannot be compiled as a loadable module.  You can either panic on error, or
ignore the error.  I don't think there are any other options.

Also, please keep the sections of this file in alphabetical order.  The
measure.c section should go between init.c and open.c sections.


> diff --git a/fs/verity/measure.c b/fs/verity/measure.c
> index eec5956141da..4b0617ea0499 100644
> --- a/fs/verity/measure.c
> +++ b/fs/verity/measure.c
> @@ -8,6 +8,8 @@
>  #include "fsverity_private.h"
>  
>  #include <linux/uaccess.h>
> +#include <linux/bpf.h>
> +#include <linux/btf.h>

Keep includes in alphabetical order, please.

- Eric

