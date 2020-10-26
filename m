Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAFB5298F55
	for <lists+bpf@lfdr.de>; Mon, 26 Oct 2020 15:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781514AbgJZOan (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Oct 2020 10:30:43 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43911 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781510AbgJZOan (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Oct 2020 10:30:43 -0400
Received: by mail-ot1-f65.google.com with SMTP id k68so8129752otk.10;
        Mon, 26 Oct 2020 07:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=+62REvLl90oSoyuDks7xdfiXCVRonn7cl65cbO1ln/E=;
        b=JnQ0MIpC39NGj7T4hBFlbdnbI8BIWOudxMb9DwRB+2vErYWqGaeDk6rew3qbtnq6zE
         xTQK3COatM2HRhx7Xj9lHlrGrcm71hnK8BNlqHvJIskesC/YoT/AlMOcjB5nyYP/qEr5
         nGqst5eVhCd7URgCMzm/Z1ajkuwlpxD5SqPAKMFSs8E/vhjMV8gwqMpNkgRp9Bp6Xpn4
         RRyiGkWI03aSsA5qqbLzT5bAviyyV57u+uzzZa6LYP23zz1MUbbGQTIEtIrCFOljySFY
         9LUzk5kBx9rPqA30qiWylDiDgAPXMjP9b5T3y/ZQo5jB7TcU7uUb3usgvmVod9XA6i/4
         aeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=+62REvLl90oSoyuDks7xdfiXCVRonn7cl65cbO1ln/E=;
        b=iMxpJoL3xGlJWe9fCAkw24Z183mbIYd+7RyuQdsh6cPdOspTKXn1hCDi2vp1rWUyAy
         e8rd8yiNDtMp9Df9KMNJxunQ02g2ONkTN3e/fkhMG37Td8RL/0sGY9BUj+n6gbKy6EGl
         z7A2cDAO5+Dm2la8NgQK6WvHN3lTDG76+x+kPlNeaQ1HcK7ooPXvFKRItsgE2wGGlpFw
         20HpOGYoE2acRxVruARID/EaZKvxBA8AJyWytISZpmq767jNGUeKuJw4w7tmU1cFD4uU
         69RxQO50mFc+rw/y/iSHtPW3OVeyN8V80ft5/EKgXxLbacJQrFxaeSpVkTQnKL+ilRKC
         iLIw==
X-Gm-Message-State: AOAM5316PNo3JKV79GREk3Sr8ZPa2mzYVfqSbC2UcN9L/at3LWAeD4qI
        AAtCm+MNej5yse5c58OWJRtw4CpFcq3Dz5T5ZuPLhkfL4gI=
X-Google-Smtp-Source: ABdhPJwW15tzyEC/krpp35iEMIIcjSyagUOGYZYuoOMQvqf+nEg1onUBKRqqUolszW2AyHG3hi9a91s1aH2f5EGSzME=
X-Received: by 2002:a05:6830:22eb:: with SMTP id t11mr13557647otc.114.1603722641926;
 Mon, 26 Oct 2020 07:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <63598b4f-6ce3-5a11-4552-cdfe308f68e4@gmail.com> <20201026135418.GN1884107@cisco>
In-Reply-To: <20201026135418.GN1884107@cisco>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Mon, 26 Oct 2020 15:30:29 +0100
Message-ID: <CAKgNAkgbvuEJ0rkLrZGgCf0OTC8YH2vxemNic8SsDxjh=Z22uw@mail.gmail.com>
Subject: Re: For review: seccomp_user_notif(2) manual page [v2]
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        Kees Cook <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Robert Sesek <rsesek@google.com>,
        Containers <containers@lists.linux-foundation.org>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Drewry <wad@chromium.org>, bpf <bpf@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Tycho,

Thanks for getting back to me.

On Mon, 26 Oct 2020 at 14:54, Tycho Andersen <tycho@tycho.pizza> wrote:
>
> On Mon, Oct 26, 2020 at 10:55:04AM +0100, Michael Kerrisk (man-pages) wrote:
> > Hi all (and especially Tycho and Sargun),
> >
> > Following review comments on the first draft (thanks to Jann, Kees,
> > Christian and Tycho), I've made a lot of changes to this page.
> > I've also added a few FIXMEs relating to outstanding API issues.
> > I'd like a second pass review of the page before I release it.
> > But also, this mail serves as a way of noting the outstanding API
> > issues.
> >
> > Tycho: I still have an outstanding question for you at [2].
> > [2] https://lore.kernel.org/linux-man/8f20d586-9609-ef83-c85a-272e37e684d8@gmail.com/
>
> I don't have that thread in my inbox any more, but I can reply here:
> no, I don't know any users of this info, but I also don't anticipate
> knowing how people will all use this feature :)

Yes, but my questions were:

[[
[1] So, I think maybe I now understand what you intended with setting
POLLOUT: the notification has been received ("read") and now the
FD can be used to NOTIFY_SEND ("write") a response. Right?

[2] If that's correct, I don't have a problem with it. I just wonder:
is it useful? IOW: are there situations where the process doing the
NOTIFY_SEND might want to test for POLLOUT because the it doesn't
know whether a NOTIFY_RECV has occurred?
]]

So, do I understand right in [1]? (The implication from your reply is
yes, but I want to be sure...)

For [2], my question was not about users, but *use cases*. The
question I asked myself is: why does the feature exist? Hence my
question [2] reworded: "when you designed this, did you have in mind
scenarios here the process doing the NOTIFY_SEND might need to test
for POLLOUT because it doesn't know whether a NOTIFY_RECV has
occurred?"

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
