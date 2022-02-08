Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B364AE560
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 00:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbiBHXWE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 18:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbiBHXWD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 18:22:03 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8060DC061576
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 15:22:02 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id e8so279446ilm.13
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 15:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=91qHH3A5GBUS5M5/qV7EKMavnXdhSlR2loZf9kWvy8k=;
        b=TVGWe/l3Rdc+OCOI7zJ1+Fc2OIPljK36Qz6vbkhTmYpSxWQ2EU+qs9GYTvsjbHGsNs
         GsQBVn6IaC8uTmcGCSeS7SasSPGotxUm/lLfRcGbzS1Qo9Yv+5n4kHagWW+2k0D0XZRk
         x8/TFujfhnGzxDj7HXcBYAzrMwXX/0ZODgcQLCD2BaTCXpoWX0lnFGofE3G6dT357LcV
         TfMLAB6a02htQ3rCX6LWKwvMaIHrpZ9WGbWkKorX36NRMKCLhVj71aW5NYeeV9KnUewJ
         vZZOgY+A/9F3ExQmoBrrMUu8tK3IDKr8Wdv9WRFQVsxGbdy75+f6YXt5K1EMYD/36i8q
         pEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=91qHH3A5GBUS5M5/qV7EKMavnXdhSlR2loZf9kWvy8k=;
        b=2MtpekDuxB+rosfPUP0aev8j7lwNCbWlKlbHUQgMzGBmO47pMO9MTcMph7svhOXWQq
         8lCuIamXod1Tc9fsUUXgyI9tSvgF+a8cjDoZexJ/nyBWoFuZ3aC24EESjVnaCALls/ny
         HN73Z29ibWaAE3Yy6h2gwvpuK3Como8h6U2jHrfTaXeloiy70V28YmavrmjAOZiVpJ4Z
         l3T/J0RtwUrKWSPPL7VNGZ1iwbeEz5fi9zIZfk7Y3HBcvFyMiDkrJPxrJZnN856N7etM
         6tHU00NVb6c13VEMzMMyioTX6TJOW4aP7C11rPh/LmpQrOyJZGTVsUtk5csJPwgr3XPV
         olXw==
X-Gm-Message-State: AOAM5314aRP3cwTOPETB2sz4MJEpk4soUPtzn67e3YVOF0Zx48sQuyWM
        HzyItxElMQtGIwjET6DOR0005n96A7Dz5dqVDfk=
X-Google-Smtp-Source: ABdhPJzXyq5AsZwzRmspSi2Il6ncahqXgNS2pBlYxhIwTU+BXS2i5HmkW837Z0Mp3U1dV6uwSMTcIU3loL1jop4av1c=
X-Received: by 2002:a05:6e02:1b81:: with SMTP id h1mr3484560ili.239.1644362521920;
 Tue, 08 Feb 2022 15:22:01 -0800 (PST)
MIME-Version: 1.0
References: <20220208051635.2160304-1-iii@linux.ibm.com> <20220208051635.2160304-6-iii@linux.ibm.com>
 <CAEf4BzZCYa-wz5B7pwvo6R84vs70YFxJddSvA_FwCGDnUrHXFg@mail.gmail.com> <566fdad05cb0176b7dfcffb6d99c59567db91c8e.camel@linux.ibm.com>
In-Reply-To: <566fdad05cb0176b7dfcffb6d99c59567db91c8e.camel@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Feb 2022 15:21:50 -0800
Message-ID: <CAEf4BzYjWdp7JA2DY--GQ_miQTnyuAA1XspovvuE+Ui5fAFNxQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 05/14] libbpf: Generalize overriding syscall
 parameter access macros
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>, bpf <bpf@vger.kernel.org>
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

On Tue, Feb 8, 2022 at 3:09 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Tue, 2022-02-08 at 14:05 -0800, Andrii Nakryiko wrote:
> > On Mon, Feb 7, 2022 at 9:16 PM Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > >
> > > Instead of conditionally overriding PT_REGS_PARM4_SYSCALL, provide
> > > default fallbacks for all __PT_PARMn_REG_SYSCALL macros, so that
> > > architectures can simply override a specific syscall parameter
> > > macro.
> > > Also allow completely overriding PT_REGS_PARM1_SYSCALL for
> > > non-trivial access sequences.
> > >
> > > Co-developed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > ---
> > >  tools/lib/bpf/bpf_tracing.h | 48 +++++++++++++++++++++++++--------
> > > ----
> > >  1 file changed, 33 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/tools/lib/bpf/bpf_tracing.h
> > > b/tools/lib/bpf/bpf_tracing.h
> > > index da7e8d5c939c..82f1e935d549 100644
> > > --- a/tools/lib/bpf/bpf_tracing.h
> > > +++ b/tools/lib/bpf/bpf_tracing.h
> > > @@ -265,25 +265,43 @@ struct pt_regs;
> > >
> > >  #endif
> > >
> > > -#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1(x)
> > > -#define PT_REGS_PARM2_SYSCALL(x) PT_REGS_PARM2(x)
> > > -#define PT_REGS_PARM3_SYSCALL(x) PT_REGS_PARM3(x)
> > > -#ifdef __PT_PARM4_REG_SYSCALL
> > > +#ifndef __PT_PARM1_REG_SYSCALL
> > > +#define __PT_PARM1_REG_SYSCALL __PT_PARM1_REG
> > > +#endif
> > > +#ifndef __PT_PARM2_REG_SYSCALL
> > > +#define __PT_PARM2_REG_SYSCALL __PT_PARM2_REG
> > > +#endif
> > > +#ifndef __PT_PARM3_REG_SYSCALL
> > > +#define __PT_PARM3_REG_SYSCALL __PT_PARM3_REG
> > > +#endif
> > > +#ifndef __PT_PARM4_REG_SYSCALL
> > > +#define __PT_PARM4_REG_SYSCALL __PT_PARM4_REG
> > > +#endif
> > > +#ifndef __PT_PARM5_REG_SYSCALL
> > > +#define __PT_PARM5_REG_SYSCALL __PT_PARM5_REG
> > > +#endif
> > > +
> > > +#ifndef PT_REGS_PARM1_SYSCALL
> > > +#define PT_REGS_PARM1_SYSCALL(x) (__PT_REGS_CAST(x)-
> > > >__PT_PARM1_REG_SYSCALL)
> > > +#endif
> > > +#ifndef PT_REGS_PARM2_SYSCALL
> > > +#define PT_REGS_PARM2_SYSCALL(x) (__PT_REGS_CAST(x)-
> > > >__PT_PARM2_REG_SYSCALL)
> > > +#endif
> > > +#ifndef PT_REGS_PARM3_SYSCALL
> > > +#define PT_REGS_PARM3_SYSCALL(x) (__PT_REGS_CAST(x)-
> > > >__PT_PARM3_REG_SYSCALL)
> > > +#endif
> > > +#ifndef PT_REGS_PARM4_SYSCALL
> > >  #define PT_REGS_PARM4_SYSCALL(x) (__PT_REGS_CAST(x)-
> > > >__PT_PARM4_REG_SYSCALL)
> > > -#else /* __PT_PARM4_REG_SYSCALL */
> > > -#define PT_REGS_PARM4_SYSCALL(x) PT_REGS_PARM4(x)
> > >  #endif
> > > -#define PT_REGS_PARM5_SYSCALL(x) PT_REGS_PARM5(x)
> > > +#ifndef PT_REGS_PARM5_SYSCALL
> > > +#define PT_REGS_PARM5_SYSCALL(x) (__PT_REGS_CAST(x)-
> > > >__PT_PARM5_REG_SYSCALL)
> > > +#endif
> > >
> > > -#define PT_REGS_PARM1_CORE_SYSCALL(x) PT_REGS_PARM1_CORE(x)
> > > -#define PT_REGS_PARM2_CORE_SYSCALL(x) PT_REGS_PARM2_CORE(x)
> > > -#define PT_REGS_PARM3_CORE_SYSCALL(x) PT_REGS_PARM3_CORE(x)
> > > -#ifdef __PT_PARM4_REG_SYSCALL
> > > +#define PT_REGS_PARM1_CORE_SYSCALL(x)
> > > BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM1_REG_SYSCALL)
> > > +#define PT_REGS_PARM2_CORE_SYSCALL(x)
> > > BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM2_REG_SYSCALL)
> > > +#define PT_REGS_PARM3_CORE_SYSCALL(x)
> > > BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM3_REG_SYSCALL)
> > >  #define PT_REGS_PARM4_CORE_SYSCALL(x)
> > > BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM4_REG_SYSCALL)
> > > -#else /* __PT_PARM4_REG_SYSCALL */
> > > -#define PT_REGS_PARM4_CORE_SYSCALL(x) PT_REGS_PARM4_CORE(x)
> > > -#endif
> > > -#define PT_REGS_PARM5_CORE_SYSCALL(x) PT_REGS_PARM5_CORE(x)
> > > +#define PT_REGS_PARM5_CORE_SYSCALL(x)
> > > BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM5_REG_SYSCALL)
> > >
> >
> > No, please don't do it. It makes CORE variants too rigid. We agreed
> > w/
> > Naveen that the way you did it in v2 is better and more flexible and
> > in v3 you did it the other way. Why?
>
> As far as I remember we didn't discuss this proposal from Naveen [1] -
> there was another one about moving SYS_PREFIX to libbpf, where
> we agreed that it would have bad consequences.

Alright, I guess I never submitted my opposition to what Naveen
proposed. But I did land the v3 version of that patch, didn't I? Why
change something that's already accepted?

>
> Isn't this patch essentially equivalent to the one from my v3 [2],
> but with the added ability to override more things and better-looking?

No, it's not. We want to override entire PT_REGS_PARM1_CORE_SYSCALL
definition to be something like BPF_CORE_READ((struct pt_regs___s390x
*)x, orig_gpr2), while you are making  PT_REGS_PARM1_CORE_SYSCALL
definition very rigid.


> I.e.: if we define __PT_PARMn_REG_SYSCALL, then PT_REGS_PARMn_SYSCALL
> and PT_REGS_PARMn_CORE_SYSCALL use that, and __PT_PARMn_REG otherwise.
>
> [1]
> https://lore.kernel.org/bpf/1643990954.fs9q9mrdxt.naveen@linux.ibm.com/
> [2]
> https://lore.kernel.org/bpf/20220204145018.1983773-5-iii@linux.ibm.com/
>
> >
> > >  #else /* defined(bpf_target_defined) */
> > >
> > > --
> > > 2.34.1
> > >
>
