Return-Path: <bpf+bounces-60510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22301AD7ADD
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 21:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4883ABA29
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 19:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02452737E7;
	Thu, 12 Jun 2025 19:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyA7FmaM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F1245948;
	Thu, 12 Jun 2025 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749755286; cv=none; b=gEwtUe0GUIxRPxDIdqFImXDumIzG9YOXSlvBBdAk1X/FcwAnsvs//Ry0IjH7lSSXKsgYg7TB0dLL0MW2zdLI1O8ZKZUNsEXSeecXsiWwFlw3eZpACerfks8huUO9bfC30nlpHMQ6weIJHX4UQ0uQGtkOJmElbIsGHGhBGqN05Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749755286; c=relaxed/simple;
	bh=XwRA2/G52VP10pm/zUbYtKCTie/rmiKByPwc14x/Ios=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvWiPDXoIznqrJaS2vWdFT3L+NS+G0tWXONieKFz1rEUtC8hcIOU1AhquHxPExjOXbYrTShmxmbLS5KZWtYYiwvuJQpZN3rO0dRP/ieAyOmt4m4jTUPEUVihFO39ipNjiUHvKX3DQRqBoVViZPDs2plzLWETZ03napYf9dOp9Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyA7FmaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3DBC4CEEA;
	Thu, 12 Jun 2025 19:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749755285;
	bh=XwRA2/G52VP10pm/zUbYtKCTie/rmiKByPwc14x/Ios=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HyA7FmaMfpoB3XaGWCdmLEMJgk5q0k8a7wpBNy1Xs2JgI2KA7jJtQMCE68Bvn5x1T
	 xDf9bS/jL6lHuyubaM12njg9cDJo+fb9uTfbShNFoAD2RoMUoa8IoQewEFbnEwLzwm
	 nMWtRQDTkyrfLt9lReo0ES2LrZRKg3NjI9d7d/h821Fo76UWo+XjFEN+ZBKf6BCl0x
	 CWbRYifE/pz4xKhngPPrgZKSGfSM4Y8MNhMma9uixSVs4L5Sixilb4AcXO03wD6Hpt
	 d40vpA6hSZj6AS8wCM7NnGBHUUERtF6pAiOUorw/Z2Z5RcMhVkpNOQNbOE5QLSDavE
	 NluK7SyvAylnQ==
Date: Thu, 12 Jun 2025 12:07:39 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	bboscaccy@linux.microsoft.com, paul@paul-moore.com,
	kys@microsoft.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org
Subject: Re: [PATCH 01/12] bpf: Implement an internal helper for SHA256
 hashing
Message-ID: <20250612190739.GC1283@sol>
References: <20250606232914.317094-1-kpsingh@kernel.org>
 <20250606232914.317094-2-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606232914.317094-2-kpsingh@kernel.org>

On Sat, Jun 07, 2025 at 01:29:03AM +0200, KP Singh wrote:
> This patch introduces bpf_sha256, an internal helper function
> that wraps the standard kernel crypto API to compute SHA256 digests of
> the program insns and map content
> 
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/bpf.h |  1 +
>  kernel/bpf/core.c   | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 5b25d278409b..d5ae43b36e68 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2086,6 +2086,7 @@ static inline bool map_type_contains_progs(struct bpf_map *map)
>  }
>  
>  bool bpf_prog_map_compatible(struct bpf_map *map, const struct bpf_prog *fp);
> +int bpf_sha256(u8 *data, size_t data_size, u8 *output_digest);
>  int bpf_prog_calc_tag(struct bpf_prog *fp);
>  
>  const struct bpf_func_proto *bpf_get_trace_printk_proto(void);
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index a3e571688421..607d5322ef94 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -17,6 +17,7 @@
>   * Kris Katterjohn - Added many additional checks in bpf_check_classic()
>   */
>  
> +#include <crypto/hash.h>
>  #include <uapi/linux/btf.h>
>  #include <linux/filter.h>
>  #include <linux/skbuff.h>
> @@ -287,6 +288,44 @@ void __bpf_prog_free(struct bpf_prog *fp)
>  	vfree(fp);
>  }
>  
> +int bpf_sha256(u8 *data, size_t data_size, u8 *output_digest)
> +{
> +	struct crypto_shash *tfm;
> +	struct shash_desc *shash_desc;
> +	size_t desc_size;
> +	int ret = 0;
> +
> +	tfm = crypto_alloc_shash("sha256", 0, 0);
> +	if (IS_ERR(tfm))
> +		return PTR_ERR(tfm);
> +
> +
> +	desc_size = crypto_shash_descsize(tfm) + sizeof(*shash_desc);
> +	shash_desc = kmalloc(desc_size, GFP_KERNEL);
> +	if (!shash_desc) {
> +		crypto_free_shash(tfm);
> +		return -ENOMEM;
> +	}
> +
> +	shash_desc->tfm = tfm;
> +	ret = crypto_shash_init(shash_desc);
> +	if (ret)
> +		goto out_free_desc;
> +
> +	ret = crypto_shash_update(shash_desc, data, data_size);
> +	if (ret)
> +		goto out_free_desc;
> +
> +	ret = crypto_shash_final(shash_desc, output_digest);
> +	if (ret)
> +		goto out_free_desc;
> +
> +out_free_desc:
> +	kfree(shash_desc);
> +	crypto_free_shash(tfm);
> +	return ret;
> +}
> +

You're looking for sha256() from <crypto/sha2.h>.  Just use that instead.

You'll just need to select CRYPTO_LIB_SHA256.

- Eric

