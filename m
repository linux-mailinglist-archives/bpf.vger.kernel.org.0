Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322D05976D5
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 21:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238288AbiHQTjq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 15:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238528AbiHQTjl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 15:39:41 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0DA98D3A;
        Wed, 17 Aug 2022 12:39:39 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id w19so26317144ejc.7;
        Wed, 17 Aug 2022 12:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=EuNyPRJfq+eeFKDGgW9jPrQ9YAIsMyHr4aBhbhS+A4s=;
        b=Q63m1AbpALxx+9Y4vjkVG40gDhEIjsP7Yo8Bu7O8/nYIF0bvVlaYqLFGBVFyAk6u2w
         byz+tISo/V2bL0RHknT3uc4aFIHPTTMu3mL5B86HHJcmKdmjBSbIODow4inSy2/P1QkT
         2KkQtE1au7DQj/RPDzus9O8GqTmmuv/PNApctAxKuib3DnnZTl3LyYd9ACfp4KfoGfeq
         XZK0tBpnnIyHDaIJqGnz/b7tlfUDuWShBXqtlvwD437MnT7In5ArFGdQTqEvx8fxgzWC
         atic+bEJZ8sB3o2C1rWNL2Zpnw0sx8XG4wN8FPl0mFwd7coNKds37mbYcpHa53CqP+dL
         75qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=EuNyPRJfq+eeFKDGgW9jPrQ9YAIsMyHr4aBhbhS+A4s=;
        b=7lIUqXAfCLqtq1le331NYmuj8U++hMAK0Cjt3Lpvkp7pOtLcwfsOCLOvCPvo3fZg1H
         nZgL7VKVxM24bWlOjynSeYln6b9n6hnHcWiITq37BSnjAqufIbyc3lF6GE9klQqQQMMb
         ci8+L3OODLDt0bRZHO33Fg2kVQo0h+xBfuDyfE5vHRQRTVheDpIoYZT1hJ+1exMWYsfw
         BUMAYIeKvEzUMRgpzVfJMWms1+q8fa86bADi2BHLICYh2y5X5cs2nGz/0QrYI7b/du3B
         Vhvi+4mHx2slRfmZW+vXro3KixLchD080qZAQkBs1hgcK6GXT2/5iZrQd5cuuOXRlrqJ
         vc4w==
X-Gm-Message-State: ACgBeo2f7qIgJL9GrvuwCO/Qg9jutqt5SYp0e02tudDRhMQWJkrrFtGf
        nkCSX8J33pOfntIYRtPEP28=
X-Google-Smtp-Source: AA6agR7JLNM2W/egU8UqbmSaeU/ggp7D9sGrC73lkUQhDIgNs4EvJriugcZd8cHPG9HgPWsfKXnFng==
X-Received: by 2002:a17:907:28d6:b0:731:100c:8999 with SMTP id en22-20020a17090728d600b00731100c8999mr17535301ejc.210.1660765178394;
        Wed, 17 Aug 2022 12:39:38 -0700 (PDT)
Received: from krava ([83.240.62.131])
        by smtp.gmail.com with ESMTPSA id cq10-20020a056402220a00b00445d85bd754sm2211227edb.79.2022.08.17.12.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 12:39:37 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 17 Aug 2022 21:39:36 +0200
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <Yv1D+D2mJtPR236L@krava>
References: <YvpZJQGQdVaa2Oh4@worktop.programming.kicks-ass.net>
 <CAADnVQKyfrFTZOM9F77i0NbaXLZZ7KbvKBvu7p6kgdnRgG+2=Q@mail.gmail.com>
 <Yvpf67eCerqaDmlE@worktop.programming.kicks-ass.net>
 <CAADnVQKX5xJz5N_mVyf7wg4BT8Q2cNh8ze-SxTRfk6KtcFQ0=Q@mail.gmail.com>
 <YvpmAnFldR0iwAFC@worktop.programming.kicks-ass.net>
 <CAADnVQJuDS22o7fi9wPZx9siAWgu1grQXXB02KfasxZ-RPdRSw@mail.gmail.com>
 <Yvpq3JDk8fTgdMv8@worktop.programming.kicks-ass.net>
 <Yvs/oey1NUlkI30d@krava>
 <Yvy06GPn45D0rD7n@krava>
 <CAADnVQ+SJ7VjeXgz-wcN9OGPpfTaJVKhoyKDm895Q60C8T4-QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+SJ7VjeXgz-wcN9OGPpfTaJVKhoyKDm895Q60C8T4-QA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 17, 2022 at 09:57:45AM -0700, Alexei Starovoitov wrote:
> On Wed, Aug 17, 2022 at 2:29 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Tue, Aug 16, 2022 at 08:56:33AM +0200, Jiri Olsa wrote:
> > > On Mon, Aug 15, 2022 at 05:48:44PM +0200, Peter Zijlstra wrote:
> > > > On Mon, Aug 15, 2022 at 08:35:53AM -0700, Alexei Starovoitov wrote:
> > > > > On Mon, Aug 15, 2022 at 8:28 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > > > >
> > > > > > On Mon, Aug 15, 2022 at 08:17:42AM -0700, Alexei Starovoitov wrote:
> > > > > > > It's hiding a fake function from ftrace, since it's not a function
> > > > > > > and ftrace infra shouldn't show it tracing logs.
> > > > > > > In other words it's a _notrace_ function with nop5.
> > > > > >
> > > > > > Then make it a notrace function with a nop5 in it. That isn't hard.
> > > > >
> > > > > That's exactly what we're trying to do.
> > > >
> > > > All the while claiming ftrace is broken while it is not.
> > > >
> > > > > Jiri's patch is one way to achieve that.
> > > >
> > > > Fairly horrible way.
> > > >
> > > > > What is your suggestion?
> > > >
> > > > Mailed it already.
> > > >
> > > > > Move it from C to asm ?
> > > >
> > > > Would be much better than proposed IMO.
> > >
> > > nice, that would be independent of the compiler atributes
> > > and config checking..  will check on this one ;-)
> >
> > how about something like below?
> >
> > dispatcher code is generated only for x86_64, so that will be covered
> > by the assembly version (free of ftrace table) other archs stay same
> >
> > jirka
> >
> >
> > ----
> > diff --git a/arch/x86/net/Makefile b/arch/x86/net/Makefile
> > index 383c87300b0d..94964002eaae 100644
> > --- a/arch/x86/net/Makefile
> > +++ b/arch/x86/net/Makefile
> > @@ -7,4 +7,5 @@ ifeq ($(CONFIG_X86_32),y)
> >          obj-$(CONFIG_BPF_JIT) += bpf_jit_comp32.o
> >  else
> >          obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o
> > +        obj-$(CONFIG_BPF_JIT) += bpf_dispatcher.o
> >  endif
> > diff --git a/arch/x86/net/bpf_dispatcher.S b/arch/x86/net/bpf_dispatcher.S
> > new file mode 100644
> > index 000000000000..65790a1286e8
> > --- /dev/null
> > +++ b/arch/x86/net/bpf_dispatcher.S
> > @@ -0,0 +1,10 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#include <linux/linkage.h>
> > +#include <asm/nops.h>
> > +#include <asm/nospec-branch.h>
> > +
> > +       .text
> > +SYM_FUNC_START(bpf_dispatcher_xdp_func)
> > +       ASM_NOP5
> > +       JMP_NOSPEC rdx
> > +SYM_FUNC_END(bpf_dispatcher_xdp_func)
> 
> Wait. Why asm ? Did you try Peter's suggestion:
> __attribute__((__no_instrument_function__))
> __attribute__((patchable_function_entry(5)))

ah so this suggestion came in the other thread after the asm one.. ok, will check

jirka
