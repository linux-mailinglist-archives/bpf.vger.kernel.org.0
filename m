Return-Path: <bpf+bounces-23164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B04BD86E767
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 18:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB0981C2268A
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 17:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148E7FC11;
	Fri,  1 Mar 2024 17:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqqkNOwy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF578BED
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314487; cv=none; b=Gpj4m4LKHctswyL/97X0VI7luwwnjcWqu7psklVtuJpEeWyXNKvY6DQ++U0iDZPcANdLKTsDwyTlbldaOWLJ9STYk/Y0g6gPqCi5XSQEuDZUZd5fUyfSrtsn8eZbv6OVhkJ+RUYD6TAe0pYo2N5G+Ji28Zj6ZYT64feydv4rBJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314487; c=relaxed/simple;
	bh=Vi4bib446pShqBvTTQcW1mpyttp1+gc4+TIpdE7agiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKCtiSm+H9EJfo86NpJ3WVDJbhO9WhRfWnbSl9+Upt+CNeR8N0mCqrHGkbyrB9+/Sy3/zKIRjHGGlzuoiIBy5d1zr0n5o3kz75w1zN5aakO2f1F4u+N0iAmnlt9NukCkpL6/UKifGnEoYJefbdMupxJ893JSpu3hX5tjmgwedzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqqkNOwy; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-299e4b352cdso1666967a91.0
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 09:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709314485; x=1709919285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzKbFQU8eRmF0cKz8RebKkoJ/5UeIcQFWpgINywQEnc=;
        b=eqqkNOwyxafPDc8sAXYyevxukJfEFxCkj9d+rpgnK7Pd5qe1Z+9HZKBiUc0h88RW+d
         lu0kBNkqeXlB56RhBVUWj+Q51y0imZbgMbpzjzEbpx1uDo3Er95v7BRlSXslm1NgiNeq
         4jlGeskU01Zf1vJPZMw7By9Lxem/yCPxVvx+5WlWBtRiLYBGFd5SyNtwWRTivK4h7VVI
         dbPCFqWQTfXdvdNKQiF54js+aXCUEyDyf9bvKEiriFK12EkAtsqIHot/SGcCl/rQLEb0
         xwnFU4i0q5E2BHEZnEA1FgPtBxLCOZGVDUMaIS+SyCNvtqeGDck4/WgAUz1cHGntOFTB
         Kvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709314485; x=1709919285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzKbFQU8eRmF0cKz8RebKkoJ/5UeIcQFWpgINywQEnc=;
        b=JoZBhUkMBZyEiz4ImgZfga+f+cPP1hkXNhLAaZZN3EYOFfrS/2tIB5V8nnttQsc8QI
         kzN4Cyk8BfCjdmwdcQul8ZjFYUCJku/mO5mcZ8Q/MKQ+73HX5yF6z8OWlTfjg37Aoe70
         THMBsWD15QahG7hXILvPDLdVD1dXYnVwQX99WCLpZOcknKTM4XnVrE4ow55fxBZXbGMd
         KzJfbw150D8FVvNGLH5Q8ZWsFDEayWR99M/ryJPQpnhzjesG8+Dfq4dqelZJco/Cu6oZ
         a4e/cmsJmBJ8bOQVkQWEpktui/rgSGuIU7dW5G4dvIsmtM0khSBVAkglaRH0hdab/KII
         QpNg==
X-Gm-Message-State: AOJu0YxNIpAyP5wSPWmAYVUPWJIl+RwITD3Tfi4pSVtdinllvqSVAQjM
	X0aM9doWpumvlYC9gJ2JWTKfix3aqwxvdp84ZyFULKcGXvedCO6xDQQHbWeuJ1PBDd06kryXKtJ
	2XyWa7AkXLRdBzYIPPWlZw4zx2ZU=
X-Google-Smtp-Source: AGHT+IEUA9xZsisi95wUv+ix9B6mWsJC1d8iQPyTKgzz+A/ZbN8TInxFvDEEMOmSgRWapBrhaCMTZmAjiV9mj9PNNGA=
X-Received: by 2002:a17:90a:a205:b0:298:c136:2ffc with SMTP id
 u5-20020a17090aa20500b00298c1362ffcmr1936848pjp.45.1709314485171; Fri, 01 Mar
 2024 09:34:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222005005.31784-1-eddyz87@gmail.com> <20240222005005.31784-3-eddyz87@gmail.com>
 <CAEf4BzZdDoaVw28RahC+8hV+kReYjTdfJQdaMXJEkUUgih8j2Q@mail.gmail.com> <b1b259639635e9328bbbbc8e0683b14242f177e2.camel@gmail.com>
In-Reply-To: <b1b259639635e9328bbbbc8e0683b14242f177e2.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Mar 2024 09:34:32 -0800
Message-ID: <CAEf4BzZjps4+teYzWw8=8Jg0M59bCVRaB_0zLNTmfveBQ63C3Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: track find_equal_scalars history on
 per-instruction level
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 3:29=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2024-02-28 at 15:01 -0800, Andrii Nakryiko wrote:
> [...]
>
> > > @@ -3332,6 +3402,12 @@ static int push_jmp_history(struct bpf_verifie=
r_env *env, struct bpf_verifier_st
> > >                           "verifier insn history bug: insn_idx %d cur=
 flags %x new flags %x\n",
> > >                           env->insn_idx, cur_hist_ent->flags, insn_fl=
ags);
> > >                 cur_hist_ent->flags |=3D insn_flags;
> > > +               if (cur_hist_ent->equal_scalars !=3D 0) {
> > > +                       verbose(env, "verifier bug: insn_idx %d equal=
_scalars !=3D 0: %#llx\n",
> > > +                               env->insn_idx, cur_hist_ent->equal_sc=
alars);
> > > +                       return -EFAULT;
> > > +               }
> >
> > let's do WARN_ONCE() just like we do for flags? why deviating?
>
> Ok
>
> [...]
>
> > >  /* For given verifier state backtrack_insn() is called from the last=
 insn to
> > > @@ -3802,6 +3917,7 @@ static int backtrack_insn(struct bpf_verifier_e=
nv *env, int idx, int subseq_idx,
> > >                          */
> > >                         return 0;
> > >                 } else if (BPF_SRC(insn->code) =3D=3D BPF_X) {
> > > +                       bt_set_equal_scalars(bt, hist);
> > >                         if (!bt_is_reg_set(bt, dreg) && !bt_is_reg_se=
t(bt, sreg))
> > >                                 return 0;
> > >                         /* dreg <cond> sreg
> > > @@ -3812,6 +3928,9 @@ static int backtrack_insn(struct bpf_verifier_e=
nv *env, int idx, int subseq_idx,
> > >                          */
> > >                         bt_set_reg(bt, dreg);
> > >                         bt_set_reg(bt, sreg);
> > > +                       bt_set_equal_scalars(bt, hist);
> > > +               } else if (BPF_SRC(insn->code) =3D=3D BPF_K) {
> > > +                       bt_set_equal_scalars(bt, hist);
> >
> > Can you please elaborate why we are doing bt_set_equal_scalars() in
> > these three places and not everywhere else? I'm trying to understand
> > whether we should do it more generically for any instruction either
> > before or after all the bt_set_xxx() calls...
>
> The before call for BPF_X is for situation when dreg/sreg are not yet
> tracked precise but one of the registers that gained range because of
> this 'if' is already tracked.
>
> The after call for BPF_X is for situation when say dreg is already
> tracked precise but sreg is not and there are some registers had same
> id as sreg, that gained range when this 'if' was processed.
> The equal_scalars_bpf_x_dst() test case covers this situation.
> Here it is for your convenience:
>
>     /* Registers r{0,1,2} share same ID when 'if r1 > r3' insn is process=
ed,
>      * check that verifier marks r{0,1,2} as precise while backtracking
>      * 'if r1 > r3' with r3 already marked.
>      */
>     SEC("socket")
>     __success __log_level(2)
>     __flag(BPF_F_TEST_STATE_FREQ)
>     __msg("frame0: regs=3Dr3 stack=3D before 5: (2d) if r1 > r3 goto pc+0=
")
>     __msg("frame0: parent state regs=3Dr0,r1,r2,r3 stack=3D:")
>     __msg("frame0: regs=3Dr0,r1,r2,r3 stack=3D before 4: (b7) r3 =3D 7")
>     __naked void equal_scalars_bpf_x_dst(void)
>     {
>         asm volatile (
>         /* r0 =3D random number up to 0xff */
>         "call %[bpf_ktime_get_ns];"
>         "r0 &=3D 0xff;"
>         /* tie r0.id =3D=3D r1.id =3D=3D r2.id */
>         "r1 =3D r0;"
>         "r2 =3D r0;"
>         "r3 =3D 7;"
>         "if r1 > r3 goto +0;"
>         /* force r0 to be precise, this eventually marks r1 and r2 as
>          * precise as well because of shared IDs
>          */
>         "r4 =3D r10;"
>         "r4 +=3D r3;"
>         "r0 =3D 0;"
>         "exit;"
>         :
>         : __imm(bpf_ktime_get_ns)
>         : __clobber_all);
>     }
>
> The before call for BPF_K is the same as before call for BPF_X: for
> situation when dreg is not yet tracked precise, but one of the
> registers that gained range because of this 'if' is already tracked.
>
> The calls are placed at point where conditional jumps are processed
> because 'equal_scalars' are only recorded for conditional jumps.

As I mentioned in offline conversation, I wonder if it's better and
less error-prone to do linked register processing in backtrack_insn()
not just for conditional jumps, for all instructions? Whenever we
currently do bpf_set_reg(), we can first check if there are linked
registers and they contain a register we are about to set precise. If
that's the case, set all of them precise.

That would make it unnecessary to have this "before BPF_X|BPF_K"
checks, I think.

It might be sufficient to process just conditional jumps given today's
use of linked registers, but is there any downside to doing it across
all instructions? Are you worried about regression in number of states
due to precision? Or performance?

>
> >
> > >                          /* else dreg <cond> K
> > >                           * Only dreg still needs precision before
> > >                           * this insn, so for the K-based conditional
>
> [...]

