Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7E1599B51
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 13:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347719AbiHSLpo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 07:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348721AbiHSLpj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 07:45:39 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99118DB061;
        Fri, 19 Aug 2022 04:45:38 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id j8so8300510ejx.9;
        Fri, 19 Aug 2022 04:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=LcUynb5n3WhFbuZbjn2oHGF/Y+MnFz6wVGyUbmw+SU4=;
        b=DqkUN6P7DF41mG4HiHPhFzm2IINrpiF/9wMLAqaL4QdSjmOWp7/y6DmKmXHkD/629m
         t2ZD8CmIIXgfkRhfnCYVNcX/c6iFnjpMKZsD0/aPZ2shyXlpB70Z3RwDQgenMwLOVvvW
         mPWmqCXYCelepQLKimhHbNlQpt1mvnquCn43n5ZGgvTOul40oDSfQWetaY9B4tXm9G2U
         JXA60D8ob20UTbdoYNi3W+y4qspNlRlkCKnYD5L8E0FXaRPEe/BBahem1uzsFoDJGO3T
         JE2zd19V60xBOFa7dwCondytnl749PLFnj2mN0XJzjif9o1alPbYCwp6CWTR+y1y7EBU
         WVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=LcUynb5n3WhFbuZbjn2oHGF/Y+MnFz6wVGyUbmw+SU4=;
        b=IVcIAslup0l896kGPgNF0Rrn1VWBJ7xPY1qXHGDi+CTna6/ZFE4DBFXVpIawkrVN1c
         KBOiRe8BqLBSNvcpXZZDGxOMait74A0L6Czuc3Iwa9WSVbCJSeMaj86C8/qA1dbQEWB8
         /T8r/ygGxZyk28ZtfOuTCeT3emN0QYDr16EegY2bctwCn6QQEq7JFO/YxRbAYoB7PlwZ
         MO3vy/SPw72hMk6PnPA2ABKID8dRZNkJfQ2VxzS+drv/2GajKTXxTNTW0kRa1fFHBUaM
         nyOm7syFpkwOEgi6ivxWAPXtkJsLcamI6MegtdG5CyYeqLw29kn5d02FfbwoV5rV9TzJ
         L3xA==
X-Gm-Message-State: ACgBeo3dTv1eeWp1SVZ2zmulXmPAtn9C86LsPzK2dASJNaEUwAguS2zZ
        PxYDX5kqF2e69Iesml68tsE=
X-Google-Smtp-Source: AA6agR6zE6slpEpAh0vLciE3hbbdf+MrB7itwGy/gTuQEmFQ9aflQfx2OMY3M7dmE9hcaPHPceqJyA==
X-Received: by 2002:a17:907:6d24:b0:731:7720:bb9b with SMTP id sa36-20020a1709076d2400b007317720bb9bmr4628015ejc.717.1660909537122;
        Fri, 19 Aug 2022 04:45:37 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id kv10-20020a17090778ca00b0073d56f5757asm357707ejc.223.2022.08.19.04.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 04:45:36 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 19 Aug 2022 13:45:34 +0200
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
Message-ID: <Yv933mq/DTIz5g7q@krava>
References: <YvpZJQGQdVaa2Oh4@worktop.programming.kicks-ass.net>
 <CAADnVQKyfrFTZOM9F77i0NbaXLZZ7KbvKBvu7p6kgdnRgG+2=Q@mail.gmail.com>
 <Yvpf67eCerqaDmlE@worktop.programming.kicks-ass.net>
 <CAADnVQKX5xJz5N_mVyf7wg4BT8Q2cNh8ze-SxTRfk6KtcFQ0=Q@mail.gmail.com>
 <YvpmAnFldR0iwAFC@worktop.programming.kicks-ass.net>
 <YvppJ7TjMXD3cSdZ@worktop.programming.kicks-ass.net>
 <Yv6gm09CMdZ/HMr5@krava>
 <20220818165024.433f56fd@gandalf.local.home>
 <CAADnVQ+n=x=CuBk23UNnD9CHVXjrXLUofbockh-SWaLwH3H9fw@mail.gmail.com>
 <Yv6wB4El4iueJtwX@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv6wB4El4iueJtwX@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 18, 2022 at 11:32:55PM +0200, Jiri Olsa wrote:
> On Thu, Aug 18, 2022 at 02:00:21PM -0700, Alexei Starovoitov wrote:
> > On Thu, Aug 18, 2022 at 1:50 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Thu, 18 Aug 2022 22:27:07 +0200
> > > Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > > ok, so the problem with __attribute__((patchable_function_entry(5))) is that
> > > > it puts function address into __patchable_function_entries section, which is
> > > > one of ftrace locations source:
> > > >
> > > >   #define MCOUNT_REC()    . = ALIGN(8);     \
> > > >     __start_mcount_loc = .;                 \
> > > >     KEEP(*(__mcount_loc))                   \
> > > >     KEEP(*(__patchable_function_entries))   \
> > > >     __stop_mcount_loc = .;                  \
> > > >    ...
> > > >
> > > >
> > > > it looks like __patchable_function_entries is used for other than x86 archs,
> > > > so we perhaps we could have x86 specific MCOUNT_REC macro just with
> > > > __mcount_loc section?
> > >
> > > So something like this:
> > >
> > > #ifdef CONFIG_X86
> > > # define NON_MCOUNT_PATCHABLE KEEP(*(__patchable_function_entries))
> > > # define MCOUNT_PATCHABLE
> > > #else
> > > # define NON_MCOUNT_PATCHABLE
> > > # define MCOUNT_PATCHABLE  KEEP(*(__patchable_function_entries))
> > > #endif
> > >
> > >   #define MCOUNT_REC()    . = ALIGN(8);     \
> > >     __start_mcount_loc = .;                 \
> > >     KEEP(*(__mcount_loc))                   \
> > >     MCOUNT_PATCHABLE                        \
> > >     __stop_mcount_loc = .;                  \
> > >     NON_MCOUNT_PATCHABLE                    \
> > >    ...
> > >
> > > ??
> > 
> > That's what more or less Peter's patch is doing:
> > Here it is again for reference:
> > https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=8d075bdf11193f1d276bf19fa56b4b8dfe24df9e
> 
> ah nice, and discards the __patchable_function_entries section, great
> 

tested change below with Peter's change above and it seems to work,
once it get merged I'll send full patch

thanks,
jirka


---
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 39bd36359c1e..39b6807058e9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -924,6 +924,8 @@ int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs);
 }
 
 #define DEFINE_BPF_DISPATCHER(name)					\
+	__attribute__((__no_instrument_function__))			\
+	__attribute__((patchable_function_entry(5)))			\
 	noinline __nocfi unsigned int bpf_dispatcher_##name##_func(	\
 		const void *ctx,					\
 		const struct bpf_insn *insnsi,				\
