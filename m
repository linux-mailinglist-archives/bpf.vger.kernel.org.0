Return-Path: <bpf+bounces-76785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E1ECC5655
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 23:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F9C13029B5B
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 22:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E1B33B6E9;
	Tue, 16 Dec 2025 22:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgU5wE0V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586CF3595D
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 22:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765925247; cv=none; b=XH0xE0Ke49TYSb6IY215dyNRFpp5GXnP5HH2s0A7irE4kdFZBqG83zB5gm5+txwwMpB7jcesRXy9zEuHti7J2lGeDgj4QGjJE1AdpJRyhMoyMF0x/io5lg0kbVop7uAOmY6k8zS0q5rrPJGiLIzidhY7Mne4yBaFnY3ySUcUTBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765925247; c=relaxed/simple;
	bh=Bu6eVvhK4RnBoMtzRvYaWxpcQTE+gYZoNK3ZVr3zDFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FlnPtx+zDCST8ddS+GsADkZrtR04WytTdZZU3Q4yf7rsTUOhKX/OCkwlwydfyCeKZHZXxeiU4SsmVLkIzK4bvu0UwpgVskjSX/DFUzyPiGsGjQfOdgk7hlcakRI3sBKW53/S8+sysMvCJWNk+Qmk5MQV2bs9deB/RdhtJNL8h/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgU5wE0V; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a12ed4d205so16276595ad.0
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 14:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765925246; x=1766530046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeqNnAjhWX18kI1jaAfZXs2mT/RmVI+nfMow2139DWM=;
        b=kgU5wE0Vcnlvwqba7ORsU4FRiNXFi2DunXCJ0qPJv7eUF9ewiTZtl6gEhm2qAG7dxW
         D9DboKLjhc/DWiHwO5SJBjau3GdunoT/Icef0rLu6rmLJmT99VwGFmmcJilHwtGudI14
         gu8Jauh0Ls/VjDs3jbUB6+xUgQLY35YpMgwWxIZiYzWqxwDcM/AJI1z3greCAa2YeEgm
         2MAQ0wy3WjjmBPNQ2YI7/wur/Ql9w20oRTcwPFdo++bcWu7dAIUnxT88ummT7tPv78bx
         7x3DgglimxmUHrbafqsl+9g30iF8MYGwNI/OjDNaErjutgIidVERgHYAYQfGRsicnDoo
         7vCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765925246; x=1766530046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QeqNnAjhWX18kI1jaAfZXs2mT/RmVI+nfMow2139DWM=;
        b=hQHbQqEg0n9IK7ebFpbbbndBPk+Argt5DVc8Q4AlPdwT6Xe3//wvYiIaCJEIC4Y543
         lhWDwDLgQs/IlBvN62fKz4iF9ZZiztjUFNFpumR4u04Re3ANYFSwTCYtUQV4qs+x7u12
         sxdJDrHamdCao99lQs4JDmY38bNaqBVvl0XMydpH7B7Tc7eDFM087exeu1A9WoVa+XVu
         35KrIOlyCHje0eKLg4k+oQIeGF65rOLYcut+2tnz6wYbkmY1If+Gf7Fj0/2C/p7wY03S
         XslHhn0GPmha1hjJsLiEdt0HnVKaCNTKZFOwX0W+1/I/hQ57jTWFxt/2FApZH5BPtQht
         /aDw==
X-Forwarded-Encrypted: i=1; AJvYcCUx28La4DU2DkUSvol2F42j6a0JqkZpr5wygnFey4ho9wlltNolxsB1vQTneZBsdDVbSnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMKEolCVey4NTOTz1/NADApp5NFe5WW4FKJImaQX6ijJZF1ljq
	KEZ37lGjyk3PBciT1JUtUVwo3zgwnwmGvEwKyGeoHPe/HgOiHb7SX3QqNMSfsEDMQXD/B4WXtl5
	eoyV0UAJFMVIpKW+YdqsNs6vgyGYmdVw=
X-Gm-Gg: AY/fxX6g/q9x8/07ZJq9WjfkpXS76nVQY2yp4Ppcxo8f6NFtxElS+MCcjhtdZ80LisY
	+0UFyfanJ2DMA8eguSJPbcpf+GtcGx5g1k/vJRYhLKEg1cAwZFLiax7qnAVWotAn3mBN8/r7ZvX
	pVWgknYQQZS1BpSAXNqL4ebmrJFbw96kuWYIbs15PvY5SQHwfMk0cCLM2nZX4r8eFwuQULQh9+m
	WAmMtlRmmIlGEh+pK5bCYSDHfT2eZTWD2o7FVr4j38fqOGlLaVs7lM6DbaRWa4oZY9mz0F8uIKx
	6AtbIZGWQNGamerO8VIJPQ==
X-Google-Smtp-Source: AGHT+IH9i900IEfvX2zBaxoajzAebLGoc1UjVSWjVOFy5p1wGPG9Q2AuCelCk2XH7DXKxTkCdVgug8SgQO5WBMRo3q0=
X-Received: by 2002:a17:902:f609:b0:2a0:8e35:969d with SMTP id
 d9443c01a7336-2a08e359c2fmr166902515ad.39.1765925245541; Tue, 16 Dec 2025
 14:47:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208062353.1702672-1-dolinux.peng@gmail.com>
 <20251208062353.1702672-2-dolinux.peng@gmail.com> <3777b2f096877a9965a0fa6905fbabb06826d13f.camel@gmail.com>
In-Reply-To: <3777b2f096877a9965a0fa6905fbabb06826d13f.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Dec 2025 14:47:13 -0800
X-Gm-Features: AQt7F2qw-ND6p_xvWdqXJLJ_HFct2_i7zgd8PPAQwjmtPw060QzJUoydSqA6IkA
Message-ID: <CAEf4BzY_k721TBfRSUeq5mB-7fgJhVKCeXVKO-W2EjQ0aS9AgA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 01/10] libbpf: Add BTF permutation support for
 type reordering
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 2:00=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2025-12-08 at 14:23 +0800, Donglin Peng wrote:
> > From: pengdonglin <pengdonglin@xiaomi.com>
> >
> > Introduce btf__permute() API to allow in-place rearrangement of BTF typ=
es.
> > This function reorganizes BTF type order according to a provided array =
of
> > type IDs, updating all type references to maintain consistency.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> > index cc01494d6210..ba67e5457e3a 100644
> > --- a/tools/lib/bpf/btf.h
> > +++ b/tools/lib/bpf/btf.h
> > @@ -281,6 +281,42 @@ LIBBPF_API int btf__dedup(struct btf *btf, const s=
truct btf_dedup_opts *opts);
> >   */
> >  LIBBPF_API int btf__relocate(struct btf *btf, const struct btf *base_b=
tf);
> >
> > +struct btf_permute_opts {
> > +     size_t sz;
> > +     /* optional .BTF.ext info along the main BTF info */
> > +     struct btf_ext *btf_ext;
> > +     size_t :0;
> > +};
> > +#define btf_permute_opts__last_field btf_ext
> > +
> > +/**
> > + * @brief **btf__permute()** performs in-place BTF type rearrangement
> > + * @param btf BTF object to permute
> > + * @param id_map Array mapping original type IDs to new IDs
> > + * @param id_map_cnt Number of elements in @id_map
> > + * @param opts Optional parameters for BTF extension updates
> > + * @return 0 on success, negative error code on failure
> > + *
> > + * **btf__permute()** rearranges BTF types according to the specified =
ID mapping.
> > + * The @id_map array defines the new type ID for each original type ID=
.
> > + *
> > + * For **base BTF**:
> > + * - @id_map must include all types from ID 1 to `btf__type_cnt(btf)-1=
`
> > + * - @id_map_cnt should be `btf__type_cnt(btf) - 1`
> > + * - Mapping uses `id_map[original_id - 1] =3D new_id`

I don't really like this - 1 here. Conceptually BTF starts at type #0,
which is hard-coded to VOID type. User cannot redefine or remap it,
but it's still there. So let's include this into id_map contract,
id_map[0] has to be zero, for and then id_map[original_id] =3D new_id.
For split BTF, types are shifted by amount of types that are in base
BTF, so id_map[original_id - btf__type_cnt(base)] =3D new_id. And that's
purely to not waste memory, because otherwise id_map[original_id] =3D
new_id would be the simplest and best API (but we don't want to force
users to allocate many kilobytes of zeroes, no?).

So funny enough, internal implementation will be inconsistent
(start_id doesn't work for base BTF case), but external contract will
be consistent.

> > + *
> > + * For **split BTF**:
> > + * - @id_map should cover only split types
> > + * - @id_map_cnt should be `btf__type_cnt(btf) - btf__type_cnt(btf__ba=
se_btf(btf))`
> > + * - Mapping uses `id_map[original_id - btf__type_cnt(btf__base_btf(bt=
f))] =3D new_id`
>
> Nit: internally the rule does not have special cases:
>
>        id_map[original_id - start_id] =3D new_id
>
>      So, maybe there is no need split these cases in the docstring?
>      Otherwise it is not immediately clear that both cases are handled
>      uniformly.
>
> > + *
> > + * On error, returns negative error code and sets errno:
> > + *   - `-EINVAL`: Invalid parameters or ID mapping (duplicates, out-of=
-range)
> > + *   - `-ENOMEM`: Memory allocation failure
> > + */
> > +LIBBPF_API int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_m=
ap_cnt,
> > +                         const struct btf_permute_opts *opts);
> > +
> >  struct btf_dump;
> >
> >  struct btf_dump_opts {
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index 8ed8749907d4..b778e5a5d0a8 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -451,4 +451,5 @@ LIBBPF_1.7.0 {
> >       global:
> >               bpf_map__set_exclusive_program;
> >               bpf_map__exclusive_program;
> > +             btf__permute;
> >  } LIBBPF_1.6.0;

