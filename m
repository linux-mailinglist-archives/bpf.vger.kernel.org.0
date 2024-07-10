Return-Path: <bpf+bounces-34409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E00192D613
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 18:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC944289F9B
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 16:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C051974F4;
	Wed, 10 Jul 2024 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdjI4P5z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A44E18EFF9
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628109; cv=none; b=Ooq5JsvCEBBpv2B3FHCgSECir9Jic26m3L4BvEarnCeaZR8VP2NRJlwhyydo1b+Ly6kTZED076TIYUQL+/39zaT6pBGMykfSglc52Rft9k5ADMyUQPg4ZZC4dqLs+ij7+SX+KXkp4v80nTPUBLw0/wTmky+lpqmO58BaxH2Zfk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628109; c=relaxed/simple;
	bh=FaDgrumQQ702EYKlMfrF234zKlRq+jMH9PK+mcDQRk4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ef77oG43qZWdv5Mvhte+FzbC3T2YnrCYAzo0Ab69eCK1haOuqiT7fCXIYXySkJOiaQd4tuAUlP7nVLFp8dLwNvVQdNE/wuFPciUj+H079PwGyzac6pfb89gFVQsqN6PNJ3cW9RXmwUiK5LH2HMelmqEulbxRUx7vryUmtac98dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdjI4P5z; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70b09cb7776so3840528b3a.1
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 09:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720628106; x=1721232906; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gvbCHzeqhYF9dVLpfQvgA04riNrEwLCImkbgcpZ+jGg=;
        b=DdjI4P5zm5cBvviLZQO0Jz052XLd42hLHMfkq3kxpvvKyUALnnIQitEQW6qwADjfK0
         1pRXCCk2BM0jrN43iaNMyWtMWWYn/iFpxUSiBoS6LUlRMbG9EtS59Aj8YxaQDFGL/i3n
         0IaWQ8CIsoVnM83a9O3Ear7n0mwuAHeJwSFAK6NkSPkK0mvFohhnXRkJ+8YSlosv/FwQ
         KbYgjhvf6pjE512ZmRVdL4XlS4TaTlqXpweFXit3ZcgpRMg3Wjy8cy4DsuZKkVKIjYio
         h9z3IedSjRJvk/vqy3r/g7pWgizc9Bk+rSEUhWLEd8OLwmT0uOhL87jm0f9pUm6bRbo2
         IKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720628106; x=1721232906;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gvbCHzeqhYF9dVLpfQvgA04riNrEwLCImkbgcpZ+jGg=;
        b=b4zp8bkdQOcwsI8PUts9W3UXEvQsvqgECAN/p6gec0YAWeoI+fTjWkP6MkfIMYMRTn
         jURSqh91fkJX781CF+ycnVvkym9SwTfeG4BPyf91k5Ne/+hsK9fyT2EN95fb31U+ZODT
         YGfdiR2PvIm5gnX/9jB2ZVeq2YsWtjkrAbXoKFCpsC4b5yL4blNe+xGH7FqPks8DUOgx
         8k6gWLT35S0dT5AbovM2aFxI+l5HfERs4jnwfvksJfEaOMveuTRmXTcTJRWbob0+UNA1
         I17OVojY4CQHAZfvLCde0FpUl5S3nKSSk1gsH5azLYMLPTBuoJFsrao8R7QcjIXTFV4r
         TbwQ==
X-Gm-Message-State: AOJu0YyqKQZA5MFNDxZumdEfUUTuqiB44+8VljJSo4QKDqr9yedZILc9
	LRHRv41Zl8ExdPkUyofySET2JeLAajR9KrrbbenyKKU4wh3AElsW
X-Google-Smtp-Source: AGHT+IEYrpgUJ4xjMPgDITYJsMxnE+6bJLL7A/P2l49+gtm9XXE09562JT1U+OKefftfkb82IxVjKQ==
X-Received: by 2002:a05:6a20:8402:b0:1bd:25a6:842f with SMTP id adf61e73a8af0-1c2984c8784mr6954902637.41.1720628106046;
        Wed, 10 Jul 2024 09:15:06 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967496sm3974718b3a.121.2024.07.10.09.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 09:15:05 -0700 (PDT)
Message-ID: <44bbdf47feb182fce4857e1b38fedb8fc95db3e7.camel@gmail.com>
Subject: Re: [RFC bpf-next v2 2/9] bpf: no_caller_saved_registers attribute
 for helper calls
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  puranjay@kernel.org, jose.marchesi@oracle.com,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 10 Jul 2024 09:15:00 -0700
In-Reply-To: <CAEf4BzajkXm0_8H3bA4RaYLvK19sz5OeQL0HFWgRGgKKERbrkA@mail.gmail.com>
References: <20240704102402.1644916-1-eddyz87@gmail.com>
	 <20240704102402.1644916-3-eddyz87@gmail.com>
	 <CAEf4BzaC--u8egj_JXrR4VoedeFdX3W=sKZt1aO9+ed44tQxWw@mail.gmail.com>
	 <7ec55e40e50fd432ba2c5d344c4927ed3a5ab953.camel@gmail.com>
	 <CAEf4BzY00fv1+13rZHb+5YHdXcwPzYjNDnN3Rq0-o+cwSB=JFw@mail.gmail.com>
	 <de4ed737e56fc6288031191509acc590446f4d24.camel@gmail.com>
	 <CAEf4BzajkXm0_8H3bA4RaYLvK19sz5OeQL0HFWgRGgKKERbrkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-10 at 08:36 -0700, Andrii Nakryiko wrote:

[...]

> > I can rewrite it like below:
> >=20
> >                 if (stx->code !=3D (BPF_STX | BPF_MEM | BPF_DW) ||
> >                     ldx->code !=3D (BPF_LDX | BPF_MEM | BPF_DW))
>=20
> I'd add stx->dst_reg !=3D BPF_REG_10 and ldx->src_reg !=3D BPF_REG_10
> checks here and preserve original comments with instruction assembly
> form.
>=20
> (think about this as establishing that we are looking at the correct
> shapes of instructions)
>=20
> >                         break;
> >                 off =3D off !=3D 0 ?: stx->off; // or use full 'if' blo=
ck from the old version
> >                 if (stx->dst_reg !=3D BPF_REG_10 ||
> >                     ldx->src_reg !=3D BPF_REG_10 ||
> >                     /* check spill/fill for the same reg and offset */
> >                     stx->src_reg !=3D ldx->dst_reg ||
> >                     stx->off !=3D ldx->off ||
> >                     stx->off !=3D off ||
> >                     (off % BPF_REG_SIZE) !=3D 0 ||
> >                     /* this should be a previously unseen register */
> >                     (BIT(stx->src_reg) & reg_mask))
>=20
> and here we are checking all the correctness and additional imposed
> semantical invariants knowing full well that we are dealing with
> correct STX/LDX shapes
>=20
> >                         break;
> >=20
> > But I'm not sure this adds any actual clarity.
>=20
> I think it makes sense.

Ok, will change.

[...]

> Ok, I see, this wasn't obvious that you want this behavior. I actually
> find it surprising (and so at least let's call this possibility out).
>=20
> But, tbh, I'd make this stricter. I'd dictate that within a subprogram
> all no_csr patterns *should* end with the same stack offset and I
> would check for that (so what I mentioned before that instead of min
> or max we need assignment and check for equality if we already
> assigned it once).

This makes sense, but does not cover a theoretical corner case:
- suppose there are two nocsr functions A and B on the kernel side,
  but only was A marked as nocsr during program compilation;
- the spill/fill "bracket" was generated for a call to function B by
  the compiler (because this is just a valid codegen).

So I wanted to keep the nocsr check a little bit more permissive.

> Also, instead of doing that extra nocsr offset check in
> do_misc_fixups(), why don't we just reset all no_csr patterns within a
> subprogram *if we find a single violation*. Compiler shouldn't ever
> emit such code, right? So let's be strict and fallback to not
> recognizing nocsr.
>=20
> And then we won't need that extra check in do_misc_fixups() because we
> eagerly unset no_csr flag and will never hit that piece of logic in
> patching.

I can do that, but the detector pass would have to be two pass:
- on the first pass, find the nocsr_stack_off, add candidate insn marks;
- on the second pass, remove marks from insns with wrong stack access offse=
t.

Otherwise I can't discern true patterns from false positives in
situation described above.

> I'd go even further and say that on any nocsr invariant violation, we
> just go and reset all nocsr pattern flags across entire BPF program
> (all subprogs including). In check_nocsr_stack_contract() I mean. Just
> have a loop over all instructions and set that flag to false.
>=20
> Why not? What realistic application would need to violate nocsr in
> some subprogs but not in others?
>=20
> KISS or it's too simplistic for some reason?

I can invalidate nocsr per-program.
If so, I would use an "allow_nocsr" flag in program aux to avoid
additional passes over instructions.

[...]

> > > > bpf_patch_insn_data() assumes that one instruction has to be replac=
ed with many.
> > > > Here I need to replace many instructions with a single instruction.
> > > > I'd prefer not to tweak bpf_patch_insn_data() for this patch-set.
> > >=20
> > > ah, bpf_patch_insn_data just does bpf_patch_insn_single, somehow I
> > > thought that it does range for range replacement of instructions.
> > > Never mind then (it's a bit sad that we don't have a proper flexible
> > > and powerful patching primitive, though, but oh well).
> >=20
> > That is true.
> > I'll think about it once other issues with this patch-set are resolved.
>=20
> yeah, it's completely unrelated, but having a bpf_patch_insns that
> takes input instruction range to be replaced and replacing it with
> another set of instructions would cover all existing use cases and
> some more. We wouldn't need verifier_remove_insns(), because that's
> just replacing existing instructions with empty new set of
> instructions. We would now have "insert instructions" primitive if we
> specify empty input range of instructions. If we add a flag whether to
> adjust jump offsets and make it configurable, we'd need the thing that
> Alexei needed for may_goto without any extra hacks.
>=20
> Furthermore, I find it wrong and silly that we keep having manual
> delta+insn adjustments in every single piece of patching logic. I
> think this should be done by bpf_patch_insns(). We need to have a
> small "insn_patcher" struct that we use during instruction patching,
> and a small instruction iterator on top that would keep returning next
> instruction to process (and its index, probably). This will allow us
> to optimize patching and instead of doing O(N) we can have something
> faster and smarter (if we hide direct insn array accesses during
> patching).
>=20
> But this is all a completely separate story from all of this.

I actually suggested something along these lines very long time ago:
https://lore.kernel.org/bpf/5c297e5009bcd4f0becf59ccd97cfd82bb3a49ec.camel@=
gmail.com/

