Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57C95AE6A1
	for <lists+bpf@lfdr.de>; Tue,  6 Sep 2022 13:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbiIFLck (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 07:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbiIFLck (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 07:32:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565974BA6B
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 04:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H+HJG8j3ty/46wBbnhnHRGsgOEaKEr21+F/xvsv/PRU=; b=HRMeuDM3jO66TVGBBUgUFquwHH
        leI+RfijIbtgOLMDKCwij3zsJN1S2stJkG5XyHtMVddqiw+QHpZ551jiQwAXXrqTEchtrq9iuRkAy
        7HE4PdTkydmzugJoZMrQYjlLcZipEmNC3DopLsxz/OqjpdVzKpw/tYwai/hX5TYTQmL9e9MSEJLWu
        RZDQPXj085mVhe94zZBHKZryQidWXqchFfvoPAbEsIVz3k3JyjSBJC7OpblUzzC6EO18F+8nUT0uR
        JhfVjnj9q5FnEhWAay+xd4QoVuFdUe07GkRo6eOearsQ63cTGQPlp+5Y6/7Z2Oka6/NABeXaHAfPR
        R3VD7XZQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVWoa-00ALyN-4V; Tue, 06 Sep 2022 11:32:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 235A6300348;
        Tue,  6 Sep 2022 13:32:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F2CAB2B6785DC; Tue,  6 Sep 2022 13:32:20 +0200 (CEST)
Date:   Tue, 6 Sep 2022 13:32:20 +0200
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
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCHv3 bpf-next 2/2] bpf: Move bpf_dispatcher function out of
 ftrace locations
Message-ID: <YxcvxI154uTBuHYw@hirez.programming.kicks-ass.net>
References: <20220903131154.420467-1-jolsa@kernel.org>
 <20220903131154.420467-3-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903131154.420467-3-jolsa@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Sep 03, 2022 at 03:11:54PM +0200, Jiri Olsa wrote:
> The dispatcher function is attached/detached to trampoline by
> dispatcher update function. At the same time it's available as
> ftrace attachable function.
> 
> After discussion [1] the proposed solution is to use compiler
> attributes to alter bpf_dispatcher_##name##_func function:
> 
>   - remove it from being instrumented with __no_instrument_function__
>     attribute, so ftrace has no track of it
> 
>   - but still generate 5 nop instructions with patchable_function_entry(5)
>     attribute, which are expected by bpf_arch_text_poke used by
>     dispatcher update function
> 
> Enabling HAVE_DYNAMIC_FTRACE_NO_PATCHABLE option for x86, so
> __patchable_function_entries functions are not part of ftrace/mcount
> locations.
> 
> Adding attributes to bpf_dispatcher_XXX function on x86_64 so it's
> kept out of ftrace locations and has 5 byte nop generated at entry.
> 
> These attributes need to be arch specific as pointer out by Ilya
> Leoshkevic in here [2].
> 
> The dispatcher image is generated only for x86_64 arch, so the
> code can stay as is for other archs.
> 
> [1] https://lore.kernel.org/bpf/20220722110811.124515-1-jolsa@kernel.org/
> [2] https://lore.kernel.org/bpf/969a14281a7791c334d476825863ee449964dd0c.camel@linux.ibm.com/
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/Kconfig    | 1 +
>  include/linux/bpf.h | 7 +++++++
>  2 files changed, 8 insertions(+)
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
> index 9c1674973e03..e267625557cb 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -924,7 +924,14 @@ int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs);
>  	},							\
>  }
>  
> +#ifdef CONFIG_X86_64
> +#define BPF_DISPATCHER_ATTRIBUTES __attribute__((patchable_function_entry(5)))
> +#else
> +#define BPF_DISPATCHER_ATTRIBUTES
> +#endif
> +
>  #define DEFINE_BPF_DISPATCHER(name)					\
> +	notrace BPF_DISPATCHER_ATTRIBUTES				\
>  	noinline __nocfi unsigned int bpf_dispatcher_##name##_func(	\
>  		const void *ctx,					\
>  		const struct bpf_insn *insnsi,				\

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
