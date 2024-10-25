Return-Path: <bpf+bounces-43191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB2F9B1111
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 22:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E13D1F23BB2
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 20:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F1821747B;
	Fri, 25 Oct 2024 20:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0lTDNKs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11372215C49;
	Fri, 25 Oct 2024 20:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889490; cv=none; b=fdZ14Y+E4n7BOmeEHMdmjVY5m2U6BtiNltOJamS5KQP0e6Zn8LzobaVLt9/OjVEhzj7KYZGxDJrZ1S8+1iSYPDJ1vf2NcGzCkG28cM7yTyfXYhlApR2qVYB07Cg4XRfYI3+uxlIlmqcd57ClEF5kC3jtjx7v+3wJxnQe0pr5OEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889490; c=relaxed/simple;
	bh=Qhvxqmz3iak3n+qoL1Q4dmntgUdRDCn4Da9U5R6G+94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/ffb+JM+tIX9DcXbd9jj7bp9Lm51ScD3eBgiO4XQfK0u2NQPYR2MvusWOUxGPcu0iqTtj3uz7zgFQ4cSGENCl/yamfb+iEDtrN6DSnB7u9xtJXNmfTjd0jbnz4ec8WY7NtPBv778pL6qns40wSZcDhciSicZjsKIlYsQlKadTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0lTDNKs; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e4244fdc6so1817511b3a.0;
        Fri, 25 Oct 2024 13:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729889487; x=1730494287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LVzn0+tS6rm732wItdJV79y1f4UkiEc3CInvIIV8B4=;
        b=k0lTDNKsd7xn61mELjVHmFZad7WOWh1cHsWb0kMwE8jWECu+gQslBEQSihU8UhrgsD
         gOn1mNMpN6ZrcQVWRJ+sHhOkP9gzrcHRc6d6XLQGLL6KSxZyyD1jZVX8vsoK6Za0Z0Ql
         78EhVVcsIUpIJVQqCepG6SplBig0Uuv/IlFvKYvyEThTBOoKrXclro3hkV2Nv4SDsGre
         eQjzN3GItV38NmxU43cH8dhS5kd1fTpTC/K3pToJ1V698jnG5LhhxgDK41noqCPI1Dj6
         aLcyrS4L2IpWQSq30CbEg9ehski/R0lggvpyS42MU26F0NdPRFOkz0HHhJKX0d943aqq
         IbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729889487; x=1730494287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LVzn0+tS6rm732wItdJV79y1f4UkiEc3CInvIIV8B4=;
        b=STLgBJ7BZv9zzr9rpwWm6lrU06f9kXKN2BZVjKwVHD0pxY+aFn9QGnvttDF0Xp2JYZ
         i2EQQUxT09YZE3anfTcJPdd1XxSFsPfAXITTn5iJWDVeKAFs8/RqOe8fkR8ghdLmOpso
         sGdjZOdeXOpujzpT7NIEdgSFpHceEf0kwK/Ba7enULMU9lUwUnxXlaARFRSd5LH2jj0D
         CKAzqvHhgYjQb/S2cCjQfewg0Ui0LPGeHJHZnmXnQFWSwzYvcYuc1ymRBzkvWO4A4tLX
         HQn06d/btEpShyV/+BhoRQaxR23mkCI34r5BHm6f/PpckN2s8E6aRZbi89BZ183JMF3i
         JJIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKnj420AmfW59kqbw9jOVMytkTQ5vAuenCpSZLdVKfgO5N3DWDye2ZPnyHPzQH8LCuxmI=@vger.kernel.org, AJvYcCVQ6QVLSN0Rtx4LvqgoXa1fB2gMsoPfx7/N4gQYvCbsj09vFUmjwtRCzNrMfVKsrPPkYC6HBWLqYMeYxXn+fI69UeVJ@vger.kernel.org, AJvYcCXUfjPYf+/e4F5Ar9I1miut4N/DYkcfjR2lnw4/Vq38AtXp8dXKJTE6rzT7Oqbw2GsqFocFVoGBRmlRG18O@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ8eFn2sXycH87hKOMCKvfJT1h7H1EwV3ojz9K4XOrc5aIpr55
	EPZc16ml38cX2fvALwOM7Wazd7zuu8H3qoaUr8zRW5ELmnpPfDjYahKRNr46sWUH/mVlJwKvjuB
	Vp0zyCC3fu3+z4FXiiJAk5HHNYwE=
X-Google-Smtp-Source: AGHT+IHYqAo+l4UEvwdEHT3abjknHgC2mrzv8B/FvXkhltsyDH+M7lVKBI3TdSCqpeqJtD9UDN2zboB6ky44WDutAfc=
X-Received: by 2002:a05:6a00:8ce:b0:71e:104d:62fe with SMTP id
 d2e1a72fcca58-7206306df3fmr1051763b3a.20.1729889487221; Fri, 25 Oct 2024
 13:51:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910060407.1427716-1-liaochang1@huawei.com> <ZxpUX1rbppLqS0bD@J2N7QTR9R3.cambridge.arm.com>
In-Reply-To: <ZxpUX1rbppLqS0bD@J2N7QTR9R3.cambridge.arm.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 25 Oct 2024 13:51:14 -0700
Message-ID: <CAEf4Bzb9fM+hx8quHpCCeRh2p7UVk9Kk6yGj3XvyJLTQu9C-2w@mail.gmail.com>
Subject: Re: [PATCH] arm64: uprobes: Simulate STP for pushing fp/lr into user stack
To: Mark Rutland <mark.rutland@arm.com>
Cc: Liao Chang <liaochang1@huawei.com>, catalin.marinas@arm.com, will@kernel.org, 
	mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org, ast@kernel.org, 
	puranjay@kernel.org, andrii@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 7:06=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Tue, Sep 10, 2024 at 06:04:07AM +0000, Liao Chang wrote:
> > This patch is the second part of a series to improve the selftest bench
> > of uprobe/uretprobe [0]. The lack of simulating 'stp fp, lr, [sp, #imm]=
'
> > significantly impact uprobe/uretprobe performance at function entry in
> > most user cases. Profiling results below reveals the STP that executes
> > in the xol slot and trap back to kernel, reduce redis RPS and increase
> > the time of string grep obviously.
> >
> > On Kunpeng916 (Hi1616), 4 NUMA nodes, 64 Arm64 cores@2.4GHz.
> >
> > Redis GET (higher is better)
> > ----------------------------
> > No uprobe: 49149.71 RPS
> > Single-stepped STP: 46750.82 RPS
> > Emulated STP: 48981.19 RPS
> >
> > Redis SET (larger is better)
> > ----------------------------
> > No uprobe: 49761.14 RPS
> > Single-stepped STP: 45255.01 RPS
> > Emulated stp: 48619.21 RPS
> >
> > Grep (lower is better)
> > ----------------------
> > No uprobe: 2.165s
> > Single-stepped STP: 15.314s
> > Emualted STP: 2.216s
>
> The results for grep are concerning.
>
> In theory, the overhead for stepping should be roughly double the
> overhead for emulating, assuming the exception-entry and
> exception-return are the dominant cost. The cost of stepping should be
> trivial.
>
> Those results show emulating adds 0.051s (for a ~2.4% overhead), while
> stepping adds 13.149s (for a ~607% overhead), meaning stepping is 250x
> more expensive.
>
> Was this tested bare-metal, or in a VM?

Hey Mark, I hope Liao will have a chance to reply, I don't know the
details of his benchmarking. But I can try to give you my numbers and
maybe answer a few questions, hopefully that helps move the
conversation forward.

So, first of all, I did a quick benchmark on bare metal (without
Liao's optimization, though), here are my results:

uprobe-nop            ( 1 cpus):    2.334 =C2=B1 0.011M/s  (  2.334M/s/cpu)
uprobe-push           ( 1 cpus):    2.321 =C2=B1 0.010M/s  (  2.321M/s/cpu)
uprobe-ret            ( 1 cpus):    4.144 =C2=B1 0.041M/s  (  4.144M/s/cpu)

uretprobe-nop         ( 1 cpus):    1.684 =C2=B1 0.004M/s  (  1.684M/s/cpu)
uretprobe-push        ( 1 cpus):    1.736 =C2=B1 0.003M/s  (  1.736M/s/cpu)
uretprobe-ret         ( 1 cpus):    2.502 =C2=B1 0.006M/s  (  2.502M/s/cpu)

uretprobes are inherently slower, so I'll just compare uprobe, as the
differences are very clear either way.

-nop is literally nop (Liao solved that issue, I just don't have his
patch applied on my test machine). -push has `stp     x29, x30, [sp,
#-0x10]!` instruction traced. -ret is literally just `ret`
instruction.

So you can see that -ret is almost twice as fast as the -push variant
(it's a microbenchmark, yes, but still).

>
> AFAICT either:
>
> * Single-stepping is unexpectedly expensive.
>
>   Historically we had performance issues with hypervisor trapping of
>   debug features, and there are things we might be able to improve in
>   the hypervisor and kernel, which would improve stepping *all*
>   instructions.
>

Single-stepping will always be more expensive, as it necessitates
extra hop kernel->user space->kernel, so no matter the optimization
for single-stepping, if we can avoid it, we should. It will be
noticeable.

>   If stepping is the big problem, we could move uprobes over to a BRK
>   rather than a single-step. That would require require updating and
>   fixing the logic to decide which instructions are steppable, but
>   that's necessary anyway given it has extant soundness issues.

I'm afraid I don't understand what BRK means and what are the
consequences in terms of overheads. I'm not an ARM person either, so
sorry if that's a stupid question. But either way, I can't address
this. But see above, emulating an instruction feels like a much better
approach, if possible.

>
> * XOL management is absurdly expensive.
>
>   Does uprobes keep the XOL slot around (like krpobes does), or does it
>   create the slot afresh for each trap?

XOL *page* is created once per process, lazily, and then we just
juggle a bunch of fixed slots there for each instance of
single-stepped uprobe. And yes, there are some bottlenecks in XOL
management, though it's mostly due to lock contention (as it is
implemented right now). Liao and Oleg have been improving XOL
management, but still, avoiding XOL in the first place is the much
preferred way.

>
>   If that's trying to create a slot afresh for each trap, there are
>   several opportunities for improvement, e.g. keep the slot around for
>   as long as the uprobe exists, or pre-allocate shared slots for common
>   instructions and use those.

As I mentioned, a XOL page is allocated and mapped once, but yes, it
seems like we dynamically get a slot in it for each single-stepped
execution (see xol_take_insn_slot() in kernel/events/uprobes.c). It's
probably not a bad idea to just cache and hold a XOL slot for each
specific uprobe, I don't see why we should limit ourselves to just one
XOL page. We also don't need to pre-size each slot, we can probably
allocate just the right amount of space for a given uprobe.

All good ideas for sure, we should do them, IMO. But we'll still be
paying an extra kernel->user->kernel switch, which almost certainly is
slower than doing a simple stack push emulation just like we do in
x86-64 case, no?


BTW, I did a quick local profiling run. I don't think XOL management
is the main source of overhead. I see 5% of CPU cycles spent in
arch_uprobe_copy_ixol, but other than that XOL doesn't figure in stack
traces. There are at least 22% CPU cycles spent in some
local_daif_restore function, though, not sure what that is, but might
be related to interrupt handling, right?


The take away I'd like to communicate here is avoiding the
single-stepping need is *the best way* to go, IMO. So if we can
emulate those STP instructions for uprobe *cheaply*, that would be
awesome.

>
> Mark.
>
> >
> > Additionally, a profiling of the entry instruction for all leaf and
> > non-leaf function, the ratio of 'stp fp, lr, [sp, #imm]' is larger than
> > 50%. So simulting the STP on the function entry is a more viable option
> > for uprobe.
> >
> > In the first version [1], it used a uaccess routine to simulate the STP
> > that push fp/lr into stack, which use double STTR instructions for
> > memory store. But as Mark pointed out, this approach can't simulate the
> > correct single-atomicity and ordering properties of STP, especiallly
> > when it interacts with MTE, POE, etc. So this patch uses a more complex
> > and inefficient approach that acquires user stack pages, maps them to
> > kernel address space, and allows kernel to use STP directly push fp/lr
> > into the stack pages.
> >
> > xol-stp
> > -------
> > uprobe-nop      ( 1 cpus):    1.566 =C2=B1 0.006M/s  (  1.566M/s/cpu)
> > uprobe-push     ( 1 cpus):    0.868 =C2=B1 0.001M/s  (  0.868M/s/cpu)
> > uprobe-ret      ( 1 cpus):    1.629 =C2=B1 0.001M/s  (  1.629M/s/cpu)
> > uretprobe-nop   ( 1 cpus):    0.871 =C2=B1 0.001M/s  (  0.871M/s/cpu)
> > uretprobe-push  ( 1 cpus):    0.616 =C2=B1 0.001M/s  (  0.616M/s/cpu)
> > uretprobe-ret   ( 1 cpus):    0.878 =C2=B1 0.002M/s  (  0.878M/s/cpu)
> >
> > simulated-stp
> > -------------
> > uprobe-nop      ( 1 cpus):    1.544 =C2=B1 0.001M/s  (  1.544M/s/cpu)
> > uprobe-push     ( 1 cpus):    1.128 =C2=B1 0.002M/s  (  1.128M/s/cpu)
> > uprobe-ret      ( 1 cpus):    1.550 =C2=B1 0.005M/s  (  1.550M/s/cpu)
> > uretprobe-nop   ( 1 cpus):    0.872 =C2=B1 0.004M/s  (  0.872M/s/cpu)
> > uretprobe-push  ( 1 cpus):    0.714 =C2=B1 0.001M/s  (  0.714M/s/cpu)
> > uretprobe-ret   ( 1 cpus):    0.896 =C2=B1 0.001M/s  (  0.896M/s/cpu)
> >
> > The profiling results based on the upstream kernel with spinlock
> > optimization patches [2] reveals the simulation of STP increase the
> > uprobe-push throughput by 29.3% (from 0.868M/s/cpu to 1.1238M/s/cpu) an=
d
> > uretprobe-push by 15.9% (from 0.616M/s/cpu to 0.714M/s/cpu).
> >
> > [0] https://lore.kernel.org/all/CAEf4BzaO4eG6hr2hzXYpn+7Uer4chS0R99zLn0=
2ezZ5YruVuQw@mail.gmail.com/
> > [1] https://lore.kernel.org/all/Zr3RN4zxF5XPgjEB@J2N7QTR9R3/
> > [2] https://lore.kernel.org/all/20240815014629.2685155-1-liaochang1@hua=
wei.com/
> >
> > Signed-off-by: Liao Chang <liaochang1@huawei.com>
> > ---
> >  arch/arm64/include/asm/insn.h            |  1 +
> >  arch/arm64/kernel/probes/decode-insn.c   | 16 +++++
> >  arch/arm64/kernel/probes/decode-insn.h   |  1 +
> >  arch/arm64/kernel/probes/simulate-insn.c | 89 ++++++++++++++++++++++++
> >  arch/arm64/kernel/probes/simulate-insn.h |  1 +
> >  arch/arm64/kernel/probes/uprobes.c       | 21 ++++++
> >  arch/arm64/lib/insn.c                    |  5 ++
> >  7 files changed, 134 insertions(+)
> >

[...]

