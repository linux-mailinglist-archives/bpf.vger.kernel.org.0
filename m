Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FB227320E
	for <lists+bpf@lfdr.de>; Mon, 21 Sep 2020 20:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgIUSim (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Sep 2020 14:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbgIUSim (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Sep 2020 14:38:42 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3D7C0613CF
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 11:38:41 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e22so13822350edq.6
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 11:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C7G6A5IlEG2WC0nmoX7XdAtZ+v2I/zqqDO0euVW1SNE=;
        b=GKj3LJZbIecljJchWIPsVbgqFMg87glRuzFxDZUSnJCVadINrRQoPekzrtKM6pXFG4
         jWmJoGWdPsML6lH9FjKOKPIrPw63/cKOhXUp5e0TPpKeUNin829jFNlYXC5LjVUi7psX
         Q8fipqI46lZkA3SDqje4ta/W4Eh+vI3SKfAi5yGK5526zHVe4lUCgrqmAQiiqMQXKcXP
         2qWHELpxN3jG2I/YmRVE/92CZfYkjr2vDdMUrejhZq+rTTRxVVnar1vEZXkj/I4Nld8N
         b5fF2BDFiRGJmzlxKgzu9iX8XLxJoLdMWZl0/TkOILYMjMeMo1Mmy0vuKiMc4RKUduOk
         a9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C7G6A5IlEG2WC0nmoX7XdAtZ+v2I/zqqDO0euVW1SNE=;
        b=W+MPph4MKULn3k+/i2UiYFOS764CHIjBlaK8IulCAmLS4IUv+JQ34Wl6+yQJqCCq90
         /aGlItZWoeSp04jO3sBlSedMnkX+3ZBi9tDuyhfVgN9hIbV1Ll/Z35QJ2BWBIj7Z/O60
         mLnCTR+/qL8xRqO3KSb6K0ZUOY3TTuuc18IMWglwPXdnQMt14jlUcLvAGIi/kQVsTJRM
         VFNc9rRZA9IaJw9tpCb6vprEBdkGu4BbD1jalA+5na3qskKPbIl3O+U1VhVue6/BjmHb
         UC5kYqr1Rs7T2W6DzwPaDVwaOvsvhqXwBdjBmOPfIEfDdodY5dQboLQBULm4aDiheSgK
         THKg==
X-Gm-Message-State: AOAM530L+IRxjMaisVNnNwCmjBkUX2ldonyDLakE/0pDcOvQyPYXcjOM
        PTQfm/6hJ80+4qgWV82FMbv2eLi5oElt3sR6lcpJiQ==
X-Google-Smtp-Source: ABdhPJw1S/OudX6ksjY6lypppCEWZ0hIJHznPBazJowA/vFH3Ctsk57UwDR5UNDwwwTnZIA6s/67nZwO+5kWeI/4UA0=
X-Received: by 2002:a05:6402:176c:: with SMTP id da12mr281928edb.386.1600713520102;
 Mon, 21 Sep 2020 11:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600661418.git.yifeifz2@illinois.edu> <6af89348c08a4820039e614a090d35aa1583acff.1600661419.git.yifeifz2@illinois.edu>
 <CAG48ez0OqZavgm0BkGjCAJUr5UfRgbeCbmLOZFJ=Rj46COcN3Q@mail.gmail.com>
In-Reply-To: <CAG48ez0OqZavgm0BkGjCAJUr5UfRgbeCbmLOZFJ=Rj46COcN3Q@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 21 Sep 2020 20:38:11 +0200
Message-ID: <CAG48ez0gBRvTEXX_L3881jQM8Aw6SURbMPafW18GihWe4ZmtmQ@mail.gmail.com>
Subject: Re: [RFC PATCH seccomp 1/2] seccomp/cache: Add "emulator" to check if
 filter is arg-dependent
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Valentin Rothberg <vrothber@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 21, 2020 at 7:47 PM Jann Horn <jannh@google.com> wrote:
> On Mon, Sep 21, 2020 at 7:35 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> > SECCOMP_CACHE_NR_ONLY will only operate on syscalls that do not
> > access any syscall arguments or instruction pointer. To facilitate
> > this we need a static analyser to know whether a filter will
> > access. This is implemented here with a pseudo-emulator, and
> > stored in a per-filter bitmap. Each seccomp cBPF instruction,
> > aside from ALU (which should rarely be used in seccomp), gets a
> > naive best-effort emulation for each syscall number.
> >
> > The emulator works by following all possible (without SAT solving)
> > paths the filter can take. Every cBPF register / memory position
> > records whether that is a constant, and of so, the value of the
> > constant. Loading from struct seccomp_data is considered constant
> > if it is a syscall number, else it is an unknown. For each
> > conditional jump, if the both arguments can be resolved to a
> > constant, the jump is followed after computing the result of the
> > condition; else both directions are followed, by pushing one of
> > the next states to a linked list of next states to process. We
> > keep a finite number of pending states to process.
>
> Is this actually necessary, or can we just bail out on any branch that
> we can't statically resolve?

Aaaah, now I get what's going on. You statically compute a bitmask
that says whether a given syscall number always has a fixed result
*per architecture number*, and then use that later to decide whether
results can be cached for the combination of a specific seccomp filter
and a specific architecture number. Which mostly works, except that it
means you end up with weird per-thread caches and you get interference
between ABIs (so if a process e.g. filters the argument numbers for
syscall 123 in ABI 1, the results for syscall 123 in ABI 2 also can't
be cached).

Anyway, even though this works, I think it's the wrong way to go about it.
