Return-Path: <bpf+bounces-12227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1DE7C9838
	for <lists+bpf@lfdr.de>; Sun, 15 Oct 2023 09:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C8D1C20983
	for <lists+bpf@lfdr.de>; Sun, 15 Oct 2023 07:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780F41FC2;
	Sun, 15 Oct 2023 07:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVr4sIHi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F7F185F;
	Sun, 15 Oct 2023 07:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097D0C433C8;
	Sun, 15 Oct 2023 07:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697353636;
	bh=qxWfCynebK6DOdDBSW64c3IS/4zZnK0wuGnNQh3BQGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jVr4sIHib34Il3jSogbJ54KpYsXwBg+AZS3/DqY88Ou/6XQq6/NhLXwIKkEyCoi2R
	 eCR3d0DoY7Ko9D3hGUzkfdJwV7ttjCd5LhgF+wSHZquq0VzKvxH1rqwX823WVX48Fn
	 muEMqXTe4FqcJMtl8t3vhpRiVXAtUKiZ42hfxCk3QbIBYeNXVLkcqj0PQhQ51DL5mO
	 9/3+ctecxTm7uGk8jVlJRLe4jCQCJui9xDRNrAsdGpyZFPrdt4a4SxMPjusgszZNE4
	 v1iTXihZ3BarJCew+BBi1GoT9RZWhLBnkggZVtMlNVhpohdpeYFg+JAzrxfSaziVdi
	 vll00NyZyB2zg==
Date: Sun, 15 Oct 2023 00:07:14 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	kernel-team@meta.com, tytso@mit.edu, roberto.sassu@huaweicloud.com
Subject: Re: [PATCH bpf-next 2/5] bpf, fsverity: Add kfunc
 bpf_get_fsverity_digest
Message-ID: <20231015070714.GF10525@sol.localdomain>
References: <20231013182644.2346458-1-song@kernel.org>
 <20231013182644.2346458-3-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013182644.2346458-3-song@kernel.org>

On Fri, Oct 13, 2023 at 11:26:41AM -0700, Song Liu wrote:
> The kfunc can be used to read fsverity_digest, so that we can verify
> signature in BPF LSM.
> 
> This kfunc is added to fs/verity/measure.c because some data structure used
> in the function is private to fsverity (fs/verity/fsverity_private.h).
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  fs/verity/measure.c | 66 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/fs/verity/measure.c b/fs/verity/measure.c
> index eec5956141da..2d4b2e6f5a5d 100644
> --- a/fs/verity/measure.c
> +++ b/fs/verity/measure.c
> @@ -8,6 +8,8 @@
>  #include "fsverity_private.h"
>  
>  #include <linux/uaccess.h>
> +#include <linux/bpf.h>
> +#include <linux/btf.h>
>  
>  /**
>   * fsverity_ioctl_measure() - get a verity file's digest
> @@ -100,3 +102,67 @@ int fsverity_get_digest(struct inode *inode,
>  	return hash_alg->digest_size;
>  }
>  EXPORT_SYMBOL_GPL(fsverity_get_digest);
> +
> +/* bpf kfuncs */
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +		  "kfuncs which will be used in BPF programs");
> +
> +/**
> + * bpf_get_fsverity_digest: read fsverity digest of file
> + * @file: file to get digest from
> + * @digest_ptr: (out) dynptr for struct fsverity_digest
> + *
> + * Read fsverity_digest of *file* into *digest_ptr*.
> + *
> + * Return: 0 on success, a negative value on error.
> + */
> +__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct bpf_dynptr_kern *digest_ptr)
> +{
> +	const struct inode *inode = file_inode(file);
> +	struct fsverity_digest *arg = digest_ptr->data;

What alignment is guaranteed here?

> +	const struct fsverity_info *vi;
> +	const struct fsverity_hash_alg *hash_alg;
> +	int out_digest_sz;
> +
> +	if (__bpf_dynptr_size(digest_ptr) < sizeof(struct fsverity_digest))
> +		return -EINVAL;
> +
> +	vi = fsverity_get_info(inode);
> +	if (!vi)
> +		return -ENODATA; /* not a verity file */
> +
> +	hash_alg = vi->tree_params.hash_alg;
> +
> +	arg->digest_algorithm = hash_alg - fsverity_hash_algs;
> +	arg->digest_size = hash_alg->digest_size;
> +
> +	out_digest_sz = __bpf_dynptr_size(digest_ptr) - sizeof(struct fsverity_digest);
> +
> +	/* copy digest */
> +	memcpy(arg->digest, vi->file_digest,  min_t(int, hash_alg->digest_size, out_digest_sz));
> +
> +	/* fill the extra buffer with zeros */
> +	memset(arg->digest + arg->digest_size, 0, out_digest_sz - hash_alg->digest_size);

Can't 'out_digest_sz - hash_alg->digest_size' underflow?

> +
> +	return 0;
> +}
> +
> +__diag_pop();
> +
> +BTF_SET8_START(fsverity_set)
> +BTF_ID_FLAGS(func, bpf_get_fsverity_digest, KF_SLEEPABLE)

Should it be sleepable?  Nothing in it sleeps, as far as I can tell.

> +BTF_SET8_END(fsverity_set)
> +
> +const struct btf_kfunc_id_set bpf_fsverity_set = {
> +	.owner = THIS_MODULE,
> +	.set = &fsverity_set,
> +};

static const?

> +
> +static int __init bpf_fsverity_init(void)
> +{
> +	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
> +					 &bpf_fsverity_set);
> +}
> +
> +late_initcall(bpf_fsverity_init);

Maybe this should be called by the existing fsverity_init() initcall instead of
having a brand new initcall just for this.

Also, doesn't this all need to be guarded by a kconfig such as CONFIG_BPF?

Also, it looks like I'm being signed up to maintain this.  This isn't a stable
UAPI, right?  No need to document this in Documentation/?

- Eric

