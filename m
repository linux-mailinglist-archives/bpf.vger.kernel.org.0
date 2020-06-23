Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CBB205AE8
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 20:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733214AbgFWSgS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 14:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732549AbgFWSgS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 14:36:18 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64465C061573
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 11:36:18 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l17so19745413qki.9
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 11:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PZldoJAHaZFSmKkIjWP2PYtF4NV5KkWpZni9lfTK1ms=;
        b=kVI2Exf/EnfDcTCkeOKoSM1JijWlhq/d+76MkLRga3Z/UV4y3vBiU2vfq/7CaBu6mX
         bSLyT8+yI76GEm3Yvi3OQnjngR5LW23cJnSF4lfYUk8+uQWh5RffC0/J+IyuEeZiNrEg
         Czd1LD1AqKr7vmuOfR220gNrYw11iqxglGjZha1f5V+O7ZL0EDnRDVaIR4bF77fSgFji
         B8hoG03OaQYI6BZutUu2Qeo4pkJa655r7Fy53/uWYn/02ZZOsHY2rGLF3FpwKwhBLYla
         D2RaZYvb8nnhh94kVBShaKItDF5I6Q03MwVxzArNf1ENbhkRnCkQHv7dZWpCeBKEGISt
         Qjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PZldoJAHaZFSmKkIjWP2PYtF4NV5KkWpZni9lfTK1ms=;
        b=UgBE5dp+u4TP48Toc8mNDriB3VKYZ/ALuhuPPoR36zzNLG7Jl8Q27jfqJH8O1SCaCX
         NAW1LcO0X4tsjxtHPJdA0bSECftSAQ7gyQ2d/6M01hE/NPsy1/Rcq/rvTxt7sPeG/Kyp
         zDDDD/UhKcDCbY6K4U5L7o+T2ygoIcvHgXgP9/7HELc17+DBXaBuVKNO6Yh23pjBAmn/
         NFzP6o5W3u6UaF8CxIjln1zL1He9kHdgrIO+jyGiiWoOLzIjZ1b7hCeZ/H/fPYqYx0ei
         aEYm48kHi0oxDd//tQmExPPt90b/xpogTmF3vtpIhfOuXPxQcsZsIGGFNQm/KXUYx4G4
         WKYw==
X-Gm-Message-State: AOAM533GfXmJFEMxL9qOlZvaPG7VNO0ee7/X9pT6BxpxfUOhDqZOYeQ1
        rGNyhhAbcE8mVmQFfOpWu2Vpqdx+tt2RZwN2OEU=
X-Google-Smtp-Source: ABdhPJw4KGDMujY//n61eX11pMbTU/aBiSxcK0RZJdcxEcfN29vlD1G9UjXZ6vJVKn5NDotCwlMeKv860Iqq2k2QL4M=
X-Received: by 2002:a05:620a:b84:: with SMTP id k4mr21833555qkh.39.1592937377493;
 Tue, 23 Jun 2020 11:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200620200602.ax7tjx5jrtgyj6vs@matt-gen-laptop-p01>
 <CAEf4Bzb1x5iGbb+mX0mz-mjLWvRvr9tn2SeQ3yVgd5eBagBc5w@mail.gmail.com>
 <20200621154428.pf6foowywrq3wxt2@matt-gen-laptop-p01> <20200622150128.hjwe3uak2sy7po22@matt-gen-desktop-p01.matt.pallissard.net>
 <CAEf4BzZt-aAo-t-eV=r3SNfgJh3rfqS8EFufz32VYKX9zOfXMQ@mail.gmail.com>
 <20200622171902.4q3pypddgyyp5p5r@matt-gen-desktop-p01.matt.pallissard.net>
 <CAEf4Bzb8U3SRQbxzLtTZihG3X=-OtQcYQApmJUhmuwqtXZaucg@mail.gmail.com>
 <20200623145429.zusbbebj52scumcr@matt-gen-desktop-p01.matt.pallissard.net>
 <8ffec8ff-664d-fd3e-12eb-49eac339b612@fb.com> <CAEf4BzbgQoi=NC6hM0j=49iGeexUEeuJFciMfipV+VDt+Luadg@mail.gmail.com>
 <20200623181105.luijy2q4vdzonlxk@matt-gen-desktop-p01.matt.pallissard.net>
In-Reply-To: <20200623181105.luijy2q4vdzonlxk@matt-gen-desktop-p01.matt.pallissard.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 23 Jun 2020 11:36:06 -0700
Message-ID: <CAEf4Bza4OFEeW59HGPtHcE2_2+KoT9h8B=Qzah58FtBf3EFoQg@mail.gmail.com>
Subject: Re: Accessing mm_rss_stat fields with btf/BPF_CORE_READ_INTO
To:     Matt Pallissard <matt@pallissard.net>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 23, 2020 at 11:11 AM Matt Pallissard <matt@pallissard.net> wrot=
e:
>
>
> On 2020-06-23T10:58:20 -0700, Andrii Nakryiko wrote:
> > On Tue, Jun 23, 2020 at 9:36 AM Yonghong Song <yhs@fb.com> wrote:
> > >
> > >
> > >
> > > On 6/23/20 7:54 AM, Matt Pallissard wrote:
> > > >
> > > > On 2020-06-22T15:09:57 -0700, Andrii Nakryiko wrote:
> > > >> On Mon, Jun 22, 2020 at 10:19 AM Matt Pallissard <matt@pallissard.=
net> wrote:
> > > >>>
> > > >>> On 2020-06-22T09:20:03 -0700, Andrii Nakryiko wrote:
> > > >>>> On Mon, Jun 22, 2020 at 8:01 AM Matt Pallissard <matt@pallissard=
.net> wrote:
> > > >>>>> On 2020-06-21T08:44:28 -0700, Matt Pallissard wrote:
> > > >>>>>> On 2020-06-20T20:29:43 -0700, Andrii Nakryiko wrote:
> > > >>>>>>> On Sat, Jun 20, 2020 at 1:07 PM Matt Pallissard <matt@palliss=
ard.net> wrote:
> > > >>>>>>>> On 2020-06-20T11:11:55 -0700, Yonghong Song wrote:
> > > >>>>>>>>> On 6/20/20 9:22 AM, Matt Pallissard wrote:
> > > >>>>>>>>>> New to bpf here.
> > > >>>>>>>>>>
> > > >>>>>>>>>> I'm trying to read values out of of mm_struct.  I have cod=
e like this;
> > > >>>>>>>>>>
> > > >>>>>>>>>> unsigned long i[10] =3D {};
> > > >>>>>>>>>> struct task_struct *t;
> > > >>>>>>>>>> struct mm_rss_stat *rss;
> > > >>>>>>>>>>
> > > >>>>>>>>>> t =3D (struct task_struct *)bpf_get_current_task();
> > > >>>>>>>>>> BPF_CORE_READ_INTO(&rss, t, mm, rss_stat);
> > > >>>>>>>>>> BPF_CORE_READ_INTO(i, rss, count);
> > > >>>>>>>>>>
> > > >>>>>>>>>> However, all values in `i` appear to be 0 (i[MM_FILEPAGES]=
, etc), as if no data gets copied.  I'm about 100% confident that this is c=
aused by a glaring oversight on my part.
> > > >>>>>>>>>
> > > >>>>>>>>> Maybe you want to check the return value of BPF_CORE_READ_I=
NTO.
> > > >>>>>>>>> Underlying it is using bpf_probe_read and bpf_probe_read ma=
y fail e.g., due
> > > >>>>>>>>> to major fault.
> > > >>>>>>>>
> > > >>>>>>>> Doh, I should have known to check the return codes!  Yes, it=
 was failing.  I knew I was overlooking something trivial.
> > > >>>>>>>>
> > > >>>>>>>
> > > >>>>>>> I wrote exactly such piece of code a while ago. Here's part o=
f it for
> > > >>>>>>> reference, I think it will be helpful:
> > > >>>>>>>
> > > >>>>>>>    struct task_struct *task =3D (struct task_struct *)bpf_get=
_current_task();
> > > >>>>>>>    const struct mm_struct *mm =3D BPF_CORE_READ(task, mm);
> > > >>>>>>>
> > > >>>>>>>    if (mm) {
> > > >>>>>>>        u64 hiwater_rss =3D BPF_CORE_READ(mm, hiwater_rss);
> > > >>>>>>>        u64 file_pages =3D BPF_CORE_READ(mm, rss_stat.count[MM=
_FILEPAGES].counter);
> > > >>>>>>>        u64 anon_pages =3D BPF_CORE_READ(mm, rss_stat.count[MM=
_ANONPAGES].counter);
> > > >>>>>>>        u64 shmem_pages =3D BPF_CORE_READ(mm,
> > > >>>>>>> rss_stat.count[MM_SHMEMPAGES].counter);
> > > >>>>>>>        u64 active_rss =3D file_pages + anon_pages + shmem_pag=
es;
> > > >>>>>>>        /* ... */
> > > >>>>>>
> > > >>>>>> Thank you,
> > > >>>>>>
> > > >>>>>> After realizing that I was referencing the struct incorrectly,=
 I wound up with a similar block of code.  However, as I started testing it=
 against /proc/pid/smaps[,_rollup] I noticed that my numbers didn't match u=
p.  Always smaller.
> > > >>>>>>
> > > >>>>>> I took a quick glance at fs/proc/task_mmu.c.  I think I'll hav=
e to walk some sort of accounting structure.
> > > >>>>>
> > > >>>>>
> > > >>>>> I started to take a hard look at fs/proc/task_mmu.c.  With all =
the locking, globals, and compile-time constants, I'm not sure that it's ev=
en possible to correctly walk `vm_area_struct` in bpf.
> > > >>>>
> > > >>>> Yes, you can't take all those locks from BPF. But reading atomic
> > > >>>> counters from BPF should be no problem. You might get a slightly=
 out
> > > >>>> of sync readings, but whatever you are doing shouldn't expect to=
 have
> > > >>>> 100% correct values anyways, because they might change so fast a=
fter
> > > >>>> you read them.
> > > >>>
> > > >>> That was my initial thought.  I didn't care to much about stale d=
ata, my only real concern was walking vm_area_struct and having memory free=
d.  I wasn't sure if that could break the list underneath me.  Although, th=
at shouldn't be too difficult to get to the bottom of.
> > > >>>
> > > >>
> > > >> Not sure about vm_area_struct (where is it in the example above?),=
 but
> > > >> mm_struct won't go away, because current task won't go away, becau=
se
> > > >> BPF program is running in the context of current. Similarly for
> > > >> bpf_iter, bpf_iter will actually take a refcnt on tast_struct. So =
I
> > > >> think you don't have to worry about that.
> > > >
> > > > I didn't mention it explicitly in the example above.  But when I or=
iginally mentioned walking an accounting structure, as procfs does, it wind=
s up being `mm_struct->mmap,vm_[next,prev]`, with mmap being a `vm_area_str=
uct`.  But, it sounds like I should be abandoning that path and iterating o=
ver all the tasks.
> > > >
> > > >
> > > >>>>> If anyone has suggestions for getting memory numbers from an en=
tire process, not just a task/thread, I'd love to hear them.  If not, I'll =
pursue this on my own.
> > > >>>>
> > > >>>> For this, you'd need to iterate across many tasks and aggregate =
their
> > > >>>> results based on tasks's tgid. Check iter/task programs in selft=
ests
> > > >>>> (progs/bpf_iter_task.c, I think).
> > > >
> > > >
> > > > When I try to replicate some of the selftest task logic. I run into=
 some errors when I call bpf_object__load.  `libbpf: task is not found in v=
mlinux BTF.`  I'll try matching the selftest code more closely and digging =
into that further.
> > >
> > > Somehow libbpf did not prepend `task` with `bpf_iter_` prefix. Not su=
re
> > > what is the exact issue. Yes, please mimic what selftests did.
> > >
> >
> > It's just an artifact of how libbpf logs error in such case. It did
> > search for "bpf_iter_task" type, though. But Matt probably doesn't
> > have a recent enough kernel or didn't build it with
> > CONFIG_DEBUG_INFO_BTF=3Dy and pahole 1.16+?
>
> That shouldn't be the case, I generated vmlinux.h from my currently runni=
ng machine.
>
>
> I'm using an upstream kernel.
> > ~ uname -r
> > 5.7.2-arch1-1
>
> Which has the BTF debug info enabled.
> > ~ zgrep BTF=3D /proc/config.gz
> > CONFIG_DEBUG_INFO_BTF=3Dy
>
>
> I assume that it was built with the version of pahole that's in the upstr=
eam repos.
> > ~ pacman -Ss pahole
> > extra/pahole 1.17-1 [installed]
>
>
> Unless I've came across some odd bug, I assume that I've implemented some=
thing incorrectly.
>

Ok, can you show your code (BPF and user-space side) and libbpf debug logs =
then?

>
> > > > As an aside; is there any documentation for bpf_iter outside of the=
 selftests?
> > >
> > > Unfortunately, no. The commit messages of the original patch set migh=
t help.
> > > https://lore.kernel.org/bpf/20200507053916.1542319-1-yhs@fb.com/T/#mf=
973843af65fc51ac9b3e3673962cd3e87f705e8
>
> Matt Pallissard
