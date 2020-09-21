Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2552736C1
	for <lists+bpf@lfdr.de>; Tue, 22 Sep 2020 01:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgIUXo0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Sep 2020 19:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgIUXoZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Sep 2020 19:44:25 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302EBC061755;
        Mon, 21 Sep 2020 16:44:25 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k13so10211202pfg.1;
        Mon, 21 Sep 2020 16:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f8AZNe0yh+nr0Q+aU3EvTJPeuK86gAHOuWijIQhouP8=;
        b=vEGvA95PpAmbmXF/2pU8BaNMqZ5N1inrv9uju3AMOs5CulSDiskwgzFOBntcsI93QM
         yEjo2q9ircjzU7d1ufiagzwfnhKETg/PR8JvFmoclPzGhNPiyn9ANKeTMV9FlDHSM66O
         XoJ2QE+VcS9nST+vtUdxDzWpjzprT84+NULHJb7LPVe+Rq0sasjVAZR2yJ9NUdKBxgEk
         j5AP6emS5GZFCLp2qarNt8/8hgbxgcfv6d0dzn9myFt0mQOAEgORS5vXiesu+pwlxwGR
         LEsz4OcwMCvbZPND10wv//eJ2zOoVof7pjh3A/QMY825eKu324F0hjRDez+cdVTXz8RF
         4SLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f8AZNe0yh+nr0Q+aU3EvTJPeuK86gAHOuWijIQhouP8=;
        b=QBX4VWqFUyKCrwaiMgXNBbPU64AhbwHZjaaLdiw4UmY1hflrtxLDB1ZtIz7F1VnKts
         py3OEt4hCmNfDTpf2/U6RGOP2+TuQLmqINs3P1m+UvG89pXof+cbrCVNY66+UPbNx87T
         axwI4iH6Xciu1fzXpjUJRbkrbgZBtiUCWpKq4Zpnozjg7x3y/j/1ZHriU876Wg31Hk7t
         sa+Oi9sQEkR68ZYNAk1SsZy78nsBesAe5wB4WTx1EbWuO7n7ibG6w9E+SHekEJyrdbQG
         z4mjbWbl9Q/tLopMcD8uYzcRiHSLoWWVKmROC6HAnkyX+baoBokGIkyvUb0C1KW2PxBK
         psqA==
X-Gm-Message-State: AOAM530cAVXPAlQhesB2RPEODgfmmx0rfhnC13cHZEUS4QfwCvsLfHBm
        zMDsElC8Sjq/2sOO1DRF3mCBXRbEaIvJ+QEVGqBy2jPADUknlw==
X-Google-Smtp-Source: ABdhPJz+byc0Fo9qwVi1m/19ewyehzO4HVj6Nm3myh1IDrLqLENEXpuSUgTX/J1/uhN/HgHUxQ0lni+/Gp6neZQXKB0=
X-Received: by 2002:a17:902:7445:b029:d1:dea3:a3ca with SMTP id
 e5-20020a1709027445b02900d1dea3a3camr2074614plt.19.1600731864616; Mon, 21 Sep
 2020 16:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600661418.git.yifeifz2@illinois.edu> <6af89348c08a4820039e614a090d35aa1583acff.1600661419.git.yifeifz2@illinois.edu>
 <CAG48ez0OqZavgm0BkGjCAJUr5UfRgbeCbmLOZFJ=Rj46COcN3Q@mail.gmail.com>
In-Reply-To: <CAG48ez0OqZavgm0BkGjCAJUr5UfRgbeCbmLOZFJ=Rj46COcN3Q@mail.gmail.com>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Mon, 21 Sep 2020 18:44:13 -0500
Message-ID: <CABqSeAQhVFeG1Frvu60XfUnRQ78YRS2Uaw1EsBobKVku-vVoDQ@mail.gmail.com>
Subject: Re: [RFC PATCH seccomp 1/2] seccomp/cache: Add "emulator" to check if
 filter is arg-dependent
To:     Jann Horn <jannh@google.com>
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

On Mon, Sep 21, 2020 at 12:47 PM Jann Horn <jannh@google.com> wrote:
> Is this actually necessary, or can we just bail out on any branch that
> we can't statically resolve?

I think after we do enumerate the arch numbers it would make much more
sense. Since if there is a branch after arch number and syscall
numbers are fixed we can assume that the return values will be
different if one or the other case is followed.

> Also: If it turns out that the time spent in seccomp_cache_prepare()
> is measurable for large filters, a possible improvement would be to
> keep track of the last syscall number for which the result would be
> the same as for the current one, such that instead of evaluating the
> filter for one instruction at a time, it would effectively be
> evaluated for a range at a time. That should be pretty straightforward
> to implement, I think.

My concern was more of the possibly-exponential amount of time &
memory needed to evaluate an adversarial filter containing full of
unresolveable branches, hence the max pending states. If we never
follow both branches then evaluation should not be much of a concern.

> > +       depends on SECCOMP
> > +       depends on SECCOMP_FILTER
>
> SECCOMP_FILTER already depends on SECCOMP, so the "depends on SECCOMP"
> line is unnecessary.

The reason that this is here is because of the looks in menuconfig.
SECCOMP is the direct previous entry, so if this depends on SECCOMP
then the config would be indented. Is this looks not worth keeping or
is there some better way to do this?

> > +       help
> > +         Seccomp filters can potentially incur large overhead for each
> > +         system call. This can alleviate some of the overhead.
> > +
> > +         If in doubt, select 'none'.
>
> This should not be in arch/x86. Other architectures, such as arm64,
> should also be able to use this without extra work.

In the initial RFC patch I only added to x86. I could add it to any
arch that has seccomp filters. Though, I'm wondering, why is SECCOMP
in the arch-specific Kconfigs?

> I think we should probably just bail out if we see anything that's
> BPF_ST/BPF_STX. I've never seen seccomp filters that actually use that
> part of cBPF.
>
> But in case we do need this, maybe instead of using "2 +" for all
> these things, the cBPF memory slots should be in a separate array.

Ok I'll just bail.

YiFei Zhu
