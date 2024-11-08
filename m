Return-Path: <bpf+bounces-44367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C1B9C241D
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 18:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB1F1C219A4
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 17:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F4A233D7D;
	Fri,  8 Nov 2024 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0QN6jQo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA74233D6B;
	Fri,  8 Nov 2024 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087457; cv=none; b=UeN9dg+1eaQJNubQXLsdCLVSoxDPPacH4tZN0uAwlrZFYwpkWPujFphUJBEy8LPY3QJrTHvj8S8/HZhpO+zi7GNqdeDtwUnH3Pjn2WdA2MFgFVPJaQgxeTBzZMO+xVhvLTbpxffWOfpbb9eOa612hiLmSshehvKeOSrSQkl3Hbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087457; c=relaxed/simple;
	bh=Vvq/YKTSjFn4Y2HWmcj9+gDtJOOeJspx2LctGJfzsYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2Kvsj7YK/AkSIIMre5XScL01SMM25TWRQzqUqEohiWU7avuUil3rnbhb9pVzoayMbOVzh/zUZFSYFA6ir68VjY1mHgGfHdv9DVtwAtzX1wokj8w5p9a2WFcnfVXg/sSDRuuXD7Ism1CmGSIM0L9Qcg8unPNN0hohIqLYoela5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0QN6jQo; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2114214c63eso21191495ad.3;
        Fri, 08 Nov 2024 09:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731087454; x=1731692254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHOKMiqqzx2c1YzXsPIp/CUVBnWihCd9oMbA+qNvYZY=;
        b=F0QN6jQorhK1UOMan+u/kA1rDJgK2E24mR8BNsPjgA9qJC726ywmlmb5Blvr1YQhMj
         DTCOkZz04NQP1qYMDWgdS9vv6Y/Fr9YQXr91BFWtnCWKfEC3oUZlZz5q/DUgxCRRzWRZ
         MAzh/sKzyU0PLmbqYXIp+bB/XTJEiQfLHqubAkrHUnWHtM/XPlg+WZAfB4qvgTQ0+g61
         Wt3d4Z10hlZV7ChRsPCfL9qarlVgM44SzG9ilmQnbP88VJxmMGNQbI/BNeaR64m0ARSD
         hotJAGmqftvKnVwJLNUjsbWQ+4vDeYLSJzHjdQwZy2UZ6HKLvTrxCNIHrMJOdMcZsPxs
         u/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731087454; x=1731692254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHOKMiqqzx2c1YzXsPIp/CUVBnWihCd9oMbA+qNvYZY=;
        b=rUZ4plsfb83B2HNdf4D1XgPxKoEjMme29drvau7vrCNCbpLm/KLhuQw+i2A2+Dh9yy
         3uF79O+kOn0P7F+NCOE0zg8mwgFu/bzuUfZqP2qpIdnMTHVy4fapTlFXiutPJFkpj86e
         zKwnLJh7jj7Uq5JToRF6pnliQPYkVJgazVIMR/Wx6C5o148RX11LZlIwSYD4MgTSMLiE
         R6jImkWXGJZnMmGY1KU7U3mb78s9VlW3Cl7EHIOOas5IWGq/tTI/EVMGrDTLddp5745V
         A+zPb3y6JSXPm7F5kvEtxzvY4TLTgI4JBO28yJIhAgHgxFWDBwz16h2EBJuphRn7g4WJ
         FA9w==
X-Forwarded-Encrypted: i=1; AJvYcCV3bAbN+3qcta4gge7b1CPLF5NEzz4Mms7QQD+lDQ0QPYBHA3zxpALyKYf2zQeEkbQCULdFF0RVwH3gRN0R@vger.kernel.org, AJvYcCVLzvD9FFKJNxPE+ivWmcCnFB+gd4/QIFI2KpCzu0WNs0QYyQesBGII6DI93Rfloo/Ibmerg/j8C7YNv9VlAMLp1HKh@vger.kernel.org, AJvYcCWtH6OuM5Nq9qMCzurR1s6XOVLHuHX7RXHRHHNRnSLVBZENhyMtDeEZwUJLbLqRAU21mic=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKCAYB6LZNyRlW7zjcsUEctXqulB9MrmSff1hCEeBd2M0MnPO1
	WcUtlCoSBoGkE8QK2swW/Dfi3Fk6cEYrrpCVeLr0iyO3PfDU1LM8lL+c/KxvgkkJOV8fOGyAckm
	hZOLI5sY5hIEU3yHI1vj6VXsHRyU=
X-Google-Smtp-Source: AGHT+IGe9d5q0fr286TZuB17V8t8ET7pCDzNkg+AILrBeFfPTt6qr7vCCmzGJ0U2gmrWuAm1vWncflEJatMJCbLcJ3o=
X-Received: by 2002:a17:902:cec9:b0:20b:a5b5:b89 with SMTP id
 d9443c01a7336-2118359cb0cmr42513815ad.35.1731087453502; Fri, 08 Nov 2024
 09:37:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910060407.1427716-1-liaochang1@huawei.com>
 <ZxpUX1rbppLqS0bD@J2N7QTR9R3.cambridge.arm.com> <CAEf4Bzb9fM+hx8quHpCCeRh2p7UVk9Kk6yGj3XvyJLTQu9C-2w@mail.gmail.com>
 <46451dbe-056c-4c13-bfae-7ee8d6e115b5@huawei.com> <CAEf4BzYBAtNbCyCLybPxQrp-CZ9NVOco9X=xctnQ7BuDfhoadA@mail.gmail.com>
 <000d70e5-0d54-4a75-b95b-9b11d95541a7@huawei.com>
In-Reply-To: <000d70e5-0d54-4a75-b95b-9b11d95541a7@huawei.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 8 Nov 2024 09:37:21 -0800
Message-ID: <CAEf4Bzbn6iSX-d9dFkYgzy_Ge-eNzR8bwTtYMToNnUf=GTBUYA@mail.gmail.com>
Subject: Re: [PATCH] arm64: uprobes: Simulate STP for pushing fp/lr into user stack
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com, will@kernel.org, 
	mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org, ast@kernel.org, 
	puranjay@kernel.org, andrii@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 7:13=E2=80=AFPM Liao, Chang <liaochang1@huawei.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/11/7 3:45, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Tue, Nov 5, 2024 at 4:22=E2=80=AFAM Liao, Chang <liaochang1@huawei.c=
om> wrote:
> >>
> >> Andrii and Mark.
> >>
> >> =E5=9C=A8 2024/10/26 4:51, Andrii Nakryiko =E5=86=99=E9=81=93:
> >>> On Thu, Oct 24, 2024 at 7:06=E2=80=AFAM Mark Rutland <mark.rutland@ar=
m.com> wrote:
> >>>>
> >>>> On Tue, Sep 10, 2024 at 06:04:07AM +0000, Liao Chang wrote:
> >>>>> This patch is the second part of a series to improve the selftest b=
ench
> >>>>> of uprobe/uretprobe [0]. The lack of simulating 'stp fp, lr, [sp, #=
imm]'
> >>>>> significantly impact uprobe/uretprobe performance at function entry=
 in
> >>>>> most user cases. Profiling results below reveals the STP that execu=
tes
> >>>>> in the xol slot and trap back to kernel, reduce redis RPS and incre=
ase
> >>>>> the time of string grep obviously.
> >>>>>
> >>>>> On Kunpeng916 (Hi1616), 4 NUMA nodes, 64 Arm64 cores@2.4GHz.
> >>>>>
> >>>>> Redis GET (higher is better)
> >>>>> ----------------------------
> >>>>> No uprobe: 49149.71 RPS
> >>>>> Single-stepped STP: 46750.82 RPS
> >>>>> Emulated STP: 48981.19 RPS
> >>>>>
> >>>>> Redis SET (larger is better)
> >>>>> ----------------------------
> >>>>> No uprobe: 49761.14 RPS
> >>>>> Single-stepped STP: 45255.01 RPS
> >>>>> Emulated stp: 48619.21 RPS
> >>>>>
> >>>>> Grep (lower is better)
> >>>>> ----------------------
> >>>>> No uprobe: 2.165s
> >>>>> Single-stepped STP: 15.314s
> >>>>> Emualted STP: 2.216s
> >>>>
> >>>> The results for grep are concerning.
> >>>>
> >>>> In theory, the overhead for stepping should be roughly double the
> >>>> overhead for emulating, assuming the exception-entry and
> >>>> exception-return are the dominant cost. The cost of stepping should =
be
> >>>> trivial.
> >>>>
> >>>> Those results show emulating adds 0.051s (for a ~2.4% overhead), whi=
le
> >>>> stepping adds 13.149s (for a ~607% overhead), meaning stepping is 25=
0x
> >>>> more expensive.
> >>>>
> >>>> Was this tested bare-metal, or in a VM?
> >>>
> >>> Hey Mark, I hope Liao will have a chance to reply, I don't know the
> >>> details of his benchmarking. But I can try to give you my numbers and
> >>> maybe answer a few questions, hopefully that helps move the
> >>> conversation forward.
> >>>
> >>> So, first of all, I did a quick benchmark on bare metal (without
> >>> Liao's optimization, though), here are my results:
> >>>
> >>> uprobe-nop            ( 1 cpus):    2.334 =C2=B1 0.011M/s  (  2.334M/=
s/cpu)
> >>> uprobe-push           ( 1 cpus):    2.321 =C2=B1 0.010M/s  (  2.321M/=
s/cpu)
> >>> uprobe-ret            ( 1 cpus):    4.144 =C2=B1 0.041M/s  (  4.144M/=
s/cpu)
> >>>
> >>> uretprobe-nop         ( 1 cpus):    1.684 =C2=B1 0.004M/s  (  1.684M/=
s/cpu)
> >>> uretprobe-push        ( 1 cpus):    1.736 =C2=B1 0.003M/s  (  1.736M/=
s/cpu)
> >>> uretprobe-ret         ( 1 cpus):    2.502 =C2=B1 0.006M/s  (  2.502M/=
s/cpu)
> >>>
> >>> uretprobes are inherently slower, so I'll just compare uprobe, as the
> >>> differences are very clear either way.
> >>>
> >>> -nop is literally nop (Liao solved that issue, I just don't have his
> >>> patch applied on my test machine). -push has `stp     x29, x30, [sp,
> >>> #-0x10]!` instruction traced. -ret is literally just `ret`
> >>> instruction.
> >>>
> >>> So you can see that -ret is almost twice as fast as the -push variant
> >>> (it's a microbenchmark, yes, but still).
> >>>
> >>>>
> >>>> AFAICT either:
> >>>>
> >>>> * Single-stepping is unexpectedly expensive.
> >>>>
> >>>>   Historically we had performance issues with hypervisor trapping of
> >>>>   debug features, and there are things we might be able to improve i=
n
> >>>>   the hypervisor and kernel, which would improve stepping *all*
> >>>>   instructions.
> >>>>
> >>>
> >>> Single-stepping will always be more expensive, as it necessitates
> >>> extra hop kernel->user space->kernel, so no matter the optimization
> >>> for single-stepping, if we can avoid it, we should. It will be
> >>> noticeable.
> >>>
> >>>>   If stepping is the big problem, we could move uprobes over to a BR=
K
> >>>>   rather than a single-step. That would require require updating and
> >>>>   fixing the logic to decide which instructions are steppable, but
> >>>>   that's necessary anyway given it has extant soundness issues.
> >>>
> >>> I'm afraid I don't understand what BRK means and what are the
> >>> consequences in terms of overheads. I'm not an ARM person either, so
> >>> sorry if that's a stupid question. But either way, I can't address
> >>> this. But see above, emulating an instruction feels like a much bette=
r
> >>> approach, if possible.
> >>
> >> As I understand, Mark's suggestion is to place a BRK instruction next =
to
> >> the instruction in the xol slot. Once the instruction in the xol slot
> >> executed, the BRK instruction would trigger a trap into kernel. This i=
s
> >> a common technique used on platforms that don't support hardware singl=
e-
> >> step. However, since Arm64 does support hardware single-stepping, kern=
el
> >> enables it in pre_ssout(), allowing the CPU to automatically trap into=
 kernel
> >> after instruction in xol slot executed. But even we move uprobes over
> >> to a BRK rather than a single-step. It can't reduce the overhead of us=
er->
> >> kernel->user context switch on the bare-metal. Maybe I am wrong, Mark,
> >> could you give more details about the BRK.
> >>
> >
> > I see, thanks for elaborating. So the suggestion was to go from very
> > expensive single-stepping mode to still expensive breakpoint-based
> > kernel->user->kernel workflow.
> >
> > I think either way it's going to be much slower than avoiding
> > kernel->user->kernel hop, so we should emulate STP instead, yep.
>
> Exactly, in most cases, simluation is the better option.
>
> >
> >>>
> >>>>
> >>>> * XOL management is absurdly expensive.
> >>>>
> >>>>   Does uprobes keep the XOL slot around (like krpobes does), or does=
 it
> >>>>   create the slot afresh for each trap?
> >>>
> >>> XOL *page* is created once per process, lazily, and then we just
> >>> juggle a bunch of fixed slots there for each instance of
> >>> single-stepped uprobe. And yes, there are some bottlenecks in XOL
> >>> management, though it's mostly due to lock contention (as it is
> >>> implemented right now). Liao and Oleg have been improving XOL
> >>> management, but still, avoiding XOL in the first place is the much
> >>> preferred way.
> >>>
> >>>>
> >>>>   If that's trying to create a slot afresh for each trap, there are
> >>>>   several opportunities for improvement, e.g. keep the slot around f=
or
> >>>>   as long as the uprobe exists, or pre-allocate shared slots for com=
mon
> >>>>   instructions and use those.
> >>>
> >>> As I mentioned, a XOL page is allocated and mapped once, but yes, it
> >>> seems like we dynamically get a slot in it for each single-stepped
> >>> execution (see xol_take_insn_slot() in kernel/events/uprobes.c). It's
> >>> probably not a bad idea to just cache and hold a XOL slot for each
> >>> specific uprobe, I don't see why we should limit ourselves to just on=
e
> >>> XOL page. We also don't need to pre-size each slot, we can probably
> >>> allocate just the right amount of space for a given uprobe.
> >>>
> >>> All good ideas for sure, we should do them, IMO. But we'll still be
> >>> paying an extra kernel->user->kernel switch, which almost certainly i=
s
> >>> slower than doing a simple stack push emulation just like we do in
> >>> x86-64 case, no?
> >>>
> >>>
> >>> BTW, I did a quick local profiling run. I don't think XOL management
> >>> is the main source of overhead. I see 5% of CPU cycles spent in
> >>> arch_uprobe_copy_ixol, but other than that XOL doesn't figure in stac=
k
> >>> traces. There are at least 22% CPU cycles spent in some
> >>> local_daif_restore function, though, not sure what that is, but might
> >>> be related to interrupt handling, right?
> >>
> >> The local_daif_restore() is part of the path for all user->kernel->use=
r
> >> context switch, including interrupt handling, breakpoints, and single-=
stepping
> >> etc. I am surprised to see it consuming 22% of CPU cycles as well. I h=
aven't
> >> been enable to reproduce this on my local machine.
> >>
> >> Andrii, could you use the patch below to see if it can reduce the 5% o=
f
> >> CPU cycles spent in arch_uprobe_copy_ixol, I doubt that D/I cache
> >> synchronization is the cause of this part of overhead.
> >>
> >> https://lore.kernel.org/all/20240919121719.2148361-1-liaochang1@huawei=
.com/
> >
> > tbh, I think pre-allocating and setting up fixed XOL slots instead of
> > dynamically allocating them is the way to go. We can allocate as many
> > special "[uprobes]" pages as necessary to accommodate all the
> > single-stepped uprobes in XOL, remember their index, etc. I think
> > that's much more performant (and simpler, IMO) approach overall. All
> > this preparation, however expensive it might be, will be done once per
> > each attached/detached uprobe/uretprobe, which is the place where we
> > want to do expensive stuff. Not when uprobe/uretprobe is actually
> > triggered.
>
> Generally agreed. But I have two concerns about pre-allocating of XOL slo=
ts:
>
> 1. If some uprobes/uretprobes are rarely or never triggered, pre-allocati=
ng
>    slots for them seem wastful. However, it isn't a issue on machines wit=
h
>    ample memory(e.g., hundreds of GB or a couple of TB).

I'm not too worried here because a) hopefully most of uprobes won't
need XOL and b) if user attaches to lots of uprobes and needs lots of
XOL slots, then machine is assumed to be powerful enough to handle
that. If we run out of memory, then that machine shouldn't be uprobed
that extensively. Generally, I think this is not a big concern.

But keep in mind, if we go this way, I think we need to make XOL slots
as small and exactly sized as necessary to fit just enough code to
handle single-stepping for that particular uprobe. Currently we size
them to 128 bytes to make it easy to dynamically allocate them in the
hot path. With pre-allocating XOL we have different tradeoffs and I'd
allocate them as tightly as possible, because attach/detach can be
significantly slower than uprobe/uretprobe triggering.

>
> 2. Currently, threads that trigger the same uprobe/uretprobe are dynamica=
lly
>    allocated different slots. Since we can't predict how many threads wil=
l
>    trigger the same uprobe/uretprobe. it can't pre-allocate enough slots =
for
>    per each uprobe/uretprobe. If you allow all threads to share the slot
>    associated with each uprobe/uretprobe. this would result in XOL pages =
being
>    shared across procecces, I think it would introduce significant change=
s to
>    the page management of xol_area and fault handling.

Yes, I was thinking that all threads will share the same XOL slot, why
would you want that per-thread? And yes, it's a pretty significant
change, but I think it's a good one.

>
> >
> >>
> >>>
> >>>
> >>> The take away I'd like to communicate here is avoiding the
> >>> single-stepping need is *the best way* to go, IMO. So if we can
> >>> emulate those STP instructions for uprobe *cheaply*, that would be
> >>> awesome.
> >>
> >> Given some significant uprobe optimizations from Oleg and Andrii
> >> merged, I am curious to see how these changes impact the profiling
> >> result on Arm64. So I re-ran the selftest bench on the latest kernel
> >> (based on tag next-20241104) and the kernel (based on tag next-2024090=
9)
> >> that I used when I submitted this patch. The results re-ran are shown
> >> below.
> >>
> >> next-20240909(xol stp + xol nop)
> >> --------------------------------
> >> uprobe-nop      ( 1 cpus):    0.424 =C2=B1 0.000M/s  (  0.424M/s/cpu)
> >> uprobe-push     ( 1 cpus):    0.415 =C2=B1 0.001M/s  (  0.415M/s/cpu)
> >> uprobe-ret      ( 1 cpus):    2.101 =C2=B1 0.002M/s  (  2.101M/s/cpu)
> >> uretprobe-nop   ( 1 cpus):    0.347 =C2=B1 0.000M/s  (  0.347M/s/cpu)
> >> uretprobe-push  ( 1 cpus):    0.349 =C2=B1 0.000M/s  (  0.349M/s/cpu)
> >> uretprobe-ret   ( 1 cpus):    1.051 =C2=B1 0.001M/s  (  1.051M/s/cpu)
> >>
> >> next-20240909(sim stp + sim nop)
> >> --------------------------------
> >> uprobe-nop      ( 1 cpus):    2.042 =C2=B1 0.002M/s  (  2.042M/s/cpu)
> >> uprobe-push     ( 1 cpus):    1.363 =C2=B1 0.002M/s  (  1.363M/s/cpu)
> >> uprobe-ret      ( 1 cpus):    2.052 =C2=B1 0.002M/s  (  2.052M/s/cpu)
> >> uretprobe-nop   ( 1 cpus):    1.049 =C2=B1 0.001M/s  (  1.049M/s/cpu)
> >> uretprobe-push  ( 1 cpus):    0.780 =C2=B1 0.000M/s  (  0.780M/s/cpu)
> >> uretprobe-ret   ( 1 cpus):    1.065 =C2=B1 0.001M/s  (  1.065M/s/cpu)
> >>
> >> next-20241104 (xol stp + sim nop)
> >> ---------------------------------
> >> uprobe-nop      ( 1 cpus):    2.044 =C2=B1 0.003M/s  (  2.044M/s/cpu)
> >> uprobe-push     ( 1 cpus):    0.415 =C2=B1 0.001M/s  (  0.415M/s/cpu)
> >> uprobe-ret      ( 1 cpus):    2.047 =C2=B1 0.001M/s  (  2.047M/s/cpu)
> >> uretprobe-nop   ( 1 cpus):    0.832 =C2=B1 0.003M/s  (  0.832M/s/cpu)
> >> uretprobe-push  ( 1 cpus):    0.328 =C2=B1 0.000M/s  (  0.328M/s/cpu)
> >> uretprobe-ret   ( 1 cpus):    0.833 =C2=B1 0.003M/s  (  0.833M/s/cpu)
> >>
> >> next-20241104 (sim stp + sim nop)
> >> ---------------------------------
> >> uprobe-nop      ( 1 cpus):    2.052 =C2=B1 0.002M/s  (  2.052M/s/cpu)
> >> uprobe-push     ( 1 cpus):    1.411 =C2=B1 0.002M/s  (  1.411M/s/cpu)
> >> uprobe-ret      ( 1 cpus):    2.052 =C2=B1 0.005M/s  (  2.052M/s/cpu)
> >> uretprobe-nop   ( 1 cpus):    0.839 =C2=B1 0.005M/s  (  0.839M/s/cpu)
> >> uretprobe-push  ( 1 cpus):    0.702 =C2=B1 0.002M/s  (  0.702M/s/cpu)
> >> uretprobe-ret   ( 1 cpus):    0.837 =C2=B1 0.001M/s  (  0.837M/s/cpu)
> >>
> >> It seems that the STP simluation approach in this patch significantly
> >> improves uprobe-push throughtput by 240% (from 0.415Ms/ to 1.411M/s)
> >> and uretprobe-push by 114% (from 0.328M/s to 0.702M/s) on kernels
> >> bases on next-20240909 and next-20241104. While there is still room
> >> for improvement to reach the throughput of -nop and -ret, the gains
> >> are very substantail.
> >>
> >> But I'm a bit puzzled by the throughput of uprobe/uretprobe-push using
> >> single-stepping stp, which are far lower compared to the result when
> >> when I submitted patch(look closely to the uprobe-push and uretprobe-p=
ush
> >> results in commit log). I'm certain that the tests were run on the
> >> same bare-metal machine with background tasked minimized. I doubt some
> >> uncommitted uprobe optimization on my local repo twist the result of
> >> -push using single-step.
> >
> > You can always profiler and compare before/after, right? See where
> > added costs are coming from?
>
> Yes, I've been looking through the git reflog to restore the
> kernel tree to the state when I submitted this patch.
>
> Regarding the throughtput data of uprobe/uretprobe-push using
> single-stepping, I believe *the re-ran result provide a more
> accurate picture*. If we carefully compare the throughput of
> -nop and -push, we can see that they are very close (uprobe-nop
> is 0.424M/s/cpu and uprobe-push is 0.415M/s/cpu, uretprobe-nop
> is 0.347M/s/cpu and upretprobe-push is 0.349M/s/cpu). This is
> expected, as both use single-stepping to execute NOP and STP.
> There's no reason -push using single-step should outperform the
> one of -nop(uprobe-push is 0.868M/s/cpu a month ago).
>
> In summary, understanding these performance is crucial for selecting
> an approach that balances accuracy and efficiency. Although this
> patch offers lower gain compared to my initial implementation.
> But, considering the complexity of 'STP', the cost seems acceptable,
> right?

But why do the suboptimal thing if we can do better?

>
> >
> >>
> >> In addition to the micro benchmark, I also re-ran Redis benchmark to
> >> compare the impact of single-stepping STP and simluated STP to the
> >> throughput of redis-server. I believe the impact of uprobe on the real
> >> application depends on the frequency of uprobe triggered and the appli=
cation's
> >> hot paths. Therefore, I wouldn't say the simluated STP will benefit al=
l
> >> real world applications.
> >
> > It will benefit *a lot* of real world applications, though, so I think
> > it's very important to improve.
>
> Good to see that.
>
> >
> >>
> >> $ redis-benchmark -h [redis-server IP] -p 7778 -n 64000 -d 4 -c 128 -t=
 SET
> >> $ redis-server --port 7778 --protected-mode no --save "" --appendonly =
no & &&
> >>   bpftrace -e 'uprobe:redis-server:readQueryFromClient{}
> >>                uprobe:redis-server:processCommand{}
> >>                uprobe:redis-server:aeApiPoll {}'
> >>
> >> next-20241104
> >> -------------
> >> RPS: 55602.1
> >>
> >> next-20241104 + ss stp
> >> ----------------------
> >> RPS: 47220.9
> >> uprobe@@aeApiPoll: 554565
> >> uprobe@processCommand: 1275160
> >> uprobe@readQueryFromClient: 1277710
> >>>> next-20241104 + sim stp
> >> -----------------------
> >> RPS           54290.09
> >> uprobe@aeApiPoll: 496007
> >> uprobe@processCommand: 1275160
> >> uprobe@readQueryFromClient: 1277710
> >>
> >> Andrii expressed concern that the STP simulation in this patch is too
> >> expensive. If we believe the result I re-ran, perhaps it is not a
> >> bad way to simluate STP. Looking forward to your feedbacks, or someone
> >> could propose a cheaper way to simluate STP, I'm very happy to test it
> >> on my machine, thanks.
> >
> > I'm no ARM64 expert, but seeing that we simulate stack pushes with
> > just memory reads/write for x86-64, it feels like that should be
> > satisfactory for ARM64. So I'd suggest you to go back to the initial
> > implementation, clean it up, rebase, re-benchmark, and send a new
> > revision. Let's continue the discussion there?
>
> I've re-benchmarked the initial implementation on the latest kernel
> tree (tag next-20241104). I paste the results for single-stepping,
> the initial patch and this patch here for comparision. Please see
> the results below:
>
> next-20241104 + xol stp
> -----------------------
> uprobe-push     ( 1 cpus):    0.415 =C2=B1 0.001M/s  (  0.415M/s/cpu)
> uretprobe-push  ( 1 cpus):    0.328 =C2=B1 0.000M/s  (  0.328M/s/cpu)
>
> next-20221104 + initial patch
> -----------------------------
> uprobe-push     ( 1 cpus):    1.798 =C2=B1 0.001M/s  (  1.798M/s/cpu)
> uretprobe-push  ( 1 cpus):    0.806 =C2=B1 0.001M/s  (  0.806M/s/cpu)
>
> next-20241104 + this patch
> --------------------------
> uprobe-push     ( 1 cpus):    1.411 =C2=B1 0.002M/s  (  1.411M/s/cpu)
> uretprobe-push  ( 1 cpus):    0.702 =C2=B1 0.002M/s  (  0.702M/s/cpu)
>
> As shown in the benchmark results, the initial implementation offers
> a limited performance advantage, especailly, it comes at the cost of
> accuracy.
>

What limited accuracy? And since when almost 30% (1.4M/s -> 1.8M/s) is
a "limited performance advantage"?

> >
> >>
> >> [...]
> >>
> >>>>>
> >>>>> xol-stp
> >>>>> -------
> >>>>> uprobe-nop      ( 1 cpus):    1.566 =C2=B1 0.006M/s  (  1.566M/s/cp=
u)
> >>>>> uprobe-push     ( 1 cpus):    0.868 =C2=B1 0.001M/s  (  0.868M/s/cp=
u)
> >>>>> uprobe-ret      ( 1 cpus):    1.629 =C2=B1 0.001M/s  (  1.629M/s/cp=
u)
> >>>>> uretprobe-nop   ( 1 cpus):    0.871 =C2=B1 0.001M/s  (  0.871M/s/cp=
u)
> >>>>> uretprobe-push  ( 1 cpus):    0.616 =C2=B1 0.001M/s  (  0.616M/s/cp=
u)
> >>>>> uretprobe-ret   ( 1 cpus):    0.878 =C2=B1 0.002M/s  (  0.878M/s/cp=
u)
> >>>>>
> >>>>> simulated-stp
> >>>>> -------------
> >>>>> uprobe-nop      ( 1 cpus):    1.544 =C2=B1 0.001M/s  (  1.544M/s/cp=
u)
> >>>>> uprobe-push     ( 1 cpus):    1.128 =C2=B1 0.002M/s  (  1.128M/s/cp=
u)
> >>>>> uprobe-ret      ( 1 cpus):    1.550 =C2=B1 0.005M/s  (  1.550M/s/cp=
u)
> >>>>> uretprobe-nop   ( 1 cpus):    0.872 =C2=B1 0.004M/s  (  0.872M/s/cp=
u)
> >>>>> uretprobe-push  ( 1 cpus):    0.714 =C2=B1 0.001M/s  (  0.714M/s/cp=
u)
> >>>>> uretprobe-ret   ( 1 cpus):    0.896 =C2=B1 0.001M/s  (  0.896M/s/cp=
u)
> >>>>>
> >>>>> The profiling results based on the upstream kernel with spinlock
> >>>>> optimization patches [2] reveals the simulation of STP increase the
> >>>>> uprobe-push throughput by 29.3% (from 0.868M/s/cpu to 1.1238M/s/cpu=
) and
> >>>>> uretprobe-push by 15.9% (from 0.616M/s/cpu to 0.714M/s/cpu).
> >>>>>
> >>>>> [0] https://lore.kernel.org/all/CAEf4BzaO4eG6hr2hzXYpn+7Uer4chS0R99=
zLn02ezZ5YruVuQw@mail.gmail.com/
> >>>>> [1] https://lore.kernel.org/all/Zr3RN4zxF5XPgjEB@J2N7QTR9R3/
> >>>>> [2] https://lore.kernel.org/all/20240815014629.2685155-1-liaochang1=
@huawei.com/
> >>>>>
> >>>>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> >>>>> ---
> >>>>>  arch/arm64/include/asm/insn.h            |  1 +
> >>>>>  arch/arm64/kernel/probes/decode-insn.c   | 16 +++++
> >>>>>  arch/arm64/kernel/probes/decode-insn.h   |  1 +
> >>>>>  arch/arm64/kernel/probes/simulate-insn.c | 89 ++++++++++++++++++++=
++++
> >>>>>  arch/arm64/kernel/probes/simulate-insn.h |  1 +
> >>>>>  arch/arm64/kernel/probes/uprobes.c       | 21 ++++++
> >>>>>  arch/arm64/lib/insn.c                    |  5 ++
> >>>>>  7 files changed, 134 insertions(+)
> >>>>>
> >>>
> >>> [...]
> >>
> >> --
> >> BR
> >> Liao, Chang
> >>
>
> --
> BR
> Liao, Chang
>

