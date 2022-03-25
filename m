Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540534E7952
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 17:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244738AbiCYQxg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 12:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241225AbiCYQxf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 12:53:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77709C12C2;
        Fri, 25 Mar 2022 09:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cPXI5QeuTULG9j4cx1a19QqWrwb7jb28krf+MnTbuWc=; b=a7zRRuEeeYE6dBkAWaXIuqwuds
        U62BNMi+T60gNXHOFW8sWRHaYet9RyMVTwcd1nc/iMUu7jFROexr5T6IquNr3YVoDEnK/r+ZeVFjh
        os7xKznL35YjNBZwVbkl7mVjtexSluDgO52MrTmk1q7D6njtsSK1VBixCcoQ25Y7VJ7fjUx0SE94p
        juEctRAcGAaLGVPytek1ib2OU1RYKKr2SR0/XXH5hc57LuYefu3bSAUyft7JHAHXqD6V3ThT4+QvL
        C76m07bJvIQ9sLKA/N0DiOvtDZjw/ne3vUks1sb20PdKeWKFFFY88VeTAOIWBv6oeZSqhFj4k2MIb
        we8cTiVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXn9l-004S23-Iu; Fri, 25 Mar 2022 16:51:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3A8863002BF;
        Fri, 25 Mar 2022 17:51:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 21A932057F80B; Fri, 25 Mar 2022 17:51:19 +0100 (CET)
Date:   Fri, 25 Mar 2022 17:51:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
Subject: Re: [PATCH bpf-next v2 0/4] kprobes: rethook: x86: Replace kretprobe
 trampoline with rethook
Message-ID: <Yj3zB2n7Hy0DhkU+@hirez.programming.kicks-ass.net>
References: <164821817332.2373735.12048266953420821089.stgit@devnote2>
 <Yj3VAsgGA9zJvxgs@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yj3VAsgGA9zJvxgs@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 25, 2022 at 03:43:15PM +0100, Peter Zijlstra wrote:
> On Fri, Mar 25, 2022 at 11:22:53PM +0900, Masami Hiramatsu wrote:
> 
> > Masami Hiramatsu (3):
> >       kprobes: Use rethook for kretprobe if possible
> >       rethook: kprobes: x86: Replace kretprobe with rethook on x86
> >       x86,kprobes: Fix optprobe trampoline to generate complete pt_regs
> > 
> > Peter Zijlstra (1):
> >       Subject: x86,rethook: Fix arch_rethook_trampoline() to generate a complete pt_regs
> 
> You fat-fingered the subject there ^
> 
> Other than that:
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Hopefully the ftrace return trampoline can also be switched over..

Urgh, allnoconfig doesn't build because..

diff --git a/kernel/Makefile b/kernel/Makefile
index 56f4ee97f328..471d71935e90 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -108,6 +108,7 @@ obj-$(CONFIG_TRACING) += trace/
 obj-$(CONFIG_TRACE_CLOCK) += trace/
 obj-$(CONFIG_RING_BUFFER) += trace/
 obj-$(CONFIG_TRACEPOINTS) += trace/
+obj-$(CONFIG_RETHOOK) += trace/
 obj-$(CONFIG_IRQ_WORK) += irq_work.o
 obj-$(CONFIG_CPU_PM) += cpu_pm.o
 obj-$(CONFIG_BPF) += bpf/
