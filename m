Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF875573C45
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 19:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiGMR5q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 13:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiGMR5p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 13:57:45 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD8627159
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 10:57:43 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id os14so21217201ejb.4
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 10:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I8K0Ou8Tmr/gg2GFMNCmJXcQvjY1pDnYLB7ua9J9AAQ=;
        b=SIJsQTJzLxku3FPI4+xfj03Y1jW6JZzaQUilVPXTojBJ6dGQVyG3ZJbbJXWJQFMSK1
         lWxHDzrmjLh0zUiZ70z4/FCARWw0tP4adNJ/+Y2Qe7DTyjm9Jj+1krfelBrtG3NKW1Rq
         SE4kqIk551OYn/MuHAu/6mwAH119K2wToNM9exNIh4ecBFmHO5eXdoW0js3Nm9Z7hNAV
         +jToPpBCI/l2VBKFC/W26n9OKLpHvqSPLlApAylhOKRlr52WhOg9UA3J9TCL/Qm1BKGY
         mGjr3PGP+vruac3Tb8SqF2wOg3WdJhJzdCRwV/WHieMQo5/IdSMZtEOva4NenQAEbxLj
         /zKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I8K0Ou8Tmr/gg2GFMNCmJXcQvjY1pDnYLB7ua9J9AAQ=;
        b=wM7dIvZBfAqvGHNz6ZbSNlti7jQ3Pvt1irrwXnKRR0kDE9peOh658e8qUXxmX/RA6l
         nNs8yDf+DcoidFJ3cWyPA1OQFUAsdtcmpsH8DVE64RyVzoa2K42fziwtlRzbIX9LtAKY
         vLhvWSME7Wk29sgfJkqCErnuIRtNSKEc8eAkZrUskIWXHTtEOJEiMpehq6w9mUmi4PUn
         NEPH5JIvykXuwTXopeo0zSFUOUwaHFytNMjK83ugS8ANCGaErk4V6ya/abMTYHcZc8WJ
         wpECwrwvmKaYfiEKYo6q5etsdBJppGGIgMFUC/z2LJ/bS0USTu9MvIi3sH5877MfTDAx
         3qbw==
X-Gm-Message-State: AJIora8RZoPYnH0FTOcXdAAOP9PiWw8FnWDp9IKv4mZgf+LzWUtMbfs9
        PzD8yy80k12x9khcf0SPY9eO1ZdDwTROdNymnxo=
X-Google-Smtp-Source: AGRyM1skZPsg4kBGolHkcKnQ40oSrXcQJxCbmco2iBTclNb1Wyt2/CQPeAbPArwuYJbM/xYsrp1aF42gudVCDYhFKFE=
X-Received: by 2002:a17:907:2808:b0:72b:4d49:b2e9 with SMTP id
 eb8-20020a170907280800b0072b4d49b2e9mr4908594ejc.176.1657735062240; Wed, 13
 Jul 2022 10:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220713015304.3375777-1-andrii@kernel.org> <20220713015304.3375777-6-andrii@kernel.org>
 <Ys7y5vCoSgiMW/p8@google.com>
In-Reply-To: <Ys7y5vCoSgiMW/p8@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 13 Jul 2022 10:57:30 -0700
Message-ID: <CAEf4BzZsEcz+NroDFh+sEu_4wrgsJYPMjhuZS8FBuzkXC77jcg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: use BPF_KSYSCALL and
 SEC("ksyscall") in selftests
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Wed, Jul 13, 2022 at 9:29 AM <sdf@google.com> wrote:
>
> On 07/12, Andrii Nakryiko wrote:
> > Convert few selftest that used plain SEC("kprobe") with arch-specific
> > syscall wrapper prefix to ksyscall/kretsyscall and corresponding
> > BPF_KSYSCALL macro. test_probe_user.c is especially benefiting from this
> > simplification.
>
> That looks super nice! I'm assuming the goal is probably

Thanks!

> to get rid of that SYS_PREFIX everywhere eventually? And have a simple
> test that exercises fentry/etc parsing?

All the other uses of SYS_PREFIX in selftests right now are
fentry/fexit. If the consensus is that this sort of higher-level
wrapper around fentry/fexit specifically for syscalls is useful, it's
not a lot of work to add something like SEC("fsyscall") and
SEC("fretsyscall") with the same approach.

One possible argument against this (and I need to double check my
assumptions first), is that with SYSCALL_WRAPPER used (which is true
for "major" platforms like x86_64), fentry doesn't provide much
benefit because __<arch>_sys_<syscall>() function will have only one
typed argument - struct pt_regs, and so we'll have to use
BPF_CORE_READ() to fetch actual arguments, at which point BPF verifier
will lose track of type information. So it's just a slightly more
performant (in terms of invocation overhead) kprobe at that point, but
with no added benefit of BTF types for input arguments.

But curious to hear what others think about this.

>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >   .../selftests/bpf/progs/bpf_syscall_macro.c   |  6 ++---
> >   .../selftests/bpf/progs/test_attach_probe.c   | 15 +++++------
> >   .../selftests/bpf/progs/test_probe_user.c     | 27 +++++--------------
> >   3 files changed, 16 insertions(+), 32 deletions(-)
>

[...]
