Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0830604FC7
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 20:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJSSir (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 14:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiJSSir (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 14:38:47 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EF0F53D6
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 11:38:46 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id g3-20020a056a000b8300b00563772d1021so9891332pfj.18
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 11:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aqBmPGloF9dC48Xg8Un3Ing+FzCSYiBV6K66Y9k5YCo=;
        b=KHRRxhGj2+R4ZEEx1Q0/OMhKkgj6/pzIbwYhk9Z+xDVzcfF1lJWERR20UiRJxPsfMd
         tj/MAP4LZYyTCfVtaswxsqvHRDfwsIGFOV/uvtdMNb8ljQFHbHpFaFdoyenwPIoD8d/w
         adTorG++/dZa7548axq6r/01mxms24MrUdAoal67qkO/7miOXLlUvfaZmeasM1EgBjVS
         L1LWfC+3c0Z/KbpsidVbhK0YUT/xJejmCAtui+u3vBToxVeCdoAoFc+OLJacoChJH3r6
         GNlaGof2SAFAd+UFn/ViRKle2RXT262ik5GjiTqTnuriPZdvwEu3cgzj2kmKEWZaSyDy
         krIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqBmPGloF9dC48Xg8Un3Ing+FzCSYiBV6K66Y9k5YCo=;
        b=ypCQRvq88fJfA4O+Hkdl5HMl6cZrFeqrOxD9/WRWTAJD5vJ93Xlz6W9Qco4RWqwDvd
         kzppDS06a11pdKDnY+EVuWhCuza001myCjfVA8cA0LJA88m15umLbzPG2guZ+eFIWZn+
         hjHsVOxbJIRCeSH4g9zH9a+uLElcYGJNcPHDUFsaueQeNZPp4M1/ZXrqUbgk6V4rpq97
         uzc44P8Z2cjTLZenjBCCj7gL8bDErhVZ/9vc4jR2hmen8X+YJ6oL0oWRZ8II9uokNX4u
         Nk2PDck8pHc/HnKQiHj5GY1BUd6jfpN+wJYw37WSUx1JGo3vv5zQNtuRxNk8DC2BZQNn
         E8nA==
X-Gm-Message-State: ACrzQf00d7gpChVIAcHEFEro0mXUirYQxwyt/FnNuL9cwU/pihKlWGbh
        xZIBv/2VYzt/yJORr8ywsqaGd8I=
X-Google-Smtp-Source: AMsMyM50NO8/ojq7mA3v9DfZ3QjisUeEFquR7XFIeu3nJ0We6Eo4CtQUo1xI04EyAnu8ZtybCbTnu4c=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a62:5e81:0:b0:563:1f18:62ab with SMTP id
 s123-20020a625e81000000b005631f1862abmr9710310pfb.76.1666204725935; Wed, 19
 Oct 2022 11:38:45 -0700 (PDT)
Date:   Wed, 19 Oct 2022 11:38:44 -0700
In-Reply-To: <20221019115539.983394-2-houtao@huaweicloud.com>
Mime-Version: 1.0
References: <20221019115539.983394-1-houtao@huaweicloud.com> <20221019115539.983394-2-houtao@huaweicloud.com>
Message-ID: <Y1BENCpam1I+anXF@google.com>
Subject: Re: [PATCH bpf 1/2] bpf: Wait for busy refill_work when destorying
 bpf memory allocator
From:   sdf@google.com
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/19, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>

> A busy irq work is an unfinished irq work and it can be either in the
> pending state or in the running state. When destroying bpf memory
> allocator, refill_work may be busy for PREEMPT_RT kernel in which irq
> work is invoked in a per-CPU RT-kthread. It is also possible for kernel
> with arch_irq_work_has_interrupt() being false (e.g. 1-cpu arm32 host)
> and irq work is inovked in timer interrupt.

> The busy refill_work leads to various issues. The obvious one is that
> there will be concurrent operations on free_by_rcu and free_list between
> irq work and memory draining. Another one is call_rcu_in_progress will
> not be reliable for the checking of pending RCU callback because
> do_call_rcu() may has not been invoked by irq work. The other is there
> will be use-after-free if irq work is freed before the callback of
> irq work is invoked as shown below:

>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   #PF: supervisor instruction fetch in kernel mode
>   #PF: error_code(0x0010) - not-present page
>   PGD 12ab94067 P4D 12ab94067 PUD 1796b4067 PMD 0
>   Oops: 0010 [#1] PREEMPT_RT SMP
>   CPU: 5 PID: 64 Comm: irq_work/5 Not tainted 6.0.0-rt11+ #1
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>   RIP: 0010:0x0
>   Code: Unable to access opcode bytes at 0xffffffffffffffd6.
>   RSP: 0018:ffffadc080293e78 EFLAGS: 00010286
>   RAX: 0000000000000000 RBX: ffffcdc07fb6a388 RCX: ffffa05000a2e000
>   RDX: ffffa05000a2e000 RSI: ffffffff96cc9827 RDI: ffffcdc07fb6a388
>   ......
>   Call Trace:
>    <TASK>
>    irq_work_single+0x24/0x60
>    irq_work_run_list+0x24/0x30
>    run_irq_workd+0x23/0x30
>    smpboot_thread_fn+0x203/0x300
>    kthread+0x126/0x150
>    ret_from_fork+0x1f/0x30
>    </TASK>

> Considering the ease of concurrency handling and the short wait time
> used for irq_work_sync() under PREEMPT_RT (When running two test_maps on
> PREEMPT_RT kernel and 72-cpus host, the max wait time is about 8ms and
> the 99th percentile is 10us), just waiting for busy refill_work to
> complete before memory draining and memory freeing.

> Fixes: 7c8199e24fa0 ("bpf: Introduce any context BPF specific memory  
> allocator.")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>   kernel/bpf/memalloc.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)

> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 94f0f63443a6..48e606aaacf0 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -497,6 +497,16 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
>   		rcu_in_progress = 0;
>   		for_each_possible_cpu(cpu) {
>   			c = per_cpu_ptr(ma->cache, cpu);
> +			/*
> +			 * refill_work may be unfinished for PREEMPT_RT kernel
> +			 * in which irq work is invoked in a per-CPU RT thread.
> +			 * It is also possible for kernel with
> +			 * arch_irq_work_has_interrupt() being false and irq
> +			 * work is inovked in timer interrupt. So wait for the
> +			 * completion of irq work to ease the handling of
> +			 * concurrency.
> +			 */
> +			irq_work_sync(&c->refill_work);

Does it make sense to guard these with "IS_ENABLED(CONFIG_PREEMPT_RT)" ?
We do have a bunch of them sprinkled already to run alloc/free with
irqs disabled.

I was also trying to see if adding local_irq_save inside drain_mem_cache
to pair with the ones from refill might work, but waiting for irq to
finish seems easier...

Maybe also move both of these in some new "static void irq_work_wait"
to make it clear that the PREEMT_RT comment applies to both of them?

Or maybe that helper should do 'for_each_possible_cpu(cpu)  
irq_work_sync(&c->refill_work);'
in the PREEMPT_RT case so we don't have to call it twice?

>   			drain_mem_cache(c);
>   			rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
>   		}
> @@ -511,6 +521,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
>   			cc = per_cpu_ptr(ma->caches, cpu);
>   			for (i = 0; i < NUM_CACHES; i++) {
>   				c = &cc->cache[i];
> +				irq_work_sync(&c->refill_work);
>   				drain_mem_cache(c);
>   				rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
>   			}
> --
> 2.29.2

