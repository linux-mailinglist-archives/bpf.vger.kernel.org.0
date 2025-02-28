Return-Path: <bpf+bounces-52939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D67A4A69D
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 00:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5E73BB015
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 23:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD5D1DED6C;
	Fri, 28 Feb 2025 23:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQByypPI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53FE1C5D51
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 23:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740785711; cv=none; b=Euj0W6GOn3mmBVaVnYBuNgmWuSjazpurmzxepiYZrCTnvxVPieuaeFcY//URwOIq1HJfFWRIO+yN/R87afSr9E/51vsVPYs3jgbp4wiuf+Cs0CLJdat7YnIbQE8EKWB4o0h8uP4wMqBkfvNiWofOGhlO5VTD2uiBG+NnSy7kcLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740785711; c=relaxed/simple;
	bh=LySsMsY/+rRAoX3my+C7IcY5rE7K11Savx+AvK5/OYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWV9xkGcQvz0rdx/F9zNwzPGPSrJ0IxIRomL+bDuE2Aaor1VnUCvlQpg9IWPMbJF6YmHfWeYHo60SNrnauWllPNbMf0upqs70rF3KdjOedo16UUMlGm+UKMSgteyl/Ax1Yzi0Z7PaA3aqee7RCXE5BeZdkRpnFtYM16R++I27vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQByypPI; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fe82414cf7so5256544a91.0
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 15:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740785709; x=1741390509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4ekww/TxdlUy0NyOzGvOOJh/2rhj66pI0AljiqbkKc=;
        b=VQByypPIwnSbxomt9FPe7AR+pUF4tWZQraXA8nEkraKM5m/oXsTWg19spv2sBDf1hQ
         mCJ0fB9p0CCL/YrNJXdb19AX4aCkYecXV3ej3Rs1C9W8Ns9OThZjt9LytMnui8dCVmP7
         HjPlHcWXRv4PYJarrp6ZCC1KnWVGmWAAPQvKEiLpV5CT3HMAiRDWkB7LqshLhWGIvZpG
         jdfuUYNtsov8zAhb/wOEyf1HSNkTnFOCOnsQMNJBNgMAI9dwVc5oRHEFDYBwbB7L4Tb/
         bm9ME/H8LlEcnewi2XRF/pOTHQyL3Kq53EUXTHrOwtoCCe16uq5ILeGv1JQKkX4WdCA8
         ADbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740785709; x=1741390509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4ekww/TxdlUy0NyOzGvOOJh/2rhj66pI0AljiqbkKc=;
        b=oP/nFzRZF9SH8caZ+esaOL+Jp9cly+2ACsgSDRWhVUvrlr6t+50JtYqlYP/jnCijRV
         e/qoQ+3uqOvwxW8T4RkJv5sxdKW0ln+4KdlFkR/gHpqYdx6uKfLDGLEyh4Hvz1V+AJrp
         ws7kRQUSiXl2iF6LCSenbT8PjeFXU/09kH9Up4+agXEAynWCf9fWfCYZU4gvXwrB1rc/
         vUitRMou6EFb50pQkg9y3b9zx/JhBK0q7PAi3qt1SmDWaKSogzoCmKa5yKx/tfK7BjGs
         w4p/EOvRThFUEJ2derse/GNKVk9eUQvazN+wFDeS3PAe0FZkj/Bu1zRyYE9pcDlxutnJ
         4zGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCX59/Z+se+Lwh6WoOloQpeQP8VL4ktjc7NE8SwrRUGH53inDemOihaircuR/FAZZx7DU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3MB46I+XxhPEVXOD88/PwquIm2q2v6ew16W/JGHgz9jx/zOW2
	fVA8RNc57NnvEvwCWKM2XgHhNAxiKsm6Pcu9VrTXlpJoZsq950zwxwI86Lalalf3tIf52HYiIGZ
	BrCMwysgp9JtOtkj84sXcLvnoHVXDuw==
X-Gm-Gg: ASbGncu4+iN0ymeT6wHShsRayft2cfLZNsUHGCKabR6GwwZFE7PnB5qS+PBdcSAwii3
	F0Lu3BvsVeuiVQu9jp0zuTjIYecNdL2RAd3Qd9DXPUTxtuc6KNuSq81MKZIrK5b2tH8wWBiqyv3
	9b+5W0mlqyHY21UiP3dZlzKqndQ6KIiKPdYYdJAoFfrQ==
X-Google-Smtp-Source: AGHT+IHDg2yji4p42LYGsWUrXp0L+Qvzvw9E+IUqAXPuOB05ztSTxrkRD7QR70o6/3eTwSDlB1v6MiQttF6K5L+kgog=
X-Received: by 2002:a17:90b:4a89:b0:2ee:8ea0:6b9c with SMTP id
 98e67ed59e1d1-2febab570b1mr10184462a91.12.1740785709064; Fri, 28 Feb 2025
 15:35:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228162858.1073529-1-memxor@gmail.com> <20250228162858.1073529-2-memxor@gmail.com>
 <CAEf4BzZ_UQVtOhE3SRvHBE3NyCwfdFCxmiAPPNbLArZVQT6oZg@mail.gmail.com> <3736b28f9266bf8b9c227998e80eb08253aef43e.camel@gmail.com>
In-Reply-To: <3736b28f9266bf8b9c227998e80eb08253aef43e.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Feb 2025 15:34:57 -0800
X-Gm-Features: AQ5f1Jop3ok-AJrrzUaDERZUbsHzO1EXUW4Zw_ZMQ5ZfUKTLe5hyXJ9j5vFnxQ8
Message-ID: <CAEf4BzZMhVCc0SVjbOLQj736kH-0yRdptqa7rNTftyD5X7ZDvw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Summarize sleepable global subprogs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 3:23=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2025-02-28 at 15:18 -0800, Andrii Nakryiko wrote:
>
> [...]
>
> > >  /* non-recursive DFS pseudo code
> > > @@ -17183,9 +17187,20 @@ static int visit_insn(int t, struct bpf_veri=
fier_env *env)
> > >                         mark_prune_point(env, t);
> > >                         mark_jmp_point(env, t);
> > >                 }
> > > -               if (bpf_helper_call(insn) && bpf_helper_changes_pkt_d=
ata(insn->imm))
> > > -                       mark_subprog_changes_pkt_data(env, t);
> > > -               if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL) {
> > > +               if (bpf_helper_call(insn)) {
> > > +                       const struct bpf_func_proto *fp;
> > > +
> > > +                       ret =3D get_helper_proto(env, insn->imm, &fp)=
;
> > > +                       /* If called in a non-sleepable context progr=
am will be
> > > +                        * rejected anyway, so we should end up with =
precise
> > > +                        * sleepable marks on subprogs, except for de=
ad code
> > > +                        * elimination.
> >
> > TBH, I'm worried that we are regressing to doing all these side effect
> > analyses disregarding dead code elimination. It's not something
> > hypothetical to have an .rodata variable controlling whether, say, to
> > do bpf_probe_read_user() (non-sleepable) vs bpf_copy_from_user()
> > (sleepable) inside global subprog, depending on some outside
> > configuration (e.g., whether we'll be doing SEC("iter.s/task") or it's
> > actually profiler logic called inside SEC("perf_event"), all
> > controlled by user-space). We do have use cases like this in
> > production already, and this dead code elimination is important in
> > such cases. Probably can be worked around with more global functions
> > and stuff like that, but still, it's worrying we are giving up on such
> > an important part of the BPF CO-RE approach - disabling parts of code
> > "dynamically" before loading BPF programs.
>
> There were two alternatives on the table last time:
> - add support for tags on global functions;

I was supportive of this, I believe

> - verify global subprogram call tree in post-order,
>   in order to have the flags ready when needed.

Remind me of the details here? we'd start validating the main prog,
suspend that process when encountering global func, go validate global
func, once done, come back to main prog, right?

Alternatively, we could mark expected properties (restrictions) of
global subprogs as we encounter them, right? E.g, if we come to global
func call inside rcu_read_{lock,unlock}() region, we'd mark it
internally as "needs to be non-sleepable".

>
> Both were rejected back than.
> But we still can reconsider :)
>

yep, though I'm not really feeling hopeful

> > > +                        */
> > > +                       if (ret =3D=3D 0 && fp->might_sleep)
> > > +                               mark_subprog_sleepable(env, t);
> > > +                       if (bpf_helper_changes_pkt_data(insn->imm))
> > > +                               mark_subprog_changes_pkt_data(env, t)=
;
> > > +               } else if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL=
) {
> > >                         struct bpf_kfunc_call_arg_meta meta;
> > >
> > >                         ret =3D fetch_kfunc_meta(env, insn, &meta, NU=
LL);
>
> [...]
>

