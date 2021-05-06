Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9341375A72
	for <lists+bpf@lfdr.de>; Thu,  6 May 2021 20:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhEFSxs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 May 2021 14:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhEFSxr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 May 2021 14:53:47 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0D7C061574;
        Thu,  6 May 2021 11:52:49 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id l7so8707841ybf.8;
        Thu, 06 May 2021 11:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OznFb7lrprpD0iBPnZACGeO9gkexqyBOLmxLxjb2jpQ=;
        b=WeEdHeOCXKvqR3npedXzsdCiX92pgzthpWScERP6jnUpnHKV0EDlz3sSfNuI0CZy43
         GOg9gmc6IXm8VWXIhHE9gZHkXyfeUyqdhF+qS7xSTHJkHLRgmurf6pTsF7RKefffv6+D
         AgFKuB1IOFanDcFZsQumBkgLIi7wBhkcDUnigHbGb3LthYFiCQl9+aFRcbJKeCxiL8hU
         fM9MMQZW9QvmBmNWIlBnIddNurYU2EK5mNfdm+UTpipvEvnQvfOyX+QPz6sklzppX802
         V2RjnaTTUkV31fD9FZ3CdFp+hqI+uDGxDFifJKP4mcoFzL6zDrqtx93mMqwIG0oP1uIi
         Gkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OznFb7lrprpD0iBPnZACGeO9gkexqyBOLmxLxjb2jpQ=;
        b=oQc0u41MOYB2X/CIP0eVmk/Vttj9odzSJ7sJpwBjLr5cGTmn2imkB17KLDMOJbDL3a
         QkcfYulZ/iS1TCVXwMdNKTGVXqtiTy4xroNJBmwHdVCTo3lU005hQnf28QG1F7b9u/D3
         Vvs/qjoiCkvOg6dFKZk/8KkZ0Erj+nddTCBdDCRlLsMJxsGcYz6CPwefhRcbZUOyJ73H
         b1tonXoqw3iSjtQnaJOtWxoNU/Bmhd5vII2aCW7iTKjRe/B6zkyTbt6ZHqTU38mC9tkJ
         NzcngH23IRg11B15A2m0qgdfuHcmeXePx1vpc9z5vHK4JtN3lGRBhYoYgJF3dhWzp9lq
         Cw+g==
X-Gm-Message-State: AOAM532aPHikrN7Xt9WTR5+Tt3VanZXVXXUv57FmPfYy8i5rW5xLnrFB
        AM9xHXhU6VyCJiAw+IOH2yNjHtyxl4oZY8sBiVw=
X-Google-Smtp-Source: ABdhPJxjo5pTnGapU46y8wqu1pAI6fqlDDHA0bRGNyOTgm7IkgSAHWQHWiQV6AOtTBumAyBgczthNlrtOXnNYRMy9D4=
X-Received: by 2002:a5b:286:: with SMTP id x6mr8109971ybl.347.1620327168605;
 Thu, 06 May 2021 11:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210505162307.2545061-1-revest@chromium.org> <CAEf4BzZiK1ncN7RzeJ-62e=itekn34VuFf7WNhUF=9OoznMP6Q@mail.gmail.com>
 <fe37ff8f-ebf0-25ec-4f3c-df3373944efa@iogearbox.net> <CAEf4BzYsAXQ1t6GUJ4f8c0qGLdnO4NLDVJLRMhAY2oaiarDd6g@mail.gmail.com>
 <CAEf4BzYqUxgj28p7e1ng_5gfebXdVdrCVyPK4bjA31O4wgppeA@mail.gmail.com> <CABRcYmJBxY5AQMzO2vuuhVN7hs=1h+ursEnVAXpCPJ3DrkRrUA@mail.gmail.com>
In-Reply-To: <CABRcYmJBxY5AQMzO2vuuhVN7hs=1h+ursEnVAXpCPJ3DrkRrUA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 6 May 2021 11:52:37 -0700
Message-ID: <CAEf4BzY4a6R-apnS0AZsb_Mtht2N8be1HvEN9hD9aSByoD1EHQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Don't WARN_ON_ONCE in bpf_bprintf_prepare
To:     Florent Revest <revest@chromium.org>
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

On Wed, May 5, 2021 at 3:29 PM Florent Revest <revest@chromium.org> wrote:
>
> On Wed, May 5, 2021 at 10:52 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, May 5, 2021 at 1:48 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, May 5, 2021 at 1:00 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> > > >
> > > > On 5/5/21 8:55 PM, Andrii Nakryiko wrote:
> > > > > On Wed, May 5, 2021 at 9:23 AM Florent Revest <revest@chromium.org> wrote:
> > > > >>
> > > > >> The bpf_seq_printf, bpf_trace_printk and bpf_snprintf helpers share one
> > > > >> per-cpu buffer that they use to store temporary data (arguments to
> > > > >> bprintf). They "get" that buffer with try_get_fmt_tmp_buf and "put" it
> > > > >> by the end of their scope with bpf_bprintf_cleanup.
> > > > >>
> > > > >> If one of these helpers gets called within the scope of one of these
> > > > >> helpers, for example: a first bpf program gets called, uses
> > > > >
> > > > > Can we afford having few struct bpf_printf_bufs? They are just 512
> > > > > bytes, so can we have 3-5 of them? Tracing low-level stuff isn't the
> > > > > only situation where this can occur, right? If someone is doing
> > > > > bpf_snprintf() and interrupt occurs and we run another BPF program, it
> > > > > will be impossible to do bpf_snprintf() or bpf_trace_printk() from the
> > > > > second BPF program, etc. We can't eliminate the probability, but
> > > > > having a small stack of buffers would make the probability so
> > > > > miniscule as to not worry about it at all.
> > > > >
> > > > > Good thing is that try_get_fmt_tmp_buf() abstracts all the details, so
> > > > > the changes are minimal. Nestedness property is preserved for
> > > > > non-sleepable BPF programs, right? If we want this to work for
> > > > > sleepable we'd need to either: 1) disable migration or 2) instead of
> > >
> > > oh wait, we already disable migration for sleepable BPF progs, so it
> > > should be good to do nestedness level only
> >
> > actually, migrate_disable() might not be enough. Unless it is
> > impossible for some reason I miss, worst case it could be that two
> > sleepable programs (A and B) can be intermixed on the same CPU: A
> > starts&sleeps - B starts&sleeps - A continues&returns - B continues
> > and nestedness doesn't work anymore. So something like "reserving a
> > slot" would work better.
>
> Iiuc try_get_fmt_tmp_buf does preempt_enable to avoid that situation ?
>
> > >
> > > > > assuming a stack of buffers, do a loop to find unused one. Should be
> > > > > acceptable performance-wise, as it's not the fastest code anyway
> > > > > (printf'ing in general).
> > > > >
> > > > > In any case, re-using the same buffer for sort-of-optional-to-work
> > > > > bpf_trace_printk() and probably-important-to-work bpf_snprintf() is
> > > > > suboptimal, so seems worth fixing this.
> > > > >
> > > > > Thoughts?
> > > >
> > > > Yes, agree, it would otherwise be really hard to debug. I had the same
> > > > thought on why not allowing nesting here given users very likely expect
> > > > these helpers to just work for all the contexts.
> > > >
> > > > Thanks,
> > > > Daniel
>
> What would you think of just letting the helpers own these 512 bytes
> buffers as local variables on their stacks ? Then bpf_prepare_bprintf
> would only need to write there, there would be no acquire semantic
> (like try_get_fmt_tmp_buf) and the stack frame would just be freed on
> the helper return so there would be no bpf_printf_cleanup either. We
> would also not pre-reserve static memory for all CPUs and it becomes
> trivial to handle re-entrant helper calls.
>
> I inherited this per-cpu buffer from the pre-existing bpf_seq_printf
> code but I've not been convinced of its necessity.

I got the impression that extra 512 bytes on the kernel stack is quite
a lot and that's why we have per-cpu buffers. Especially that
bpf_trace_printk() can be called from any context, including NMI.
