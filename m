Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8EB34BE42
	for <lists+bpf@lfdr.de>; Sun, 28 Mar 2021 20:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhC1Sbb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Mar 2021 14:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhC1SbK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Mar 2021 14:31:10 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BC1C061756
        for <bpf@vger.kernel.org>; Sun, 28 Mar 2021 11:31:10 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id v107so6457982ybi.9
        for <bpf@vger.kernel.org>; Sun, 28 Mar 2021 11:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=edPB8eAthLIdnXSQ1qeDxnpID4A9br8Qq4IJxeEHb2c=;
        b=CifiLeAl1k/hWs4y+6uGVk0hSExHC63YwaGoiKxwGQTRX7kTAlvHKPR+h37MnjS5uN
         6yH94YLd2dhuSyithZrFlzoMC4UB7E/iyC7PcM5BGPWeRS7UCUxcW34BCBgsI3dQq4cF
         XAgarKB4rPSV/o6yc/4xNO/ynbaKr03ZbOEteh+GVwxwZthUauUyDeP9fKftyAGnbsAE
         1imgq64OuLYAn7cn7d0CfHclAj4Gw7Utggitbb2PWDAqh02DOK6adOZLHEpoV/FnO7sy
         9otSVud8F9C6XuAYj6w07IMVfLpw3ZcdPu6BAsJECsXew7iHtQyUXDl+Sx5+ZK77srHS
         TIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=edPB8eAthLIdnXSQ1qeDxnpID4A9br8Qq4IJxeEHb2c=;
        b=oCfhlOGhOasdn0p8HFzckUsbzeiEBs/QXj5m8UiKCKCqWKsrz70aalurXZiMikrRTb
         J/jhXOdHDboWqbPLg5c9EkTi5dDiFJmV9LiO6TRaL2OK7bqo3nJlvaTaw0sre/WuJmHQ
         5O5XfBekz3TwrD9ivJVitujFDCiPFDxj+q80eAsq3uVXv1jMvAKFvIzjYa95fAocif0r
         WeGcFBT3bHclTCi5q9qPtiIrclyGTGpeeqLqpvTspgttEtZ9Lo3wvGS7AyPYHFO5pfll
         Ljt0cy0KUT5BLx94y50xiISkpIPeNrJW3facbTmfwayVA5xJFeY6eqAVe7xAduXTrZyM
         spMQ==
X-Gm-Message-State: AOAM5308xSUyaQ/7KrgRSFnvD0QIu6jvMSoec5zFc6iCe2WrCz2e4eoA
        oQ14YvyR+dlYnVcnBHbAIh6vmAlKSgD0aWNCVAA=
X-Google-Smtp-Source: ABdhPJxwqDlbF+tbTt4TulpjSJ9zHPaPSiTFv4a9q3lBaYg5hXFNEVfIWN/BM3HAV6ksyG29Hia7aGtI/5Wk8kI/olY=
X-Received: by 2002:a25:874c:: with SMTP id e12mr32405438ybn.403.1616956269987;
 Sun, 28 Mar 2021 11:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210326114658.210034-1-yauheni.kaliuta@redhat.com>
 <20210326122407.211174-1-yauheni.kaliuta@redhat.com> <CAEf4BzY_=Fj4+TetwHatiid=XM7rtjuZwfCA3fe9n7mhEhmwcg@mail.gmail.com>
 <CANoWswn7f+Byx=yCZRP+bhL7RjsLZF+puL4OgVudPB9QMPW1nw@mail.gmail.com>
In-Reply-To: <CANoWswn7f+Byx=yCZRP+bhL7RjsLZF+puL4OgVudPB9QMPW1nw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 28 Mar 2021 11:30:59 -0700
Message-ID: <CAEf4Bzax53s7x82rHP8MW9SW6eVi+WF5LJVvF=2Vqs9R4R_khg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] bpf/selftests: page size fixes
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 28, 2021 at 10:06 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Hi, Andrii,
>
> On Sun, Mar 28, 2021 at 8:05 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Mar 26, 2021 at 5:24 AM Yauheni Kaliuta
> > <yauheni.kaliuta@redhat.com> wrote:
> > >
> > > A set of fixes for selftests to make them working on systems with PAGE_SIZE > 4K
> > >
> > > 2 questions left:
> > >
> > > - about `nit: if (!ASSERT_OK(err, "setsockopt_attach"))`. I left
> > >   CHECK() for now since otherwise it has too many negations. But
> > >   should I anyway use ASSERT?
> >
> > CHECK itself is a negation as much more confusing, IMO. if
> > (!ASSERT_OK(err)) is pretty clear, as for me.
> >
> > >
> > > - https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/prog_tests/mmap.c#L41
> > >   and below -- it works now as is, but should be switched also to page_size?
> >
> > replied on another patch, it is possible to set all that at runtime
> > with bpf_map__set_max_entries().
>
> For both mmap and ringbuf or only for mmap?
>
> But the question is about the mmap userspace part. In the test for
> some reason both hardcoded 4096 and runtime page_size are used. I'm a
> bit confused, should I replace that 4096 with page size.

everywhere where 4096 is hard-coded, it was supposed to match page
size, so switching to page size would be best. for test_mmap, in
particular, I was trying to validate mmap refcounting, so each
separate 4096 bytes page was supposed to trigger as separate mmap
operation (with corresponding refcnt bump).


>
> >
> >
> > Overall, please specify the [PATCH bpf-next] prefix to denote that it
> > targets bpf-next.
>
> thanks for the review, I'll prepare v3 then.
>
> >
> >
> > >
> > > --
> > > v1->v2:
> > >
> > > - add missed 'selftests/bpf: test_progs/sockopt_sk: Convert to use BPF skeleton'
> > >
> > > Yauheni Kaliuta (4):
> > >
> > >   selftests/bpf: test_progs/sockopt_sk: pass page size from userspace
> > >   bpf: selftests: test_progs/sockopt_sk: remove version
> > >   selftests/bpf: ringbuf, mmap: bump up page size to 64K
> > >
> > >  .../selftests/bpf/prog_tests/ringbuf.c        |  9 ++-
> > >  .../selftests/bpf/prog_tests/sockopt_sk.c     | 68 ++++++-------------
> > >  .../selftests/bpf/progs/map_ptr_kern.c        |  9 ++-
> > >  .../testing/selftests/bpf/progs/sockopt_sk.c  | 11 ++-
> > >  tools/testing/selftests/bpf/progs/test_mmap.c | 10 ++-
> > >  .../selftests/bpf/progs/test_ringbuf.c        |  8 ++-
> > >  .../selftests/bpf/progs/test_ringbuf_multi.c  |  7 +-
> > >  7 files changed, 61 insertions(+), 61 deletions(-)
> > >
> > > --
> > > 2.29.2
> > >
> >
>
>
> --
> WBR, Yauheni
>
