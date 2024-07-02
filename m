Return-Path: <bpf+bounces-33673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 930F99249C3
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 23:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74F01C22D65
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 21:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EAF201264;
	Tue,  2 Jul 2024 21:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxyWvzP5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEE61BA87F
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 21:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719954588; cv=none; b=dPoaQC3ZxD26gNOX9Zz/GQeFlrzYhyr142YAcbu9HS+WH6JaLJCybaDbUlKYIdKKAyd8tMmIfiKmX0ftF7+yrDgBVR0bBf45H47E0QIn3y4qOwoAv86DcYUPnHFPQ5SROs9aYGT3qljl086seVHsLiHxdmhBOam1KZFRQ/rqmzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719954588; c=relaxed/simple;
	bh=scke65GQZ4/LYvyaNsQ3JiGjKX8WWnxdtmvxR8sguKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kMXh+03bymqfk1SP6lWygzhKmvM2Erz7hxlL7MMPnhfa8O+9BwP6ifYvVGy2XJkP6+kfbEekQuNUwdauh5jUE4LPMEMFM66m2DCK8gNovUvLV/Ggsn0a0kiuYYVJBY9ilHP12wYGlpPpynM91tS/2fS0+Qu/oFpI5m1Rs0UW5x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxyWvzP5; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7066cba4ebbso3294423b3a.3
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2024 14:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719954586; x=1720559386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Z1HT/n3xR8H46DLhLTMY6AW7P2mBstcvd/NbPOCsQg=;
        b=fxyWvzP55yRp6UDMJa1b3WaTqHtPN2g+bDsHBfN01uyAkU2Nfh+W+k48cC1vx8cwrn
         Kz0v40KIhGezZJp5vlwLnlYTy3nSPlx9k0RS6J1DDGgv3pfrBsAsDC7NpVbblEDSmioo
         W5bFOm0bEy0B0GjvDZE9q3RBWOX+eVg1M3xLzFjpyAmGavCk/dKnhEx1kkplIAhHEMYF
         P1i/z/Ru/GyPEflYCviAsL+JpotsbxaXkquyKLzh/UIFxBPUXCvzuUmiNZ1q2sNAxW05
         jWY6OWzWmvNGGEEIKygAW/thaBOdrfEmsAO0KmfJaUxPC/V1svKO7HmMJKCeV6if8Vta
         vlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719954586; x=1720559386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Z1HT/n3xR8H46DLhLTMY6AW7P2mBstcvd/NbPOCsQg=;
        b=FIm1lTSW17ObjkeDDTli+SGoXZnUfkvMBH3Ri/PgNXAZ9NtGqHXw3yOtO5C1vFIMWi
         Tsw9zpPlVZmmHPj57T2m46BkKQVGC7h94/2lJrPFY3sWaRwAS8I6HTBLapXsaQu7Fplc
         rV8ptpg1zHk3TdjtKW9Vs9aV7StDl2qruhmOKdR81pIuiPAU095g33Q7RkVRZYSmrKAQ
         lvuu/6FsBJS5+C8y4aXeh+TWRWVpT7dK89ACpwv928yjIGr09daFO5RpsPTM8+lVVDEt
         Kg6DVRJRBjDCl/KWuA1lZMdMaSx8Iqhtyt2SQnQrvWe5nje1pRLIB5VuSc+L3DPe5zJD
         CvVA==
X-Gm-Message-State: AOJu0Ywv/mteOI8ZJU17i4oLWQP5i5YJufkP19JuAAiBw6pLUmqVm3VI
	dPjACTUXJUQiDkSMep1knrID/uadtEswQS8O1iBHcG7dImDty6HXXAsuUz8cTyvYk+l8mqZxSJt
	Sc9KqcpNwLKyw7+IJ3nJh56XUaPY=
X-Google-Smtp-Source: AGHT+IFvlzWy4nFaV0Liy447N4djQEckxWbn6kq2d/JikN+zxgpSvCq7CoVrZ9Q8G+QCBuGbwbWelvR47oZZVM1btnU=
X-Received: by 2002:a05:6a00:892:b0:704:14b9:105 with SMTP id
 d2e1a72fcca58-70aaad359f9mr9018846b3a.13.1719954585728; Tue, 02 Jul 2024
 14:09:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629094733.3863850-1-eddyz87@gmail.com> <20240629094733.3863850-3-eddyz87@gmail.com>
 <CAEf4Bzb5JoeVAwO6krQPUWHyUad0ya5ivXWukfb+_wrWrs7H5Q@mail.gmail.com> <806fe5b0940a8b3e60a9c5448ec213b23107e3f0.camel@gmail.com>
In-Reply-To: <806fe5b0940a8b3e60a9c5448ec213b23107e3f0.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 14:09:33 -0700
Message-ID: <CAEf4BzZPyZ=HWDeYXwjS1q5C0pcKmtQ5_pt=hQN9P0W+Tb+L3A@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 2/8] bpf: no_caller_saved_registers attribute
 for helper calls
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, jose.marchesi@oracle.com, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 1:38=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2024-07-01 at 17:41 -0700, Andrii Nakryiko wrote:
>
> [...]
>

[...]

> > > +static bool verifier_inlines_helper_call(struct bpf_verifier_env *en=
v, s32 imm)
> > > +{
> >
> > note that there is now also bpf_jit_inlines_helper_call()
>
> There is.
> I'd like authors of jit inline patches to explicitly opt-in
> for nocsr, vouching that inline patch follows nocsr contract.
> The idea is that people would extend call_csr_mask() as necessary.
>

you are defining a general framework with these changes, though, so
let's introduce a standard and simple way to do this. Say, in addition
to having arch-specific bpf_jit_inlines_helper_call() we can have
bpf_jit_supports_helper_nocsr() or something. And they should be
defined next to each other, so whenever one changes it's easier to
remember to change the other one.

I don't think requiring arm64 contributors to change the code of
call_csr_mask() is the right approach.

> >
> >
> > > +       return false;
> > > +}
> > > +
> > > +/* If 'insn' is a call that follows no_caller_saved_registers contra=
ct
> > > + * and called function is inlined by current jit, return a mask with
> > > + * 1s corresponding to registers that are scratched by this call
> > > + * (depends on return type and number of return parameters).
> > > + * Otherwise return ALL_CALLER_SAVED_REGS mask.
> > > + */
> > > +static u32 call_csr_mask(struct bpf_verifier_env *env, struct bpf_in=
sn *insn)
> > > +{
> > > +       const struct bpf_func_proto *fn;
> > > +
> > > +       if (bpf_helper_call(insn) &&
> > > +           verifier_inlines_helper_call(env, insn->imm) &&
> >
> > strictly speaking, does nocsr have anything to do with inlining,
> > though? E.g., if we know for sure (however, that's a separate issue)
> > that helper implementation doesn't touch extra registers, why do we
> > need inlining to make use of nocsr?
>
> Technically, alternative for nocsr is for C version of the
> helper/kfunc itself has no_caller_saved_registers attribute.
> Grep shows a single function annotated as such in kernel tree:
> stackleak_track_stack().
> Or, maybe, for helpers/kfuncs implemented in assembly.

Yes, I suppose it's too dangerous to rely on the compiler to not use
some extra register. I guess worst case we can "inline" helper by
keeping call to it intact :)

> Whenever such helpers/kfuncs are added, this function could be extended.
>
> >
> > > +           get_helper_proto(env, insn->imm, &fn) =3D=3D 0 &&
> > > +           fn->nocsr)
> > > +               return ~get_helper_reg_mask(fn);
> > > +
> > > +       return ALL_CALLER_SAVED_REGS;
> > > +}
> > > +
>
> [...]
>

[...]

> > > +       if (i =3D=3D 1)
> > > +               return 0;
> > > +       if (mark) {
> > > +               s =3D find_containing_subprog(env, t);
> > > +               /* can't happen */
> > > +               if (WARN_ON_ONCE(s < 0))
> > > +                       return 0;
> > > +               subprog =3D &env->subprog_info[s];
> > > +               subprog->nocsr_stack_off =3D min(subprog->nocsr_stack=
_off, off);
> > > +       }
> >
> > why not split pattern detection and all this other marking logic? You
> > can return "the size of csr pattern", meaning how many spills/fills
> > are there surrounding the call, no? Then all the marking can be done
> > (if necessary) by the caller.
>
> I'll try recording pattern size for function call,
> so no split would be necessary.
>

ack

> > The question is what to do with zero patter (no spills/fills for nocsr
> > call, is that valid case?)
>
> Zero pattern -- no spills/fills to remove, so nothing to do.
> I will add a test case, but it should be handled by current implementatio=
n fine.

yep, thanks

>
> [...]
>
> > > +/* Remove unnecessary spill/fill pairs, members of nocsr pattern.
> > > + * Do this as a separate pass to avoid interfering with helper/kfunc
> > > + * inlining logic in do_misc_fixups().
> > > + * See comment for match_and_mark_nocsr_pattern().
> > > + */
> > > +static int remove_nocsr_spills_fills(struct bpf_verifier_env *env)
> > > +{
> > > +       struct bpf_subprog_info *subprogs =3D env->subprog_info;
> > > +       int i, j, spills_num, cur_subprog =3D 0;
> > > +       struct bpf_insn *insn =3D env->prog->insnsi;
> > > +       int insn_cnt =3D env->prog->len;
> > > +
> > > +       for (i =3D 0; i < insn_cnt; i++, insn++) {
> > > +               spills_num =3D match_nocsr_pattern(env, i);
> >
> > we can probably afford a single-byte field somewhere in
> > bpf_insn_aux_data to remember "csr pattern size" instead of just a
> > true/false fact that it is nocsr call. And so we wouldn't need to do
> > pattern matching again here, we'll just have all the data.
>
> Makes sense.
>
> [...]

