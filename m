Return-Path: <bpf+bounces-41657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 239E1999522
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 00:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF452837FE
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 22:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AA21EC01F;
	Thu, 10 Oct 2024 22:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvOHar8S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F6A1E9091;
	Thu, 10 Oct 2024 22:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598961; cv=none; b=OarNxrTpmfivUPGUKxRapNKqPma977gbmAKcalwrb5eu846Zonn1/t5kiySaCGdm3zCTcxGBJhwl0g40b/g5RGpMmLQdvkcMoDu4yihzVlM3ShJ96Ee6OiaSKNM/yym3Ja8m8hUIMc1z2UgTJtqfPPop09z4bFZzgMoyWV+dHRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598961; c=relaxed/simple;
	bh=gemCiS2iR6rMBKQV+E/ag/riT2JdV0rWSQPpaz+ddsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrWGSZ5vEfvYT9SWQSahToAL/bk66exvWqa+vVvaIY2ofj1Wkrvb7HnWArjSk1VPVGx2eXyDJDdAi/jlj3XRe2gZwUFYhls2xLLwu4fGMT/ypqZIl8wXQ5rPcbzMHFqbsmzInUZML+tgt5vJa0ytbEBVhSOSWtV03HF09qXBBq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvOHar8S; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2bb1efe78so1035205a91.1;
        Thu, 10 Oct 2024 15:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728598959; x=1729203759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJ3QmMlS95A6MHzFTxNEnAHvRaHc4Cdj7eqnkirwFiE=;
        b=HvOHar8SlYD0VRxO5vJvbMLR9NL9xhl7T7VpZ8zBrGlOsLkbomeJRhryhGmDOWNS9B
         1t0RhoDeMcQJ/Ke4oEJpgxuXXSujmQ32+IhE5DuxF6nmpyC9NU/skwzQVMVOBEiLRkcm
         TDzEScUxuKwTwmJ4mGaax/K712CrqXbTZ5J6JenT+GkfOJ7OskcaLb1IXxQ5C4S0qFoA
         FXdhEX8e8Qnr2LdHfOgNF3GHB+gvBIkcroOgfL3e/c2JVfV1M/M6ecnsqIR3Oq3uw7Ua
         dDhVoVnSdqvPmn1mwipP99lME5Pm7FGQAPD/OZsP1S4YbJF5IQ8rUvPt7Gn668B8c2t2
         ms/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728598959; x=1729203759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJ3QmMlS95A6MHzFTxNEnAHvRaHc4Cdj7eqnkirwFiE=;
        b=FxbqNEwR6neWk2599CByhen7aUmeBNUCKrVV2pVd2hyjK5roZ/HiiNH8sx2YVGb03W
         gvueZxRLQI42UyPOI6hGofN05mYUb0Pi2QUVrgvYvMJqI1Oc0seiO9+GSM5rxDJAZIwj
         zDYIzouPKpb6rubLY4h/DCKecv430vD98CunKmwGlgyzDSpi4z2Vq4Z2DuncTBfJ1/rC
         sL2CZFFg5Kl5YC2WqIikPAbjkS+T2FVfWM8TeFR9HANXi82sBP3bRYbDAZtRl+46LqZM
         FGobnej4u7q+wmP+IYqW2mTjSHNQKIInZAcOOjg167U32PqYvjZQu1rud4hrNj3Yl5+V
         aPOw==
X-Forwarded-Encrypted: i=1; AJvYcCUTeKSuJ4Zc6NHVA6YNtsXbuO46A/M8WvZtH0PQpIDwqMe3JDkulisDON8qpaw2TSeuCpetzYZHwjWOdu2S@vger.kernel.org, AJvYcCW+fMd3/5kyse24J1z7ZOHBeqBokQ6QjpV7ocG0R0aGQ3GUEgLjiZY/fv3OB95USlOQdko=@vger.kernel.org, AJvYcCXsR9LNjOHYtro0Xuw/bfcAA8FMgZNoB74KxbXWyd58dthlu2AtVist5BiJSycoUu/UnPdM+gegOz81yCL3LYDY+fIs@vger.kernel.org
X-Gm-Message-State: AOJu0YwiGXV1CgKUi+4LcDXBi8t6L9mDzpOX/F8mrp1gCbCA1VGqAq5j
	EvgYheVja2TswqlktS8YHcAWMOgEXHFPmWH3PFhu2lPXXyJCbb2hMgG9YOA0SaG7FPt31xp6HZw
	IoXaRUnEmzXQe3A/kH+hqijSt2AondJ/6
X-Google-Smtp-Source: AGHT+IF0HWG7jJwsVwL+jVP75fRAK56Gx2iufwCdfrFqkGu3wPHuQlDLS+8o28DvbEI4M7jB5O+2jJtOXHzLUVjMsOE=
X-Received: by 2002:a17:90a:a412:b0:2d8:b510:170f with SMTP id
 98e67ed59e1d1-2e2c81d3daamr6242625a91.20.1728598958986; Thu, 10 Oct 2024
 15:22:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909071114.1150053-1-liaochang1@huawei.com>
 <CAEf4BzZVUPZHyuyt6zGZVTQ3sB8u64Wxfuks9BGq-HXGM1yp3A@mail.gmail.com> <ZwezYJIIsiAeK46P@J2N7QTR9R3>
In-Reply-To: <ZwezYJIIsiAeK46P@J2N7QTR9R3>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 10 Oct 2024 15:22:26 -0700
Message-ID: <CAEf4BzbEGN4zpjg9fwdfnj0pjBDT2_YzE1WkpwVjee-FZL1_ZQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: insn: Simulate nop instruction for better
 uprobe performance
To: Mark Rutland <mark.rutland@arm.com>
Cc: Liao Chang <liaochang1@huawei.com>, will@kernel.org, catalin.marinas@arm.com, 
	ast@kernel.org, puranjay@kernel.org, andrii@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 3:58=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> Hi Andrii,
>
> On Wed, Oct 09, 2024 at 04:54:25PM -0700, Andrii Nakryiko wrote:
> > On Mon, Sep 9, 2024 at 12:21=E2=80=AFAM Liao Chang <liaochang1@huawei.c=
om> wrote:
>
> > I'm curious what's the status of this patch? It received no comments
> > so far in the last month. Can someone on the ARM64 side of things
> > please take a look? (or maybe it was applied to some tree and there
> > was just no notification?)
> >
> > This is a very useful performance optimization for uprobe tracing on
> > ARM64, so would be nice to get it in during current release cycle.
> > Thank you!
>
> Sorry, I got busy chasing up a bunch of bugs and hadn't gotten round to
> this yet.
>
> I've replied with a couple of minor comments and an ack, and I reckon we
> can queue this up this cycle. Usually this sort of thing starts to get
> queued around -rc3.

Thanks Mark! I'm happy to backport it internally before it goes into
official kernel release, as long as it's clear that the patch is in
the final state. So once Liao posts a new version with your ack, I'll
just go ahead and use it internally.

When you get a chance, please also take another look at Liao's second
optimization targeting STP instruction. I know it was more
controversial, but hopefully we can arrive at some maintainable
solution that would still benefit a very common uprobe tracing use
case. Thanks in advance!

  [0] https://lore.kernel.org/linux-trace-kernel/20240910060407.1427716-1-l=
iaochang1@huawei.com/

>
> Mark.
>
> >
> > > diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/i=
nsn.h
> > > index 8c0a36f72d6f..dd530d5c3d67 100644
> > > --- a/arch/arm64/include/asm/insn.h
> > > +++ b/arch/arm64/include/asm/insn.h
> > > @@ -549,6 +549,12 @@ static __always_inline bool aarch64_insn_uses_li=
teral(u32 insn)
> > >                aarch64_insn_is_prfm_lit(insn);
> > >  }
> > >
> > > +static __always_inline bool aarch64_insn_is_nop(u32 insn)
> > > +{
> > > +       return aarch64_insn_is_hint(insn) &&
> > > +              ((insn & 0xFE0) =3D=3D AARCH64_INSN_HINT_NOP);
> > > +}
> > > +
> > >  enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
> > >  u64 aarch64_insn_decode_immediate(enum aarch64_insn_imm_type type, u=
32 insn);
> > >  u32 aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
> > > diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kern=
el/probes/decode-insn.c
> > > index 968d5fffe233..be54539e309e 100644
> > > --- a/arch/arm64/kernel/probes/decode-insn.c
> > > +++ b/arch/arm64/kernel/probes/decode-insn.c
> > > @@ -75,6 +75,15 @@ static bool __kprobes aarch64_insn_is_steppable(u3=
2 insn)
> > >  enum probe_insn __kprobes
> > >  arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn *a=
pi)
> > >  {
> > > +       /*
> > > +        * While 'nop' instruction can execute in the out-of-line slo=
t,
> > > +        * simulating them in breakpoint handling offers better perfo=
rmance.
> > > +        */
> > > +       if (aarch64_insn_is_nop(insn)) {
> > > +               api->handler =3D simulate_nop;
> > > +               return INSN_GOOD_NO_SLOT;
> > > +       }
> > > +
> > >         /*
> > >          * Instructions reading or modifying the PC won't work from t=
he XOL
> > >          * slot.
> > > diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/ke=
rnel/probes/simulate-insn.c
> > > index 22d0b3252476..5e4f887a074c 100644
> > > --- a/arch/arm64/kernel/probes/simulate-insn.c
> > > +++ b/arch/arm64/kernel/probes/simulate-insn.c
> > > @@ -200,3 +200,14 @@ simulate_ldrsw_literal(u32 opcode, long addr, st=
ruct pt_regs *regs)
> > >
> > >         instruction_pointer_set(regs, instruction_pointer(regs) + 4);
> > >  }
> > > +
> > > +void __kprobes
> > > +simulate_nop(u32 opcode, long addr, struct pt_regs *regs)
> > > +{
> > > +       /*
> > > +        * Compared to instruction_pointer_set(), it offers better
> > > +        * compatibility with single-stepping and execution in target
> > > +        * guarded memory.
> > > +        */
> > > +       arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
> > > +}
> > > diff --git a/arch/arm64/kernel/probes/simulate-insn.h b/arch/arm64/ke=
rnel/probes/simulate-insn.h
> > > index e065dc92218e..efb2803ec943 100644
> > > --- a/arch/arm64/kernel/probes/simulate-insn.h
> > > +++ b/arch/arm64/kernel/probes/simulate-insn.h
> > > @@ -16,5 +16,6 @@ void simulate_cbz_cbnz(u32 opcode, long addr, struc=
t pt_regs *regs);
> > >  void simulate_tbz_tbnz(u32 opcode, long addr, struct pt_regs *regs);
> > >  void simulate_ldr_literal(u32 opcode, long addr, struct pt_regs *reg=
s);
> > >  void simulate_ldrsw_literal(u32 opcode, long addr, struct pt_regs *r=
egs);
> > > +void simulate_nop(u32 opcode, long addr, struct pt_regs *regs);
> > >
> > >  #endif /* _ARM_KERNEL_KPROBES_SIMULATE_INSN_H */
> > > --
> > > 2.34.1
> > >

