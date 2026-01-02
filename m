Return-Path: <bpf+bounces-77665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 92331CED929
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 01:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 208A030006F1
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 00:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0744B14D29B;
	Fri,  2 Jan 2026 00:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="zIF6Wuhe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B92B3C465
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 00:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767312908; cv=none; b=bnv+9C8w6H9G8IicGSsE/LLlt/TjtWOVIZsWdaNEBwr2kdZOT56SQJtuK/KP6bzxJPlDdLIHfAojcmUu6oAbMFGzv8cndXtU84NV35H1abqtyUY8O7kky5UHArXDOY2SPII/tpKXNB0RavYkMlHUjGKQ6cTlWlhXROJ779lgJzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767312908; c=relaxed/simple;
	bh=r+T7OSUEXnd7gL27CeJ4YmJFi9hbKpWqPqV80KMKCLg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=jyai4nSbSeMBMUZlh2qydHH1D4PHCGAJpmy/C1qHkJDasBfcy87l67WLgM6xKEiw4sxbPjv0fStXfm1c+LLk8ntzksrmPDQveyO1Xtgd93PBu+dYUWFF8yl/dLD6HbBiBcl8ejqYfE/ThGL8JFnBV6douKL2r7LLCJMqHAd9Mbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=zIF6Wuhe; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4f4c89f8cc6so98597031cf.1
        for <bpf@vger.kernel.org>; Thu, 01 Jan 2026 16:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1767312905; x=1767917705; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aVI5EqdRahzuudsEe3u52vwHw5jyHw9TE+dj2mykJE=;
        b=zIF6WuheC3LpGJHXLm9QV25gb9y/fMtNcrIfnGXZC5mvi54AzPHBwwyliHLrcDXs81
         y9a19xxZcaF82pCAIPvbWVKn6nDgs9+V4y6IELE0d30FkFMHij1Rqrd3A584hX8JlY3S
         vH/PI5WRhrpMVphWf8376QxfCu3eWCRU7KJLAEPyk34HZDaxQMgT8t0eJD3WWC+IF5e0
         bjbDBcbx+MugdyHYS+H+nGjNAy3q+BwriehGKlqLiUn/Nk703q1uWAOUpuqo9Y1gcYHo
         pNkFqd+ft7ixVmJEsiGwhN3zGltJiwamRcvZKFKC6aSjz23EfGHQVuMVDoIZ8TaRkklh
         vGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767312905; x=1767917705;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6aVI5EqdRahzuudsEe3u52vwHw5jyHw9TE+dj2mykJE=;
        b=UI6Xw/vJ7tfCP24gIJilzTbujpLQQlxEkuTC/aGsc2Ydv/DqeNYsdDGzB6QBWPnGDk
         XloIdrVVMV7rv/ZHOMn+fvhiipe+dVBsCDFJGhwTsOoPmU0kHP4zRDuHniyVLwEz/kaB
         z9AtqZFGJzocdBieC5ZEbIDgWCeAoKrcS+9Sj1mgapyjeRzU9L+pPtI85mZQnRDUiA7u
         l/cz8uQ0Kpg3tbhz471q7TmNzEceWGOD+OojkdntptkKYDrOfL6xb9wogtG3b17DOHhM
         dhd8mGqIl8NNX6EnU/CNnRi8P4iSs+X2aLVxHyj9dfhG/NlhrHz7B9IyqDOq4Vd1Xlb9
         iQxg==
X-Forwarded-Encrypted: i=1; AJvYcCWnUz8gPoKcyUptFdzGShR9+plBuMfyxlFqiqn5y9+62HTvzQtj4FgyuiVwFvToCXBYubk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMmfs4BLy11rG6kF4hiQzSYyu9db0xJyQ7SGrTtGwdvH78SpRq
	D6R/E+kLMIP150N7q/FH0aH2owDS/3/ppF6HqbNJd2ZgN2VAZAfTvMwIpSSJJxl6c5E=
X-Gm-Gg: AY/fxX5i8NBdaMjV+kyE9hBfFOG30dtkTJF2lFCnXNh0mQIuezNkSAIHz5rU9zaIZtr
	68qmdlC7spMHAMQFVYVwX+iRFVYOGYog9H93DpJ5utyyEpxbawOcS7dNcf++oxJEb99ucb4xPdx
	9705GrYSjzinPayINodYl36SJG/R+ECJgQx0W+UIu7nTjRxW668gUjlmdVFSSu+f2ND1L44Lp/7
	QkzuTh32v8PytiUMuAiDyrFw7Eipd/YvH+O+qy0IDRUkmXudxei9uJdop82WG08XZUYtWrus033
	81vVgel2YIXE0EZHY0avlWhM6ZscI6gNgFI0Nzkq25M2G29qlGOGBsb7HwSM9Y8EFOgW8TH3TGT
	15Yxc4Tp1MyMdwMHot6HVW3Fg1BRdCnYo7rbzjMi0SQ5FOtdscGceaXwnruTs3cYWGtrkmNvkBQ
	CzLs53g9rxrS8=
X-Google-Smtp-Source: AGHT+IG2wONcolQBnWNSudLyJa9qSBkneRo2v5YBl6vAoUSDwIOTQovAH/59mPIfy/543gYUsySdWw==
X-Received: by 2002:a05:622a:2609:b0:4f1:af8d:64c with SMTP id d75a77b69052e-4f4abcf43aemr662640061cf.31.1767312904815;
        Thu, 01 Jan 2026 16:15:04 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d96ddae2csm282600366d6.20.2026.01.01.16.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jan 2026 16:15:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Jan 2026 19:15:03 -0500
Message-Id: <DFDO4ZDORNS8.31JCAC7DL945M@etsalapatis.com>
Subject: Re: [PATCH bpf-next v2 1/9] bpf: Make KF_TRUSTED_ARGS the default
 for all kfuncs
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>
Cc: "Puranjay Mohan" <puranjay12@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Martin KaFai Lau" <martin.lau@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, <kernel-team@meta.com>
X-Mailer: aerc 0.20.1
References: <20251231171118.1174007-1-puranjay@kernel.org>
 <20251231171118.1174007-2-puranjay@kernel.org>
In-Reply-To: <20251231171118.1174007-2-puranjay@kernel.org>

On Wed Dec 31, 2025 at 12:08 PM EST, Puranjay Mohan wrote:
> Change the verifier to make trusted args the default requirement for
> all kfuncs by removing is_kfunc_trusted_args() assuming it be to always
> return true.
>
> This works because:
> 1. Context pointers (xdp_md, __sk_buff, etc.) are handled through their
>    own KF_ARG_PTR_TO_CTX case label and bypass the trusted check
> 2. Struct_ops callback arguments are already marked as PTR_TRUSTED during
>    initialization and pass is_trusted_reg()
> 3. KF_RCU kfuncs are handled separately via is_kfunc_rcu() checks at
>    call sites (always checked with || alongside is_kfunc_trusted_args)
>
> This simple change makes all kfuncs require trusted args by default
> while maintaining correct behavior for all existing special cases.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

For sched-ext in particular, patchset works fine (as expected).

> ---
>  Documentation/bpf/kfuncs.rst | 35 +++++++++++++++++------------------
>  kernel/bpf/verifier.c        | 14 +++-----------
>  2 files changed, 20 insertions(+), 29 deletions(-)
>
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index e38941370b90..22b5a970078c 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -241,25 +241,23 @@ both are orthogonal to each other.
>  The KF_RELEASE flag is used to indicate that the kfunc releases the poin=
ter
>  passed in to it. There can be only one referenced pointer that can be pa=
ssed
>  in. All copies of the pointer being released are invalidated as a result=
 of
> -invoking kfunc with this flag. KF_RELEASE kfuncs automatically receive t=
he
> -protection afforded by the KF_TRUSTED_ARGS flag described below.
> +invoking kfunc with this flag.
> =20
> -2.4.4 KF_TRUSTED_ARGS flag
> ---------------------------
> +2.4.4 KF_TRUSTED_ARGS (default behavior)
> +-----------------------------------------
> =20
> -The KF_TRUSTED_ARGS flag is used for kfuncs taking pointer arguments. It
> -indicates that the all pointer arguments are valid, and that all pointer=
s to
> -BTF objects have been passed in their unmodified form (that is, at a zer=
o
> -offset, and without having been obtained from walking another pointer, w=
ith one
> -exception described below).
> +All kfuncs now require trusted arguments by default. This means that all
> +pointer arguments must be valid, and all pointers to BTF objects must be
> +passed in their unmodified form (at a zero offset, and without having be=
en
> +obtained from walking another pointer, with exceptions described below).
> =20
> -There are two types of pointers to kernel objects which are considered "=
valid":
> +There are two types of pointers to kernel objects which are considered "=
trusted":
> =20
>  1. Pointers which are passed as tracepoint or struct_ops callback argume=
nts.
>  2. Pointers which were returned from a KF_ACQUIRE kfunc.
> =20
>  Pointers to non-BTF objects (e.g. scalar pointers) may also be passed to
> -KF_TRUSTED_ARGS kfuncs, and may have a non-zero offset.
> +kfuncs, and may have a non-zero offset.
> =20
>  The definition of "valid" pointers is subject to change at any time, and=
 has
>  absolutely no ABI stability guarantees.
> @@ -327,13 +325,14 @@ added later.
>  2.4.7 KF_RCU flag
>  -----------------
> =20
> -The KF_RCU flag is a weaker version of KF_TRUSTED_ARGS. The kfuncs marke=
d with
> -KF_RCU expect either PTR_TRUSTED or MEM_RCU arguments. The verifier guar=
antees
> -that the objects are valid and there is no use-after-free. The pointers =
are not
> -NULL, but the object's refcount could have reached zero. The kfuncs need=
 to
> -consider doing refcnt !=3D 0 check, especially when returning a KF_ACQUI=
RE
> -pointer. Note as well that a KF_ACQUIRE kfunc that is KF_RCU should very=
 likely
> -also be KF_RET_NULL.
> +The KF_RCU flag allows kfuncs to opt out of the default trusted args
> +requirement and accept RCU pointers with weaker guarantees. The kfuncs m=
arked
> +with KF_RCU expect either PTR_TRUSTED or MEM_RCU arguments. The verifier
> +guarantees that the objects are valid and there is no use-after-free. Th=
e
> +pointers are not NULL, but the object's refcount could have reached zero=
. The
> +kfuncs need to consider doing refcnt !=3D 0 check, especially when retur=
ning a
> +KF_ACQUIRE pointer. Note as well that a KF_ACQUIRE kfunc that is KF_RCU =
should
> +very likely also be KF_RET_NULL.
> =20
>  2.4.8 KF_RCU_PROTECTED flag
>  ---------------------------
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0baae7828af2..a31eace4a67c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12040,11 +12040,6 @@ static bool is_kfunc_release(struct bpf_kfunc_ca=
ll_arg_meta *meta)
>  	return meta->kfunc_flags & KF_RELEASE;
>  }
> =20
> -static bool is_kfunc_trusted_args(struct bpf_kfunc_call_arg_meta *meta)
> -{
> -	return (meta->kfunc_flags & KF_TRUSTED_ARGS) || is_kfunc_release(meta);
> -}
> -
>  static bool is_kfunc_sleepable(struct bpf_kfunc_call_arg_meta *meta)
>  {
>  	return meta->kfunc_flags & KF_SLEEPABLE;
> @@ -13253,9 +13248,9 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
>  			return -EINVAL;
>  		}
> =20
> -		if ((is_kfunc_trusted_args(meta) || is_kfunc_rcu(meta)) &&
> -		    (register_is_null(reg) || type_may_be_null(reg->type)) &&
> -			!is_kfunc_arg_nullable(meta->btf, &args[i])) {
> +		if ((register_is_null(reg) || type_may_be_null(reg->type)) &&
> +		    !is_kfunc_arg_nullable(meta->btf, &args[i]) &&
> +		    !is_kfunc_arg_optional(meta->btf, &args[i])) {
>  			verbose(env, "Possibly NULL pointer passed to trusted arg%d\n", i);
>  			return -EACCES;
>  		}
> @@ -13320,9 +13315,6 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
>  			fallthrough;
>  		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
>  		case KF_ARG_PTR_TO_BTF_ID:
> -			if (!is_kfunc_trusted_args(meta) && !is_kfunc_rcu(meta))
> -				break;
> -
>  			if (!is_trusted_reg(reg)) {
>  				if (!is_kfunc_rcu(meta)) {
>  					verbose(env, "R%d must be referenced or trusted\n", regno);


