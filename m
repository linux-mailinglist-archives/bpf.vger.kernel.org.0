Return-Path: <bpf+bounces-5045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D41E7544CB
	for <lists+bpf@lfdr.de>; Sat, 15 Jul 2023 00:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C29A1C20E42
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 22:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D1A200C5;
	Fri, 14 Jul 2023 22:05:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C2153AF
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 22:05:27 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F77D1BF3
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 15:05:26 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6831e80080dso1685246b3a.0
        for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 15:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689372325; x=1691964325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HSK8hiSlq+I3EV/RTgFlyY+RJO0KD6oZIQu1DfKsr04=;
        b=oPdQMaE5nNl84GdOHOPtxvdzbjoaDkPKjYL0BW8QG76hrcv1GpeXyf6QrpNZDnuF/d
         FWP5vAyAjIIu+APrpjsSEqe+Vek/+32xupdefyMx3NhCrfuQUlSjtSMS6iQREb7PM1Y8
         RcsVZP1JMm3Z8MlXWP/6Ueb0O9qDrTd3eBNkN5tg7GkXkJcnRBX2WeNvKzN4DOS8Ka+z
         ZeNT5+s9FAoT39O+DFQYPk5Fhl0O4PCEtZiciseB94ZgifIciYl4taLiRyg8Qq9CTLNz
         os6H1GdDbURyexJrBayGMiEyKVn2l124pn5991IpGQ6dr/LS/zGs3HRaasaB7fy8b5g3
         d9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689372325; x=1691964325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSK8hiSlq+I3EV/RTgFlyY+RJO0KD6oZIQu1DfKsr04=;
        b=ChepOXaybpywU676MMJoF/9IcSCdbbsaRZ+jGmqxOiUZH2GltzG8TVzf3UAx8tt2qL
         hgpnrb6FQ+MzsWJ9mF3ugQ/PAIM2qIGnx5VNktp+bPhhuuorF915DNZk6OQ6dF2E599S
         I00HLdG3u1COg9f8GFIkU9xQGTmQ2Q/J2X2KKDOCJZvVxAZqpV6fG2lmHEo/DbFNgmdH
         QOo3ENu1VnqaK68QrUVS+dc04ZYWYW2p1I466M03b64kRu/K5dpYDCRxIBZ8SaiAULHS
         L+4Z/2FLYleVxOYDAN+q1HZq2jnOsCBoE0buD59nPCSNFvRERwiqa+oe4x1+QZmRaGjw
         109w==
X-Gm-Message-State: ABy/qLbnk0pJ93X+1ijpivhxZPXtVVZMnfB4KdxbiIc5uK40ZbAR4p4z
	NYLO0htqDRjVLqZiTBjYi+o=
X-Google-Smtp-Source: APBJJlFKW20P2fV0PmVmaH1R7qGao9RWCZxgg5MlCS86NEI4rb3eo3YHXBcucCEUamPZGj5+2N5d5g==
X-Received: by 2002:a05:6a20:be08:b0:133:fcb0:abcd with SMTP id ge8-20020a056a20be0800b00133fcb0abcdmr1179724pzb.44.1689372325509;
        Fri, 14 Jul 2023 15:05:25 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:2ff4])
        by smtp.gmail.com with ESMTPSA id x14-20020a63aa4e000000b00553d27ab0e0sm7934154pgo.69.2023.07.14.15.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 15:05:25 -0700 (PDT)
Date: Fri, 14 Jul 2023 15:05:22 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	David Vernet <void@manifault.com>
Subject: Re: [PATCH bpf-next v1 05/10] arch/x86: Implement arch_bpf_stack_walk
Message-ID: <20230714220522.r4w256kkjtqhdued@MacBook-Pro-8.local>
References: <20230713023232.1411523-1-memxor@gmail.com>
 <20230713023232.1411523-6-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713023232.1411523-6-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 08:02:27AM +0530, Kumar Kartikeya Dwivedi wrote:
> The plumbing for offline unwinding when we throw an exception in
> programs would require walking the stack, hence introduce a new
> arch_bpf_stack_walk function. This is provided when the JIT supports
> exceptions, i.e. bpf_jit_supports_exceptions is true. The arch-specific
> code is really minimal, hence it should straightforward to extend this
> support to other architectures as well, as it reuses the logic of
> arch_stack_walk, but allowing access to unwind_state data.
> 
> Once the stack pointer and frame pointer are known for the main subprog
> during the unwinding, we know the stack layout and location of any
> callee-saved registers which must be restored before we return back to
> the kernel.
> 
> This handling will be added in the next patch.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 21 +++++++++++++++++++++
>  include/linux/filter.h      |  2 ++
>  kernel/bpf/core.c           |  9 +++++++++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 438adb695daa..d326503ce242 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -16,6 +16,7 @@
>  #include <asm/set_memory.h>
>  #include <asm/nospec-branch.h>
>  #include <asm/text-patching.h>
> +#include <asm/unwind.h>
>  
>  static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
>  {
> @@ -2660,3 +2661,23 @@ void bpf_jit_free(struct bpf_prog *prog)
>  
>  	bpf_prog_unlock_free(prog);
>  }
> +
> +bool bpf_jit_supports_exceptions(void)
> +{
> +	return IS_ENABLED(CONFIG_UNWINDER_ORC) || IS_ENABLED(CONFIG_UNWINDER_FRAME_POINTER);
> +}
> +
> +void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie)
> +{
> +#if defined(CONFIG_UNWINDER_ORC) || defined(CONFIG_UNWINDER_FRAME_POINTER)
> +	struct unwind_state state;
> +	unsigned long addr;
> +
> +	for (unwind_start(&state, current, NULL, NULL); !unwind_done(&state);
> +	     unwind_next_frame(&state)) {
> +		addr = unwind_get_return_address(&state);

I think these steps will work even with UNWINDER_GUESS.
What is the reason for #ifdef ?

> +		if (!addr || !consume_fn(cookie, (u64)addr, (u64)state.sp, (u64)state.bp))
> +			break;
> +	}
> +#endif
> +}
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index f69114083ec7..21ac801330bb 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -920,6 +920,8 @@ bool bpf_jit_needs_zext(void);
>  bool bpf_jit_supports_subprog_tailcalls(void);
>  bool bpf_jit_supports_kfunc_call(void);
>  bool bpf_jit_supports_far_kfunc_call(void);
> +bool bpf_jit_supports_exceptions(void);
> +void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie);
>  bool bpf_helper_changes_pkt_data(void *func);
>  
>  static inline bool bpf_dump_raw_ok(const struct cred *cred)
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 5c484b2bc3d6..5e224cf0ec27 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2770,6 +2770,15 @@ int __weak bpf_arch_text_invalidate(void *dst, size_t len)
>  	return -ENOTSUPP;
>  }
>  
> +bool __weak bpf_jit_supports_exceptions(void)
> +{
> +	return false;
> +}
> +
> +void __weak arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie)
> +{
> +}
> +
>  #ifdef CONFIG_BPF_SYSCALL
>  static int __init bpf_global_ma_init(void)
>  {
> -- 
> 2.40.1
> 

