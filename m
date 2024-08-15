Return-Path: <bpf+bounces-37282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E599538A7
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 18:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852AD1C241AD
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 16:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FAE1BB6AB;
	Thu, 15 Aug 2024 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cwlnjmgg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE7B2A8D0;
	Thu, 15 Aug 2024 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723741127; cv=none; b=FTmXnOF7IQYX4Q6i0uqbWTJFx9E36dTQ6XuWk67uOkPJkQhsHr9KtA96m3PRlduqGB+mgBq+P08NKYuXCjkg6APthxL6ZxH0untXK9kB6OChQ/SRHwtecSiYEglZWgm0CUMuPmZRFnbyoGHrttSEN4IA/H9pf4sFFYax2Jcqy+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723741127; c=relaxed/simple;
	bh=Ib8DIMPpofXCSfRQ6zD5trgnX+a9yantuomCVvt7mAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+hpvU/5SsPBd1wQ0Vl8PkOE0Cist1Onp+iWxhyrOJu+Zm3Q0Q4YIrbXTjFDqDghG9G6NzG6HTKIbgsnVV1yygydgnq7UbWC7EG6Jca6fCLD4Z4bC6/fEnvC5dkzDyJSqt/juLnc8oiX8aiFPX+JgUy4Hh05tPSsbFx6GYEk/3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cwlnjmgg; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d3bae081efso820693a91.1;
        Thu, 15 Aug 2024 09:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723741125; x=1724345925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXbFzt6LXAdcOsF6ra0hCRYtxIZlnZouzdNl+xRjFA8=;
        b=Cwlnjmgg01bo3dq8bBqg3iB390vhCWLQabw2fNlMpX8s8b0srxKz12k1Lm5LbhRKIF
         UCzsQXrV059gPxrieLrmN/2m7U2W7BecxIUtg1dojZATwdkHFx+53BT7neyD3eUXvBg1
         DAAo5fSaPmyLYbNMCty9ozerTFyZK+UfxRhFBluRj09D+5rvecDbST5lC7oeynaMwmbl
         Vv6nL7zWP82o7gRkqmQXvXv3n7mcGLi/ZbcZm7XcE1IJwjqblCmKvfp6AqHiAIajvFvK
         rfW7Q4Myn009boDlfTQ6G/k1vbiObcMnjZXzfUwpv8JW+gDRWae+Qy3Zqg4f0PrrFiL0
         rn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723741125; x=1724345925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXbFzt6LXAdcOsF6ra0hCRYtxIZlnZouzdNl+xRjFA8=;
        b=Eyf+3/yN8C3m0nSN1Wr8mFkuMWHGljMx7MLSQpg3v0vWuOD6xY5etAwkmvGpB0BPto
         TFae3rXMxWhyYECeTPgNjVWtRDDp+77L8Y58TJWQYZfj9xawivC7olPg5mDh8YCH2RZW
         L3s6FPY0F/87oXuBooJJoX8Un6MoflagXBHYKIG6poszszjSCE50ZJBkr9QghojNKxtS
         TDaF7x0417FG2XFq9oaLSU9ddNq21mnSt/394UJdUeDXGiR9RqhnXrFhEi9uWuBvjW2p
         0HxdUw4GpX70IW0aaE42CUYe1ej7PcsJj3CL/NOXSJSjZjjYKWH+3b2srYy1sD2vbI5x
         EuBA==
X-Forwarded-Encrypted: i=1; AJvYcCU6KVK3jbh6elcExIoTHRQ0ymrZNJ6D0xz0PmfR27n9olOjFkdmoD81akBiPz7jb7yflKxB2y5aZs1V1O131Bq/q57AJDlY9sq0GzGKoIkCe552/cx8DDcBLYbPV/c1k0FqF2rGjxcmGowvhvb6Atmie2w1tq7dEkSFFkWA23mNxBvHMGcAMQS8RQKcB4BdGB63DdKnvjMcSWL5aN+EDM70jKWZHYzJ7g==
X-Gm-Message-State: AOJu0YxmcytHA0LQ8bu883thiWRRtjg5UTchkiSt7gBajcOXai/i0nYw
	wBrJOzuZ1av16y3tyJbE73UT5Hm+ftxjlp+GshL+ohIHrDiNcr/pCtid/KxaxP9SMLA5Hs6S8LD
	pK4gEqRI0P8bK5hy81R+uj3LTXX0=
X-Google-Smtp-Source: AGHT+IFZ+HoeWikcblB6mAdquTOuOrBRV3QmtJF5138mHWSco5PCU0G4IxZxFkTBn7TRrKbLwbrJHuNsLlH8T7wuOtU=
X-Received: by 2002:a17:90b:4f85:b0:2ca:8a93:a40b with SMTP id
 98e67ed59e1d1-2d3e00f06e3mr277987a91.31.1723741124751; Thu, 15 Aug 2024
 09:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727094405.1362496-1-liaochang1@huawei.com>
 <7eefae59-8cd1-14a5-ef62-fc0e62b26831@huawei.com> <CAEf4BzaO4eG6hr2hzXYpn+7Uer4chS0R99zLn02ezZ5YruVuQw@mail.gmail.com>
 <85991ce3-674d-b46e-b4f9-88a50f7f5122@huawei.com> <CAEf4BzYvpgfFGckcKdzkC_g1J1SFi7xBe=_cjdVy4KEMikvGMw@mail.gmail.com>
 <2c23e9cc-5593-84d0-9157-1e946df941d9@huawei.com> <CAEf4BzYSC+OQ0D+B0oEi3uN0kyZ07kPaneLJLJqF=oA6gTXLbg@mail.gmail.com>
 <e17cf2d1-e3e0-f549-b04a-664ca2708817@huawei.com>
In-Reply-To: <e17cf2d1-e3e0-f549-b04a-664ca2708817@huawei.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Aug 2024 09:58:32 -0700
Message-ID: <CAEf4BzYHqKdhRKGK1LoMAk12Awye612q2UUidoRh4d4fDYYZ-A@mail.gmail.com>
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

On Thu, Aug 15, 2024 at 12:59=E2=80=AFAM Liao, Chang <liaochang1@huawei.com=
> wrote:
>
>
>
> =E5=9C=A8 2024/8/15 0:57, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Tue, Aug 13, 2024 at 9:17=E2=80=AFPM Liao, Chang <liaochang1@huawei.=
com> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2024/8/13 1:49, Andrii Nakryiko =E5=86=99=E9=81=93:
> >>> On Mon, Aug 12, 2024 at 4:11=E2=80=AFAM Liao, Chang <liaochang1@huawe=
i.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> =E5=9C=A8 2024/8/9 2:26, Andrii Nakryiko =E5=86=99=E9=81=93:
> >>>>> On Thu, Aug 8, 2024 at 1:45=E2=80=AFAM Liao, Chang <liaochang1@huaw=
ei.com> wrote:
> >>>>>>
> >>>>>> Hi Andrii and Oleg.
> >>>>>>
> >>>>>> This patch sent by me two weeks ago also aim to optimize the perfo=
rmance of uprobe
> >>>>>> on arm64. I notice recent discussions on the performance and scala=
bility of uprobes
> >>>>>> within the mailing list. Considering this interest, I've added you=
 and other relevant
> >>>>>> maintainers to the CC list for broader visibility and potential co=
llaboration.
> >>>>>>
> >>>>>
> >>>>> Hi Liao,
> >>>>>
> >>>>> As you can see there is an active work to improve uprobes, that
> >>>>> changes lifetime management of uprobes, removes a bunch of locks ta=
ken
> >>>>> in the uprobe/uretprobe hot path, etc. It would be nice if you can
> >>>>> hold off a bit with your changes until all that lands. And then
> >>>>> re-benchmark, as costs might shift.
> >>>>>
> >>>>> But also see some remarks below.
> >>>>>
> >>>>>> Thanks.
> >>>>>>
> >>>>>> =E5=9C=A8 2024/7/27 17:44, Liao Chang =E5=86=99=E9=81=93:
> >>>>>>> The profiling result of single-thread model of selftests bench re=
veals
> >>>>>>> performance bottlenecks in find_uprobe() and caches_clean_inval_p=
ou() on
> >>>>>>> ARM64. On my local testing machine, 5% of CPU time is consumed by
> >>>>>>> find_uprobe() for trig-uprobe-ret, while caches_clean_inval_pou()=
 take
> >>>>>>> about 34% of CPU time for trig-uprobe-nop and trig-uprobe-push.
> >>>>>>>
> >>>>>>> This patch introduce struct uprobe_breakpoint to track previously
> >>>>>>> allocated insn_slot for frequently hit uprobe. it effectively red=
uce the
> >>>>>>> need for redundant insn_slot writes and subsequent expensive cach=
e
> >>>>>>> flush, especially on architecture like ARM64. This patch has been=
 tested
> >>>>>>> on Kunpeng916 (Hi1616), 4 NUMA nodes, 64 cores@ 2.4GHz. The selft=
est
> >>>>>>> bench and Redis GET/SET benchmark result below reveal obivious
> >>>>>>> performance gain.
> >>>>>>>
> >>>>>>> before-opt
> >>>>>>> ----------
> >>>>>>> trig-uprobe-nop:  0.371 =C2=B1 0.001M/s (0.371M/prod)
> >>>>>>> trig-uprobe-push: 0.370 =C2=B1 0.001M/s (0.370M/prod)
> >>>>>>> trig-uprobe-ret:  1.637 =C2=B1 0.001M/s (1.647M/prod)
> >>>>>
> >>>>> I'm surprised that nop and push variants are much slower than ret
> >>>>> variant. This is exactly opposite on x86-64. Do you have an
> >>>>> explanation why this might be happening? I see you are trying to
> >>>>> optimize xol_get_insn_slot(), but that is (at least for x86) a slow
> >>>>> variant of uprobe that normally shouldn't be used. Typically uprobe=
 is
> >>>>> installed on nop (for USDT) and on function entry (which would be p=
ush
> >>>>> variant, `push %rbp` instruction).
> >>>>>
> >>>>> ret variant, for x86-64, causes one extra step to go back to user
> >>>>> space to execute original instruction out-of-line, and then trappin=
g
> >>>>> back to kernel for running uprobe. Which is what you normally want =
to
> >>>>> avoid.
> >>>>>
> >>>>> What I'm getting at here. It seems like maybe arm arch is missing f=
ast
> >>>>> emulated implementations for nops/push or whatever equivalents for
> >>>>> ARM64 that is. Please take a look at that and see why those are slo=
w
> >>>>> and whether you can make those into fast uprobe cases?
> >>>>
> >>>> Hi Andrii,
> >>>>
> >>>> As you correctly pointed out, the benchmark result on Arm64 is count=
erintuitive
> >>>> compared to X86 behavior. My investigation revealed that the root ca=
use lies in
> >>>> the arch_uprobe_analyse_insn(), which excludes the Arm64 equvialents=
 instructions
> >>>> of 'nop' and 'push' from the emulatable instruction list. This force=
s the kernel
> >>>> to handle these instructions out-of-line in userspace upon breakpoin=
t exception
> >>>> is handled, leading to a significant performance overhead compared t=
o 'ret' variant,
> >>>> which is already emulated.
> >>>>
> >>>> To address this issue, I've developed a patch supports  the emulatio=
n of 'nop' and
> >>>> 'push' variants. The benchmark results below indicates the performan=
ce gain of
> >>>> emulation is obivious.
> >>>>
> >>>> xol (1 cpus)
> >>>> ------------
> >>>> uprobe-nop:  0.916 =C2=B1 0.001M/s (0.916M/prod)
> >>>> uprobe-push: 0.908 =C2=B1 0.001M/s (0.908M/prod)
> >>>> uprobe-ret:  1.855 =C2=B1 0.000M/s (1.855M/prod)
> >>>> uretprobe-nop:  0.640 =C2=B1 0.000M/s (0.640M/prod)
> >>>> uretprobe-push: 0.633 =C2=B1 0.001M/s (0.633M/prod)
> >>>> uretprobe-ret:  0.978 =C2=B1 0.003M/s (0.978M/prod)
> >>>>
> >>>> emulation (1 cpus)
> >>>> -------------------
> >>>> uprobe-nop:  1.862 =C2=B1 0.002M/s  (1.862M/s/cpu)
> >>>> uprobe-push: 1.743 =C2=B1 0.006M/s  (1.743M/s/cpu)
> >>>> uprobe-ret:  1.840 =C2=B1 0.001M/s  (1.840M/s/cpu)
> >>>> uretprobe-nop:  0.964 =C2=B1 0.004M/s  (0.964M/s/cpu)
> >>>> uretprobe-push: 0.936 =C2=B1 0.004M/s  (0.936M/s/cpu)
> >>>> uretprobe-ret:  0.940 =C2=B1 0.001M/s  (0.940M/s/cpu)
> >>>>
> >>>> As you can see, the performance gap between nop/push and ret variant=
s has been significantly
> >>>> reduced. Due to the emulation of 'push' instruction need to access u=
serspace memory, it spent
> >>>> more cycles than the other.
> >>>
> >>> Great, it's an obvious improvement. Are you going to send patches
> >>> upstream? Please cc bpf@vger.kernel.org as well.
> >>
> >> I'll need more time to thoroughly test this patch. The emulation o pus=
h/nop
> >> instructions also impacts the kprobe/kretprobe paths on Arm64, As as r=
esult,
> >> I'm working on enhancements to trig-kprobe/kretprobe to prevent perfor=
mance
> >> regression.
> >>
> >>>
> >>>
> >>> I'm also thinking we should update uprobe/uretprobe benchmarks to be
> >>> less x86-specific. Right now "-nop" is the happy fastest case, "-push=
"
> >>> is still happy, slightly slower case (due to the need to emulate stac=
k
> >>> operation) and "-ret" is meant to be the slow single-step case. We
> >>> should adjust the naming and make sure that on ARM64 we hit similar
> >>> code paths. Given you seem to know arm64 pretty well, can you please
> >>> take a look at updating bench tool for ARM64 (we can also rename
> >>> benchmarks to something a bit more generic, rather than using
> >>> instruction names)?
> >>
> >> Let me use a matrix below for the structured comparsion of uprobe/uret=
probe
> >> benchmarks on X86 and Arm64:
> >>
> >> Architecture  Instrution Type   Handling method   Performance
> >> X86           nop               Emulated          Fastest
> >> X86           push              Emulated          Fast
> >> X86           ret               Single-step       Slow
> >> Arm64         nop               Emulated          Fastest
> >> Arm64         push              Emulated          Fast
> >> Arm64         ret               Emulated          Faster
> >>
> >> I suggest categorize benchmarks into 'emu' for emulated instructions a=
nd 'ss'
> >> for 'single-steppable' instructions. Generally, emulated instructions =
should
> >> outperform single-step ones across different architectures. Regarding =
the
> >> generic naming, I propose using a self-explanatory style, such as
> >> s/nop/empty-insn/g, s/push/push-stack/g, s/ret/func-return/g.
> >>
> >> Above all, example "bench --list" output:
> >>
> >> X86:
> >>   ...
> >>   trig-uprobe-emu-empty-insn
> >>   trig-uprobe-ss-func-return
> >>   trig-uprobe-emu-push-stack
> >>   trig-uretprobe-emu-empyt-insn
> >>   trig-uretprobe-ss-func-return
> >>   trig-uretprobe-emu-push-stack
> >>   ...
> >>
> >> Arm64:
> >>   ...
> >>   trig-uprobe-emu-empty-insn
> >>   trig-uprobe-emu-func-return
> >>   trig-uprobe-emu-push-stack
> >>   trig-uretprobe-emu-empyt-insn
> >>   trig-uretprobe-emu-func-return
> >>   trig-uretprobe-emu-push-stack
> >>   ...
> >>
> >> This structure will allow for direct comparison of uprobe/uretprobe
> >> performance across different architectures and instruction types.
> >> Please let me know your thought, Andrii.
> >
> > Tbh, sounds a bit like an overkill. But before we decide on naming,
> > what kind of situation is single-stepped on arm64?
>
> On Arm64, the following instruction types are generally not single-steppa=
ble.
>
>   - Modifying and reading PC, including 'ret' and various branch instruct=
ions.
>
>   - Forming a PC-relative address using the PC and an immediate value.
>
>   - Generating exception, includes BRK, HLT, HVC, SMC, SVC.
>
>   - Loading memory at address calculated based on the PC and an immediate=
 offset.
>
>   - Moving general-purpose register to system registers of PE (similar to=
 logical cores on x86).
>
>   - Hint instruction cause exception or unintend behavior for single-step=
ping.
>     However, 'nop' is steppable hint.
>
> Most parts of instructions that doesn't fall into any of these types are =
single-stepped,
> including the Arm64 equvialents of 'push'.

Ok, so you special-cased the "push %rbp" equivalent, by any other
push-like instruction will be single-stepped, right?

So how about we make sure that we have three classes of
uprobe/uretprobe benchmarks:

  - fastest nop case, and we call it uprobe/uretprobe-usdt or keep it
as uprobe/uretprobe-nop. USDT is sort of a target case for this, so
I'm fine changing the name;
  - slightly less fast but common "push %rbp"-like case, which we can
call uprobe-entry (as in function entry case);
  - and slowest single-stepped, here the naming is a bit less clear,
so uprobe-slow or uprobe-ss (single-step, but if someone wants to read
"super slow" I'm fine with it as well ;). Or uprobe-sstep, I don't
know.

WDYT?

>
> Thanks.
>
> >
> >>
> >> Thanks.
> >>
> >>>
> >>>>
> >>>>>
> >>>>>>> trig-uretprobe-nop:  0.331 =C2=B1 0.004M/s (0.331M/prod)
> >>>>>>> trig-uretprobe-push: 0.333 =C2=B1 0.000M/s (0.333M/prod)
> >>>>>>> trig-uretprobe-ret:  0.854 =C2=B1 0.002M/s (0.854M/prod)
> >>>>>>> Redis SET (RPS) uprobe: 42728.52
> >>>>>>> Redis GET (RPS) uprobe: 43640.18
> >>>>>>> Redis SET (RPS) uretprobe: 40624.54
> >>>>>>> Redis GET (RPS) uretprobe: 41180.56
> >>>>>>>
> >>>>>>> after-opt
> >>>>>>> ---------
> >>>>>>> trig-uprobe-nop:  0.916 =C2=B1 0.001M/s (0.916M/prod)
> >>>>>>> trig-uprobe-push: 0.908 =C2=B1 0.001M/s (0.908M/prod)
> >>>>>>> trig-uprobe-ret:  1.855 =C2=B1 0.000M/s (1.855M/prod)
> >>>>>>> trig-uretprobe-nop:  0.640 =C2=B1 0.000M/s (0.640M/prod)
> >>>>>>> trig-uretprobe-push: 0.633 =C2=B1 0.001M/s (0.633M/prod)
> >>>>>>> trig-uretprobe-ret:  0.978 =C2=B1 0.003M/s (0.978M/prod)
> >>>>>>> Redis SET (RPS) uprobe: 43939.69
> >>>>>>> Redis GET (RPS) uprobe: 45200.80
> >>>>>>> Redis SET (RPS) uretprobe: 41658.58
> >>>>>>> Redis GET (RPS) uretprobe: 42805.80
> >>>>>>>
> >>>>>>> While some uprobes might still need to share the same insn_slot, =
this
> >>>>>>> patch compare the instructions in the resued insn_slot with the
> >>>>>>> instructions execute out-of-line firstly to decides allocate a ne=
w one
> >>>>>>> or not.
> >>>>>>>
> >>>>>>> Additionally, this patch use a rbtree associated with each thread=
 that
> >>>>>>> hit uprobes to manage these allocated uprobe_breakpoint data. Due=
 to the
> >>>>>>> rbtree of uprobe_breakpoints has smaller node, better locality an=
d less
> >>>>>>> contention, it result in faster lookup times compared to find_upr=
obe().
> >>>>>>>
> >>>>>>> The other part of this patch are some necessary memory management=
 for
> >>>>>>> uprobe_breakpoint data. A uprobe_breakpoint is allocated for each=
 newly
> >>>>>>> hit uprobe that doesn't already have a corresponding node in rbtr=
ee. All
> >>>>>>> uprobe_breakpoints will be freed when thread exit.
> >>>>>>>
> >>>>>>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> >>>>>>> ---
> >>>>>>>  include/linux/uprobes.h |   3 +
> >>>>>>>  kernel/events/uprobes.c | 246 +++++++++++++++++++++++++++++++++-=
------
> >>>>>>>  2 files changed, 211 insertions(+), 38 deletions(-)
> >>>>>>>
> >>>>>
> >>>>> [...]
> >>>>
> >>>> --
> >>>> BR
> >>>> Liao, Chang
> >>
> >> --
> >> BR
> >> Liao, Chang
>
> --
> BR
> Liao, Chang

