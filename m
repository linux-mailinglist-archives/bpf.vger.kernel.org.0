Return-Path: <bpf+bounces-30883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 356D18D41F2
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 01:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517E71F23B06
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 23:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AB2178387;
	Wed, 29 May 2024 23:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vk2CLCmY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D7C167DB4
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 23:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717025181; cv=none; b=AV0h2+LZ5XPGtqycxnfQROw/UMfI/qw6dYbHogsSa8BdHV2q6yGdKb1/H/Q+R9xqQE+kTKFJ+DJDQls+DOX+zQZ6YQalvs/F/VZbIfvdDRSt64On1W4r1W0g7xRAjXik6XS6n2sJF5+dHXdiPFzxl8OCBiY+rTrbmvjBn2em9CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717025181; c=relaxed/simple;
	bh=nQzTg0ldhb0lm1jTIbOIk+QFpVT3ppLJE1iW78II2Mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNJsK5xU0xPwdVdda9pM1FDeAtsvDSyrFAbjdjN8NuTPfXH2+9LHBa7jtEvNMA4icwSHH+23zl6e+IdGimjngAIHqb3nmGpB0bLvVEjYQLgT1ioJ1bccc9g/gEPwELZwShnT83LkoIj8U9GLxwv312+MfQvn9ctucZGQr74EJ4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vk2CLCmY; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57857e0f45eso301676a12.0
        for <bpf@vger.kernel.org>; Wed, 29 May 2024 16:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717025178; x=1717629978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j93bZCxvCOn8BpjlVbHRWdez63Cf0eMn01gBR9mCfa8=;
        b=Vk2CLCmYsmRb+bxsTdLQ0vl+d779ZeQVWc+tjyF6Z4qrSNmofQK7h3Z+qZcaVycHbl
         MsiXIjHfN5vJv5N9CWDkPTm8ee1Vi0Kb4JL6mWSJsJ3R7G1PfPCSDjaxgIcLs4rfESbE
         5Pfl0kKm9IgIOZId6oAvI0snMzahZTCa9P1uWZ50IznucKtBQQRvMTZiRE7+d/bpBKl7
         HInILGZZwH2zghSuSOFVZToqAcSO12QSMRhEreUL99e7WoGLuhyN9GCQKLsk+SP9NEXR
         EYykF6Gp14sxpvvrW77AQcrKnidFWOFqGFqBB7ZzjILvSJsXE5Ar4vYvI0IE+jhec10y
         friw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717025178; x=1717629978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j93bZCxvCOn8BpjlVbHRWdez63Cf0eMn01gBR9mCfa8=;
        b=kRJQJTcnky2zGThYdB9GI21n+Pnq/ShGCw7CIutVBnpSDW2tSVC5cVj8gfYAUxTVdX
         ccrLbK412R9VCgufdL0L7J0z/tuGNwqXbfcBGmV/iFH5d2L5O7affIfa1XgbgABuLbwc
         lFyCqhnZwFjJ+nMtI/lqk5RWZ59IKJodq944Z47uSt54gE2gDtrfxzT54QrJTy3XJe34
         EtxkuTRFXUvLlG3HY3WNJi/WTAgPq7/ClpomKCvZxe5kGMibtuE+ohyZmsi11yXxogfb
         DltOMMnX4GGk14RyiEwD8uoGiSb+Bb7uek4DdmdLL3wudseGLg48HxcBwnPiq4hjQ1pE
         nseg==
X-Forwarded-Encrypted: i=1; AJvYcCXZjqykugw8zEIuM5fyegKLuIa7nhYcI+mgkewCJKw9rau8CBUUrNPHhEvB1DXiAs00yJvEC+usqBS7Gz1j2+j2eVrm
X-Gm-Message-State: AOJu0Yz063bCZKYE6IL1h+seWiUrneNE2DkvLCTn3GFtXsT8yEujegor
	OYRzmPqSKqXLAixzv/xAO3dxdyjLSi4OokqZeLNwuycGDLsmxFU9nGMzxOa0nXUL8PgvEW1yJRF
	mILXloXYc2nCbk5zJW2JWZORrDXc=
X-Google-Smtp-Source: AGHT+IF4dP3S7kFk4ODulPVhtrTaQMH9TFI3MVbm4dK/gMwuTIV67MrDg2JWsXdaUBs7OkzvPb6pA/9NE3lMm3IHaHw=
X-Received: by 2002:a50:d782:0:b0:579:e6ff:c61f with SMTP id
 4fb4d7f45d1cf-57a1788ee43mr367296a12.25.1717025177972; Wed, 29 May 2024
 16:26:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524223036.318800-1-thinker.li@gmail.com> <20240524223036.318800-3-thinker.li@gmail.com>
 <20b1a16e-2614-4022-9389-c28b332a29fb@linux.dev> <CAHE2DV1R8VwbVfZgcmzvJWdtnAaHyzC_KboUO_LynT8_-z71ZQ@mail.gmail.com>
 <c995be4c-eac8-490c-a220-7f19794c3420@linux.dev>
In-Reply-To: <c995be4c-eac8-490c-a220-7f19794c3420@linux.dev>
From: Kuifeng Lee <sinquersw@gmail.com>
Date: Wed, 29 May 2024 16:26:06 -0700
Message-ID: <CAHE2DV3Z9t_c98pGyMXzt8gCronWLe=9yPqqsfBOe-5CBnbXKA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/8] bpf: enable detaching links of struct_ops objects.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	song@kernel.org, kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 3:38=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 5/29/24 8:04 AM, Kuifeng Lee wrote:
> > On Tue, May 28, 2024 at 11:17=E2=80=AFPM Martin KaFai Lau <martin.lau@l=
inux.dev> wrote:
> >>
> >> On 5/24/24 3:30 PM, Kui-Feng Lee wrote:
> >>> +static int bpf_struct_ops_map_link_detach(struct bpf_link *link)
> >>> +{
> >>> +     struct bpf_struct_ops_link *st_link =3D container_of(link, stru=
ct bpf_struct_ops_link, link);
> >>> +     struct bpf_struct_ops_map *st_map;
> >>> +     struct bpf_map *map;
> >>> +
> >>> +     mutex_lock(&update_mutex);
> >>
> >> update_mutex is needed to detach.
> >>
> >>> +
> >>> +     map =3D rcu_dereference_protected(st_link->map, lockdep_is_held=
(&update_mutex));
> >>> +     if (!map) {
> >>> +             mutex_unlock(&update_mutex);
> >>> +             return 0;
> >>> +     }
> >>> +     st_map =3D container_of(map, struct bpf_struct_ops_map, map);
> >>> +
> >>> +     st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
> >>> +
> >>> +     rcu_assign_pointer(st_link->map, NULL);
> >>> +     /* Pair with bpf_map_get() in bpf_struct_ops_link_create() or
> >>> +      * bpf_map_inc() in bpf_struct_ops_map_link_update().
> >>> +      */
> >>> +     bpf_map_put(&st_map->map);
> >>> +
> >>> +     mutex_unlock(&update_mutex);
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>>    static const struct bpf_link_ops bpf_struct_ops_map_lops =3D {
> >>>        .dealloc =3D bpf_struct_ops_map_link_dealloc,
> >>> +     .detach =3D bpf_struct_ops_map_link_detach,
> >>>        .show_fdinfo =3D bpf_struct_ops_map_link_show_fdinfo,
> >>>        .fill_link_info =3D bpf_struct_ops_map_link_fill_link_info,
> >>>        .update_map =3D bpf_struct_ops_map_link_update,
> >>> @@ -1176,13 +1208,22 @@ int bpf_struct_ops_link_create(union bpf_attr=
 *attr)
> >>>        if (err)
> >>>                goto err_out;
> >>>
> >>> +     /* Init link->map before calling reg() in case being detached
> >>> +      * immediately.
> >>> +      */
> >>
> >> With update_mutex held in link_create here, the parallel detach can st=
ill happen
> >> before the link is fully initialized (the link->map pointer here in pa=
rticular)?
> >>
> >>> +     RCU_INIT_POINTER(link->map, map);
> >>> +
> >>> +     mutex_lock(&update_mutex);
> >>>        err =3D st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data, =
&link->link);
> >>>        if (err) {
> >>> +             RCU_INIT_POINTER(link->map, NULL);
> >>
> >> I was hoping by holding the the update_mutex, it can avoid this link->=
map init
> >> dance, like RCU_INIT_POINTER(link->map, map) above and then resetting =
here on
> >> the error case.
> >>
> >>> +             mutex_unlock(&update_mutex);
> >>>                bpf_link_cleanup(&link_primer);
> >>> +             /* The link has been free by bpf_link_cleanup() */
> >>>                link =3D NULL;
> >>>                goto err_out;
> >>>        }
> >>> -     RCU_INIT_POINTER(link->map, map);
> >>
> >> If only init link->map once here like the existing code (and the init =
is
> >> protected by the update_mutex), the subsystem should not be able to de=
tach until
> >> the link->map is fully initialized.
> >>
> >> or I am missing something obvious. Can you explain why this link->map =
init dance
> >> is still needed?
> >
> > Ok, I get what you mean.
> >
> > I will move RCU_INIT_POINTER() back to its original place, and move the=
 check
> > on the value of "err" to the place after mutext_unlock().
> The RCU_INIT_POINTER(link->map, map) needs to be done with update_mutex h=
eld and
> it should be init after the err check, so the err check needs to be insid=
e
> update_mutex lock also.
>
> Something like this (untested):
>
>         mutex_lock(&update_mutex);
>
>         err =3D st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data, &li=
nk->link);
>         if (err) {
>                 mutex_unlock(&update_mutex);
>                 bpf_link_cleanup(&link_primer);
>                 link =3D NULL;
>                 goto err_out;
>         }
>         RCU_INIT_POINTER(link->map, map);
>
>         mutex_unlock(&update_mutex);
>

Sure! According to what we discussed off-line, the RCU_INIT_POINTER()
will be moved
back to its original place. Subsystems should not try to access link->map.


>
> >
> >>
> >>> +     mutex_unlock(&update_mutex);
> >>
>

