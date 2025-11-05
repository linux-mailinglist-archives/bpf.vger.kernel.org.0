Return-Path: <bpf+bounces-73550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AC4C338BB
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 01:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8811884E75
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 00:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DB8242D70;
	Wed,  5 Nov 2025 00:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QT9vdIsc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97F023E35E
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 00:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762304057; cv=none; b=Qw0zRU1XCwXfAeHjm+OqLiVT7O6v8ksUElFq6T9378V4ygbLnXNiDwGbI1lMBzwfX1MNUs1oRGAxHKT7BAQALnNGIslxo+0jBVW9Iu0zzi9rt2Ot3gtTJ9bVtQkYloGhr9bQFq9wOjSBK9R0920L/u8S5U6MAmyBjPbl9CTKeZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762304057; c=relaxed/simple;
	bh=VV7eBKzuMpuJRr2XIgNa/X/7vqmqZ08LzVtCckGyb+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHwyu2CVadsNOndq39zCQM81bJaPRpzaz277UOdbcDyZriVgbfyHmnE786VxPJ1cRkhtZ9cXieO6eBHpZcigneMj3YaDd5GBOSLhNXRtURVKEnn92hmJm+d0v6zPx8HBTrAu9cGha12v1N1KsrqF6BmQjidK7E6jRGGoVFTh9Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QT9vdIsc; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2951a817541so69024165ad.2
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 16:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762304055; x=1762908855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ai8mvMssYGesI1bFVdjZPVSaZhnJPK3ohpheYvjpakQ=;
        b=QT9vdIscTUWB0RNlGFhXfFLLqI1QStHkdPiZe5dBkef/XpYWPJdZVEdRunwKvZqpxz
         IGOIDCI3iVL6zW1Th08U8Z3bGOVVPky1a1noHCtL6ppGQshRD8Ujw+trNMuA9d1BLTET
         DHW17c2yO6PJr79izKiRB9oqgYxp/Ft6xDC7bEDNyjvA0vZQIEVk3plGT0kkvhIF3dk/
         DDvLYbxf2wvM1lFFO7F/0U/wg+0/de5mdOsQiTXsa2VZK673M9OhO88E89ZaV9s0RYyf
         uIAmjTtEwu2hjU62CFBTE9imewTwBK7m4Xs1MW8Xonih5w4u78RvRBp9dEX5oe7jBsV1
         j8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762304055; x=1762908855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ai8mvMssYGesI1bFVdjZPVSaZhnJPK3ohpheYvjpakQ=;
        b=dZaUyQv5Q8ZSsmjoyt6z2iyfH7nHaGMNii3d/yrdYbNA/SwuHW0Cde5wqCx7EOYhft
         w00mrLDsAqjC8iO3QN8PhGLd5U3Qc4ipqLrbYKQ4jCRxALy0HCv9dt0GANH4YiJkynAl
         qNOsHcE5AFge4xwH57WvAXjsC9VrT70svVkCDEsZRmbxOXdRYCCms9huT+9kRuUrls2w
         A9qA4yAcBOPmFoDWj/6QpZp/TQUoUgqvIyFxMz/cviIAdcuJhiZrozlF1CzqkDFYyCFT
         5SZw1PDKcaqUC18MVmwhlFz7fGHMWHM/pIBspUI7h/l39Ca0msJFsSLDi4jZnhhY/mnY
         qSqA==
X-Forwarded-Encrypted: i=1; AJvYcCWeOdBxuQC1/nJ/Sqtmzzz+U8reN6YkkqISdXLvA0Tj58dVEmF787w4N/sokmY+HaJTIek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlvsO1oIKrNRgLJ2+51FZCXau4oIDosRCiiS24QLMYtMIJaX4F
	MhuWHtVMBMn2Szt4NslJU/2P/CxD3uS/KoJcWJs/gvIQsCQOYgyjDsyt53jGFir13mR7kHq0RYb
	iq5cjDSn3FPF/yNw7KgP+Jjl0ksZ/8rk=
X-Gm-Gg: ASbGncuIG9GJMEV73k7OYiTjsmD+TCpscaYygyU+Y2t1EWnT7MT0NBmM8yWAjD/zeEZ
	2b9PiOlO/aFk4K8OAhjm5BpWwtMabjk8knjjUVQgsAkzb3O41YpY+L8eA+PEIjEDA/AHvQW7k5/
	GaqNhObzuxQZYZ0jP2qt10+JGihsY00MqszLTMRfHONNX/UylpOPhn6X1DnMB82Jnb8yufwHixt
	IbHywbAqQF38RO53lS3JZV9kaGI0Q3rkPv8H5mHrwfWvMFN3ovetQ9ezTjaNHg6J31kdIUBSA0+
X-Google-Smtp-Source: AGHT+IFvcCgG6pGr57yA4MEdSV2o0BGxmUkR4KxnqJzD1CKnDYxQyDUN45vCD7fRxAUDO0fQfFEf0KI3uLe/HCSL/QU=
X-Received: by 2002:a17:902:d485:b0:295:70bd:b04b with SMTP id
 d9443c01a7336-2962adda56bmr23168845ad.55.1762304055076; Tue, 04 Nov 2025
 16:54:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
 <20251104134033.344807-4-dolinux.peng@gmail.com> <CAEf4BzaxU1ea_cVRRD9EenTusDy54tuEpbFqoDQUZVf46zdawg@mail.gmail.com>
 <a2aa0996f076e976b8aef43c94658322150443b6.camel@gmail.com>
In-Reply-To: <a2aa0996f076e976b8aef43c94658322150443b6.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Nov 2025 16:54:00 -0800
X-Gm-Features: AWmQ_bmU6TGrwyvmx-hOamFY5JCJCZp3bcPJpWex0EJcwgRNuWp785zP45llSsM
Message-ID: <CAEf4Bzb73ZGjtbwbBDg9wEPtXkL5zXc3SRqfbeyuqNeiPGhyoA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/7] libbpf: Optimize type lookup with binary
 search for sorted BTF
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 4:19=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Tue, 2025-11-04 at 16:11 -0800, Andrii Nakryiko wrote:
>
> [...]
>
> > > @@ -897,44 +903,134 @@ int btf__resolve_type(const struct btf *btf, _=
_u32 type_id)
> > >         return type_id;
> > >  }
> > >
> > > -__s32 btf__find_by_name(const struct btf *btf, const char *type_name=
)
> > > +/*
> > > + * Find BTF types with matching names within the [left, right] index=
 range.
> > > + * On success, updates *left and *right to the boundaries of the mat=
ching range
> > > + * and returns the leftmost matching index.
> > > + */
> > > +static __s32 btf_find_type_by_name_bsearch(const struct btf *btf, co=
nst char *name,
> > > +                                               __s32 *left, __s32 *r=
ight)
> >
> > I thought we discussed this, why do you need "right"? Two binary
> > searches where one would do just fine.
>
> I think the idea is that there would be less strcmp's if there is a
> long sequence of items with identical names.

Sure, it's a tradeoff. But how long is the set of duplicate name
entries we expect in kernel BTF? Additional O(logN) over 70K+ types
with high likelihood will take more comparisons.

