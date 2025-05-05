Return-Path: <bpf+bounces-57333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AE9AA900F
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 11:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711FE3AB77E
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 09:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708DB1FDA6A;
	Mon,  5 May 2025 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cvzRzO5V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2811FBE83
	for <bpf@vger.kernel.org>; Mon,  5 May 2025 09:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746438567; cv=none; b=kKUKojXA3hf3vcBtVLJmmm1k/t/xdsjV7nzXdjCtyS/iAXZ9/hB0SdryTpNxgWsfSqgNoWN8Vzeo0hW8WepmZsuF6bKueiWsOGU6jq/aXWnVKWBCGzdyljS9nQyrrWaBPqJgZ94wDjH0lQ/A34n8zIp8VA/Fsk0q2UULLdc1/9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746438567; c=relaxed/simple;
	bh=gvzkYTs5rtpmqTb8VcPZ2BZt4c/wz+av7Ml2LLrsOrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuQXFlLAJhNK03vPJqszulyUq295ahRbZz7BZwt7e6ukwCFA/1Tb27paBNYX2Gl3T4puWw3GqAClF70GAgb1z37DoM0EI9se+jyZXuCz8qfTn/vOo2k03/96s7S25q6rM1/2nuBWojI33wu5XuTm/P8kPX3xxy50V4V8AZBlO/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cvzRzO5V; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so462711666b.0
        for <bpf@vger.kernel.org>; Mon, 05 May 2025 02:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746438563; x=1747043363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1BnBvCblRkYEN9Ha75Czu/UHxSFQXfVj92v2hVXdBmw=;
        b=cvzRzO5VSdzYYdu8zwdQc5dPP6cTQ1lEMaSiaO6qdXVWS1vFQyL9eDw6UqSPkpQc7m
         +KVIb95ry0t+iYcjGVzONhlgBoqVi8zXejSnJQxvnT/ucsnAxzc2zeFmh6bx7w/TxyLT
         pSdTJRdsfAz5XdnmHVcppVa4ZlZJmdu81RoVZ1SJFFGaq45p8cLIJMc7zV1Zge7Bd19R
         yCACTwN12kXdhgaNpzTXEFW9HV+XcqnrAUo27YLBMr0CT+7qqQI0bGxHx4YS6+TKulL2
         ansZLDCY4ZlFE+ZyHBve2RELwQiQL2PuMPsq4/eV0dMeeHexBOmlK6WnQIWdk0kCQpRD
         iGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746438563; x=1747043363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BnBvCblRkYEN9Ha75Czu/UHxSFQXfVj92v2hVXdBmw=;
        b=Z7h5C/XIuDsTWTaYxY1461zITcLLGQ0sUkhjDug4a8RByfCmk+yl8xV3rvyCDI1ylU
         yF/NjbF0ZyEsyCcHYP1iJbIHtBLcPGnlstwJejRJWeTqJJ0k+WTAYKSJ0fvuBJ8v/e4X
         TnYCe8ZzaPj4MNBpPqWVfHi9imn9m5Y6M1TmpkAf4CmMoHdP/eNiZ7eu3LLU96Mx8HIA
         qrkPcSKWakkN2TMuqaAUMTGgEOTjLw9/qIRZWdfTQ5kzNJMjKS/xcsQM1CUDvTRDSSV5
         v7E0qP/0ga/MkKUDx+uxL12ThZ0ALkfZQnf85Pn0a2Gdftoprf0+jhQRFODwP5W7HyXs
         xr8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVe84iefavBj0JADgFwWdxIADF+yeeXqiZFLMgRsWqXtKUvKeVWyYNEcv02ItZDkhJK47s=@vger.kernel.org
X-Gm-Message-State: AOJu0YylBbPner2vzcuMkDH9v9NQaMOp77pj0G51IzGoViXSrWffOJWX
	0lhhjmGfuIHGxP/FZTBocuLlDzS4eBf7yfJAHeEY3ZYO/d1MCkfqwAiLpkoTng==
X-Gm-Gg: ASbGncudVloPn89F9RSqEuVBNt+C/7Xw2eBqXqjQgHJH4g4cWSMsBa229Tkltf4ncd3
	W+x/kKkaFqBk7ULNsIjORquWcYq4vnA9gf/LfyscIFn5vqojfKznXKO7/0fKibLspmdvr2HpZEq
	Ga5Na+uR/nL8Yp6w4y1Yq5aTjysG8WISBSN5p5YsgdKAVX0SEQRDs92CFTlM0KHlsz3ZGrcRtHE
	KXKYvHyiHKpA8ayA7Lr0e/xELG4GbhXix0eOXNh4iuDvwuoLErXhrcqf+ZpP6gERHQUET85XbwH
	0iB6hVwPQvC21fkzFftwgb3R/A6Vjea2lDAwQcI2r1MBbaXymckhiV6OcmmHCZcQNQSsgEhTLbG
	XYPK5GvrbbSYvMU2Ohg==
X-Google-Smtp-Source: AGHT+IFYGMgq5KfTLL8HI20N+F541w/zDb+X8QB3oV7HJE3GRuklU1l2cXFO8FZH21KvDjj0U5xzlg==
X-Received: by 2002:a17:907:9411:b0:ace:c50a:f87 with SMTP id a640c23a62f3a-ad1a4b040f5mr560069966b.46.1746438563048;
        Mon, 05 May 2025 02:49:23 -0700 (PDT)
Received: from google.com (201.31.90.34.bc.googleusercontent.com. [34.90.31.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad18950ace4sm463710566b.153.2025.05.05.02.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 02:49:22 -0700 (PDT)
Date: Mon, 5 May 2025 09:49:17 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: add bpf_msleep_interruptible()
Message-ID: <aBiJnR5MEL5hVXXC@google.com>
References: <20250505063918.3320164-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505063918.3320164-1-senozhatsky@chromium.org>

On Mon, May 05, 2025 at 03:38:59PM +0900, Sergey Senozhatsky wrote:
> bpf_msleep_interruptible() puts a calling context into an
> interruptible sleep.  This function is expected to be used
> for testing only (perhaps in conjunction with fault-injection)
> to simulate various execution delays or timeouts.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  include/linux/bpf.h            |  1 +
>  include/uapi/linux/bpf.h       |  9 +++++++++
>  kernel/bpf/helpers.c           | 13 +++++++++++++
>  kernel/trace/bpf_trace.c       |  2 ++
>  tools/include/uapi/linux/bpf.h |  9 +++++++++
>  5 files changed, 34 insertions(+)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3f0cc89c0622..85bd1daaa7df 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3392,6 +3392,7 @@ extern const struct bpf_func_proto bpf_get_retval_proto;
>  extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
>  extern const struct bpf_func_proto bpf_cgrp_storage_get_proto;
>  extern const struct bpf_func_proto bpf_cgrp_storage_delete_proto;
> +extern const struct bpf_func_proto bpf_msleep_interruptible_proto;
>  
>  const struct bpf_func_proto *tracing_prog_func_proto(
>    enum bpf_func_id func_id, const struct bpf_prog *prog);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 71d5ac83cf5d..cbbb6d70a7a3 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5814,6 +5814,14 @@ union bpf_attr {
>   *		0 on success.
>   *
>   *		**-ENOENT** if the bpf_local_storage cannot be found.
> + *
> + * long bpf_msleep_interruptible(long timeout)
> + *	Description
> + *		Make the current task sleep until *timeout* milliseconds have
> + *		elapsed or until a signal is received.
> + *
> + *	Return
> + *		The remaining time of the sleep duration in milliseconds.
>   */
>  #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
>  	FN(unspec, 0, ##ctx)				\
> @@ -6028,6 +6036,7 @@ union bpf_attr {
>  	FN(user_ringbuf_drain, 209, ##ctx)		\
>  	FN(cgrp_storage_get, 210, ##ctx)		\
>  	FN(cgrp_storage_delete, 211, ##ctx)		\
> +	FN(msleep_interruptible, 212, ##ctx)		\
>  	/* This helper list is effectively frozen. If you are trying to	\
>  	 * add a new helper, you should add a kfunc instead which has	\
>  	 * less stability guarantees. See Documentation/bpf/kfuncs.rst	\

I noticed that you've written the newly proposed BPF helper in the
legacy BPF helper form, which I believe is now discouraged, as also
stated within the above comment. You probably want to respin this
patch series having written this newly proposed BPF helper in BPF
kfuncs [0] form instead.

Additionally, as part of your patch series I think you'll also want to
include some selftests.

[0] https://docs.kernel.org/bpf/kfuncs.html

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index e3a2662f4e33..0a3449c282f2 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1905,6 +1905,19 @@ static const struct bpf_func_proto bpf_dynptr_data_proto = {
>  	.arg3_type	= ARG_CONST_ALLOC_SIZE_OR_ZERO,
>  };
>  
> +BPF_CALL_1(bpf_msleep_interruptible, long, timeout)
> +{
> +	return msleep_interruptible(timeout);
> +}
> +
> +const struct bpf_func_proto bpf_msleep_interruptible_proto = {
> +	.func		= bpf_msleep_interruptible,
> +	.gpl_only	= false,
> +	.might_sleep	= true,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type	= ARG_ANYTHING,
> +};
> +
>  const struct bpf_func_proto bpf_get_current_task_proto __weak;
>  const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
>  const struct bpf_func_proto bpf_probe_read_user_proto __weak;
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 52c432a44aeb..8a0b96aed0c0 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1475,6 +1475,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		return &bpf_get_branch_snapshot_proto;
>  	case BPF_FUNC_find_vma:
>  		return &bpf_find_vma_proto;
> +	case BPF_FUNC_msleep_interruptible:
> +		return &bpf_msleep_interruptible_proto;
>  	default:
>  		break;
>  	}
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 71d5ac83cf5d..cbbb6d70a7a3 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -5814,6 +5814,14 @@ union bpf_attr {
>   *		0 on success.
>   *
>   *		**-ENOENT** if the bpf_local_storage cannot be found.
> + *
> + * long bpf_msleep_interruptible(long timeout)
> + *	Description
> + *		Make the current task sleep until *timeout* milliseconds have
> + *		elapsed or until a signal is received.
> + *
> + *	Return
> + *		The remaining time of the sleep duration in milliseconds.
>   */
>  #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
>  	FN(unspec, 0, ##ctx)				\
> @@ -6028,6 +6036,7 @@ union bpf_attr {
>  	FN(user_ringbuf_drain, 209, ##ctx)		\
>  	FN(cgrp_storage_get, 210, ##ctx)		\
>  	FN(cgrp_storage_delete, 211, ##ctx)		\
> +	FN(msleep_interruptible, 212, ##ctx)		\
>  	/* This helper list is effectively frozen. If you are trying to	\
>  	 * add a new helper, you should add a kfunc instead which has	\
>  	 * less stability guarantees. See Documentation/bpf/kfuncs.rst	\
> -- 
> 2.49.0.906.g1f30a19c02-goog
> 

