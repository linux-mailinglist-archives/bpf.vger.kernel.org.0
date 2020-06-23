Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D13620552D
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 16:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732835AbgFWOye (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 10:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732840AbgFWOye (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 10:54:34 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFE9C061573
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 07:54:33 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id i18so8198770ilk.10
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 07:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pallissard.net; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fq/hyhMik9y4c383B8CgHqBuUGSl1nhwOAMCPI0CrbQ=;
        b=JCbGKkt6paSoSDEp8Mcy+3EjR9fIQG1fov28k5zxVLEZL/ufi6tQ6CipIil5NFHT/P
         FqsE+QJ2PB3i6zhf8gg0ol0xsNpeVM0r6fXGRR8MSdfY/kNzIV6upyYKGEeRe9+DaKqf
         sjVV3r6MPoZtzZvpbE8toXY/bDrwC7T4eAkmLBqkUO2co5FvbpE9XXCx7aRbO6pRTcRX
         iXcgihBDv2H8TwcalJA6/xUHmImbPeWUR23K3BblKWno/EMjP2VfvLj2Ue63DbItrusr
         xwmSDxkdRQVCXeGkAPaPyURC0OQbYSJK7Yi2FVAFdMytU86Wpkw+oMo1rKVIXXcE6UkB
         042g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fq/hyhMik9y4c383B8CgHqBuUGSl1nhwOAMCPI0CrbQ=;
        b=LMSas6qNFrNYghMxOikE2uT26V8Fgr95D/QNO2ypoi/LVfGSG1wORhwvGtD+wCPoT8
         hhbtdc/k2QBhggkdefzNn8AP9ZxkUYgvjvPLIyys2S2uuqUiSuYoqXIs1O9hRN5iaqL3
         27CFfvIyftgEIg9lPdJazh4inir6uRIiQfXl41otiToDAdHGWYiX33uYzCjJWHvZ//ht
         6wgKWY9TFMmUP2ACFKhbS85o7i1KVDmnjJ9fQ9Jx2FClkxaF5xuq0ygahYadfFO47Ng9
         QidRGcbTfCjpGb4Zl+zx+KZpbxbtllWlYFt+Z0FoYAJAdNn+zapGJA1AlXA5Kk+SJWJo
         iNNw==
X-Gm-Message-State: AOAM532uinR/CRCjmyNBK8NUQVeWjzFVSTa7tdogNzjheYb7MnXQi02f
        riDyg+0FtYVzi2Xnle41enpHbA==
X-Google-Smtp-Source: ABdhPJzA95A94Z472VFU9vAmc+HPReyzGeeCZqkyMoiR1mzXfho22J64Xns63Oxa8QqtMGimedlStA==
X-Received: by 2002:a92:c6cb:: with SMTP id v11mr23217522ilm.206.1592924073001;
        Tue, 23 Jun 2020 07:54:33 -0700 (PDT)
Received: from mail.matt.pallissard.net (223.91.188.35.bc.googleusercontent.com. [35.188.91.223])
        by smtp.gmail.com with ESMTPSA id w4sm7385041ioc.23.2020.06.23.07.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 07:54:32 -0700 (PDT)
Date:   Tue, 23 Jun 2020 07:54:29 -0700
From:   Matt Pallissard <matt@pallissard.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Subject: Re: Accessing mm_rss_stat fields with btf/BPF_CORE_READ_INTO
Message-ID: <20200623145429.zusbbebj52scumcr@matt-gen-desktop-p01.matt.pallissard.net>
References: <20200620162216.2ioyj6uzlpc45jzx@matt-gen-desktop-p01.matt.pallissard.net>
 <4889d766-578e-1e20-119f-9f97621e766f@fb.com>
 <20200620200602.ax7tjx5jrtgyj6vs@matt-gen-laptop-p01>
 <CAEf4Bzb1x5iGbb+mX0mz-mjLWvRvr9tn2SeQ3yVgd5eBagBc5w@mail.gmail.com>
 <20200621154428.pf6foowywrq3wxt2@matt-gen-laptop-p01>
 <20200622150128.hjwe3uak2sy7po22@matt-gen-desktop-p01.matt.pallissard.net>
 <CAEf4BzZt-aAo-t-eV=r3SNfgJh3rfqS8EFufz32VYKX9zOfXMQ@mail.gmail.com>
 <20200622171902.4q3pypddgyyp5p5r@matt-gen-desktop-p01.matt.pallissard.net>
 <CAEf4Bzb8U3SRQbxzLtTZihG3X=-OtQcYQApmJUhmuwqtXZaucg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzb8U3SRQbxzLtTZihG3X=-OtQcYQApmJUhmuwqtXZaucg@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 2020-06-22T15:09:57 -0700, Andrii Nakryiko wrote:
> On Mon, Jun 22, 2020 at 10:19 AM Matt Pallissard <matt@pallissard.net> wrote:
> >
> > On 2020-06-22T09:20:03 -0700, Andrii Nakryiko wrote:
> > > On Mon, Jun 22, 2020 at 8:01 AM Matt Pallissard <matt@pallissard.net> wrote:
> > > > On 2020-06-21T08:44:28 -0700, Matt Pallissard wrote:
> > > > > On 2020-06-20T20:29:43 -0700, Andrii Nakryiko wrote:
> > > > > > On Sat, Jun 20, 2020 at 1:07 PM Matt Pallissard <matt@pallissard.net> wrote:
> > > > > > > On 2020-06-20T11:11:55 -0700, Yonghong Song wrote:
> > > > > > > > On 6/20/20 9:22 AM, Matt Pallissard wrote:
> > > > > > > > > New to bpf here.
> > > > > > > > >
> > > > > > > > > I'm trying to read values out of of mm_struct.  I have code like this;
> > > > > > > > >
> > > > > > > > > unsigned long i[10] = {};
> > > > > > > > > struct task_struct *t;
> > > > > > > > > struct mm_rss_stat *rss;
> > > > > > > > >
> > > > > > > > > t = (struct task_struct *)bpf_get_current_task();
> > > > > > > > > BPF_CORE_READ_INTO(&rss, t, mm, rss_stat);
> > > > > > > > > BPF_CORE_READ_INTO(i, rss, count);
> > > > > > > > >
> > > > > > > > > However, all values in `i` appear to be 0 (i[MM_FILEPAGES], etc), as if no data gets copied.  I'm about 100% confident that this is caused by a glaring oversight on my part.
> > > > > > > >
> > > > > > > > Maybe you want to check the return value of BPF_CORE_READ_INTO.
> > > > > > > > Underlying it is using bpf_probe_read and bpf_probe_read may fail e.g., due
> > > > > > > > to major fault.
> > > > > > >
> > > > > > > Doh, I should have known to check the return codes!  Yes, it was failing.  I knew I was overlooking something trivial.
> > > > > > >
> > > > > >
> > > > > > I wrote exactly such piece of code a while ago. Here's part of it for
> > > > > > reference, I think it will be helpful:
> > > > > >
> > > > > >   struct task_struct *task = (struct task_struct *)bpf_get_current_task();
> > > > > >   const struct mm_struct *mm = BPF_CORE_READ(task, mm);
> > > > > >
> > > > > >   if (mm) {
> > > > > >       u64 hiwater_rss = BPF_CORE_READ(mm, hiwater_rss);
> > > > > >       u64 file_pages = BPF_CORE_READ(mm, rss_stat.count[MM_FILEPAGES].counter);
> > > > > >       u64 anon_pages = BPF_CORE_READ(mm, rss_stat.count[MM_ANONPAGES].counter);
> > > > > >       u64 shmem_pages = BPF_CORE_READ(mm,
> > > > > > rss_stat.count[MM_SHMEMPAGES].counter);
> > > > > >       u64 active_rss = file_pages + anon_pages + shmem_pages;
> > > > > >       /* ... */
> > > > >
> > > > > Thank you,
> > > > >
> > > > > After realizing that I was referencing the struct incorrectly, I wound up with a similar block of code.  However, as I started testing it against /proc/pid/smaps[,_rollup] I noticed that my numbers didn't match up.  Always smaller.
> > > > >
> > > > > I took a quick glance at fs/proc/task_mmu.c.  I think I'll have to walk some sort of accounting structure.
> > > >
> > > >
> > > > I started to take a hard look at fs/proc/task_mmu.c.  With all the locking, globals, and compile-time constants, I'm not sure that it's even possible to correctly walk `vm_area_struct` in bpf.
> > >
> > > Yes, you can't take all those locks from BPF. But reading atomic
> > > counters from BPF should be no problem. You might get a slightly out
> > > of sync readings, but whatever you are doing shouldn't expect to have
> > > 100% correct values anyways, because they might change so fast after
> > > you read them.
> >
> > That was my initial thought.  I didn't care to much about stale data, my only real concern was walking vm_area_struct and having memory freed.  I wasn't sure if that could break the list underneath me.  Although, that shouldn't be too difficult to get to the bottom of.
> >
>
> Not sure about vm_area_struct (where is it in the example above?), but
> mm_struct won't go away, because current task won't go away, because
> BPF program is running in the context of current. Similarly for
> bpf_iter, bpf_iter will actually take a refcnt on tast_struct. So I
> think you don't have to worry about that.

I didn't mention it explicitly in the example above.  But when I originally mentioned walking an accounting structure, as procfs does, it winds up being `mm_struct->mmap,vm_[next,prev]`, with mmap being a `vm_area_struct`.  But, it sounds like I should be abandoning that path and iterating over all the tasks.


> > > > If anyone has suggestions for getting memory numbers from an entire process, not just a task/thread, I'd love to hear them.  If not, I'll pursue this on my own.
> > >
> > > For this, you'd need to iterate across many tasks and aggregate their
> > > results based on tasks's tgid. Check iter/task programs in selftests
> > > (progs/bpf_iter_task.c, I think).


When I try to replicate some of the selftest task logic. I run into some errors when I call bpf_object__load.  `libbpf: task is not found in vmlinux BTF.`  I'll try matching the selftest code more closely and digging into that further.

As an aside; is there any documentation for bpf_iter outside of the selftests?

Matt Pallissard
