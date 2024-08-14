Return-Path: <bpf+bounces-37194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931A8952091
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 18:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC783B22B31
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 16:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF59F1BB6AA;
	Wed, 14 Aug 2024 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0PTXs79"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A568A1B1409;
	Wed, 14 Aug 2024 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654688; cv=none; b=Cvdmv6Xp6sAeSOz5cumXbPD3/etjUugaYUENwNdPvHtNPkG6bl5dPcZCJDaMNL9LbEMvlA1Ng7uGBIBYcTqfTACchjSccivpNbeTeVuqmBZqNT81i+w/E307wQM3574LzQ5sfgB048dEqb8aw4JAyYy3g79CilqzgA0IPvGubCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654688; c=relaxed/simple;
	bh=WXa14y0Xj1TzLTBBOAGxA4twKZO1AOmGgfnbupvjqII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eubxVAjAqG8HeY7x2lKsy+Yu4DLKhp9wsPRU3SGT6I9AjHqad1QYRiIB/0dKLcXzRdwxwLTh8tFpn6HWEd/p28Sf8avtkNKBXCkSwgv5aYML+iNO6pzhRAWgDoKcIG8dmhckFthi54tXyq0+Px1vWrHimIroo3vpqYgv0O27Zrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0PTXs79; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2cd48ad7f0dso5325413a91.0;
        Wed, 14 Aug 2024 09:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723654686; x=1724259486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zK9oCAyyxU+1Adi0zAVmpcvNXExU4bq1goqAnIGislg=;
        b=A0PTXs79sx0iFJpijMLJPQLPMw0RG2R4gWYieG1OorgpxSn+qcz74dwpW7RCx25IDK
         lVs85NvOLe7G/gt4m/eAGw8Hr7dt6F75z7JgVfMeAoS5GTks/4Xwg0WXDTP4sYSLg/Vc
         jJe98WhYHXcZb2F2jpUWGZfURcOPqpyMOYORGZ1H1Tp5RFETfcf1kmr8IwQBF3yFaRMy
         L75MyA3FqicPDl0Crxy/vGzk+EnhrTpFJ6767nJT5aGNWn1cGcXB8xdTfHSIsSWLdRl1
         A1RjnV1tP6qFzgszmvy/fpjd+cziicjrX7lDkGzcaT58xfWwv9/mpJkkdv9XRm/oDN4x
         N87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723654686; x=1724259486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zK9oCAyyxU+1Adi0zAVmpcvNXExU4bq1goqAnIGislg=;
        b=qkkSnSDF9ZRyMMFIlJk8AIelN/2ezYbeS30g74cPWtAdsyWGp4GHEYTRGywC5r7JZZ
         AJ+uiQ7D4K3F0sxDwhNYeewT61nQEiGgAjaBkeg8hXl1dr2bW1iDlrzczzKg0beOkqa3
         3pMPsnIsp1q6fAOnkRBGT/bZDEHERA2Tywgq47Rm4+Gskarmg4EfMUDPRlX3Ni4YIuy5
         w5L0mPvsEQLLXDjDK8oQzRIOn6e8bE0vcD5axD0IfCmDTTc/EDY0H2r9o0uwsJqVqVvv
         clFb3Y1sJXkDVcY/zzPyH9Bri47hMmIN4G9AYnB/zeqijZEZZmKw1EuAPquWik7Ftomt
         AHAg==
X-Forwarded-Encrypted: i=1; AJvYcCXrIVq+866fiK0Br1eUQ7ydrA8stLyjW3i+6Upk2F4JvfVawrKFTPJetpj26svshBfFqUxHZJrDD7Eq57j1NgS8J9sydpcZloAb5KJot3soSMa3oun585ctwY9XhHTsaRT8k+W1dWteuqldpW++tFb59TfiFfsHozOERdNEKXH8FBxrV8pb9m6gD3TWv+qwSxBMaf0JKGTF/yDs7vakiDIMBntPbUGeyw==
X-Gm-Message-State: AOJu0YyXLUNMHmjn7fxI1GS6szNSHv63zabqYYgFOocfZVX7ToTaODas
	OWhlkiQdxi7ipp6n/nP2FNccU/Bc6QSr6mNFbpqNBSkcOCRJqIpLzBPQXfrQctl0McQZCU9QiRi
	NSB20ANt+NuQ/qzsQLrD+70JDVf4=
X-Google-Smtp-Source: AGHT+IExO2GnNGmHC4eq5apMFZrsKjtDAiupLd1O/j4j2xYVrMEyYx2eQOqskxBhEAnFewHJAtNgnlFjCwDBfj3ylR4=
X-Received: by 2002:a17:90a:1bcf:b0:2cb:50ff:732e with SMTP id
 98e67ed59e1d1-2d3aab8c9b6mr3620203a91.42.1723654685739; Wed, 14 Aug 2024
 09:58:05 -0700 (PDT)
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
Date: Wed, 14 Aug 2024 09:57:53 -0700
Message-ID: <CAEf4BzYSC+OQ0D+B0oEi3uN0kyZ07kPaneLJLJqF=oA6gTXLbg@mail.gmail.com>
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
> Let me use a matrix below for the structured comparsion of uprobe/uretpro=
be
> benchmarks on X86 and Arm64:
>
> Architecture  Instrution Type   Handling method   Performance
> X86           nop               Emulated          Fastest
> X86           push              Emulated          Fast
> X86           ret               Single-step       Slow
> Arm64         nop               Emulated          Fastest
> Arm64         push              Emulated          Fast
> Arm64         ret               Emulated          Faster
>
> I suggest categorize benchmarks into 'emu' for emulated instructions and =
'ss'
> for 'single-steppable' instructions. Generally, emulated instructions sho=
uld
> outperform single-step ones across different architectures. Regarding the
> generic naming, I propose using a self-explanatory style, such as
> s/nop/empty-insn/g, s/push/push-stack/g, s/ret/func-return/g.
>
> Above all, example "bench --list" output:
>
> X86:
>   ...
>   trig-uprobe-emu-empty-insn
>   trig-uprobe-ss-func-return
>   trig-uprobe-emu-push-stack
>   trig-uretprobe-emu-empyt-insn
>   trig-uretprobe-ss-func-return
>   trig-uretprobe-emu-push-stack
>   ...
>
> Arm64:
>   ...
>   trig-uprobe-emu-empty-insn
>   trig-uprobe-emu-func-return
>   trig-uprobe-emu-push-stack
>   trig-uretprobe-emu-empyt-insn
>   trig-uretprobe-emu-func-return
>   trig-uretprobe-emu-push-stack
>   ...
>
> This structure will allow for direct comparison of uprobe/uretprobe
> performance across different architectures and instruction types.
> Please let me know your thought, Andrii.

Tbh, sounds a bit like an overkill. But before we decide on naming,
what kind of situation is single-stepped on arm64?

>
> Thanks.
>
> >
> >>
> >>>
> >>>>> trig-uretprobe-nop:  0.331 =C2=B1 0.004M/s (0.331M/prod)
> >>>>> trig-uretprobe-push: 0.333 =C2=B1 0.000M/s (0.333M/prod)
> >>>>> trig-uretprobe-ret:  0.854 =C2=B1 0.002M/s (0.854M/prod)
> >>>>> Redis SET (RPS) uprobe: 42728.52
> >>>>> Redis GET (RPS) uprobe: 43640.18
> >>>>> Redis SET (RPS) uretprobe: 40624.54
> >>>>> Redis GET (RPS) uretprobe: 41180.56
> >>>>>
> >>>>> after-opt
> >>>>> ---------
> >>>>> trig-uprobe-nop:  0.916 =C2=B1 0.001M/s (0.916M/prod)
> >>>>> trig-uprobe-push: 0.908 =C2=B1 0.001M/s (0.908M/prod)
> >>>>> trig-uprobe-ret:  1.855 =C2=B1 0.000M/s (1.855M/prod)
> >>>>> trig-uretprobe-nop:  0.640 =C2=B1 0.000M/s (0.640M/prod)
> >>>>> trig-uretprobe-push: 0.633 =C2=B1 0.001M/s (0.633M/prod)
> >>>>> trig-uretprobe-ret:  0.978 =C2=B1 0.003M/s (0.978M/prod)
> >>>>> Redis SET (RPS) uprobe: 43939.69
> >>>>> Redis GET (RPS) uprobe: 45200.80
> >>>>> Redis SET (RPS) uretprobe: 41658.58
> >>>>> Redis GET (RPS) uretprobe: 42805.80
> >>>>>
> >>>>> While some uprobes might still need to share the same insn_slot, th=
is
> >>>>> patch compare the instructions in the resued insn_slot with the
> >>>>> instructions execute out-of-line firstly to decides allocate a new =
one
> >>>>> or not.
> >>>>>
> >>>>> Additionally, this patch use a rbtree associated with each thread t=
hat
> >>>>> hit uprobes to manage these allocated uprobe_breakpoint data. Due t=
o the
> >>>>> rbtree of uprobe_breakpoints has smaller node, better locality and =
less
> >>>>> contention, it result in faster lookup times compared to find_uprob=
e().
> >>>>>
> >>>>> The other part of this patch are some necessary memory management f=
or
> >>>>> uprobe_breakpoint data. A uprobe_breakpoint is allocated for each n=
ewly
> >>>>> hit uprobe that doesn't already have a corresponding node in rbtree=
. All
> >>>>> uprobe_breakpoints will be freed when thread exit.
> >>>>>
> >>>>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> >>>>> ---
> >>>>>  include/linux/uprobes.h |   3 +
> >>>>>  kernel/events/uprobes.c | 246 +++++++++++++++++++++++++++++++++---=
----
> >>>>>  2 files changed, 211 insertions(+), 38 deletions(-)
> >>>>>
> >>>
> >>> [...]
> >>
> >> --
> >> BR
> >> Liao, Chang
>
> --
> BR
> Liao, Chang

