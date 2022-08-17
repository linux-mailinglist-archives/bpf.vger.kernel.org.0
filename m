Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91294596C0C
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 11:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiHQJ3T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 05:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiHQJ3S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 05:29:18 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C2F27CF2;
        Wed, 17 Aug 2022 02:29:16 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id y13so23444376ejp.13;
        Wed, 17 Aug 2022 02:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=jljdedi6DAkIAYkCnbgj5IjVnTulkRPsvXaOGGTQHjk=;
        b=CYrdM5leNid3d5aUornHuKlAPIq/tg/zwug8RUJg3j5tU/mlmvLw4iO09HoO9rewuy
         ZfZoPfjf6lbjcmxsPH2HthMiXmtB9kaov+wNSxDX9sVPHwh2voBdySWIS13yeFYWGhGv
         VuXrxQDvTZyoOcaQGoNZw0JY4xESY7jzNlcvSKiGY6jkPCSYTK44HiO/TBOpsD9kc1DH
         gyhUiZgvUj7hgFtc2cdUzVKn03eBN7k9xnLrV/e4XrQkQ+sA7eE3CVkvaOP783Yi2kgY
         QPS8wG9CEG8uvXxGGWJ2rt7M8t9TDxcHOlxS2CYHim6oUSSAcjr/4GN0l4mosF+nAisk
         VI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=jljdedi6DAkIAYkCnbgj5IjVnTulkRPsvXaOGGTQHjk=;
        b=g9aWi0295dK1aWLTjxqlFEzpqaTCWo8amRV9Q0bzyQEmS3d3jQeKKzRZiBO0wKBB77
         QpLjZ4sP9RKv6lK7KtTn/2yUNYO1kAkzD8PWD3qO0yNsf6f0wn9Y8g2FDTOm3+ysEmI0
         4a2ajxNfaoC387gY2oNR2j6KdLnxo+j8ChozW+rLaEw1/b9Rc0JLIlhSNk0jay7r7Wno
         51GpJSMp2LZbQOZdQWjkxCEejvxLbGqkU6DQ5cU3dmwI2Xodg6bhzpXpEJf2yqLfnpq5
         RCXauokeOuiSOo+SrjjwEHMeY+hShhhkhElp2G/cm1kmRJhyYhUnjhFBT2SIXQNPZoHR
         9Exw==
X-Gm-Message-State: ACgBeo3Zx60mg14oyNAI4O0Lq8c/bqfrxPU/1VFxhECi/ALn7OzH5YmZ
        PhwAgL3bxb7ZomrG3IvENeM=
X-Google-Smtp-Source: AA6agR4MiAdMay67Au4I3uD3+4DBq5nNX1gACXdguiQjG+H8gS8v9LqNb0OxRpTdm2KNehcwOikG5A==
X-Received: by 2002:a17:907:7d8c:b0:731:65f6:1f28 with SMTP id oz12-20020a1709077d8c00b0073165f61f28mr15361798ejc.91.1660728555133;
        Wed, 17 Aug 2022 02:29:15 -0700 (PDT)
Received: from krava ([83.240.61.33])
        by smtp.gmail.com with ESMTPSA id p26-20020aa7cc9a000000b0043cc66d7accsm10210626edt.36.2022.08.17.02.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 02:29:14 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 17 Aug 2022 11:29:12 +0200
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
        Josh Poimboeuf <jpoimboe@redhat.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
Message-ID: <Yvy06GPn45D0rD7n@krava>
References: <Yvo+EpO9dN30G0XE@worktop.programming.kicks-ass.net>
 <CAADnVQJfvn2RYydqgO-nS_K+C8WJL7BdCnR44MiMF4rnAwWM5A@mail.gmail.com>
 <YvpZJQGQdVaa2Oh4@worktop.programming.kicks-ass.net>
 <CAADnVQKyfrFTZOM9F77i0NbaXLZZ7KbvKBvu7p6kgdnRgG+2=Q@mail.gmail.com>
 <Yvpf67eCerqaDmlE@worktop.programming.kicks-ass.net>
 <CAADnVQKX5xJz5N_mVyf7wg4BT8Q2cNh8ze-SxTRfk6KtcFQ0=Q@mail.gmail.com>
 <YvpmAnFldR0iwAFC@worktop.programming.kicks-ass.net>
 <CAADnVQJuDS22o7fi9wPZx9siAWgu1grQXXB02KfasxZ-RPdRSw@mail.gmail.com>
 <Yvpq3JDk8fTgdMv8@worktop.programming.kicks-ass.net>
 <Yvs/oey1NUlkI30d@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yvs/oey1NUlkI30d@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 16, 2022 at 08:56:33AM +0200, Jiri Olsa wrote:
> On Mon, Aug 15, 2022 at 05:48:44PM +0200, Peter Zijlstra wrote:
> > On Mon, Aug 15, 2022 at 08:35:53AM -0700, Alexei Starovoitov wrote:
> > > On Mon, Aug 15, 2022 at 8:28 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Mon, Aug 15, 2022 at 08:17:42AM -0700, Alexei Starovoitov wrote:
> > > > > It's hiding a fake function from ftrace, since it's not a function
> > > > > and ftrace infra shouldn't show it tracing logs.
> > > > > In other words it's a _notrace_ function with nop5.
> > > >
> > > > Then make it a notrace function with a nop5 in it. That isn't hard.
> > > 
> > > That's exactly what we're trying to do.
> > 
> > All the while claiming ftrace is broken while it is not.
> > 
> > > Jiri's patch is one way to achieve that.
> > 
> > Fairly horrible way.
> > 
> > > What is your suggestion?
> > 
> > Mailed it already.
> > 
> > > Move it from C to asm ?
> > 
> > Would be much better than proposed IMO.
> 
> nice, that would be independent of the compiler atributes
> and config checking..  will check on this one ;-)

how about something like below?

dispatcher code is generated only for x86_64, so that will be covered
by the assembly version (free of ftrace table) other archs stay same

jirka


----
diff --git a/arch/x86/net/Makefile b/arch/x86/net/Makefile
index 383c87300b0d..94964002eaae 100644
--- a/arch/x86/net/Makefile
+++ b/arch/x86/net/Makefile
@@ -7,4 +7,5 @@ ifeq ($(CONFIG_X86_32),y)
         obj-$(CONFIG_BPF_JIT) += bpf_jit_comp32.o
 else
         obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o
+        obj-$(CONFIG_BPF_JIT) += bpf_dispatcher.o
 endif
diff --git a/arch/x86/net/bpf_dispatcher.S b/arch/x86/net/bpf_dispatcher.S
new file mode 100644
index 000000000000..65790a1286e8
--- /dev/null
+++ b/arch/x86/net/bpf_dispatcher.S
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/linkage.h>
+#include <asm/nops.h>
+#include <asm/nospec-branch.h>
+
+	.text
+SYM_FUNC_START(bpf_dispatcher_xdp_func)
+	ASM_NOP5
+	JMP_NOSPEC rdx
+SYM_FUNC_END(bpf_dispatcher_xdp_func)
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a627a02cf8ab..03b54c820b95 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -924,7 +924,7 @@ int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs);
 }
 
 #define DEFINE_BPF_DISPATCHER(name)					\
-	noinline __nocfi unsigned int bpf_dispatcher_##name##_func(	\
+	noinline __nocfi unsigned int __weak bpf_dispatcher_##name##_func(\
 		const void *ctx,					\
 		const struct bpf_insn *insnsi,				\
 		bpf_func_t bpf_func)					\
