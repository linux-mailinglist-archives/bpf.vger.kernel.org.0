Return-Path: <bpf+bounces-34424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0D992D864
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 20:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 956AEB217E8
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 18:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A73319644B;
	Wed, 10 Jul 2024 18:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrCgIUNG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7DE195803
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 18:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720636862; cv=none; b=sRYPKrsUHAcs+5Uk2ZGobeNuAjD9Jojfmqzrb5rTcZR2pKEEUBahRtIx6Z+IllScCTLeiioZ1nCNtgVhiYEWzo+60CS8G2GBjQhno+C8rH82NsKw1xT9eBFwCxF8SkAi55mqVFMY7v20+L/w70I4mVzkg+yrXbP+sSDtYnxM6SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720636862; c=relaxed/simple;
	bh=wLqPYzW2pBBV+oKcBJ+oU+XebIJJYxesDOoqfOP4Fm8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HeOMVvhO4kZa+KPyqWZMwjio28oeJXc7jJO0fAxjhp2IVLKlTjDBjs1Ljqctk0Dq/W3MdBRDuYYai2HkQboxasEtwzMdI72wVjlHShlojtBtHvhnBALnlRLC3IechqSrFObi972zm6YYg/ECt0AMd1E/yXkSdpiYG5zi04WT4YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrCgIUNG; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70af81e8439so129038b3a.0
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 11:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720636860; x=1721241660; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ANczVI3KSYUFvPh1e7RqT/SMcnsl4xdigmhSPJ5myzY=;
        b=YrCgIUNGWJ+P/UdyLpkLs6vV4syFuQC1OYstHLSrKFxXsq3GHA1w3qs1VFToFsNDnY
         SbIz4ZmXwZGcbZZ3k5ikfV0Ri4PZKqGTYltXlhCP6Zc2BE0p5ASFXBxMncDLJ/cALW92
         v1qon1ZQS0LqTYwvuSt0lzuq/wopKQvhbmKB6Q0RBCubfv+Szlea5ckL+99H3XxjDW1P
         SezTDgjDmaurpR2kSODwSTonmrALqhHBGggJaTxAiFikMUVyDOEEyPiCBLjwCsrL77PE
         WX/Y6xcfhm86OkDSbpJJvV2ISiHmhM+JAucEP4S9i0+oRlgE8t1bEiL3j0+DUPhu02Vb
         AATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720636860; x=1721241660;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ANczVI3KSYUFvPh1e7RqT/SMcnsl4xdigmhSPJ5myzY=;
        b=RCZOc2avKlPZfFd+apDmwt4rRetxy/6eHTm+6ufbbXtlrg67A1neSxTHq+ojDGUn0z
         24qlqKP8PARF/vi9xQ2F/K/Hspo3eTJwnbpPMaoeBDaH5oY18ptlYaV+S+6+lD/7XRZH
         tnLyL9ACXnHY1euzJw184QuBRfdoBMx8WkbhCciOpu2ORgoY0enrFReL7yF7gVu97QRO
         kHeVyENOtRlgTxvT7eqgsOq9+L0msHGhNWTQXyN81bWxiFQ39hZ2La0Uv/ZEjeuXS3QD
         hSO6mjdwZd/qZ82u5GoCs9LbLUbscJIBDHa/8LZFft3O6r3E4iOZj20D9rCVIcfG67mw
         uv0A==
X-Gm-Message-State: AOJu0Yz9EA6n9tIPEbark4mhc6dBQJq8eKVjsYgIf7QIjZ7JdgliqGNw
	FLZdYmtqttukYsaowcmyM9UHz74yvW2bwtasZMZr08MEJtnUeTF3
X-Google-Smtp-Source: AGHT+IHnU7kwxhUzExd7GtsBZbDDmDrE3ZlvjtELbrgDkI7qCL8FFK4xeGh91DWzzDBJvXqD9gIfHw==
X-Received: by 2002:a05:6a00:814:b0:70b:12:5241 with SMTP id d2e1a72fcca58-70b43544e6bmr7896967b3a.13.1720636859774;
        Wed, 10 Jul 2024 11:40:59 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438c2597sm4114473b3a.55.2024.07.10.11.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 11:40:59 -0700 (PDT)
Message-ID: <b21d3cc6f95dc4e1241c09a92a1ad45942ce53d0.camel@gmail.com>
Subject: Re: [RFC bpf-next v2 2/9] bpf: no_caller_saved_registers attribute
 for helper calls
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  puranjay@kernel.org, jose.marchesi@oracle.com,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 10 Jul 2024 11:40:53 -0700
In-Reply-To: <CAEf4BzZWMNWzk0V2HmG3MV693bNDoBo5ptFE6_fPsRXEH4E75A@mail.gmail.com>
References: <20240704102402.1644916-1-eddyz87@gmail.com>
	 <20240704102402.1644916-3-eddyz87@gmail.com>
	 <CAEf4BzaC--u8egj_JXrR4VoedeFdX3W=sKZt1aO9+ed44tQxWw@mail.gmail.com>
	 <7ec55e40e50fd432ba2c5d344c4927ed3a5ab953.camel@gmail.com>
	 <CAEf4BzY00fv1+13rZHb+5YHdXcwPzYjNDnN3Rq0-o+cwSB=JFw@mail.gmail.com>
	 <de4ed737e56fc6288031191509acc590446f4d24.camel@gmail.com>
	 <CAEf4BzajkXm0_8H3bA4RaYLvK19sz5OeQL0HFWgRGgKKERbrkA@mail.gmail.com>
	 <44bbdf47feb182fce4857e1b38fedb8fc95db3e7.camel@gmail.com>
	 <CAEf4BzZWMNWzk0V2HmG3MV693bNDoBo5ptFE6_fPsRXEH4E75A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-10 at 10:50 -0700, Andrii Nakryiko wrote:

[...]

> > > Ok, I see, this wasn't obvious that you want this behavior. I actuall=
y
> > > find it surprising (and so at least let's call this possibility out).
> > >=20
> > > But, tbh, I'd make this stricter. I'd dictate that within a subprogra=
m
> > > all no_csr patterns *should* end with the same stack offset and I
> > > would check for that (so what I mentioned before that instead of min
> > > or max we need assignment and check for equality if we already
> > > assigned it once).
> >=20
> > This makes sense, but does not cover a theoretical corner case:
> > - suppose there are two nocsr functions A and B on the kernel side,
> >   but only was A marked as nocsr during program compilation;
> > - the spill/fill "bracket" was generated for a call to function B by
> >   the compiler (because this is just a valid codegen).
>=20
> In this case the call to A shouldn't be changing nocsr_offset at all,
> though? You should find no spill/fill and thus even though A is
> *allowed* to use no_csr, it doesn't, so it should have no effect on
> nocsr offsets, no?

Consider the following code:

    *(u64 *)(r10 - 24) =3D r1;
    call A                     // kernel and clang know that A is nocsr
    r1 =3D *(u64 *)(r10 - 24);   // kernel assumes .nocsr_stack_offset -24
    ...
    *(u64 *)(r10 - 16) =3D r1;
    call B                     // only kernel knows that B is nocsr
    r1 =3D *(u64 *)(r10 - 16);   // with stricter logic this would disable
                               // nocsr for the whole sub-probram

> But your example actually made me think about another (not theoretical
> at all) case. What if we have calls to A and B, the kernel is slightly
> old and knows that B is nocsr, but A is not. But the BPF program was
> compiled with the latest helper/kfunc definitions marking A as no_csr
> eligible (as well as B). (btw, THAT'S THE WORD for allow_csr --
> ELIGIBLE. csr_eligible FTW! but I digress...)
>=20
> With the case above we'll disable nocsr for both A and B, right? That
> sucks, but not sure if we can do anything about that. (We can probably
> assume no_csr pattern and thus allow spill/fill and not disable nocsr
> in general, but not remove spill/fills... a bit more complication
> upfront for longer term extensibility.. not sure, maybe performance
> regression is a fine price, hmm)
>=20
> So I take it back about unmarking csr in the *entire BPF program*,
> let's just limit it to the subprog scope. But I still think we should
> do it eagerly, rather than double checking in do_misc_followups().
> WDYT?

With current algo this situation would disable nocsr indeed.
The problem is that checks for spilled stack slots usage is too simplistic.
However, it could be covered if the check is performed using e.g.
process I described earlier:
- for spill, remember the defining instruction in the stack slot structure;
- for fill, "merge" the defining instruction index;
- for other stack access mark defining instruction as escaping.

> > So I wanted to keep the nocsr check a little bit more permissive.
> >=20
> > > Also, instead of doing that extra nocsr offset check in
> > > do_misc_fixups(), why don't we just reset all no_csr patterns within =
a
> > > subprogram *if we find a single violation*. Compiler shouldn't ever
> > > emit such code, right? So let's be strict and fallback to not
> > > recognizing nocsr.
> > >=20
> > > And then we won't need that extra check in do_misc_fixups() because w=
e
> > > eagerly unset no_csr flag and will never hit that piece of logic in
> > > patching.
> >=20
> > I can do that, but the detector pass would have to be two pass:
> > - on the first pass, find the nocsr_stack_off, add candidate insn marks=
;
> > - on the second pass, remove marks from insns with wrong stack access o=
ffset.
>=20
> It's not really a second pass, it's part of normal validation.
> check_nocsr_stack_contract() will detect this and will do, yes, pass
> over all instructions of a subprogram to unmark them.

- on the first pass true .nocsr_stack_off is not yet known,
  so .nocsr_pattern is set optimistically;
- on the second pass .nocsr_stack_off is already known,
  so .nocsr_pattern can be removed from spills/fills outside the range;
- check_nocsr_stack_contract() does not need to scan full sub-program
  on each violation, it can set a flag disabling nocsr in subprogram info.

> > Otherwise I can't discern true patterns from false positives in
> > situation described above.
>=20
> See above, I might be missing what your "theoretical" example changes.
>=20
> >=20
> > > I'd go even further and say that on any nocsr invariant violation, we
> > > just go and reset all nocsr pattern flags across entire BPF program
> > > (all subprogs including). In check_nocsr_stack_contract() I mean. Jus=
t
> > > have a loop over all instructions and set that flag to false.
> > >=20
> > > Why not? What realistic application would need to violate nocsr in
> > > some subprogs but not in others?
> > >=20
> > > KISS or it's too simplistic for some reason?
> >=20
> > I can invalidate nocsr per-program.
> > If so, I would use an "allow_nocsr" flag in program aux to avoid
> > additional passes over instructions.
>=20
> yep, see above (but let's keep it per-subprog for now)

Ok

> > > > > > bpf_patch_insn_data() assumes that one instruction has to be re=
placed with many.
> > > > > > Here I need to replace many instructions with a single instruct=
ion.
> > > > > > I'd prefer not to tweak bpf_patch_insn_data() for this patch-se=
t.
> > > > >=20
> > > > > ah, bpf_patch_insn_data just does bpf_patch_insn_single, somehow =
I
> > > > > thought that it does range for range replacement of instructions.
> > > > > Never mind then (it's a bit sad that we don't have a proper flexi=
ble
> > > > > and powerful patching primitive, though, but oh well).
> > > >=20
> > > > That is true.
> > > > I'll think about it once other issues with this patch-set are resol=
ved.
> > >=20
> > > yeah, it's completely unrelated, but having a bpf_patch_insns that
> > > takes input instruction range to be replaced and replacing it with
> > > another set of instructions would cover all existing use cases and
> > > some more. We wouldn't need verifier_remove_insns(), because that's
> > > just replacing existing instructions with empty new set of
> > > instructions. We would now have "insert instructions" primitive if we
> > > specify empty input range of instructions. If we add a flag whether t=
o
> > > adjust jump offsets and make it configurable, we'd need the thing tha=
t
> > > Alexei needed for may_goto without any extra hacks.
> > >=20
> > > Furthermore, I find it wrong and silly that we keep having manual
> > > delta+insn adjustments in every single piece of patching logic. I
> > > think this should be done by bpf_patch_insns(). We need to have a
> > > small "insn_patcher" struct that we use during instruction patching,
> > > and a small instruction iterator on top that would keep returning nex=
t
> > > instruction to process (and its index, probably). This will allow us
> > > to optimize patching and instead of doing O(N) we can have something
> > > faster and smarter (if we hide direct insn array accesses during
> > > patching).
> > >=20
> > > But this is all a completely separate story from all of this.
> >=20
> > I actually suggested something along these lines very long time ago:
> > https://lore.kernel.org/bpf/5c297e5009bcd4f0becf59ccd97cfd82bb3a49ec.ca=
mel@gmail.com/
>=20
> We had a few discussions around patching improvements (you can see I
> mentioned that in that thread as well). We all like to talk about
> improving this, but not really doing anything about this. :) Tech debt
> at its best.

If you are not completely opposed to that idea I can follow-up with a
complete version as an RFC.

