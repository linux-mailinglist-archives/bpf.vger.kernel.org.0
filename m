Return-Path: <bpf+bounces-51645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFB9A36C11
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 05:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCFFB16FD6C
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 04:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7171714CF;
	Sat, 15 Feb 2025 04:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5EvkKBI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E83144304
	for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 04:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739595532; cv=none; b=Esfvn0YjzxRBQWQ0j1MA/4bD1wvcEuNK9k2ZwGUmjf5fh+/k8ArD0FU8PXiV5zXl9BRCbjN9I0HiiglL/9rHFHIMJtmlxB3Z9abzSwcerk5+ghakIC7Mipl2D8sgzSTKHy7f8CDpy072mD2AxMankBujk+EOSGcIX+JBWTFWneY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739595532; c=relaxed/simple;
	bh=872Qw0Wwq6hBDOHkCZehyrh/0DlrvNjVfsodjJS65/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HuTevGpsRuj4YtjoWr2CAA8EUAFR4wiv80mqgYCB3jx8eHY/jyfOD5/Bug0elSvulVrUQGNBEA+IZgoCJrWrX2Myyu3pZFZwYO55zAvwkuYDIa726mL5zO5KR/PDnDmaBHNQUwvUd29f/s2Pxpg0jcbOoe0mQAWpfTp6wD99o/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5EvkKBI; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e5b29779d74so2365260276.2
        for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 20:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739595529; x=1740200329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJqX1fpox2WP3QOYNDZlug8w8fQYU9P0gMoH3e70X7k=;
        b=M5EvkKBIoS9LsVwGH3yDZmEIKbPCgLSdTNq7JORW4H6jf4TOhy6xtLuynGT4sy99dv
         OVgwl3NjexiAJZQM/0yWq7yHtMsSxNEV+z4uZ7Ww1LJETO3Ucu7ZXJ7smrmnD79NOF3Q
         3vEadZKgL6wR1Ox9VSoEgzF9pYtO/evBGsJrQKV7E3/ykh3eh+kjsfrMjBX71MeAvx1n
         V/+5GPiF6wNwt/bkQxQJi7ZkBDD7blV8pFrrcr5kU1BflptHl7e7ksEgMwB0f4ppIVOR
         LzxqyUZBQOalVGFg6jI5o9HdIlyJP8ELn98WrWYJPPYf5W5IK+Id2r6qOutE63Rgp7By
         69Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739595529; x=1740200329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJqX1fpox2WP3QOYNDZlug8w8fQYU9P0gMoH3e70X7k=;
        b=Ee7o65R1iBs6/WhvGeXX2wPgY1lxq79f7hXg9dpN90SiYqa5G2JqZgLiMKPzGyqA05
         piSDRBAA85cMPU55Z2Y5SgH0gvzoGweUog64cjZJ0DMmesxXP4ksOk45oLWDPusP0z2q
         wuPmlVU7cG2zRBlcKkYi/mjyBTLF2N88vMjB35EV2AHqI0CRlvqE+gMPQGgpUPdtJy2L
         wOESIfHGGjTtAY6LL24EwBYXDK6yeAsIMjFhcoaRzfBzEVEHPT6hZz37uWQouooaep9f
         N/X9S07lu2xu5aJ5AhO8CL/YXJt9FdKFhVWacD6NM+ozQXd+mKCSCkFpqjersuxOuwJ9
         UT3A==
X-Gm-Message-State: AOJu0Yx2Al5HIunT3E2a7po+8M0NOra1iPUaD6WtmOlFyyPiMZUtZpST
	yNxf5/bIZGlMCBE8O1HHKu3S35m/F+VsfNjStKQ8x3Rk27IAfLRGzpm1TX0k743oPy2pvqH3igt
	PDh9ogVNSOXzDye05EqmPNf6h5zc=
X-Gm-Gg: ASbGncs3hJwUdI/4TfF+wfP7QzhdOpWr9XnupNa/KV8Ayp649SROSYXE2BhymN+qzDf
	qr80TzzLMfok3gjA9yBV8+/IyIsR2jsOixQKIGs/OrtDnB0PV8akk1zYLYxSMKNGXy/jEAsZm
X-Google-Smtp-Source: AGHT+IEnTjA9yhyoVss3lQ1SoxjWYoNUDd/xBgnoxO7f76kGUn3K5Oy6ezyRUNPAdwzZ3fSZgXXVDmldpMQLITnbbjw=
X-Received: by 2002:a05:6902:845:b0:e59:dbac:d993 with SMTP id
 3f1490d57ef6-e5dc9043ed6mr1709351276.17.1739595529246; Fri, 14 Feb 2025
 20:58:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214164520.1001211-1-ameryhung@gmail.com> <20250214164520.1001211-3-ameryhung@gmail.com>
 <CAADnVQJoUpZ8qNKSR7drX9nr1YE_Wcx+fM+FAeyMvXekr=ECDA@mail.gmail.com>
In-Reply-To: <CAADnVQJoUpZ8qNKSR7drX9nr1YE_Wcx+fM+FAeyMvXekr=ECDA@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 14 Feb 2025 20:58:37 -0800
X-Gm-Features: AWEUYZka2alzRxhS1yK792YRPT2lTF9q6iNwD0Ka_NniGXnZScfmwOXuH9coQ34
Message-ID: <CAMB2axM4SapP=OLLhwmuWN_t5cBf-2+DScNL5DePOgihR8_3cA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/5] bpf: Support getting referenced kptr from
 struct_ops argument
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 6:48=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Feb 14, 2025 at 8:45=E2=80=AFAM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > +               if (!is_nullable && !is_refcounted)
> >                         continue;
> >
> > +               if (is_nullable)
> > +                       suffix =3D MAYBE_NULL_SUFFIX;
> > +               else if (is_refcounted)
> > +                       suffix =3D REFCOUNTED_SUFFIX;
>
> I would remove the first 'if' and add:
>    else
>       continue;

That looks better than what it is. I will fix it.

>
> >                 /* Should be a pointer to struct */
> >                 pointed_type =3D btf_type_resolve_ptr(btf,
> >                                                     args[arg_no].type,
> > @@ -236,7 +246,7 @@ static int prepare_arg_info(struct btf *btf,
> >                 if (!pointed_type ||
> >                     !btf_type_is_struct(pointed_type)) {
> >                         pr_warn("stub function %s has %s tagging to an =
unsupported type\n",
> > -                               stub_fname, MAYBE_NULL_SUFFIX);
> > +                               stub_fname, suffix);
> >                         goto err_out;
> >                 }
> >
> > @@ -254,11 +264,15 @@ static int prepare_arg_info(struct btf *btf,
> >                 }
> >
> >                 /* Fill the information of the new argument */
> > -               info->reg_type =3D
> > -                       PTR_TRUSTED | PTR_TO_BTF_ID | PTR_MAYBE_NULL;
> >                 info->btf_id =3D arg_btf_id;
> >                 info->btf =3D btf;
> >                 info->offset =3D offset;
> > +               if (is_nullable) {
> > +                       info->reg_type =3D PTR_TRUSTED | PTR_TO_BTF_ID =
| PTR_MAYBE_NULL;
> > +               } else if (is_refcounted) {
> > +                       info->reg_type =3D PTR_TRUSTED | PTR_TO_BTF_ID;
> > +                       info->refcounted =3D true;
> > +               }
> >
> >                 info++;
> >                 info_cnt++;
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 9de6acddd479..fd3470fbd144 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6677,6 +6677,7 @@ bool btf_ctx_access(int off, int size, enum bpf_a=
ccess_type type,
> >                         info->reg_type =3D ctx_arg_info->reg_type;
> >                         info->btf =3D ctx_arg_info->btf ? : btf_vmlinux=
;
> >                         info->btf_id =3D ctx_arg_info->btf_id;
> > +                       info->ref_obj_id =3D ctx_arg_info->refcounted ?=
 ctx_arg_info->ref_obj_id : 0;
> >                         return true;
> >                 }
> >         }
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index a41ba019780f..a0f51903e977 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -1543,6 +1543,17 @@ static void release_reference_state(struct bpf_v=
erifier_state *state, int idx)
> >         return;
> >  }
> >
> > +static bool find_reference_state(struct bpf_verifier_state *state, int=
 ptr_id)
> > +{
> > +       int i;
> > +
> > +       for (i =3D 0; i < state->acquired_refs; i++)
> > +               if (state->refs[i].id =3D=3D ptr_id)
> > +                       return true;
> > +
> > +       return false;
> > +}
> > +
> >  static int release_lock_state(struct bpf_verifier_state *state, int ty=
pe, int id, void *ptr)
> >  {
> >         int i;
> > @@ -5981,7 +5992,8 @@ static int check_packet_access(struct bpf_verifie=
r_env *env, u32 regno, int off,
> >  /* check access to 'struct bpf_context' fields.  Supports fixed offset=
s only */
> >  static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx=
, int off, int size,
> >                             enum bpf_access_type t, enum bpf_reg_type *=
reg_type,
> > -                           struct btf **btf, u32 *btf_id, bool *is_ret=
val, bool is_ldsx)
> > +                           struct btf **btf, u32 *btf_id, bool *is_ret=
val, bool is_ldsx,
> > +                           u32 *ref_obj_id)
>
> It's ok-ish for now, but 11 arguments in a function is pushing it.
> We've accumulated enough tech debt here.
> Consider a follow up.

Definitely.

A quick look at the check_ctx_access(): Many arguments are used as
input+output at the same time and are part of bpf_insn_access_aux, so
we might as well just let the caller prepare bpf_insn_access_aux. This
should reduce 5 arguments already.

I will send a follow up patch to cleanup this part.

