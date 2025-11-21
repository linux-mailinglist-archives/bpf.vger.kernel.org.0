Return-Path: <bpf+bounces-75231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F10B2C7A231
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 15:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B1D14F4F4C
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 14:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264E534AAF7;
	Fri, 21 Nov 2025 14:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/zqiqoY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DE92D8766
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763734570; cv=none; b=fI6XIBLHMO3W2mZ6Uvw93sNt/lEFTLqLvdA0kgy7D63LsSN40dtmaeFLe89ex9D3j6Q9ARtm4yY1bNEDFd+Hmh2YvZC9dL4DCtfMhpCVVx+69EDRJL5aFtDFO5+4ysEh3L6orEBwiiuOzZKimZ9MSJGhmCCLlgpafov81h7cNgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763734570; c=relaxed/simple;
	bh=V6sF5pPGSgry/vEEJwE2Jtlu5MYHyGEOM2QA3weOWD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCK+a6gYE1zXwuTw39GZojNSOEtymbRjLXGtlzy5ekIvnDeN2yjbdyLO3Hj9Q/AYfu2ZdNBRcHqZHTL3JLMeau7LBBVOGb2f8LpMWG1w/B9QZfvvy8Audu9YrSR8E7akw9vgbAC1wy6N9/6peV8DeZoct1sgJ2nDMk1ymvmA+mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/zqiqoY; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64175dfc338so3645255a12.0
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 06:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763734567; x=1764339367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pv6JoU3MZycxscWLFz6XU5qCo+nXmLC2gkKBvAN+L0=;
        b=I/zqiqoY6eHK//dMkHgAIVMmZ3hsT48eh8vGb1YERv6YNqkvIwJHAM9vxKPUy8FMG9
         CjH+FBGfhFnZGS8P2/CTYNFQsKCmd9UjRHUDO2lnoObAg88XhyXaexfigZlTntUNStwW
         6fCrKrrLNZZGmuIbsAffWj6CegSd4d/LyFKUNtQ3ktIO9PSAETuGlv8ZjHE91LLiJpao
         leIWtbm2V6wI16Ck9MN/uUJd7fAAd8aBOcCzu5Rimvkn7dQz9b/2PDMJquthXw7VK7BU
         dMYAWMCyYEMys+6Kbr6oZgxW2U+GRaF0dcgJJp4iP58RgadwFtg/eQUYKlTz/RZm5e37
         p78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763734567; x=1764339367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1pv6JoU3MZycxscWLFz6XU5qCo+nXmLC2gkKBvAN+L0=;
        b=cMG4HMNQNt7GziIiQ8+tameP0poKN/QawnU8PKxdPbjrVfBL4diIuzgpr/tV7XD9eI
         bSGFDhBK3Mymm5zRDIkaC1BPpUPNYJEkm1zGAZgP+W/QUpknLt8KcWvi5sPa6Wj6DbZw
         4qT1uWBcEoAa6TP9ImszlZrFpcOarXle9XvmUaoL4zl3nlNAmtIh4Z+/mErMLEjKpkwZ
         Q7qppGmqsmLGHTs/6kCLHGj9lYmwKpDKUdWHNBj8RfYW8nFcObCV7Y+Y5lNiIbe/muIn
         rkP7sFWHOykK+GYnw7XU6k5+jji4ZfZ9h//oPC/egQ8PXPv1Uyn7AHrvmK1/tqoMzY3H
         0/vA==
X-Forwarded-Encrypted: i=1; AJvYcCWorKb8EFZBoRKAg8PH2CN8VrvA/DCWHDtM/F2pK8BlOiC7YVCOuVqw/633LuX7YQC1wJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpprOac7ZmbhFefXD5/ZhilXjfxY3dfsAmzIdszYn4T4BjsIjh
	n4UvgNsSU5IZuVPsutNLooeWhJEUon35DywLJlRl5Y38vaw2EiYTxOGxAcqZr0S7tI2QsEvfUtk
	qsWLZ/SIpo5Rob6LJQ7wLriC814fbQtw=
X-Gm-Gg: ASbGncshBxJiD7v5wJF6zSK1y6YUBolD83EaHiNCz/Ay017eFJM8xirYSOsq6IVAY/7
	VMfiD6UpQAgpTVGJ0pOb6Vmr05mp5YKvjMOaejMPEqgGedRi7nFAWo6GfO6rudzihf2sJo3b6ZS
	G3LiveikRLC1YzvehKpUh8O+KmlEs2/a/zH0gNWLmOTxgflpGANYOiJzkVVUhY3nfP/oOw/FG2M
	8DlTZsL+CVZMzEfz3sCLIlYktgiC7J/gXuIvJmmkleJcFoKTVjKcHuzq939Vb1GMusdAxAo
X-Google-Smtp-Source: AGHT+IFOY4Mb0rbCwjarYr4/giJ+O7wIO9u49h5cyjcCmcl09q2XSC8vkYNI6/yK7vEGBO1OcRzMuI140rgrZ+3HVuc=
X-Received: by 2002:a17:906:f5a8:b0:b73:826a:39df with SMTP id
 a640c23a62f3a-b76719eb78bmr231642966b.61.1763734566340; Fri, 21 Nov 2025
 06:16:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
 <20251119031531.1817099-2-dolinux.peng@gmail.com> <CAEf4Bzb76SfWfNtxP2WVJ44hsVU-GrePmeKKxH25Q8KOn_Mkfw@mail.gmail.com>
 <5315c03cd97af176065c86c0640461321c818887.camel@gmail.com>
In-Reply-To: <5315c03cd97af176065c86c0640461321c818887.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 21 Nov 2025 22:15:54 +0800
X-Gm-Features: AWmQ_blzRFWJZX8u3FJnsWEK5k5TAvcFqWOvg6SHKxcEiy_o7bzvILMAiXR_HQ4
Message-ID: <CAErzpmv1W69HTB=WjETaB0qz4WJsUE4zSMd7dJ2v7PLmr3mzhg@mail.gmail.com>
Subject: Re: [RFC PATCH v7 1/7] libbpf: Add BTF permutation support for type reordering
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@kernel.org, zhangxiaoqin@xiaomi.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 7:21=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-11-19 at 10:21 -0800, Andrii Nakryiko wrote:
> > On Tue, Nov 18, 2025 at 7:21=E2=80=AFPM Donglin Peng <dolinux.peng@gmai=
l.com> wrote:
>
> [...]
>
> > > +       nt =3D new_types;
> > > +       for (i =3D 0; i < new_nr_types; i++) {
> > > +               struct btf_field_iter it;
> > > +               const struct btf_type *t;
> > > +               __u32 *type_id;
> > > +               int type_size;
> > > +
> > > +               id =3D order_map[i];
> > > +               /* must be a valid type ID */
> >
> > redundant comment, please drop
> >
> > > +               t =3D btf__type_by_id(btf, id);
> > > +               if (!t) {
> >
> > no need to check this, we already validated that all types are valid ea=
rlier
> >
> > > +                       err =3D -EINVAL;
> > > +                       goto done;
> > > +               }
> > > +               type_size =3D btf_type_size(t);
> > > +               memcpy(nt, t, type_size);
> > > +
> > > +               /* Fix up referenced IDs for BTF */
> > > +               err =3D btf_field_iter_init(&it, nt, BTF_FIELD_ITER_I=
DS);
> > > +               if (err)
> > > +                       goto done;
> > > +               while ((type_id =3D btf_field_iter_next(&it))) {
> > > +                       err =3D btf_permute_remap_type_id(type_id, &p=
);
> > > +                       if (err)
> > > +                               goto done;
> > > +               }
> > > +
> > > +               nt +=3D type_size;
> > > +       }
> > > +
> > > +       /* Fix up referenced IDs for btf_ext */
> > > +       btf_ext =3D OPTS_GET(opts, btf_ext, NULL);
> > > +       if (btf_ext) {
> > > +               err =3D btf_ext_visit_type_ids(btf_ext, btf_permute_r=
emap_type_id, &p);
> > > +               if (err)
> > > +                       goto done;
> > > +       }
> > > +
> > > +       new_type_len =3D nt - new_types;
> >
> >
> > new_type_len has to be exactly the same as the old size, this is redund=
ant
> >
> > > +       next_type =3D new_types;
> > > +       end_type =3D next_type + new_type_len;
> > > +       i =3D 0;
> > > +       while (next_type + sizeof(struct btf_type) <=3D end_type) {
> >
> > while (next_type < end_type)?
> >
> > Reference to struct btf_type is confusing, as generally type is bigger
> > than just sizeof(struct btf_type). But there is no need for this, with
> > correct code next_type < end_type is sufficient check
> >
> > But really, this can also be written cleanly as a simple for loop
> >
> > for (i =3D 0; i < nr_types; i++) {
> >     btf->type_offs[i] =3D next_type - new_types;
> >     next_type +=3D btf_type_size(next_type);
> > }
> >
>
> Adding to what Andrii says, the whole group of assignments is
> reducible:
>
>   +       new_type_len =3D nt - new_types;
>   +       next_type =3D new_types;
>   +       end_type =3D next_type + new_type_len;
>
> =3D> end_type =3D new_types + new_type_len; // subst next_type -> new_typ=
es
> =3D> end_type =3D new_types + nt - new_types; // subst new_types -> nt - =
new_types
> =3D> end_type =3D nt
>
> Why recomputing it in such a convoluted way?

Sorry, I referred to the implementation of btf_parse_type_sec and could hav=
e
thought more about how to refactor it.

>
> > > +               btf->type_offs[i++] =3D next_type - new_types;
> > > +               next_type +=3D btf_type_size(next_type);
> > > +       }
> > > +
>
> [...]

