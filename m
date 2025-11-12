Return-Path: <bpf+bounces-74261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB22C501A4
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 01:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06394189736C
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 00:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44231290F;
	Wed, 12 Nov 2025 00:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lp0o7r+B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B9335CBC4
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 00:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762905683; cv=none; b=K5rz9SK8GZ5AzdF8b2Kb1B8EOcG+ljCdVj1C5xYBG6n5+7P0loquw4Hgx/5V3LlzcJMAyS/Y6eqn2cmnHl2SAP2pDyufvxuWK6mTm5gTCcEMEtrIUgFqoRJjqmgzln+oLttV9lSLk4fgzO3r37hms8cHpCIajvSLw7WPf9Enhc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762905683; c=relaxed/simple;
	bh=CXZjKfAzksLGZaLX9G+mjGAL8cWkdLyNmA6onnJtDH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJTES6W+agwF8XwqfSwhcb8WvCcM399KgIFC3ICHq0CCnVFQ/cmL7Y/ePy55SJGBC1HM4rFSSzYxMF6nRalEfpez+8CH5rWexvyYAMnR45xQv4hYadEGKjqouSmDY74xZo28VlIl6Wks3jdGyOYZ8NwPgzJwJVe9T+ip2UYedx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lp0o7r+B; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64074f01a6eso362642a12.2
        for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 16:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762905680; x=1763510480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1c65TA/qlfWizahDeIPj92hA2Tnvs0ON89Itog2UtY=;
        b=lp0o7r+BJFNYRXJdz1kWXPPp+yWfuptjDyEj9GS8C5C47vH1Igm1DADrmfI/KC+uPN
         QZ01ffXCuhq2SwA2VlwCuqRW/02B33cLjga/8iSaC0p1JHAMDevqRo/Qx26WCh7BBqPQ
         rcGmubiLvdk7B8KKc0Kzs3lH5d7P5pdGwdbQoORYtDECgRyRd6UvyWEEL/PCL/dXSx9U
         XwLd+4fjgI60pCdc1kBhDWR4lmvkh/RcbP9RGb5kCkB6lD5BaEC5a0yGz3MHkcGOGYuP
         LK035P70JHhs7n/Pi/JUsEgUi6ULKXtKZuZoc9ewcYN2Jxk0qGeLsF/29C0V7dwCYJ5M
         gwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762905680; x=1763510480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L1c65TA/qlfWizahDeIPj92hA2Tnvs0ON89Itog2UtY=;
        b=CoxMXdlnFUAZSrbhPkVC5CcMWl7xfp1tM8ktWTiO64WawKKptcw83VEOdZ+YcATH0M
         NHIQMzoc0B2voiFJMRXe2mwILRwqLn2D1rdJ85NbpYOhSu+6Qil2q7DekGXUkTz9jQTt
         d9j3DGAwTn07gzPetbUDFhrtPGPugd6YAHn7ypPKYZjzku4onqBKo/0wPVuaYGCpPR8g
         j2X7Ih7oPJ8MNDebNVOZfElCcs3TtsYEVjnMtIswPo9peW4K2DdDzlVZfsoqdzrhzoUM
         JyixS7rdMLBKJuo2MeJrnWfU1QlhJhn8gRgM61T3R27l2cyJOLSzWBEfhoWTcg/yesmP
         GNOg==
X-Forwarded-Encrypted: i=1; AJvYcCX8Y+A4+XbhvScSUzeyPlBJC6UlDnwIX0k/DyH3lc45v9Ny9IxXp5k/ziJdsNgoglajPI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx3JLqNqlUX4e0PuZvFGQjZxbra6hQ6adpmSHAjLClnOrj7BxT
	Bb/iKNM/rZQze22iZ1kJNH6cUnOinFRIhBcSspSvvXY07jVa1/MZK7Q/Q1U66qeSRClYF+J4EoE
	GOghgD1pGRNJwrMqQN+eGvVk71xCXgfw=
X-Gm-Gg: ASbGncuzK5wlWgGRrUYplDizZqb9bdyCRtgfNJH7Y04gt5timXr0Se2357QY8Ij8Mol
	cb0+B0PULZc6/zI2W5BsG6zDh7ilKTTM+mXLjwl5sXXRQXVKl5ZKNIgzmT7vmlCGA2AkFysTmMR
	TcH+VSVWnk1ETnhWKmIaj6E3yLpoEg/gxiFmP19WsqUoWpV0CDCHLMvisG2j/okmxF54q2h9MzI
	rRfH/uFwA1YGtof7Vb5PwGjB0INt+kpHXbwE9D6Pf9ShhA+O+6xR0vUbWjOJ4Yx5Sut33P//+1R
	C0L2alcUTlCbHbjz
X-Google-Smtp-Source: AGHT+IGAHCAVV06XKvp+l9AdAkG2fV/+IdH9G34Rp60840q1TRUTw1crOZt1MnrCX3JqWPV1kINreRlf75NoH/qhvxw=
X-Received: by 2002:a05:6402:5112:b0:643:1659:7593 with SMTP id
 4fb4d7f45d1cf-6431a5755ccmr783569a12.30.1762905680187; Tue, 11 Nov 2025
 16:01:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111160949.45623-1-puranjay@kernel.org> <052b04eb-9b97-40be-965c-bb5aa8c88a49@gmail.com>
In-Reply-To: <052b04eb-9b97-40be-965c-bb5aa8c88a49@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 12 Nov 2025 01:01:08 +0100
X-Gm-Features: AWmQ_bmiaeEEmwymaPgyiTUD7K9iSOrvC-_iGJZ_kCP55Ut4Ui8_XPn6kDFSN90
Message-ID: <CANk7y0hQw_B-7hcmgK6hTExTvcghcXCFhH-N0TkyJsbRokzDaA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: verifier: initialize imm in kfunc_tab in add_kfunc_call()
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 7:38=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 11/11/25 16:09, Puranjay Mohan wrote:
> > Metadata about a kfunc call is added to the kfunc_tab in
> > add_kfunc_call() but the call instruction itself could get removed by
> > opt_remove_dead_code() later if it is not reachable.
> >
> > If the call instruction is removed, specialize_kfunc() is never called
> > for it and the desc->imm in the kfunc_tab is never initialized for this
> > kfunc call. In this case, sort_kfunc_descs_by_imm_off(env->prog); in
> > do_misc_fixups() doesn't sort the table correctly.
> > This is a problem from s390 as its JIT uses this table to find the
> > addresses for kfuncs, and if this table is not sorted properly, JIT can
> > fail to find addresses for valid kfunc calls.
> >
> > This was exposed by:
> >
> > commit d869d56ca848 ("bpf: verifier: refactor kfunc specialization")
> >
> > as before this commit, desc->imm was initialised in add_kfunc_call().
> >
> > Initialize desc->imm to func_id, it will be overwritten in
> > specialize_kfunc() if the instruction is not removed.
> >
> > Fixes: d869d56ca848 ("bpf: verifier: refactor kfunc specialization")
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >
> > This bug is not triggered by the CI currently, I am working on another
> > set for non-sleepbale arena allocations and as part of that I am adding
> > a new selftest that triggers this bug.
> >
> > Selftest: https://github.com/kernel-patches/bpf/pull/10242/commits/1f68=
1f022c6d685fd76695e5eafbe9d9ab4c0002
> > CI run: https://github.com/kernel-patches/bpf/actions/runs/19238699806/=
job/54996376908
> >
> > ---
> >   kernel/bpf/verifier.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 1268fa075d4c..a667f761173c 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -3371,6 +3371,7 @@ static int add_kfunc_call(struct bpf_verifier_env=
 *env, u32 func_id, s16 offset)
> >
> >       desc =3D &tab->descs[tab->nr_descs++];
> >       desc->func_id =3D func_id;
> > +     desc->imm =3D func_id;
> >       desc->offset =3D offset;
> >       desc->addr =3D addr;
> >       desc->func_model =3D func_model;
> Thanks for sending the fix.
> I'm not sure if this is enough, though. Don't you need to run entire
> calculation
> for the desc->imm, like in the original, before
> d869d56ca848 ("bpf: verifier: refactor kfunc specialization")?
>
>      if (bpf_jit_supports_far_kfunc_call()) {
>          call_imm =3D func_id;
>      } else {
>          call_imm =3D BPF_CALL_IMM(addr);
>          /* Check whether the relative offset overflows desc->imm */
>          if ((unsigned long)(s32)call_imm !=3D call_imm) {
>              verbose(env, "address of kernel func_id %u is out of
> range\n", func_id);
>              return -EINVAL;
>          }
>      }
>      desc->imm =3D call_imm;
>
> I think it would be right to reuse that hunk in both places:
>   add_kfunc_call() and specialize_kfunc().

Yes, I agree with you. Currently it doesn't make a difference because
only s390 uses it
and it needs the func_id to be in desc->imm, but for completeness we
should do the proper
calculation to not introduce bugs for later developments.

I will send v2 with this entire calculation. and we can remove:

 if (bpf_jit_supports_far_kfunc_call()) {
                call_imm =3D func_id;

from specialize_kfunc() as it is redundant.


Thanks,
Puranjay

