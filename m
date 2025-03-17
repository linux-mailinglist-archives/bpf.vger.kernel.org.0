Return-Path: <bpf+bounces-54179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB558A6486C
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 10:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFFEA188AAC2
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 09:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2986722F155;
	Mon, 17 Mar 2025 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixx0EbL2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE97F22FACE
	for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 09:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742205544; cv=none; b=PeCbbtUVQslH1Ws7cWsfKwHPUGYe52RPfspjWP3hutYAzWxG1qdUl3tn1x1I0IP2i/LfnZi2FdVIOl95YC3jPuKQPwElqrpKoRbQG4a61XVBtPKCGD+R1ha9OvjoUxVTaA2nWe3dCB9GNAvmGiM9cCNGbBRzZ07UUKoOAB90/28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742205544; c=relaxed/simple;
	bh=TYjYZ6duWQEdEQWm/c38bFEvw3rW3V3w1NhWv6sQFB8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXGr6Rkm3TPhRNNYW+853+aagbvigdi6cZMpA9YnkWutPq1SwOMwL7wCa1OKkz0n9oRgG5GfmQ4cW5FTCvmKnp+BmgjVytSqbRd5lWsMcsffAyMkGGGgnKdMG5Ni4R6RvoUt5utXzowfQAfpwDLqmTgbqOYo6xGLhSJ2Dh+rFjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixx0EbL2; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5cd420781so8121090a12.2
        for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 02:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742205541; x=1742810341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w4/z2F9vBJNQcvx8fdIH3GaTI+MVNeoWIgSjM7ZKZiQ=;
        b=ixx0EbL2Ao2KAVAY/hJFZcF5bbphGJsxur2cwV98V3uSBxI5KzUsH6IrwfJSeNxPtU
         QeS5TqBhwPd7d0hU2g7eogxa4I8C64oNg8oMnFce2T/hF/JrYXm4RPedmn/zvrldjkmq
         bvT8WWDOB1zrTC8cUocII/WoeIRk7vKthnaqpvqAjTklp5+38Tq1zqV/ksZQJPlQE5UB
         207vkikxbhYgzGZmdNgszRVzILEf0zZnwuohpTDqyK98LNfGwU33WsjgQDTeaFRJEjbi
         xSqzr7oSi9fRpoorgqbGvJ2NmjY2FFk9QQbdc6ovcsDLFmKCUe7rE4luTz3+VO9bLLvu
         0ygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742205541; x=1742810341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4/z2F9vBJNQcvx8fdIH3GaTI+MVNeoWIgSjM7ZKZiQ=;
        b=dUgHPllXjLhIs0pEKnCwywVyo8Gc5f+FKVMQm8/2PM+AACDDXzjrmFrOeIgxM+Xc+A
         jW/agm1Hp5ktYodteiuKKGoZmb+W6IiUmgoLVftGf6RbO0i5OjVAC+4ssVt2zamTP/7M
         ogzBNsj7WEetxHxAnFRKGY8b2u89CUQdiIY5XqwyFugnWTtMoJiHONOB0pyai6bm4PCf
         enrdAtgLudwEw8YFXZcDSizP1vqwvdEiE0ZuxRq/4dQ7pFEpKIzMqMM+ioUNAuvqOkCa
         OQiYdv4RUZuqlJSO/nCI6K+bvg1mY5G54i3Ax5tAQxWcESvcgujmWKd0qLgmtfoRbm48
         RwGQ==
X-Gm-Message-State: AOJu0Yw3jX8t18k40UMvxp+HkEUjZpmdxjD2+dF+l+w3kXSFYXnFZLJd
	qP0rhQ/s2YZuOscER/mVcITtZAH4V6g7oZdPlaKF5jOxIAV7wU+c
X-Gm-Gg: ASbGncvUOqYJo++4ZBJ5Ya29X3//my7py0UoD/rpLfC+Ajb8qQei7nD+/VaI0KX5jnc
	2eIfLlWKS+6+ivQMzSlxpRg2zN2uuhuvM3ssgHzYPNr/WPp8c88ONT3CoUItNCGYt65T3GVg1TM
	vmAn5s4st1Lizv2XOl9bNbvhj1uRt2KPvHx/2CmQNDZf4yiQrfOkp27mdIGvZwWlzIlbN55LobZ
	KDVx0mdRmwdkkcyAr+E1N5TWe3wiE8elzqpE1XKtUlhBs2o8RRuToLMYrmSvbf7iAvhTHYUt0P4
	H98XWH/eCdQJVwRvZaHfD0TKIqBLSFo=
X-Google-Smtp-Source: AGHT+IG9sd/cC3DxQS9XltPitiHGdfdEHjLi+6/2OIw2PfRNtX86vsiUEdyHxXzNvQAePWbnWD58vg==
X-Received: by 2002:a17:907:7290:b0:ac3:2d47:f6af with SMTP id a640c23a62f3a-ac3301fe762mr1153074966b.20.1742205540830;
        Mon, 17 Mar 2025 02:59:00 -0700 (PDT)
Received: from krava ([173.38.220.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149cf22dsm630891166b.111.2025.03.17.02.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 02:59:00 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 17 Mar 2025 10:58:58 +0100
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	yonghong.song@linux.dev, tj@kernel.org, memxor@gmail.com
Subject: Re: [PATCH] bpf: make perf_event_read_output accessible from BPF
 core when available
Message-ID: <Z9fyYuJgQ-D8q87E@krava>
References: <20250316180103.12386-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250316180103.12386-1-emil@etsalapatis.com>

On Sun, Mar 16, 2025 at 02:01:03PM -0400, Emil Tsalapatis wrote:
> The perf_event_read_event_output helper is currently only available to
> tracing protrams, but is useful for other BPF programs like sched_ext
> schedulers. When the helper is available, provide its bpf_func_proto
> directly from the bpf core.

please add bpf-next to the subject, otherwise lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka


> 
> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> ---
>  include/linux/bpf.h      | 2 ++
>  kernel/bpf/core.c        | 5 +++++
>  kernel/bpf/helpers.c     | 2 ++
>  kernel/trace/bpf_trace.c | 5 +++++
>  4 files changed, 14 insertions(+)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 0d7b70124d81..973a88d9b52b 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2059,6 +2059,8 @@ int bpf_prog_calc_tag(struct bpf_prog *fp);
>  const struct bpf_func_proto *bpf_get_trace_printk_proto(void);
>  const struct bpf_func_proto *bpf_get_trace_vprintk_proto(void);
>  
> +const struct bpf_func_proto *bpf_get_perf_event_read_value_proto(void);
> +
>  typedef unsigned long (*bpf_ctx_copy_t)(void *dst, const void *src,
>  					unsigned long off, unsigned long len);
>  typedef u32 (*bpf_convert_ctx_access_t)(enum bpf_access_type type,
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 62cb9557ad3b..ba6b6118cf50 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2972,6 +2972,11 @@ const struct bpf_func_proto * __weak bpf_get_trace_vprintk_proto(void)
>  	return NULL;
>  }
>  
> +const struct bpf_func_proto * __weak bpf_get_perf_event_read_value_proto(void)
> +{
> +	return NULL;
> +}
> +
>  u64 __weak
>  bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
>  		 void *ctx, u64 ctx_size, bpf_ctx_copy_t ctx_copy)
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 5449756ba102..ddaa41a70676 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2056,6 +2056,8 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		return &bpf_task_pt_regs_proto;
>  	case BPF_FUNC_trace_vprintk:
>  		return bpf_get_trace_vprintk_proto();
> +	case BPF_FUNC_perf_event_read_value:
> +		return bpf_get_perf_event_read_value_proto();
>  	default:
>  		return NULL;
>  	}
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 13bef2462e94..6b07fa7081d9 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -607,6 +607,11 @@ static const struct bpf_func_proto bpf_perf_event_read_value_proto = {
>  	.arg4_type	= ARG_CONST_SIZE,
>  };
>  
> +const struct bpf_func_proto *bpf_get_perf_event_read_value_proto(void)
> +{
> +	return &bpf_perf_event_read_value_proto;
> +}
> +
>  static __always_inline u64
>  __bpf_perf_event_output(struct pt_regs *regs, struct bpf_map *map,
>  			u64 flags, struct perf_raw_record *raw,
> -- 
> 2.47.1
> 
> 

