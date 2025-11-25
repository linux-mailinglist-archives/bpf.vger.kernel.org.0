Return-Path: <bpf+bounces-75460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A48C8529B
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 14:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F068B3A31AC
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 13:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DF42459CF;
	Tue, 25 Nov 2025 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWT88mll"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6A21EE7DC
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764076937; cv=none; b=auCCbqtdpfW+m8SBH2NTufRcGUheTthYeMc1fzRXHpTOamxD6baHIZvfeLrkWc+nBRy6dE5tY/QC7s7gbpNNY8EWZoyMKuMx4rwlSZ6pKrA09Dqtq28hTyunSFClt9lZUQuINIGCweGCh87UFNpwgG9YSafo3ps4QraVpw96wVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764076937; c=relaxed/simple;
	bh=Yd4AOfleAhUleyUyqG1hHAAF6qI9BB0aSxYsOTC87ps=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=oNZYxG58B5hHQcRj1FpSyM4ZprKLFQWA5p86oVzEvLpZ6UIV+ld3j5fU33EQhNIQV5RKQmRl3vc1eqZMtcA0b9/TkJ0HV05ZAhamJq+8jnLmksLGVf/1ttIU12G8qaErFri54TPyuvQJC8liGc3PcUCbmGIldYg5Qzs4UnnIXvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWT88mll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3CBC116B1;
	Tue, 25 Nov 2025 13:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764076936;
	bh=Yd4AOfleAhUleyUyqG1hHAAF6qI9BB0aSxYsOTC87ps=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=uWT88mllwnId4bEknXJNc/VlhPoigwI+VXcycb6UNBtZCiTFUvzrE/3opdLuSnFZ/
	 2akIwm1iqjFQdZ2mQeb3VoLzQN5/dSSaib2B1MQyTykgxNOkPB855+kampuU6thpok
	 N6Ntpqj4i7l/x2o1WiQe+vpgDtDX2OK9P8Tlx8VkCTHsT48OJ2pL61bKbqAfakXbo5
	 ikmgD6EFLWHMntR1xEgDNKdMlLO4LqHroMDeKb45Vb/1PVZSR+7UPFEoQ2+EgfHEZ2
	 ij9jLBcLw1H3kdUexrn/P02NHekTTjUC+c5pY/piXgwhuIs4aQgPUuD15Q6sqMFnwI
	 h6vWrocVjdmGQ==
Content-Type: multipart/mixed; boundary="===============1367236628527144502=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <35d5864ecbfca2f37ee4f8219575a9c1dc69874fca80d2d2179c8044824ec1f4@mail.kernel.org>
In-Reply-To: <20251125125634.2671-3-dimitar.kanaliev@siteground.com>
References: <20251125125634.2671-3-dimitar.kanaliev@siteground.com>
Subject: Re: [PATCH v1 2/3] bpf: verifier: Simplify register sign extension with tnum_scast
From: bot+bpf-ci@kernel.org
To: dimitar.kanaliev@siteground.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,mykolal@fb.com,shung-hsi.yu@suse.com,dimitar.kanaliev@siteground.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 25 Nov 2025 13:22:15 +0000 (UTC)

--===============1367236628527144502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 766695491..c9a6bf85b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -6876,147 +6876,57 @@ static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
>  	reg_bounds_sync(reg);
>  }
>
> -static void set_sext64_default_val(struct bpf_reg_state *reg, int size)
> -{

[ ... ]

> -}
> -
>  static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
>  {

[ ... ]

>  }
>
> -static void set_sext32_default_val(struct bpf_reg_state *reg, int size)
> -{

[ ... ]

> -}
> -
>  static void coerce_subreg_to_size_sx(struct bpf_reg_state *reg, int size)
>  {
> -	s32 init_s32_max, init_s32_min, s32_max, s32_min, u32_val;
> -	u32 top_smax_value, top_smin_value;
> -	u32 num_bits = size * 8;
> -
> -	if (tnum_is_const(reg->var_off)) {
> -		u32_val = reg->var_off.value;
> -		if (size == 1)
> -			reg->var_off = tnum_const((s8)u32_val);
> -		else
> -			reg->var_off = tnum_const((s16)u32_val);
> +	s32 smin_value, smax_value;
>
> -		u32_val = reg->var_off.value;
> -		reg->s32_min_value = reg->s32_max_value = u32_val;
> -		reg->u32_min_value = reg->u32_max_value = u32_val;
> +	if (size >= 4)
>  		return;
> -	}
>
> -	top_smax_value = ((u32)reg->s32_max_value >> num_bits) << num_bits;
> -	top_smin_value = ((u32)reg->s32_min_value >> num_bits) << num_bits;
> +	reg->var_off = tnum_subreg(tnum_scast(reg->var_off, size));
>
> -	if (top_smax_value != top_smin_value)
> -		goto out;
> +	smin_value = -(1 << (size * 8 - 1));
> +	smax_value = (1 << (size * 8 - 1)) - 1;
>
> -	/* find the s32_min and s32_min after sign extension */
> -	if (size == 1) {
> -		init_s32_max = (s8)reg->s32_max_value;
> -		init_s32_min = (s8)reg->s32_min_value;
> -	} else {
> -		/* size == 2 */
> -		init_s32_max = (s16)reg->s32_max_value;
> -		init_s32_min = (s16)reg->s32_min_value;
> -	}
> -	s32_max = max(init_s32_max, init_s32_min);
> -	s32_min = min(init_s32_max, init_s32_min);
> -
> -	if ((s32_min >= 0) == (s32_max >= 0)) {
> -		reg->s32_min_value = s32_min;
> -		reg->s32_max_value = s32_max;
> -		reg->u32_min_value = (u32)s32_min;
> -		reg->u32_max_value = (u32)s32_max;
> -		reg->var_off = tnum_subreg(tnum_range(s32_min, s32_max));
> -		return;
> -	}
> +	reg->s32_min_value = smin_value;
> +	reg->s32_max_value = smax_value;
>
> -out:
> -	set_sext32_default_val(reg, size);
> +	reg->u32_min_value = 0;
> +	reg->u32_max_value = U32_MAX;
> +
> +	__update_reg32_bounds(reg);
> +
> +	reg->umin_value = reg->u32_min_value;
> +	reg->umax_value = reg->u32_max_value;
> +
> +	reg->smin_value = reg->umin_value;
> +	reg->smax_value = reg->umax_value;
                        ^^^^^^^^
Can reg->smin_value and reg->smax_value be correctly set from unsigned
values here? For sign-extended negative values, the 64-bit unsigned
bounds (umin/umax) will be positive after zero-extension, but the 64-bit
signed bounds (smin/smax) should remain negative.

Consider an 8-bit value -1 (0xFF) that gets sign-extended:
- After sign extension: s32_min_value = s32_max_value = -1 (0xFFFFFFFF)
- After __update_reg32_bounds: u32_min_value = u32_max_value = 0xFFFFFFFF
- After zero-extension to 64-bit: umin_value = umax_value = 0x00000000FFFFFFFF
- Then: smin_value = 0x00000000FFFFFFFF (interpreted as +4294967295)

But the correct 64-bit signed value should be -1 (0xFFFFFFFFFFFFFFFF),
not +4294967295.

The pattern in __reg_assign_32_into_64() at verifier.c:2771-2772 shows
the correct approach for propagating signed 32-bit bounds to 64-bit:

    reg->smin_value = reg->s32_min_value;
    reg->smax_value = reg->s32_max_value;

This uses implicit sign-extension from s32 to s64. Should
coerce_subreg_to_size_sx() follow the same pattern?

>  }
>
>  static bool bpf_map_is_rdonly(const struct bpf_map *map)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19670538430

--===============1367236628527144502==--

