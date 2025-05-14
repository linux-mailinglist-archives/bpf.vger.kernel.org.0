Return-Path: <bpf+bounces-58235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B270FAB7605
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 21:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9BC4C241D
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 19:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B592918FE;
	Wed, 14 May 2025 19:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdRI2tJ1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BC215278E
	for <bpf@vger.kernel.org>; Wed, 14 May 2025 19:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747251498; cv=none; b=gwuZkExnoKe+iZCzjkmd3+zYrLcLHZi5VFm+YkgsGv9JtPOPGYbEjGXdOLTHaHAxQAwAu8hMLJvckHpRmGuPkRxzz/01KPX3Ero8xYo4a0z3xNAGJ1nnF1LmBa7X9E2nvP6s6fOABWYaEkjuV639YNNpLW+VUyJTozfbaxEAurQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747251498; c=relaxed/simple;
	bh=g/Vog5IuZoF0ytya9wtiXRFfTQzbrrEkqE0dm2mARvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HsWyU+I2l4/STnHgH6m24gmZ0IWlg9HUKxrrA5yc44lDzM7WH1Jr4o+bGfe/5wc+cwmZWKpAQ4526B7Kqv2TnAvqSP3QJfu9Ozh94coN6K+45f0uH4f4+488GWtkkBbtZb8Un1UFi/d0fQcGrrWsb1sJdETTblvZjiJ546LBeZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdRI2tJ1; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5fbf007ea38so305925a12.3
        for <bpf@vger.kernel.org>; Wed, 14 May 2025 12:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747251493; x=1747856293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Px1cOmw1elnuQ1MdOWXPbIflcovRSoOGkM7m/4ITU34=;
        b=mdRI2tJ14Ps+q/vWOMnsqD0aUzwicJRRQhzpxOwHb8CVM1iJl8uNUo8lHojp+qPiDJ
         XMl/La4c4dvO1Ap/t0r+YSwTs5sOa2K9rN23rhe6LjQsjwUhIsotDBA56DwiUEekZOR6
         e7dDub3WBpNq+w884+TdurudIYDcdWqD6sMhmUjrFrOSdOLQMgAQP8RGND1gRyzQ66bk
         I2rzfjfH/mTb0mFJZAE6VvH7ovdS31vGOG2p9oG7jdjo2GVENVGdPcUrzC+5AqDZOKH2
         +Fgse74EPjtRAK0UI2xZLmFgzOvTZJUtMrwee7M3vVvlT7IKuPNtHjq7ymIb1hAhafkV
         c7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747251493; x=1747856293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Px1cOmw1elnuQ1MdOWXPbIflcovRSoOGkM7m/4ITU34=;
        b=uqA4RgCx3BgChBPoeKBaaeZAepePHz3KlltcIFQWpPOOJIdmTbYyg+xWqUuE1XSznz
         7SRwHmMAxhdZkB3ePuGcTwvRIK7sopv4qaNgYfJN4ltiAybaxt4rihm5vwm7poO+UKdS
         xMZ27J3LVews09z4cfYjW4ww1l5yiDdLNXTPPNxvKXhAb2siqBhJBzvJsgBPKb2Ej8B2
         vaIB1RncAYwfnzOq3fMtMXelgRcm8nDfdozG8o7PQ5fuu3nFr0dmvHsYQXYM6FEX5rH5
         93gmZ0UMP3GRenLuqe3TVypk5Prgauwx7u56HpJzVHnWfjJr/9emETQfwtAaFde5uxJ8
         29CA==
X-Gm-Message-State: AOJu0YwUMg1po+0YktrO20163zrf+0qcluQ9uw66A8G/Y4UAUw3DBS/J
	33OrZjO+jaU7jkVg774C1kqnXfnBjpWxu82rECQyHjrJ0iBD6q0yTSC1cggqz+w0axvWYRerFDv
	if0KpcBKuqb9G2q2WrfCB+D0+V+Ia0sqUfbPgcxLN
X-Gm-Gg: ASbGncvCVZ5aadOJTHpNtOlIwjMkmBnaYepB8yXXC7YeIEPCxeTFDCcdzaVXabgymlx
	X8Vst1gOvzdzTwiLUDcIOrDR+HIqrkOWCq4BmZ/YrT43a2QhIZ1Uo5MUwg4L8Dny2V1U3wCWpf2
	/k3IBAGKHCXZqjXkzSben3wY9tI3OXYt8opZLTs0gQP+YhEFaP
X-Google-Smtp-Source: AGHT+IEd0QvIQ81uIGR++nZ09sLMXmXsyQw9TjvNyWNrjGkj7tddBhw5PQugSY47UM6tP2WcNIQhAAY0yzK4ertgFAA=
X-Received: by 2002:a17:907:7f05:b0:ad2:2417:12d2 with SMTP id
 a640c23a62f3a-ad4f7519e0dmr387013966b.42.1747251492477; Wed, 14 May 2025
 12:38:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514175415.2045783-1-memxor@gmail.com> <CAADnVQLtAEJrp5TRg0QpA8nZBn=kT17C0E64AHhm4+fYi8Xm5w@mail.gmail.com>
In-Reply-To: <CAADnVQLtAEJrp5TRg0QpA8nZBn=kT17C0E64AHhm4+fYi8Xm5w@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 14 May 2025 15:37:36 -0400
X-Gm-Features: AX0GCFvgb3RawED1YwACWgUjHEsm06AMbzdG9uJ_YaxuDyN2rRZFjeH884oPeyk
Message-ID: <CAP01T77AJ4MpMzYPJLzYavzGV4h5eDk=ECX8g7Erd+DUqi+dSQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf, x86: Add support for signed arena loads
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 14 May 2025 at 15:25, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, May 14, 2025 at 10:54=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >  static void emit_stx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, i=
nt off)
> >  {
> > @@ -2010,13 +2037,19 @@ st:                     if (is_imm8(insn->off))
> >                 case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
> >                 case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
> >                 case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
> > +               case BPF_LDX | BPF_PROBE_MEM32SX | BPF_B:
> > +               case BPF_LDX | BPF_PROBE_MEM32SX | BPF_H:
> > +               case BPF_LDX | BPF_PROBE_MEM32SX | BPF_W:
> >                 case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
> >                 case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
> >                 case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
> >                 case BPF_STX | BPF_PROBE_MEM32 | BPF_DW:
> >                         start_of_ldx =3D prog;
> >                         if (BPF_CLASS(insn->code) =3D=3D BPF_LDX)
> > -                               emit_ldx_r12(&prog, BPF_SIZE(insn->code=
), dst_reg, src_reg, insn->off);
> > +                               if (BPF_MODE(insn->code) =3D=3D BPF_PRO=
BE_MEM32SX)
> > +                                       emit_ldsx_r12(&prog, BPF_SIZE(i=
nsn->code), dst_reg, src_reg, insn->off);
> > +                               else
> > +                                       emit_ldx_r12(&prog, BPF_SIZE(in=
sn->code), dst_reg, src_reg, insn->off);
> >                         else
> >                                 emit_stx_r12(&prog, BPF_SIZE(insn->code=
), dst_reg, src_reg, insn->off);
> >  populate_extable:
>
> Luckily I didn't trust CI and decided to test it manually:
>
> ./test_progs-cpuv4 -t arena_spin
> [   68.977751] mem32 extable bug
> [   68.984388] mem32 extable bug
> [   69.182864] mem32 extable bug
> [   69.190027] mem32 extable bug
> [   69.408629] mem32 extable bug
> [   69.415651] mem32 extable bug
> libbpf: prog 'prog': BPF program load failed: -EINVAL
> libbpf: prog 'prog': -- BEGIN PROG LOAD LOG --
> Func#1 ('arena_spin_lock_slowpath') is safe for any args that match
> its prototype
> calling kernel functions are not allowed in non-JITed programs
> processed 408 insns (limit 1000000) max_states_per_insn 1 total_states
> 42 peak_states 42 mark_read 7
> -- END PROG LOAD LOG --
>
> The verifier error is wrong.
> The prog failed to JIT, but jit_subprog didn't return EFAULT
> and the verifier tried to guess the error with:
>         if (has_kfunc_call) {
>                 verbose(env, "calling kernel functions are not allowed
> in non-JITed programs\n");
>                 return -EINVAL;
>         }
>
> and guessed it wrong,
> but that is a separate issue.
>
> The patch needs this fix:
>
> index 70152200cc8c..a66c288dd812 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21188,6 +21188,7 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
>                         if (BPF_CLASS(insn->code) =3D=3D BPF_LDX &&
>                             (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM ||
>                              BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM32 =
||
> +                            BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM32S=
X ||
>                              BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEMSX)=
)
>                                 num_exentries++;
>                         if ((BPF_CLASS(insn->code) =3D=3D BPF_STX ||
>
>
> Before I tested it I thought we can apply this patch without
> a new selftest, but that would have been a mistake.
> We would have landed a half working sign extending loads :(
>
> Please respin with the selftest.

Hmm, weird.
I tested with an asm volatile sign extending load in arena_list before
sending out and didn't hit it.
That should have hit the extable too. It did fail on revert and
succeeded on applying the change.
But I'll add an explicit test.

>
> pw-bot: cr

