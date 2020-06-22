Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532A0203A37
	for <lists+bpf@lfdr.de>; Mon, 22 Jun 2020 17:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgFVPBf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Jun 2020 11:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729065AbgFVPBf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Jun 2020 11:01:35 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7E1C061573
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 08:01:34 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id y5so19733107iob.12
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 08:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pallissard.net; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0DbYF33Ysv60huADi5kR4Tydu87llnTNCuQlqaMFrNQ=;
        b=nPUauC146G3UwOFliFoUVnmMVNxCmQfumsWkhErYeAK8ar28mTpKtRKwRPHQwfHAbw
         USwUDg9eXXZK1NUNJAoSkfrgImNV4EDY3bLWH0Ocond6NOK49fKSGhC5ApG/usKTRFPf
         huB3ZBfesUzDPhw9bK5Lifk8tJHDckJz9ZbQi3yuNbcvW+oUWoWM21xe9n/p3s2hcUHy
         sYue1KFN3mdlEl4h57w9k9rj9Jl8KvKfe96ettusjx7ckjyvM98xEOnuJk+RbOJ/4E+a
         hvoo30NQJpdbiPIaESav9jjAHHh8NEeqLCmADONOPf/VK5MbFjwwJRlwNCm8ZiPDDWo8
         IWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0DbYF33Ysv60huADi5kR4Tydu87llnTNCuQlqaMFrNQ=;
        b=ngtBRdrnqbb58iXgwHt3ni3v9Fir691HUV9q+ZaJifC1XQw5KFiXeLVkhb5fOb/eAB
         ao8PnhhK7wW+FqQ5pV+YSWRRrYlMRlWJSKl7so3gWy6CKj+J3rFuVux9dL0u4UbQ+QYZ
         xkeXZyA3riVia1hRt/Wlg34T8hA7Fs1WLH3uN2GLYT2z9SjEj/gshhqsBNSlmN4Z9ic+
         AF9Jq2dRkYE2xoeMagupjQw6klUTIdxbogQoUDXXC3OcYnxgKJuN3q8WmOqQCY8a9J1R
         gTyZ0F/zotaPPFrQRxdAvZNbExwoVxjDmuxT5JrP22cxhtabTBH/zDD46+uVLN2fEe8d
         iYFw==
X-Gm-Message-State: AOAM5323zXOS/0UEIru0qlPYKsIlexRaH7nXw/islxTkjJ7so4kOEoJ3
        +ujvgMqukbn+sIKq/dPJzvINjA==
X-Google-Smtp-Source: ABdhPJyrYLfNBp+5gZ/dKdKZcHAMehuhvfN9vGyROSvWRYr/73kBdpChp/7JYMV2h2j1he2Kc1uASg==
X-Received: by 2002:a05:6638:975:: with SMTP id o21mr17670577jaj.99.1592838093056;
        Mon, 22 Jun 2020 08:01:33 -0700 (PDT)
Received: from mail.matt.pallissard.net (223.91.188.35.bc.googleusercontent.com. [35.188.91.223])
        by smtp.gmail.com with ESMTPSA id n4sm8630351ioc.8.2020.06.22.08.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 08:01:31 -0700 (PDT)
Date:   Mon, 22 Jun 2020 08:01:28 -0700
From:   Matt Pallissard <matt@pallissard.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Subject: Re: Accessing mm_rss_stat fields with btf/BPF_CORE_READ_INTO
Message-ID: <20200622150128.hjwe3uak2sy7po22@matt-gen-desktop-p01.matt.pallissard.net>
References: <20200620162216.2ioyj6uzlpc45jzx@matt-gen-desktop-p01.matt.pallissard.net>
 <4889d766-578e-1e20-119f-9f97621e766f@fb.com>
 <20200620200602.ax7tjx5jrtgyj6vs@matt-gen-laptop-p01>
 <CAEf4Bzb1x5iGbb+mX0mz-mjLWvRvr9tn2SeQ3yVgd5eBagBc5w@mail.gmail.com>
 <20200621154428.pf6foowywrq3wxt2@matt-gen-laptop-p01>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200621154428.pf6foowywrq3wxt2@matt-gen-laptop-p01>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2020-06-21T08:44:28 -0700, Matt Pallissard wrote:
>
>
> On 2020-06-20T20:29:43 -0700, Andrii Nakryiko wrote:
> > On Sat, Jun 20, 2020 at 1:07 PM Matt Pallissard <matt@pallissard.net> wrote:
> > >
> > >
> > >
> > >
> > > On 2020-06-20T11:11:55 -0700, Yonghong Song wrote:
> > > >
> > > >
> > > > On 6/20/20 9:22 AM, Matt Pallissard wrote:
> > > > > New to bpf here.
> > > > >
> > > > > I'm trying to read values out of of mm_struct.  I have code like this;
> > > > >
> > > > > unsigned long i[10] = {};
> > > > > struct task_struct *t;
> > > > > struct mm_rss_stat *rss;
> > > > >
> > > > > t = (struct task_struct *)bpf_get_current_task();
> > > > > BPF_CORE_READ_INTO(&rss, t, mm, rss_stat);
> > > > > BPF_CORE_READ_INTO(i, rss, count);
> > > > >
> > > > > However, all values in `i` appear to be 0 (i[MM_FILEPAGES], etc), as if no data gets copied.  I'm about 100% confident that this is caused by a glaring oversight on my part.
> > > >
> > > > Maybe you want to check the return value of BPF_CORE_READ_INTO.
> > > > Underlying it is using bpf_probe_read and bpf_probe_read may fail e.g., due
> > > > to major fault.
> > >
> > > Doh, I should have known to check the return codes!  Yes, it was failing.  I knew I was overlooking something trivial.
> > >
> >
> > I wrote exactly such piece of code a while ago. Here's part of it for
> > reference, I think it will be helpful:
> >
> >   struct task_struct *task = (struct task_struct *)bpf_get_current_task();
> >   const struct mm_struct *mm = BPF_CORE_READ(task, mm);
> >
> >   if (mm) {
> >       u64 hiwater_rss = BPF_CORE_READ(mm, hiwater_rss);
> >       u64 file_pages = BPF_CORE_READ(mm, rss_stat.count[MM_FILEPAGES].counter);
> >       u64 anon_pages = BPF_CORE_READ(mm, rss_stat.count[MM_ANONPAGES].counter);
> >       u64 shmem_pages = BPF_CORE_READ(mm,
> > rss_stat.count[MM_SHMEMPAGES].counter);
> >       u64 active_rss = file_pages + anon_pages + shmem_pages;
> >       /* ... */
>
> Thank you,
>
> After realizing that I was referencing the struct incorrectly, I wound up with a similar block of code.  However, as I started testing it against /proc/pid/smaps[,_rollup] I noticed that my numbers didn't match up.  Always smaller.
>
> I took a quick glance at fs/proc/task_mmu.c.  I think I'll have to walk some sort of accounting structure.


I started to take a hard look at fs/proc/task_mmu.c.  With all the locking, globals, and compile-time constants, I'm not sure that it's even possible to correctly walk `vm_area_struct` in bpf.

If anyone has suggestions for getting memory numbers from an entire process, not just a task/thread, I'd love to hear them.  If not, I'll pursue this on my own.


Matt Pallissard
