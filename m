Return-Path: <bpf+bounces-18049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B088153B9
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 23:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A404F1F263C2
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 22:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5096D657;
	Fri, 15 Dec 2023 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECmwRwYL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BD218EC7
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 22:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-58a7d13b00bso795226eaf.1
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 14:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702679688; x=1703284488; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LBa6n5fXNHBq8DNH3i9A6BZiqnzOkPRdQ+oxm0YijEs=;
        b=ECmwRwYLUfbn3b4QbDUibEVw7nvjLdIs6oGf+c2wzPPfCw9isK500pFZO2FiDVF931
         iuviVbNBhDDVMhQ4Z5UxFkouzvmav7NONZO6dSbfUmHVDORb4xJSozGcD48Fk4BGTeUU
         IREwk9WXKqzc0glnztOUfB1TK6uIfWxkcaBv/3IE0w97XR6UDBt4hnwY0bGl9Avc0NOA
         vv9lKIzxgnxUA15mb7iYwfYU64Yb+jP6XYhNw3jhdIvfY5IEv6VScYQQrtHdbv5C72mv
         TaneAGFuqTLiyKZNZHoXae5SrmjOONpmzPCDFsg/GjGttK53xSKUjMiIVGZljfzVNu4r
         TGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702679688; x=1703284488;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LBa6n5fXNHBq8DNH3i9A6BZiqnzOkPRdQ+oxm0YijEs=;
        b=K9fq24TzzcirE5CZ5ny1eQf1C5pevXHSi5YPqrGzxhdUQmsXSbFrZdwPtrJ/DD5YHb
         Ua2qCJaHJ9tXdOJwXmDezigvS+1nHEG1AeVKlBiG5aIk8QAfa4D1R1GW+FMzPaSxl4zr
         uau9Ty9VgxcYWRmynmIjB4aLsWc2zq3FCKSBnOLQ90WGZwzqi/+4RXL0fKXen7i4zlSr
         LKM+DFzML1aSJVEgo+rYhSQSngVpOm6uvenplos/AV8PXQrj+S94hmUnnxf5SCENmTm8
         B2CN/2WAZkOBkMXHxCxpSRaKrxWlFJdYtcXfoAbsUDYSv/uYr/KhnJSlK+zhzg1HtyKZ
         aywA==
X-Gm-Message-State: AOJu0Yz0XbpAuwO1o+XaJ5tU4rh4Wymy3099N5Bv5TKjP9cRV502lddi
	/HbRg9aCTV6grXuKnxbpe/k=
X-Google-Smtp-Source: AGHT+IGZwdnOsJ5SCTcZrgjc6ds72EA+W959IOtBUBSUgal1+43Nl2JhmNcpSR2Dk4cjGWB39AbdwA==
X-Received: by 2002:a05:6359:b82:b0:170:5f32:b3bb with SMTP id gf2-20020a0563590b8200b001705f32b3bbmr11977531rwb.51.1702679687641;
        Fri, 15 Dec 2023 14:34:47 -0800 (PST)
Received: from localhost ([185.220.102.8])
        by smtp.gmail.com with ESMTPSA id so3-20020a17090b1f8300b0028ae8495d47sm5935872pjb.21.2023.12.15.14.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 14:34:47 -0800 (PST)
Date: Sat, 16 Dec 2023 00:34:40 +0200
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	kernel-team@meta.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v4 bpf-next 09/10] selftests/bpf: validate precision
 logic in partial_stack_load_preserves_zeros
Message-ID: <ZXzUgFgCmPY9p0aV@mail.gmail.com>
References: <20231205184248.1502704-1-andrii@kernel.org>
 <20231205184248.1502704-10-andrii@kernel.org>
 <ZXsPWvgt6xWtUizn@mail.gmail.com>
 <CAEf4BzbqRO-JTEfZ83pxfGe+1ULCtuBarNbaWDOi4eTfju6YAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbqRO-JTEfZ83pxfGe+1ULCtuBarNbaWDOi4eTfju6YAg@mail.gmail.com>

On Thu, 14 Dec 2023 at 15:45:07 -0800, Andrii Nakryiko wrote:
> On Thu, Dec 14, 2023 at 6:21 AM Maxim Mikityanskiy <maxtram95@gmail.com> wrote:
> >
> > Hi Andrii,
> >
> > I'm preparing a series for submission [1], and it started failing on
> > this selftest on big endian after I rebased over your series. Can we
> > discuss (see below) to figure out whether it's a bug in your patch or
> > whether I'm missing something?
> >
> > On Tue, 05 Dec 2023 at 10:42:47 -0800, Andrii Nakryiko wrote:
> > > Enhance partial_stack_load_preserves_zeros subtest with detailed
> > > precision propagation log checks. We know expect fp-16 to be spilled,
> > > initially imprecise, zero const register, which is later marked as
> > > precise even when partial stack slot load is performed, even if it's not
> > > a register fill (!).
> > >
> > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  .../selftests/bpf/progs/verifier_spill_fill.c    | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> > > index 41fd61299eab..df4920da3472 100644
> > > --- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> > > +++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> > > @@ -495,6 +495,22 @@ char single_byte_buf[1] SEC(".data.single_byte_buf");
> > >  SEC("raw_tp")
> > >  __log_level(2)
> > >  __success
> > > +/* make sure fp-8 is all STACK_ZERO */
> > > +__msg("2: (7a) *(u64 *)(r10 -8) = 0          ; R10=fp0 fp-8_w=00000000")
> > > +/* but fp-16 is spilled IMPRECISE zero const reg */
> > > +__msg("4: (7b) *(u64 *)(r10 -16) = r0        ; R0_w=0 R10=fp0 fp-16_w=0")
> > > +/* and now check that precision propagation works even for such tricky case */
> > > +__msg("10: (71) r2 = *(u8 *)(r10 -9)         ; R2_w=P0 R10=fp0 fp-16_w=0")
> >
> > Why do we require R2 to be precise at this point? It seems the only
> > reason it's marked as precise here is because it was marked at line 6,
> > and the mark was never cleared: when R2 was overwritten at line 10, only
> > __mark_reg_const_zero was called, and no-one cleared the flag, although
> > R2 was overwritten.
> >
> > Moreover, if I replace r2 with r3 in this block, it doesn't get the
> > precise mark, as I expect.
> >
> > Preserving the flag looks like a bug to me, but I wanted to double-check
> > with you.
> >
> 
> 
> So let's look at the relevant pieces of the code and the log.
> 
> First, note that we set fp-16 slot to all zeroes by spilling register
> with known value zero (but not yet marked precise)
> 
> 3: (b7) r0 = 0                        ; R0_w=0
> 4: (7b) *(u64 *)(r10 -16) = r0        ; R0_w=0 R10=fp0 fp-16_w=0
> 
> then eventually we get to insns #11, which is using r2 as an offset
> into map_value pointer, so r2's value is important to know precisely,
> so we start precision back propagation:
> 
> 8: (73) *(u8 *)(r1 +0) = r2           ;
> R1_w=map_value(map=.data.single_by,ks=4,vs=1) R2_w=P0
> 9: (bf) r1 = r6                       ;
> R1_w=map_value(map=.data.single_by,ks=4,vs=1)
> R6_w=map_value(map=.data.single_by,ks=4,vs=1)
> 10: (71) r2 = *(u8 *)(r10 -9)         ; R2_w=P0 R10=fp0 fp-16_w=0

All that you say below makes sense to me. What looks weird is this "P0"
at line 10, because it's before the backtracking happened. And if I
patch this block in the test as follows (replacing r2 with r3):

"r1 = %[single_byte_buf];"
"r3 = *(u8 *)(r10 -9);"
"r1 += r3;"
"*(u8 *)(r1 + 0) = r3;"

then I no longer see R3_w=P0 before the backtracking:

8: (73) *(u8 *)(r1 +0) = r2           ; R1_w=map_value(map=.data.single_by,ks=4,vs=1) R2_w=P0
9: (bf) r1 = r6                       ; R1_w=map_value(map=.data.single_by,ks=4,vs=1) R6_w=map_value(map=.data.single_by,ks=4,vs=1)
10: (71) r3 = *(u8 *)(r10 -9)         ; R3_w=0 R10=fp0 fp-16_w=0
11: (0f) r1 += r3

although the backtracking that follows looks the same:

mark_precise: frame0: last_idx 11 first_idx 0 subseq_idx -1
mark_precise: frame0: regs=r3 stack= before 10: (71) r3 = *(u8 *)(r10 -9)
mark_precise: frame0: regs= stack=-16 before 9: (bf) r1 = r6
mark_precise: frame0: regs= stack=-16 before 8: (73) *(u8 *)(r1 +0) = r2
mark_precise: frame0: regs= stack=-16 before 7: (0f) r1 += r2
mark_precise: frame0: regs= stack=-16 before 6: (71) r2 = *(u8 *)(r10 -1)
mark_precise: frame0: regs= stack=-16 before 5: (bf) r1 = r6
mark_precise: frame0: regs= stack=-16 before 4: (7b) *(u64 *)(r10 -16) = r0
mark_precise: frame0: regs=r0 stack= before 3: (b7) r0 = 0

It seems the reason it shows R2_w=P0, but R3_w=0, is that at [2] you
overwrite the register boundaries with zero, but you don't reset the
precise flag, and r2 had it set higher above (for its previous value).

What do you think? Does what I say make sense?

> 11: (0f) r1 += r2
> mark_precise: frame0: last_idx 11 first_idx 0 subseq_idx -1
> mark_precise: frame0: regs=r2 stack= before 10: (71) r2 = *(u8 *)(r10 -9)
> 
> ^^ here r2 is assigned from fp-16 slot, so now we drop r2, but start
> tracking fp-16 to mark it as precise
> 
> mark_precise: frame0: regs= stack=-16 before 9: (bf) r1 = r6
> mark_precise: frame0: regs= stack=-16 before 8: (73) *(u8 *)(r1 +0) = r2
> mark_precise: frame0: regs= stack=-16 before 7: (0f) r1 += r2
> mark_precise: frame0: regs= stack=-16 before 6: (71) r2 = *(u8 *)(r10 -1)
> mark_precise: frame0: regs= stack=-16 before 5: (bf) r1 = r6
> 
> ^^ irrelevant instructions which we just skip
> 
> mark_precise: frame0: regs= stack=-16 before 4: (7b) *(u64 *)(r10 -16) = r0
> 
> ^^ here we notice that fp-16 was set by spilling r0 state, so we drop
> fp-16, start tracking r0
> 
> mark_precise: frame0: regs=r0 stack= before 3: (b7) r0 = 0
> 
> ^^ and finally we arrive at r0 which was assigned 0 directly. We are done.
> 
> 
> All seems correct. Did you spot any problem in the logic?
> 
> 
> > The context why it's relevant to my series: after patch [3], this fill
> > goes to the then-branch on big endian (not to the else-branch, as
> > before), and I copy the register with copy_register_state, which
> > preserves the precise flag from the stack, not from the old value of r2.
> >
> 
> I haven't looked at your patches, sorry, let's try figuring out if the
> test's logic is broken, first.
> 
> > > +__msg("11: (0f) r1 += r2")
> > > +__msg("mark_precise: frame0: last_idx 11 first_idx 0 subseq_idx -1")
> > > +__msg("mark_precise: frame0: regs=r2 stack= before 10: (71) r2 = *(u8 *)(r10 -9)")
> > > +__msg("mark_precise: frame0: regs= stack=-16 before 9: (bf) r1 = r6")
> > > +__msg("mark_precise: frame0: regs= stack=-16 before 8: (73) *(u8 *)(r1 +0) = r2")
> > > +__msg("mark_precise: frame0: regs= stack=-16 before 7: (0f) r1 += r2")
> > > +__msg("mark_precise: frame0: regs= stack=-16 before 6: (71) r2 = *(u8 *)(r10 -1)")
> > > +__msg("mark_precise: frame0: regs= stack=-16 before 5: (bf) r1 = r6")
> > > +__msg("mark_precise: frame0: regs= stack=-16 before 4: (7b) *(u64 *)(r10 -16) = r0")
> > > +__msg("mark_precise: frame0: regs=r0 stack= before 3: (b7) r0 = 0")
> > >  __naked void partial_stack_load_preserves_zeros(void)
> > >  {
> > >       asm volatile (
> > > --
> > > 2.34.1
> > >
> > >
> >
> > [1]: https://github.com/kernel-patches/bpf/pull/6132
> > [2]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/kernel/bpf/verifier.c?id=c838fe1282df540ebf6e24e386ac34acb3ef3115#n4806
> > [3]: https://github.com/kernel-patches/bpf/pull/6132/commits/0e72ee541180812e515b2bf3ebd127b6e670fd59

