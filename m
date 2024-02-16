Return-Path: <bpf+bounces-22130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCE4857568
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 05:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E56E3B22941
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 04:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E0211C85;
	Fri, 16 Feb 2024 04:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+BFY/NC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332ED10A0C
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 04:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708059079; cv=none; b=ViVtrinGI7tDKBIk2CqFnN5sO5zEiUygXnsKnKSz9cSr1s3UMhBx9ZKS7cxOlRk4DrU3ZzAbiBvXFpdcl5zNOIW9G31KHf8EI8FsxpFb480E/DUm3L5KEoVwii2sA5nx0xfiUQtexoRQ3zn1u4qeLBh8IBP6IA1fUFShj5mKoYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708059079; c=relaxed/simple;
	bh=sZkwodbNn+Omf9UdP2MEEvY0C/w/SAvFpeCUFSESngA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DrzF+NdkewAaIOVVDn+44szag5t5g78ddhIzN69wFfNUGOwVhuFIxT7vv3y/lse/PvHt6ET0f6OHPQaE0vXe8s4zdIP/Ax0go/elIvdklWsHSIINW6QdVz5yJguYCmySr+6SXTl9HpLlxPuT4WsAUvvUHRUZDvwaf6l0bMo40Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+BFY/NC; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d944e8f367so15719525ad.0
        for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 20:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708059077; x=1708663877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6/VJ0JfXKC1lOJsbcyV+No0q+mraHhGZvW0Oa6VLFc=;
        b=E+BFY/NCTygS77JU4LhivpjQe/0ujGegYKedYF3XCgxNfsUtlfle4hfb9W3Ojv78QK
         ipM8CLC7bhfyaghx1l+B81Ub+IYZB9S86XaV+/X9LgR0KcwTEFe/OKJ59HImZ1SlGKns
         rMQurE7UMBJsiFRGL7hTmCPX5j2AIZbW6LHiIP8NbojpX2tqaDBVu/to1770oXd99GUE
         Usawym1YhLWThkDbQmhCzle1foHlB3NOH7sqjmEwpZl9Nwt7kH95RlFibDR19dvyHjS4
         JrM8Rth8AC9KSLXcLfw2Ark8hmvcft7IfEbEbvBSSauGE/s6MwdvS/yo2MVI8QlRjUAB
         asHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708059077; x=1708663877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6/VJ0JfXKC1lOJsbcyV+No0q+mraHhGZvW0Oa6VLFc=;
        b=cyUaTZOTozQXlz8dhp6Uxf6YoFzkYLdVrqkxKfLrTmRdGukyTTzgL+Q+meq/WOc5wo
         2jTopjkjKoQh++jUHkn8GOcDA/gVE0GaDoSm82fH59a3OdIYW/GKfON9fM2wL5EFmTsl
         IBgGKePfpngSMhs1HzHYd8FQw0430Uwk6oSNohBnMYv9ZRpjzOnTOOWxUTGiHNRuGQKs
         O2tOz2I6vRdpY3dz5Mox8m7u+jEEpy6ixNNnjonqfesrPtaEP8vuZX1ew6SmvsZpal8D
         nvPpORYbxEfD6ZkR2JCgq4ePBWJs4Omp0Ki7HGzQ7Ke/NcbuJ9lrf4U0ETsNSgSGMHSj
         MHiw==
X-Forwarded-Encrypted: i=1; AJvYcCXjGWryFefROwx1hrFo3Rg7SZO/9PZEu4otyZ54y2DxATAlqbzi40JGahN8E77U5L6JHQrliPLdR6+W16kM8WI1Q06P
X-Gm-Message-State: AOJu0Yz4pwf1LnG7S4ta0yYb8bG6PHLBY5sg4q1h3e7DGPGeHy+mrKLc
	K7XFaV9txJhW0UmrWAWL1h+kXbYxbGdiidBdZeOVMrjzOI1ABqTkZpVbUQPy+Zi02EOj/CQwEaL
	OWJzkFqRLpj1DtUDOf1s2/GUB3Fo=
X-Google-Smtp-Source: AGHT+IHNYBImYYUc1t4TDkDT16OADsr/q5qavH8/DXizlPeWEyL5RdPBIcCQUxqloBxJE8qGLdpCuj0axkF4vdQZPFA=
X-Received: by 2002:a17:90b:fd6:b0:299:c65:db3a with SMTP id
 gd22-20020a17090b0fd600b002990c65db3amr3026120pjb.46.1708059077320; Thu, 15
 Feb 2024 20:51:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-15-alexei.starovoitov@gmail.com> <e9fbe163f0273448142ba70b2cf8a13b6cca57ad.camel@gmail.com>
 <CAEf4BzYbkqhrPCY1RfyHHY1nq-fmpxP2O-n0gMzWoDFe4Msofw@mail.gmail.com>
 <7af0d2e0cc168eb8f57be0fe185d7fa9caf87824.camel@gmail.com>
 <CAEf4BzZyPDdtV8xyFxpLmPQpKrtO-affGrEfyDkodr_BDHVZcA@mail.gmail.com>
 <CAADnVQKY0UKYRUBmUZ8BPUrcx-t-v6iMz7u0AaBUKLB1-CS0qg@mail.gmail.com>
 <CAEf4BzY8grOqDUOAuvyBw+t1oZh6x_6xubHePv3byxV3sC9uVg@mail.gmail.com>
 <CAEf4BzapMe_zjrN9j7w41xP05VZOV_Nys9kwks7yCC312Omdpg@mail.gmail.com> <CAADnVQJROT_DYp_PmQrrM3NU-rt94gynDw1Y=dNc3jgaSVNDHA@mail.gmail.com>
In-Reply-To: <CAADnVQJROT_DYp_PmQrrM3NU-rt94gynDw1Y=dNc3jgaSVNDHA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Feb 2024 20:51:05 -0800
Message-ID: <CAEf4BzbeKSfhDnspJaDNZ8bHtCy9Zupcq6cOUQA=ZzOzm38phg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 14/20] libbpf: Recognize __arena global varaibles.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 6:45=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Feb 15, 2024 at 3:22=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> >  {
> > @@ -2835,6 +2819,33 @@ static int
> > bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
> >              return err;
> >      }
> >
> > +    for (i =3D 0; i < obj->nr_maps; i++) {
> > +        struct bpf_map *map =3D &obj->maps[i];
> > +
> > +        if (map->def.type !=3D BPF_MAP_TYPE_ARENA)
> > +            continue;
> > +
> > +        if (obj->arena_map) {
> > +            pr_warn("map '%s': only single ARENA map is supported
> > (map '%s' is also ARENA)\n",
> > +                map->name, obj->arena_map->name);
> > +            return -EINVAL;
> > +        }
> > +        obj->arena_map =3D map;
> > +
> > +        if (obj->efile.arena_data) {
> > +            err =3D init_arena_map_data(obj, map, ARENA_SEC,
> > obj->efile.arena_data_shndx,
> > +                          obj->efile.arena_data->d_buf,
> > +                          obj->efile.arena_data->d_size);
> > +            if (err)
> > +                return err;
> > +        }
> > +    }
> > +    if (obj->efile.arena_data && !obj->arena_map) {
> > +        pr_warn("elf: sec '%s': to use global __arena variables the
> > ARENA map should be explicitly declared in SEC(\".maps\")\n",
> > +            ARENA_SEC);
> > +        return -ENOENT;
> > +    }
> > +
> >      return 0;
> >  }
> >
> > @@ -3699,9 +3710,8 @@ static int bpf_object__elf_collect(struct bpf_obj=
ect *obj)
> >                  obj->efile.st_ops_link_data =3D data;
> >                  obj->efile.st_ops_link_shndx =3D idx;
> >              } else if (strcmp(name, ARENA_SEC) =3D=3D 0) {
> > -                sec_desc->sec_type =3D SEC_ARENA;
> > -                sec_desc->shdr =3D sh;
> > -                sec_desc->data =3D data;
> > +                obj->efile.arena_data =3D data;
> > +                obj->efile.arena_data_shndx =3D idx;
>
> I see. So these two are sort-of main tricks.
> Special case ARENA_SEC like ".maps" and then look for this
> obj level map in the right spots.

yep

> The special case around bpf_map__[set_]initial_value kind break
> the layering with:
> if (map->def.type =3D=3D BPF_MAP_TYPE_ARENA)
>   actual_sz =3D map->obj->arena_data_sz;
> but no big deal.
>

true, and struct_ops will be another special case, so we might want to
think about generalizing that a bit, but that's a separate thing we
can handle later on

> How do you want me to squash the patches?
> Keep "rename is_internal_mmapable_map into is_mmapable_map" patch as-is

yep

> and then squash mine and your 2nd and 3rd?

I think `libbpf: move post-creation steps for ARENA map` should be
squashed into your `libbpf: Add support for bpf_arena.` which
introduces ARENA map by itself. And then `libbpf: Recognize __arena
global varaibles.` and `libbpf: remove fake __arena_internal map` can
be squashed together as well.

