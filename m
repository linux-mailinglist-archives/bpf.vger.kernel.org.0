Return-Path: <bpf+bounces-34416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A248492D7C1
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 19:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7A31F21AD7
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 17:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB5D19538D;
	Wed, 10 Jul 2024 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXlZwfyk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327E7848E
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720633843; cv=none; b=b+rBxdKJ1ki3J5WLqIiIqfvWt1G/6eQWOyeb1RGnLvbgVujIydQB86gkbcBydWsV3KWWGAKO4fjhbRGeTZDRbjYQMlj1f9UN7dAu1aa3wwzJjg/+m6ajnfaJ51qxAOzMiHOlZTaPxsIDBq3QNXwCS+DHGtZeQpzFz3vVdej8jBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720633843; c=relaxed/simple;
	bh=GbHAgGPo2AM3egpQpgQexn1NU2qmTQ+C4DIKbuj8rjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHmB3AzdFJ8EnOBNhnVydWuGY0hFSUB7HffnAIZlzOrld9Nn032F73QOXnsATd6VCgnNDOwgPVKu7+NNQtfbH9DurukNq07qoTi0Wua5aHZT2BPo36k0/7u9EvE5xmNpGByMrYQ99BigV1LCH/5wsTUpzMBtHyJdkaFHuUciWoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXlZwfyk; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c98b22638bso55778a91.1
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 10:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720633841; x=1721238641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOxLBYybWKvjQIwKTnEDRJC5irM/7441D+SxWA590lo=;
        b=VXlZwfyk1ho4T9GynankJ7a00mJFqFvTS28wxWnMgcjsOYyp3KQA3l2e4chB5YbZG5
         Z/T64/Qh/JfkhAGgC36FWHXPUs1UwaQlpC6eBhg1JJMjznr0gj6KwDZmwvs0HDiWTJzE
         r9BDYhoJp6Myf3yMKva4QbOCtzWT9S7EHFlOBnPnwRr4StVpOa3yXJMK3ZvoSZDQcsO9
         XMhGNhbSonA+k3Ds1bTAt9Irm1DclwyNX4zQmwPY4gmK7ER4EbyjYsLdr7a9qH82IWDR
         shj0+dpzsx3Ya5sjsx3O05KMRZHxO2L9lzljfXW47frRA2YHjVFOEQNd/tuXJWFrdW+l
         G3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720633841; x=1721238641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOxLBYybWKvjQIwKTnEDRJC5irM/7441D+SxWA590lo=;
        b=KlfKWc/XdZR2ZLYo7OnOeBXL8Ez98M8YaMr/GWBDULFz09HCewb+2SdWXplrkZaC8L
         Ua1gKtLtom7pk9+9OmlKQTxSVugFLhlorOX4PCiCYQG6HrNyLWpuGH4gscbnOHOeNLHZ
         JaXY4Yp631FiySTM7mCBh/GAdZweVic1MOPAUoYPlvF8A8sJaYE9/BetRODEGCFJJtdg
         GBNMyB/vgn7iD1C483yEqac8dfbRSTeX40qfHwmBaN0/BnXUh/StWLik/eA1TWQIpWx/
         8PYrC0OEMf4vkO/5hw5kCgkwQhJPrS/3JzxoBSkkOvxDMwiD25bZHaot5m6jhlArugiw
         t4vQ==
X-Gm-Message-State: AOJu0YxdY5Ag/zMx9uhelrfk0eJ5Pjoge3ej+dIQLWmtDMynPQaJNe10
	s2LMr1H+39fDqPVdgy7EHmzJ0SLBgxAHQcNn4gkJ6oYqLkmPglL6ojYibFQEhmg5pRzaXFqptzV
	XumVIereY8njjwBKzZ9qBG05qD9A=
X-Google-Smtp-Source: AGHT+IG5JNWdoOJVf/rOgSXyT7Xy0lp/WYu3Qf4FeAx81iflTS2hrOjWo+JaWhm3Hdm6tmRBzKMwd0IbR7bwv/EVlQg=
X-Received: by 2002:a17:90a:c698:b0:2c8:f3b5:7dd1 with SMTP id
 98e67ed59e1d1-2ca9ded1badmr485376a91.16.1720633841209; Wed, 10 Jul 2024
 10:50:41 -0700 (PDT)
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
 <CAEf4BzajkXm0_8H3bA4RaYLvK19sz5OeQL0HFWgRGgKKERbrkA@mail.gmail.com> <44bbdf47feb182fce4857e1b38fedb8fc95db3e7.camel@gmail.com>
In-Reply-To: <44bbdf47feb182fce4857e1b38fedb8fc95db3e7.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 Jul 2024 10:50:29 -0700
Message-ID: <CAEf4BzZWMNWzk0V2HmG3MV693bNDoBo5ptFE6_fPsRXEH4E75A@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 2/9] bpf: no_caller_saved_registers attribute
 for helper calls
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, puranjay@kernel.org, jose.marchesi@oracle.com, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 9:15=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2024-07-10 at 08:36 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > > I can rewrite it like below:
> > >
> > >                 if (stx->code !=3D (BPF_STX | BPF_MEM | BPF_DW) ||
> > >                     ldx->code !=3D (BPF_LDX | BPF_MEM | BPF_DW))
> >
> > I'd add stx->dst_reg !=3D BPF_REG_10 and ldx->src_reg !=3D BPF_REG_10
> > checks here and preserve original comments with instruction assembly
> > form.
> >
> > (think about this as establishing that we are looking at the correct
> > shapes of instructions)
> >
> > >                         break;
> > >                 off =3D off !=3D 0 ?: stx->off; // or use full 'if' b=
lock from the old version
> > >                 if (stx->dst_reg !=3D BPF_REG_10 ||
> > >                     ldx->src_reg !=3D BPF_REG_10 ||
> > >                     /* check spill/fill for the same reg and offset *=
/
> > >                     stx->src_reg !=3D ldx->dst_reg ||
> > >                     stx->off !=3D ldx->off ||
> > >                     stx->off !=3D off ||
> > >                     (off % BPF_REG_SIZE) !=3D 0 ||
> > >                     /* this should be a previously unseen register */
> > >                     (BIT(stx->src_reg) & reg_mask))
> >
> > and here we are checking all the correctness and additional imposed
> > semantical invariants knowing full well that we are dealing with
> > correct STX/LDX shapes
> >
> > >                         break;
> > >
> > > But I'm not sure this adds any actual clarity.
> >
> > I think it makes sense.
>
> Ok, will change.
>
> [...]
>
> > Ok, I see, this wasn't obvious that you want this behavior. I actually
> > find it surprising (and so at least let's call this possibility out).
> >
> > But, tbh, I'd make this stricter. I'd dictate that within a subprogram
> > all no_csr patterns *should* end with the same stack offset and I
> > would check for that (so what I mentioned before that instead of min
> > or max we need assignment and check for equality if we already
> > assigned it once).
>
> This makes sense, but does not cover a theoretical corner case:
> - suppose there are two nocsr functions A and B on the kernel side,
>   but only was A marked as nocsr during program compilation;
> - the spill/fill "bracket" was generated for a call to function B by
>   the compiler (because this is just a valid codegen).

In this case the call to A shouldn't be changing nocsr_offset at all,
though? You should find no spill/fill and thus even though A is
*allowed* to use no_csr, it doesn't, so it should have no effect on
nocsr offsets, no?

But your example actually made me think about another (not theoretical
at all) case. What if we have calls to A and B, the kernel is slightly
old and knows that B is nocsr, but A is not. But the BPF program was
compiled with the latest helper/kfunc definitions marking A as no_csr
eligible (as well as B). (btw, THAT'S THE WORD for allow_csr --
ELIGIBLE. csr_eligible FTW! but I digress...)

With the case above we'll disable nocsr for both A and B, right? That
sucks, but not sure if we can do anything about that. (We can probably
assume no_csr pattern and thus allow spill/fill and not disable nocsr
in general, but not remove spill/fills... a bit more complication
upfront for longer term extensibility.. not sure, maybe performance
regression is a fine price, hmm)

So I take it back about unmarking csr in the *entire BPF program*,
let's just limit it to the subprog scope. But I still think we should
do it eagerly, rather than double checking in do_misc_followups().
WDYT?

>
> So I wanted to keep the nocsr check a little bit more permissive.
>
> > Also, instead of doing that extra nocsr offset check in
> > do_misc_fixups(), why don't we just reset all no_csr patterns within a
> > subprogram *if we find a single violation*. Compiler shouldn't ever
> > emit such code, right? So let's be strict and fallback to not
> > recognizing nocsr.
> >
> > And then we won't need that extra check in do_misc_fixups() because we
> > eagerly unset no_csr flag and will never hit that piece of logic in
> > patching.
>
> I can do that, but the detector pass would have to be two pass:
> - on the first pass, find the nocsr_stack_off, add candidate insn marks;
> - on the second pass, remove marks from insns with wrong stack access off=
set.

It's not really a second pass, it's part of normal validation.
check_nocsr_stack_contract() will detect this and will do, yes, pass
over all instructions of a subprogram to unmark them.

>
> Otherwise I can't discern true patterns from false positives in
> situation described above.

See above, I might be missing what your "theoretical" example changes.

>
> > I'd go even further and say that on any nocsr invariant violation, we
> > just go and reset all nocsr pattern flags across entire BPF program
> > (all subprogs including). In check_nocsr_stack_contract() I mean. Just
> > have a loop over all instructions and set that flag to false.
> >
> > Why not? What realistic application would need to violate nocsr in
> > some subprogs but not in others?
> >
> > KISS or it's too simplistic for some reason?
>
> I can invalidate nocsr per-program.
> If so, I would use an "allow_nocsr" flag in program aux to avoid
> additional passes over instructions.

yep, see above (but let's keep it per-subprog for now)

>
> [...]
>
> > > > > bpf_patch_insn_data() assumes that one instruction has to be repl=
aced with many.
> > > > > Here I need to replace many instructions with a single instructio=
n.
> > > > > I'd prefer not to tweak bpf_patch_insn_data() for this patch-set.
> > > >
> > > > ah, bpf_patch_insn_data just does bpf_patch_insn_single, somehow I
> > > > thought that it does range for range replacement of instructions.
> > > > Never mind then (it's a bit sad that we don't have a proper flexibl=
e
> > > > and powerful patching primitive, though, but oh well).
> > >
> > > That is true.
> > > I'll think about it once other issues with this patch-set are resolve=
d.
> >
> > yeah, it's completely unrelated, but having a bpf_patch_insns that
> > takes input instruction range to be replaced and replacing it with
> > another set of instructions would cover all existing use cases and
> > some more. We wouldn't need verifier_remove_insns(), because that's
> > just replacing existing instructions with empty new set of
> > instructions. We would now have "insert instructions" primitive if we
> > specify empty input range of instructions. If we add a flag whether to
> > adjust jump offsets and make it configurable, we'd need the thing that
> > Alexei needed for may_goto without any extra hacks.
> >
> > Furthermore, I find it wrong and silly that we keep having manual
> > delta+insn adjustments in every single piece of patching logic. I
> > think this should be done by bpf_patch_insns(). We need to have a
> > small "insn_patcher" struct that we use during instruction patching,
> > and a small instruction iterator on top that would keep returning next
> > instruction to process (and its index, probably). This will allow us
> > to optimize patching and instead of doing O(N) we can have something
> > faster and smarter (if we hide direct insn array accesses during
> > patching).
> >
> > But this is all a completely separate story from all of this.
>
> I actually suggested something along these lines very long time ago:
> https://lore.kernel.org/bpf/5c297e5009bcd4f0becf59ccd97cfd82bb3a49ec.came=
l@gmail.com/

We had a few discussions around patching improvements (you can see I
mentioned that in that thread as well). We all like to talk about
improving this, but not really doing anything about this. :) Tech debt
at its best.

