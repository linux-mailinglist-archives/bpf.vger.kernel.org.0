Return-Path: <bpf+bounces-36207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB438944222
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 06:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833791F222C8
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 04:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB39B13D602;
	Thu,  1 Aug 2024 04:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EepdKWth"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CE5208A0
	for <bpf@vger.kernel.org>; Thu,  1 Aug 2024 04:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722485239; cv=none; b=JvcNHJp8JnFfUUP3GzI2nvGIprm9+tydruRQG/j0uvoibeQ+NGGNsQHr4j2iyWuODnpMmPzA841jIfvHxYqc/4CRILLSxqPUWb4uk6P5vBSNtG9zIKVsxaYHhB7yh7tJBfDtQtpzTEK/C+qOqd4LqtFslZrIW9AK1hRJpXDe+K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722485239; c=relaxed/simple;
	bh=6Mb60cvCPVQyUd+TqeEj1JEQt8VV/5RgMRUVzDPZMjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xyhv5TsYqOaK5G2g9Tvabdq9Zh1BPucecfDVnx4RGs4CPCFEkmTL7CeP5rOSKzMicj8hgxwdZbmNSswHtvPG04ojRE2VGAYI28898n6uoyS5sndtBOZaHyP3kbjSbhA8jfPLiUTeqqkhuolNrTTJcNjkGzBC5zYQvxkOib3sUg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EepdKWth; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e026a2238d8so2257462276.0
        for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 21:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722485237; x=1723090037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXERcDSV9H4+3Ko5qOftgu3dPDR9HKlo5Wwu3O2Y3h8=;
        b=EepdKWth248vKnFdiTFVZIiwx68giXFZ8Gx3wbh3sD6Gr+Kg6CeO2ovw8KEc/NQrXO
         CrqWYOb8unYg0AL1fbxIaoAL51LQhC6GuF2HVUFftcSILZk54TMztk89QF7wuF3z/7RA
         lNNJQ1AzKS7PTkhTtzBm/dNGwOHcOSBouH9inLWMi5cxjYdWltNNP/CJT4sTLKTWBzg9
         JB2iYtjMmGarqjGyIg/3rF10W8wyyQOr6GnPaKuBPvzvmkQimBoRFsyR1Ibtu+2ZX+YT
         fhL8ZF6mValOjM+3Pbql+BzctxWD0FNjRXE1/CYl91cF7mF4AYSYU3cv4JUGC5ezk0ei
         glag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722485237; x=1723090037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXERcDSV9H4+3Ko5qOftgu3dPDR9HKlo5Wwu3O2Y3h8=;
        b=Z3P77ZWZUGGntMKmKl1KbAQ/kI3F6lFa40XqVGkpBfWlKouurk9H6HbLdxCIsJEeGz
         OnvtK7lM4/huDszV6PQai2nslfmfzLalQVs0zMWwVFRwTmXfH9i9zLNR456kCR4c2gaH
         ql/X/6k+7RaybOqqIcRGMbU/z9cWyWTv+z2tYefLfuT06HBWbifv3/zRR0LLAA0Jz3Tw
         mO1L/nycYCywKBpH4Zy7rn7f3eSibO5TKyGYaVkpzSZPA8nxh7vpLILNtEqWGBJBcFus
         dj8ZHks0TmaVxj8W4zT01h04K/WIR1tRIkYFLiXLveY7KCtyJmizNrXLn33fIDuA0rf0
         93Ug==
X-Gm-Message-State: AOJu0Ywliptonv3MU7PT50D71bbU+tIlkALC0CnJY+0UMdV4fcZA4FCl
	yJNs8Nedz5YVVV/vuDyVr8oHEMbPhuYAes12ZS/fbUQ1WQmDznPYdx/oqlABnwAjC/F4hlTCOUs
	OgD7/FVGV4qSlTI7utde+8fUVOV4=
X-Google-Smtp-Source: AGHT+IEZkYdUV+YVkDNAYOJ9UrMA8iprwQMBR9rAQOBTK7CH7fQMx4FlFI6PozQh4tnqloCEa4rh3LN1CHMvFXf3XR8=
X-Received: by 2002:a05:6902:15c1:b0:e08:5f3e:2e45 with SMTP id
 3f1490d57ef6-e0bcd39115emr1543408276.38.1722485236921; Wed, 31 Jul 2024
 21:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728030115.3970543-1-amery.hung@bytedance.com>
 <20240728030115.3970543-4-amery.hung@bytedance.com> <fa767cc5-b330-4789-9a5e-e09e0f224c4e@linux.dev>
In-Reply-To: <fa767cc5-b330-4789-9a5e-e09e0f224c4e@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 31 Jul 2024 21:07:05 -0700
Message-ID: <CAMB2axMxKdweeH0YfPv=MtVHHMCby6xyBeih5UoEo8b-=1j2_w@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 3/4] bpf: Support bpf_kptr_xchg into local kptr
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, sinquersw@gmail.com, 
	davemarchevsky@fb.com, Amery Hung <amery.hung@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 4:38=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 7/27/24 8:01 PM, Amery Hung wrote:
> > @@ -8399,7 +8408,12 @@ static const struct bpf_reg_types func_ptr_types=
 =3D { .types =3D { PTR_TO_FUNC } };
> >   static const struct bpf_reg_types stack_ptr_types =3D { .types =3D { =
PTR_TO_STACK } };
> >   static const struct bpf_reg_types const_str_ptr_types =3D { .types =
=3D { PTR_TO_MAP_VALUE } };
> >   static const struct bpf_reg_types timer_types =3D { .types =3D { PTR_=
TO_MAP_VALUE } };
> > -static const struct bpf_reg_types kptr_xchg_dest_types =3D { .types =
=3D { PTR_TO_MAP_VALUE } };
> > +static const struct bpf_reg_types kptr_xchg_dest_types =3D {
> > +     .types =3D {
> > +             PTR_TO_MAP_VALUE,
> > +             PTR_TO_BTF_ID | MEM_ALLOC
> > +     }
> > +};
> >   static const struct bpf_reg_types dynptr_types =3D {
> >       .types =3D {
> >               PTR_TO_STACK,
> > @@ -8470,7 +8484,8 @@ static int check_reg_type(struct bpf_verifier_env=
 *env, u32 regno,
> >       if (base_type(arg_type) =3D=3D ARG_PTR_TO_MEM)
> >               type &=3D ~DYNPTR_TYPE_FLAG_MASK;
> >
> > -     if (meta->func_id =3D=3D BPF_FUNC_kptr_xchg && type_is_alloc(type=
)) {
> > +     /* local kptr types are allowed as the source argument of bpf_kpt=
r_xchg */
> > +     if (meta->func_id =3D=3D BPF_FUNC_kptr_xchg && type_is_alloc(type=
) && regno =3D=3D BPF_REG_2) {
> >               type &=3D ~MEM_ALLOC;
> >               type &=3D ~MEM_PERCPU;
> >       }
> > @@ -8563,7 +8578,7 @@ static int check_reg_type(struct bpf_verifier_env=
 *env, u32 regno,
> >                       verbose(env, "verifier internal error: unimplemen=
ted handling of MEM_ALLOC\n");
> >                       return -EFAULT;
> >               }
> > -             if (meta->func_id =3D=3D BPF_FUNC_kptr_xchg) {
> > +             if (meta->func_id =3D=3D BPF_FUNC_kptr_xchg && regno =3D=
=3D BPF_REG_2) {
>
> I think this BPF_REG_2 check is because the dst (BPF_REG_1) can be MEM_AL=
LOC
> now. Just want to ensure I understand it correctly.
>

Right. I can add a comment for this too if that helps:
/* Check if local kptr in src arg matches kptr in dst arg */

> One nit. Please also update the document for bpf_kptr_xchg in uapi/linux/=
bpf.h:
>
> =3D=3D=3D=3D >8888 =3D=3D=3D=3D
>   * void *bpf_kptr_xchg(void *map_value, void *ptr)
>   *      Description
>   *              Exchange kptr at pointer *map_value* with *ptr*, and ret=
urn the
> =3D=3D=3D=3D 8888< =3D=3D=3D=3D
>

Got it. I will change the first argument from "map_value" to "dst" and
the description to reflect what this series does.

Thanks,
Amery

