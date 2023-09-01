Return-Path: <bpf+bounces-9116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C9F78FECB
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 16:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511CC1C20D20
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 14:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E26CC122;
	Fri,  1 Sep 2023 14:13:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD8AAD41
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 14:13:12 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10151706
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 07:13:08 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9936b3d0286so260124666b.0
        for <bpf@vger.kernel.org>; Fri, 01 Sep 2023 07:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693577587; x=1694182387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ye6ZkPoS1U5amjb0Pm4XQ049E5Qr0Ru1KFNH1whHUaM=;
        b=n8WgfzPOT5h9PXRIN1Kbhjgs/haDvRK+vJe0vHH1XkRQxZ24b/GudgdUvFHIfLXiUe
         7ABveD9sTQJE43YNZccL4tDoTgJ5YnCDGJfyrGD3Wc5JFLEFCyO6lkoWsV4od9j9xuLs
         1eorlRUqECMWaoLOpgTWlzv9alMnN2+AQPUXP7jsOy+fQGxCEACaBW42SFFnJVfhyYaD
         9Dsrk9y4yGX1Ywlpundc/q8Np5bsE/3uFURSHFPgwmE13S9hro1yZM1ZA70b41MQO5dG
         +HAhCnHjcetfjCdfWMJleG4/SywprQQ1ZIBV6swz2NyRjnaig42L4VNoa39nfoMOZbld
         lQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693577587; x=1694182387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ye6ZkPoS1U5amjb0Pm4XQ049E5Qr0Ru1KFNH1whHUaM=;
        b=EBTYyrilupXrRaZp0j6Q3eZFGpAL+JoBQaWIt8bLJKqe18B4/KF41KGvN6NNSa6nj+
         hmE8vM1vUezGLXhRVwqSWvmLh35zdhIAd2+pWsOF51M2YmrUtiF39TWcif83GmEqyF/0
         rqECyEWzHKhxNWVeUI+0t9DeAE/cNi/I2GVk+1mbJesLLVpIJDCoksock/Ajg1+GqIWI
         +SJBX89RZL16nUDJs0tfLrt9aevZafAJRkkEpUj1AuzZFUuHOd05+iKHv78URWaEc/B8
         nJLFyj0+2ede6le1b/S40HEJpedNXJZQIBR29qqaYHzdTGRqmGQ7Ez5pYL7kBOpKvYei
         FYcQ==
X-Gm-Message-State: AOJu0Yw7TuA75JGDYSVsb9HprvDyfhJMTaArDMb2oQVQEWtS8oeaCye/
	I1AhWmS6NmvcY9zDOrP1rYE=
X-Google-Smtp-Source: AGHT+IEeKX1w0UlWZao1ereAs8cek9yVZ9/CyOIxT1roOtKkL0bpeuj3nGICgKkYO7u5XqzASQYSBA==
X-Received: by 2002:a17:907:2c44:b0:9a5:c54f:da1c with SMTP id hf4-20020a1709072c4400b009a5c54fda1cmr1748557ejc.47.1693577587107;
        Fri, 01 Sep 2023 07:13:07 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id l13-20020a170906078d00b009a5f1d15642sm1989940ejc.158.2023.09.01.07.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 07:13:06 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 1 Sep 2023 16:13:04 +0200
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Kui-Feng Lee <kuifeng@fb.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] bpf: Assign bpf_tramp_run_ctx::saved_run_ctx before
 recursion check.
Message-ID: <ZPHxAbQDzZVNyXBL@krava>
References: <20230830080405.251926-1-bigeasy@linutronix.de>
 <20230830080405.251926-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830080405.251926-3-bigeasy@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 30, 2023 at 10:04:05AM +0200, Sebastian Andrzej Siewior wrote:
> __bpf_prog_enter() assigns bpf_tramp_run_ctx::saved_run_ctx before

I guess you meant __bpf_prog_enter_recur right?

> performing the recursion check which means in case of a recursion
> __bpf_prog_exit() uses the previously set
> bpf_tramp_run_ctx::saved_run_ctx value.
> 
> __bpf_prog_enter_sleepable() assigns bpf_tramp_run_ctx::saved_run_ctx

__bpf_prog_enter_sleepable_recur ?

> after the recursion check which means in case of a recursion
> __bpf_prog_exit_sleepable() uses an uninitialized value.
> This does not look right. If I read the entry trampoline code right,
> then bpf_tramp_run_ctx isn't initialized upfront.
> 
> Align __bpf_prog_enter_sleepable() with __bpf_prog_enter() and set

ditto

> bpf_tramp_run_ctx::saved_run_ctx before the recursion check is made.
> Remove the assignment of saved_run_ctx in kern_sys_bpf() since it
> happens a few cycles later.
> 
> Fixes: e384c7b7b46d0 ("bpf, x86: Create bpf_tramp_run_ctx on the caller thread's stack")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

makes sense to me.. I ran selftests and all passed
CI seems to fail due to unrelated issues that are just being fixed

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  kernel/bpf/syscall.c    | 1 -
>  kernel/bpf/trampoline.c | 5 ++---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index c925c270ed8b4..1480b6cf12f06 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5304,7 +5304,6 @@ int kern_sys_bpf(int cmd, union bpf_attr *attr, unsigned int size)
>  		}
>  
>  		run_ctx.bpf_cookie = 0;
> -		run_ctx.saved_run_ctx = NULL;
>  		if (!__bpf_prog_enter_sleepable_recur(prog, &run_ctx)) {
>  			/* recursion detected */
>  			__bpf_prog_exit_sleepable_recur(prog, 0, &run_ctx);
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 78acf28d48732..53ff50cac61ea 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -926,13 +926,12 @@ u64 notrace __bpf_prog_enter_sleepable_recur(struct bpf_prog *prog,
>  	migrate_disable();
>  	might_fault();
>  
> +	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
> +
>  	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
>  		bpf_prog_inc_misses_counter(prog);
>  		return 0;
>  	}
> -
> -	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
> -
>  	return bpf_prog_start_time();
>  }
>  
> -- 
> 2.40.1
> 

