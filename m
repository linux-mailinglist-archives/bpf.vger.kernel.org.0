Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB015AD641
	for <lists+bpf@lfdr.de>; Mon,  5 Sep 2022 17:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbiIEPYI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Sep 2022 11:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238899AbiIEPXN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Sep 2022 11:23:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FF12127B
        for <bpf@vger.kernel.org>; Mon,  5 Sep 2022 08:23:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4FAEB811F9
        for <bpf@vger.kernel.org>; Mon,  5 Sep 2022 15:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3ACC433D6;
        Mon,  5 Sep 2022 15:23:07 +0000 (UTC)
Date:   Mon, 5 Sep 2022 11:23:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?Qmo=?= =?UTF-8?B?w7ZybiBUw7ZwZWw=?= <bjorn@kernel.org>
Subject: Re: [PATCHv3 bpf-next 2/2] bpf: Move bpf_dispatcher function out of
 ftrace locations
Message-ID: <20220905112345.3daf34a1@gandalf.local.home>
In-Reply-To: <20220903131154.420467-3-jolsa@kernel.org>
References: <20220903131154.420467-1-jolsa@kernel.org>
        <20220903131154.420467-3-jolsa@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat,  3 Sep 2022 15:11:54 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

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

I think Peter may have already mentioned this, but shouldn't he above be:

  #ifdef HAVE_DYNAMIC_FTRACE_NO_PATCHABLE

??

-- Steve

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
> -- 
