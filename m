Return-Path: <bpf+bounces-58340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45D3AB8E08
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 19:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F59A01C0A
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 17:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6911258CDC;
	Thu, 15 May 2025 17:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isH7+Bjf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E619C8F6E
	for <bpf@vger.kernel.org>; Thu, 15 May 2025 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747331006; cv=none; b=W4lxu+tI5oVwiG9+g2LwQY4AlmnEUowTXp7tiRIzObxCipluSz6fbI/YumEjnEv3rvrFEhdwAn4wFPcsFxUtfP4aJ3f+FB/+roeeUcBPGWBip+p7AdECwrZN1HWPd5ltsKuzHw3dbzhC+NnlMUhjFOpe6jm2Z934o3JAOB9qJU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747331006; c=relaxed/simple;
	bh=BntxHoPfvh6BxtC9IAXP99+f9Sj9lZwsMRApSgg6G1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nT+ppDCv5YS8in5gsVUD4a8N1cUgEKrcV6wrR3U2ceo+QnXgBdsp/N2Ayj/mtL7sGLesgMvw/mvkTKoPVPUYoWNUjJWbf1YJQdbpm2dqIe//Y8SgiW2ocM1A6+R2110rQLP8ESgoxWJqt8zseNTwrIbFY4Qj5evm73/6/pQDNrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isH7+Bjf; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-af523f4511fso919930a12.0
        for <bpf@vger.kernel.org>; Thu, 15 May 2025 10:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747331004; x=1747935804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gU8W5xlOqkV6+QVwjyPh6IEK6MsYOphg4oSdIpMHnUs=;
        b=isH7+BjfqSJmTSDz4YrXMh6JbWG1LnfYrGK/Y2YxdY0n6DgkPN0YFwk5BMywM3ezUE
         2DqXC54sYxhEurm+G48KnI5ZOXyaMJiIseHA22wd00WGA2yHt6egAcuULaaVXqSGBsjF
         fArLlt33kajfa/jBqq8u+KieVOB4a2E15tC8/7gO8rW72shfz6WKTWoYAZ+MJMmoBtFx
         aZ/dc6J/ittTp3Cqnq7zeH4fCV6LZcB5/Do13s3upHA/fY2ujf4ME8+nIke2nx9Suxvc
         QdofeuS62dPuyptBluoVOuzTfdX33+HS3YaQAGqYR9EvVNjl6zVc9Jl8w+tE8j3gFJvT
         Et6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747331004; x=1747935804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gU8W5xlOqkV6+QVwjyPh6IEK6MsYOphg4oSdIpMHnUs=;
        b=hsiOTVo7Dwb5+0b7+8HqbzpyjfNVu7HeNewa+SQRSRRyF24t+4GqOrBmUcN4Sz7NZf
         oXKUfLeuO7LiRAN4dl2wmrZ7FT68A3BpW3vonHaan5GxKiK76jFKDvcNzZ8BD5lF1mxC
         rXoEtFJ6HY3bcGYCeXArP768Bpk/WSpCaIBPnO21QwZ5duUJfxWf6AovfcaSXJdU+hKO
         VC9QkVdgkGK0N1RxH0Heh/pTNuVL5icn9d+6mawM4tfRwEkNI/X7PO40py32Aw7NX+AX
         wUO4Y3y0OZ5SlijKmPIGwp6xp5gTzvB353Q0xOwaFwuQtC/G/ySua+665QgtlRC0N53s
         8mEg==
X-Forwarded-Encrypted: i=1; AJvYcCWrk8FttnllYMqSpcf2Dp+irM8Pg+hcSsQ+0rlqEE6jXZtBkZ0Io5AjFVJkpTIUy5cMvFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIMSGJhJsr7YTAhnwjUn3dmIBBOO8VNmDssgVs7w/QDEOUfyye
	GkhGqip64Y761fKeJ9R61x320HU0jyWnaNUJSt48pt1bpl9jB9koIy9wlcq37uVfS9YYpnOmjfz
	bFkF/gw61PrnBSX/cHAa2ZA96UE0IqjM=
X-Gm-Gg: ASbGncv5C+1/86cPy4jPXXqu+U9HzK1r7/BEiS3N0ca0C2IMdzwTfegxK+e9uZf2qiu
	kiBS5NZAHx5+KNookXiAYfj1kvk8H/dQDsGDgOL9DkJHcUidJ/X9MGxjAKQRXsmM9lGQKLSIUlo
	QyESwntb/r93/AIhBMXPn73gUR3LNKXzAHy7+8GIc/QMdhEUBW/H51Shn3W7U=
X-Google-Smtp-Source: AGHT+IGGzgS6MMDzBd6bUMKtBScI1a5qh3O0bXTzS7NTlz6pRQ2LPLPaQvpcYRkb0uqSIpk3A3y5YQgEoR/96g5YLpw=
X-Received: by 2002:a05:6a21:9988:b0:1f5:7eee:bb10 with SMTP id
 adf61e73a8af0-216218856fdmr563413637.8.1747331004080; Thu, 15 May 2025
 10:43:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420105524.2115690-1-rjsu26@gmail.com> <20250420105524.2115690-4-rjsu26@gmail.com>
 <m27c2l1ihl.fsf@gmail.com> <CAADnVQJZpyqY9TWanRKjmViOZxppAeh7FGAnxV_1CKAih7drkA@mail.gmail.com>
 <CAE5sdEh3NuXUcjScj4Auvtc2701NAS6fu0hpzLGVnaoQ7ESnfg@mail.gmail.com> <CAADnVQKX2=jYfs5TBBKdKxHPi_ssUvrSuxbr22-dmYoP_e3=dA@mail.gmail.com>
In-Reply-To: <CAADnVQKX2=jYfs5TBBKdKxHPi_ssUvrSuxbr22-dmYoP_e3=dA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 May 2025 10:43:11 -0700
X-Gm-Features: AX0GCFv0w619uvjt9c6rg5q7b6-Z95edkb6Wf4ZzUVDoBLWVIopilcc2INUzjNA
Message-ID: <CAEf4BzYpsNmHeQaHEMJ+1qUe=VusJSVgCbCrhSMe3u5mG33TKw@mail.gmail.com>
Subject: Re: [RFC bpf-next 3/4] bpf: Generating a stubbed version of BPF
 program for termination
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Raj Sahu <rjsu26@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Dan Williams <djwillia@vt.edu>, miloc@vt.edu, ericts@vt.edu, 
	rahult@vt.edu, doniaghazy@vt.edu, quanzhif@vt.edu, 
	Jinghao Jia <jinghao7@illinois.edu>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 6:59=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, May 12, 2025 at 10:16=E2=80=AFPM Siddharth Chintamaneni
> <sidchintamaneni@gmail.com> wrote:
> >
> > On Mon, 12 May 2025 at 17:20, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, May 12, 2025 at 5:07=E2=80=AFPM Eduard Zingerman <eddyz87@gma=
il.com> wrote:
> > > >
> > > >
> > > > - From verification point of view:
> > > >   this function is RET_VOID and is not in
> > > >   find_in_skiplist(), patch_generator() would replace its call with=
 a
> > > >   dummy. However, a corresponding bpf_spin_unlock() would remain an=
d thus
> > > >   bpf_check() will exit with error.
> > > >   So, you would need some special version of bpf_check, that collec=
ts
> > > >   all resources needed for program translation (e.g. maps), but doe=
s
> > > >   not perform semantic checks.
> > > >   Or patch_generator() has to be called for a program that is alrea=
dy
> > > >   verified.
> > >
> > > No. let's not parametrize bpf_check.
> > >
> > > Here is what I proposed earlier in the thread:
> > >
> > > the verifier should just remember all places where kfuncs
> > > and helpers return _OR_NULL,
> > > then when the verification is complete, copy the prog,
> > > replaces 'call kfunc/help' with 'call stub',
> > > run two JITs, and compare JIT artifacts
> > > to make sure IPs match.
> > >
> >
> > This is something that we've experimented with last week
> > https://github.com/sidchintamaneni/bpf/commits/bpf_term/v2_exploration/=
.
> > We did the cloning part after `do_misc_fixups` and before
> > `fixup_call_args` inside
> > bpf_check().
>
> Something like that but it needs to handle both helpers and kfuncs,
> and you don't need new fake helpers.
> text_poke_bp_batch() doesn't care what insn is being patched.
>
> > > But thinking about it more...
> > > I'm not sure any more that it's a good idea to fast execute
> > > the program on one cpu and let it continue running as-is on
> > > all other cpus including future invocations on this cpu.
> > > So far the reasons to terminate bpf program:
> > > - timeout in rqspinlock
> > > - fault in arena
> > > - some future watchdog
> > >
> >
> > Also long running interators, for example -
> > https://github.com/sidchintamaneni/os-dev-env/blob/main/bpf-programs-ca=
talog/research/termination/patch_gen_testing/bpf_loop_lr.kern.c
> > Eventhough this is just an example, this could be possible when
> > iterating through a map which grows unconditionally.
>
> In terms of detection this is a subset of watchdog.
> In terms of termination we still need to figure out the best
> path forward.
> bpf_loop() may or may not be inlined.
> If it's still a helper call then we can have per-prog "stop_me" flag,
> but it will penalize run-time, and won't really work for
> inlined (unless we force inlining logic to consult that flag
> as well).
> One option is to patch the callback subprog to return 1,
> but the callback might not have a branch that returns 1.
> Another option is to remember the insn that does:
>         /* loop header,
>          * if reg_loop_cnt >=3D reg_loop_max skip the loop body
>          */
>         insn_buf[cnt++] =3D BPF_JMP_REG(BPF_JGE, reg_loop_cnt, reg_loop_m=
ax, 5);
>
> in inlined bpf_loop() and patch that insn with 'goto +5',
> so inlined bpf_loop will terminate quickly.
>
> > > In all cases the program is buggy, so it's safer
> > > from kernel pov and from data integrity pov to stop
> > > all instances now and prevent future invocations.
> > > So I think we should patch the prog text in run-time
> > > without cloning.
> > >
> >
> > Yes, this is something that we had in mind:
> > 1. Terminate the program on a single CPU
> > 2. Terminate the program on all CPUs and de-link it
> >
> > Single CPU termination could be useful when a BPF program is using a
> > per-CPU map and the map on a single CPU grows, causing the iterator to
> > take a lot of time.
>
> I think de-link (and detach) is difficult.
> The context where an abnormal condition is detected (like watchdog)
> may not allow detaching.
> So I think replacing nop5 in the prologue with 'goto out'
> is better.
>

We do have a "defunct link" state for some BPF link types, like XDP
and a bunch of others, for example. If the interface to which XDP
program was attached gets removed, you'll still have a BPF link
remaining, but it won't really be attached anymore. We also have
BPF_LINK_DETACH command (meant to be used by admins to force-detach
links), which is basically the same concept. Original application will
still have link FD, and that link object will exist in the kernel, but
it will be "defunc" with no underlying BPF program and no attachment
to its original BPF hook.

That's just to say that we can extend that to other BPF link types, if
necessary.

> >
> > > The verifier should prepare an array of patches in
> > > text_poke_bp_batch() format and when timeout/fault detected
> > > do one call to text_poke_bp_batch() to stub out the whole prog.
> > >
> > Do you mean creating different versions of patches and applying one of
> > them based on the current execution state?
>
> I mean the verifier should prepare the whole batch with all insns
> that needs to be patched and apply the whole thing at once
> with one call to text_poke_bp_batch() that will affect all cpus.
> It doesn't matter where the program was running on this cpu.
> It might be running somewhere else on a different cpu.
> text_poke_bp_batch() won't be atomic, but it doesn't have to be.
> Every cpu might have a different fast-execute path to exit.

