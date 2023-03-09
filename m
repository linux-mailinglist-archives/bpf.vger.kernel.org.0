Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900706B2CFC
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 19:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCIShD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 13:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjCIShC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 13:37:02 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B81FCF38
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 10:36:37 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id p13so1519632ilp.11
        for <bpf@vger.kernel.org>; Thu, 09 Mar 2023 10:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678386997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcKQIgodumKTKwDG1jrtUqE4ItB7pqN2TOLUifY1FmE=;
        b=oHCE7Zi7oj41PA0PXpYWd1Th5YT3xm7/C+YIfP9vZtzNT8wqII4suUtmKJU55/mOQs
         JgWeVZzv9E75of0Brn5qpsyshg2kuTFN3wbqOCrMRXsyvgT1DdfIy2HhngMA/wFzlJl3
         gj+jmcQKyvDYqhvf8Kj2kwzbTJoHOLXW5Rnf4KxgH4r0oLfOReZn/z1B/HKPs41I2OW5
         HX3Bcp54N8JFF26ED45MlgI7TRg3pACj/DXEhOLO266n1YFDgGaJbDhaij2zeRG8yYZk
         kqJu+NU9DXtmTZKv3iWmpObzYixTGDpCwtdF9aKSNpP3pzCYaoL64cTDe0lNJw/Ak5m1
         XNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678386997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JcKQIgodumKTKwDG1jrtUqE4ItB7pqN2TOLUifY1FmE=;
        b=doX3ud8z/IfpmN6GJyPD1jH8PCKfLIiDmIIA+jwFy9bCFHkXU7d8OCuvjAT8v8OIHF
         RaB8IXRMbZ/J1j3YfyaIaQUve5sGGo/nt3M9J1IUXSHanrSPuOMrk8hxvracT+482OyD
         wKW+Vru4rwaD42Dsho06qurtSJoC1enfhsseeHZn9wye2aocJnQK2Jy1pYnIhiEYYJyW
         D/5CD8HE8ZGPCRBspeSc7kplPU/z4UuRENVd/XqEUdEcDmUXqSYuBjgnNXjqryDxVuQh
         MzFb30ubqDm6UcqBhkdDySMQJH2ikmQ7X+KRImY7BUlZidnlH2hJfvigCY9ofQWZvdKo
         +FYA==
X-Gm-Message-State: AO0yUKXlv86moknz+VJ7qpJNHbp3t5y9p0/6WnmV8trNpt9OtXq4bDBu
        KrDlzEmTNEVbpe5BiTSbMn4NcXDsUJt5lwfibOo=
X-Google-Smtp-Source: AK7set+7cZih+NAUm1X7yFKE+xKAqCqip6/1HLu8kYd/ONI8gZe06ZiLjxQiWExDwF2QFfCByK8W5dpTpbzvLB4Df2Q=
X-Received: by 2002:a05:6e02:928:b0:317:fc57:d2f7 with SMTP id
 o8-20020a056e02092800b00317fc57d2f7mr10565491ilt.6.1678386996855; Thu, 09 Mar
 2023 10:36:36 -0800 (PST)
MIME-Version: 1.0
References: <CAO658oXX+_7FnAsv02x27FQRbm_Dw7d=tOmQ_Gfe=fB5Hv+C+g@mail.gmail.com>
 <CAEf4BzZDv8hUD=_KYXNAO+EQMqHjqgEWurOcNF_huwX+CvmHXA@mail.gmail.com>
 <CAO658oVAMKPZT0cbAUmB82nXrj1StyawEJFSLPbWi8ZPtrVY+Q@mail.gmail.com> <fc8de596-aa8c-a92b-a288-d2bba2e08ff7@meta.com>
In-Reply-To: <fc8de596-aa8c-a92b-a288-d2bba2e08ff7@meta.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Thu, 9 Mar 2023 13:36:26 -0500
Message-ID: <CAO658oXvAN12PFQhAQR2UXs78K-1vF3tAefd6-ToEzzQucNM=Q@mail.gmail.com>
Subject: Re: [Question] How can I get floating point registers on arm64
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
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

On Wed, Mar 8, 2023 at 10:54=E2=80=AFPM Dave Marchevsky <davemarchevsky@met=
a.com> wrote:
>
> On 3/8/23 9:20 AM, Grant Seltzer Richman wrote:
> > On Tue, Mar 7, 2023 at 7:28=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Thu, Mar 2, 2023 at 11:06=E2=80=AFAM Grant Seltzer Richman
> >> <grantseltzer@gmail.com> wrote:
> >>>
> >>> Hi everyone,
> >>>
> >>> I'm writing a uprobe program that I'm attaching to a function in a go
> >>> program on arm64. The function takes a float and as such loads the
> >>> parameters via 64-bit floating point registers i.e. `D0`.
> >>>
> >>> However, the struct pt_regs context that uprobe programs have access
> >>> to only has a single set of 31 64-bit registers. These appear to be
> >>> the regular general purpose integer registers. My question is - how d=
o
> >>> I access the second set of registers? If this question doesn't make
> >>> sense, am I misunderstanding how arm64 works?
> >>>
> >>
> >> cc'ing Dave, as he was looking at this problem in the past (in the
> >> context of accessing xmm registers, but similar problem).
> >>
> >> The conclusion was that we'd need to add a new helper (kfunc nowadays)
> >> that would do it for BPF program. Few things to consider:
> >>
> >>   - designing generic enough interface to allow reading various
> >> families of registers (FPU, XMM, etc) in some generic way
> >>   - consider whether do platform-specific or platform-agnostic
> >> interface (both possible)
> >>   - and most annoyingly, we'd need to handle kernel potentially
> >> modifying FPU state without (yet) restoring it. Dave investigated
> >> this, and in some recent kernels it seems like kernel code doesn't
> >> necessarily restore FPU state right after it's done with it, and
> >> rather sets some special flag to restore FPU state as kernel exits to
> >> user-space.
> >
> > Thanks for this info Andrii! I think your first couple points are
> > manageable but I'm not familiar with FPU context switching. Will read
> > up on it, and Dave if you're willing to give some guidance I'd happily
> > put in the work to get this helper introduced!
> >
>
> Hi Grant,
>
> I attempted to tackle this in a patchset a while back [0]. Had to abandon=
 it to
> focus on other things, please feel free to use it as a starting point.
>
> Happy to elaborate on Andrii's 3rd point above, there's definitely some n=
uance
> there that the series may not explain well. But need a day or so to page =
it back
> in :). Will update this thread with details.

Thanks Dave! I'm going to spend time over the new few days
familiarizing myself with this code and will certainly follow up with
questions. I see this patchset seems to specifically tackle x86 for
now, I'm hoping to additionally get arm64 support as that's the
priority for the project I work on.

>   [0]: https://lore.kernel.org/bpf/20220512074321.2090073-1-davemarchevsk=
y@fb.com/
>
> >>
> >> Hopefully Dave can correct me and fill in details.
> >>
> >>
> >>> Thanks so much,
> >>> Grant
