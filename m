Return-Path: <bpf+bounces-67895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C88D3B502F6
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 18:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3A71C6553C
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 16:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4480350D5B;
	Tue,  9 Sep 2025 16:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXJVJyuA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35B3228C99;
	Tue,  9 Sep 2025 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436283; cv=none; b=WJ9xtaQha3eOv6KCuqrsfVrtC4Condb3XRcQCUN8czXUNA9QiEfVp8MExajl10QjmSDyDVwRP4Gz4amz5cqw1psuX9PeyKOp9BhICcBqq7OiOxumjdZnQs/Wwm6UWr+h6I6Cz4Po7Uq9rxb4JR0VfJVU8AcpUzZFsmlesFMRkCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436283; c=relaxed/simple;
	bh=bNtLYd2L6M+ZCsukpHb4tRizHcY3x+2F613p3R2EI4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCPT1JPS+sVoLGXXKaznSHUhm02QPI+Zuz6mRDzMtrpmlEDpgEVR51guP86xr8TQ7/See+bZrDN4OQOklllvgx8o654gPSmbYbQ0Dkn0xu0e4Bv9unIyLmxEvHTdSHeFYfnKH2eJP5vD818d5KE0Wm7sSBF9CNAXZpaW4IfZu0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXJVJyuA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24cb39fbd90so48947275ad.3;
        Tue, 09 Sep 2025 09:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757436281; x=1758041081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSkwLnBsHHcwsQtnOBtGK2900wi8i4lVybwCJ7dh00w=;
        b=hXJVJyuAvPlxHmHbSQbWWVespsPsoUGFlO9hSNrpnVqGCraWOT2Cu83NSP+8voPiLf
         1HrSLqnVe615pZvQbPSr8LnGzD9p8wCNPsyjNDZj3enw0nknPbVnf3/XGQ4tjZ9yrSIZ
         5zNHlIDEJwt61CphzjCJSLA5l3TrDK/2NDKpuqiDQaQteKY/yIB18AmoNE27Z9zGoEk5
         WyOpTnD3EPyEVAq52pdGC69X7qoP3FqHHHm84FJATOqhycolDfdgYAAzDTTGFJGqGaMi
         btcQpl1YvxZ31jvjdsN12SCiDGIC4RcV5pN08XDdqcnM6M3hYGA6ZjpV6KKqBTF+pMIJ
         u0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757436281; x=1758041081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSkwLnBsHHcwsQtnOBtGK2900wi8i4lVybwCJ7dh00w=;
        b=ZPmFziXJjrbIBMLLD1KRLJRuE53/YMdLpVWuTndrWAeVCTJd7T7CN2lVO1TcJAlr4A
         CKeIGbLCXYAPci0GE7TTTZNpYGUyydf+SY7u2wpUK+vfFEQHJH1QPpyQzgmMjxCX7Rfx
         E8H8iLPh4kMCpHOh1Kphtlllc0n7PG57KeEQIUEt+1ZyTmeh7EnXRBe8X7q72Q8jWXhZ
         pEvUEmy4lWJbccu3VvqVo5X5rE4QYTMpjQMTfycoJwtzZ2H4m05K/oMBuSR6K0z975AJ
         OguZpXOkmardHBvpK/dvVk6GseC9cyNPkXeTwjAqfxVnlLix/2266nm7nRqDk6sq/R4s
         2anA==
X-Forwarded-Encrypted: i=1; AJvYcCUVepMDg/XEACUZvaX0iSO04MNOh02qpiLxZbNNcSXlIcvRKO69qY5TFARWErnri1TuHy0qZPIOyEeYb+zHdNG0RtCh@vger.kernel.org, AJvYcCVtFlTlK4QpCC749FJlz5yJKyovV+MyxUWUllRZApiIVD4+BzkEQEgStCITBsiXxfAToKzoWtPQpZJm4irm@vger.kernel.org, AJvYcCXZjX83c2XXSn5obluDfngNOrExeqC0z/lDHFp3U52tQ+SUs8zaCCtEatpe8bhbt17knLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza/VDP8TtDyqa1Fj7g72xfaVhBUw15wSa4B5qUDGeRzh9yfPYS
	ToVICibaUV4J2nW8T/dQnix201d0ES9IGWSXDmQ+NxIwp0n0VOPuVgyP1dWW52cETbEMFqSM2uC
	39gQ4fmi00eX6oMkG2DKylZUwvH06xz0=
X-Gm-Gg: ASbGncuguhr9wV2SQYLLgfeYhEd1GQTor0/9VUothYCFRkl7fZ2AqVURlrws7r+Ap3w
	N73LomZHd8VehLWh3wqIXNUKlnXgc5zpTajZm/HT/6f+aSqj3y6OV6CzH4Yadup8xfI6jnSSkPa
	9f1yRAZbpB1vZylszbhkFOVKNw80Y6E9UD0g4G9S4PuHLaXL/yakSuhWpW+Wba6IPNYJLaaqQch
	82oppo22bH2QErxsxGwUR8=
X-Google-Smtp-Source: AGHT+IG29apTsXAZMmsw1CgrEszKuGBMI+sEbqLqwi+QUkwE/YBb/lA85/xDTnPPWvA1FzyNbXHf3CgLza2bfVkZsnk=
X-Received: by 2002:a17:902:d2c7:b0:249:1440:59a6 with SMTP id
 d9443c01a7336-25170c44d22mr139247845ad.33.1757436280913; Tue, 09 Sep 2025
 09:44:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821122822.671515652@infradead.org> <aKcqm023mYJ5Gv2l@krava>
 <aKgtaXHtQvJ0nm_b@krava> <CAEf4BzYg9jsEK1XdKW4dKFdOSrY4CAspaCAAv6ZJZScHxkHSyA@mail.gmail.com>
 <aMAiMrLlfmG9FbQ3@krava> <CAEf4BzZnvWH-X-7qKvx2LxzR+xkFfvjj27Tfjoui5xnph-urMw@mail.gmail.com>
 <aMBYJvtvR7c-Srkb@krava>
In-Reply-To: <aMBYJvtvR7c-Srkb@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Sep 2025 12:44:29 -0400
X-Gm-Features: Ac12FXxHbFc-MNQFIxWNt1iywe3jTGzlQxQkdGkwRYPmpF7Qg4ZX290a8LpqSfE
Message-ID: <CAEf4Bza7Toiemx7E6Cr8FyZ=M3VC1eqfhNAVuxU=3Tm6pYWc4w@mail.gmail.com>
Subject: Re: [PATCH 0/6] uprobes/x86: Cleanups and fixes
To: Jiri Olsa <olsajiri@gmail.com>
Cc: andrii@kernel.org, Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com, 
	mhiramat@kernel.org, linux-kernel@vger.kernel.org, alx@kernel.org, 
	eyal.birger@gmail.com, kees@kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, songliubraving@fb.com, 
	yhs@fb.com, john.fastabend@gmail.com, haoluo@google.com, rostedt@goodmis.org, 
	alan.maguire@oracle.com, David.Laight@aculab.com, thomas@t-8ch.de, 
	mingo@kernel.org, rick.p.edgecombe@intel.com, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 12:39=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Tue, Sep 09, 2025 at 11:20:13AM -0400, Andrii Nakryiko wrote:
> > On Tue, Sep 9, 2025 at 8:48=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> w=
rote:
> > >
> > > On Fri, Aug 22, 2025 at 11:05:59AM -0700, Andrii Nakryiko wrote:
> > > > On Fri, Aug 22, 2025 at 1:42=E2=80=AFAM Jiri Olsa <olsajiri@gmail.c=
om> wrote:
> > > > >
> > > > > On Thu, Aug 21, 2025 at 04:18:03PM +0200, Jiri Olsa wrote:
> > > > > > On Thu, Aug 21, 2025 at 02:28:22PM +0200, Peter Zijlstra wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > These are cleanups and fixes that I applied on top of Jiri's =
patches:
> > > > > > >
> > > > > > >   https://lkml.kernel.org/r/20250720112133.244369-1-jolsa@ker=
nel.org
> > > > > > >
> > > > > > > The combined lot sits in:
> > > > > > >
> > > > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.=
git perf/core
> > > > > > >
> > > > > > > Jiri was going to send me some selftest updates that might me=
an rebasing that
> > > > > > > tree, but we'll see. If this all works we'll land it in -tip.
> > > > > > >
> > > > > >
> > > > > > hi,
> > > > > > sent the selftest fix in here:
> > > > > >   https://lore.kernel.org/bpf/20250821141557.13233-1-jolsa@kern=
el.org/T/#u
> > > > >
> > > > > Andrii,
> > > > > do we want any special logistic for the bpf/selftest changes or i=
t could
> > > > > go through the tip tree?
> > > >
> > > > let's route selftest changes through tip together with the rest of
> > > > uprobe changes, it's unlikely to conflict
> > >
> > > fyi, there's conflict now between tip/perf/core and bpf-next/master
> > > in the selftests.. due to usdt SIB argument support changes
> > >
> > > please let me know if you need any help in resolving that
> >
> > so selftest change hasn't landed in tip/perf/core just yet, is that
> > right? If there is a conflict, I guess that changes equation a bit.
> > I'd land it in bpf-next and for now disable that test in BPF CI until
> > the trees converge. WDYT?
>
> I can see the selftests changes in tip/perf/core already
>

Ah, that's the shadow stack test. I thought we are talking about
-ENXIO change to sys_uprobe and dropping that BPF selftests you had
that makes sure the process is killed.

Well, I guess we'll have to handle that conflict then?..

> jirka
>
>
> 16ed38922765 (HEAD -> tip/perf/core) perf: Skip user unwind if the task i=
s a kernel thread
> d77e3319e310 perf: Simplify get_perf_callchain() user logic
> 90942f9fac05 perf: Use current->flags & PF_KTHREAD|PF_USER_WORKER instead=
 of current->mm =3D=3D NULL
> 153f9e74dec2 perf: Have get_perf_callchain() return NULL if crosstask and=
 user are set
> e649bcda25b5 perf: Remove get_perf_callchain() init_nr argument
> f49e1be19542 perf/x86: Print PMU counters bitmap in x86_pmu_show_pmu_cap(=
)
> 2676dbf9f4fb perf/x86/intel: Add ICL_FIXED_0_ADAPTIVE bit into INTEL_FIXE=
D_BITS_MASK
> 9b3e119784bc perf/x86/intel: Change macro GLOBAL_CTRL_EN_PERF_METRICS to =
BIT_ULL(48)
> 0c5caea762de perf/x86: Add PERF_CAP_PEBS_TIMING_INFO flag
> 43796f305078 perf/x86/intel: Fix IA32_PMC_x_CFG_B MSRs access error
> d9cf9c6884d2 perf/x86/intel: Use early_initcall() to hook bts_init()
> e173287b5d21 uprobes: Remove redundant __GFP_NOWARN
> 9ffc7a635c35 selftests/seccomp: validate uprobe syscall passes through se=
ccomp
> 89d1d8434d24 seccomp: passthrough uprobe systemcall without filtering
> 52718438af2a selftests/bpf: Fix uprobe syscall shadow stack test
> 3abf4298c613 selftests/bpf: Change test_uretprobe_regs_change for uprobe =
and uretprobe
> 275eae678986 selftests/bpf: Add uprobe_regs_equal test
> 875e1705ad99 selftests/bpf: Add optimized usdt variant for basic usdt tes=
t
> c11661bd9adf selftests/bpf: Add uprobe syscall sigill signal test
> c8be59667cf1 selftests/bpf: Add hit/attach/detach race optimized uprobe t=
est
> d5c86c337010 selftests/bpf: Add uprobe/usdt syscall tests
> 7932c4cf5771 selftests/bpf: Rename uprobe_syscall_executed prog to test_u=
retprobe_multi
> 4e7005223e6d selftests/bpf: Reorg the uprobe_syscall test function
> 17c3b0015764 selftests/bpf: Import usdt.h from libbpf/usdt project
> 354492a0e1bc uprobes/x86: Add SLS mitigation to the trampolines
> 60ed85b7e469 uprobes/x86: Make asm style consistent
> ...

