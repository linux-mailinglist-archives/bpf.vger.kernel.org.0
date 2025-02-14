Return-Path: <bpf+bounces-51536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 300FDA357E7
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 08:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B8E3AE3C4
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 07:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B8920AF77;
	Fri, 14 Feb 2025 07:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aowlqLpr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B868D204C2D
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739518256; cv=none; b=jxx0gittpzRgbCAZAr1B1x0c5UG43VFuzerqYVFvtD0UkjXhXw1+nXVmeuSKELLU22rMiny/tmIzdoVEbsvyowZSqHuGQzyXJFJb5U6zykKNv0ixsgsT3JeCQB1fXvE+OJVHH5Qc+ItF6vWgOGli12GZKJoiUpU4BV3aAeVvIiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739518256; c=relaxed/simple;
	bh=aJ1Cj42J6rrQP84Q6f2v6Xs1juh+ku/D7zvVpB25Rds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KF4o5dU8+JSYomIHVNHDs+c+jWgl23cek1Y/LmeIG7ZidixOVhzFhCtC2NeEHna+iruhIFjsP6n9yw6ZcKIcc51XqR2zpIG85GGtW98+yCHO6Xz1XbSrTkxw99tHdiIf3dz4wLBpF2vSZd2UmROZ1Fn0hCUOT+m2o+mzAtWOFRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aowlqLpr; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-471bc8eaf3fso15002391cf.2
        for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 23:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739518252; x=1740123052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/gDV1d1gmKk3coK6/jH7KArqYrE46gbcFcP2fMKHuM=;
        b=aowlqLprnzx0F+NXLXJMonq1fPD/Lpg284dRINo94OxuPe5gOQVb9lipyN6gGgSEJA
         9Va8zafG6i3FLS+O5d+K3o7VTSuDe+eTUb/jaIORkvIdzSIj7sgfTb6x2K2HmgHJfwLr
         A05lJZTb0Gl1xc4X6jtftDXhIQtYI5yDyzPkJpC6elYxaShOXICNpWXMy8TPpG0mtpZO
         eTq0FtKk1GBNzQ0yO1VnxE1yNmRFPrap42GPcUu5Mrhg1BPZdjnplX+Il0WDyYlSfXgJ
         6DqG2c5wSTgv16XsJPdp5OKlsMRAAKlrgX8se4ckxWYMYB+opizIRmVrfiq/d2L0F22D
         uu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739518252; x=1740123052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/gDV1d1gmKk3coK6/jH7KArqYrE46gbcFcP2fMKHuM=;
        b=dd0WyHTKJXzVSKe8JBmYj8lvapH5D96l4nIGjsfntsvCMEemwZUsgugjByZrSY1WVL
         Q/JvCcEc+RB5i0LIgihtQ0r6TS/jz3kjvq2oPXfaYt7UhaRUIOlrex6cxfn7MN3qk3DA
         YQUY08zBmv+vwSJlespUheoMljYJlGp3sUOfEHFhHBUmt7I6jrM6AyQR4ShOhh+704+t
         9OoVEVDpLS0w+AfZZXPFtHcOL0zoDjGfxnVie3vopRfBdWsoLzsjpxxLUUVCzPmFh7Qw
         LjFXVyC3oLJx/cFSqtscW2zSmKNc7TFy+TYbpcdSu2Jzg0+qPPs5Vk7HxNRwo5piTgaw
         T+ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVhlWtOMYXb2EmpZxScL1lHsXhaPG3P2aXkLu4ttDD44F7ERE+H62fvsr7WA//s5rF3xVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoxySVWSdFpN7sC7PoL60bnxf422xwWOGpT29ziOcPu8FDfudd
	nmWmcT9FCGZhyP+RjWhym/WRk4Zc/KwsMUnQfQRZ1bYcrak/Et8TS0HDS7RniIRUVo6mWBfaiy6
	4B7yNGVMbkG0FKYSZBPMq5eyRjUgfrUEeoNY=
X-Gm-Gg: ASbGncswLNGGJF+zmDMRpHeSVA8Mw1rbKk44etn50gze1fR6qcPJVMsWBwnNwyZHuhw
	yS8ZpDBVxZqenFUmrjc+sbL+M+DtKSVorRORgcvXgZujNy0Wkklnm4YeOdlaO+7xvls1hozUh38
	8=
X-Google-Smtp-Source: AGHT+IFk1VnrE8DI8+2KBSVKgc9+2Ibol5eioblJLT2oRVvYU8PyNtYrUbv4x89b8i2hZyFvQVl/fobKn3L0yr+pu80=
X-Received: by 2002:a05:6214:501d:b0:6e6:61a5:aa54 with SMTP id
 6a1803df08f44-6e661a5ad3bmr56475766d6.44.1739518252524; Thu, 13 Feb 2025
 23:30:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211023359.1570-1-laoar.shao@gmail.com> <20250211023359.1570-3-laoar.shao@gmail.com>
 <CAPhsuW5TRdcpy-br1n4esGAasM+=F58LJWJq=6gYGRMeSr=pdQ@mail.gmail.com>
In-Reply-To: <CAPhsuW5TRdcpy-br1n4esGAasM+=F58LJWJq=6gYGRMeSr=pdQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 14 Feb 2025 15:30:16 +0800
X-Gm-Features: AWEUYZnioDpBcYyd_BZ6ovbPn169_fUDVtqHu1_6JLYWVlRklLKyjy_rbYcDgfA
Message-ID: <CALOAHbB7Y9g-8LEZS45eRmbwCuACA4qOnDx-yC61FV20uBpjeg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Reject attaching fexit to functions
 annotated with __noreturn
To: Song Liu <song@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, jpoimboe@kernel.org, 
	peterz@infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 1:19=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Mon, Feb 10, 2025 at 6:34=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > If we attach fexit to a function annotated with __noreturn, it will
> > cause an issue that the bpf trampoline image will be left over even if
> > the bpf link has been destroyed. Take attaching do_exit() for example. =
The
> > fexit works as follows,
> >
> >   bpf_trampoline
> >   + __bpf_tramp_enter
> >     + percpu_ref_get(&tr->pcref);
> >
> >   + call do_exit()
> >
> >   + __bpf_tramp_exit
> >     + percpu_ref_put(&tr->pcref);
> >
> > Since do_exit() never returns, the refcnt of the trampoline image is
> > never decremented, preventing it from being freed. This can be verified
> > with as follows,
> >
> >   $ bpftool link show                                   <<<< nothing ou=
tput
> >   $ grep "bpf_trampoline_[0-9]" /proc/kallsyms
> >   ffffffffc04cb000 t bpf_trampoline_6442526459    [bpf] <<<< leftover
> >
> > With this change, attaching fexit probes to functions like do_exit() wi=
ll
> > be rejected.
> >
> > $ ./fexit
> > libbpf: prog 'fexit': BPF program load failed: -EINVAL
> > libbpf: prog 'fexit': -- BEGIN PROG LOAD LOG --
> > processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 =
peak_states 0 mark_read 0
> > -- END PROG LOAD LOG --
> > libbpf: prog 'fexit': failed to load: -EINVAL
> > libbpf: failed to load object 'fexit_bpf'
> > libbpf: failed to load BPF skeleton 'fexit_bpf': -EINVAL
> > failed to load BPF object -22
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 9971c03adfd5..f7224fc61e0c 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -22841,6 +22841,13 @@ BTF_ID(func, __rcu_read_unlock)
> >  #endif
> >  BTF_SET_END(btf_id_deny)
> >
> > +/* The functions annotated with __noreturn are denied. */
> > +BTF_SET_START(fexit_deny)
> > +#define NORETURN(fn) BTF_ID(func, fn)
> > +#include <linux/noreturns.h>
> > +#undef NORETURN
> > +BTF_SET_END(fexit_deny)
> > +
> >  static bool can_be_sleepable(struct bpf_prog *prog)
> >  {
> >         if (prog->type =3D=3D BPF_PROG_TYPE_TRACING) {
> > @@ -22929,6 +22936,9 @@ static int check_attach_btf_id(struct bpf_verif=
ier_env *env)
> >         } else if (prog->type =3D=3D BPF_PROG_TYPE_TRACING &&
> >                    btf_id_set_contains(&btf_id_deny, btf_id)) {
> >                 return -EINVAL;
> > +       } else if (prog->expected_attach_type =3D=3D BPF_TRACE_FEXIT &&
> > +                  btf_id_set_contains(&fexit_deny, btf_id)) {
>
> Please add a verifier log (with verbose()) here, so that the user knows
> why the program failed to attach.

Good suggestion.  I will add it.

--=20
Regards
Yafang

