Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD575A60FE
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 12:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiH3Kon (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 06:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiH3Kon (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 06:44:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB131A3D2A
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 03:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NOGCZOgdOOkPcWIhOncPBTHvKhkYXHsNeuVIFczq+TU=; b=N63JsYoEWcrOCnl4Nwf5JrzJyf
        bQaDahM5/VHWg3+qvR8VXSX7rSQDrBownvYEDTc/A+0hAZ15UjLInPrS1ZbVHqrWVvnwQBqli85N+
        6O9GJdHeh59R4vv9iPWuy6GIXUNbR2HZLNDywPdS1VinRDt0uT+hkQmD+myVhe4n8k6dLJdnQzJvZ
        5TsGCIFdzkmXZmhEP2ZiBYeyN6o3L8x3vsgAQyDWDXqOzU6SAG/zJnpoxmOB3VYq0ibImhTxwOBJO
        o9eIFSjGtfKNdHteGWZrUH67MxBujIoGdlVs6aWFgrtJElbNjFFFVGVlweroNXk4WgdcWwwBXi3Rh
        N3KpNHpw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSyj8-007oGH-6Z; Tue, 30 Aug 2022 10:44:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E03A3002C7;
        Tue, 30 Aug 2022 12:44:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3D43D20A3D215; Tue, 30 Aug 2022 12:44:13 +0200 (CEST)
Date:   Tue, 30 Aug 2022 12:44:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Subject: Re: [PATCH bpf-next 2/2] bpf: Move bpf_dispatcher function out of
 ftrace locations
Message-ID: <Yw3p/WBKlOaN+W9h@hirez.programming.kicks-ass.net>
References: <20220826184608.141475-1-jolsa@kernel.org>
 <20220826184608.141475-3-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826184608.141475-3-jolsa@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 26, 2022 at 08:46:08PM +0200, Jiri Olsa wrote:
> The dispatcher function is attached/detached to trampoline by
> dispatcher update function. At the same time it's available as
> ftrace attachable function.
> 
> After discussion [1] the proposed solution is to use compiler
> attributes to alter bpf_dispatcher_##name##_func function:
> 
>   - remove it from being instrumented with __no_instrument_function__
>     attribute, so ftrace has no track of it

This is typically spelled like: 'notrace' in the kernel.

>   - but still generate 5 nop instructions with patchable_function_entry(5)
>     attribute, which are expected by bpf_arch_text_poke used by
>     dispatcher update function
> 
> Enabling HAVE_DYNAMIC_FTRACE_NO_PATCHABLE option for x86, so
> __patchable_function_entries functions are not part of ftrace/mcount
> locations.
> 
> The dispatcher code is generated and attached only for x86 so it's safe
> to keep bpf_dispatcher func in patchable_function_entry locations for
> other archs.
> 
> [1] https://lore.kernel.org/bpf/20220722110811.124515-1-jolsa@kernel.org/
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/Kconfig    | 1 +
>  include/linux/bpf.h | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index f9920f1341c8..089c20cefd2b 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -284,6 +284,7 @@ config X86
>  	select PROC_PID_ARCH_STATUS		if PROC_FS
>  	select HAVE_ARCH_NODE_DEV_GROUP		if X86_SGX
>  	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
> +	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
>  
>  config INSTRUCTION_DECODER
>  	def_bool y
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 9c1674973e03..945d5414bb62 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -925,6 +925,8 @@ int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs);
>  }
>  
>  #define DEFINE_BPF_DISPATCHER(name)					\
> +	__attribute__((__no_instrument_function__))			\
> +	__attribute__((patchable_function_entry(5)))			\
>  	noinline __nocfi unsigned int bpf_dispatcher_##name##_func(	\
>  		const void *ctx,					\
>  		const struct bpf_insn *insnsi,				\

What makes that whole dispatcher thing x86 only? AFAICT it is only under
BPF_JIT here and could be used by anyone.

ARM64 for instance has BPG_JIT and builds net/core/filter.c. And ARM64
very much does use patchable_function_entry() for its ftrace
implementation.
