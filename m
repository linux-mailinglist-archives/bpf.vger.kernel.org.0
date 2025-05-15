Return-Path: <bpf+bounces-58272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7E8AB7B52
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 03:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9A11B672B1
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 01:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FD5278160;
	Thu, 15 May 2025 01:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSir3s73"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DE7220F25
	for <bpf@vger.kernel.org>; Thu, 15 May 2025 01:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747274364; cv=none; b=IlX+yOmmXkfZ92vRy7KjT9t1w28/LS4TsezAqDm0mAt28z6MEgY1A55YKQFGNTXQvH8fETw+107G6M6w+9/cpf4jDbhSSJ4y0x1DI2yunh4CYma4vhRwWxSuVUlzY97zHCeTBdQVuHCy3Iu3BZEDd/Ii7nCImKcjhkwrEUv/RIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747274364; c=relaxed/simple;
	bh=XVSFhA3/U0QZ5tVD4bMo8zExHhkjm9/WCogH1VIWDvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDiO1norYjf8JyeZumxuwv5p0hZwAD97MxeeXgfOg1MXcd4b83Q4rcqDZnHlLRbl8WvbqEhmhgwDKR+VKoyUi4XTzG2RZRE2QnQWvEHUwpcFO8QhbRpOn5skxL0TXvfKCdgDf/vgpdBfMfTewZfXWH3wUJu6CIb8EA824S7Okvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSir3s73; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a0b135d18eso179526f8f.2
        for <bpf@vger.kernel.org>; Wed, 14 May 2025 18:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747274361; x=1747879161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCxDzcRbiw8MdbVm429evwPKn7OCtDNkcc28QrdCpCI=;
        b=FSir3s73IsMTeVdfrkHsNHBB/s0Zc4eDsB7CoorYi9UBVV6A6xkjB6RanPotdm6Fzh
         xafFYRaCRBJKuiMHIt/qz4xF6SNgwTeYj2CCvdp+Zg7Cud60jQb+pfAPwGDFVf49lZtN
         IlA0jcHZ58esOikY0i6/yyueRKLwYZ8ciftvUCQ5NseStVu7B1y5y3FsZG3HkIqorHZo
         wVZQRr8kvTN+LWLSq0y1B3tqOY7hGoEzH6albXuTjaxKgDiBkEDjvC0Oi0QvkFBo/lDB
         NfddC918bUpn1XKk4pdWMHKE+VYjHgGr99gjEH3paNl3TkU5l5G5L+YJROdYTLHHT6uo
         tZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747274361; x=1747879161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCxDzcRbiw8MdbVm429evwPKn7OCtDNkcc28QrdCpCI=;
        b=FpBZchOwXHCtxXH0/ONXQErmyKhpBVlfHHDImHSduS/kxzGO4RH73i6s7KRbU1G9K5
         Re52FsQbijytmI3B4Q+w4SJd56bhXF/7SfR+Ibolf/i6Uo3M0OJXaqcIZKcZvxRcro0j
         1PElo57nD5HGPxIptp9+k/f9J7Hg9T9fAzv04Dh1/697IeVaGHHmuptbJJnkPfrLW+Du
         RM83xzWIwbXjTYqUh7IpijrNc1RZ+Jq0mDwnPADjZsJdBhrXLVK8GkPwSfegxl0wyRKC
         fZvp2vHDNq/pNfDDi1qdZ/DT6SgOnk2DFfoTr+Tty0jaG9+Op/7ZrEE84dlNb5SDpb4I
         jy4A==
X-Forwarded-Encrypted: i=1; AJvYcCXyDRCJB8cbHzA2a+ARuF1TMKbkmUALM6SAL21qJmeCf5yVQF8PV2Rta18HL4QGAA+b+Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/0JlS3POs8BcbMXNL43vF1BAkz/o+rS1yrEJMXQsihUtAnZp0
	EK3SqLB311ui+PC+geAmmWupDMASKv1ceOT2lhYx4WOG2bROW5b7jhsBr0kXBeofmIVm/d5Opkd
	pK89imzSkJN+DKcs94ymBMgRLf4k=
X-Gm-Gg: ASbGncuJOg2JpD9OhbvrMe3NVuVnSG1yi+8SVTfGYBv26xlJFHKEsJKyiCJtC3WHIIC
	3rA0onmfWFBkkPmHVOs3xyp7UbW388ea7fpxIUuCoDnGeZCesRmuYuq16pF7NhX81aLsqrychuf
	w03BA9qjqOm19QjYifjfpeEcF2NDnnsk2b3uatWGnrD2yaqU0HlRD6nX2tBYtGGQ==
X-Google-Smtp-Source: AGHT+IH2ISuEMoBkZSuikzSJy01PPH5XBeOqLj3ja1UNlYqUYgvdc6FuGcnCgKSsa7sqoWBe80Wr2WPcV2yyuiFZvls=
X-Received: by 2002:a05:6000:2c5:b0:3a0:b3f1:6edf with SMTP id
 ffacd0b85a97d-3a35373a94dmr469884f8f.21.1747274360985; Wed, 14 May 2025
 18:59:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420105524.2115690-1-rjsu26@gmail.com> <20250420105524.2115690-4-rjsu26@gmail.com>
 <m27c2l1ihl.fsf@gmail.com> <CAADnVQJZpyqY9TWanRKjmViOZxppAeh7FGAnxV_1CKAih7drkA@mail.gmail.com>
 <CAE5sdEh3NuXUcjScj4Auvtc2701NAS6fu0hpzLGVnaoQ7ESnfg@mail.gmail.com>
In-Reply-To: <CAE5sdEh3NuXUcjScj4Auvtc2701NAS6fu0hpzLGVnaoQ7ESnfg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 14 May 2025 18:59:09 -0700
X-Gm-Features: AX0GCFvHE6fn__D1uhBJmyc-icXd08hXAOgmz2UdJnf8c1kvVB51LEgL6Zlmx6c
Message-ID: <CAADnVQKX2=jYfs5TBBKdKxHPi_ssUvrSuxbr22-dmYoP_e3=dA@mail.gmail.com>
Subject: Re: [RFC bpf-next 3/4] bpf: Generating a stubbed version of BPF
 program for termination
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Raj Sahu <rjsu26@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Dan Williams <djwillia@vt.edu>, miloc@vt.edu, ericts@vt.edu, 
	rahult@vt.edu, doniaghazy@vt.edu, quanzhif@vt.edu, 
	Jinghao Jia <jinghao7@illinois.edu>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 10:16=E2=80=AFPM Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
>
> On Mon, 12 May 2025 at 17:20, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, May 12, 2025 at 5:07=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > >
> > > - From verification point of view:
> > >   this function is RET_VOID and is not in
> > >   find_in_skiplist(), patch_generator() would replace its call with a
> > >   dummy. However, a corresponding bpf_spin_unlock() would remain and =
thus
> > >   bpf_check() will exit with error.
> > >   So, you would need some special version of bpf_check, that collects
> > >   all resources needed for program translation (e.g. maps), but does
> > >   not perform semantic checks.
> > >   Or patch_generator() has to be called for a program that is already
> > >   verified.
> >
> > No. let's not parametrize bpf_check.
> >
> > Here is what I proposed earlier in the thread:
> >
> > the verifier should just remember all places where kfuncs
> > and helpers return _OR_NULL,
> > then when the verification is complete, copy the prog,
> > replaces 'call kfunc/help' with 'call stub',
> > run two JITs, and compare JIT artifacts
> > to make sure IPs match.
> >
>
> This is something that we've experimented with last week
> https://github.com/sidchintamaneni/bpf/commits/bpf_term/v2_exploration/.
> We did the cloning part after `do_misc_fixups` and before
> `fixup_call_args` inside
> bpf_check().

Something like that but it needs to handle both helpers and kfuncs,
and you don't need new fake helpers.
text_poke_bp_batch() doesn't care what insn is being patched.

> > But thinking about it more...
> > I'm not sure any more that it's a good idea to fast execute
> > the program on one cpu and let it continue running as-is on
> > all other cpus including future invocations on this cpu.
> > So far the reasons to terminate bpf program:
> > - timeout in rqspinlock
> > - fault in arena
> > - some future watchdog
> >
>
> Also long running interators, for example -
> https://github.com/sidchintamaneni/os-dev-env/blob/main/bpf-programs-cata=
log/research/termination/patch_gen_testing/bpf_loop_lr.kern.c
> Eventhough this is just an example, this could be possible when
> iterating through a map which grows unconditionally.

In terms of detection this is a subset of watchdog.
In terms of termination we still need to figure out the best
path forward.
bpf_loop() may or may not be inlined.
If it's still a helper call then we can have per-prog "stop_me" flag,
but it will penalize run-time, and won't really work for
inlined (unless we force inlining logic to consult that flag
as well).
One option is to patch the callback subprog to return 1,
but the callback might not have a branch that returns 1.
Another option is to remember the insn that does:
        /* loop header,
         * if reg_loop_cnt >=3D reg_loop_max skip the loop body
         */
        insn_buf[cnt++] =3D BPF_JMP_REG(BPF_JGE, reg_loop_cnt, reg_loop_max=
, 5);

in inlined bpf_loop() and patch that insn with 'goto +5',
so inlined bpf_loop will terminate quickly.

> > In all cases the program is buggy, so it's safer
> > from kernel pov and from data integrity pov to stop
> > all instances now and prevent future invocations.
> > So I think we should patch the prog text in run-time
> > without cloning.
> >
>
> Yes, this is something that we had in mind:
> 1. Terminate the program on a single CPU
> 2. Terminate the program on all CPUs and de-link it
>
> Single CPU termination could be useful when a BPF program is using a
> per-CPU map and the map on a single CPU grows, causing the iterator to
> take a lot of time.

I think de-link (and detach) is difficult.
The context where an abnormal condition is detected (like watchdog)
may not allow detaching.
So I think replacing nop5 in the prologue with 'goto out'
is better.

>
> > The verifier should prepare an array of patches in
> > text_poke_bp_batch() format and when timeout/fault detected
> > do one call to text_poke_bp_batch() to stub out the whole prog.
> >
> Do you mean creating different versions of patches and applying one of
> them based on the current execution state?

I mean the verifier should prepare the whole batch with all insns
that needs to be patched and apply the whole thing at once
with one call to text_poke_bp_batch() that will affect all cpus.
It doesn't matter where the program was running on this cpu.
It might be running somewhere else on a different cpu.
text_poke_bp_batch() won't be atomic, but it doesn't have to be.
Every cpu might have a different fast-execute path to exit.

