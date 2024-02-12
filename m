Return-Path: <bpf+bounces-21759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A57851DA6
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 20:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7551B1F21EC4
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 19:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA28647A53;
	Mon, 12 Feb 2024 19:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/7OaOEx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C837A4C60B
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 19:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707765101; cv=none; b=S3oeeLoJHqILrTrxeeuTQb9ZhFADUDPZvPMSgCxPgJelFlLMArMSvi/seSulNae3YCnyjAHHbcL4FD9fhphUMx2PoVIQnGDtIDXzaf08n5P5brsYKdTgY+cIRCZNgYqcglacqGttPuyKawq4jIi0p29pjs60aUHyulHJjArHiRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707765101; c=relaxed/simple;
	bh=uu0tNijahduA2skY7MM+5lIFyKYbSfPzOMgZucTtvkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkbptBYo4L4EMIrrYmO9TFUSP9mo63jYzZTcR0skMOiseWaTW4c9ps+TnHDcHShHJDPjWSWFSi9YEDB24+FVLt82TBdXME7hb5k5bKd9hmvDPABMmfoieUIXZ+fbmNERurgslCE5pA4pTk9nY8FQrl/1MSN6OijVjkBsONA1ceY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/7OaOEx; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e0eacc5078so557671b3a.0
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 11:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707765099; x=1708369899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUD0wC9KyENgwYKaRGo4h2B/QZ9QTMhsPhKclpkb0Ns=;
        b=S/7OaOEx0akGPxvD+rL4ozmgl/r0fF10rHqbVN2rm4KlCnSQXzgqniXoeMJIuNZum+
         U1cRnwPP6qGqRk0mOGrnKNwVX+C6lRGpyog6QCzbZJwJBBbSVsnjMhjmAU7cQMqaMMwF
         OwuP+wEu2vUdLxnxaFUO7Gx1yk06LQTrHKKN8Xjfz8NvvsEe9wYJcs0gIpEnyZK1SIIw
         ESzozMZSBy/YaPofYoY0eBBMQIcVeiD/JPGvKdw6t9GYHc7ZL5tV+fTEGUeL0SOmpxyz
         fb32XD2KkmArdGrhktyx5KTbndBSjQJFwQcA5qTG52gnUjANJ1pfH6snsRR6fdDFwE4C
         /MqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707765099; x=1708369899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUD0wC9KyENgwYKaRGo4h2B/QZ9QTMhsPhKclpkb0Ns=;
        b=eGulFd8xt0f5miK+QimckNhXRqXPwcfqMIxbcop7knw5buzYzrFH+arpRcahrvBNgo
         pjruypem8P00OhjKFUYwsoeBvs6Vnezi81TfcJTLY3s9QHcenrM3wgL030PgRekFhwc7
         I2uCjJCY+LPjANlTl2mZwBmNFhZOBwDYJzd5HNl8N4628Bql+1Krr4dq/UUKGRwdcYpu
         pNhw0TfDFxd/U/wwaULQkA+MGsoq8sb9YP8/2ra2TPJu8hsAR0eW7c6jyHYYlwKb+sFj
         w2APKhqnsB8ABCDVBKWk7+EkfUVzVW2komkPfaRzMBySQBum7zeDwP8LcuHmunxMAui+
         QOIA==
X-Forwarded-Encrypted: i=1; AJvYcCU812oYxxn5aRScMtrIJ2tg8sAaDMlo+r96RPTAkm8PHh41/JWmOVPldCASjWIr4Oncs67/5qmlveYBtDY0s2JnCH2Q
X-Gm-Message-State: AOJu0Yy/qP2sGIVmQNVVAM5VovofObxCKE/tPksrf5jhpMT6BLcz3v01
	A/TdL0018+asTMLH1aELnpJmjcmlHTmWFS6gC08b+iyOLk6pY02ns7ZEeVVLpbnTg1Vanz+gatA
	e6FIZrhRKAGKqr5YuTPYpLl4ki/VQea8DEDo=
X-Google-Smtp-Source: AGHT+IGNiw+DUyIDHERvScrza7oc6iEntlqOOfnknQgYeMWs6zMwCrObVgEuyc334tRqHNiDvuFjcvsNdUxxav3Hmr8=
X-Received: by 2002:a17:90b:380e:b0:296:43a:932e with SMTP id
 mq14-20020a17090b380e00b00296043a932emr5025578pjb.7.1707765098951; Mon, 12
 Feb 2024 11:11:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-13-alexei.starovoitov@gmail.com> <CAP01T761B1+paMwrQesjX+zqFwQp8iUzLORueTjTLSHPbJ+0fQ@mail.gmail.com>
In-Reply-To: <CAP01T761B1+paMwrQesjX+zqFwQp8iUzLORueTjTLSHPbJ+0fQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Feb 2024 11:11:27 -0800
Message-ID: <CAEf4BzYikhyH8TF8GJy9rLX1SrmGKz1xSd_zFhGYhvXtTFwMgA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 12/20] libbpf: Add support for bpf_arena.
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, tj@kernel.org, brho@google.com, 
	hannes@cmpxchg.org, lstoakes@gmail.com, akpm@linux-foundation.org, 
	urezki@gmail.com, hch@infradead.org, linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 11:17=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, 9 Feb 2024 at 05:07, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > mmap() bpf_arena right after creation, since the kernel needs to
> > remember the address returned from mmap. This is user_vm_start.
> > LLVM will generate bpf_arena_cast_user() instructions where
> > necessary and JIT will add upper 32-bit of user_vm_start
> > to such pointers.
> >
> > Fix up bpf_map_mmap_sz() to compute mmap size as
> > map->value_size * map->max_entries for arrays and
> > PAGE_SIZE * map->max_entries for arena.
> >
> > Don't set BTF at arena creation time, since it doesn't support it.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf.c        | 43 ++++++++++++++++++++++++++++++-----
> >  tools/lib/bpf/libbpf_probes.c |  7 ++++++
> >  2 files changed, 44 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 01f407591a92..4880d623098d 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -185,6 +185,7 @@ static const char * const map_type_name[] =3D {
> >         [BPF_MAP_TYPE_BLOOM_FILTER]             =3D "bloom_filter",
> >         [BPF_MAP_TYPE_USER_RINGBUF]             =3D "user_ringbuf",
> >         [BPF_MAP_TYPE_CGRP_STORAGE]             =3D "cgrp_storage",
> > +       [BPF_MAP_TYPE_ARENA]                    =3D "arena",
> >  };
> >
> >  static const char * const prog_type_name[] =3D {
> > @@ -1577,7 +1578,7 @@ static struct bpf_map *bpf_object__add_map(struct=
 bpf_object *obj)
> >         return map;
> >  }
> >
> > -static size_t bpf_map_mmap_sz(unsigned int value_sz, unsigned int max_=
entries)
> > +static size_t __bpf_map_mmap_sz(unsigned int value_sz, unsigned int ma=
x_entries)
> >  {
> >         const long page_sz =3D sysconf(_SC_PAGE_SIZE);
> >         size_t map_sz;
> > @@ -1587,6 +1588,20 @@ static size_t bpf_map_mmap_sz(unsigned int value=
_sz, unsigned int max_entries)
> >         return map_sz;
> >  }
> >
> > +static size_t bpf_map_mmap_sz(const struct bpf_map *map)
> > +{
> > +       const long page_sz =3D sysconf(_SC_PAGE_SIZE);
> > +
> > +       switch (map->def.type) {
> > +       case BPF_MAP_TYPE_ARRAY:
> > +               return __bpf_map_mmap_sz(map->def.value_size, map->def.=
max_entries);
> > +       case BPF_MAP_TYPE_ARENA:
> > +               return page_sz * map->def.max_entries;
> > +       default:
> > +               return 0; /* not supported */
> > +       }
> > +}
> > +
> >  static int bpf_map_mmap_resize(struct bpf_map *map, size_t old_sz, siz=
e_t new_sz)
> >  {
> >         void *mmaped;
> > @@ -1740,7 +1755,7 @@ bpf_object__init_internal_map(struct bpf_object *=
obj, enum libbpf_map_type type,
> >         pr_debug("map '%s' (global data): at sec_idx %d, offset %zu, fl=
ags %x.\n",
> >                  map->name, map->sec_idx, map->sec_offset, def->map_fla=
gs);
> >
> > -       mmap_sz =3D bpf_map_mmap_sz(map->def.value_size, map->def.max_e=
ntries);
> > +       mmap_sz =3D bpf_map_mmap_sz(map);
> >         map->mmaped =3D mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE,
> >                            MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> >         if (map->mmaped =3D=3D MAP_FAILED) {
> > @@ -4852,6 +4867,7 @@ static int bpf_object__create_map(struct bpf_obje=
ct *obj, struct bpf_map *map, b
> >         case BPF_MAP_TYPE_SOCKHASH:
> >         case BPF_MAP_TYPE_QUEUE:
> >         case BPF_MAP_TYPE_STACK:
> > +       case BPF_MAP_TYPE_ARENA:
> >                 create_attr.btf_fd =3D 0;
> >                 create_attr.btf_key_type_id =3D 0;
> >                 create_attr.btf_value_type_id =3D 0;
> > @@ -4908,6 +4924,21 @@ static int bpf_object__create_map(struct bpf_obj=
ect *obj, struct bpf_map *map, b
> >         if (map->fd =3D=3D map_fd)
> >                 return 0;
> >
> > +       if (def->type =3D=3D BPF_MAP_TYPE_ARENA) {
> > +               map->mmaped =3D mmap((void *)map->map_extra, bpf_map_mm=
ap_sz(map),
> > +                                  PROT_READ | PROT_WRITE,
> > +                                  map->map_extra ? MAP_SHARED | MAP_FI=
XED : MAP_SHARED,
> > +                                  map_fd, 0);
> > +               if (map->mmaped =3D=3D MAP_FAILED) {
> > +                       err =3D -errno;
> > +                       map->mmaped =3D NULL;
> > +                       close(map_fd);
> > +                       pr_warn("map '%s': failed to mmap bpf_arena: %d=
\n",
> > +                               bpf_map__name(map), err);
> > +                       return err;
> > +               }
> > +       }
> > +
>
> Would it be possible to introduce a public API accessor for getting
> the value of map->mmaped?

That would be bpf_map__initial_value(), no?

> Otherwise one would have to parse through /proc/self/maps in case
> map_extra is 0.
>
> The use case is to be able to use the arena as a backing store for
> userspace malloc arenas, so that
> we can pass through malloc/mallocx calls (or class specific operator
> new) directly to malloc arena using the BPF arena.
> In such a case a lot of the burden of converting existing data
> structures or code can be avoided by making much of the process
> transparent.
> Userspace malloced objects can also be easily shared to BPF progs as a
> pool through bpf_ma style per-CPU allocator.
>
> > [...]

