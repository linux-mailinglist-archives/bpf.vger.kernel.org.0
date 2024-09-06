Return-Path: <bpf+bounces-39153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B7296F9FB
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 19:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7F14B220EC
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 17:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDC91D45ED;
	Fri,  6 Sep 2024 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkYp7DVd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB38D200DE
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 17:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725644277; cv=none; b=cssmXgEejHtA8Cac8kwuBWMVEfCUIeBONQnOlLQiZ5uGO6tJGDtEOwoUKiQO1b0oOmwM5s8XvpRDL7joXMPD5EjI2eeZ/GPY1rezZj6/DSQ7XrQgLKOeOC5tkwfBV/kydAKG4nisQCa+JJxvIy1+z1laYH6yefFqWDvG+3BJO7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725644277; c=relaxed/simple;
	bh=FY5lTF2RAO8h17gviigqEycicelL2JqWEkutGq/IBSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZV9+QC89pLVrjvl70HTnOgEGoJc6deuXxnQ4iFYXiZFmN7FWeBsUZgMxnr8eiuND0LUlmP8XrALnRToq8RXd1lFhlUmUt03OeUBEYmT/VIXlbLw1LvBI1vtH0ptVOYtGcyGjrNJeMioLXdpVPFvjQ5qVTo1Gb57wD/JVHxF8kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkYp7DVd; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2da4e84c198so1667471a91.0
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 10:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725644275; x=1726249075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXNAeQA5Mf+0Vk7q8DHamBmPcDDuBPfdgQzC1R0nJss=;
        b=TkYp7DVdYjZjLGEpgGABUC4oItNn420pFgQtcQatY74BjbwtTyD4HhdIxpVV7UQpiC
         zKRFqH6nkBIpg3HLJ3uy7NWqzm/q/f434Vxm2ndN8BwdwozoREYrelo+RRyZ7Hb2wrCS
         SSCYVG7lcOJz2HG9iLldqFFTSldBTar9ttXm2SYX9jy37RppqNRl6PTvYcAPELpGByvV
         cjWxIQh/OMJwIHEqWDKr5sdKHc1aD08Dq1ZbSqqLL46NmQMDxPMkw2x8eeUI5MISPyVB
         nJRo64uVBeQR3bEnJjjYaUgxQFqWBISIWf+JsidnRL1jXX9rduF1T1YOXehsRFo2J2Lv
         Izjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725644275; x=1726249075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXNAeQA5Mf+0Vk7q8DHamBmPcDDuBPfdgQzC1R0nJss=;
        b=wCKX1ji6tkw031C1lZwMU17t/f6yQ6B/xLAtJG4791T6M/BEWmOmZAA5XEiAAxPylj
         q4d2yIyEHbuGRd4pIDyJAdJ8+0fgDdwIkP9F0xZmRaAyJD4pWTXkZ39RQnEMvsuvXqYB
         y20t+4zKTjUae64R8uH6EXFm8Dww0MeSRej0DLXyGKZxo/yxov4c0KIM1v8QSYq9hdQZ
         bEbgban3lx8jirumIttu4GjKQ3TUaJwybDgctQIUhauZTkucBwJwv698G5oa2iIInf2N
         FbsXBAylhLIBjMEqCsedV4SOtTBFxxPG/e2dm8ZuWRmk2qFlq2cV5OgU90cIsrucHHiZ
         GfpA==
X-Forwarded-Encrypted: i=1; AJvYcCVsSoltnMcVkR1YiqSrVg5QFO2zdYWmjfkKnGJt7z7igHHrt0IrhidyaVbXi6Q1N0NsG/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzhJvQjQOOffGSsseT+3smkfawkZHHLQFOVbJwY5+7OiY/VxQA
	PKuP9kG8vjSGyhhp0UK15i1onPBxZyUZGCy8sb+z7bOd1IR2Y3ymsw6XPd0o0VaYqXCEVt7QHxW
	BTj4xOij6YItF6xGhm6scllPZJ+c=
X-Google-Smtp-Source: AGHT+IGd18Jx0lBbcnDW6vbMd0dN/nW4grGX4I+NJIu/dHblanupUnVVzz+xYIZm9lxNlEHvi4VpD0byEA5Z8ZOurdg=
X-Received: by 2002:a17:90a:eb08:b0:2d8:d254:6cdd with SMTP id
 98e67ed59e1d1-2d8d2547050mr18552337a91.38.1725644274991; Fri, 06 Sep 2024
 10:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725016029.git.vmalik@redhat.com> <92146771-8756-4259-88f0-e0b61c11ad55@oracle.com>
 <3adea7f7-0e8d-4114-ba04-356cdf9d20d1@redhat.com> <CAADnVQLmo0sOCuF598nL_xoowMDwTEXzjHareG1xiWGPLM77qA@mail.gmail.com>
 <CAEf4Bza=i15HZoZHyvGJrPdqUPbNxEGG5QWTDJKFnbOcT-jPZw@mail.gmail.com> <b157f640-98d0-4be1-ac30-35800032d094@redhat.com>
In-Reply-To: <b157f640-98d0-4be1-ac30-35800032d094@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Sep 2024 10:37:42 -0700
Message-ID: <CAEf4BzaU1_uv=r9c1jsd1pMBhQkB5wY+sJTyeCXTp-KUxVObVg@mail.gmail.com>
Subject: Re: [RFC bpf-next 0/3] libbpf: Add support for aliased BPF programs
To: Viktor Malik <vmalik@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 10:04=E2=80=AFPM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> On 9/4/24 21:07, Andrii Nakryiko wrote:
> > On Tue, Sep 3, 2024 at 1:19=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> On Mon, Sep 2, 2024 at 10:57=E2=80=AFPM Viktor Malik <vmalik@redhat.co=
m> wrote:
> >>>
> >>> On 9/2/24 19:01, Alan Maguire wrote:
> >>>> On 02/09/2024 07:58, Viktor Malik wrote:
> >>>>> TL;DR
> >>>>>
> >>>>> This adds libbpf support for creating multiple BPF programs having =
the
> >>>>> same instructions using symbol aliases.
> >>>>>
> >>>>> Context
> >>>>> =3D=3D=3D=3D=3D=3D=3D
> >>>>>
> >>>>> bpftrace has so-called "wildcarded" probes which allow to attach th=
e
> >>>>> same program to multple different attach points. For k(u)probes, th=
is is
> >>>>> easy to do as we can leverage k(u)probe_multi, however, other progr=
am
> >>>>> types (fentry/fexit, tracepoints) don't have such features.
> >>>>>
> >>>>> Currently, what bpftrace does is that it creates a copy of the prog=
ram
> >>>>> for each attach point. This naturally results in a lot of redundant=
 code
> >>>>> in the produced BPF object.
> >>>>>
> >>>>> Proposal
> >>>>> =3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>
> >>>>> One way to address this problem would be to use *symbol aliases*. I=
n
> >>>>> short, they allow to have multiple symbol table entries for the sam=
e
> >>>>> address. In bpftrace, we would create them using llvm::GlobalAlias.=
 In
> >>>>> C, it can be achieved using compiler __attribute__((alias(...))):
> >>>>>
> >>>>>     int BPF_PROG(prog)
> >>>>>     {
> >>>>>         [...]
> >>>>>     }
> >>>>>     int prog_alias() __attribute__((alias("prog")));
> >>>>>
> >>>>> When calling bpf_object__open, libbpf is currently able to discover=
 all
> >>>>> the programs and internally does a separate copy of the instruction=
s for
> >>>>> each aliased program. What libbpf cannot do, is perform relocations=
 b/c
> >>>>> it assumes that each instruction belongs to a single program only. =
The
> >>>>> second patch of this series changes relocation collection such that=
 it
> >>>>> records relocations for each aliased program. With that, bpftrace c=
an
> >>>>> emit just one copy of the full program and an alias for each target
> >>>>> attach point.
> >>>>>
> >>>>> For example, considering the following bpftrace script collecting t=
he
> >>>>> number of hits of each VFS function using fentry over a one second
> >>>>> period:
> >>>>>
> >>>>>     $ bpftrace -e 'kfunc:vfs_* { @[func] =3D count() } i:s:1 { exit=
() }'
> >>>>>     [...]
> >>>>>
> >>>>> this change will allow to reduce the size of the in-memory BPF obje=
ct
> >>>>> that bpftrace generates from 60K to 9K.
> >
> > Tbh, I'm not too keen on adding this aliasing complication just for
> > this. It seems a bit too intrusive for something so obscure.
> >
> > retsnoop doesn't need this and bypasses the issue by cloning with
> > bpf_prog_load(), can bpftrace follow the same model? If we need to add
> > some getters to bpf_program() to make this easier, that sounds like a
> > better long-term investment, API-wise.
>
> Yes, as I already mentioned, it should be possible to use cloning via
> bpf_prog_load(). The aliasing approach just seemed simpler from tool's
> perspective - you just emit one alias for each clone and libbpf takes
> care of the rest. But I admit that I anticipated the change to be much
> simpler than it turned out to be.
>
> Let me try add the cloning and I'll see if we could add something to
> libbpf to make it simpler.
>
> >
> >>>>>
> >>>>> For reference, the bpftrace PoC is in [1].
> >>>>>
> >>>>> The advantage of this change is that for BPF objects without aliase=
s, it
> >>>>> doesn't introduce any overhead.
> >>>>>
> >>>>
> >>>> A few high-level questions - apologies in advance if I'm missing the
> >>>> point here.
> >>>>
> >>>> Could bpftrace use program linking to solve this issue instead? So w=
e'd
> >>>> have separate progs for the various attach points associated with vf=
s_*
> >>>> functions, but they would all call the same global function. That
> >>>> _should_ reduce the memory footprint of the object I think - or are
> >>>> there issues with doing that?
> >>>
> >>> That's a good suggestion, thanks! We added subprograms to bpftrace on=
ly
> >>> relatively recently so I didn't really think about this option. I'll
> >>> definitely give it a try as it could be even more efficient.
> >>>
> >>>> I also wonder if aliasing helps memory
> >>>> footprint fully, especially if we end up with separate copies of the
> >>>> program for relocation purposes; won't we have separate copies in-ke=
rnel
> >>>> then too? So I _think_ the memory utilization you're concerned about=
 is
> >>>> not what's running in the kernel, but the BPF object representation =
in
> >>>> bpftrace; is that right?
> >>>
> >>> Yes, that is correct. libbpf will create a copy of the program for ea=
ch
> >>> symbol in PROGBITS section that it discovers (including aliases) and =
the
> >>> copies will be loaded into kernel.
> >>>
> >>> It's mainly the footprint of the BPF object produced by bpftrace that=
 I
> >>> was concerned about. (The reason is that we work on ahead-of-time
> >>> compilation so it will directly affect the size of the pre-compiled
> >>> binaries). But the above solution using global subprograms should red=
uce
> >>> the in-kernel footprint, too, so I'll try to add it and see if it wou=
ld
> >>> work for bpftrace.
> >>
> >> I think it's a half solution, since prog will be duplicated anyway and
> >> loaded multiple times into the kernel.
> >>
> >> I think it's better to revive this patch sets:
> >>
> >> v1:
> >> https://lore.kernel.org/bpf/20240220035105.34626-1-dongmenglong.8@byte=
dance.com/
> >>
> >> v2:
> >> https://lore.kernel.org/bpf/20240311093526.1010158-1-dongmenglong.8@by=
tedance.com/
> >>
> >> Unfortunately it went off rails, because we went deep into trying
> >> to save bpf trampoline memory too.
> >>
> >
> > +1 to adding multi-attach fentry, even if it will have to duplicate tra=
mpolines
>
> That would resolve fentry but the same problem still exists for (raw)
> tracepoints. In bpftrace, you may want to do something like
> `tracepoint:syscalls:sys_enter_* { ... }` and at the moment, we still
> need to the cloning in such case.

There are two problems for fentry: loading and attaching/detaching.
Given how fentry programs need to provide different attach_btf_id
during *load*, the load is the challenging part that requires cloning.

Then there is an attachment/detachment, which is just slow, but not
problematic logistically. Multi-fentry would solve/mitigate both.

But for tracepoints the load problem doesn't exist. You can load one
single instance of a program, and then attach multiple times to
different tracepoints. So cloning is not needed for tracepoints *at
all*.

If you want to know which tracepoint exactly you are processing at
runtime, use BPF cookie.

If you mean BTF-enabled raw tracepoints, then it's a separate thing
(and yes, there is a similar problem to fentry, of course).

But particularly for syscalls:sys_enter_*, I suspect the best solution
would be to attach generic sys_enter raw tracepoint and filter in
bpftrace by syscall number. Then it would be easy load, fast attach,
and most probably not worse runtime performance.

>
> But still, it does solve a part of the problem and could be useful for
> bpftrace to reduce the memory footprint for wildcarded fentry probes.
> I'll try to find some time to give this a shot (unless someone beats me
> to it).
>
> Viktor
>
> >
> >> I think it can still land.
> >> We can load fentry program once and attach it in multiple places
> >> with many bpf links.
> >> That is still worth doing.
> >
> > This part I'm confused about, but we can postpone discussion until
> > someone actually works on this.
> >
> >>
> >> I think it should solve retsnoop and bpftrace use cases.
> >> Not perfect, since there will be many trampolines, but still an improv=
ement.
> >>
> >
> > retsnoop is fine already through bpf_prog_load()-based cloning, but
> > faster attachment for fentry/fexit would definitely help.
> >
>

