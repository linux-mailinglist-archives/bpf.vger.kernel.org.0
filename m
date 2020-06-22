Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5713203DAE
	for <lists+bpf@lfdr.de>; Mon, 22 Jun 2020 19:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbgFVRTI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Jun 2020 13:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729309AbgFVRTH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Jun 2020 13:19:07 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ECAC061573
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 10:19:07 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id x9so2839023ila.3
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 10:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pallissard.net; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cfSDtIH/3g/WVK4RNClgcjPVTQErdDOYFr8yK8h2rUU=;
        b=IP5VkIIJGxuboJra8Zcm+VhuPr82x8zQKI3I2NtpV/xkQo32oSQuq2FzGD9YUS7q4i
         UqI06yi2r41k5KHcntRPgP6YhCpPc+7SlhQXE0DJLlvJ813H+0P0GqlcP+r4fi6nGA+N
         eb6uxUYRwSMnIGzFODZ4681oeFSpV7SELTPn+jrZ4EuXHYLdJ3kStuzL7K272UDBJ4YC
         Gk0ADkEsadmvjq0CHq3i+N1TAsjCoW7OFXNOdJc4EloexfFP57aZyDjWqwVzaOI/wY1a
         YWCFRfAmdcJ/6SU4F6PKcnZymGnc/rZ2r5BI5jDL9hX8CAY5/LfplakLGC1wg9gtjojH
         GE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cfSDtIH/3g/WVK4RNClgcjPVTQErdDOYFr8yK8h2rUU=;
        b=laDALur+/NdNfzeNdWA95+rBbNQD12C7V83b7urrk/Fp9a+71tJRJwocWOPvlmUVi6
         a4u7VGgSQK/MhD/biOULqIQD5RvYFGALtzdN+Z/FXsNAfBLfIX7K/dRJ2mmfSUx8m0DK
         e2KVbqFPdpvlWlGG/MqHuHjYxwRhqJ1iKCyljFJZ55KA7BnYewtqh0DxSp/WJ84/ubf1
         4FF+m3fp/5G/lT2tob6AFn7RPxMjYloE6nHsq1vHNZ3OUL19xMZk4O4uF/pciNa/UfvB
         fPHpmXodH1Qt2yU4wtENBbClBP0TElyhr/5VrYNyi+iXKi89ZZ+LjSlYbj0btCjgWQYx
         buew==
X-Gm-Message-State: AOAM533qDfly1vD+zsU/s7pfXuXnSf/5Rk1X5xYO2FFugvJkcW6jMpmE
        aB/OColz4f+TI3z4F/XDM0bbdA==
X-Google-Smtp-Source: ABdhPJw0quCEX1S4GuiVe4P06D+3n1QTaUo1FH31gzZhTE97Yl5wbCRpmguwnByqpZ7nY2hXkpJdqw==
X-Received: by 2002:a92:7788:: with SMTP id s130mr18002452ilc.136.1592846346531;
        Mon, 22 Jun 2020 10:19:06 -0700 (PDT)
Received: from mail.matt.pallissard.net (223.91.188.35.bc.googleusercontent.com. [35.188.91.223])
        by smtp.gmail.com with ESMTPSA id z20sm809263iot.15.2020.06.22.10.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 10:19:05 -0700 (PDT)
Date:   Mon, 22 Jun 2020 10:19:02 -0700
From:   Matt Pallissard <matt@pallissard.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Subject: Re: Accessing mm_rss_stat fields with btf/BPF_CORE_READ_INTO
Message-ID: <20200622171902.4q3pypddgyyp5p5r@matt-gen-desktop-p01.matt.pallissard.net>
References: <20200620162216.2ioyj6uzlpc45jzx@matt-gen-desktop-p01.matt.pallissard.net>
 <4889d766-578e-1e20-119f-9f97621e766f@fb.com>
 <20200620200602.ax7tjx5jrtgyj6vs@matt-gen-laptop-p01>
 <CAEf4Bzb1x5iGbb+mX0mz-mjLWvRvr9tn2SeQ3yVgd5eBagBc5w@mail.gmail.com>
 <20200621154428.pf6foowywrq3wxt2@matt-gen-laptop-p01>
 <20200622150128.hjwe3uak2sy7po22@matt-gen-desktop-p01.matt.pallissard.net>
 <CAEf4BzZt-aAo-t-eV=r3SNfgJh3rfqS8EFufz32VYKX9zOfXMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZt-aAo-t-eV=r3SNfgJh3rfqS8EFufz32VYKX9zOfXMQ@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2020-06-22T09:20:03 -0700, Andrii Nakryiko wrote:
> On Mon, Jun 22, 2020 at 8:01 AM Matt Pallissard <matt@pallissard.net> wrote:
> > On 2020-06-21T08:44:28 -0700, Matt Pallissard wrote:
> > > On 2020-06-20T20:29:43 -0700, Andrii Nakryiko wrote:
> > > > On Sat, Jun 20, 2020 at 1:07 PM Matt Pallissard <matt@pallissard.net> wrote:
> > > > > On 2020-06-20T11:11:55 -0700, Yonghong Song wrote:
> > > > > > On 6/20/20 9:22 AM, Matt Pallissard wrote:
> > > > > > > New to bpf here.
> > > > > > >
> > > > > > > I'm trying to read values out of of mm_struct.  I have code like this;
> > > > > > >
> > > > > > > unsigned long i[10] = {};
> > > > > > > struct task_struct *t;
> > > > > > > struct mm_rss_stat *rss;
> > > > > > >
> > > > > > > t = (struct task_struct *)bpf_get_current_task();
> > > > > > > BPF_CORE_READ_INTO(&rss, t, mm, rss_stat);
> > > > > > > BPF_CORE_READ_INTO(i, rss, count);
> > > > > > >
> > > > > > > However, all values in `i` appear to be 0 (i[MM_FILEPAGES], etc), as if no data gets copied.  I'm about 100% confident that this is caused by a glaring oversight on my part.
> > > > > >
> > > > > > Maybe you want to check the return value of BPF_CORE_READ_INTO.
> > > > > > Underlying it is using bpf_probe_read and bpf_probe_read may fail e.g., due
> > > > > > to major fault.
> > > > >
> > > > > Doh, I should have known to check the return codes!  Yes, it was failing.  I knew I was overlooking something trivial.
> > > > >
> > > >
> > > > I wrote exactly such piece of code a while ago. Here's part of it for
> > > > reference, I think it will be helpful:
> > > >
> > > >   struct task_struct *task = (struct task_struct *)bpf_get_current_task();
> > > >   const struct mm_struct *mm = BPF_CORE_READ(task, mm);
> > > >
> > > >   if (mm) {
> > > >       u64 hiwater_rss = BPF_CORE_READ(mm, hiwater_rss);
> > > >       u64 file_pages = BPF_CORE_READ(mm, rss_stat.count[MM_FILEPAGES].counter);
> > > >       u64 anon_pages = BPF_CORE_READ(mm, rss_stat.count[MM_ANONPAGES].counter);
> > > >       u64 shmem_pages = BPF_CORE_READ(mm,
> > > > rss_stat.count[MM_SHMEMPAGES].counter);
> > > >       u64 active_rss = file_pages + anon_pages + shmem_pages;
> > > >       /* ... */
> > >
> > > Thank you,
> > >
> > > After realizing that I was referencing the struct incorrectly, I wound up with a similar block of code.  However, as I started testing it against /proc/pid/smaps[,_rollup] I noticed that my numbers didn't match up.  Always smaller.
> > >
> > > I took a quick glance at fs/proc/task_mmu.c.  I think I'll have to walk some sort of accounting structure.
> >
> >
> > I started to take a hard look at fs/proc/task_mmu.c.  With all the locking, globals, and compile-time constants, I'm not sure that it's even possible to correctly walk `vm_area_struct` in bpf.
>
> Yes, you can't take all those locks from BPF. But reading atomic
> counters from BPF should be no problem. You might get a slightly out
> of sync readings, but whatever you are doing shouldn't expect to have
> 100% correct values anyways, because they might change so fast after
> you read them.

That was my initial thought.  I didn't care to much about stale data, my only real concern was walking vm_area_struct and having memory freed.  I wasn't sure if that could break the list underneath me.  Although, that shouldn't be too difficult to get to the bottom of.


> > If anyone has suggestions for getting memory numbers from an entire process, not just a task/thread, I'd love to hear them.  If not, I'll pursue this on my own.
>
> For this, you'd need to iterate across many tasks and aggregate their
> results based on tasks's tgid. Check iter/task programs in selftests
> (progs/bpf_iter_task.c, I think).

Sounds like a great starting point.  Thanks again.

Matt Pallissard
