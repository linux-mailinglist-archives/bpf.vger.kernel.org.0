Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4964C5974AC
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 18:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbiHQQ6B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 12:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbiHQQ57 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 12:57:59 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1B296741;
        Wed, 17 Aug 2022 09:57:58 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a7so25638955ejp.2;
        Wed, 17 Aug 2022 09:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=hLP+S6kLRjuwIdqWwvBk1ZHMXAyy6jMYUeclPfetyb4=;
        b=CABvHkYbt6HHL0PGpdkXgPFufbFV/cofEg85u1v0buP7XK0lICkl7kUZlTxcHZegJj
         cZW+tKjiPbAjRhaQGOFrNm9FwB/gxp5OijPbB3udxyQau6MB60fjbweWg7oDKTEo89Dd
         CEfS6/k5W6G9zLHbbFf7Xw917G9w1aRcdUkh9T4NO9GUtZ6XwHspod1bEXbZdozHzkJT
         G8JcvnwJlFs6zmTN9y0npRmA28pFv7S6zVuboX79RFMNGAwUTKaela0GfWbqCfgl3FpD
         4qGsu20V4+SyyjUuNhrzZnGw/LmXZPO6nCeu2CuQNjjkvhLSo8l0uGo4hrdkiapePfGP
         uyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=hLP+S6kLRjuwIdqWwvBk1ZHMXAyy6jMYUeclPfetyb4=;
        b=7/JnLB83h+igf62hk+Y0LZfBB16X6dX4nB5ZOP5OffRljt2eQSDy5C90wG3ohMI5L1
         0BWcz599RQuhbIudfidBfzm5PuHFYoK/gm/dZizEzhcBzj/U7rIenZm8hzNIiX3Du5ng
         VhW9vCXrD6Int03nmmebots4wNoRenUqwdmp3yzJyqUkm84lrVKQrh+MwV+ZuosNz4+V
         xTM+04l0n9/4se2uzWupR8c77emKJZW+AzGA6cdcPRAURstRRr8ORFAGTdtzJ8NTtlsp
         oqUJBmpcknv+PYuAgLn7ZFjsKvb6rQsKhev7sKTSXsUj0ore05stma1j5VI4GkFPzAcV
         9+3A==
X-Gm-Message-State: ACgBeo0fKmDPRvergaOMVhXCXtFkcL1e4rdlrg/BXx5+/cx+Ag8+7+tZ
        GZCX6a0uMEJ+WcYmzBCW4o7bT5p9t5X7BHo94Ro=
X-Google-Smtp-Source: AA6agR5ieMUt/MmXkjYZqJwZ521wXlpUeKLFoOdOl83nnnlV172csCWd7y557vyYHMDmXtjCAVg6XgLdrh1G22S6oVo=
X-Received: by 2002:a17:907:7612:b0:738:5087:9a65 with SMTP id
 jx18-20020a170907761200b0073850879a65mr10009582ejc.327.1660755476560; Wed, 17
 Aug 2022 09:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <Yvo+EpO9dN30G0XE@worktop.programming.kicks-ass.net>
 <CAADnVQJfvn2RYydqgO-nS_K+C8WJL7BdCnR44MiMF4rnAwWM5A@mail.gmail.com>
 <YvpZJQGQdVaa2Oh4@worktop.programming.kicks-ass.net> <CAADnVQKyfrFTZOM9F77i0NbaXLZZ7KbvKBvu7p6kgdnRgG+2=Q@mail.gmail.com>
 <Yvpf67eCerqaDmlE@worktop.programming.kicks-ass.net> <CAADnVQKX5xJz5N_mVyf7wg4BT8Q2cNh8ze-SxTRfk6KtcFQ0=Q@mail.gmail.com>
 <YvpmAnFldR0iwAFC@worktop.programming.kicks-ass.net> <CAADnVQJuDS22o7fi9wPZx9siAWgu1grQXXB02KfasxZ-RPdRSw@mail.gmail.com>
 <Yvpq3JDk8fTgdMv8@worktop.programming.kicks-ass.net> <Yvs/oey1NUlkI30d@krava> <Yvy06GPn45D0rD7n@krava>
In-Reply-To: <Yvy06GPn45D0rD7n@krava>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 17 Aug 2022 09:57:45 -0700
Message-ID: <CAADnVQ+SJ7VjeXgz-wcN9OGPpfTaJVKhoyKDm895Q60C8T4-QA@mail.gmail.com>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 17, 2022 at 2:29 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Tue, Aug 16, 2022 at 08:56:33AM +0200, Jiri Olsa wrote:
> > On Mon, Aug 15, 2022 at 05:48:44PM +0200, Peter Zijlstra wrote:
> > > On Mon, Aug 15, 2022 at 08:35:53AM -0700, Alexei Starovoitov wrote:
> > > > On Mon, Aug 15, 2022 at 8:28 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > > >
> > > > > On Mon, Aug 15, 2022 at 08:17:42AM -0700, Alexei Starovoitov wrote:
> > > > > > It's hiding a fake function from ftrace, since it's not a function
> > > > > > and ftrace infra shouldn't show it tracing logs.
> > > > > > In other words it's a _notrace_ function with nop5.
> > > > >
> > > > > Then make it a notrace function with a nop5 in it. That isn't hard.
> > > >
> > > > That's exactly what we're trying to do.
> > >
> > > All the while claiming ftrace is broken while it is not.
> > >
> > > > Jiri's patch is one way to achieve that.
> > >
> > > Fairly horrible way.
> > >
> > > > What is your suggestion?
> > >
> > > Mailed it already.
> > >
> > > > Move it from C to asm ?
> > >
> > > Would be much better than proposed IMO.
> >
> > nice, that would be independent of the compiler atributes
> > and config checking..  will check on this one ;-)
>
> how about something like below?
>
> dispatcher code is generated only for x86_64, so that will be covered
> by the assembly version (free of ftrace table) other archs stay same
>
> jirka
>
>
> ----
> diff --git a/arch/x86/net/Makefile b/arch/x86/net/Makefile
> index 383c87300b0d..94964002eaae 100644
> --- a/arch/x86/net/Makefile
> +++ b/arch/x86/net/Makefile
> @@ -7,4 +7,5 @@ ifeq ($(CONFIG_X86_32),y)
>          obj-$(CONFIG_BPF_JIT) += bpf_jit_comp32.o
>  else
>          obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o
> +        obj-$(CONFIG_BPF_JIT) += bpf_dispatcher.o
>  endif
> diff --git a/arch/x86/net/bpf_dispatcher.S b/arch/x86/net/bpf_dispatcher.S
> new file mode 100644
> index 000000000000..65790a1286e8
> --- /dev/null
> +++ b/arch/x86/net/bpf_dispatcher.S
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <linux/linkage.h>
> +#include <asm/nops.h>
> +#include <asm/nospec-branch.h>
> +
> +       .text
> +SYM_FUNC_START(bpf_dispatcher_xdp_func)
> +       ASM_NOP5
> +       JMP_NOSPEC rdx
> +SYM_FUNC_END(bpf_dispatcher_xdp_func)

Wait. Why asm ? Did you try Peter's suggestion:
__attribute__((__no_instrument_function__))
__attribute__((patchable_function_entry(5)))

?
