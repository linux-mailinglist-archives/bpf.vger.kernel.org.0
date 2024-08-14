Return-Path: <bpf+bounces-37200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 557E5952221
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 20:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39E81F2367A
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 18:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF79B1BDAA5;
	Wed, 14 Aug 2024 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9iUWvZL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA52D3A29F;
	Wed, 14 Aug 2024 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723660950; cv=none; b=SC3V4J4htsLr29LZdoN9t6eRKVpgDZ4f16EyZ5j08aoAZZjcLrCLEKujOQgbaznatbQLuRFlDnW45Vb2H3KFkn3A+e2RMElRVUdOPnETS/y8XVustOAzVZj++WWtgsY6YdO/RvaPV+KvmNnpsmAQCk/S5SWmg6JbtEHEztRra00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723660950; c=relaxed/simple;
	bh=TU37DmTr1YEKbhnSgEzMaXP11iT9JVzF9g5jJFV02Ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6OEU1MFC9LsZLvHUDnsDamlFVpXQ+BIxcNS3xazdDUyGQ9QOYZ4fD8tBhEqrBq/09cSg5t5dn/ijViRbSbuqp5I71vnbMyjkfSQp5l1u/LU7CKIyeskBkbY5tW6FG9JeL6eDIL4KlCGJBqsBmUo8723Kxq/0QuwLa+wgO3JctI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9iUWvZL; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d3bc043e81so69060a91.2;
        Wed, 14 Aug 2024 11:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723660947; x=1724265747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gbsct0TgfVPvlu225RGcCO8r+10kIKBz4cC1cmHdeGA=;
        b=b9iUWvZLamhv5SpSG32V4s83NrmWfpsfneQHRGQiTas9xnxT52KsYu+n3h7zbWcYAI
         10ws9b1B3JKhutQxyS67buPeVXHuD8DSKk77C0R1P9yMKqTseMVDZBJc+k317toq32q2
         J2RCHCK0rDYza+MaF5uZtRTwtSy9rUoyvJmGw2/UYmfgYeOXuSNUN7LyiJk58NsX0fFW
         Tnp2Ajm7Mf46lVyL+12vAEghBq3+wrJl0t/zkUZDIFuE38fFUwMtrvTl9VgVunWeVgsO
         2ZiDmDwPJt9ttPFRpSJ6x3qUqFMFNiUR8IvnMIP0EJQJ+FvpjGZ8I1ic4rvWkV0y/rfO
         BnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723660947; x=1724265747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gbsct0TgfVPvlu225RGcCO8r+10kIKBz4cC1cmHdeGA=;
        b=jP5ITl5tz4lJTdQYwUWI8YnNS+YgiSH7K8WyIKPheT3guoBVJxvR0egstdxpdapfmF
         6+9H12hoahTJ4nsCCNzZsPl6pAVRre6cjkKqyu6DmCoFntXCScAkwVF4YRJ9C8wjotI0
         mY63GwE1NIIw9cAfV3X47GfeG5lpgJvLfOps2ItafZVDZ5VgaW4K/x8pPCnpSxbMEVgS
         7b4BXTYombv6N2eoM3G1SmasVQQsRoIhCRVCqnQkKodNSiJLOPBHQHNcAJpX60s4PJJE
         6pp19mqD/7ajH2gUC9caoafQINJOhr53mb2NaLXhHYoUDKh/hXEanc/U+QLx9TaYx4HE
         T4Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUDk+ayi2r/5wx46mSCg6zOZOclR9eDWGhiGJSiuUIJZtCg0WVB/6Yt4U9We7axvEUdkzE=@vger.kernel.org, AJvYcCWlc5xYtv4sOpPb2UmWNOyZ63kO5UIlJhUnnkDF99Wd1TcUIunpuMk3sCruKauPJ+zKYXpPImrtWzynebeO@vger.kernel.org, AJvYcCXP6vWrINao+WPJNiOk7rjUUvJfT2/k5XCJ45aJIKezzczcX+aRfM8YuVsw5sV2NffWeWJEj1aV7SxZ1cIgVLAiOA==@vger.kernel.org, AJvYcCXU1KyqAFVLQFt/3RLtyRVEBPGJR6QW3vzp9NHaosKfNMM6bgALfrxlqZ13+ul7Ka682ethR1/zZVMNpWifM7lkSUKl@vger.kernel.org
X-Gm-Message-State: AOJu0YywSGxCcaWbU8Gu3sBN79DTmTTTdk6lTGNO9Luqq/FqMpt/JKGU
	y5oDtbx6tpRNMGRy4fWPpGK/69NnrQBfiqMYxt0LRCtdSkkSZ6zfd751WhmH2stj9OZFM83t4S/
	WHeUpLW8XdITOB8HO/TqluV/gyT0=
X-Google-Smtp-Source: AGHT+IFJ6JssHR0s8HbeTx/tfoS96h/siWUufY6QMnrBcZAbsTdaxpmf1b1R02GXN5tUtFJZi6fIJLG0SBYdN93Wvdw=
X-Received: by 2002:a17:90b:3a8b:b0:2cd:7d6f:31ad with SMTP id
 98e67ed59e1d1-2d3aab489d1mr4273540a91.31.1723660946658; Wed, 14 Aug 2024
 11:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727094405.1362496-1-liaochang1@huawei.com>
 <7eefae59-8cd1-14a5-ef62-fc0e62b26831@huawei.com> <CAEf4BzaO4eG6hr2hzXYpn+7Uer4chS0R99zLn02ezZ5YruVuQw@mail.gmail.com>
 <85991ce3-674d-b46e-b4f9-88a50f7f5122@huawei.com> <CAEf4BzYvpgfFGckcKdzkC_g1J1SFi7xBe=_cjdVy4KEMikvGMw@mail.gmail.com>
 <2c23e9cc-5593-84d0-9157-1e946df941d9@huawei.com>
In-Reply-To: <2c23e9cc-5593-84d0-9157-1e946df941d9@huawei.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 14 Aug 2024 11:42:14 -0700
Message-ID: <CAEf4BzZkXWcE7=2FNm-DrSFOR-Pd9LqrQJvV0ShXfPnXzSzYjg@mail.gmail.com>
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

On Tue, Aug 13, 2024 at 9:17=E2=80=AFPM Liao, Chang <liaochang1@huawei.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/8/13 1:49, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Mon, Aug 12, 2024 at 4:11=E2=80=AFAM Liao, Chang <liaochang1@huawei.=
com> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2024/8/9 2:26, Andrii Nakryiko =E5=86=99=E9=81=93:
> >>> On Thu, Aug 8, 2024 at 1:45=E2=80=AFAM Liao, Chang <liaochang1@huawei=
.com> wrote:
> >>>>
> >>>> Hi Andrii and Oleg.
> >>>>
> >>>> This patch sent by me two weeks ago also aim to optimize the perform=
ance of uprobe
> >>>> on arm64. I notice recent discussions on the performance and scalabi=
lity of uprobes
> >>>> within the mailing list. Considering this interest, I've added you a=
nd other relevant
> >>>> maintainers to the CC list for broader visibility and potential coll=
aboration.
> >>>>
> >>>
> >>> Hi Liao,
> >>>
> >>> As you can see there is an active work to improve uprobes, that
> >>> changes lifetime management of uprobes, removes a bunch of locks take=
n
> >>> in the uprobe/uretprobe hot path, etc. It would be nice if you can
> >>> hold off a bit with your changes until all that lands. And then
> >>> re-benchmark, as costs might shift.
> >>>
> >>> But also see some remarks below.
> >>>
> >>>> Thanks.
> >>>>
> >>>> =E5=9C=A8 2024/7/27 17:44, Liao Chang =E5=86=99=E9=81=93:
> >>>>> The profiling result of single-thread model of selftests bench reve=
als
> >>>>> performance bottlenecks in find_uprobe() and caches_clean_inval_pou=
() on
> >>>>> ARM64. On my local testing machine, 5% of CPU time is consumed by
> >>>>> find_uprobe() for trig-uprobe-ret, while caches_clean_inval_pou() t=
ake
> >>>>> about 34% of CPU time for trig-uprobe-nop and trig-uprobe-push.
> >>>>>
> >>>>> This patch introduce struct uprobe_breakpoint to track previously
> >>>>> allocated insn_slot for frequently hit uprobe. it effectively reduc=
e the
> >>>>> need for redundant insn_slot writes and subsequent expensive cache
> >>>>> flush, especially on architecture like ARM64. This patch has been t=
ested
> >>>>> on Kunpeng916 (Hi1616), 4 NUMA nodes, 64 cores@ 2.4GHz. The selftes=
t
> >>>>> bench and Redis GET/SET benchmark result below reveal obivious
> >>>>> performance gain.
> >>>>>
> >>>>> before-opt
> >>>>> ----------
> >>>>> trig-uprobe-nop:  0.371 =C2=B1 0.001M/s (0.371M/prod)
> >>>>> trig-uprobe-push: 0.370 =C2=B1 0.001M/s (0.370M/prod)
> >>>>> trig-uprobe-ret:  1.637 =C2=B1 0.001M/s (1.647M/prod)
> >>>
> >>> I'm surprised that nop and push variants are much slower than ret
> >>> variant. This is exactly opposite on x86-64. Do you have an
> >>> explanation why this might be happening? I see you are trying to
> >>> optimize xol_get_insn_slot(), but that is (at least for x86) a slow
> >>> variant of uprobe that normally shouldn't be used. Typically uprobe i=
s
> >>> installed on nop (for USDT) and on function entry (which would be pus=
h
> >>> variant, `push %rbp` instruction).
> >>>
> >>> ret variant, for x86-64, causes one extra step to go back to user
> >>> space to execute original instruction out-of-line, and then trapping
> >>> back to kernel for running uprobe. Which is what you normally want to
> >>> avoid.
> >>>
> >>> What I'm getting at here. It seems like maybe arm arch is missing fas=
t
> >>> emulated implementations for nops/push or whatever equivalents for
> >>> ARM64 that is. Please take a look at that and see why those are slow
> >>> and whether you can make those into fast uprobe cases?
> >>
> >> Hi Andrii,
> >>
> >> As you correctly pointed out, the benchmark result on Arm64 is counter=
intuitive
> >> compared to X86 behavior. My investigation revealed that the root caus=
e lies in
> >> the arch_uprobe_analyse_insn(), which excludes the Arm64 equvialents i=
nstructions
> >> of 'nop' and 'push' from the emulatable instruction list. This forces =
the kernel
> >> to handle these instructions out-of-line in userspace upon breakpoint =
exception
> >> is handled, leading to a significant performance overhead compared to =
'ret' variant,
> >> which is already emulated.
> >>
> >> To address this issue, I've developed a patch supports  the emulation =
of 'nop' and
> >> 'push' variants. The benchmark results below indicates the performance=
 gain of
> >> emulation is obivious.
> >>
> >> xol (1 cpus)
> >> ------------
> >> uprobe-nop:  0.916 =C2=B1 0.001M/s (0.916M/prod)
> >> uprobe-push: 0.908 =C2=B1 0.001M/s (0.908M/prod)
> >> uprobe-ret:  1.855 =C2=B1 0.000M/s (1.855M/prod)
> >> uretprobe-nop:  0.640 =C2=B1 0.000M/s (0.640M/prod)
> >> uretprobe-push: 0.633 =C2=B1 0.001M/s (0.633M/prod)
> >> uretprobe-ret:  0.978 =C2=B1 0.003M/s (0.978M/prod)
> >>
> >> emulation (1 cpus)
> >> -------------------
> >> uprobe-nop:  1.862 =C2=B1 0.002M/s  (1.862M/s/cpu)
> >> uprobe-push: 1.743 =C2=B1 0.006M/s  (1.743M/s/cpu)
> >> uprobe-ret:  1.840 =C2=B1 0.001M/s  (1.840M/s/cpu)
> >> uretprobe-nop:  0.964 =C2=B1 0.004M/s  (0.964M/s/cpu)
> >> uretprobe-push: 0.936 =C2=B1 0.004M/s  (0.936M/s/cpu)
> >> uretprobe-ret:  0.940 =C2=B1 0.001M/s  (0.940M/s/cpu)
> >>
> >> As you can see, the performance gap between nop/push and ret variants =
has been significantly
> >> reduced. Due to the emulation of 'push' instruction need to access use=
rspace memory, it spent
> >> more cycles than the other.
> >
> > Great, it's an obvious improvement. Are you going to send patches
> > upstream? Please cc bpf@vger.kernel.org as well.
>
> I'll need more time to thoroughly test this patch. The emulation o push/n=
op
> instructions also impacts the kprobe/kretprobe paths on Arm64, As as resu=
lt,
> I'm working on enhancements to trig-kprobe/kretprobe to prevent performan=
ce
> regression.

Why would the *benchmarks* have to be modified? The typical
kprobe/kretprobe attachment should be fast, and those benchmarks
simulate typical fast path kprobe/kretprobe. Is there some simulation
logic that is shared between uprobes and kprobes or something?

>
> >
> >
> > I'm also thinking we should update uprobe/uretprobe benchmarks to be
> > less x86-specific. Right now "-nop" is the happy fastest case, "-push"
> > is still happy, slightly slower case (due to the need to emulate stack
> > operation) and "-ret" is meant to be the slow single-step case. We
> > should adjust the naming and make sure that on ARM64 we hit similar
> > code paths. Given you seem to know arm64 pretty well, can you please
> > take a look at updating bench tool for ARM64 (we can also rename
> > benchmarks to something a bit more generic, rather than using
> > instruction names)?
>

[...]

