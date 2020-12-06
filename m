Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE7C2D0730
	for <lists+bpf@lfdr.de>; Sun,  6 Dec 2020 21:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgLFU51 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Dec 2020 15:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgLFU50 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Dec 2020 15:57:26 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63D8C0613D0
        for <bpf@vger.kernel.org>; Sun,  6 Dec 2020 12:56:46 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id y5so11411444iow.5
        for <bpf@vger.kernel.org>; Sun, 06 Dec 2020 12:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DPu/dtmUkocxsfOQNvHscUxEnhaoWVewWqxI3lBHv7g=;
        b=OfTNcqyiLL8NP9ptJ/YR74icEHAuo+wpCaFEza36nv5g3/xgTXFPk/mFe8CeOI4QyB
         0jtjxXADSWz9Y1a7yDdTfCTCui5Czh8XwbZ6DlDYvhH84KE7mVZ41Nn+WGFTolyoBBEK
         fhmcOgQia+vnNTW/AdDtTPxUhGxOzOgRQ3LHD0Kqx86feFvVH1KiTLKChZC4wVdSDp2S
         aNrAawGI5gb1hyyTAVJVhxRgmWvbFdt2S7O6ZIXUT5/tyUL8dlHbZgcvdpUByz8l2FBM
         p+Ga9QZtlU3KLEldLbu533kSqc2TCLRxHZBCL/YtMjOwj3Unx9zFduVaODMMoCaDQ5Ae
         g3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DPu/dtmUkocxsfOQNvHscUxEnhaoWVewWqxI3lBHv7g=;
        b=dwfsrtiYKku9lrE4gLMB8XhrJlIXkw+N1HL5e67tWorMSFBszCcwLIqYKyZh3Q7JqO
         dznqcpp5t+l0/Xwu2LwXRFnphDYqZAHoiQhELBgo2gUQWcKvAwMqNqWzts3FIvNBtSXN
         Xstq+47dQ0exK15mDCp2awXWN/DA1bkcEZZfo7vjK6vzR/TCePjRIlJnM1sU+N5HdHYo
         HLGuKObLx0aE5xfB6kthYIuR8qXsWywG2dPW70IBwUy2ll5iOCfcw2U1JXvsF7OtHBMO
         8jdupyG7SMTdP57d7tSCQroQHrBg/3hpa1Mya3wazktHC5wY3KBqSaMUOQykl4RNlLDa
         ea6w==
X-Gm-Message-State: AOAM531fezXhA/SZkhQcBErOI1xvsOxmQQwocfeRVOFN6cDn0OtAhaSo
        JUMqUMusLcdLfdW2oqhC4OBQE/uwjkSYU569bs8NIRoeTTVH9Q==
X-Google-Smtp-Source: ABdhPJycGKhP96ut8YiAqFeG8VV8RwuLwzy6tsssYbpaN2PjhszHPECcZMcYH5tSG8cMDDLq5KtML0L22skQSaF7oLM=
X-Received: by 2002:a6b:b74e:: with SMTP id h75mr11435411iof.0.1607288205276;
 Sun, 06 Dec 2020 12:56:45 -0800 (PST)
MIME-Version: 1.0
References: <CAO__=G52s_=2E4wF8wDcgc3KwMU0kzmDfBQhDD3+LMZ8M3fZ8w@mail.gmail.com>
 <CAEf4BzbKtAcO81ZvxOJwhpOKauDQ==Y+Bcvy4_QAF3FZyLbMeg@mail.gmail.com>
 <CAO__=G5ReWaSsHUmkHk53LF8nBQCU_RtVoLdi=AXMDZX1mfu4Q@mail.gmail.com> <CAEf4BzaUA9DUdJ5BNSsArrtOqV1UrUw+8eU90UzjpW9O10PJtw@mail.gmail.com>
In-Reply-To: <CAEf4BzaUA9DUdJ5BNSsArrtOqV1UrUw+8eU90UzjpW9O10PJtw@mail.gmail.com>
From:   David Marcinkovic <david.marcinkovic@sartura.hr>
Date:   Sun, 6 Dec 2020 21:56:34 +0100
Message-ID: <CAO__=G56qc10ygQFq+rMXnRUHJpwyd2r6RophWTXLR==X=yN4g@mail.gmail.com>
Subject: Re: Problem with BPF_CORE_READ macro function
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 4, 2020 at 7:01 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Dec 4, 2020 at 6:23 AM David Marcinkovic
> <david.marcinkovic@sartura.hr> wrote:
> >
> > On Thu, Dec 3, 2020 at 9:35 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Dec 3, 2020 at 4:20 AM David Marcinkovic
> > > <david.marcinkovic@sartura.hr> wrote:
> > > >
> > > > Hello everyone,
> > > >
> > > > I am trying to run a simple BPF program that hooks onto
> > > > `mac80211/drv_sta_state` tracepoint. When I run the program on the =
arm
> > > > 32 bit architecture,
> > > > the verifier rejects to load the program and outputs the following =
error
> > > > message:
> > > >
> > > > Unrecognized arg#0 type PTR
> > > > ; int tp__mac80211_drv_sta_state(struct trace_event_raw_drv_sta_sta=
te* ctx)
> > > > 0: (bf) r3 =3D r1
> > > > 1: (85) call unknown#195896080
> > > > invalid func unknown#195896080
> > > >
> > > > This error does not seem to occur on the amd64 architecture. I am
> > > > using clang version 10 for both, compiling on amd64 and
> > > > cross-compiling for arm32.
> > > >
> > > >
> > > > I have prepared a simple program that hooks onto the
> > > > `mac80211/drv_sta_state` tracepoint.
> > > > In this example, `BPF_CORE_READ` macro function seems to cause the
> > > > verifier to reject to load the program.
> > > > I've been using this macro in various different programs and it did=
n't
> > > > cause any problems.
> > > > Also, I've been using packed structs and bit fields in other progra=
ms
> > > > and they also didn't cause any problems.
> > > >
> > > > I tried to use BPF_CORE_READ_BITFIELD as stated in this patch [0] a=
nd
> > > > got a similar error.
> > > >
> > > > Any input is much appreciated,
> > > >
> > >
> > > Can you provide libbpf debug output, especially the section about
> > > CO-RE relocations? Could it be that this tracepoint is inside the
> > > kernel module?
> >
> > You're right. The problem is that this tracepoint is inside the kernel =
module.
> > I recompiled the kernel with CONFIG_MAC80211 flag set to 'y' and the
> > program loads
> > successfully.
> >
>
> Ok, just as I suspected. With [0] and [1] (and using pahole 1.19+ to
> build the kernel and modules), it should work even for modules now.
>
> [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=3D395715&=
state=3D*
> [1] https://patchwork.kernel.org/project/netdevbpf/list/?series=3D380759&=
state=3D*

Thank you for your help. We really appreciate your quick responses.

Unfortunately, we are not able to test those patches right now as we
have quite a few out of tree patches for our board.
We will definitely test them once they make their way into a stable
release or release candidate.

King regards,
David Mar=C4=8Dinkovi=C4=87

>
> > Thank you very much for your fast reply.
> >
> > >
> > > > Best regards,
> > > > David Mar=C4=8Dinkovi=C4=87
> > > >
> > > >
> > > > [0] https://lore.kernel.org/bpf/20201007202946.3684483-1-andrii@ker=
nel.org/T/#ma08db511daa0b5978f16df9f98f4ef644b83fc96
> > > >
> > > >
> > >
> > > [...]
