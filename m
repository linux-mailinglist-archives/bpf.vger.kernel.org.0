Return-Path: <bpf+bounces-68708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73246B81D77
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 22:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6B2468100
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 20:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A892C0263;
	Wed, 17 Sep 2025 20:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTwGHjOT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5292857F9
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 20:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758142459; cv=none; b=srUbxmacywq+C0prCLE9DhgPjEwkE+OpIE4Y1tB9x7W6h7PI+qD0D82FY2tIt3rGdV1+q/4LfitIYRka4ItHsN3XW67dTUX2JXXdaeh5yEOPIVdDETQZDCLvZ+SvjKQAgqQZzBilh/b1XvoW9hAOply5YJ8Vz2k63PpjXAb3E/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758142459; c=relaxed/simple;
	bh=YvKMKUa3iFqK30wHgHmGyw4LhHyDhfQNQ6CDNtfKAo8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hjuvIatZslWDs5pOmj/o1EcnaUalPes/osBJYLWF61C1aMYhm22f/wWBTup/h6SYVKH+ljb/iY6QsnCqxKH/4grsz5MyCIT07t8i1YO9w1Qt3PSwBE5WJoXU+F9jWL/rySfBOu5XVf2CfQ+pPQpJHzuqYieVV/Hx/Okb5Gct/ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTwGHjOT; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24b13313b1bso1769955ad.2
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 13:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758142457; x=1758747257; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=stZLBVQAAtsFgwRwLerSSIdrg8HwZMf/GUL6MtPKn8c=;
        b=fTwGHjOTlX8qlF+3j3/MRqEqckV8pjAO5b2VPQwHId8n0ynDCfsSdRWY8IosmXN2vg
         x5AgUkE3rRQiTn6L22UHbksLGPICMhCTCunMRqOiRz67BvmV7nIOW9l7Nht4LCb9xlNe
         tUZqoFH5umZFoU3N1HtBCsH/X017R9F70feUraRJs9TGhzAbr73eKDHiR+t0bHjP6ZFf
         kskhl4LmXwc9WE00wE0Zl0GMkgsCccNSfCrfZ+eKDLJ1Icwta95KA2LykbGPi+p1kf9X
         n/xFEkk9zFNL4lSpxjMhvd4jJb7YsPEciePfPJnB4uWbXyZj3sLl6xiediH37fJXzpVS
         kgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758142457; x=1758747257;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=stZLBVQAAtsFgwRwLerSSIdrg8HwZMf/GUL6MtPKn8c=;
        b=K6liDYw7AQUafASxPsmWDQ1K3NO3iwZDruHThAjprQ/RjCR+o+2mGf40JerJoqBnYN
         gOAYlqHGPsSNTjdJb0Df6XLh64OJqNN+yvnibzqaj+vo6Mk/6oC7P4VOXs60kHn8cB2a
         etqwRSdR8yGljlZtbbuJ8zvrMl38Y8+vczwmOnE7KYxEvHXeo6mDjRLCcsG7h+LCvVSL
         XNLhfdfvrhMHU3+tNOu8/7n2Q+UqAlrRzTrBQI6K3fadyU75UP9W7nzZN3lAuhWqdxdX
         YNMbXZ1213boFqMMAvRhnDja8o77ZfqIiQzA2HBJHwx86ymjN9q6Nz18ETL58aW6tJIw
         c7xA==
X-Forwarded-Encrypted: i=1; AJvYcCXO9JW7Y2Thl8kRmkYaYTOJGqDuNRBwQOE+a58iBKizYYVjPDvOyUNaqy3MeGv08NlD934=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzny/7q0IsA+/FN5vc9L88/uXor6SwZo+SQps5yACgnkk2V6mee
	ojPf+lpq7ZLCDUFoh7smhEzqTpxjbz5sPogusFJo5l2mmIySTZ1jCha7
X-Gm-Gg: ASbGncv4w1cDEkmE3euayLutDI76ATSM82WtHevl3tiGHTfxUBM1lz/3bxFXUE8pXjp
	6utCQo8XJJC5PBeT2yUUYeAkkP+70/oMGudkdgziy0MgANnkpDIZkxrROOhmzJxQvxtT1Mfe8mc
	1/mgaWqvOj2oZCQwe8Jt9uONwIgITBWjFniPxRht9VEMEJXUsWx6m/tqoLtBoQXS9b7VYFMNeIv
	jPJzzgc4tufEJ24QqFBnZiPP8PYByVe3ROKWAF3cuDKO/toHhyNUeryhXuYgK0icyZV17vo7dUS
	NaeLOuyQNI+7qalxwDlYD+fwMh20oUZV3U2dTxrYeuLlAtQOIAv64KRuB4NygMMFuCWXPKJBFAx
	RqzLH8DLN3l8/tv0jsHiw0U+vSL/d350qRR+xceRxcGFfEnu9eDVZlfU0G/0PE+xkKEc=
X-Google-Smtp-Source: AGHT+IHXJVOsLQoTlrebMypK5MCeTa4+U60mqpvJ1Qa9Chikl+IoHCWtlj+6ja7Yhr2HqYe2Dt61WA==
X-Received: by 2002:a17:903:46d0:b0:252:1743:de67 with SMTP id d9443c01a7336-26813cf3929mr46007515ad.44.1758142457416;
        Wed, 17 Sep 2025 13:54:17 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1f60:e809:9013:8d56? ([2620:10d:c090:500::5:3675])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980179981sm4708735ad.54.2025.09.17.13.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 13:54:17 -0700 (PDT)
Message-ID: <f70dd7c2f0ae5c52347ec8873901df53dcb4f1b3.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 0/8] bpf: Introduce deferred task context
 execution
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf <bpf@vger.kernel.org>,
  Alexei Starovoitov	 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>,
 Kernel Team	 <kernel-team@meta.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
Date: Wed, 17 Sep 2025 13:54:15 -0700
In-Reply-To: <CAEf4BzarLFHDi3RXp9Gg0tF4YeZPJGAkTpNGTwaQCzxczQFn=A@mail.gmail.com>
References: <20250916233651.258458-1-mykyta.yatsenko5@gmail.com>
	 <3b65db27f2cd4575875a090f9cce0ca0f138daea.camel@gmail.com>
	 <CAADnVQLe+5C8MH9SEU2MxHP9iaCHJHXdnuXTHkqvnVwsHTynwA@mail.gmail.com>
	 <5e2fff56d3465ca921dbee96f512bf0443f66346.camel@gmail.com>
	 <bf202c1aabb6247cdc6c651c6cac3ff3982115db.camel@gmail.com>
	 <CAADnVQ+UAr=kcw_dom=DqqcBWrxK1yWTn2dsabLq9_wopw8Cmw@mail.gmail.com>
	 <CAEf4BzarLFHDi3RXp9Gg0tF4YeZPJGAkTpNGTwaQCzxczQFn=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-17 at 13:51 -0700, Andrii Nakryiko wrote:
> On Wed, Sep 17, 2025 at 7:58=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >=20
> > On Tue, Sep 16, 2025 at 9:51=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >=20
> > > On Tue, 2025-09-16 at 21:44 -0700, Eduard Zingerman wrote:
> > >=20
> > > [...]
> > >=20
> > > > In v4 the function invocation looked like:
> > > >=20
> > > >   err =3D check_map_field_pointer(env, regno, BPF_TIMER, map->recor=
d->timer_off, "bpf_timer");
> > > >=20
> > >=20
> > > One option is to pass an address:
> > >=20
> > >   err =3D check_map_field_pointer(env, regno, BPF_TIMER, &map->record=
->timer_off, "bpf_timer");
> > >=20
> > > But still looks a bit ugly.
> >=20
> > and then check that this pointer is > PAGE_SIZE and only then
> > access it ?
> > I guess that works, but why not something like:
> > map->record ? map->record->timer_off : -1
>=20
> The point of that refactored check_map_field_pointer() was to contain
> all the error handling, and now we'll be splitting a bit of
> preliminary error handling into every caller, which isn't great.
>=20
> Furthermore, map->record can be NULL or ERR_PTR() (see map_check_btf,
> it can return error-in-pointer), so yay, more bugs like this.
>=20
> So let's bite the bullet, and have helper as simple as just:
>=20
>  check_map_field_pointer(env, regno, BPF_TIMER)
>=20
> And internally resolve BPF_TIMER into "bpf_timer" string (for error
> reporting) and into corresponding field offset (for getting actual
> offset within map value).
>=20
> BPF_TIMER, BPF_RES_SPIN_LOCK, etc are currently bits instead of
> tightly packed enum, so we can either go with two simple functions
> that do a switch, or we can introduce a new internal enum and just do
> array lookup. Unless we think this is performance critical, I'd go
> with simple switch.

+1 to simple switch, this is most readable of proposals so far.

