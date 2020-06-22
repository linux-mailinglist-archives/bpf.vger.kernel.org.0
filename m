Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC208204356
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 00:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbgFVWKJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Jun 2020 18:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730763AbgFVWKJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Jun 2020 18:10:09 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31355C061573
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 15:10:09 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id z2so11891851qts.5
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 15:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5FVQQm7Md9g67e172vkmsTjZdBdISJyOedVT2OgwwHc=;
        b=gJEHjE6Ri0tSi59Fx2YHDUx37ViV2I5JI2ySZBKnskqDhzPtE3Hguonag+O+9Q/zXF
         jwzFyUBsHpis834IAjtzRxQmsbVX6bfAIRkdIAW9vXV1kadZtGjrOJJHg+NM14zmg20c
         jaRbeCXowaziCOHxCkidhSWeZN0Z7phtp2+YFb29zPiYtnuvZ2bsIM8HUdqRi/BLqmuw
         hbUEoZ783JwAFn/2ESYpk1tHetxgksIW1MSbykCpfGk4Z6XdnsyzqoH7VzupgnRGj+MY
         mOLORIZCBeyj5ruxTy2vr7i+sQs8CoddiaM7i5yt/cgNMhnaCyptn0BJ4lBXOT9wU8ZK
         t2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5FVQQm7Md9g67e172vkmsTjZdBdISJyOedVT2OgwwHc=;
        b=OUhSjLXxYluyZ6iCB+66X6lmEtLgEoFuz31KH1czIdSeR5JcJxLnsO6a4rmFCunf5Z
         ASlMNSsNh/uygKgsRIic3UhjMBVTYijSPdn5O5W/AFI0EqgjwURJaro7bxayFgdYu+U9
         /8cUmo5fxbujPHMRVMr9JaigtBu4/ocbiyJnqN3fj5saJfX7oRlc42gQ1Ub/U7HfOc+v
         mo5/XN20T9dFBEAL0H5tP/i/8J2o46Zck6GXS4ISz85czxnbulDpAzaDJRgIVdcahKuf
         1g4B56Y+ZJys9Fyq13k4Ab6HUNbwipMHLa3gjcpr29qy0o0CYLYKf/hXjLQZZca1U1RS
         e8fw==
X-Gm-Message-State: AOAM530xHeaBPfobJhGf61lAXMz6zi7NoW0OxPeOH9SQ7DRhmjYmyUtz
        gLCSrrZf5rPdAEJhTf3jQujLduvg+C/JIOCJC6U5vw==
X-Google-Smtp-Source: ABdhPJzk4bMTNzwkqi3gY2mjR6l3jTWZWReOF5r0t71mA8c1UFYZQeIgvjln/Z9A27KGRI4rQxmCPG6G+5crsLaH4VQ=
X-Received: by 2002:ac8:2bba:: with SMTP id m55mr18475311qtm.171.1592863808280;
 Mon, 22 Jun 2020 15:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200620162216.2ioyj6uzlpc45jzx@matt-gen-desktop-p01.matt.pallissard.net>
 <4889d766-578e-1e20-119f-9f97621e766f@fb.com> <20200620200602.ax7tjx5jrtgyj6vs@matt-gen-laptop-p01>
 <CAEf4Bzb1x5iGbb+mX0mz-mjLWvRvr9tn2SeQ3yVgd5eBagBc5w@mail.gmail.com>
 <20200621154428.pf6foowywrq3wxt2@matt-gen-laptop-p01> <20200622150128.hjwe3uak2sy7po22@matt-gen-desktop-p01.matt.pallissard.net>
 <CAEf4BzZt-aAo-t-eV=r3SNfgJh3rfqS8EFufz32VYKX9zOfXMQ@mail.gmail.com> <20200622171902.4q3pypddgyyp5p5r@matt-gen-desktop-p01.matt.pallissard.net>
In-Reply-To: <20200622171902.4q3pypddgyyp5p5r@matt-gen-desktop-p01.matt.pallissard.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Jun 2020 15:09:57 -0700
Message-ID: <CAEf4Bzb8U3SRQbxzLtTZihG3X=-OtQcYQApmJUhmuwqtXZaucg@mail.gmail.com>
Subject: Re: Accessing mm_rss_stat fields with btf/BPF_CORE_READ_INTO
To:     Matt Pallissard <matt@pallissard.net>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 22, 2020 at 10:19 AM Matt Pallissard <matt@pallissard.net> wrot=
e:
>
> On 2020-06-22T09:20:03 -0700, Andrii Nakryiko wrote:
> > On Mon, Jun 22, 2020 at 8:01 AM Matt Pallissard <matt@pallissard.net> w=
rote:
> > > On 2020-06-21T08:44:28 -0700, Matt Pallissard wrote:
> > > > On 2020-06-20T20:29:43 -0700, Andrii Nakryiko wrote:
> > > > > On Sat, Jun 20, 2020 at 1:07 PM Matt Pallissard <matt@pallissard.=
net> wrote:
> > > > > > On 2020-06-20T11:11:55 -0700, Yonghong Song wrote:
> > > > > > > On 6/20/20 9:22 AM, Matt Pallissard wrote:
> > > > > > > > New to bpf here.
> > > > > > > >
> > > > > > > > I'm trying to read values out of of mm_struct.  I have code=
 like this;
> > > > > > > >
> > > > > > > > unsigned long i[10] =3D {};
> > > > > > > > struct task_struct *t;
> > > > > > > > struct mm_rss_stat *rss;
> > > > > > > >
> > > > > > > > t =3D (struct task_struct *)bpf_get_current_task();
> > > > > > > > BPF_CORE_READ_INTO(&rss, t, mm, rss_stat);
> > > > > > > > BPF_CORE_READ_INTO(i, rss, count);
> > > > > > > >
> > > > > > > > However, all values in `i` appear to be 0 (i[MM_FILEPAGES],=
 etc), as if no data gets copied.  I'm about 100% confident that this is ca=
used by a glaring oversight on my part.
> > > > > > >
> > > > > > > Maybe you want to check the return value of BPF_CORE_READ_INT=
O.
> > > > > > > Underlying it is using bpf_probe_read and bpf_probe_read may =
fail e.g., due
> > > > > > > to major fault.
> > > > > >
> > > > > > Doh, I should have known to check the return codes!  Yes, it wa=
s failing.  I knew I was overlooking something trivial.
> > > > > >
> > > > >
> > > > > I wrote exactly such piece of code a while ago. Here's part of it=
 for
> > > > > reference, I think it will be helpful:
> > > > >
> > > > >   struct task_struct *task =3D (struct task_struct *)bpf_get_curr=
ent_task();
> > > > >   const struct mm_struct *mm =3D BPF_CORE_READ(task, mm);
> > > > >
> > > > >   if (mm) {
> > > > >       u64 hiwater_rss =3D BPF_CORE_READ(mm, hiwater_rss);
> > > > >       u64 file_pages =3D BPF_CORE_READ(mm, rss_stat.count[MM_FILE=
PAGES].counter);
> > > > >       u64 anon_pages =3D BPF_CORE_READ(mm, rss_stat.count[MM_ANON=
PAGES].counter);
> > > > >       u64 shmem_pages =3D BPF_CORE_READ(mm,
> > > > > rss_stat.count[MM_SHMEMPAGES].counter);
> > > > >       u64 active_rss =3D file_pages + anon_pages + shmem_pages;
> > > > >       /* ... */
> > > >
> > > > Thank you,
> > > >
> > > > After realizing that I was referencing the struct incorrectly, I wo=
und up with a similar block of code.  However, as I started testing it agai=
nst /proc/pid/smaps[,_rollup] I noticed that my numbers didn't match up.  A=
lways smaller.
> > > >
> > > > I took a quick glance at fs/proc/task_mmu.c.  I think I'll have to =
walk some sort of accounting structure.
> > >
> > >
> > > I started to take a hard look at fs/proc/task_mmu.c.  With all the lo=
cking, globals, and compile-time constants, I'm not sure that it's even pos=
sible to correctly walk `vm_area_struct` in bpf.
> >
> > Yes, you can't take all those locks from BPF. But reading atomic
> > counters from BPF should be no problem. You might get a slightly out
> > of sync readings, but whatever you are doing shouldn't expect to have
> > 100% correct values anyways, because they might change so fast after
> > you read them.
>
> That was my initial thought.  I didn't care to much about stale data, my =
only real concern was walking vm_area_struct and having memory freed.  I wa=
sn't sure if that could break the list underneath me.  Although, that shoul=
dn't be too difficult to get to the bottom of.
>

Not sure about vm_area_struct (where is it in the example above?), but
mm_struct won't go away, because current task won't go away, because
BPF program is running in the context of current. Similarly for
bpf_iter, bpf_iter will actually take a refcnt on tast_struct. So I
think you don't have to worry about that.

>
> > > If anyone has suggestions for getting memory numbers from an entire p=
rocess, not just a task/thread, I'd love to hear them.  If not, I'll pursue=
 this on my own.
> >
> > For this, you'd need to iterate across many tasks and aggregate their
> > results based on tasks's tgid. Check iter/task programs in selftests
> > (progs/bpf_iter_task.c, I think).
>
> Sounds like a great starting point.  Thanks again.
>
> Matt Pallissard
