Return-Path: <bpf+bounces-18335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74F281905B
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 20:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC6B2875B4
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 19:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F7A38DF7;
	Tue, 19 Dec 2023 19:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rvc4YWhg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEA91C69A
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 19:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a1fae88e66eso552348066b.3
        for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 11:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703012907; x=1703617707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2SWsVnzENDsypUHZ9nE+/Zw1SqpeOLm2z+P7nddARk=;
        b=Rvc4YWhgF3i78IA6z3SUdTcilPEZinl4SV+g5pA+2Pxi4caWDwdWqnnsPax68xQ60/
         yT2MWDyWnEmzYPb1/jxrmznfgIFKSzLPqfmsapGUj24WJVByU47S6aIyhnpfH+v7balX
         HR+KXiOkD+aO21VaE4F1Qu1DSYOj5eGce6nzcbcvTmcV9jGVVnLEdyXGVQO6r3eyEuVw
         gSrn+Et7SlBNwuiNNAMdl4yKXwC8AjK3baPp7/0387XNRCAGppyIcIr2gBFXi1xDNdF8
         3MI1fNxUo7DTBTO0SK1fnSVyIr9AyLQ62IHIIU5OoKl0I3VPGiejklmgF1QWf03f5oMV
         V8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703012907; x=1703617707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2SWsVnzENDsypUHZ9nE+/Zw1SqpeOLm2z+P7nddARk=;
        b=tRvixlmjbNimlfBzvtY7HGjfIyCK7CdPqvAlrpDOSw+XrkGibmAS95iQoufoWwncIV
         dyKm2VSlEO0vF1FSehIcR4tCVDB2jfnGQQT9NAMj7VPPkJY84tWS2DWM3QxIW+momwPz
         Us61psULIeo+iK4iDomPF6X/UHaOvbsrD1b5Xd4CYK2B3nEnhZyqBmpDEbz4nEEOWLDH
         S30c06PHrLnkv6YwoNDIUYeb1EDhgPvPLnBMah/tBbXyVsc7VHksTN8lGWBBFRSIBShx
         GxdCtNNsxJ6sqo+0Ii51upgxLFGiWLV9Maw1EVk3njabTCfQCcjd/eAaBLU8UscvUoPE
         TKQA==
X-Gm-Message-State: AOJu0YyDT1KUbozHBe2vSO0zpU+GY0ryu+vla5WMmpk9Nj+2W/6dzsSe
	tCt1eRbGp7itkaq5cK/63aHoLOitfTXQa2rbTQA=
X-Google-Smtp-Source: AGHT+IFojQG7gOdibyLViR8wsRJigNdkNert1P+RKAbn1nSp+eSr1RwlF5Ljt7r4ehXUbwMDPIshzvNiy0NhvQyT0l8=
X-Received: by 2002:a17:906:11d3:b0:a19:a1ba:8cf1 with SMTP id
 o19-20020a17090611d300b00a19a1ba8cf1mr8000958eja.143.1703012906879; Tue, 19
 Dec 2023 11:08:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217010649.577814-1-andreimatei1@gmail.com>
 <20231217010649.577814-2-andreimatei1@gmail.com> <658b22003f90e066ba7d6585aa444c3e401ff0ac.camel@gmail.com>
 <CABWLseu+uALXXwaSGJ=zJhoZuWH3Lajby-ip8oKAmTOLxci7Vw@mail.gmail.com> <0994aae8e3086cb93f25a47ee9e81a6894dbff26.camel@gmail.com>
In-Reply-To: <0994aae8e3086cb93f25a47ee9e81a6894dbff26.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 19 Dec 2023 11:08:14 -0800
Message-ID: <CAEf4BzZPC0zV_ETO_BPe58aZnDx_GrhpVejr3=-Hzx176P1Kvw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] bpf: Simplify checking size of helper accesses
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrei Matei <andreimatei1@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 9:01=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2023-12-18 at 21:54 -0500, Andrei Matei wrote:
> > On Mon, Dec 18, 2023 at 7:04=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Sat, 2023-12-16 at 20:06 -0500, Andrei Matei wrote:
> > > [...]
> > >
> > > > (*) Besides standing to reason that the checks for a bigger size ac=
cess
> > > > are a super-set of the checks for a smaller size access, I have als=
o
> > > > mechanically verified this by reading the code for all types of
> > > > pointers. I could convince myself that it's true for all but
> > > > PTR_TO_BTF_ID (check_ptr_to_btf_access). There, simply looking
> > > > line-by-line does not immediately prove what we want. If anyone has=
 any
> > > > qualms, let me know.
> > >
> > > check_help_mem_access() is a bit obfuscated :)
> > > After staring at it for a bit I have a question regarding
> > > check_ptr_to_btf_access():
> > > - it can call btf_struct_access(),
> > >   which in can call btf_struct_walk(),
> > >   which has the following check:
> > >
> > >                 if (btf_type_is_ptr(mtype)) {
> > >                         const struct btf_type *stype, *t;
> > >                         enum bpf_type_flag tmp_flag =3D 0;
> > >                         u32 id;
> > >
> > >                         if (msize !=3D size || off !=3D moff) {
> > >                                 bpf_log(log,
> > >                                         "cannot access ptr member %s =
with moff %u in struct %s with off %u size %u\n",
> > >                                         mname, moff, tname, off, size=
);
> > >                                 return -EACCES;
> > >                         }
> > >
> > > - previously this code was executed twice, for size 0 and for size
> > >   umax_value of the size register;
> > > - now this code is executed only for umax_value of the size register;
> > > - is it possible that with size 0 this code could have reported error
> > >   -EACCESS error, which would be missed now?
> >
> > I don't have a good answer. I too have looked at check_ptr_to_btf_acces=
s() and
> > ended up confused -- but then again, I don't know what's supposed to be=
 allowed
> > and what's supposed to not be allowed. I will say, though, that I don't=
 think
> > the code as it stands make sense, and I don't think any interaction bet=
ween the
> > zero-size check and btf access is intentional. Around [1] we've looked =
a bit at
> > the history of this zero-size check, and it's been there forever, preda=
ting
> > most of the code around it. What convinces me personally that the zero-=
size
> > check was not load-bearing is the fact that we were only performing
> > the check iff
> > umin =3D=3D 0 -- we were not consistently performing a check for the um=
in value.
> > Also, obviously, we were not performing a check for every possible valu=
e in
> > between umin and umax. So I can't really imagine positive benefits of t=
he
> > inconsistent check we were doing. But then again, I cannot actually spe=
ak with
> > confidence about it.
>
> Not checking consistently for all possible offsets is a good argument, th=
ank you.
>
> > As a btw, I'll say that we don't allow variable-offset accesses to btf =
ptr [2].
> > I don't know if this should influence how we treat the access size... b=
ut
> > maybe? Like, should we disallow variable-sized accesses on the same arg=
ument as
> > disallowing variable-offset ones (whatever that argument may be)? I don=
't know
> > what I'm talking about (generally BTF is foreign to me), but I imagine =
this all
> > means that currently the verifier allows one to read from an array fiel=
d by
> > starting at a compile-time constant offset, and extending to a variable=
 size.
> > However, you cannot start from an arbitrary offset, though. Does this
> > combination of being strict about the offset but permissive about the s=
ize make
> > sense?
>
> I agree with you, that disallowing variable size access in BTF case
> might make sense. check_ptr_to_btf_access() calls either:
> a. env->ops->btf_struct_access(), which is one of the following:
>    1. _tc_cls_act_btf_struct_access() (through a function pointer),
>       which allows accessing exactly one field: struct nf_conn->mark;
>    2. bpf_tcp_ca_btf_struct_access, which allows accessing several
>       fields in sock, tcp_sock and inet_connection_sock structures.
> b. btf_struct_access(), which checks the following:
>    1. part with btf_find_struct_meta() checks that access does not reach
>       to some forbidden field;

wouldn't variable size access be problematic here without properly
working with size range (instead of a max offset)? Just because max
offset falls into allowed field, doesn't mean that min offset falls
into allowed field. What's even worth, both min and max by themselves
can fall into allowed fields (different ones, though), but between
those two fields there will be a forbidden one?


>    2. btf_struct_walk() checks that offset and size of the access match
>       offset and size of some field in the target BTF structure;
>
> Technically, checks a.1, a.2 and b.1 are ok with variable size access,
> but b.2 is not and it does not seem to be verified.
>
> I tried a patch below and test_progs seem to pass locally
> (but I have some troubles with my local setup at the moment,
>  so it should be double-checked).
>
> > I'll take guidance. If people prefer we don't touch this code at all, t=
hat's
> > fine. Although it doesn't feel good to be driven simply by fear.
>
> Would be good if others could comment.

Given the current (seemingly incomplete) checking logic Andrei change
makes sense. But the variable-sized BTF access throws a wrinkle into
this, no? It can't be checked just at min/max offset boundaries, as I
mentioned above.

I don't know if variable-sized BTF access is important (Alexei?,
Martin?), but maybe BTF access has to be checked separately and then
we can keep the check that does pure dump memory access checks simply
and correctly?

>
> [...]
>
> ---
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index cf2a09408bdc..946415d11338 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7328,6 +7328,7 @@ static int check_mem_size_reg(struct bpf_verifier_e=
nv *env,
>  {
>         int err;
>         const bool size_is_const =3D tnum_is_const(reg->var_off);
> +       struct bpf_reg_state *ptr_reg =3D &cur_regs(env)[regno - 1];
>
>         /* This is used to refine r0 return value bounds for helpers
>          * that enforce this value as an upper bound on return values.
> @@ -7373,6 +7374,13 @@ static int check_mem_size_reg(struct bpf_verifier_=
env *env,
>                 verbose(env, "verifier bug: !zero_size_allowed should hav=
e been handled already\n");
>                 return -EFAULT;
>         }
> +
> +       if (base_type(ptr_reg->type) =3D=3D PTR_TO_BTF_ID && !size_is_con=
st) {
> +               verbose(env, "variable length access to r%d %s is not all=
owed",
> +                       regno - 1, reg_type_str(env, ptr_reg->type));
> +               return -EACCES;
> +       }
> +
>         err =3D check_helper_mem_access(env, regno - 1,
>                                       reg->umax_value,
>                                       /* zero_size_allowed: we asserted a=
bove that umax_value is

