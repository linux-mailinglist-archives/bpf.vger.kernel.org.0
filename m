Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFF33749B8
	for <lists+bpf@lfdr.de>; Wed,  5 May 2021 22:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbhEEUxt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 May 2021 16:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhEEUxs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 May 2021 16:53:48 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D317AC061574;
        Wed,  5 May 2021 13:52:50 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id r8so4471704ybb.9;
        Wed, 05 May 2021 13:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q4JBNbqyYCjln25EbbU6DcvCBBTTLObO2f45KPQlIvw=;
        b=NfKUWGtrm0EjtAw5A4he1weVOh1Nz7g9P+jrdslL6B/26iMAyrYhWL+WK9YHkckNQE
         SvMPVMGGwa5lP3F5GY3hokpjijjmxmWytNfm7XH/cO88n4ptn2xIdORfsf1ySsmKAQiF
         4hkW+V8fkqIjof7akiwSEuV9kKnmMXJOR0Cf8J3X6hUAw89eALtXYWmh6PVpDJ/LO+2w
         GAnlx3JRRvMfdHJrqfxD9XHyec6Le1hHps0y1kj1uszSRAVeAdkk8OjrcTkk+F7dtbOe
         /ovkE0C7ySXT3W0Fk42kRSEfbcAttRtnoOSfUpStHovLI9PUNfkYcP4tqMEBXjMB/fa4
         495Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q4JBNbqyYCjln25EbbU6DcvCBBTTLObO2f45KPQlIvw=;
        b=n1ahAP5yFfV/aRX9zkHnHMJWdbZOSfmhkij1dhJ0XpY082hxbGEDt9dgcrRaVisiOT
         l3JSZYHCogQKAOqr7/ByQQ3mQOGebSVWW/l6UGxqvqopFGI13Q/7cmEmNC2/BPFQ3Rqx
         SAv3GwrTE5jFx7Z1vwVL8am0UD+XhcJn433Z97Vz/gPf0uNqc4F9JNowoeLVSCTf3K9I
         mQ92DbvtXlbYX7YxPBbLF6ohn5RGKzD8Xh62/Kur67HPfOmoJYethuzKB7NCghNypPL/
         9Mn+14y1pkoNixiyumLXIzgAYAHWie6O0qPgaONIbTQLtnf8ISQPF4eDwX+6kkWQIA0D
         HpvQ==
X-Gm-Message-State: AOAM533BQyq5COgtFg13xOrV0z83XHC5xeTaj9hgMXyouxVO8VpVpn1R
        oEEzR5JcmX12BMLy7PI9P47KD//PknJ/R+FugBY=
X-Google-Smtp-Source: ABdhPJwvqmneCMjZ2JkKmPwqsNm4pu9Bao8fICeSnWrWo5Y6n4D++G91E6wrsd09XS7cYBoKehafdhGMNVS17jSS/v0=
X-Received: by 2002:a05:6902:1144:: with SMTP id p4mr917910ybu.510.1620247970059;
 Wed, 05 May 2021 13:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210505162307.2545061-1-revest@chromium.org> <CAEf4BzZiK1ncN7RzeJ-62e=itekn34VuFf7WNhUF=9OoznMP6Q@mail.gmail.com>
 <fe37ff8f-ebf0-25ec-4f3c-df3373944efa@iogearbox.net> <CAEf4BzYsAXQ1t6GUJ4f8c0qGLdnO4NLDVJLRMhAY2oaiarDd6g@mail.gmail.com>
In-Reply-To: <CAEf4BzYsAXQ1t6GUJ4f8c0qGLdnO4NLDVJLRMhAY2oaiarDd6g@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 May 2021 13:52:39 -0700
Message-ID: <CAEf4BzYqUxgj28p7e1ng_5gfebXdVdrCVyPK4bjA31O4wgppeA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Don't WARN_ON_ONCE in bpf_bprintf_prepare
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Florent Revest <revest@chromium.org>, bpf <bpf@vger.kernel.org>,
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

On Wed, May 5, 2021 at 1:48 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, May 5, 2021 at 1:00 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >
> > On 5/5/21 8:55 PM, Andrii Nakryiko wrote:
> > > On Wed, May 5, 2021 at 9:23 AM Florent Revest <revest@chromium.org> wrote:
> > >>
> > >> The bpf_seq_printf, bpf_trace_printk and bpf_snprintf helpers share one
> > >> per-cpu buffer that they use to store temporary data (arguments to
> > >> bprintf). They "get" that buffer with try_get_fmt_tmp_buf and "put" it
> > >> by the end of their scope with bpf_bprintf_cleanup.
> > >>
> > >> If one of these helpers gets called within the scope of one of these
> > >> helpers, for example: a first bpf program gets called, uses
> > >
> > > Can we afford having few struct bpf_printf_bufs? They are just 512
> > > bytes, so can we have 3-5 of them? Tracing low-level stuff isn't the
> > > only situation where this can occur, right? If someone is doing
> > > bpf_snprintf() and interrupt occurs and we run another BPF program, it
> > > will be impossible to do bpf_snprintf() or bpf_trace_printk() from the
> > > second BPF program, etc. We can't eliminate the probability, but
> > > having a small stack of buffers would make the probability so
> > > miniscule as to not worry about it at all.
> > >
> > > Good thing is that try_get_fmt_tmp_buf() abstracts all the details, so
> > > the changes are minimal. Nestedness property is preserved for
> > > non-sleepable BPF programs, right? If we want this to work for
> > > sleepable we'd need to either: 1) disable migration or 2) instead of
>
> oh wait, we already disable migration for sleepable BPF progs, so it
> should be good to do nestedness level only

actually, migrate_disable() might not be enough. Unless it is
impossible for some reason I miss, worst case it could be that two
sleepable programs (A and B) can be intermixed on the same CPU: A
starts&sleeps - B starts&sleeps - A continues&returns - B continues
and nestedness doesn't work anymore. So something like "reserving a
slot" would work better.

>
> > > assuming a stack of buffers, do a loop to find unused one. Should be
> > > acceptable performance-wise, as it's not the fastest code anyway
> > > (printf'ing in general).
> > >
> > > In any case, re-using the same buffer for sort-of-optional-to-work
> > > bpf_trace_printk() and probably-important-to-work bpf_snprintf() is
> > > suboptimal, so seems worth fixing this.
> > >
> > > Thoughts?
> >
> > Yes, agree, it would otherwise be really hard to debug. I had the same
> > thought on why not allowing nesting here given users very likely expect
> > these helpers to just work for all the contexts.
> >
> > Thanks,
> > Daniel
