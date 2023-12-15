Return-Path: <bpf+bounces-18052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAD1815453
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 00:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9561F25629
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 23:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941A418EBB;
	Fri, 15 Dec 2023 23:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipNFzlld"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B1849F67
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 23:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40c580ba223so14305385e9.3
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 15:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702681388; x=1703286188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ci8RCbAmQN8bzikISe2KPPEnjwaZftRLc3VPZPqp3Ps=;
        b=ipNFzlld6HzIKwrTJonXEUmW10855u1VO7jOsPVVlausyn2Qo8+D3Bhae4FZU3pwlG
         6Yctg3+Y4bVJMaMlFMpbyAWiDMfELf2RDW1CSt8yqY3X31YxcTsfO1hZtBpnFpQ2MwTI
         kd7UsRiI1VtZNapYC57c+P+rnhaq4UlB/iIt6iXiT03OZysky7O3Mk2Wf4A2HLB02Tat
         sA0eWfaMHBj2Lu9fqZcnLrB/RuzRiBNgao8PZYPb/KCjyhvfXNWjoScm57kxkOnev7cZ
         MqQ6qS9KYXt7zz6qqy7oIJ+V8+lEX2L61V14JMNioJci6TzT+4YDAvUT8bZk24BbywN6
         dHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702681388; x=1703286188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ci8RCbAmQN8bzikISe2KPPEnjwaZftRLc3VPZPqp3Ps=;
        b=fxzGqce9yZHXDr5tSEJYYXK7z/3vxznmxwfGMDMAjAD9Mu8j/mnByGdPGwgHQ3A4Yp
         GipyMc8KeXgl/7rEXTivdjOGrZzQOTt4vUS90vy9LXrCECECLPbP/WLxqq3jDNQCgokL
         U55zBY6T4J4LTKKNx4HOAzMl/FvGmiil3D6Xs1lgnqtM0lDUbvEJsZW5scjysSS1HE+L
         LBR+RBMOwrNfgAmXVhRUiWXO+b/eV9ar0WP9vnks0LINpzOEV2SBbK38bpizygC5GwlR
         2GitaHwWNJs5VgBCYSZQeZa4SdvdLat4oOwV35o+zP2kIE1l0Lbmq1/qoTRvSqL3CY6a
         2Lrg==
X-Gm-Message-State: AOJu0Yw0HnjZ0iDR/g1dThF2qB2i9Jm/hGlR85Rs7LtmR8axkTNTPwCa
	WEnbGKjil+4xazJYoRM18MZStR3CLJ+2mmqpMqw=
X-Google-Smtp-Source: AGHT+IFurDx6C9EXGH0Xq/tHrdlWhKy6JUIABTPYIEZAQVezXJ6t1/F0YPR2P3sXeqV4DDa0AJzetfqGZeS2XObiaOA=
X-Received: by 2002:a05:6000:ac6:b0:336:5b5d:966a with SMTP id
 di6-20020a0560000ac600b003365b5d966amr534333wrb.111.1702681388384; Fri, 15
 Dec 2023 15:03:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205184248.1502704-1-andrii@kernel.org> <20231205184248.1502704-10-andrii@kernel.org>
 <ZXsPWvgt6xWtUizn@mail.gmail.com> <CAEf4BzbqRO-JTEfZ83pxfGe+1ULCtuBarNbaWDOi4eTfju6YAg@mail.gmail.com>
 <ZXzUgFgCmPY9p0aV@mail.gmail.com>
In-Reply-To: <ZXzUgFgCmPY9p0aV@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 Dec 2023 15:02:56 -0800
Message-ID: <CAEf4BzayGCAakixaUjOPaw+A2jqUUyQb+PYYf7uMDyGeEB0cvQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 09/10] selftests/bpf: validate precision logic
 in partial_stack_load_preserves_zeros
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 2:34=E2=80=AFPM Maxim Mikityanskiy <maxtram95@gmail=
.com> wrote:
>
> On Thu, 14 Dec 2023 at 15:45:07 -0800, Andrii Nakryiko wrote:
> > On Thu, Dec 14, 2023 at 6:21=E2=80=AFAM Maxim Mikityanskiy <maxtram95@g=
mail.com> wrote:
> > >
> > > Hi Andrii,
> > >
> > > I'm preparing a series for submission [1], and it started failing on
> > > this selftest on big endian after I rebased over your series. Can we
> > > discuss (see below) to figure out whether it's a bug in your patch or
> > > whether I'm missing something?
> > >
> > > On Tue, 05 Dec 2023 at 10:42:47 -0800, Andrii Nakryiko wrote:
> > > > Enhance partial_stack_load_preserves_zeros subtest with detailed
> > > > precision propagation log checks. We know expect fp-16 to be spille=
d,
> > > > initially imprecise, zero const register, which is later marked as
> > > > precise even when partial stack slot load is performed, even if it'=
s not
> > > > a register fill (!).
> > > >
> > > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  .../selftests/bpf/progs/verifier_spill_fill.c    | 16 ++++++++++++=
++++
> > > >  1 file changed, 16 insertions(+)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.=
c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> > > > index 41fd61299eab..df4920da3472 100644
> > > > --- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> > > > +++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> > > > @@ -495,6 +495,22 @@ char single_byte_buf[1] SEC(".data.single_byte=
_buf");
> > > >  SEC("raw_tp")
> > > >  __log_level(2)
> > > >  __success
> > > > +/* make sure fp-8 is all STACK_ZERO */
> > > > +__msg("2: (7a) *(u64 *)(r10 -8) =3D 0          ; R10=3Dfp0 fp-8_w=
=3D00000000")
> > > > +/* but fp-16 is spilled IMPRECISE zero const reg */
> > > > +__msg("4: (7b) *(u64 *)(r10 -16) =3D r0        ; R0_w=3D0 R10=3Dfp=
0 fp-16_w=3D0")
> > > > +/* and now check that precision propagation works even for such tr=
icky case */
> > > > +__msg("10: (71) r2 =3D *(u8 *)(r10 -9)         ; R2_w=3DP0 R10=3Df=
p0 fp-16_w=3D0")
> > >
> > > Why do we require R2 to be precise at this point? It seems the only
> > > reason it's marked as precise here is because it was marked at line 6=
,
> > > and the mark was never cleared: when R2 was overwritten at line 10, o=
nly
> > > __mark_reg_const_zero was called, and no-one cleared the flag, althou=
gh
> > > R2 was overwritten.
> > >
> > > Moreover, if I replace r2 with r3 in this block, it doesn't get the
> > > precise mark, as I expect.
> > >
> > > Preserving the flag looks like a bug to me, but I wanted to double-ch=
eck
> > > with you.
> > >
> >
> >
> > So let's look at the relevant pieces of the code and the log.
> >
> > First, note that we set fp-16 slot to all zeroes by spilling register
> > with known value zero (but not yet marked precise)
> >
> > 3: (b7) r0 =3D 0                        ; R0_w=3D0
> > 4: (7b) *(u64 *)(r10 -16) =3D r0        ; R0_w=3D0 R10=3Dfp0 fp-16_w=3D=
0
> >
> > then eventually we get to insns #11, which is using r2 as an offset
> > into map_value pointer, so r2's value is important to know precisely,
> > so we start precision back propagation:
> >
> > 8: (73) *(u8 *)(r1 +0) =3D r2           ;
> > R1_w=3Dmap_value(map=3D.data.single_by,ks=3D4,vs=3D1) R2_w=3DP0
> > 9: (bf) r1 =3D r6                       ;
> > R1_w=3Dmap_value(map=3D.data.single_by,ks=3D4,vs=3D1)
> > R6_w=3Dmap_value(map=3D.data.single_by,ks=3D4,vs=3D1)
> > 10: (71) r2 =3D *(u8 *)(r10 -9)         ; R2_w=3DP0 R10=3Dfp0 fp-16_w=
=3D0
>
> All that you say below makes sense to me. What looks weird is this "P0"
> at line 10, because it's before the backtracking happened. And if I
> patch this block in the test as follows (replacing r2 with r3):
>
> "r1 =3D %[single_byte_buf];"
> "r3 =3D *(u8 *)(r10 -9);"
> "r1 +=3D r3;"
> "*(u8 *)(r1 + 0) =3D r3;"
>
> then I no longer see R3_w=3DP0 before the backtracking:
>
> 8: (73) *(u8 *)(r1 +0) =3D r2           ; R1_w=3Dmap_value(map=3D.data.si=
ngle_by,ks=3D4,vs=3D1) R2_w=3DP0
> 9: (bf) r1 =3D r6                       ; R1_w=3Dmap_value(map=3D.data.si=
ngle_by,ks=3D4,vs=3D1) R6_w=3Dmap_value(map=3D.data.single_by,ks=3D4,vs=3D1=
)
> 10: (71) r3 =3D *(u8 *)(r10 -9)         ; R3_w=3D0 R10=3Dfp0 fp-16_w=3D0
> 11: (0f) r1 +=3D r3
>
> although the backtracking that follows looks the same:
>
> mark_precise: frame0: last_idx 11 first_idx 0 subseq_idx -1
> mark_precise: frame0: regs=3Dr3 stack=3D before 10: (71) r3 =3D *(u8 *)(r=
10 -9)
> mark_precise: frame0: regs=3D stack=3D-16 before 9: (bf) r1 =3D r6
> mark_precise: frame0: regs=3D stack=3D-16 before 8: (73) *(u8 *)(r1 +0) =
=3D r2
> mark_precise: frame0: regs=3D stack=3D-16 before 7: (0f) r1 +=3D r2
> mark_precise: frame0: regs=3D stack=3D-16 before 6: (71) r2 =3D *(u8 *)(r=
10 -1)
> mark_precise: frame0: regs=3D stack=3D-16 before 5: (bf) r1 =3D r6
> mark_precise: frame0: regs=3D stack=3D-16 before 4: (7b) *(u64 *)(r10 -16=
) =3D r0
> mark_precise: frame0: regs=3Dr0 stack=3D before 3: (b7) r0 =3D 0
>
> It seems the reason it shows R2_w=3DP0, but R3_w=3D0, is that at [2] you
> overwrite the register boundaries with zero, but you don't reset the
> precise flag, and r2 had it set higher above (for its previous value).
>
> What do you think? Does what I say make sense?

Oh, I yes, now I see that as well. You are right. Turns out
__mark_reg_const_zero() doesn't reset the precision flag. Yeah, in
this case when we restore zero from spilled register we should reset
precision for sure, that's an easy fix. But we need to also audit all
the uses of __mark_reg_const_zero() and confirm that it's intended to
preserve old value of precision flag (I suspect in some cases it's not
and we should probably specify that we either clear or set if always).

>
> > 11: (0f) r1 +=3D r2
> > mark_precise: frame0: last_idx 11 first_idx 0 subseq_idx -1
> > mark_precise: frame0: regs=3Dr2 stack=3D before 10: (71) r2 =3D *(u8 *)=
(r10 -9)
> >
> > ^^ here r2 is assigned from fp-16 slot, so now we drop r2, but start
> > tracking fp-16 to mark it as precise
> >
> > mark_precise: frame0: regs=3D stack=3D-16 before 9: (bf) r1 =3D r6
> > mark_precise: frame0: regs=3D stack=3D-16 before 8: (73) *(u8 *)(r1 +0)=
 =3D r2
> > mark_precise: frame0: regs=3D stack=3D-16 before 7: (0f) r1 +=3D r2
> > mark_precise: frame0: regs=3D stack=3D-16 before 6: (71) r2 =3D *(u8 *)=
(r10 -1)
> > mark_precise: frame0: regs=3D stack=3D-16 before 5: (bf) r1 =3D r6
> >
> > ^^ irrelevant instructions which we just skip
> >
> > mark_precise: frame0: regs=3D stack=3D-16 before 4: (7b) *(u64 *)(r10 -=
16) =3D r0
> >
> > ^^ here we notice that fp-16 was set by spilling r0 state, so we drop
> > fp-16, start tracking r0
> >
> > mark_precise: frame0: regs=3Dr0 stack=3D before 3: (b7) r0 =3D 0
> >
> > ^^ and finally we arrive at r0 which was assigned 0 directly. We are do=
ne.
> >
> >
> > All seems correct. Did you spot any problem in the logic?
> >
> >
> > > The context why it's relevant to my series: after patch [3], this fil=
l
> > > goes to the then-branch on big endian (not to the else-branch, as
> > > before), and I copy the register with copy_register_state, which
> > > preserves the precise flag from the stack, not from the old value of =
r2.
> > >
> >
> > I haven't looked at your patches, sorry, let's try figuring out if the
> > test's logic is broken, first.
> >
> > > > +__msg("11: (0f) r1 +=3D r2")
> > > > +__msg("mark_precise: frame0: last_idx 11 first_idx 0 subseq_idx -1=
")
> > > > +__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 10: (71) r2=
 =3D *(u8 *)(r10 -9)")
> > > > +__msg("mark_precise: frame0: regs=3D stack=3D-16 before 9: (bf) r1=
 =3D r6")
> > > > +__msg("mark_precise: frame0: regs=3D stack=3D-16 before 8: (73) *(=
u8 *)(r1 +0) =3D r2")
> > > > +__msg("mark_precise: frame0: regs=3D stack=3D-16 before 7: (0f) r1=
 +=3D r2")
> > > > +__msg("mark_precise: frame0: regs=3D stack=3D-16 before 6: (71) r2=
 =3D *(u8 *)(r10 -1)")
> > > > +__msg("mark_precise: frame0: regs=3D stack=3D-16 before 5: (bf) r1=
 =3D r6")
> > > > +__msg("mark_precise: frame0: regs=3D stack=3D-16 before 4: (7b) *(=
u64 *)(r10 -16) =3D r0")
> > > > +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 3: (b7) r0 =
=3D 0")
> > > >  __naked void partial_stack_load_preserves_zeros(void)
> > > >  {
> > > >       asm volatile (
> > > > --
> > > > 2.34.1
> > > >
> > > >
> > >
> > > [1]: https://github.com/kernel-patches/bpf/pull/6132
> > > [2]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git=
/tree/kernel/bpf/verifier.c?id=3Dc838fe1282df540ebf6e24e386ac34acb3ef3115#n=
4806
> > > [3]: https://github.com/kernel-patches/bpf/pull/6132/commits/0e72ee54=
1180812e515b2bf3ebd127b6e670fd59

