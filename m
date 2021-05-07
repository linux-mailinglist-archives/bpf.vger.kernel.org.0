Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D983763FC
	for <lists+bpf@lfdr.de>; Fri,  7 May 2021 12:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbhEGKkt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 May 2021 06:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbhEGKks (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 May 2021 06:40:48 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7CDC061761
        for <bpf@vger.kernel.org>; Fri,  7 May 2021 03:39:24 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id f6so7559276iow.2
        for <bpf@vger.kernel.org>; Fri, 07 May 2021 03:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+820bBEEqqhQYCq8XGwExxSwhxuLHxIq3wsvTuPIL5o=;
        b=ZPB8NlE/FMef4Xaw1s3C6uH4LFcb50rHrXtJpOqJRc/8pFPgmHj9MiQ7/VeuQZCIu6
         gkF47/dS8JKUlJxqIfk6nAPXcV486GBACGeB+qVE98Vo3Zysz7a4sOMcv7tKS+tO8au+
         G1t/XuRGEAVqdj/IwuAUWyDHUn0nFWrRaXcYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+820bBEEqqhQYCq8XGwExxSwhxuLHxIq3wsvTuPIL5o=;
        b=maORd/ZnQgg0g34FOsuKhIe96lA3+sIMFHIWzR0sX50OwtJWCNY/f7P7jjktPHWQWl
         MOw3GkxsQMAeFkk6FpyczlHH693zYNXf7JJKobIvauKgr1e/VObICFJMehm3MxX4ojux
         9vnDseAgbwkY5oD9nDXaLB6boTteIxfTc+x0bpJGDPbDEK5rqC+NvjQhsea03Y80zxI+
         0tTI+NiMmOl42UplXEFQmqVF9HrfzohESC9potJhy7i2IeGimIkSPbioSIlwwOhkfO3L
         4GZZbFs6y6xk28HGELWOonVFYcO/qe8aSC2/z1qC22g8q/7vr/Vuj5a6ws9V8TS/vK0s
         2b9w==
X-Gm-Message-State: AOAM532Q6SxbGHMdgx0GAQ5Oa377dldlYp3e2fBBZKrcW2CbtvCCYFAV
        ctvz9kCa20qxuelTbkLV0KYSMlNKe+AnD8h4OCq3JA==
X-Google-Smtp-Source: ABdhPJxsC68RQ71unoY16kEk0t28ZWGtRUaJK9KkAIhneOywMiEv12Ya/P+uGWQ6OR29fOHLs1+66l0Ez3uUsmvCioE=
X-Received: by 2002:a05:6638:f0e:: with SMTP id h14mr8347035jas.32.1620383963958;
 Fri, 07 May 2021 03:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210505162307.2545061-1-revest@chromium.org> <CAEf4BzZiK1ncN7RzeJ-62e=itekn34VuFf7WNhUF=9OoznMP6Q@mail.gmail.com>
 <fe37ff8f-ebf0-25ec-4f3c-df3373944efa@iogearbox.net> <CAEf4BzYsAXQ1t6GUJ4f8c0qGLdnO4NLDVJLRMhAY2oaiarDd6g@mail.gmail.com>
 <CAEf4BzYqUxgj28p7e1ng_5gfebXdVdrCVyPK4bjA31O4wgppeA@mail.gmail.com>
 <CABRcYmJBxY5AQMzO2vuuhVN7hs=1h+ursEnVAXpCPJ3DrkRrUA@mail.gmail.com>
 <CAEf4BzY4a6R-apnS0AZsb_Mtht2N8be1HvEN9hD9aSByoD1EHQ@mail.gmail.com>
 <CABRcYm+3AjHa3zO5AHSk6SbyFK6o6dLd8Fbz_sOznchWL2dumQ@mail.gmail.com> <875174b0-c0f1-8a41-ef00-3f0fe0396288@iogearbox.net>
In-Reply-To: <875174b0-c0f1-8a41-ef00-3f0fe0396288@iogearbox.net>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 7 May 2021 12:39:13 +0200
Message-ID: <CABRcYmJxfgmuOPnLNCqGJpRSmYLf+v5=ZSaRL6O7QbuhjfeZiQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Don't WARN_ON_ONCE in bpf_bprintf_prepare
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
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

On Thu, May 6, 2021 at 11:38 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 5/6/21 10:17 PM, Florent Revest wrote:
> > On Thu, May 6, 2021 at 8:52 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >> On Wed, May 5, 2021 at 3:29 PM Florent Revest <revest@chromium.org> wrote:
> >>> On Wed, May 5, 2021 at 10:52 PM Andrii Nakryiko
> >>> <andrii.nakryiko@gmail.com> wrote:
> >>>> On Wed, May 5, 2021 at 1:48 PM Andrii Nakryiko
> >>>> <andrii.nakryiko@gmail.com> wrote:
> >>>>> On Wed, May 5, 2021 at 1:00 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >>>>>> On 5/5/21 8:55 PM, Andrii Nakryiko wrote:
> >>>>>>> On Wed, May 5, 2021 at 9:23 AM Florent Revest <revest@chromium.org> wrote:
> >>>>>>>>
> >>>>>>>> The bpf_seq_printf, bpf_trace_printk and bpf_snprintf helpers share one
> >>>>>>>> per-cpu buffer that they use to store temporary data (arguments to
> >>>>>>>> bprintf). They "get" that buffer with try_get_fmt_tmp_buf and "put" it
> >>>>>>>> by the end of their scope with bpf_bprintf_cleanup.
> >>>>>>>>
> >>>>>>>> If one of these helpers gets called within the scope of one of these
> >>>>>>>> helpers, for example: a first bpf program gets called, uses
> >>>>>>>
> >>>>>>> Can we afford having few struct bpf_printf_bufs? They are just 512
> >>>>>>> bytes, so can we have 3-5 of them? Tracing low-level stuff isn't the
> >>>>>>> only situation where this can occur, right? If someone is doing
> >>>>>>> bpf_snprintf() and interrupt occurs and we run another BPF program, it
> >>>>>>> will be impossible to do bpf_snprintf() or bpf_trace_printk() from the
> >>>>>>> second BPF program, etc. We can't eliminate the probability, but
> >>>>>>> having a small stack of buffers would make the probability so
> >>>>>>> miniscule as to not worry about it at all.
> >>>>>>>
> >>>>>>> Good thing is that try_get_fmt_tmp_buf() abstracts all the details, so
> >>>>>>> the changes are minimal. Nestedness property is preserved for
> >>>>>>> non-sleepable BPF programs, right? If we want this to work for
> >>>>>>> sleepable we'd need to either: 1) disable migration or 2) instead of
> >>>>>
> >>>>> oh wait, we already disable migration for sleepable BPF progs, so it
> >>>>> should be good to do nestedness level only
> >>>>
> >>>> actually, migrate_disable() might not be enough. Unless it is
> >>>> impossible for some reason I miss, worst case it could be that two
> >>>> sleepable programs (A and B) can be intermixed on the same CPU: A
> >>>> starts&sleeps - B starts&sleeps - A continues&returns - B continues
> >>>> and nestedness doesn't work anymore. So something like "reserving a
> >>>> slot" would work better.
> >>>
> >>> Iiuc try_get_fmt_tmp_buf does preempt_enable to avoid that situation ?
> >>>
> >>>>>>> assuming a stack of buffers, do a loop to find unused one. Should be
> >>>>>>> acceptable performance-wise, as it's not the fastest code anyway
> >>>>>>> (printf'ing in general).
> >>>>>>>
> >>>>>>> In any case, re-using the same buffer for sort-of-optional-to-work
> >>>>>>> bpf_trace_printk() and probably-important-to-work bpf_snprintf() is
> >>>>>>> suboptimal, so seems worth fixing this.
> >>>>>>>
> >>>>>>> Thoughts?
> >>>>>>
> >>>>>> Yes, agree, it would otherwise be really hard to debug. I had the same
> >>>>>> thought on why not allowing nesting here given users very likely expect
> >>>>>> these helpers to just work for all the contexts.
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Daniel
> >>>
> >>> What would you think of just letting the helpers own these 512 bytes
> >>> buffers as local variables on their stacks ? Then bpf_prepare_bprintf
> >>> would only need to write there, there would be no acquire semantic
> >>> (like try_get_fmt_tmp_buf) and the stack frame would just be freed on
> >>> the helper return so there would be no bpf_printf_cleanup either. We
> >>> would also not pre-reserve static memory for all CPUs and it becomes
> >>> trivial to handle re-entrant helper calls.
> >>>
> >>> I inherited this per-cpu buffer from the pre-existing bpf_seq_printf
> >>> code but I've not been convinced of its necessity.
> >>
> >> I got the impression that extra 512 bytes on the kernel stack is quite
> >> a lot and that's why we have per-cpu buffers. Especially that
> >> bpf_trace_printk() can be called from any context, including NMI.
> >
> > Ok, I understand.
> >
> > What about having one buffer per helper, synchronized with a spinlock?
> > Actually, bpf_trace_printk already has that, not for the bprintf
> > arguments but for the bprintf output so this wouldn't change much to
> > the performance of the helpers anyway:
> > https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/kernel/trace/bpf_trace.c?id=9d31d2338950293ec19d9b095fbaa9030899dcb4#n385
> >
> > These helpers are not performance sensitive so a per-cpu stack of
> > buffers feels over-engineered to me (and is also complexity I feel a
> > bit uncomfortable with).
>
> But wouldn't this have same potential of causing a deadlock? Simple example
> would be if you have a tracing prog attached to bstr_printf(), and one of
> the other helpers using the same lock called from a non-tracing prog. If

Ah, right, I see :/

> it can be avoided fairly easily, I'd also opt for per-cpu buffers as Andrii
> mentioned earlier. We've had few prior examples with similar issues [0].
>
>    [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9594dc3c7e71b9f52bee1d7852eb3d4e3aea9e99

Ok it's not as bad as I imagined, thank you Daniel :) I'll look into
it beginning of next week.
