Return-Path: <bpf+bounces-34443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACC392D89A
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 20:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B02D6B22599
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 18:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0A75028C;
	Wed, 10 Jul 2024 18:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xdeho7AG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CF83BBED
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 18:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720637390; cv=none; b=PYw1Sikbk6j1E72yPazR3BKFyxmozfdbwcUJvcortArWLy8md1L5ZsSaBQE3lpCU4WK5OX93ajC6CVeVjj58pRywp1qUEuwtSa2G13+Q4sI08bw7Jhvi/7+C5I2q7ZvXgJ+WpNY5Fbmiz2eb20RUeIiddNO4BIHkc/gP8fi5BJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720637390; c=relaxed/simple;
	bh=INPlAOB3Tmv23LWgkrLGQE/DSpZgiZ+V4UhdFA5r4x0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+MXhDLxWVFXFRU1HU6IRL9nctC7zFtAHjb9kFUDsN+1uC7oThnvyZhwv5NxiCotjRDE/NY82X078RKkp2Fa6zNo98eI0d6CuhAPophvFUu8g9CWA1oHV90r4kUGYpvoOAYSpweYtwpUdrAMox5ReTw+isDUXSmD6o4N0pblre8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xdeho7AG; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-75c3acf90f0so21627a12.2
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 11:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720637388; x=1721242188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cXMiUMx9oKuB8p3ZxeMnOTq59qG0VqewLpMI7681mM=;
        b=Xdeho7AGSmUrm7Os1jA34Sp1RJJoKrRM5ElsjBu/dpQhDoxOlLuKJ2qohasvJTDla2
         Kw26Gei05HSUQsdBWstvWPbFg0ZpNFfbINzROZOEkBaML+IDppyRRFyEhv/6Bt0ODjPK
         PtjQjlTmwqF1H/SFik+9htaQSKsKHF1Qys7By7oIeNa1486Qn8v+2yp5QGGwWcfRIr2u
         O7vUSz8oL4dM7AQEkpSF0P/P8gHIj4tSGEJruHUNNrUdjer92dwj3tTlTwSX+tUhOnlc
         RRZA4CQScODxo/250arG+rPCBUCTuj45T3H7M/M2Ui9XXsAPXyxmqyNc7jesvuifr7Y/
         1mEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720637388; x=1721242188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cXMiUMx9oKuB8p3ZxeMnOTq59qG0VqewLpMI7681mM=;
        b=XyGZfrhgfiTYZvXK337knJ59Bmh7h3cdLfVueTBT/2PPD0OR4xNXle5uEt1qYqNK0P
         2BNuZwTi+n7XNuCohV6lSd/Uk4fONeuyHQs5OzmRp2a1qyY4niee2A47vk2fLFXAgjzP
         L3z4NaX3MzmRgtJjpSd5yH4OsaXvWCQXnIj2X1wdMxzfllf8MWfXRUr/L8qTyn/I23Am
         1EF0nerzmwxMmDMTpq190kQSQj2q4mRAt+bB0BZcaHbwGkgTRakWOInopKK6KsTZZfYO
         N+0lkQm1T2lkCiFzF/gHnFcIDfcwQwODY66rs+bFu7u1mD+OwQmOEl9AzsjquhocN3Si
         e7Mg==
X-Gm-Message-State: AOJu0YwEbiwpb1Lr624wZr86m+0cAw0IEX+8sQ0eLVezXT9NwI+BxRdY
	HW/0s0HeNbYiUZmTFR68q1tYXhd6PuMW+sK8qDGUq7Tei5S5OQuDu7ABxAwz/1V80k+khjXx7H7
	PbhrUQ1Lps1d1yHzDeJDHICrQhH0=
X-Google-Smtp-Source: AGHT+IElaQLd/tHxF3+JPR9dUjB9m7BdNROAY1/iTLrBBRVzzN84J50Ly7dytyYigdUoF18izOtd2/r1IQ7lAedb6FU=
X-Received: by 2002:a05:6a20:8b84:b0:1c3:b26d:82ad with SMTP id
 adf61e73a8af0-1c3b26d83femr342619637.3.1720637388218; Wed, 10 Jul 2024
 11:49:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704102402.1644916-1-eddyz87@gmail.com> <20240704102402.1644916-3-eddyz87@gmail.com>
 <CAEf4BzaC--u8egj_JXrR4VoedeFdX3W=sKZt1aO9+ed44tQxWw@mail.gmail.com>
 <7ec55e40e50fd432ba2c5d344c4927ed3a5ab953.camel@gmail.com>
 <CAEf4BzY00fv1+13rZHb+5YHdXcwPzYjNDnN3Rq0-o+cwSB=JFw@mail.gmail.com>
 <de4ed737e56fc6288031191509acc590446f4d24.camel@gmail.com>
 <CAEf4BzajkXm0_8H3bA4RaYLvK19sz5OeQL0HFWgRGgKKERbrkA@mail.gmail.com>
 <44bbdf47feb182fce4857e1b38fedb8fc95db3e7.camel@gmail.com>
 <CAEf4BzZWMNWzk0V2HmG3MV693bNDoBo5ptFE6_fPsRXEH4E75A@mail.gmail.com> <b21d3cc6f95dc4e1241c09a92a1ad45942ce53d0.camel@gmail.com>
In-Reply-To: <b21d3cc6f95dc4e1241c09a92a1ad45942ce53d0.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 Jul 2024 11:49:35 -0700
Message-ID: <CAEf4BzZD=1KmBi-t=qPcfFU=BrH0qDkLgjbBjNCohhBv2vc1EA@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 2/9] bpf: no_caller_saved_registers attribute
 for helper calls
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, puranjay@kernel.org, jose.marchesi@oracle.com, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 11:41=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Wed, 2024-07-10 at 10:50 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > > > Ok, I see, this wasn't obvious that you want this behavior. I actua=
lly
> > > > find it surprising (and so at least let's call this possibility out=
).
> > > >
> > > > But, tbh, I'd make this stricter. I'd dictate that within a subprog=
ram
> > > > all no_csr patterns *should* end with the same stack offset and I
> > > > would check for that (so what I mentioned before that instead of mi=
n
> > > > or max we need assignment and check for equality if we already
> > > > assigned it once).
> > >
> > > This makes sense, but does not cover a theoretical corner case:
> > > - suppose there are two nocsr functions A and B on the kernel side,
> > >   but only was A marked as nocsr during program compilation;
> > > - the spill/fill "bracket" was generated for a call to function B by
> > >   the compiler (because this is just a valid codegen).
> >
> > In this case the call to A shouldn't be changing nocsr_offset at all,
> > though? You should find no spill/fill and thus even though A is
> > *allowed* to use no_csr, it doesn't, so it should have no effect on
> > nocsr offsets, no?
>
> Consider the following code:
>
>     *(u64 *)(r10 - 24) =3D r1;
>     call A                     // kernel and clang know that A is nocsr
>     r1 =3D *(u64 *)(r10 - 24);   // kernel assumes .nocsr_stack_offset -2=
4
>     ...
>     *(u64 *)(r10 - 16) =3D r1;
>     call B                     // only kernel knows that B is nocsr
>     r1 =3D *(u64 *)(r10 - 16);   // with stricter logic this would disabl=
e
>                                // nocsr for the whole sub-probram

oh, you mean that r10-16 accesses are valid instructions emitted by
the compiler but not due to nocsr? I mean, tough luck?... We shouldn't
reject this, but nocsr is ultimately a performance optimization, so
not critical if it doesn't work within some subprogram.

>
> > But your example actually made me think about another (not theoretical
> > at all) case. What if we have calls to A and B, the kernel is slightly
> > old and knows that B is nocsr, but A is not. But the BPF program was
> > compiled with the latest helper/kfunc definitions marking A as no_csr
> > eligible (as well as B). (btw, THAT'S THE WORD for allow_csr --
> > ELIGIBLE. csr_eligible FTW! but I digress...)
> >
> > With the case above we'll disable nocsr for both A and B, right? That
> > sucks, but not sure if we can do anything about that. (We can probably
> > assume no_csr pattern and thus allow spill/fill and not disable nocsr
> > in general, but not remove spill/fills... a bit more complication
> > upfront for longer term extensibility.. not sure, maybe performance
> > regression is a fine price, hmm)
> >
> > So I take it back about unmarking csr in the *entire BPF program*,
> > let's just limit it to the subprog scope. But I still think we should
> > do it eagerly, rather than double checking in do_misc_followups().
> > WDYT?
>
> With current algo this situation would disable nocsr indeed.
> The problem is that checks for spilled stack slots usage is too simplisti=
c.
> However, it could be covered if the check is performed using e.g.
> process I described earlier:
> - for spill, remember the defining instruction in the stack slot structur=
e;
> - for fill, "merge" the defining instruction index;
> - for other stack access mark defining instruction as escaping.

Sorry, I have no idea what the above means and implies. "defining
instruction", "merge", "escaping"

As I mentioned above, I'd keep it as simple as reasonably possible.

>
> > > So I wanted to keep the nocsr check a little bit more permissive.
> > >
> > > > Also, instead of doing that extra nocsr offset check in
> > > > do_misc_fixups(), why don't we just reset all no_csr patterns withi=
n a
> > > > subprogram *if we find a single violation*. Compiler shouldn't ever
> > > > emit such code, right? So let's be strict and fallback to not
> > > > recognizing nocsr.
> > > >
> > > > And then we won't need that extra check in do_misc_fixups() because=
 we
> > > > eagerly unset no_csr flag and will never hit that piece of logic in
> > > > patching.
> > >
> > > I can do that, but the detector pass would have to be two pass:
> > > - on the first pass, find the nocsr_stack_off, add candidate insn mar=
ks;
> > > - on the second pass, remove marks from insns with wrong stack access=
 offset.
> >
> > It's not really a second pass, it's part of normal validation.
> > check_nocsr_stack_contract() will detect this and will do, yes, pass
> > over all instructions of a subprogram to unmark them.
>
> - on the first pass true .nocsr_stack_off is not yet known,
>   so .nocsr_pattern is set optimistically;
> - on the second pass .nocsr_stack_off is already known,
>   so .nocsr_pattern can be removed from spills/fills outside the range;
> - check_nocsr_stack_contract() does not need to scan full sub-program
>   on each violation, it can set a flag disabling nocsr in subprogram info=
.

I'm not even sure anymore if we are agreeing or disagreeing, let's
just look at the next revision or something, I'm getting lost.

I was saying that as soon as check_nocsr_stack_contract() detects that
contract is breached, we eagerly set nocsr_pattern and
nocsr_spills_num to 0 for all instructions within the current subprog
and setting nocsr_stack_off for subprog info to 0 (there is no more
csr). There will be no other violations after that within that
subprog. Maybe that's what you mean as well and I just can't read.

>
> > > Otherwise I can't discern true patterns from false positives in
> > > situation described above.
> >
> > See above, I might be missing what your "theoretical" example changes.
> >
> > >
> > > > I'd go even further and say that on any nocsr invariant violation, =
we
> > > > just go and reset all nocsr pattern flags across entire BPF program
> > > > (all subprogs including). In check_nocsr_stack_contract() I mean. J=
ust
> > > > have a loop over all instructions and set that flag to false.
> > > >
> > > > Why not? What realistic application would need to violate nocsr in
> > > > some subprogs but not in others?
> > > >
> > > > KISS or it's too simplistic for some reason?
> > >
> > > I can invalidate nocsr per-program.
> > > If so, I would use an "allow_nocsr" flag in program aux to avoid
> > > additional passes over instructions.
> >
> > yep, see above (but let's keep it per-subprog for now)
>
> Ok
>
> > > > > > > bpf_patch_insn_data() assumes that one instruction has to be =
replaced with many.
> > > > > > > Here I need to replace many instructions with a single instru=
ction.
> > > > > > > I'd prefer not to tweak bpf_patch_insn_data() for this patch-=
set.
> > > > > >
> > > > > > ah, bpf_patch_insn_data just does bpf_patch_insn_single, someho=
w I
> > > > > > thought that it does range for range replacement of instruction=
s.
> > > > > > Never mind then (it's a bit sad that we don't have a proper fle=
xible
> > > > > > and powerful patching primitive, though, but oh well).
> > > > >
> > > > > That is true.
> > > > > I'll think about it once other issues with this patch-set are res=
olved.
> > > >
> > > > yeah, it's completely unrelated, but having a bpf_patch_insns that
> > > > takes input instruction range to be replaced and replacing it with
> > > > another set of instructions would cover all existing use cases and
> > > > some more. We wouldn't need verifier_remove_insns(), because that's
> > > > just replacing existing instructions with empty new set of
> > > > instructions. We would now have "insert instructions" primitive if =
we
> > > > specify empty input range of instructions. If we add a flag whether=
 to
> > > > adjust jump offsets and make it configurable, we'd need the thing t=
hat
> > > > Alexei needed for may_goto without any extra hacks.
> > > >
> > > > Furthermore, I find it wrong and silly that we keep having manual
> > > > delta+insn adjustments in every single piece of patching logic. I
> > > > think this should be done by bpf_patch_insns(). We need to have a
> > > > small "insn_patcher" struct that we use during instruction patching=
,
> > > > and a small instruction iterator on top that would keep returning n=
ext
> > > > instruction to process (and its index, probably). This will allow u=
s
> > > > to optimize patching and instead of doing O(N) we can have somethin=
g
> > > > faster and smarter (if we hide direct insn array accesses during
> > > > patching).
> > > >
> > > > But this is all a completely separate story from all of this.
> > >
> > > I actually suggested something along these lines very long time ago:
> > > https://lore.kernel.org/bpf/5c297e5009bcd4f0becf59ccd97cfd82bb3a49ec.=
camel@gmail.com/
> >
> > We had a few discussions around patching improvements (you can see I
> > mentioned that in that thread as well). We all like to talk about
> > improving this, but not really doing anything about this. :) Tech debt
> > at its best.
>
> If you are not completely opposed to that idea I can follow-up with a
> complete version as an RFC.

let's do one thing at a time, there is plenty to review for nocsr
without having to switch to patching.

