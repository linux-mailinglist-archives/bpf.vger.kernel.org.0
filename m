Return-Path: <bpf+bounces-10095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B667A1005
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D55E1C210A4
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 21:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21AC273C2;
	Thu, 14 Sep 2023 21:49:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A53B10A0C
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 21:49:11 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A109B270B
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 14:49:10 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a64619d8fbso195458066b.0
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 14:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694728149; x=1695332949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yywFNfkxTANxC6bAdNsmDQ/EQAjE0DKcXK52CjAEWfw=;
        b=BtDQS/wu1LgMU0YD4/g9U88Ww9Y7nIZ4ZEysH34ubTsXFkvMPUYaOaFMQxgd/xHyhT
         Lr/FbnztRzkaov3OkZxl/t/XgPHw7SGFUvT0B3kT2+rhbM0K4fPXBERKreETPzhrfPKr
         yXC/MbGSX5pfxmZyT0NEK/SZJxDwZdEWS4D/UX3ATmuhW8oaH94HdKpPzRxxjlQwG8pQ
         U+qhlvpXSzS6HmP6vGuJxJ6VSzwvwm8lQfAc8EJ1MPMGNgdzvzvMpBiX/M5t1C1Ud+t+
         a+QNQL1Iuk03Bw7CyJtbBu0PQHVk11SoEiHZhEM54iiQHoTN3uiiL+vyIUUvtvHkZ4Ku
         4FEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694728149; x=1695332949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yywFNfkxTANxC6bAdNsmDQ/EQAjE0DKcXK52CjAEWfw=;
        b=ejgexVdpbLWn9OoYRzTjQJ3ntFnz5RlSjuAztHnNTH0vTTkLGA2idcJn6pul1w74wm
         Q/ho+Lj46lXz+1JrLmmTVHSQvgJkUdewcuPHFl87rgHSB0ns0rJL/JUcEIc6m/dWoHFA
         HdUevEzuZUQZ/KsmeDnAyfWI5bgBFqd+gr2U41/Y8a4t9DdEpjuhDubzLOW129E8QTwG
         lwqb4rQvmOYl6NRwYA/24gJ7PtCLh1tLtiTxUGt13qm5sfDkmPcrsa8JxDkrNukH4/W3
         +/7fjD7sVSSmvQBUlKmxkNEUdou7KffECSxDltHkbRqxVjjR0rS3M6tLqNdqr+/1eQTe
         Jbsg==
X-Gm-Message-State: AOJu0YzZYMnGsj4b0qQPFkeKHougPKDRARkZYT2FXAeTs09iWwc1iN0e
	VFluIrH48U4P4sCaO9VhkRE=
X-Google-Smtp-Source: AGHT+IFNgy0445LR2WwRikJer/g4uGsAxKYPQNR0/zokjxT6VQ+f6xmV9bBdKPe+3JD8k8FhbyB+8Q==
X-Received: by 2002:a17:907:77c3:b0:9ad:a86b:2337 with SMTP id kz3-20020a17090777c300b009ada86b2337mr4784600ejc.23.1694728148706;
        Thu, 14 Sep 2023 14:49:08 -0700 (PDT)
Received: from krava ([83.240.62.189])
        by smtp.gmail.com with ESMTPSA id kg11-20020a17090776eb00b009a1a653770bsm1552713ejc.87.2023.09.14.14.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 14:49:08 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 14 Sep 2023 23:49:04 +0200
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, toke@redhat.com, sdf@google.com,
	lkp@intel.com, dan.carpenter@linaro.org,
	maciej.fijalkowski@intel.com, hengqi.chen@gmail.com,
	kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf] bpf: Fix tr dereferencing
Message-ID: <ZQN/0IpgAX2gF5gx@krava>
References: <20230914145126.40202-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914145126.40202-1-hffilwlqm@gmail.com>

On Thu, Sep 14, 2023 at 10:51:26PM +0800, Leon Hwang wrote:
> Fix 'tr' dereferencing bug when CONFIG_BPF_JIT is turned off.
> 
> Like 'bpf_trampoline_get_progs()', return 'ERR_PTR()' and then check by
> 'IS_ERR()'. As a result, when CONFIG_BPF_JIT is turned off, it's able to
> handle the case that 'bpf_trampoline_get()' returns
> 'ERR_PTR(-EOPNOTSUPP)'.
> 
> Fixes: 4a1e7c0c63e0 ("bpf: Support attaching freplace programs to multiple attach points")
> Fixes: f7b12b6fea00 ("bpf: verifier: refactor check_attach_btf_id()")
> Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202309131936.5Nc8eUD0-lkp@intel.com/
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>

it does not apply cleanly on bpf/master for me, but nice catch

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  kernel/bpf/syscall.c    | 4 ++--
>  kernel/bpf/trampoline.c | 6 +++---
>  kernel/bpf/verifier.c   | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6a692f3bea150..5748d01c99854 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3211,8 +3211,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>  		}
>  
>  		tr = bpf_trampoline_get(key, &tgt_info);
> -		if (!tr) {
> -			err = -ENOMEM;
> +		if (IS_ERR(tr)) {
> +			err = PTR_ERR(tr);
>  			goto out_unlock;
>  		}
>  	} else {
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index e97aeda3a86b5..1952614778433 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -697,8 +697,8 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
>  
>  	bpf_lsm_find_cgroup_shim(prog, &bpf_func);
>  	tr = bpf_trampoline_get(key, &tgt_info);
> -	if (!tr)
> -		return  -ENOMEM;
> +	if (IS_ERR(tr))
> +		return PTR_ERR(tr);
>  
>  	mutex_lock(&tr->mutex);
>  
> @@ -775,7 +775,7 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
>  
>  	tr = bpf_trampoline_lookup(key);
>  	if (!tr)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  
>  	mutex_lock(&tr->mutex);
>  	if (tr->func.addr)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 18e673c0ac159..054063ead0e54 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19771,8 +19771,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
>  
>  	key = bpf_trampoline_compute_key(tgt_prog, prog->aux->attach_btf, btf_id);
>  	tr = bpf_trampoline_get(key, &tgt_info);
> -	if (!tr)
> -		return -ENOMEM;
> +	if (IS_ERR(tr))
> +		return PTR_ERR(tr);
>  
>  	if (tgt_prog && tgt_prog->aux->tail_call_reachable)
>  		tr->flags = BPF_TRAMP_F_TAIL_CALL_CTX;
> 
> base-commit: cbb1dbcd99b0ae74c45c4c83c6d213c12c31785c
> -- 
> 2.41.0
> 
> 

