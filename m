Return-Path: <bpf+bounces-67442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9152B43DF4
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 16:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 413267A80A3
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 14:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980CC306487;
	Thu,  4 Sep 2025 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5wFhqeD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD7E3054CA
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756994590; cv=none; b=Gp8xqyqnObtA0ecq9dSCPDUirOro8e1DOcU3rVi2qE5PM0Xi3TqwTAFL98asA0WZHywPUlDrSmPGRkz3GEusmvWLWhSc0bST6ySM3zub0rpoxCNQPEs5TqdO9S5DuutcbdYo9dEaKjHurO/WP5EiIxG5cPsuoMdfKSY7ZWwOhsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756994590; c=relaxed/simple;
	bh=8fwdEDNgQNYG4gphMT8zMdVTIR8Ip6BnO8haoHLvHwo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z6eh6Bx60TU05bFATTOGSfaSHk41jnkA1Qyi173sFUhYMCUEMG75UmGuNslqDQAKbBXAW+8Wrhuz1OYSv91cn97QIN1wA7/GSxabQpKbalncCeWNu1xv8a4k2B5H4XGZKKKafA5xMtbxLGLoR2uyoSpDiJUq+Bd1gGCqSG9tc4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5wFhqeD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7251C4CEF0;
	Thu,  4 Sep 2025 14:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756994590;
	bh=8fwdEDNgQNYG4gphMT8zMdVTIR8Ip6BnO8haoHLvHwo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=B5wFhqeD3Z61ujiS3bjjkdpToOThY2pD8daYNRmw+e+4xTrVTXbRPIZPAB8Jyeq07
	 jabUkNuCoMiVXVTOjw9G9fljI37kUwdhBzQuyS8uKM1Ew8OrNcaBCRRd7OlRcNsmuY
	 Z5UUkPwnB5KOJHOU78vNJcaaMHztyXOu1XPg4zOsB8VTams9Gh01GI+bhni9wHtCfu
	 tY4SYpkRBqEnlXrAvF15n3uOTo7++nESVpqXCW/SCLXU81Ec8LjzS2m+X2HmT+QB7u
	 18KVWGUZdsAkprUynfdmMslxjPfTCHrwc5RG29gkVbJWYA2QDrGl4LOzKDqjdq58z8
	 LFGh/0kUu/eiw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Hengqi Chen <hengqi.chen@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 xukuohai@huaweicloud.com
Cc: bpf@vger.kernel.org, Hengqi Chen <hengqi.chen@gmail.com>
Subject: Re: [PATCH bpf-next] bpf, arm64: Remove duplicated bpf_flush_icache()
In-Reply-To: <20250904075703.49404-1-hengqi.chen@gmail.com>
References: <20250904075703.49404-1-hengqi.chen@gmail.com>
Date: Thu, 04 Sep 2025 14:03:06 +0000
Message-ID: <mb61pwm6eqpr9.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hengqi Chen <hengqi.chen@gmail.com> writes:

> The bpf_flush_icache() is done by bpf_arch_text_copy() already.
> Remove the duplicated one in arch_prepare_bpf_trampoline().
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index a98b8132479a..f0b1cb2c3bc4 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -2773,7 +2773,6 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
>  		goto out;
>  	}
>  
> -	bpf_flush_icache(ro_image, ro_image + size);
>  out:
>  	kvfree(image);
>  	return ret;
> -- 
> 2.43.5

Acked-by: Puranjay Mohan <puranjay@kernel.org>

Thanks,
Puranjay

