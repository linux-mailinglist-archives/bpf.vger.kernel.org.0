Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191E34E7E69
	for <lists+bpf@lfdr.de>; Sat, 26 Mar 2022 02:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiCZBWc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 21:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiCZBWb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 21:22:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2104D2A5AA6;
        Fri, 25 Mar 2022 18:20:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C14DAB82AE1;
        Sat, 26 Mar 2022 01:20:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A733C2BBE4;
        Sat, 26 Mar 2022 01:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648257653;
        bh=2jM6K8HMj5gWuZKaREeuXsW8X1XXJcDu7VTZ4Gfp0is=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EO9MI3ehZHiOLQMcJlTwchKS/p6Js2NZFbXf9joprxQs2P7hTMp7d8aCULfgYESZi
         MPKtKXrKqC4eMF09Q5BzgI5G0PuwAbCHZuXf6vukcDkFPi1neEtTRKSIC2ktmPj6lk
         Hmaa5kdihagorvJ9LOpt/ARO1Mt90Gt4r+3nJZOIy10MTZdw8n8Y266Qylk6TqxNkv
         C5hY4uFuSNC6dzMFVSNCtU+2TSVekU2WAh7tSraXu/SqKSLaGd9P6K2uUnztveQbtQ
         rL2bQHFET5z9uY3A7uu3qRtt/phHpvfcqCUcK2TYswijun2rxOK7C13EDPV9rl8Dhs
         Fax3QgG8o77lg==
Date:   Sat, 26 Mar 2022 10:20:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel-janitors@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 0/4] kprobes: rethook: x86: Replace
 kretprobe trampoline with rethook
Message-Id: <20220326102047.61c095c112e0add6876446e2@kernel.org>
In-Reply-To: <Yj3zB2n7Hy0DhkU+@hirez.programming.kicks-ass.net>
References: <164821817332.2373735.12048266953420821089.stgit@devnote2>
        <Yj3VAsgGA9zJvxgs@hirez.programming.kicks-ass.net>
        <Yj3zB2n7Hy0DhkU+@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 25 Mar 2022 17:51:19 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Mar 25, 2022 at 03:43:15PM +0100, Peter Zijlstra wrote:
> > On Fri, Mar 25, 2022 at 11:22:53PM +0900, Masami Hiramatsu wrote:
> > 
> > > Masami Hiramatsu (3):
> > >       kprobes: Use rethook for kretprobe if possible
> > >       rethook: kprobes: x86: Replace kretprobe with rethook on x86
> > >       x86,kprobes: Fix optprobe trampoline to generate complete pt_regs
> > > 
> > > Peter Zijlstra (1):
> > >       Subject: x86,rethook: Fix arch_rethook_trampoline() to generate a complete pt_regs
> > 
> > You fat-fingered the subject there ^
> > 
> > Other than that:
> > 
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > Hopefully the ftrace return trampoline can also be switched over..
> 
> Urgh, allnoconfig doesn't build because..
> 
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 56f4ee97f328..471d71935e90 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -108,6 +108,7 @@ obj-$(CONFIG_TRACING) += trace/
>  obj-$(CONFIG_TRACE_CLOCK) += trace/
>  obj-$(CONFIG_RING_BUFFER) += trace/
>  obj-$(CONFIG_TRACEPOINTS) += trace/
> +obj-$(CONFIG_RETHOOK) += trace/
>  obj-$(CONFIG_IRQ_WORK) += irq_work.o
>  obj-$(CONFIG_CPU_PM) += cpu_pm.o
>  obj-$(CONFIG_BPF) += bpf/

Oops, thanks for pointing out!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
