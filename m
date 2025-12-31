Return-Path: <bpf+bounces-77616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E2FCEC642
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 18:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 449183004CE3
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 17:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290A32222C5;
	Wed, 31 Dec 2025 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+1Udh28"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52062773F4
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767202622; cv=none; b=QyMVf3LJSWP42TCNAgN26cUDpBhwzc7Wsh0XAx02U9R9qjAQjm6zkx0hITa7W4vr4/sci/5XvCuNVTFwNsew1gUtej965WHTkaRHVqYrr3FXuihP3ZQt8rDAbISeZJo5bznxO3YLQwTAp604x3FmUA8UlfUTYbLW4m1Ck0NL1HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767202622; c=relaxed/simple;
	bh=Q6mz/AYlmxHG93FH1z0esaRZ0e1ZNvvGBFoEIm/SG0o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CZJQLAEJUwPWvasFB/HOqPPqwlBAmILXuw8MfQIGlYJ+cCFqPNRUQ9lRGiR42+ZBKGfDfmit3Wn/vwp9hcyuUgI6RQz4CBFJ8dMllXFLLa406sCn2LHXjLxOeaLbBlwTwNpZ0QxrJIDNnkn06QuHBX9RAQvcz4W6KfTtGirv9gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+1Udh28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F179AC116D0;
	Wed, 31 Dec 2025 17:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767202622;
	bh=Q6mz/AYlmxHG93FH1z0esaRZ0e1ZNvvGBFoEIm/SG0o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=S+1Udh28F4jP9++rBD/10AQPTv6bKaL2S7WSZkNZLOyX9vdnpDZFj+TuwH1zD3Nd+
	 KeeLSIOyvupPEGK/fpOVd7uQKo2IjVh66nhVOhGUCXUGobfLZmkyq++QdZl1azifnp
	 c7FCxVbvJef3i7Zsa0mTwIhfsNhVfKyG7HU8v6VUK77/Tm9vAXtZysX7Xcx4QZ9Lp8
	 mrk1czmbrFMwFM3abA6d7x4UdCyvMAkRR6TF50MUofiYW+hgT9XpxY6o9D5Zjx2TPN
	 ZTGpMpGMSd2/kOVAvXgY04txSw6sAuULhNnoFGnATQ4tVNtfmYS2jXpK7yZEVsFSTT
	 +Ajbjl/M1TYIw==
Content-Type: multipart/mixed; boundary="===============5104216385160100441=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f6e020fa57cd251f33c83b4e934dc6297f12f38ef239ac8ccdf6b6a92056e612@mail.kernel.org>
In-Reply-To: <20251231171118.1174007-2-puranjay@kernel.org>
References: <20251231171118.1174007-2-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v2 1/9] bpf: Make KF_TRUSTED_ARGS the default for all kfuncs
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 31 Dec 2025 17:37:01 +0000 (UTC)

--===============5104216385160100441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3d44c5d06623..359a962d69a1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -13253,9 +13248,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
> 			return -EINVAL;
> 		}
>
> -		if ((is_kfunc_trusted_args(meta) || is_kfunc_rcu(meta)) &&
> -		    (register_is_null(reg) || type_may_be_null(reg->type)) &&
> -			!is_kfunc_arg_nullable(meta->btf, &args[i])) {
> +		if ((register_is_null(reg) || type_may_be_null(reg->type)) &&
> +		    !is_kfunc_arg_nullable(meta->btf, &args[i]) &&
> +		    !is_kfunc_arg_optional(meta->btf, &args[i])) {
> 			verbose(env, "Possibly NULL pointer passed to trusted arg%d\n", i);
> 			return -EACCES;
> 		}

The NULL check guard (is_kfunc_trusted_args || is_kfunc_rcu) is removed here,
making the check unconditional for all kfuncs. This means kfuncs that
previously accepted NULL pointers without KF_TRUSTED_ARGS will now reject
NULL at verification time.

Several netfilter kfuncs are affected: bpf_xdp_ct_lookup(), bpf_skb_ct_lookup(),
bpf_xdp_ct_alloc(), and bpf_skb_ct_alloc() all accept NULL for their bpf_tuple
and opts parameters internally (checked in __bpf_nf_ct_lookup), but after this
change the verifier rejects NULL before the kfunc is even called.

I see this is addressed in the series by commit 4ca5896ad640 ("bpf: net:
netfilter: Mark kfuncs accurately") which adds the __nullable suffix to
these parameters.

> @@ -13320,9 +13315,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
> 			fallthrough;
> 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
> 		case KF_ARG_PTR_TO_BTF_ID:
> -			if (!is_kfunc_trusted_args(meta) && !is_kfunc_rcu(meta))
> -				break;
> -
> 			if (!is_trusted_reg(reg)) {
> 				if (!is_kfunc_rcu(meta)) {
> 					verbose(env, "R%d must be referenced or trusted\n", regno);

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20623776553

--===============5104216385160100441==--

