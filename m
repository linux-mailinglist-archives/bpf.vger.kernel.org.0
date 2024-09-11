Return-Path: <bpf+bounces-39655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33928975BD5
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 22:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB119287921
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 20:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75F414EC51;
	Wed, 11 Sep 2024 20:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQI0PWtM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4F6149003;
	Wed, 11 Sep 2024 20:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726086984; cv=none; b=b5GZjuoSqUKQGqWohAgpSiMLCUC/CIJ7Vo79TCal4xyiYaHcx5lzR1wJyAhkqHeDndxqpa0ftIp2CtVMSyVf/yvEJI5huMgWbNwLDu7bCvCmT2AICaQB+BeipW5phCB8ES2w6zhbvsojWepY6QasUED47FVEk9ZjumJwHGTbcNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726086984; c=relaxed/simple;
	bh=J7wFICQvX+deOv+4zTqudEnSjsRuWt/9BGeGeGrHn3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PjpIQwtalYCw2Kf06gan3CAZCdZBoLtOAU+BtN6E6v9SiuKm9phoZjQYLyBaBxog9UW0c7ibA99ozwc0VHztPUZuCIQQES1VyQFlyVT1+I3n78Bag5vh162V6xREYM/BoB/7rRT0K4QsSYwDwfGAl+jpvJOoRDU7hW+7DNPGbdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQI0PWtM; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2daaa9706a9so183810a91.1;
        Wed, 11 Sep 2024 13:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726086982; x=1726691782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GY9CDptXF1uc9239tLpvNPZQma9cc8u/mmYymfYr5N4=;
        b=HQI0PWtMLtL4JWzOmHdlY7GamFc0L8HtJNEV7eluv1fi7q0Mr30cmj9aQtYSahvrw4
         k9t60T/ldEEcEjwXxqzH6k/rKkgToFycNYLj8AzvrUuR22O8B2SuAdFfnnG10zuHJ8xo
         /ondYFvdp6EEi7pSOoUyZAPEvvdEVjUckPIVOXjDd4sVXeu6RN9OWyiPPZLXp64I5yw/
         lw8dx3L9FwBQTcQkDa/CIjxiXli4pZpsL/XR9aejpiEweCZhH2v6Z8PDC8eGkvF+7gVk
         QB0ng3MlMTKdKVTq3wQCfHvcdCFz/1iyRE4Wfq5qwlBwWe8A9h9LIyaBs1OYEzmGlZiO
         /dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726086982; x=1726691782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GY9CDptXF1uc9239tLpvNPZQma9cc8u/mmYymfYr5N4=;
        b=LGwyJS9kUP4BSOrm2TnBsXCXw5DMU8+Dsa/1rwE4FrNlyVfxAFV5MoyZVwVsryDvji
         uR3siiBnwoRqAN1RlcaKbWvLE0SuR0zndbdwazO96fuTTzU8Be53Rbm4asnHYUty9UJi
         Xd1lQorWKetcs5aqTQUJryST/mvHsnJc4coulb2SLLjpi+mqhoNSJeFCzoZhW6JJbI2j
         lhMAKJtRW6Vz4u3VSZ2PzlGIrdtQSt4wYmyBAmLHd9nHnSQd1c7Pdi84LBEpSVU8ctdw
         cveN1pyiZnkv9wVlHCk9KpxKg+9/7bQIjTIlAeV6R+XeKq4C2JkqynGFtFTpxR76h6vb
         qrEg==
X-Forwarded-Encrypted: i=1; AJvYcCVFfYogE/+hSiAG4xS2XEcdBGEr2J2xEXuc+UZFHk45uugcevsY5CuRZ5Nfym5oSffgXorh/nhobDWizv4g@vger.kernel.org, AJvYcCX4nxlM7OqJc+ptN02dCu/EfzMcDabqYvdPR+hvZ1a6h8i0vJLjVocAUCFj2tjzVKVW/6pWUvgfIQPKGkaZmW1//8hI@vger.kernel.org, AJvYcCXmPoOYceFa2aVcLamRoiPq+g/Qi1DL5SWGIQrNY00sWNulcKhbaG+bSj1h+2D7VMFX5yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxELLN82hPsc0nSNy57FvD0lsbmcvl6jN2dbVL0jsW8orh8QJeH
	Pna/1iRaTr06ix/JJEnYI1RmZIE13hxLc0dhhJIXJ5zA5GD2ShHTTgGK38ehiiK9MshpN5evhTQ
	p0ClSLmYt5kHOiPVIEphhvjNwLuo=
X-Google-Smtp-Source: AGHT+IGJ/5nrG0RE6b3kSvB+YZqkxd2YpXZhu+lxgPIhG7n1lPv0YbL5F912uUA03IvhLzd2v4d4D0YwwJk1rRVEUqQ=
X-Received: by 2002:a17:90a:6b44:b0:2d8:9513:d889 with SMTP id
 98e67ed59e1d1-2db9ffbeecdmr449728a91.14.1726086982028; Wed, 11 Sep 2024
 13:36:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910060407.1427716-1-liaochang1@huawei.com>
 <CAEf4BzZ3trjMWjvWX4Zy1GzW5RN1ihXZSnLZax7V-mCzAUg2cg@mail.gmail.com> <f96eda54-9fb1-31a0-b138-cde0716f11f1@huawei.com>
In-Reply-To: <f96eda54-9fb1-31a0-b138-cde0716f11f1@huawei.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Sep 2024 13:36:10 -0700
Message-ID: <CAEf4BzYNbvaghksdZCSxH8gt=MxskVEWStkznPH1-orBQeS3Zw@mail.gmail.com>
Subject: Re: [PATCH] arm64: uprobes: Simulate STP for pushing fp/lr into user stack
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org, 
	oleg@redhat.com, peterz@infradead.org, ast@kernel.org, puranjay@kernel.org, 
	andrii@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 8:07=E2=80=AFPM Liao, Chang <liaochang1@huawei.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/9/11 4:54, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Mon, Sep 9, 2024 at 11:14=E2=80=AFPM Liao Chang <liaochang1@huawei.c=
om> wrote:
> >>
> >> This patch is the second part of a series to improve the selftest benc=
h
> >> of uprobe/uretprobe [0]. The lack of simulating 'stp fp, lr, [sp, #imm=
]'
> >> significantly impact uprobe/uretprobe performance at function entry in
> >> most user cases. Profiling results below reveals the STP that executes
> >> in the xol slot and trap back to kernel, reduce redis RPS and increase
> >> the time of string grep obviously.
> >>
> >> On Kunpeng916 (Hi1616), 4 NUMA nodes, 64 Arm64 cores@2.4GHz.
> >>
> >> Redis GET (higher is better)
> >> ----------------------------
> >> No uprobe: 49149.71 RPS
> >> Single-stepped STP: 46750.82 RPS
> >> Emulated STP: 48981.19 RPS
> >>
> >> Redis SET (larger is better)
> >> ----------------------------
> >> No uprobe: 49761.14 RPS
> >> Single-stepped STP: 45255.01 RPS
> >> Emulated stp: 48619.21 RPS
> >>
> >> Grep (lower is better)
> >> ----------------------
> >> No uprobe: 2.165s
> >> Single-stepped STP: 15.314s
> >> Emualted STP: 2.216s
> >>
> >> Additionally, a profiling of the entry instruction for all leaf and
> >> non-leaf function, the ratio of 'stp fp, lr, [sp, #imm]' is larger tha=
n
> >> 50%. So simulting the STP on the function entry is a more viable optio=
n
> >> for uprobe.
> >>
> >> In the first version [1], it used a uaccess routine to simulate the ST=
P
> >> that push fp/lr into stack, which use double STTR instructions for
> >> memory store. But as Mark pointed out, this approach can't simulate th=
e
> >> correct single-atomicity and ordering properties of STP, especiallly
> >> when it interacts with MTE, POE, etc. So this patch uses a more comple=
x
> >
> > Does all those effects matter if the thread is stopped after
> > breakpoint? This is pushing to stack, right? Other threads are not
> > supposed to access that memory anyways (not the well-defined ones, at
> > least, I suppose). Do we really need all these complications for
>
> I have raised the same question in my reply to Mark. Since the STP
> simulation focuses on the uprobe/uretprob at function entry, which
> push two registers onto *stack*. I believe it might not require strict
> alignment with the exact property of STP. However, as you know, Mark

Agreed.

> stand by his comments about STP simulation, which is why I send this
> patch out. Although the gain is not good as the uaccess version, it
> still offer some better result than the current XOL code.
>
> > uprobes? We use a similar approach in x86-64, see emulate_push_stack()
> > in arch/x86/kernel/uprobes.c and it works great in practice (and has
>
> Yes, I've noticed the X86 routine. Actually. The CPU-specific difference
> lies in Arm64 CPUs with PAN enabled. Due to security reasons, it doesn't
> support STP (storing pairs of registers to memory) when accessing userpsa=
ce
> address. This leads to kernel has to use STTR instructions (storing singl=
e
> register to unprivileged memory) twice, which can't meet the atomicity
> and ordering properties of original STP at userspace. In future, if Arm64
> would add some instruction for storing pairs of registers to unprivileged
> memory, it ought to replace this inefficient approach.
>
> > been for years by now). Would be nice to keep things simple knowing
> > that this is specifically for this rather well-defined and restricted
> > uprobe/uretprobe use case.
> >
> > Sorry, I can't help reviewing this, but I have a hunch that we might
> > be over-killing it with this approach, no?
>
> This approach fails to obtain the max benefit from simuation indeed.
>

Yes, the performance hit is very large for seemingly no good reason,
which is why I'm asking.

And all this performance concern is not just some pure
microbenchmarking. We do have use cases with millions of uprobe calls
per second. E.g., tracing every single Python function call, then
rolling a dice (in BPF program), and sampling some portion of them
(more heavy-weight logic). As such, it's critical to be able to
trigger uprobe as fast as possible, then most of the time we do
nothing. So any overheads like this one are very noticeable and limit
possible applications.

> >
> >
> >> and inefficient approach that acquires user stack pages, maps them to
> >> kernel address space, and allows kernel to use STP directly push fp/lr
> >> into the stack pages.
> >>
> >> xol-stp
> >> -------
> >> uprobe-nop      ( 1 cpus):    1.566 =C2=B1 0.006M/s  (  1.566M/s/cpu)
> >> uprobe-push     ( 1 cpus):    0.868 =C2=B1 0.001M/s  (  0.868M/s/cpu)
> >> uprobe-ret      ( 1 cpus):    1.629 =C2=B1 0.001M/s  (  1.629M/s/cpu)
> >> uretprobe-nop   ( 1 cpus):    0.871 =C2=B1 0.001M/s  (  0.871M/s/cpu)
> >> uretprobe-push  ( 1 cpus):    0.616 =C2=B1 0.001M/s  (  0.616M/s/cpu)
> >> uretprobe-ret   ( 1 cpus):    0.878 =C2=B1 0.002M/s  (  0.878M/s/cpu)
> >>
> >> simulated-stp
> >> -------------
> >> uprobe-nop      ( 1 cpus):    1.544 =C2=B1 0.001M/s  (  1.544M/s/cpu)
> >> uprobe-push     ( 1 cpus):    1.128 =C2=B1 0.002M/s  (  1.128M/s/cpu)
> >> uprobe-ret      ( 1 cpus):    1.550 =C2=B1 0.005M/s  (  1.550M/s/cpu)
> >> uretprobe-nop   ( 1 cpus):    0.872 =C2=B1 0.004M/s  (  0.872M/s/cpu)
> >> uretprobe-push  ( 1 cpus):    0.714 =C2=B1 0.001M/s  (  0.714M/s/cpu)
> >> uretprobe-ret   ( 1 cpus):    0.896 =C2=B1 0.001M/s  (  0.896M/s/cpu)
> >>
> >> The profiling results based on the upstream kernel with spinlock
> >> optimization patches [2] reveals the simulation of STP increase the
> >> uprobe-push throughput by 29.3% (from 0.868M/s/cpu to 1.1238M/s/cpu) a=
nd
> >> uretprobe-push by 15.9% (from 0.616M/s/cpu to 0.714M/s/cpu).
> >>
> >> [0] https://lore.kernel.org/all/CAEf4BzaO4eG6hr2hzXYpn+7Uer4chS0R99zLn=
02ezZ5YruVuQw@mail.gmail.com/
> >> [1] https://lore.kernel.org/all/Zr3RN4zxF5XPgjEB@J2N7QTR9R3/
> >> [2] https://lore.kernel.org/all/20240815014629.2685155-1-liaochang1@hu=
awei.com/
> >>
> >> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> >> ---
> >>  arch/arm64/include/asm/insn.h            |  1 +
> >>  arch/arm64/kernel/probes/decode-insn.c   | 16 +++++
> >>  arch/arm64/kernel/probes/decode-insn.h   |  1 +
> >>  arch/arm64/kernel/probes/simulate-insn.c | 89 +++++++++++++++++++++++=
+
> >>  arch/arm64/kernel/probes/simulate-insn.h |  1 +
> >>  arch/arm64/kernel/probes/uprobes.c       | 21 ++++++
> >>  arch/arm64/lib/insn.c                    |  5 ++
> >>  7 files changed, 134 insertions(+)
> >>
> >
> > [...]
> >
> >
>
> --
> BR
> Liao, Chang

