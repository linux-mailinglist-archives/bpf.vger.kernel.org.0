Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321406B0AE7
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 15:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjCHOUe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 09:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjCHOUd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 09:20:33 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552B092BD5
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 06:20:32 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id bf15so6819167iob.7
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 06:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678285231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+ovKJCH7uz5MCcnSs/iyabzV+RgojGJERwYamB6eyI=;
        b=qTHLanDMMas9m0COpJnJCZN0pnWol/gGx4gjYJEaFdD+4CNDiR9BamK7uZqOhms9Dc
         NjSUV51hN7fOHA56gfHeoijLs9OGSkPFjEfjB3+/4tD3wCObWYIJs9bk3IlQTsZtkZgM
         uzyYeGim8tZceUwgxjitzVlUMU/OC9BuBDvsV4JKtzAnT/b9U68cDY3DSb4es8GW1oRa
         fP60tJyZ+gpRv2OpG99JLZPiKSrYT8NUESLHQdjtXqd4VuBB0e6A3CBk2xga5WDRAWSa
         LGjDAlLvVFtjKJwiRH2C91li1c05JQPgw6ZkZSevdzTq3KBUNxi1U4JB5Ddi+2pDB+S5
         S6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678285231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+ovKJCH7uz5MCcnSs/iyabzV+RgojGJERwYamB6eyI=;
        b=btp6+qE/oEdgt2uUnH2t2UDgw2BK8COXK1kQqsrZdRtwyAFO7ZYYweFA9aZjFVszc3
         sLiW+pBisD8wA/mv1HvW3mKInd17sA7dJmSLMRa/MlQyq+94hN0orSoxttpMsud+MhrP
         vFiUIT1GlHmqc9Iih7zV8Ssb3mm5K+pAOvu4f9j5JO0jHVuWpxZYFWhdUO2tjRS0oNir
         zNEfJWU67pn4j8x7m5T16JLKQP3Ny4sbo+eN7zIGYI5z94zIRNnaWN6XKzERrcRnjL94
         yvoTfjiqsdK4SKS7iU2izBrRBThXboBagguDrQIrtS5n8LOsgBYkr8TWT46tCFAmvWHd
         x0nA==
X-Gm-Message-State: AO0yUKXlwCjTIkL6Avb+eHIx0NP1MgtGK8JKkTCzeMAlbW2wKgKwa6Ho
        nLi53/yjBI7NdcZIe7c2Q5uw53m3I4FGSYZnC00=
X-Google-Smtp-Source: AK7set/P4DF08AtOrwMO6kGvxwlhOWAInzzjsngAxhh2Oozb44zWLACx6ILU6J91NDAtPFP29rgBicWHIbGCfsV6Fuc=
X-Received: by 2002:a02:6386:0:b0:3c5:139d:609b with SMTP id
 j128-20020a026386000000b003c5139d609bmr9000773jac.1.1678285231635; Wed, 08
 Mar 2023 06:20:31 -0800 (PST)
MIME-Version: 1.0
References: <CAO658oXX+_7FnAsv02x27FQRbm_Dw7d=tOmQ_Gfe=fB5Hv+C+g@mail.gmail.com>
 <CAEf4BzZDv8hUD=_KYXNAO+EQMqHjqgEWurOcNF_huwX+CvmHXA@mail.gmail.com>
In-Reply-To: <CAEf4BzZDv8hUD=_KYXNAO+EQMqHjqgEWurOcNF_huwX+CvmHXA@mail.gmail.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Wed, 8 Mar 2023 09:20:20 -0500
Message-ID: <CAO658oVAMKPZT0cbAUmB82nXrj1StyawEJFSLPbWi8ZPtrVY+Q@mail.gmail.com>
Subject: Re: [Question] How can I get floating point registers on arm64
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@meta.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 7, 2023 at 7:28=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Mar 2, 2023 at 11:06=E2=80=AFAM Grant Seltzer Richman
> <grantseltzer@gmail.com> wrote:
> >
> > Hi everyone,
> >
> > I'm writing a uprobe program that I'm attaching to a function in a go
> > program on arm64. The function takes a float and as such loads the
> > parameters via 64-bit floating point registers i.e. `D0`.
> >
> > However, the struct pt_regs context that uprobe programs have access
> > to only has a single set of 31 64-bit registers. These appear to be
> > the regular general purpose integer registers. My question is - how do
> > I access the second set of registers? If this question doesn't make
> > sense, am I misunderstanding how arm64 works?
> >
>
> cc'ing Dave, as he was looking at this problem in the past (in the
> context of accessing xmm registers, but similar problem).
>
> The conclusion was that we'd need to add a new helper (kfunc nowadays)
> that would do it for BPF program. Few things to consider:
>
>   - designing generic enough interface to allow reading various
> families of registers (FPU, XMM, etc) in some generic way
>   - consider whether do platform-specific or platform-agnostic
> interface (both possible)
>   - and most annoyingly, we'd need to handle kernel potentially
> modifying FPU state without (yet) restoring it. Dave investigated
> this, and in some recent kernels it seems like kernel code doesn't
> necessarily restore FPU state right after it's done with it, and
> rather sets some special flag to restore FPU state as kernel exits to
> user-space.

Thanks for this info Andrii! I think your first couple points are
manageable but I'm not familiar with FPU context switching. Will read
up on it, and Dave if you're willing to give some guidance I'd happily
put in the work to get this helper introduced!

>
> Hopefully Dave can correct me and fill in details.
>
>
> > Thanks so much,
> > Grant
