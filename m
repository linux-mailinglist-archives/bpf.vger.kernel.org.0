Return-Path: <bpf+bounces-76485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB88CB69F9
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 18:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2291630161B7
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 17:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF9F3148C9;
	Thu, 11 Dec 2025 17:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnPsoF/l"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D182C27A10F;
	Thu, 11 Dec 2025 17:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765472882; cv=none; b=SGUQM/c/CL3SHzbxw59sJkAUDy5OzQj+Tlgpr8wEz1Uy4+ib4QsW8BVhcuVeTTQQHvqN1uB/V7SppaKYtQm24TAyyYzVNsaWTf80QEy2064F5NP/NKAlV2JfDT3Qpfs3klRkVjzKQHpzyPf5zbKLUMPK8/3VtEoNBWGFMK5gPbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765472882; c=relaxed/simple;
	bh=ODoGWPUWZsagDjvvXpnPzzmJRzdIn3ErABVVmxALTDI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZY79/a+TZCA5aGRSpEWLexGqZpABEKP5+vIqF3ibcsomjBQ1LZ+PErU8chHb01aqUKGZ67UyoKnA/LH2vLYueibHE34g8bIcAbqKIMrB+bBGelAtcz5MfFhDQf2yFJEvHL8LTj9s6d4jk4G1G3Dm9V2qYrGeu9gG+tJF7h+hs0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnPsoF/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8956CC4CEF7;
	Thu, 11 Dec 2025 17:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765472882;
	bh=ODoGWPUWZsagDjvvXpnPzzmJRzdIn3ErABVVmxALTDI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=XnPsoF/lklKErExgwWiC3G7jIvMBCcjN8ClcGMjpml8Jswu3gdc8G0RLAWV7MvhZ7
	 QW2llGeM72BOwF0IagFmHwj23K+cI0nKEdnunK4dPSYGJVuwJ1HETppR6h42XppqGK
	 kHhrVvCOnKZbtoO36MCGVtVqpG/nUFGxEQOgWnziyWy3HMK/gpWTQGrs0+IjcCqtGm
	 5Fis5cV75MyaBLlQrd93g5yf4LbDelLB5dx0EodxDiAzhqj/Vh1EI1YdVt/o53HJQk
	 HCMmUKrDeL9SnZu5QLWrdofQo2qnzcJ2uUHpec7FEIV/PaNxDATYSZjeIOq3uE+2M0
	 ZBtQJ1dpnyuPw==
Content-Type: multipart/mixed; boundary="===============2248098912615350654=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7a0761227380698b87b3717ba6b98735328917800ff9a4f8148cbce186656dba@mail.kernel.org>
In-Reply-To: <20251211164646.1219122-7-alan.maguire@oracle.com>
References: <20251211164646.1219122-7-alan.maguire@oracle.com>
Subject: Re: [PATCH v7 bpf-next 06/10] btf: support kernel parsing of BTF with kind layout
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,dwarves@vger.kernel.org,bpf@vger.kernel.org,ttreyer@meta.com,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 11 Dec 2025 17:08:00 +0000 (UTC)

--===============2248098912615350654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 0de8fc8a0e0b..d6221d3e7893 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -5215,23 +5216,36 @@ static s32 btf_check_meta(struct btf_verifier_env *env,
>  		return -EINVAL;
>  	}
>
> -	if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX ||
> -	    BTF_INFO_KIND(t->info) == BTF_KIND_UNKN) {
> +	if (!btf_name_offset_valid(env->btf, t->name_off)) {
> +		btf_verifier_log(env, "[%u] Invalid name_offset:%u",
> +				 env->log_type_id, t->name_off);
> +		return -EINVAL;
> +	}
> +
> +	if (BTF_INFO_KIND(t->info) == BTF_KIND_UNKN) {
>  		btf_verifier_log(env, "[%u] Invalid kind:%u",
>  				 env->log_type_id, BTF_INFO_KIND(t->info));
>  		return -EINVAL;
>  	}
>
> -	if (!btf_name_offset_valid(env->btf, t->name_off)) {
> -		btf_verifier_log(env, "[%u] Invalid name_offset:%u",
> -				 env->log_type_id, t->name_off);
> +	if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX && env->btf->kind_layout &&
> +	    (BTF_INFO_KIND(t->info) * sizeof(struct btf_kind_layout)) <
> +	     env->btf->hdr.kind_layout_len) {
                 ^^^^

Is the bounds check correct in btf_check_meta()? The code checks whether
kind_layout[kind] exists by testing if (kind * elem_size < total_len).
This verifies the element starts within the buffer, but to actually read
the full element we need (kind + 1) * elem_size <= total_len.

For example, with kind_layout_len=41 bytes and elem_size=2 bytes:
- Check: kind=20 -> 20 * 2 < 41 -> 40 < 41 -> passes
- But reading kind_layout[20] needs bytes [40, 42) which exceeds the
  41-byte buffer

While both code paths still reject the BTF (just with different error
messages), the check allows kind_layout_len values that aren't proper
multiples of sizeof(struct btf_kind_layout) to be treated as if they
contain complete elements at the boundary.

The validation in btf_parse_kind_layout_sec() requires at least one
complete element (kind_layout_len >= sizeof(struct btf_kind_layout)) but
doesn't enforce that the length is a multiple of the element size, which
could lead to this off-by-one scenario.

> +		btf_verifier_log(env, "[%u] unknown but required kind %u",
> +				 env->log_type_id,
> +				 BTF_INFO_KIND(t->info));
>  		return -EINVAL;
> +	} else {
> +		if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX) {
> +			btf_verifier_log(env, "[%u] Invalid kind:%u",
> +					 env->log_type_id, BTF_INFO_KIND(t->info));
> +			return -EINVAL;
> +		}
> +		var_meta_size = btf_type_ops(t)->check_meta(env, t, meta_left);
> +		if (var_meta_size < 0)
> +			return var_meta_size;
>  	}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20140850025

--===============2248098912615350654==--

