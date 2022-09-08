Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FB75B2572
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 20:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiIHSPy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 14:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiIHSPx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 14:15:53 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B026F979E0
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 11:15:51 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 92-20020a17090a09e500b001d917022847so8164461pjo.1
        for <bpf@vger.kernel.org>; Thu, 08 Sep 2022 11:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=8GlmI1JcG6ngJpOfGNzGmoIkPMCbcnikWV5w5TgqHbw=;
        b=JnWkPNyKsabEya8Fw8WfBdE6XYkfVfu34zD82qZxQelapGoN8wDOOOu+uv+E4RQ4xI
         XN8W3pWl5xo88XMBBJsdWQOYiekad++Ghuqoc5Vpm2HbohrLuUSFUljygFwTW2fLfj+L
         0J6y7vutknuidicHJgVu09+uSniF88m2pxhhCpmzWppTTQSvEg6c9TW6slLaEFKDnfcP
         3LpP4zVJFkgvxbBapBmAj9c087dqGCPp1ElwQtrDStDupdPbvqMu4rivJtoP4cy0W0t7
         BlRgzO89TH8PDkezlq/KIEG5R3hutCMl/I+/m9DOjkzQ/WNcqsD/vHqMuos8XKpNAHRq
         /8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=8GlmI1JcG6ngJpOfGNzGmoIkPMCbcnikWV5w5TgqHbw=;
        b=iG6g1tL+FPInkt/1B821X7w/GZ+UTZOT1YfBevkFuCaIWGRXhMVq3wBbmU2LGJB2w2
         i2gCIgbVkla9fYRYSORioKnj6xSRwku3N7Ff1IQ8PxJ3mTYXNPdeAZF13QAho6fCSanM
         sXHy6AyfUFjvhcU+xpNfi7xRhsGc/npwS+uC1vxPa6OhPOiBog+SKjMPpoPJyG+he7qC
         he+hIiVQCmQbCpD3glA0HwcnJt3UC8slb0lCRm8SQD5lM08JDo3ZCgKq+d/CnZGvKxXE
         BN28pfY2aoagXTQheLSstCSVLkJb6w7jeGe3Yq8uJvZOrnPLiOucC/0VBYc+ug02x4Vd
         MDuA==
X-Gm-Message-State: ACgBeo1SWjyrmV412geHRoHjOAznj79pKUuCfDAqEAKgQNkYAbul4TTZ
        Cyi2Kg4kSUUTTHKMaXIGHqXnK5s=
X-Google-Smtp-Source: AA6agR5Hye3v3g3vQNGv2sxDxN0MQYZzy1NniLwFYug9lKHsrYWE9v/m+VPlUdinVqGOD7UrFA0EY4Q=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:1410:b0:528:5a5a:d846 with SMTP id
 l16-20020a056a00141000b005285a5ad846mr10599808pfu.9.1662660951235; Thu, 08
 Sep 2022 11:15:51 -0700 (PDT)
Date:   Thu, 8 Sep 2022 11:15:49 -0700
In-Reply-To: <20220908114659.102775-1-jolsa@kernel.org>
Mime-Version: 1.0
References: <20220908114659.102775-1-jolsa@kernel.org>
Message-ID: <YxoxVS4s9NgbpXrP@google.com>
Subject: Re: [PATCH bpf-next] bpf: Prevent bpf program recursion for raw
 tracepoint probes
From:   sdf@google.com
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        syzbot+2251879aa068ad9c960d@syzkaller.appspotmail.com,
        bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 09/08, Jiri Olsa wrote:
> We got report from sysbot [1] about warnings that were caused by
> bpf program attached to contention_begin raw tracepoint triggering
> the same tracepoint by using bpf_trace_printk helper that takes
> trace_printk_lock lock.

>   Call Trace:
>    <TASK>
>    ? trace_event_raw_event_bpf_trace_printk+0x5f/0x90
>    bpf_trace_printk+0x2b/0xe0
>    bpf_prog_a9aec6167c091eef_prog+0x1f/0x24
>    bpf_trace_run2+0x26/0x90
>    native_queued_spin_lock_slowpath+0x1c6/0x2b0
>    _raw_spin_lock_irqsave+0x44/0x50
>    bpf_trace_printk+0x3f/0xe0
>    bpf_prog_a9aec6167c091eef_prog+0x1f/0x24
>    bpf_trace_run2+0x26/0x90
>    native_queued_spin_lock_slowpath+0x1c6/0x2b0
>    _raw_spin_lock_irqsave+0x44/0x50
>    bpf_trace_printk+0x3f/0xe0
>    bpf_prog_a9aec6167c091eef_prog+0x1f/0x24
>    bpf_trace_run2+0x26/0x90
>    native_queued_spin_lock_slowpath+0x1c6/0x2b0
>    _raw_spin_lock_irqsave+0x44/0x50
>    bpf_trace_printk+0x3f/0xe0
>    bpf_prog_a9aec6167c091eef_prog+0x1f/0x24
>    bpf_trace_run2+0x26/0x90
>    native_queued_spin_lock_slowpath+0x1c6/0x2b0
>    _raw_spin_lock_irqsave+0x44/0x50
>    __unfreeze_partials+0x5b/0x160
>    ...

> The can be reproduced by attaching bpf program as raw tracepoint on
> contention_begin tracepoint. The bpf prog calls bpf_trace_printk
> helper. Then by running perf bench the spin lock code is forced to
> take slowpath and call contention_begin tracepoint.

> Fixing this by skipping execution of the bpf program if it's
> already running, Using bpf prog 'active' field, which is being
> currently used by trampoline programs for the same reason.

Makes sense to me and seems to address Alexei's earlier point
about bpf_prog_active.

Reviewed-by: Stanislav Fomichev <sdf@google.com>

> Reported-by: syzbot+2251879aa068ad9c960d@syzkaller.appspotmail.com
> [1] https://lore.kernel.org/bpf/YxhFe3EwqchC%2FfYf@krava/T/#t
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>   include/linux/bpf.h      | 1 +
>   kernel/bpf/trampoline.c  | 6 +++---
>   kernel/trace/bpf_trace.c | 6 ++++++
>   3 files changed, 10 insertions(+), 3 deletions(-)

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 48ae05099f36..4737bd0fcbb8 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2640,4 +2640,5 @@ static inline void bpf_cgroup_atype_get(u32  
> attach_btf_id, int cgroup_atype) {}
>   static inline void bpf_cgroup_atype_put(int cgroup_atype) {}
>   #endif /* CONFIG_BPF_LSM */

> +void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog);
>   #endif /* _LINUX_BPF_H */
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index ad76940b02cc..a098bdc33209 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -863,7 +863,7 @@ static __always_inline u64 notrace  
> bpf_prog_start_time(void)
>   	return start;
>   }

> -static void notrace inc_misses_counter(struct bpf_prog *prog)
> +void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog)
>   {
>   	struct bpf_prog_stats *stats;
>   	unsigned int flags;
> @@ -896,7 +896,7 @@ u64 notrace __bpf_prog_enter(struct bpf_prog *prog,  
> struct bpf_tramp_run_ctx *ru
>   	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);

>   	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
> -		inc_misses_counter(prog);
> +		bpf_prog_inc_misses_counter(prog);
>   		return 0;
>   	}
>   	return bpf_prog_start_time();
> @@ -967,7 +967,7 @@ u64 notrace __bpf_prog_enter_sleepable(struct  
> bpf_prog *prog, struct bpf_tramp_r
>   	might_fault();

>   	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
> -		inc_misses_counter(prog);
> +		bpf_prog_inc_misses_counter(prog);
>   		return 0;
>   	}

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 68e5cdd24cef..c8cd1aa7b112 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2042,9 +2042,15 @@ static __always_inline
>   void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
>   {
>   	cant_sleep();
> +	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
> +		bpf_prog_inc_misses_counter(prog);
> +		goto out;
> +	}
>   	rcu_read_lock();
>   	(void) bpf_prog_run(prog, args);
>   	rcu_read_unlock();
> +out:
> +	this_cpu_dec(*(prog->active));
>   }

>   #define UNPACK(...)			__VA_ARGS__
> --
> 2.37.3

