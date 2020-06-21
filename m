Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EFA20282B
	for <lists+bpf@lfdr.de>; Sun, 21 Jun 2020 05:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgFUD3z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Jun 2020 23:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729208AbgFUD3z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Jun 2020 23:29:55 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B91C061794
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2020 20:29:55 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z2so8199391qts.5
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2020 20:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ltt+A8PUjsTQwdw4bm1kwo8wSeGrjbS5e/T45SL3DGg=;
        b=UGaOY1by+/zdtauEvXHgf3RjzPWg3W+6JH1ZVYcAL6qaOeDJMn61jO7h09eL6tw06z
         UxZqW6SxwEdj8lp8Xkskq01IJP2XxlyoeQqGNXMphP0mEVwrwRnlzM6uDAtbVr9L2En/
         YgKMK4ICHEV9wun8dviULWRHwur4630t856yxfZHfRUvLGVoQzCmVVa3kQLOCwmJQmGb
         eAmMTwNtjQyQr9tW3sXJxUKxptZ7JFSNuY8SvJ3VW5Wb9Fb31f/Xeh2iWTyNNH2o3FHB
         xdQYrlF2KaW7HNkpkhlIJ+OfmwDl1n3Nl7WzqHwu/0kX4FG6CEj884JhzUUiPiyshoWP
         6Jug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ltt+A8PUjsTQwdw4bm1kwo8wSeGrjbS5e/T45SL3DGg=;
        b=hXpP94X9IIvek95pyCHP8tx7xMbH++Y7AXTZacMxn3Hp9glEL0d8FlvoB4J6qUBxOC
         SjYWcPqtfM59L0dx93lVlOwklv0745OF20geV4/MYbyeriv1A86vRh5xdvcvVjpjAUmq
         tzs0zXRFeNHhUTPaGmsDX0qNBkuVnWHr8Z4NC15p6meyQ3xrPPiz6N/rcO+Nfd6fRr6s
         cZBxkW6rUhxX2RPAscIuJ1nzuV0Y6RDOXo7895KTctw4a31BZpb6TIa76NnHAcl4hTxC
         qOwdS9/OkZY8Ua1fpWz4eQHeP0HOECuaIfLuVHxrptaeyzoYGGiX9RLC4umQo1s4eDih
         LFSA==
X-Gm-Message-State: AOAM5307id30Oam/SKPsiZ3wpVZREuSNMobqnighggJ1Ml9aeIjIsi+P
        NEyDEnWktXx2MHNM58kM8aGHzmIfBivLz5mszFuNRMTC
X-Google-Smtp-Source: ABdhPJy8IvoX1u+ekkEG7nrRrfHagiYK/prHQc8Stejr26UcaY/UxEv/I7vZqxDer0mthotZLxi/YKftMC17gZJkFy4=
X-Received: by 2002:ac8:1991:: with SMTP id u17mr4018218qtj.93.1592710194290;
 Sat, 20 Jun 2020 20:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200620162216.2ioyj6uzlpc45jzx@matt-gen-desktop-p01.matt.pallissard.net>
 <4889d766-578e-1e20-119f-9f97621e766f@fb.com> <20200620200602.ax7tjx5jrtgyj6vs@matt-gen-laptop-p01>
In-Reply-To: <20200620200602.ax7tjx5jrtgyj6vs@matt-gen-laptop-p01>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 20 Jun 2020 20:29:43 -0700
Message-ID: <CAEf4Bzb1x5iGbb+mX0mz-mjLWvRvr9tn2SeQ3yVgd5eBagBc5w@mail.gmail.com>
Subject: Re: Accessing mm_rss_stat fields with btf/BPF_CORE_READ_INTO
To:     Matt Pallissard <matt@pallissard.net>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jun 20, 2020 at 1:07 PM Matt Pallissard <matt@pallissard.net> wrote:
>
>
>
>
> On 2020-06-20T11:11:55 -0700, Yonghong Song wrote:
> >
> >
> > On 6/20/20 9:22 AM, Matt Pallissard wrote:
> > > New to bpf here.
> > >
> > > I'm trying to read values out of of mm_struct.  I have code like this;
> > >
> > > unsigned long i[10] = {};
> > > struct task_struct *t;
> > > struct mm_rss_stat *rss;
> > >
> > > t = (struct task_struct *)bpf_get_current_task();
> > > BPF_CORE_READ_INTO(&rss, t, mm, rss_stat);
> > > BPF_CORE_READ_INTO(i, rss, count);
> > >
> > > However, all values in `i` appear to be 0 (i[MM_FILEPAGES], etc), as if no data gets copied.  I'm about 100% confident that this is caused by a glaring oversight on my part.
> >
> > Maybe you want to check the return value of BPF_CORE_READ_INTO.
> > Underlying it is using bpf_probe_read and bpf_probe_read may fail e.g., due
> > to major fault.
>
> Doh, I should have known to check the return codes!  Yes, it was failing.  I knew I was overlooking something trivial.
>

I wrote exactly such piece of code a while ago. Here's part of it for
reference, I think it will be helpful:

  struct task_struct *task = (struct task_struct *)bpf_get_current_task();
  const struct mm_struct *mm = BPF_CORE_READ(task, mm);

  if (mm) {
      u64 hiwater_rss = BPF_CORE_READ(mm, hiwater_rss);
      u64 file_pages = BPF_CORE_READ(mm, rss_stat.count[MM_FILEPAGES].counter);
      u64 anon_pages = BPF_CORE_READ(mm, rss_stat.count[MM_ANONPAGES].counter);
      u64 shmem_pages = BPF_CORE_READ(mm,
rss_stat.count[MM_SHMEMPAGES].counter);
      u64 active_rss = file_pages + anon_pages + shmem_pages;
      /* ... */
  }

> Thanks a bunch.
>
> Matt Pallissard
