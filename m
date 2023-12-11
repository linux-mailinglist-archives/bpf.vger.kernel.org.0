Return-Path: <bpf+bounces-17394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 267F780C9CA
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 13:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55B01F217A0
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 12:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902BB3B2B7;
	Mon, 11 Dec 2023 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DS0NQpvf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061AEDF
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 04:30:29 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3333074512bso2837385f8f.1
        for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 04:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702297827; x=1702902627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RRCMYK+/Bhjt8nlJGO02P/XmLptibZwCl1CrdIbpCUc=;
        b=DS0NQpvfsJmR6LIYuFPqJIXSAio7hmyv75IJiA+TJTxXlbNfGSp4y2zAwJxAlrXPuu
         5oAHbJ1jp5w8gI8mG08x1Tm/DTx+yni+qS6AqCipJtvKhkGb6yv2aZgzcZlc4SQPPl4f
         NwigXLqSb3I+YsBQjq0AxXeC6DlsfOQiT+vc4pdBvdF3fJGtUmuyDlPupqLOSbsUhcVq
         ubZtF/aJ3oe455D9VfEh/uA2QRFX0v/GIuDkcLgtGUlNcsxJs+CyVz2O8tm0WQh4WLdT
         g0vz+lD9CiCJ9CWY6zBNkVFvq9y2ydZpPWyjkB1HUsvIIhYM24weztnNr/v0Gb3PRSOp
         3o3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702297827; x=1702902627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRCMYK+/Bhjt8nlJGO02P/XmLptibZwCl1CrdIbpCUc=;
        b=dErmKsfuHss7kqMCevN0xp/toepOxLrDOkCEO1D8bIdjWy2rFhuPLlVUCldumkWYPn
         b+ZpNO+qxpsSss+HsFJMW6U/1OcokYyH1XI8k1j+MjHxBC+IrJQ2EJjBPesvMirG9l9M
         mX4lb+gCRsx2LMJgEv3pDF/9gWddU9Q05bAz2TpYV/C9NL4s6JQ6Owo0QYcch+KIOnzy
         /i9ZPNFUAmpfnEIrODJo5jPinXc/O+Vgg/jbdjW+9E87KGUK5uC+UBbGgDgzq7yQobSY
         5rj0fWtA8XPDI+8uFZbrmkR0ZyaZbYc7p3RU9j2cgYz5jRM4SMwgdz30BA7cDLWm97Xx
         pdQQ==
X-Gm-Message-State: AOJu0YzMhMB+zcBtwbt0AWrOljY0iQlEwwgNXgkp+hG8t7IMfgdtaS+f
	zeLzmjg0RwhEid4i60ot8WVofXPX94o=
X-Google-Smtp-Source: AGHT+IHGK2vCDjBanh4z3RE3BiwPj9anGzQPJlWFbW9SjxJLr1y27C2MGJigIBnsYe97+e55jhIQ1Q==
X-Received: by 2002:a05:600c:4e0c:b0:40c:3dac:817f with SMTP id b12-20020a05600c4e0c00b0040c3dac817fmr1585997wmq.73.1702297826973;
        Mon, 11 Dec 2023 04:30:26 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c500a00b004094e565e71sm12846011wmr.23.2023.12.11.04.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 04:30:26 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 11 Dec 2023 13:30:24 +0100
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, dan.carpenter@linaro.org,
	olsajiri@gmail.com, asavkov@redhat.com
Subject: Re: [PATCH bpf-next v7 1/4] bpf: Relax tracing prog recursive attach
 rules
Message-ID: <ZXcA4KxoaDagJPjc@krava>
References: <20231208185557.8477-1-9erthalion6@gmail.com>
 <20231208185557.8477-2-9erthalion6@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208185557.8477-2-9erthalion6@gmail.com>

On Fri, Dec 08, 2023 at 07:55:53PM +0100, Dmitrii Dolgov wrote:

SNIP

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index eb447b0a9423..e7393674ab94 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1414,6 +1414,7 @@ struct bpf_prog_aux {
>  	bool dev_bound; /* Program is bound to the netdev. */
>  	bool offload_requested; /* Program is bound and offloaded to the netdev. */
>  	bool attach_btf_trace; /* true if attaching to BTF-enabled raw tp */
> +	bool attach_tracing_prog; /* true if tracing another tracing program */
>  	bool func_proto_unreliable;
>  	bool sleepable;
>  	bool tail_call_reachable;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 5e43ddd1b83f..d5470a5c8c6d 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3039,6 +3039,7 @@ static void bpf_tracing_link_release(struct bpf_link *link)
>  
>  	bpf_trampoline_put(tr_link->trampoline);
>  
> +	link->prog->aux->attach_tracing_prog = false;

I think it'd be better to have this as part of the 'if (tr_link->tgt_prog)'
path below, because it's set only for that case

>  	/* tgt_prog is NULL if target is a kernel function */
>  	if (tr_link->tgt_prog)
>  		bpf_prog_put(tr_link->tgt_prog);
> @@ -3243,6 +3244,12 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>  		goto out_unlock;
>  	}
>  
> +	/* Bookkeeping for managing the prog attachment chain */
> +	if (tgt_prog &&
> +		prog->type == BPF_PROG_TYPE_TRACING &&
> +		tgt_prog->type == BPF_PROG_TYPE_TRACING)
> +		prog->aux->attach_tracing_prog = true;

wrong indentation in here, please check the if conditions around

thanks,
jirka

> +
>  	link->tgt_prog = tgt_prog;
>  	link->trampoline = tr;
>  
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8e7b6072e3f4..f8c15ce8fd05 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20077,6 +20077,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  			    struct bpf_attach_target_info *tgt_info)
>  {
>  	bool prog_extension = prog->type == BPF_PROG_TYPE_EXT;
> +	bool prog_tracing = prog->type == BPF_PROG_TYPE_TRACING;
>  	const char prefix[] = "btf_trace_";
>  	int ret = 0, subprog = -1, i;
>  	const struct btf_type *t;
> @@ -20147,10 +20148,21 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  			bpf_log(log, "Can attach to only JITed progs\n");
>  			return -EINVAL;
>  		}
> -		if (tgt_prog->type == prog->type) {
> -			/* Cannot fentry/fexit another fentry/fexit program.
> -			 * Cannot attach program extension to another extension.
> -			 * It's ok to attach fentry/fexit to extension program.
> +		if (prog_tracing) {
> +			if (aux->attach_tracing_prog) {
> +				/*
> +				 * Target program is an fentry/fexit which is already attached
> +				 * to another tracing program. More levels of nesting
> +				 * attachment are not allowed.
> +				 */
> +				bpf_log(log, "Cannot nest tracing program attach more than once\n");
> +				return -EINVAL;
> +			}
> +		} else if (tgt_prog->type == prog->type) {
> +			/*
> +			 * To avoid potential call chain cycles, prevent attaching of a
> +			 * program extension to another extension. It's ok to attach
> +			 * fentry/fexit to extension program.
>  			 */
>  			bpf_log(log, "Cannot recursively attach\n");
>  			return -EINVAL;
> @@ -20163,16 +20175,15 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  			 * except fentry/fexit. The reason is the following.
>  			 * The fentry/fexit programs are used for performance
>  			 * analysis, stats and can be attached to any program
> -			 * type except themselves. When extension program is
> -			 * replacing XDP function it is necessary to allow
> -			 * performance analysis of all functions. Both original
> -			 * XDP program and its program extension. Hence
> -			 * attaching fentry/fexit to BPF_PROG_TYPE_EXT is
> -			 * allowed. If extending of fentry/fexit was allowed it
> -			 * would be possible to create long call chain
> -			 * fentry->extension->fentry->extension beyond
> -			 * reasonable stack size. Hence extending fentry is not
> -			 * allowed.
> +			 * type. When extension program is replacing XDP function
> +			 * it is necessary to allow performance analysis of all
> +			 * functions. Both original XDP program and its program
> +			 * extension. Hence attaching fentry/fexit to
> +			 * BPF_PROG_TYPE_EXT is allowed. If extending of
> +			 * fentry/fexit was allowed it would be possible to create
> +			 * long call chain fentry->extension->fentry->extension
> +			 * beyond reasonable stack size. Hence extending fentry
> +			 * is not allowed.
>  			 */
>  			bpf_log(log, "Cannot extend fentry/fexit\n");
>  			return -EINVAL;
> -- 
> 2.41.0
> 

