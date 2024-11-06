Return-Path: <bpf+bounces-44147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4315F9BF78D
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 20:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02126280D25
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 19:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0406220ADD3;
	Wed,  6 Nov 2024 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKcRigRf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762FF208225;
	Wed,  6 Nov 2024 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730922322; cv=none; b=KtNl7Z0hKI4JWEAJuRvPAneMyijTNqLqY5211R7FBWUXJ8lwgPRFOCvsVSjrx2ZYHPHofWlb/poC91BlvdoBAdONmeWbR65nk+Dv677k+MGHIMueuXterhLEKPxEbqrF389uCr18DNt8SFrT+B2+5E7G1hu3iEQJca89Sh89pQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730922322; c=relaxed/simple;
	bh=BF65O3jHtf3kOsBmTMPSdvix63/S+nl9LQpxGnAyA4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZkN+cvOy5AvMBlAPaIsYmwgpvKeiQFdDRx5FkdMlFPDAM2egud9L2YcqZGdwYctK4PF4TKw/0XBp0NP/2s3oN2+cCZiw0ag7v7+rBmQXAV0WDR3MMtwAa9mHrTlbn3MPR2h2rXvcGdNtc0WX569NjhdyBLCliSlC4ZGc8RXA+tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKcRigRf; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e30fb8cb07so148056a91.3;
        Wed, 06 Nov 2024 11:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730922320; x=1731527120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERW3U817ICJVWH5C1bIPnSiPS7bcsAi0OHsZw8R5di4=;
        b=MKcRigRfChDtkNbFqJwCiaxrOJr2Wn11S6AOM+dOhDjGvoaWudCqeBCh6PV5KKIxTR
         7V0aAeX4yzdQ28+IbHGWItEqj9ZeAce+6E1zZ01Sbr8Ae0o6qpFU1dK9ggZWcmTTqnhB
         mjOhf4HOcQ1+OI+XzFKYAHigKHN8CrUGMongQg989BPCJUp7sigqZHCPxDez/Je52yJn
         m+DOocsSqtqpSa6j/GC34wL4e5RjbRP1+TNtOuRi0ZAJNiL31VlErqaOJopZ0NxAZqGk
         9tmv8PKhAhg5G0zn+AC9qVMFW0HmC010g/5xfwHXB+GChYZSM/1WI68a7yUXPF0zDcnM
         WliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730922320; x=1731527120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERW3U817ICJVWH5C1bIPnSiPS7bcsAi0OHsZw8R5di4=;
        b=NjkwFcg2iAPbf9PLj3cSv67sORLUSRVc2NowPtQayGoeFtbymN7/GguULV+xgoA0OU
         IiCZuMwUyagbktWW/rms6FSFX3v4RRre+QjdiWg8FWbXJJM6oGtgvS8ii8q0jtan+k+u
         s+D91KnvyhgmYC/L4sa/uDsh1J/iZqz4D+sTro0qzId570MZJ/TYgP+5Af0smEC5SN+P
         6MroHo2yA2dG2+PbWaR/lAyH7ahkab3pXPik17b/h4KZRhYkaP2HIKT/S0sClb0sqrsO
         IxgZfNRGczYC4D9dZa4Xlxgv3ouICemeBADXBaWrAtWiNagJIXkNlBaCRQhOZmFmXIqs
         6zbg==
X-Forwarded-Encrypted: i=1; AJvYcCUHcml7IVI6cOvS0JHxwP5RqfWwIJO8RK45Vo0V57Ek+CDDdQlYKFGLoXjKV1o1cg6OwByD/HJTX6+uTNy/@vger.kernel.org, AJvYcCWl2J6FzNhYtOneahxUdTo++qIJPK+rAteRKp6iO7hzlKWQjKjynrc03sFoJTi4byauz9k=@vger.kernel.org, AJvYcCXYkAFGXd5a6xp4IbMvKm5C1M60b46B3qqcB40Y8bxvvedNDtY0GDQnxE5FzZj2KX8F2mQIRnTS3im4/67+jAfiZqby@vger.kernel.org
X-Gm-Message-State: AOJu0YzbQi3DO3EJkpKWgmyDonx3w4tE9oD+g5wQArQ1OKsCzv4WJGh1
	8n3HtLbJ3yMyswTIXvvMJq1HQsKS/acCM8RbVb8YhSNK7YIlYa+0OYTE37jVXLnEFrHPafIMw/f
	o3AOCqcbUHwHmXap5z2xU6oJ5efk=
X-Google-Smtp-Source: AGHT+IFbmQxTWeLNB8XV7BIfN4wjfQBgzF4RxF4R5uqD3wQNs02fm9aOsTQRWdT5wxISCZLrRRJ6WTjtbBhWxYa886M=
X-Received: by 2002:a17:90a:ad91:b0:2d1:bf48:e767 with SMTP id
 98e67ed59e1d1-2e92cf2dc3emr31095159a91.29.1730922318060; Wed, 06 Nov 2024
 11:45:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910060407.1427716-1-liaochang1@huawei.com>
 <ZxpUX1rbppLqS0bD@J2N7QTR9R3.cambridge.arm.com> <CAEf4Bzb9fM+hx8quHpCCeRh2p7UVk9Kk6yGj3XvyJLTQu9C-2w@mail.gmail.com>
 <46451dbe-056c-4c13-bfae-7ee8d6e115b5@huawei.com>
In-Reply-To: <46451dbe-056c-4c13-bfae-7ee8d6e115b5@huawei.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Nov 2024 11:45:06 -0800
Message-ID: <CAEf4BzYBAtNbCyCLybPxQrp-CZ9NVOco9X=xctnQ7BuDfhoadA@mail.gmail.com>
Subject: Re: [PATCH] arm64: uprobes: Simulate STP for pushing fp/lr into user stack
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com, will@kernel.org, 
	mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org, ast@kernel.org, 
	puranjay@kernel.org, andrii@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 4:22=E2=80=AFAM Liao, Chang <liaochang1@huawei.com> =
wrote:
>
> Andrii and Mark.
>
> =E5=9C=A8 2024/10/26 4:51, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Thu, Oct 24, 2024 at 7:06=E2=80=AFAM Mark Rutland <mark.rutland@arm.=
com> wrote:
> >>
> >> On Tue, Sep 10, 2024 at 06:04:07AM +0000, Liao Chang wrote:
> >>> This patch is the second part of a series to improve the selftest ben=
ch
> >>> of uprobe/uretprobe [0]. The lack of simulating 'stp fp, lr, [sp, #im=
m]'
> >>> significantly impact uprobe/uretprobe performance at function entry i=
n
> >>> most user cases. Profiling results below reveals the STP that execute=
s
> >>> in the xol slot and trap back to kernel, reduce redis RPS and increas=
e
> >>> the time of string grep obviously.
> >>>
> >>> On Kunpeng916 (Hi1616), 4 NUMA nodes, 64 Arm64 cores@2.4GHz.
> >>>
> >>> Redis GET (higher is better)
> >>> ----------------------------
> >>> No uprobe: 49149.71 RPS
> >>> Single-stepped STP: 46750.82 RPS
> >>> Emulated STP: 48981.19 RPS
> >>>
> >>> Redis SET (larger is better)
> >>> ----------------------------
> >>> No uprobe: 49761.14 RPS
> >>> Single-stepped STP: 45255.01 RPS
> >>> Emulated stp: 48619.21 RPS
> >>>
> >>> Grep (lower is better)
> >>> ----------------------
> >>> No uprobe: 2.165s
> >>> Single-stepped STP: 15.314s
> >>> Emualted STP: 2.216s
> >>
> >> The results for grep are concerning.
> >>
> >> In theory, the overhead for stepping should be roughly double the
> >> overhead for emulating, assuming the exception-entry and
> >> exception-return are the dominant cost. The cost of stepping should be
> >> trivial.
> >>
> >> Those results show emulating adds 0.051s (for a ~2.4% overhead), while
> >> stepping adds 13.149s (for a ~607% overhead), meaning stepping is 250x
> >> more expensive.
> >>
> >> Was this tested bare-metal, or in a VM?
> >
> > Hey Mark, I hope Liao will have a chance to reply, I don't know the
> > details of his benchmarking. But I can try to give you my numbers and
> > maybe answer a few questions, hopefully that helps move the
> > conversation forward.
> >
> > So, first of all, I did a quick benchmark on bare metal (without
> > Liao's optimization, though), here are my results:
> >
> > uprobe-nop            ( 1 cpus):    2.334 =C2=B1 0.011M/s  (  2.334M/s/=
cpu)
> > uprobe-push           ( 1 cpus):    2.321 =C2=B1 0.010M/s  (  2.321M/s/=
cpu)
> > uprobe-ret            ( 1 cpus):    4.144 =C2=B1 0.041M/s  (  4.144M/s/=
cpu)
> >
> > uretprobe-nop         ( 1 cpus):    1.684 =C2=B1 0.004M/s  (  1.684M/s/=
cpu)
> > uretprobe-push        ( 1 cpus):    1.736 =C2=B1 0.003M/s  (  1.736M/s/=
cpu)
> > uretprobe-ret         ( 1 cpus):    2.502 =C2=B1 0.006M/s  (  2.502M/s/=
cpu)
> >
> > uretprobes are inherently slower, so I'll just compare uprobe, as the
> > differences are very clear either way.
> >
> > -nop is literally nop (Liao solved that issue, I just don't have his
> > patch applied on my test machine). -push has `stp     x29, x30, [sp,
> > #-0x10]!` instruction traced. -ret is literally just `ret`
> > instruction.
> >
> > So you can see that -ret is almost twice as fast as the -push variant
> > (it's a microbenchmark, yes, but still).
> >
> >>
> >> AFAICT either:
> >>
> >> * Single-stepping is unexpectedly expensive.
> >>
> >>   Historically we had performance issues with hypervisor trapping of
> >>   debug features, and there are things we might be able to improve in
> >>   the hypervisor and kernel, which would improve stepping *all*
> >>   instructions.
> >>
> >
> > Single-stepping will always be more expensive, as it necessitates
> > extra hop kernel->user space->kernel, so no matter the optimization
> > for single-stepping, if we can avoid it, we should. It will be
> > noticeable.
> >
> >>   If stepping is the big problem, we could move uprobes over to a BRK
> >>   rather than a single-step. That would require require updating and
> >>   fixing the logic to decide which instructions are steppable, but
> >>   that's necessary anyway given it has extant soundness issues.
> >
> > I'm afraid I don't understand what BRK means and what are the
> > consequences in terms of overheads. I'm not an ARM person either, so
> > sorry if that's a stupid question. But either way, I can't address
> > this. But see above, emulating an instruction feels like a much better
> > approach, if possible.
>
> As I understand, Mark's suggestion is to place a BRK instruction next to
> the instruction in the xol slot. Once the instruction in the xol slot
> executed, the BRK instruction would trigger a trap into kernel. This is
> a common technique used on platforms that don't support hardware single-
> step. However, since Arm64 does support hardware single-stepping, kernel
> enables it in pre_ssout(), allowing the CPU to automatically trap into ke=
rnel
> after instruction in xol slot executed. But even we move uprobes over
> to a BRK rather than a single-step. It can't reduce the overhead of user-=
>
> kernel->user context switch on the bare-metal. Maybe I am wrong, Mark,
> could you give more details about the BRK.
>

I see, thanks for elaborating. So the suggestion was to go from very
expensive single-stepping mode to still expensive breakpoint-based
kernel->user->kernel workflow.

I think either way it's going to be much slower than avoiding
kernel->user->kernel hop, so we should emulate STP instead, yep.

> >
> >>
> >> * XOL management is absurdly expensive.
> >>
> >>   Does uprobes keep the XOL slot around (like krpobes does), or does i=
t
> >>   create the slot afresh for each trap?
> >
> > XOL *page* is created once per process, lazily, and then we just
> > juggle a bunch of fixed slots there for each instance of
> > single-stepped uprobe. And yes, there are some bottlenecks in XOL
> > management, though it's mostly due to lock contention (as it is
> > implemented right now). Liao and Oleg have been improving XOL
> > management, but still, avoiding XOL in the first place is the much
> > preferred way.
> >
> >>
> >>   If that's trying to create a slot afresh for each trap, there are
> >>   several opportunities for improvement, e.g. keep the slot around for
> >>   as long as the uprobe exists, or pre-allocate shared slots for commo=
n
> >>   instructions and use those.
> >
> > As I mentioned, a XOL page is allocated and mapped once, but yes, it
> > seems like we dynamically get a slot in it for each single-stepped
> > execution (see xol_take_insn_slot() in kernel/events/uprobes.c). It's
> > probably not a bad idea to just cache and hold a XOL slot for each
> > specific uprobe, I don't see why we should limit ourselves to just one
> > XOL page. We also don't need to pre-size each slot, we can probably
> > allocate just the right amount of space for a given uprobe.
> >
> > All good ideas for sure, we should do them, IMO. But we'll still be
> > paying an extra kernel->user->kernel switch, which almost certainly is
> > slower than doing a simple stack push emulation just like we do in
> > x86-64 case, no?
> >
> >
> > BTW, I did a quick local profiling run. I don't think XOL management
> > is the main source of overhead. I see 5% of CPU cycles spent in
> > arch_uprobe_copy_ixol, but other than that XOL doesn't figure in stack
> > traces. There are at least 22% CPU cycles spent in some
> > local_daif_restore function, though, not sure what that is, but might
> > be related to interrupt handling, right?
>
> The local_daif_restore() is part of the path for all user->kernel->user
> context switch, including interrupt handling, breakpoints, and single-ste=
pping
> etc. I am surprised to see it consuming 22% of CPU cycles as well. I have=
n't
> been enable to reproduce this on my local machine.
>
> Andrii, could you use the patch below to see if it can reduce the 5% of
> CPU cycles spent in arch_uprobe_copy_ixol, I doubt that D/I cache
> synchronization is the cause of this part of overhead.
>
> https://lore.kernel.org/all/20240919121719.2148361-1-liaochang1@huawei.co=
m/

tbh, I think pre-allocating and setting up fixed XOL slots instead of
dynamically allocating them is the way to go. We can allocate as many
special "[uprobes]" pages as necessary to accommodate all the
single-stepped uprobes in XOL, remember their index, etc. I think
that's much more performant (and simpler, IMO) approach overall. All
this preparation, however expensive it might be, will be done once per
each attached/detached uprobe/uretprobe, which is the place where we
want to do expensive stuff. Not when uprobe/uretprobe is actually
triggered.

>
> >
> >
> > The take away I'd like to communicate here is avoiding the
> > single-stepping need is *the best way* to go, IMO. So if we can
> > emulate those STP instructions for uprobe *cheaply*, that would be
> > awesome.
>
> Given some significant uprobe optimizations from Oleg and Andrii
> merged, I am curious to see how these changes impact the profiling
> result on Arm64. So I re-ran the selftest bench on the latest kernel
> (based on tag next-20241104) and the kernel (based on tag next-20240909)
> that I used when I submitted this patch. The results re-ran are shown
> below.
>
> next-20240909(xol stp + xol nop)
> --------------------------------
> uprobe-nop      ( 1 cpus):    0.424 =C2=B1 0.000M/s  (  0.424M/s/cpu)
> uprobe-push     ( 1 cpus):    0.415 =C2=B1 0.001M/s  (  0.415M/s/cpu)
> uprobe-ret      ( 1 cpus):    2.101 =C2=B1 0.002M/s  (  2.101M/s/cpu)
> uretprobe-nop   ( 1 cpus):    0.347 =C2=B1 0.000M/s  (  0.347M/s/cpu)
> uretprobe-push  ( 1 cpus):    0.349 =C2=B1 0.000M/s  (  0.349M/s/cpu)
> uretprobe-ret   ( 1 cpus):    1.051 =C2=B1 0.001M/s  (  1.051M/s/cpu)
>
> next-20240909(sim stp + sim nop)
> --------------------------------
> uprobe-nop      ( 1 cpus):    2.042 =C2=B1 0.002M/s  (  2.042M/s/cpu)
> uprobe-push     ( 1 cpus):    1.363 =C2=B1 0.002M/s  (  1.363M/s/cpu)
> uprobe-ret      ( 1 cpus):    2.052 =C2=B1 0.002M/s  (  2.052M/s/cpu)
> uretprobe-nop   ( 1 cpus):    1.049 =C2=B1 0.001M/s  (  1.049M/s/cpu)
> uretprobe-push  ( 1 cpus):    0.780 =C2=B1 0.000M/s  (  0.780M/s/cpu)
> uretprobe-ret   ( 1 cpus):    1.065 =C2=B1 0.001M/s  (  1.065M/s/cpu)
>
> next-20241104 (xol stp + sim nop)
> ---------------------------------
> uprobe-nop      ( 1 cpus):    2.044 =C2=B1 0.003M/s  (  2.044M/s/cpu)
> uprobe-push     ( 1 cpus):    0.415 =C2=B1 0.001M/s  (  0.415M/s/cpu)
> uprobe-ret      ( 1 cpus):    2.047 =C2=B1 0.001M/s  (  2.047M/s/cpu)
> uretprobe-nop   ( 1 cpus):    0.832 =C2=B1 0.003M/s  (  0.832M/s/cpu)
> uretprobe-push  ( 1 cpus):    0.328 =C2=B1 0.000M/s  (  0.328M/s/cpu)
> uretprobe-ret   ( 1 cpus):    0.833 =C2=B1 0.003M/s  (  0.833M/s/cpu)
>
> next-20241104 (sim stp + sim nop)
> ---------------------------------
> uprobe-nop      ( 1 cpus):    2.052 =C2=B1 0.002M/s  (  2.052M/s/cpu)
> uprobe-push     ( 1 cpus):    1.411 =C2=B1 0.002M/s  (  1.411M/s/cpu)
> uprobe-ret      ( 1 cpus):    2.052 =C2=B1 0.005M/s  (  2.052M/s/cpu)
> uretprobe-nop   ( 1 cpus):    0.839 =C2=B1 0.005M/s  (  0.839M/s/cpu)
> uretprobe-push  ( 1 cpus):    0.702 =C2=B1 0.002M/s  (  0.702M/s/cpu)
> uretprobe-ret   ( 1 cpus):    0.837 =C2=B1 0.001M/s  (  0.837M/s/cpu)
>
> It seems that the STP simluation approach in this patch significantly
> improves uprobe-push throughtput by 240% (from 0.415Ms/ to 1.411M/s)
> and uretprobe-push by 114% (from 0.328M/s to 0.702M/s) on kernels
> bases on next-20240909 and next-20241104. While there is still room
> for improvement to reach the throughput of -nop and -ret, the gains
> are very substantail.
>
> But I'm a bit puzzled by the throughput of uprobe/uretprobe-push using
> single-stepping stp, which are far lower compared to the result when
> when I submitted patch(look closely to the uprobe-push and uretprobe-push
> results in commit log). I'm certain that the tests were run on the
> same bare-metal machine with background tasked minimized. I doubt some
> uncommitted uprobe optimization on my local repo twist the result of
> -push using single-step.

You can always profiler and compare before/after, right? See where
added costs are coming from?

>
> In addition to the micro benchmark, I also re-ran Redis benchmark to
> compare the impact of single-stepping STP and simluated STP to the
> throughput of redis-server. I believe the impact of uprobe on the real
> application depends on the frequency of uprobe triggered and the applicat=
ion's
> hot paths. Therefore, I wouldn't say the simluated STP will benefit all
> real world applications.

It will benefit *a lot* of real world applications, though, so I think
it's very important to improve.

>
> $ redis-benchmark -h [redis-server IP] -p 7778 -n 64000 -d 4 -c 128 -t SE=
T
> $ redis-server --port 7778 --protected-mode no --save "" --appendonly no =
& &&
>   bpftrace -e 'uprobe:redis-server:readQueryFromClient{}
>                uprobe:redis-server:processCommand{}
>                uprobe:redis-server:aeApiPoll {}'
>
> next-20241104
> -------------
> RPS: 55602.1
>
> next-20241104 + ss stp
> ----------------------
> RPS: 47220.9
> uprobe@@aeApiPoll: 554565
> uprobe@processCommand: 1275160
> uprobe@readQueryFromClient: 1277710
>
> next-20241104 + sim stp
> -----------------------
> RPS           54290.09
> uprobe@aeApiPoll: 496007
> uprobe@processCommand: 1275160
> uprobe@readQueryFromClient: 1277710
>
> Andrii expressed concern that the STP simulation in this patch is too
> expensive. If we believe the result I re-ran, perhaps it is not a
> bad way to simluate STP. Looking forward to your feedbacks, or someone
> could propose a cheaper way to simluate STP, I'm very happy to test it
> on my machine, thanks.

I'm no ARM64 expert, but seeing that we simulate stack pushes with
just memory reads/write for x86-64, it feels like that should be
satisfactory for ARM64. So I'd suggest you to go back to the initial
implementation, clean it up, rebase, re-benchmark, and send a new
revision. Let's continue the discussion there?

>
> [...]
>
> >>>
> >>> xol-stp
> >>> -------
> >>> uprobe-nop      ( 1 cpus):    1.566 =C2=B1 0.006M/s  (  1.566M/s/cpu)
> >>> uprobe-push     ( 1 cpus):    0.868 =C2=B1 0.001M/s  (  0.868M/s/cpu)
> >>> uprobe-ret      ( 1 cpus):    1.629 =C2=B1 0.001M/s  (  1.629M/s/cpu)
> >>> uretprobe-nop   ( 1 cpus):    0.871 =C2=B1 0.001M/s  (  0.871M/s/cpu)
> >>> uretprobe-push  ( 1 cpus):    0.616 =C2=B1 0.001M/s  (  0.616M/s/cpu)
> >>> uretprobe-ret   ( 1 cpus):    0.878 =C2=B1 0.002M/s  (  0.878M/s/cpu)
> >>>
> >>> simulated-stp
> >>> -------------
> >>> uprobe-nop      ( 1 cpus):    1.544 =C2=B1 0.001M/s  (  1.544M/s/cpu)
> >>> uprobe-push     ( 1 cpus):    1.128 =C2=B1 0.002M/s  (  1.128M/s/cpu)
> >>> uprobe-ret      ( 1 cpus):    1.550 =C2=B1 0.005M/s  (  1.550M/s/cpu)
> >>> uretprobe-nop   ( 1 cpus):    0.872 =C2=B1 0.004M/s  (  0.872M/s/cpu)
> >>> uretprobe-push  ( 1 cpus):    0.714 =C2=B1 0.001M/s  (  0.714M/s/cpu)
> >>> uretprobe-ret   ( 1 cpus):    0.896 =C2=B1 0.001M/s  (  0.896M/s/cpu)
> >>>
> >>> The profiling results based on the upstream kernel with spinlock
> >>> optimization patches [2] reveals the simulation of STP increase the
> >>> uprobe-push throughput by 29.3% (from 0.868M/s/cpu to 1.1238M/s/cpu) =
and
> >>> uretprobe-push by 15.9% (from 0.616M/s/cpu to 0.714M/s/cpu).
> >>>
> >>> [0] https://lore.kernel.org/all/CAEf4BzaO4eG6hr2hzXYpn+7Uer4chS0R99zL=
n02ezZ5YruVuQw@mail.gmail.com/
> >>> [1] https://lore.kernel.org/all/Zr3RN4zxF5XPgjEB@J2N7QTR9R3/
> >>> [2] https://lore.kernel.org/all/20240815014629.2685155-1-liaochang1@h=
uawei.com/
> >>>
> >>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> >>> ---
> >>>  arch/arm64/include/asm/insn.h            |  1 +
> >>>  arch/arm64/kernel/probes/decode-insn.c   | 16 +++++
> >>>  arch/arm64/kernel/probes/decode-insn.h   |  1 +
> >>>  arch/arm64/kernel/probes/simulate-insn.c | 89 ++++++++++++++++++++++=
++
> >>>  arch/arm64/kernel/probes/simulate-insn.h |  1 +
> >>>  arch/arm64/kernel/probes/uprobes.c       | 21 ++++++
> >>>  arch/arm64/lib/insn.c                    |  5 ++
> >>>  7 files changed, 134 insertions(+)
> >>>
> >
> > [...]
>
> --
> BR
> Liao, Chang
>

