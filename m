Return-Path: <bpf+bounces-17900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6DB813E61
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 00:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC4141C21BBF
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 23:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBDC6C6FD;
	Thu, 14 Dec 2023 23:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dO9++IK9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860BC6C6C3
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 23:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ca02def690so740991fa.3
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 15:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702597519; x=1703202319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeVlmRGkarljEyU41X8OnHyMxY8bME/PwUk1mph45NQ=;
        b=dO9++IK9nWzcVHQF8Geckg/QVmUUt4HuBwuDm9baYnQAyPc0iDiSBNk2Szpi3wpjgi
         uNXkFeqeud/LBXjDGsDQWsuwbMhm5Lmhkj0AnsPCWVnr1y1Sy41hu21ytNbqCdVxjjFK
         C7iBvBYN3FBjPx/f1CZvfYKNOr6duWD4s11m419dIoJraRXWesDDUvguQSdRfwng/zKT
         ZzCGA/QYqVxRURf4aYJswXvYPsdWSFoF8HtMrjVClf9CCMnsSF3BoLOpsGE6s6ufHUWe
         G+C0N95Urfq/JfNXUvWp/Z6E2jo5O5r4vF1SvzNikmhMTTZRSFB0uwZ9CSuaKExAUugm
         O2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702597519; x=1703202319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KeVlmRGkarljEyU41X8OnHyMxY8bME/PwUk1mph45NQ=;
        b=ulEoY+BTOVzniefwtXB/dxYwAVG1W8147w+t65CsQhfu2iBT8vTpcHuY3FsM85F+2x
         J4kcLH7Rths+HgVxwtDk7ppCnJxzXcz5D8C9XjTcd3xnRvlu3r+quI5xkTBrVs6s9jNc
         YQl69PSzT/qaDAqLmndzj9zm5HIz9c5qbqvD+UMTg0E6GZfx2AYdImV8Uqdmr9qCGmol
         HgM/Qw9CMic/dy0U1VW84w4XADSXOp1JDfOz1MQCaWkG6JQPtVa+h6Kkk9cmx5eeFQfj
         CTGt0lgsCc4ppWfRuoKwjtuKIjEklSQlox9ebPWEw+Fhvy5+TMxnCaSwXHckTcaVUcNX
         m7jQ==
X-Gm-Message-State: AOJu0Yzdg8MzFo98GIGVhkkcgtqKWCq8XpPPdl+rQSWuKlbiMVU2pI+5
	qMWchiZMlwkbl9aEUhsptCXXjv1Yy/iFZuSUscSkBiyD0kg=
X-Google-Smtp-Source: AGHT+IE1noNowFo5fMszlGDRjQDqu4nuEDSS0HSGSorXyl3YYgwDy74TZSTNo83/+a87awlfC9IDmzNXT47bd9oyrVA=
X-Received: by 2002:a2e:ab09:0:b0:2cc:21fc:35eb with SMTP id
 ce9-20020a2eab09000000b002cc21fc35ebmr6005345ljb.54.1702597519468; Thu, 14
 Dec 2023 15:45:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205184248.1502704-1-andrii@kernel.org> <20231205184248.1502704-10-andrii@kernel.org>
 <ZXsPWvgt6xWtUizn@mail.gmail.com>
In-Reply-To: <ZXsPWvgt6xWtUizn@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Dec 2023 15:45:07 -0800
Message-ID: <CAEf4BzbqRO-JTEfZ83pxfGe+1ULCtuBarNbaWDOi4eTfju6YAg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 09/10] selftests/bpf: validate precision logic
 in partial_stack_load_preserves_zeros
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 6:21=E2=80=AFAM Maxim Mikityanskiy <maxtram95@gmail=
.com> wrote:
>
> Hi Andrii,
>
> I'm preparing a series for submission [1], and it started failing on
> this selftest on big endian after I rebased over your series. Can we
> discuss (see below) to figure out whether it's a bug in your patch or
> whether I'm missing something?
>
> On Tue, 05 Dec 2023 at 10:42:47 -0800, Andrii Nakryiko wrote:
> > Enhance partial_stack_load_preserves_zeros subtest with detailed
> > precision propagation log checks. We know expect fp-16 to be spilled,
> > initially imprecise, zero const register, which is later marked as
> > precise even when partial stack slot load is performed, even if it's no=
t
> > a register fill (!).
> >
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  .../selftests/bpf/progs/verifier_spill_fill.c    | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/=
tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> > index 41fd61299eab..df4920da3472 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> > @@ -495,6 +495,22 @@ char single_byte_buf[1] SEC(".data.single_byte_buf=
");
> >  SEC("raw_tp")
> >  __log_level(2)
> >  __success
> > +/* make sure fp-8 is all STACK_ZERO */
> > +__msg("2: (7a) *(u64 *)(r10 -8) =3D 0          ; R10=3Dfp0 fp-8_w=3D00=
000000")
> > +/* but fp-16 is spilled IMPRECISE zero const reg */
> > +__msg("4: (7b) *(u64 *)(r10 -16) =3D r0        ; R0_w=3D0 R10=3Dfp0 fp=
-16_w=3D0")
> > +/* and now check that precision propagation works even for such tricky=
 case */
> > +__msg("10: (71) r2 =3D *(u8 *)(r10 -9)         ; R2_w=3DP0 R10=3Dfp0 f=
p-16_w=3D0")
>
> Why do we require R2 to be precise at this point? It seems the only
> reason it's marked as precise here is because it was marked at line 6,
> and the mark was never cleared: when R2 was overwritten at line 10, only
> __mark_reg_const_zero was called, and no-one cleared the flag, although
> R2 was overwritten.
>
> Moreover, if I replace r2 with r3 in this block, it doesn't get the
> precise mark, as I expect.
>
> Preserving the flag looks like a bug to me, but I wanted to double-check
> with you.
>


So let's look at the relevant pieces of the code and the log.

First, note that we set fp-16 slot to all zeroes by spilling register
with known value zero (but not yet marked precise)

3: (b7) r0 =3D 0                        ; R0_w=3D0
4: (7b) *(u64 *)(r10 -16) =3D r0        ; R0_w=3D0 R10=3Dfp0 fp-16_w=3D0

then eventually we get to insns #11, which is using r2 as an offset
into map_value pointer, so r2's value is important to know precisely,
so we start precision back propagation:

8: (73) *(u8 *)(r1 +0) =3D r2           ;
R1_w=3Dmap_value(map=3D.data.single_by,ks=3D4,vs=3D1) R2_w=3DP0
9: (bf) r1 =3D r6                       ;
R1_w=3Dmap_value(map=3D.data.single_by,ks=3D4,vs=3D1)
R6_w=3Dmap_value(map=3D.data.single_by,ks=3D4,vs=3D1)
10: (71) r2 =3D *(u8 *)(r10 -9)         ; R2_w=3DP0 R10=3Dfp0 fp-16_w=3D0
11: (0f) r1 +=3D r2
mark_precise: frame0: last_idx 11 first_idx 0 subseq_idx -1
mark_precise: frame0: regs=3Dr2 stack=3D before 10: (71) r2 =3D *(u8 *)(r10=
 -9)

^^ here r2 is assigned from fp-16 slot, so now we drop r2, but start
tracking fp-16 to mark it as precise

mark_precise: frame0: regs=3D stack=3D-16 before 9: (bf) r1 =3D r6
mark_precise: frame0: regs=3D stack=3D-16 before 8: (73) *(u8 *)(r1 +0) =3D=
 r2
mark_precise: frame0: regs=3D stack=3D-16 before 7: (0f) r1 +=3D r2
mark_precise: frame0: regs=3D stack=3D-16 before 6: (71) r2 =3D *(u8 *)(r10=
 -1)
mark_precise: frame0: regs=3D stack=3D-16 before 5: (bf) r1 =3D r6

^^ irrelevant instructions which we just skip

mark_precise: frame0: regs=3D stack=3D-16 before 4: (7b) *(u64 *)(r10 -16) =
=3D r0

^^ here we notice that fp-16 was set by spilling r0 state, so we drop
fp-16, start tracking r0

mark_precise: frame0: regs=3Dr0 stack=3D before 3: (b7) r0 =3D 0

^^ and finally we arrive at r0 which was assigned 0 directly. We are done.


All seems correct. Did you spot any problem in the logic?


> The context why it's relevant to my series: after patch [3], this fill
> goes to the then-branch on big endian (not to the else-branch, as
> before), and I copy the register with copy_register_state, which
> preserves the precise flag from the stack, not from the old value of r2.
>

I haven't looked at your patches, sorry, let's try figuring out if the
test's logic is broken, first.

> > +__msg("11: (0f) r1 +=3D r2")
> > +__msg("mark_precise: frame0: last_idx 11 first_idx 0 subseq_idx -1")
> > +__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 10: (71) r2 =3D=
 *(u8 *)(r10 -9)")
> > +__msg("mark_precise: frame0: regs=3D stack=3D-16 before 9: (bf) r1 =3D=
 r6")
> > +__msg("mark_precise: frame0: regs=3D stack=3D-16 before 8: (73) *(u8 *=
)(r1 +0) =3D r2")
> > +__msg("mark_precise: frame0: regs=3D stack=3D-16 before 7: (0f) r1 +=
=3D r2")
> > +__msg("mark_precise: frame0: regs=3D stack=3D-16 before 6: (71) r2 =3D=
 *(u8 *)(r10 -1)")
> > +__msg("mark_precise: frame0: regs=3D stack=3D-16 before 5: (bf) r1 =3D=
 r6")
> > +__msg("mark_precise: frame0: regs=3D stack=3D-16 before 4: (7b) *(u64 =
*)(r10 -16) =3D r0")
> > +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 3: (b7) r0 =3D =
0")
> >  __naked void partial_stack_load_preserves_zeros(void)
> >  {
> >       asm volatile (
> > --
> > 2.34.1
> >
> >
>
> [1]: https://github.com/kernel-patches/bpf/pull/6132
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tre=
e/kernel/bpf/verifier.c?id=3Dc838fe1282df540ebf6e24e386ac34acb3ef3115#n4806
> [3]: https://github.com/kernel-patches/bpf/pull/6132/commits/0e72ee541180=
812e515b2bf3ebd127b6e670fd59

