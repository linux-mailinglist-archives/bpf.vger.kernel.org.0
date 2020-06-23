Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566BB205A08
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 19:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733069AbgFWR6d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 13:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgFWR6d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 13:58:33 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDCEC061573
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 10:58:32 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id t7so1240313qvl.8
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 10:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fcbcYKljcXS0XwaIyzJUi6HgtLmyNGwKqKYss9LMPTQ=;
        b=NQIcDiB5LdIal1fcHCa9hcQx5tndJEflc/oZIEdrl1zsYbNn1DWFD3ZCK9Nz9B1ZCU
         2B8+ggKGvSZ6l++QclpizDEYZk1IqqOM66MvLF+iLNdSAj0KEuh+9Rr9ubLAYEfcaQ+x
         4RK8f1/5M8Ng7XLTwv4j5iFRm21uYU3DvtiqVwunB2TxZxi84Q9uugpGPxW/IDMzTqxm
         u1rCk4SGuuKe6BDQV1Nsgl11w9SuezLQ8EarGn2CIEGu8F6nRf9HGYEQylZeUP5SmGBh
         uqdZ3Xs22p4ACVEjybCGXdKW2ZDLCEeOonmdo5MpNV70oQMUjbbzXg5ynM9lox30fGY8
         cnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fcbcYKljcXS0XwaIyzJUi6HgtLmyNGwKqKYss9LMPTQ=;
        b=p+lbXweJPCZ7C/fMBdDTX3gaDk+QPCrSJwfbeGC+QzAgeuptGSRTTsYzF17lTya4yc
         LVCpPg3wRnY5GvUNBW4hgXmo8kT549ey00zG7o7dR6EOO8OQXL7LZSO5WKZ/C2RmAChW
         3kF2BNwqCIl+PSQ4+jLTuaTXQOjInCZrtiTdvuQh2fTjFxkP6NXK0Lv6rjRecdeFdmsh
         9NdgqNfsNzdsC8/y+/EoSMWvbcAQwSa5xD3AlZ0vqfm1zIHx5Kdwf2NpDctse9jxv7oA
         1Z0/yeo3IWH67pl+kqGOxzaE2axxFNG9TU1fVDggNc+c4BfvxapziOrY192sS7iZTXV2
         8Egw==
X-Gm-Message-State: AOAM531KgWfnmaiT8iXBLccrKQwKbAg03KEKutuhgZlPaXndZtGFLCnl
        DF5SYWFBkoJOEx9BhZROvV95awQEFLNe+z85SdU=
X-Google-Smtp-Source: ABdhPJyxuDNyNZnBhjDKEwlHdFuEm4Ti0DdlmmSrqy0nPUQgyXYjM1HsQGZ/PUeijZ8iUxPdBAnory7uW6Bd5Vc0aH8=
X-Received: by 2002:a0c:a2e3:: with SMTP id g90mr1090626qva.163.1592935111947;
 Tue, 23 Jun 2020 10:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200620162216.2ioyj6uzlpc45jzx@matt-gen-desktop-p01.matt.pallissard.net>
 <4889d766-578e-1e20-119f-9f97621e766f@fb.com> <20200620200602.ax7tjx5jrtgyj6vs@matt-gen-laptop-p01>
 <CAEf4Bzb1x5iGbb+mX0mz-mjLWvRvr9tn2SeQ3yVgd5eBagBc5w@mail.gmail.com>
 <20200621154428.pf6foowywrq3wxt2@matt-gen-laptop-p01> <20200622150128.hjwe3uak2sy7po22@matt-gen-desktop-p01.matt.pallissard.net>
 <CAEf4BzZt-aAo-t-eV=r3SNfgJh3rfqS8EFufz32VYKX9zOfXMQ@mail.gmail.com>
 <20200622171902.4q3pypddgyyp5p5r@matt-gen-desktop-p01.matt.pallissard.net>
 <CAEf4Bzb8U3SRQbxzLtTZihG3X=-OtQcYQApmJUhmuwqtXZaucg@mail.gmail.com>
 <20200623145429.zusbbebj52scumcr@matt-gen-desktop-p01.matt.pallissard.net> <8ffec8ff-664d-fd3e-12eb-49eac339b612@fb.com>
In-Reply-To: <8ffec8ff-664d-fd3e-12eb-49eac339b612@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 23 Jun 2020 10:58:20 -0700
Message-ID: <CAEf4BzbgQoi=NC6hM0j=49iGeexUEeuJFciMfipV+VDt+Luadg@mail.gmail.com>
Subject: Re: Accessing mm_rss_stat fields with btf/BPF_CORE_READ_INTO
To:     Yonghong Song <yhs@fb.com>
Cc:     Matt Pallissard <matt@pallissard.net>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 23, 2020 at 9:36 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 6/23/20 7:54 AM, Matt Pallissard wrote:
> >
> > On 2020-06-22T15:09:57 -0700, Andrii Nakryiko wrote:
> >> On Mon, Jun 22, 2020 at 10:19 AM Matt Pallissard <matt@pallissard.net>=
 wrote:
> >>>
> >>> On 2020-06-22T09:20:03 -0700, Andrii Nakryiko wrote:
> >>>> On Mon, Jun 22, 2020 at 8:01 AM Matt Pallissard <matt@pallissard.net=
> wrote:
> >>>>> On 2020-06-21T08:44:28 -0700, Matt Pallissard wrote:
> >>>>>> On 2020-06-20T20:29:43 -0700, Andrii Nakryiko wrote:
> >>>>>>> On Sat, Jun 20, 2020 at 1:07 PM Matt Pallissard <matt@pallissard.=
net> wrote:
> >>>>>>>> On 2020-06-20T11:11:55 -0700, Yonghong Song wrote:
> >>>>>>>>> On 6/20/20 9:22 AM, Matt Pallissard wrote:
> >>>>>>>>>> New to bpf here.
> >>>>>>>>>>
> >>>>>>>>>> I'm trying to read values out of of mm_struct.  I have code li=
ke this;
> >>>>>>>>>>
> >>>>>>>>>> unsigned long i[10] =3D {};
> >>>>>>>>>> struct task_struct *t;
> >>>>>>>>>> struct mm_rss_stat *rss;
> >>>>>>>>>>
> >>>>>>>>>> t =3D (struct task_struct *)bpf_get_current_task();
> >>>>>>>>>> BPF_CORE_READ_INTO(&rss, t, mm, rss_stat);
> >>>>>>>>>> BPF_CORE_READ_INTO(i, rss, count);
> >>>>>>>>>>
> >>>>>>>>>> However, all values in `i` appear to be 0 (i[MM_FILEPAGES], et=
c), as if no data gets copied.  I'm about 100% confident that this is cause=
d by a glaring oversight on my part.
> >>>>>>>>>
> >>>>>>>>> Maybe you want to check the return value of BPF_CORE_READ_INTO.
> >>>>>>>>> Underlying it is using bpf_probe_read and bpf_probe_read may fa=
il e.g., due
> >>>>>>>>> to major fault.
> >>>>>>>>
> >>>>>>>> Doh, I should have known to check the return codes!  Yes, it was=
 failing.  I knew I was overlooking something trivial.
> >>>>>>>>
> >>>>>>>
> >>>>>>> I wrote exactly such piece of code a while ago. Here's part of it=
 for
> >>>>>>> reference, I think it will be helpful:
> >>>>>>>
> >>>>>>>    struct task_struct *task =3D (struct task_struct *)bpf_get_cur=
rent_task();
> >>>>>>>    const struct mm_struct *mm =3D BPF_CORE_READ(task, mm);
> >>>>>>>
> >>>>>>>    if (mm) {
> >>>>>>>        u64 hiwater_rss =3D BPF_CORE_READ(mm, hiwater_rss);
> >>>>>>>        u64 file_pages =3D BPF_CORE_READ(mm, rss_stat.count[MM_FIL=
EPAGES].counter);
> >>>>>>>        u64 anon_pages =3D BPF_CORE_READ(mm, rss_stat.count[MM_ANO=
NPAGES].counter);
> >>>>>>>        u64 shmem_pages =3D BPF_CORE_READ(mm,
> >>>>>>> rss_stat.count[MM_SHMEMPAGES].counter);
> >>>>>>>        u64 active_rss =3D file_pages + anon_pages + shmem_pages;
> >>>>>>>        /* ... */
> >>>>>>
> >>>>>> Thank you,
> >>>>>>
> >>>>>> After realizing that I was referencing the struct incorrectly, I w=
ound up with a similar block of code.  However, as I started testing it aga=
inst /proc/pid/smaps[,_rollup] I noticed that my numbers didn't match up.  =
Always smaller.
> >>>>>>
> >>>>>> I took a quick glance at fs/proc/task_mmu.c.  I think I'll have to=
 walk some sort of accounting structure.
> >>>>>
> >>>>>
> >>>>> I started to take a hard look at fs/proc/task_mmu.c.  With all the =
locking, globals, and compile-time constants, I'm not sure that it's even p=
ossible to correctly walk `vm_area_struct` in bpf.
> >>>>
> >>>> Yes, you can't take all those locks from BPF. But reading atomic
> >>>> counters from BPF should be no problem. You might get a slightly out
> >>>> of sync readings, but whatever you are doing shouldn't expect to hav=
e
> >>>> 100% correct values anyways, because they might change so fast after
> >>>> you read them.
> >>>
> >>> That was my initial thought.  I didn't care to much about stale data,=
 my only real concern was walking vm_area_struct and having memory freed.  =
I wasn't sure if that could break the list underneath me.  Although, that s=
houldn't be too difficult to get to the bottom of.
> >>>
> >>
> >> Not sure about vm_area_struct (where is it in the example above?), but
> >> mm_struct won't go away, because current task won't go away, because
> >> BPF program is running in the context of current. Similarly for
> >> bpf_iter, bpf_iter will actually take a refcnt on tast_struct. So I
> >> think you don't have to worry about that.
> >
> > I didn't mention it explicitly in the example above.  But when I origin=
ally mentioned walking an accounting structure, as procfs does, it winds up=
 being `mm_struct->mmap,vm_[next,prev]`, with mmap being a `vm_area_struct`=
.  But, it sounds like I should be abandoning that path and iterating over =
all the tasks.
> >
> >
> >>>>> If anyone has suggestions for getting memory numbers from an entire=
 process, not just a task/thread, I'd love to hear them.  If not, I'll purs=
ue this on my own.
> >>>>
> >>>> For this, you'd need to iterate across many tasks and aggregate thei=
r
> >>>> results based on tasks's tgid. Check iter/task programs in selftests
> >>>> (progs/bpf_iter_task.c, I think).
> >
> >
> > When I try to replicate some of the selftest task logic. I run into som=
e errors when I call bpf_object__load.  `libbpf: task is not found in vmlin=
ux BTF.`  I'll try matching the selftest code more closely and digging into=
 that further.
>
> Somehow libbpf did not prepend `task` with `bpf_iter_` prefix. Not sure
> what is the exact issue. Yes, please mimic what selftests did.
>

It's just an artifact of how libbpf logs error in such case. It did
search for "bpf_iter_task" type, though. But Matt probably doesn't
have a recent enough kernel or didn't build it with
CONFIG_DEBUG_INFO_BTF=3Dy and pahole 1.16+?

> >
> > As an aside; is there any documentation for bpf_iter outside of the sel=
ftests?
>
> Unfortunately, no. The commit messages of the original patch set might he=
lp.
> https://lore.kernel.org/bpf/20200507053916.1542319-1-yhs@fb.com/T/#mf9738=
43af65fc51ac9b3e3673962cd3e87f705e8
>
> >
> > Matt Pallissard
> >
