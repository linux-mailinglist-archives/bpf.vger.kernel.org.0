Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC08C375C25
	for <lists+bpf@lfdr.de>; Thu,  6 May 2021 22:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbhEFUTH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 May 2021 16:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbhEFUTF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 May 2021 16:19:05 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34017C061761
        for <bpf@vger.kernel.org>; Thu,  6 May 2021 13:18:07 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id p8so5950643iol.11
        for <bpf@vger.kernel.org>; Thu, 06 May 2021 13:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9FpP0oYJ5o5WVaMKta2Gw4ucGc3wzpzA9zy0oojQ72k=;
        b=cVRBVTdIe2G3kEyjvc30fD55v7pIgnGqkAdDAuF8SLTWZ5d6SygwRGMbmQH2+zfG59
         M+DLsIJSLgq5ec6kQZI4yAaUaE/xcdKWyxfVHH/1yKTbCTcI7TBq4YGrQFMsU2Pt4OPo
         WfsO8GItV90u8aye4WD+uDdHHD6LrTbZdY9JM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9FpP0oYJ5o5WVaMKta2Gw4ucGc3wzpzA9zy0oojQ72k=;
        b=e6QaMVh02gR9AsIE+8JYp2vdl9Co8E9Yg+zu3tRObeS339uYC272WEZHRl+UfQIOTf
         ptAzSY66GDqIq2eC9L6OY/PpSUXVWzbst2RC+pWq3V0CMOewtUin7KpfWwrwQxrU0LNA
         Dsw9l5ddt9ND/wtqcHknyjbb1y7eFG+iZxVEGcp53Rpn7IGgdP4E8QYsccf86zW1LFDz
         Y304qfUkki0uWutGapgF8QqoxSKhlL9V33jFZHwXOVN/DjsLvA3EOU7jCdwnm8bF10dZ
         ybUODark3pcS/QkE38yV9kTCfnRQIr+sm9CoUE8gv/c9CkwY9Olcuj7+bb3iFm5IKHZ3
         xQXg==
X-Gm-Message-State: AOAM53017bX8t/qk05jBo9yvxCsN84O6E4X0VMeEXH7LjAvUibPBPi8C
        Ow8aAEm1u3GN6gPrA3Sqj3Ej+s5Duk0hl5YsNJVqHw==
X-Google-Smtp-Source: ABdhPJzKCz7oLH/S1hED4I6RCK9rzyC7Lxfl8spOMc8YJw7Q1j0aHPnnOCOprQg/aFmbOnCt1XRF9dSHT4Xpoe1Bzt8=
X-Received: by 2002:a6b:dc06:: with SMTP id s6mr4938895ioc.130.1620332286076;
 Thu, 06 May 2021 13:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210505162307.2545061-1-revest@chromium.org> <CAEf4BzZiK1ncN7RzeJ-62e=itekn34VuFf7WNhUF=9OoznMP6Q@mail.gmail.com>
 <fe37ff8f-ebf0-25ec-4f3c-df3373944efa@iogearbox.net> <CAEf4BzYsAXQ1t6GUJ4f8c0qGLdnO4NLDVJLRMhAY2oaiarDd6g@mail.gmail.com>
 <CAEf4BzYqUxgj28p7e1ng_5gfebXdVdrCVyPK4bjA31O4wgppeA@mail.gmail.com>
 <CABRcYmJBxY5AQMzO2vuuhVN7hs=1h+ursEnVAXpCPJ3DrkRrUA@mail.gmail.com> <CAEf4BzY4a6R-apnS0AZsb_Mtht2N8be1HvEN9hD9aSByoD1EHQ@mail.gmail.com>
In-Reply-To: <CAEf4BzY4a6R-apnS0AZsb_Mtht2N8be1HvEN9hD9aSByoD1EHQ@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 6 May 2021 22:17:54 +0200
Message-ID: <CABRcYm+3AjHa3zO5AHSk6SbyFK6o6dLd8Fbz_sOznchWL2dumQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Don't WARN_ON_ONCE in bpf_bprintf_prepare
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        syzbot <syzbot@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 6, 2021 at 8:52 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, May 5, 2021 at 3:29 PM Florent Revest <revest@chromium.org> wrote:
> >
> > On Wed, May 5, 2021 at 10:52 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, May 5, 2021 at 1:48 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Wed, May 5, 2021 at 1:00 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> > > > >
> > > > > On 5/5/21 8:55 PM, Andrii Nakryiko wrote:
> > > > > > On Wed, May 5, 2021 at 9:23 AM Florent Revest <revest@chromium.org> wrote:
> > > > > >>
> > > > > >> The bpf_seq_printf, bpf_trace_printk and bpf_snprintf helpers share one
> > > > > >> per-cpu buffer that they use to store temporary data (arguments to
> > > > > >> bprintf). They "get" that buffer with try_get_fmt_tmp_buf and "put" it
> > > > > >> by the end of their scope with bpf_bprintf_cleanup.
> > > > > >>
> > > > > >> If one of these helpers gets called within the scope of one of these
> > > > > >> helpers, for example: a first bpf program gets called, uses
> > > > > >
> > > > > > Can we afford having few struct bpf_printf_bufs? They are just 512
> > > > > > bytes, so can we have 3-5 of them? Tracing low-level stuff isn't the
> > > > > > only situation where this can occur, right? If someone is doing
> > > > > > bpf_snprintf() and interrupt occurs and we run another BPF program, it
> > > > > > will be impossible to do bpf_snprintf() or bpf_trace_printk() from the
> > > > > > second BPF program, etc. We can't eliminate the probability, but
> > > > > > having a small stack of buffers would make the probability so
> > > > > > miniscule as to not worry about it at all.
> > > > > >
> > > > > > Good thing is that try_get_fmt_tmp_buf() abstracts all the details, so
> > > > > > the changes are minimal. Nestedness property is preserved for
> > > > > > non-sleepable BPF programs, right? If we want this to work for
> > > > > > sleepable we'd need to either: 1) disable migration or 2) instead of
> > > >
> > > > oh wait, we already disable migration for sleepable BPF progs, so it
> > > > should be good to do nestedness level only
> > >
> > > actually, migrate_disable() might not be enough. Unless it is
> > > impossible for some reason I miss, worst case it could be that two
> > > sleepable programs (A and B) can be intermixed on the same CPU: A
> > > starts&sleeps - B starts&sleeps - A continues&returns - B continues
> > > and nestedness doesn't work anymore. So something like "reserving a
> > > slot" would work better.
> >
> > Iiuc try_get_fmt_tmp_buf does preempt_enable to avoid that situation ?
> >
> > > >
> > > > > > assuming a stack of buffers, do a loop to find unused one. Should be
> > > > > > acceptable performance-wise, as it's not the fastest code anyway
> > > > > > (printf'ing in general).
> > > > > >
> > > > > > In any case, re-using the same buffer for sort-of-optional-to-work
> > > > > > bpf_trace_printk() and probably-important-to-work bpf_snprintf() is
> > > > > > suboptimal, so seems worth fixing this.
> > > > > >
> > > > > > Thoughts?
> > > > >
> > > > > Yes, agree, it would otherwise be really hard to debug. I had the same
> > > > > thought on why not allowing nesting here given users very likely expect
> > > > > these helpers to just work for all the contexts.
> > > > >
> > > > > Thanks,
> > > > > Daniel
> >
> > What would you think of just letting the helpers own these 512 bytes
> > buffers as local variables on their stacks ? Then bpf_prepare_bprintf
> > would only need to write there, there would be no acquire semantic
> > (like try_get_fmt_tmp_buf) and the stack frame would just be freed on
> > the helper return so there would be no bpf_printf_cleanup either. We
> > would also not pre-reserve static memory for all CPUs and it becomes
> > trivial to handle re-entrant helper calls.
> >
> > I inherited this per-cpu buffer from the pre-existing bpf_seq_printf
> > code but I've not been convinced of its necessity.
>
> I got the impression that extra 512 bytes on the kernel stack is quite
> a lot and that's why we have per-cpu buffers. Especially that
> bpf_trace_printk() can be called from any context, including NMI.

Ok, I understand.

What about having one buffer per helper, synchronized with a spinlock?
Actually, bpf_trace_printk already has that, not for the bprintf
arguments but for the bprintf output so this wouldn't change much to
the performance of the helpers anyway:
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/kernel/trace/bpf_trace.c?id=9d31d2338950293ec19d9b095fbaa9030899dcb4#n385

These helpers are not performance sensitive so a per-cpu stack of
buffers feels over-engineered to me (and is also complexity I feel a
bit uncomfortable with).
