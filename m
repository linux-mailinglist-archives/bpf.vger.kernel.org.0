Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64131203C5A
	for <lists+bpf@lfdr.de>; Mon, 22 Jun 2020 18:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbgFVQUR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Jun 2020 12:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729486AbgFVQUR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Jun 2020 12:20:17 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED669C061573
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 09:20:15 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id u12so2644996qth.12
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 09:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+2jU/nFVOM01wbd08DiwoZG+XcqCe0hwgDtmWk8AZ4s=;
        b=dutyKe79keAVuDh0G3ShbYFeSSLtmzG0DwITGNk6DWHeGCkbmPXldDYZ3jgIsAsnrB
         nKK9tzpvZJH8wOuv5NwMzfna39bRvraCJ2uZtkbXD6xcQMbHK9FpfdF/05l8fMwhKXrs
         9IPSGshpCU2Tu1PLdOXB/NsGSU65+Mhy3aohd2xmxrCnDTD/YdugBqBNnAyZg+3v7jjH
         U3YHi6zUKtZeGxa4asuEAmhC89BjldQglJYvCW0mAHKljlHHjIBqQVxE0JTyevo500X7
         zOI3T/73zPiEiFTDF4YCa/LQfRJd0VJCWf8zmnwSqgKROJQE3VOgPWqhV4opZ4ld/STZ
         Oeow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+2jU/nFVOM01wbd08DiwoZG+XcqCe0hwgDtmWk8AZ4s=;
        b=leJQW8L+Mu8eTQh0v+iPU6Zt7aKq/xOxaEypvCVYfYOxxi0UG7ik/w+smfkbHXn+mc
         JIpWviVGD3sIGmoOuf6vkLqRb96woB0X3+6ENetOnjgyg+SJy1xp9cjtfpIS4kMddxdX
         WRLeGqQksyfVmE5FJfpVG4Z7iJGXHR4aYjnGkbazayPKFBr0QNt7AgVKaMZ1RKNhZCAw
         DjAgmxGNtMbbRciZvdFr/m0FeZMBlxuaayBmOn9uWUP63RVSilYkBNw10l7nBV4P7Wa/
         RI0SIcR1vfk10QX/YTEFfGiIuCxNejOd8Hz+vLJPRmKveIQl0TEI26Y7/pRWOoZ+G2Yy
         /BSQ==
X-Gm-Message-State: AOAM530lOrk1tLOKzW7fpQE2pbreEHMhh5l/EFjePxav3focunjQLRqX
        b0MfuIzwO6tK/LFZWaU8uf90+3uLhrLPeZvb53hpUg==
X-Google-Smtp-Source: ABdhPJw6aZ729UamroBO8jbq91pZJeujR2U3yraQjv1Ez+3zhyW84ocKvr5/AFzweS11tSHfpPULjT2OQ5DFRgmiuyo=
X-Received: by 2002:ac8:4cc9:: with SMTP id l9mr3462388qtv.59.1592842815054;
 Mon, 22 Jun 2020 09:20:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200620162216.2ioyj6uzlpc45jzx@matt-gen-desktop-p01.matt.pallissard.net>
 <4889d766-578e-1e20-119f-9f97621e766f@fb.com> <20200620200602.ax7tjx5jrtgyj6vs@matt-gen-laptop-p01>
 <CAEf4Bzb1x5iGbb+mX0mz-mjLWvRvr9tn2SeQ3yVgd5eBagBc5w@mail.gmail.com>
 <20200621154428.pf6foowywrq3wxt2@matt-gen-laptop-p01> <20200622150128.hjwe3uak2sy7po22@matt-gen-desktop-p01.matt.pallissard.net>
In-Reply-To: <20200622150128.hjwe3uak2sy7po22@matt-gen-desktop-p01.matt.pallissard.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Jun 2020 09:20:03 -0700
Message-ID: <CAEf4BzZt-aAo-t-eV=r3SNfgJh3rfqS8EFufz32VYKX9zOfXMQ@mail.gmail.com>
Subject: Re: Accessing mm_rss_stat fields with btf/BPF_CORE_READ_INTO
To:     Matt Pallissard <matt@pallissard.net>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 22, 2020 at 8:01 AM Matt Pallissard <matt@pallissard.net> wrote:
>
>
>
> On 2020-06-21T08:44:28 -0700, Matt Pallissard wrote:
> >
> >
> > On 2020-06-20T20:29:43 -0700, Andrii Nakryiko wrote:
> > > On Sat, Jun 20, 2020 at 1:07 PM Matt Pallissard <matt@pallissard.net> wrote:
> > > >
> > > >
> > > >
> > > >
> > > > On 2020-06-20T11:11:55 -0700, Yonghong Song wrote:
> > > > >
> > > > >
> > > > > On 6/20/20 9:22 AM, Matt Pallissard wrote:
> > > > > > New to bpf here.
> > > > > >
> > > > > > I'm trying to read values out of of mm_struct.  I have code like this;
> > > > > >
> > > > > > unsigned long i[10] = {};
> > > > > > struct task_struct *t;
> > > > > > struct mm_rss_stat *rss;
> > > > > >
> > > > > > t = (struct task_struct *)bpf_get_current_task();
> > > > > > BPF_CORE_READ_INTO(&rss, t, mm, rss_stat);
> > > > > > BPF_CORE_READ_INTO(i, rss, count);
> > > > > >
> > > > > > However, all values in `i` appear to be 0 (i[MM_FILEPAGES], etc), as if no data gets copied.  I'm about 100% confident that this is caused by a glaring oversight on my part.
> > > > >
> > > > > Maybe you want to check the return value of BPF_CORE_READ_INTO.
> > > > > Underlying it is using bpf_probe_read and bpf_probe_read may fail e.g., due
> > > > > to major fault.
> > > >
> > > > Doh, I should have known to check the return codes!  Yes, it was failing.  I knew I was overlooking something trivial.
> > > >
> > >
> > > I wrote exactly such piece of code a while ago. Here's part of it for
> > > reference, I think it will be helpful:
> > >
> > >   struct task_struct *task = (struct task_struct *)bpf_get_current_task();
> > >   const struct mm_struct *mm = BPF_CORE_READ(task, mm);
> > >
> > >   if (mm) {
> > >       u64 hiwater_rss = BPF_CORE_READ(mm, hiwater_rss);
> > >       u64 file_pages = BPF_CORE_READ(mm, rss_stat.count[MM_FILEPAGES].counter);
> > >       u64 anon_pages = BPF_CORE_READ(mm, rss_stat.count[MM_ANONPAGES].counter);
> > >       u64 shmem_pages = BPF_CORE_READ(mm,
> > > rss_stat.count[MM_SHMEMPAGES].counter);
> > >       u64 active_rss = file_pages + anon_pages + shmem_pages;
> > >       /* ... */
> >
> > Thank you,
> >
> > After realizing that I was referencing the struct incorrectly, I wound up with a similar block of code.  However, as I started testing it against /proc/pid/smaps[,_rollup] I noticed that my numbers didn't match up.  Always smaller.
> >
> > I took a quick glance at fs/proc/task_mmu.c.  I think I'll have to walk some sort of accounting structure.
>
>
> I started to take a hard look at fs/proc/task_mmu.c.  With all the locking, globals, and compile-time constants, I'm not sure that it's even possible to correctly walk `vm_area_struct` in bpf.

Yes, you can't take all those locks from BPF. But reading atomic
counters from BPF should be no problem. You might get a slightly out
of sync readings, but whatever you are doing shouldn't expect to have
100% correct values anyways, because they might change so fast after
you read them.

>
> If anyone has suggestions for getting memory numbers from an entire process, not just a task/thread, I'd love to hear them.  If not, I'll pursue this on my own.

For this, you'd need to iterate across many tasks and aggregate their
results based on tasks's tgid. Check iter/task programs in selftests
(progs/bpf_iter_task.c, I think).

>
>
> Matt Pallissard
