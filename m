Return-Path: <bpf+bounces-30846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1A68D3A46
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 17:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8EB1F234D5
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 15:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EE917DE1D;
	Wed, 29 May 2024 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Asd98Lak"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC11315B11A
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716995083; cv=none; b=bOlIjVnOf/omgjfKUKLP78PsfcQTY7D03UREl8Kk8TkBxtD7SrypchiPLkUJ+7Ifnp9cugkRjmEsxzDLu/hL/uuSAIA0Zu6wtwGzZlDhWHsEitREzjj3ubAzHArTrbiM5klduzVKdao3uBSbM/AyFhSNLFhDjVDMkeLAG3nXUsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716995083; c=relaxed/simple;
	bh=2F54Q6erBr+8Xi0/uHxbPK1qtGGQEZ9OUZPRNTDR4ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIkianMCFoQKiI+U7xTZCpTTV1m7S8CU94QD0sMF2wNZhyPVOQZQJtEwVK8efQdDXr1rGTkevj1Q/Xm4QVTSmm0zGVTK2mZAL6qRAe5ePgvpM9Q3jsYg8fWTlnkK99SfDkZcmNKSCxsiCDu+nDtcr2gq5YiE6ib7dGLyPbiXXUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Asd98Lak; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5785eab8d5dso2446215a12.3
        for <bpf@vger.kernel.org>; Wed, 29 May 2024 08:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716995080; x=1717599880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTPyIXr8Hr3ineOTCxQCvYh45ZQG6YuNmIKu7WnPeHo=;
        b=Asd98LakNYP+qW9BhtLzOtkNHRbYbRXMRJubNgov2bVlAnZcAatgatUWRWjFV4C3yK
         oggs4hMtJnYXGI0VQ7wq8mRROXSP3JsfUbtvLZCVjvILvOP4c00Pd6aQkyKIKoc1pe47
         WKbMeZ9nduFQiX3mUTXdwhrOvQGejnAFfq1j1zsN2S8QeOCLvmqzBAFWtqtygzMYfwqc
         6PP/FbbkLGL4ke4iS/loy8P2FF8i1BUPLYrCb/jNXThHhg4buuuD260pmDX+jXJJ6KI+
         xrsXgXXTvGiI2++i9ft0tKxSF77BdRoqjHgMdWjKZGOixrX5zLKpI7VYtQAFaFiNV/4W
         FP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716995080; x=1717599880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTPyIXr8Hr3ineOTCxQCvYh45ZQG6YuNmIKu7WnPeHo=;
        b=TGquMlq5ylD6AlUnRV/3tJNq62QiecRuWopCdHdbV9y657UZdU5YXVKjy+pnpBVv8z
         rywKPASdbCIh0AFZmc6xTjm2EQ+k/SwAZWRzPEkyNskwpCCOmnoZc3QrW2KCKTKMH2yl
         xmHsYG/y1kzDRr9w9fb1GkfFg5RtMVTUTSseLcjYTLhAMKsbE8U/5QsMuJbVNRGdtyw/
         V0wwB3LFSZa0Qofz7ey0Gn27bu0i7MuIxf3tz3/VyVOEohJzjHBUaALBg+jtyCTCgABD
         FbuBofJAVC3VcKFCEFM1iWI7bSDsWhsWsmm/BkvQLs/TmHYbTlmsrc86S5bRCe1LcDb4
         K4Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVvOfAcCOn3THF0/LSrnS8wxawoVCaSw/UCMwJkHgMcYkzJz19/MnR2XOBj50n4vNJPbfbSf3f+aNhzHmJL3UzQZi1M
X-Gm-Message-State: AOJu0YwPbLHm70c8QEjogA2aLGq95IqMVeOlY7yImfi2d7oaY83apngh
	qmNLNrozH299MibZAttunI5o/tyk+q4B5NFriOe4Z7j8y+plI2/7flcqlJpg5IpQ1LkG0qnrgQw
	GJetRp//8jVwSeiEFvg5g7G7sW0c=
X-Google-Smtp-Source: AGHT+IEx7gD8cupmfP7+SwLcXDT7iipt5mz5Yjr2QFHJnkZ1PEIiUxCDA0u1QzPNSqWxADNqsvotnHAU1pMJkmmGpUg=
X-Received: by 2002:a50:cd46:0:b0:574:eba7:4741 with SMTP id
 4fb4d7f45d1cf-57851a98632mr8606993a12.42.1716995079806; Wed, 29 May 2024
 08:04:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524223036.318800-1-thinker.li@gmail.com> <20240524223036.318800-3-thinker.li@gmail.com>
 <20b1a16e-2614-4022-9389-c28b332a29fb@linux.dev>
In-Reply-To: <20b1a16e-2614-4022-9389-c28b332a29fb@linux.dev>
From: Kuifeng Lee <sinquersw@gmail.com>
Date: Wed, 29 May 2024 08:04:28 -0700
Message-ID: <CAHE2DV1R8VwbVfZgcmzvJWdtnAaHyzC_KboUO_LynT8_-z71ZQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/8] bpf: enable detaching links of struct_ops objects.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	song@kernel.org, kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 11:17=E2=80=AFPM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 5/24/24 3:30 PM, Kui-Feng Lee wrote:
> > +static int bpf_struct_ops_map_link_detach(struct bpf_link *link)
> > +{
> > +     struct bpf_struct_ops_link *st_link =3D container_of(link, struct=
 bpf_struct_ops_link, link);
> > +     struct bpf_struct_ops_map *st_map;
> > +     struct bpf_map *map;
> > +
> > +     mutex_lock(&update_mutex);
>
> update_mutex is needed to detach.
>
> > +
> > +     map =3D rcu_dereference_protected(st_link->map, lockdep_is_held(&=
update_mutex));
> > +     if (!map) {
> > +             mutex_unlock(&update_mutex);
> > +             return 0;
> > +     }
> > +     st_map =3D container_of(map, struct bpf_struct_ops_map, map);
> > +
> > +     st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
> > +
> > +     rcu_assign_pointer(st_link->map, NULL);
> > +     /* Pair with bpf_map_get() in bpf_struct_ops_link_create() or
> > +      * bpf_map_inc() in bpf_struct_ops_map_link_update().
> > +      */
> > +     bpf_map_put(&st_map->map);
> > +
> > +     mutex_unlock(&update_mutex);
> > +
> > +     return 0;
> > +}
> > +
> >   static const struct bpf_link_ops bpf_struct_ops_map_lops =3D {
> >       .dealloc =3D bpf_struct_ops_map_link_dealloc,
> > +     .detach =3D bpf_struct_ops_map_link_detach,
> >       .show_fdinfo =3D bpf_struct_ops_map_link_show_fdinfo,
> >       .fill_link_info =3D bpf_struct_ops_map_link_fill_link_info,
> >       .update_map =3D bpf_struct_ops_map_link_update,
> > @@ -1176,13 +1208,22 @@ int bpf_struct_ops_link_create(union bpf_attr *=
attr)
> >       if (err)
> >               goto err_out;
> >
> > +     /* Init link->map before calling reg() in case being detached
> > +      * immediately.
> > +      */
>
> With update_mutex held in link_create here, the parallel detach can still=
 happen
> before the link is fully initialized (the link->map pointer here in parti=
cular)?
>
> > +     RCU_INIT_POINTER(link->map, map);
> > +
> > +     mutex_lock(&update_mutex);
> >       err =3D st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data, &li=
nk->link);
> >       if (err) {
> > +             RCU_INIT_POINTER(link->map, NULL);
>
> I was hoping by holding the the update_mutex, it can avoid this link->map=
 init
> dance, like RCU_INIT_POINTER(link->map, map) above and then resetting her=
e on
> the error case.
>
> > +             mutex_unlock(&update_mutex);
> >               bpf_link_cleanup(&link_primer);
> > +             /* The link has been free by bpf_link_cleanup() */
> >               link =3D NULL;
> >               goto err_out;
> >       }
> > -     RCU_INIT_POINTER(link->map, map);
>
> If only init link->map once here like the existing code (and the init is
> protected by the update_mutex), the subsystem should not be able to detac=
h until
> the link->map is fully initialized.
>
> or I am missing something obvious. Can you explain why this link->map ini=
t dance
> is still needed?

Ok, I get what you mean.

I will move RCU_INIT_POINTER() back to its original place, and move the che=
ck
on the value of "err" to the place after mutext_unlock(). Is it what you li=
ke?

>
> > +     mutex_unlock(&update_mutex);
>

