Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B627936DACD
	for <lists+bpf@lfdr.de>; Wed, 28 Apr 2021 17:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhD1PDo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Apr 2021 11:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbhD1PDc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Apr 2021 11:03:32 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA5AC061375
        for <bpf@vger.kernel.org>; Wed, 28 Apr 2021 07:59:53 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id s16so57774405iog.9
        for <bpf@vger.kernel.org>; Wed, 28 Apr 2021 07:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iabn/7TldLlLe4ct1XbBE3tIHi0bNFX+HoKTspy+Zd8=;
        b=W8J8yxp2ijkdH07hhcmJoTch4+ds+RpR3uJrFyC0n+ijzmDDAkR7Wa2g/1NMRtci5F
         XGfLuh8mdCRY1S3icexBaEMHztAzbCBe+wx+rqRERgmLQBZGxhCp2gvvUlj8IFXHI0Iy
         TwtKi5pO89ycJaUT+bcI/pkLkI/z/p05oaD3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iabn/7TldLlLe4ct1XbBE3tIHi0bNFX+HoKTspy+Zd8=;
        b=VdBpCVYfWjBx7Uc2XZCzOnLJADxh9DABXo5MintdKy4COV1tBomteBuuBTE+rIH54m
         DcHUrlkQ7UQyS8Ha5/1VFWYe04UayTXAE4m4gAzr8b3jcwS0a0vrMrcz8eqWpaEL0vF3
         rrhkjT1CHBVvRnRr2CsDi6tUe7CgF2J/Z17Mlxq9hm7WFCe9wzzSB1U2KMuutLuZ+L6s
         d0KRZJL9Dok1xifooyO50KIhtLIB0/omj6z6Jhgno6gqHIVI8pB8t1rCkFvErI8UDBLH
         frNlYT/8wOI39I0x0mdKbJn9O0YBIpYbQIIyyjno1O7atsKBxK/VP/kMZkxBq7C2wQPu
         RE/A==
X-Gm-Message-State: AOAM5310KnoYBhiuni6kn4+O0/ZZ1LIdCqf+06DYWQ7B6U+Aipm2ErcT
        kUjTwh44omo1GDMwrjxQfO3VJeAYTBKb4gzTGcskGg==
X-Google-Smtp-Source: ABdhPJw7OhNOQmqPMxNZRZjEipI1SzvGVR7FqSWDt4x1WF2C2QZ9V9DVTVNQUH8IVON5Fb672kMK94cmky6MFHihP6A=
X-Received: by 2002:a05:6638:2515:: with SMTP id v21mr27686360jat.110.1619621993352;
 Wed, 28 Apr 2021 07:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210419155243.1632274-1-revest@chromium.org> <20210419155243.1632274-7-revest@chromium.org>
 <CAEf4BzZUM4hb9owhompwARabRvRbCYxBrpgXSdXM8RRm42tU1A@mail.gmail.com>
 <CABRcYm+=XSt_U-19eYXU8+XwDUXoBGQMROMbm6xk9P9OHnUW_A@mail.gmail.com>
 <CAEf4BzZnkYDAm2R+5R9u4YEdZLj=C8XQmpT=iS6Qv0Ne7cRBGw@mail.gmail.com>
 <CABRcYmLn2S2g-QTezy8qECsU2QNSQ6wyjhuaHpuM9dzq97mZ7g@mail.gmail.com>
 <2db39f1c-cedd-b9e7-2a15-aef203f068eb@rasmusvillemoes.dk> <CABRcYmJdTZAhdD_2OVAu-hOnYX-bgvrrbnUjaV23tzp-c+9_8w@mail.gmail.com>
 <CAEf4BzaHqvxuosYP32WLSs_wxeJ9FfR2wGRKqsocXHCJUXVycw@mail.gmail.com>
In-Reply-To: <CAEf4BzaHqvxuosYP32WLSs_wxeJ9FfR2wGRKqsocXHCJUXVycw@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 28 Apr 2021 16:59:42 +0200
Message-ID: <CABRcYm+pO94dFW83SZCtKQE8x6PkRicr+exGD3CNwGwQUYmFcw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 6/6] selftests/bpf: Add a series of tests for bpf_snprintf
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 27, 2021 at 8:03 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Apr 27, 2021 at 2:51 AM Florent Revest <revest@chromium.org> wrote:
> >
> > On Tue, Apr 27, 2021 at 8:35 AM Rasmus Villemoes
> > <linux@rasmusvillemoes.dk> wrote:
> > >         u64 args[MAX_TRACE_PRINTK_VARARGS] = { arg1, arg2, arg3 };
> > > -       enum bpf_printf_mod_type mod[MAX_TRACE_PRINTK_VARARGS];
> > > +       u32 *bin_args;
> > >         static char buf[BPF_TRACE_PRINTK_SIZE];
> > >         unsigned long flags;
> > >         int ret;
> > >
> > > -       ret = bpf_printf_prepare(fmt, fmt_size, args, args, mod,
> > > -                                MAX_TRACE_PRINTK_VARARGS);
> > > +       ret = bpf_bprintf_prepare(fmt, fmt_size, args, &bin_args,
> > > +                                 MAX_TRACE_PRINTK_VARARGS);
> > >         if (ret < 0)
> > >                 return ret;
> > >
> > > -       ret = snprintf(buf, sizeof(buf), fmt, BPF_CAST_FMT_ARG(0, args, mod),
> > > -               BPF_CAST_FMT_ARG(1, args, mod), BPF_CAST_FMT_ARG(2, args, mod));
> > > -       /* snprintf() will not append null for zero-length strings */
> > > -       if (ret == 0)
> > > -               buf[0] = '\0';
> > > +       ret = bstr_printf(buf, sizeof(buf), fmt, bin_args);
> > >
> > >         raw_spin_lock_irqsave(&trace_printk_lock, flags);
> > >         trace_bpf_trace_printk(buf);
> > >         raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
> > >
> > > Why isn't the write to buf[] protected by that spinlock? Or put another
> > > way, what protects buf[] from concurrent writes?
> >
> > You're right, that is a bug, I missed that buf was static and thought
> > it was just on the stack. That snprintf call should be after the
> > raw_spin_lock_irqsave. I'll send a patch. Thank you Rasmus. (before my
> > snprintf series, there was a vsprintf after the raw_spin_lock_irqsave)

Solved now

> Can you please also clean up unnecessary ()s you added in at least a
> few places. Thanks.

Alexei said he took care of this .:)

> > > Probably the test cases are not run in parallel, but this is the kind of
> > > thing that would give those symptoms.
> >
> > I think it's a separate issue from what Andrii reported though because
> > the flaky test exercises the bpf_snprintf helper and this buf spinlock
> > bug you just found only affects the bpf_trace_printk helper.
> >
> > That being said, it does smell a little bit like a concurrency issue
> > too, indeed. The bpf_snprintf test program is a raw_tp/sys_enter so it
> > attaches to all syscall entries and most likely gets executed many
> > more times than necessary and probably on parallel CPUs. The "pad_out"
> > buffer they write to is unique and not locked so maybe the test's
> > userspace reads pad_out while another CPU is writing on it and if the
> > string output goes through a stage where it is "    4 0000" before
> > being "    4 000", we might read at the wrong time. That being said, I
> > would find it weird that this happens as much as 50% of the time and
> > always specifically on that test case.
> >
> > Andrii could you maybe try changing the prog type to
> > "tp/syscalls/sys_enter_nanosleep" on the machine where you can
> > reproduce this bug ?
>
> Yes, it helps. I can't repro it easily anymore.

Good, so it does sound like a concurrency issue indeed

> I think the right fix, though, should be to filter by tid, not change the tracepoint.

Agreed, I'll send a patch for that today. :)

> I think what's happening is we see the string right before bstr_printf
> does zero-termination with end[-1] = '\0'; So in some cases we see
> truncated string, in others we see untruncated one.

Makes sense but I still wonder why it happens so often (50% of the
time is really a lot) and why it is consistently that one test case
that fails and not the "overflow" case for example. But I'm confident
that this is not a bug in the helper now and that the tid filter will
fix the test.
