Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A285ED11A
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 01:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbiI0XiC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 19:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiI0XiA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 19:38:00 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F166E1D1E1A;
        Tue, 27 Sep 2022 16:37:58 -0700 (PDT)
Message-ID: <1d2c81e7-b9d8-c153-608b-6464a10949d8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664321877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NJ7/GjwO5s3/ginJgteWz0r6uzF1YuNFPNCQEpTVgMU=;
        b=Iqz19tkvvyFkJkeNoOree+vsCZ3s93kTzq11StWbOi+2u4ykiHzzr2Ff2tyNkEXkZzSS6T
        ILdIyDrV4NIuIVIHq2A2TN1zWTJJhPtUnDvJDHLOAE04mV8CnXTeBq5fNKaNfYUdSPa+Lf
        NjRfUeE80YHt/WpwzJGePdOxc//7ITs=
Date:   Tue, 27 Sep 2022 16:37:44 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] samples/bpf: offwaketime: pretty print
Content-Language: en-US
To:     Rong Tao <rtoax@foxmail.com>
Cc:     Rong Tao <rongtao@cestc.cn>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_1C233A1BC00A0164C55FCAAB24BF768C320A@qq.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <tencent_1C233A1BC00A0164C55FCAAB24BF768C320A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/25/22 7:22 PM, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> A sample of call stack:
> swapper/10 [
> 	secondary_startup_64_no_verify
> 	cpu_startup_entry
> 	do_idle
> 	schedule_idle
> 	__schedule
> 	__traceiter_sched_switch
> 	__traceiter_sched_switch
> 	-
> 	try_to_wake_up
> 	call_timer_fn
> 	__run_timers.part.0
> 	run_timer_softirq
> 	__softirqentry_text_start
> 	__irq_exit_rcu
> 	sysvec_apic_timer_interrupt
> 	asm_sysvec_apic_timer_interrupt
> 	cpuidle_enter_state
> 	cpuidle_enter
> 	cpuidle_idle_call
> 	do_idle
> 	cpu_startup_entry
> 	secondary_startup_64_no_verify
> ] swapper/10 1
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>   samples/bpf/offwaketime_user.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/samples/bpf/offwaketime_user.c b/samples/bpf/offwaketime_user.c
> index b6eedcb98fb9..d89278d62e4e 100644
> --- a/samples/bpf/offwaketime_user.c
> +++ b/samples/bpf/offwaketime_user.c
> @@ -30,9 +30,9 @@ static void print_ksym(__u64 addr)
>   	}
>   
>   	if (PRINT_RAW_ADDR)
> -		printf("%s/%llx;", sym->name, addr);
> +		printf("\t%s/%llx\n", sym->name, addr);

The origin commit intention is to have an external script for post processing. 
Beside, there are bcc, bpftrace, and libbpf-tools which are better places to 
have different output options.  The current code is good enough for sample 
purpose and no need for unnecessary code churn.
