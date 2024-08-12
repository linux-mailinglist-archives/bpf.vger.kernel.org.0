Return-Path: <bpf+bounces-36919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830FF94F618
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 19:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79035B21E16
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 17:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A08F189509;
	Mon, 12 Aug 2024 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbQgXQn3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A67187332;
	Mon, 12 Aug 2024 17:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723485011; cv=none; b=MFTU3UPbFd6M0zjn/nz29fgO0AtEJgAvODqS+hDgRO4SjITGYlMgE5gjoNVbMVnslpzBhH607tkJaYJYu8Ok5Mcgoz4cu/lQTkn/ADA01Syq+cD2Dr56eAeyvvJB9WCLKrK5AHFBNy6DrYVuFvIErFDZnxLFMlgRg4uC9HFXeKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723485011; c=relaxed/simple;
	bh=2z2RSKov/GyH1EK5WVNnSxrbnB9jrrm9TIxF5hy0Ejk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KYop6/RZ692/YKuVqvZjkNbL4D4mHyHmrD8ZgkfCl7VZsGY0dd2BnVjFjER9Me8K99DMHLBIPprOgiTUf9XHfvK2ePf6YutcwveURGl/T33Z/Hv5CF9aa6/DI7xwAMtiAvKV59icbGZINoK4g7EkMj884FPbQGKycA30kfIg3IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbQgXQn3; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d1bb65e906so2952820a91.3;
        Mon, 12 Aug 2024 10:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723485008; x=1724089808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NawEhTzLqH6yNvIfmhIsOQiQSLsjJ89Sw7WTHq6svcA=;
        b=PbQgXQn3ukIAkv8ddUq+GLEG7urlVYxJVStzACTLEKd4h+BjSRvFsLUqs5JhD1fnOU
         sn4sIz4z8gJaRczPnC/GhMqxMAjwXVqrPReeI7Al4J3T7GOmnhSuyz30T4T6c3fa0ttL
         BLk+HHP5bcIQhqvovzfpvH2ioY8t0pgO7m68uwJOWAsyjgu1+9qRxh0S83/AXg/qamJB
         qluMq7p2buI3iIkmExQRCbSGGly2J2URjGgLkqG5niTHSpZ7eUaEGZNc8rjEUSs1VEHq
         /COdLmkAldcpfwQ9PV5cumE+gwWDf6EmV00DyKrs5eApMUPrsUUl/QOMJGZT8NRRItd0
         Z26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723485008; x=1724089808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NawEhTzLqH6yNvIfmhIsOQiQSLsjJ89Sw7WTHq6svcA=;
        b=dkmzEWo570949fHlOU1InZac2yMj2wmGjJnCIfVw6yK31RHRc2ugiyx2UDxOYiUD2P
         JzKlPfbd/ynCMNsED7AcKD3oT9r6SeaKbwGirug+NQNhT8eLE4NF2u7tQlwt65AMiFKd
         RKLrXPAyDntlLujPzdnIw8EYN7UY7lmI2NeuJ9ndtFfTYE7reeugPF5bVcJP8ut/T8ct
         fi2g3VpucnFtbxfj+xlGUAiP3KYdz3yulNQlXPImqfhnk2qcCCf9yKEmhv0GeVXwHADy
         0EcTf6H4ODTe4uZSjwH96c39jYjdxwPM+dC/WHn0X4i6RXoB6569NBq98j0HTidhSkNE
         Ofcg==
X-Forwarded-Encrypted: i=1; AJvYcCVOzhAskrZOeKbHc3HR47VoMFO+IYOzz2QFK9JZH9x7AUMR4Ch5PvP80NAG24pABcgAp01hRM1T3VdU4BIu7Z+14u/9B3n6ECFBSvyeJwuHuxRLzNYzwwRafWlz3RJORXNO0T8/QueIgQkaxoc+Hf/88AQR7RHlAXCw9PdSCqaXTK6pEi1Lzd2Ts0b4nasebmdb3VqwIrJctnVm6ONPDv7LOxG9brk/xg==
X-Gm-Message-State: AOJu0Yz0xihEs/EEs0eB61eDkaf6MgAHjJQ4Qkwtg0vE9X1dWrTSDh+6
	bkqQfoyIwgFauiRnhkZGTlBHKjYUJ5ERBuMt44XJ1LzJWiPFtcul0aHGTwnLltyzAGNOxbIHxhN
	fgmIwfzBb3vhfMfCEdtuL3lRATrw=
X-Google-Smtp-Source: AGHT+IEzNLNL72J4chcApxip/q/fhhOWJeN9YXVN3ipYVj/KZQHYL6UbpTdjRx5N6fk+CtSG34OoY/ZfBHTKTHmVGO8=
X-Received: by 2002:a17:90b:4b88:b0:2c8:85c:750b with SMTP id
 98e67ed59e1d1-2d39263fefdmr1134353a91.34.1723485008393; Mon, 12 Aug 2024
 10:50:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727094405.1362496-1-liaochang1@huawei.com>
 <7eefae59-8cd1-14a5-ef62-fc0e62b26831@huawei.com> <CAEf4BzaO4eG6hr2hzXYpn+7Uer4chS0R99zLn02ezZ5YruVuQw@mail.gmail.com>
 <85991ce3-674d-b46e-b4f9-88a50f7f5122@huawei.com>
In-Reply-To: <85991ce3-674d-b46e-b4f9-88a50f7f5122@huawei.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Aug 2024 10:49:56 -0700
Message-ID: <CAEf4BzYvpgfFGckcKdzkC_g1J1SFi7xBe=_cjdVy4KEMikvGMw@mail.gmail.com>
Subject: Re: [PATCH] uprobes: Optimize the allocation of insn_slot for performance
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, 
	"oleg@redhat.com >> Oleg Nesterov" <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, paulmck@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 4:11=E2=80=AFAM Liao, Chang <liaochang1@huawei.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/8/9 2:26, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Thu, Aug 8, 2024 at 1:45=E2=80=AFAM Liao, Chang <liaochang1@huawei.c=
om> wrote:
> >>
> >> Hi Andrii and Oleg.
> >>
> >> This patch sent by me two weeks ago also aim to optimize the performan=
ce of uprobe
> >> on arm64. I notice recent discussions on the performance and scalabili=
ty of uprobes
> >> within the mailing list. Considering this interest, I've added you and=
 other relevant
> >> maintainers to the CC list for broader visibility and potential collab=
oration.
> >>
> >
> > Hi Liao,
> >
> > As you can see there is an active work to improve uprobes, that
> > changes lifetime management of uprobes, removes a bunch of locks taken
> > in the uprobe/uretprobe hot path, etc. It would be nice if you can
> > hold off a bit with your changes until all that lands. And then
> > re-benchmark, as costs might shift.
> >
> > But also see some remarks below.
> >
> >> Thanks.
> >>
> >> =E5=9C=A8 2024/7/27 17:44, Liao Chang =E5=86=99=E9=81=93:
> >>> The profiling result of single-thread model of selftests bench reveal=
s
> >>> performance bottlenecks in find_uprobe() and caches_clean_inval_pou()=
 on
> >>> ARM64. On my local testing machine, 5% of CPU time is consumed by
> >>> find_uprobe() for trig-uprobe-ret, while caches_clean_inval_pou() tak=
e
> >>> about 34% of CPU time for trig-uprobe-nop and trig-uprobe-push.
> >>>
> >>> This patch introduce struct uprobe_breakpoint to track previously
> >>> allocated insn_slot for frequently hit uprobe. it effectively reduce =
the
> >>> need for redundant insn_slot writes and subsequent expensive cache
> >>> flush, especially on architecture like ARM64. This patch has been tes=
ted
> >>> on Kunpeng916 (Hi1616), 4 NUMA nodes, 64 cores@ 2.4GHz. The selftest
> >>> bench and Redis GET/SET benchmark result below reveal obivious
> >>> performance gain.
> >>>
> >>> before-opt
> >>> ----------
> >>> trig-uprobe-nop:  0.371 =C2=B1 0.001M/s (0.371M/prod)
> >>> trig-uprobe-push: 0.370 =C2=B1 0.001M/s (0.370M/prod)
> >>> trig-uprobe-ret:  1.637 =C2=B1 0.001M/s (1.647M/prod)
> >
> > I'm surprised that nop and push variants are much slower than ret
> > variant. This is exactly opposite on x86-64. Do you have an
> > explanation why this might be happening? I see you are trying to
> > optimize xol_get_insn_slot(), but that is (at least for x86) a slow
> > variant of uprobe that normally shouldn't be used. Typically uprobe is
> > installed on nop (for USDT) and on function entry (which would be push
> > variant, `push %rbp` instruction).
> >
> > ret variant, for x86-64, causes one extra step to go back to user
> > space to execute original instruction out-of-line, and then trapping
> > back to kernel for running uprobe. Which is what you normally want to
> > avoid.
> >
> > What I'm getting at here. It seems like maybe arm arch is missing fast
> > emulated implementations for nops/push or whatever equivalents for
> > ARM64 that is. Please take a look at that and see why those are slow
> > and whether you can make those into fast uprobe cases?
>
> Hi Andrii,
>
> As you correctly pointed out, the benchmark result on Arm64 is counterint=
uitive
> compared to X86 behavior. My investigation revealed that the root cause l=
ies in
> the arch_uprobe_analyse_insn(), which excludes the Arm64 equvialents inst=
ructions
> of 'nop' and 'push' from the emulatable instruction list. This forces the=
 kernel
> to handle these instructions out-of-line in userspace upon breakpoint exc=
eption
> is handled, leading to a significant performance overhead compared to 're=
t' variant,
> which is already emulated.
>
> To address this issue, I've developed a patch supports  the emulation of =
'nop' and
> 'push' variants. The benchmark results below indicates the performance ga=
in of
> emulation is obivious.
>
> xol (1 cpus)
> ------------
> uprobe-nop:  0.916 =C2=B1 0.001M/s (0.916M/prod)
> uprobe-push: 0.908 =C2=B1 0.001M/s (0.908M/prod)
> uprobe-ret:  1.855 =C2=B1 0.000M/s (1.855M/prod)
> uretprobe-nop:  0.640 =C2=B1 0.000M/s (0.640M/prod)
> uretprobe-push: 0.633 =C2=B1 0.001M/s (0.633M/prod)
> uretprobe-ret:  0.978 =C2=B1 0.003M/s (0.978M/prod)
>
> emulation (1 cpus)
> -------------------
> uprobe-nop:  1.862 =C2=B1 0.002M/s  (1.862M/s/cpu)
> uprobe-push: 1.743 =C2=B1 0.006M/s  (1.743M/s/cpu)
> uprobe-ret:  1.840 =C2=B1 0.001M/s  (1.840M/s/cpu)
> uretprobe-nop:  0.964 =C2=B1 0.004M/s  (0.964M/s/cpu)
> uretprobe-push: 0.936 =C2=B1 0.004M/s  (0.936M/s/cpu)
> uretprobe-ret:  0.940 =C2=B1 0.001M/s  (0.940M/s/cpu)
>
> As you can see, the performance gap between nop/push and ret variants has=
 been significantly
> reduced. Due to the emulation of 'push' instruction need to access usersp=
ace memory, it spent
> more cycles than the other.

Great, it's an obvious improvement. Are you going to send patches
upstream? Please cc bpf@vger.kernel.org as well.


I'm also thinking we should update uprobe/uretprobe benchmarks to be
less x86-specific. Right now "-nop" is the happy fastest case, "-push"
is still happy, slightly slower case (due to the need to emulate stack
operation) and "-ret" is meant to be the slow single-step case. We
should adjust the naming and make sure that on ARM64 we hit similar
code paths. Given you seem to know arm64 pretty well, can you please
take a look at updating bench tool for ARM64 (we can also rename
benchmarks to something a bit more generic, rather than using
instruction names)?

>
> >
> >>> trig-uretprobe-nop:  0.331 =C2=B1 0.004M/s (0.331M/prod)
> >>> trig-uretprobe-push: 0.333 =C2=B1 0.000M/s (0.333M/prod)
> >>> trig-uretprobe-ret:  0.854 =C2=B1 0.002M/s (0.854M/prod)
> >>> Redis SET (RPS) uprobe: 42728.52
> >>> Redis GET (RPS) uprobe: 43640.18
> >>> Redis SET (RPS) uretprobe: 40624.54
> >>> Redis GET (RPS) uretprobe: 41180.56
> >>>
> >>> after-opt
> >>> ---------
> >>> trig-uprobe-nop:  0.916 =C2=B1 0.001M/s (0.916M/prod)
> >>> trig-uprobe-push: 0.908 =C2=B1 0.001M/s (0.908M/prod)
> >>> trig-uprobe-ret:  1.855 =C2=B1 0.000M/s (1.855M/prod)
> >>> trig-uretprobe-nop:  0.640 =C2=B1 0.000M/s (0.640M/prod)
> >>> trig-uretprobe-push: 0.633 =C2=B1 0.001M/s (0.633M/prod)
> >>> trig-uretprobe-ret:  0.978 =C2=B1 0.003M/s (0.978M/prod)
> >>> Redis SET (RPS) uprobe: 43939.69
> >>> Redis GET (RPS) uprobe: 45200.80
> >>> Redis SET (RPS) uretprobe: 41658.58
> >>> Redis GET (RPS) uretprobe: 42805.80
> >>>
> >>> While some uprobes might still need to share the same insn_slot, this
> >>> patch compare the instructions in the resued insn_slot with the
> >>> instructions execute out-of-line firstly to decides allocate a new on=
e
> >>> or not.
> >>>
> >>> Additionally, this patch use a rbtree associated with each thread tha=
t
> >>> hit uprobes to manage these allocated uprobe_breakpoint data. Due to =
the
> >>> rbtree of uprobe_breakpoints has smaller node, better locality and le=
ss
> >>> contention, it result in faster lookup times compared to find_uprobe(=
).
> >>>
> >>> The other part of this patch are some necessary memory management for
> >>> uprobe_breakpoint data. A uprobe_breakpoint is allocated for each new=
ly
> >>> hit uprobe that doesn't already have a corresponding node in rbtree. =
All
> >>> uprobe_breakpoints will be freed when thread exit.
> >>>
> >>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> >>> ---
> >>>  include/linux/uprobes.h |   3 +
> >>>  kernel/events/uprobes.c | 246 +++++++++++++++++++++++++++++++++-----=
--
> >>>  2 files changed, 211 insertions(+), 38 deletions(-)
> >>>
> >
> > [...]
>
> --
> BR
> Liao, Chang

