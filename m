Return-Path: <bpf+bounces-68707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A64BAB81D61
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 22:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235091C22E8A
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 20:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E4F29A323;
	Wed, 17 Sep 2025 20:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McA1NfiN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D06208A7
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 20:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758142292; cv=none; b=JjPa8Oxm5DbY6fCzEw0tavgpR9fzSTOZqqK0/7BK8iyDCHvxMH0bzmVUILVHHZZxy3K+6hOCaUCVc/VEM/TlRPJZoMbmYZqR9bMrMel8S48subvThRxPusKFMqJq0h3ww5yPZrdY9FrjEigtl3rw5ELpq+AA4O4ubsIVc39pdko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758142292; c=relaxed/simple;
	bh=dNCXmFofP5R+c6Iy8mrO189tPCHb906L6cSKl/jkn/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxLGMmR0lTKUt85wtfzHl7OuA0OZT8LU4s0V6IBE70YugEh0VUiyMFwvzUmIiEpZeI2VL+whMBQz6d07ASCOEmSZJ6WAuKlVJzrPdXPcqQheieZObNpXtlv0XttWXI8G8AdHwxrCs8MHld8i6K6okrrvscdDexQ1p1iiIC4zkec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McA1NfiN; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32e60fa6928so191834a91.1
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 13:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758142290; x=1758747090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGCZVzaGvYkcaTstDShU2hIAQRmvwh1Vgc/YLEqtaJA=;
        b=McA1NfiNEX25mEhWWDWsI7sm4GYqvC6RUAjmKFrP2NQKUOL8v1Hi4T7NMJNNF/TFEN
         glS3nPCevE9dGIprOZh0yNTrTuI6SHeRQzsIVNnPZo3zSK3BNLR5l4NLXaYtmmlernTj
         G3FrPHcnnlNiDeQKW/5CUzGJFg095DT11S9O7uFry12dkMClY2oPzAhZmvm8W92TGFe0
         hV4xiv3x3aIpuS9HTXYqUxIkF2MptGT7/fwwbr88OPYylFjKECcQwuTzbSq5eHlCw5b3
         9TW4H1YFxHi65lKcYfhAxCeuFOO+I9BxMpLpOzVdA/U044921aNT4lN+ivOeFN2KU/kx
         tKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758142290; x=1758747090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGCZVzaGvYkcaTstDShU2hIAQRmvwh1Vgc/YLEqtaJA=;
        b=Bg5cEF0XQs21aOw6xGyVuXFOS6wSQ1ZNHUS4xNE6SxY5nUok1ajRhpa3hEPi5dHFce
         5BmA/tY4McRNZJ1c0c8Wfw/5WNGE1Trn57fx7xALsN9hu/Q1GY3wza2KSZHiRUdiL1k4
         iAO+ovmpszNEuxODNfWe1dM01sdVvr+kfqMztcieG6yxOykTd+fYvanMhqOFEQUez2QG
         QateXlwNR7VSORZoHB4DiQS8tlKRheXTYweAsvcrlM7+EALs2twOUJ60kFLURo8uLLXd
         EmLsr4JvcIkDTB7U9KALmeFvkRiN+F+uprewjNS2m0cRor5sjQ7WiV1VUr1BuY7dxDbc
         VEsA==
X-Forwarded-Encrypted: i=1; AJvYcCWqloxWDudNzdkuhvSKGSKveYbTMcBugQhdH27iL2YlUQ/ZOFM19qR2e3xkCa9YVE9aQ3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw48vkQizm0I5XySIniAfoLQzpkzTqmKjwDTcdW7Al2xiC5XjRt
	eJ4HFAuAnlP4o573HSyadQdtuAuOwlG7v9qQclaZbqiLtqMv9aJdETXIpE/8JWxiDo18c1haazG
	0SJXzEUtmRl+mRyaOPk3JRAAYNUU2wAY=
X-Gm-Gg: ASbGncv/jxvJwjCvFnK1jyb1lUrlP8y3LQKPIxz9fknbT452iTQwqZI9PID8E3ocA74
	mGvFZwl49/PtrFH5igHeoUckkAY61x8+QsysIarhtL2HwwcQynJaBMQBZH7n052ToypVoPUyayY
	jpOIibJFl+UFLhaLtv1zSVpl/ce40xUr87DBswoZbIOwqRcsRkM2+hwIbkOvg5LyC1KG3j6tvzB
	fPPLGB1wd/KcSMUHs2V86/kRvY7wdfl0g==
X-Google-Smtp-Source: AGHT+IGhf9lZhac4b3C+JjBIPVJTIVHElz1gNDcHwLUFH9MLbWvCPa6fozkZpkAoht8Rp9hk3AIg1WKmPFMQkC610Hw=
X-Received: by 2002:a17:90b:3952:b0:32d:d8de:191e with SMTP id
 98e67ed59e1d1-32ee3e91c16mr3599343a91.10.1758142290273; Wed, 17 Sep 2025
 13:51:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916233651.258458-1-mykyta.yatsenko5@gmail.com>
 <3b65db27f2cd4575875a090f9cce0ca0f138daea.camel@gmail.com>
 <CAADnVQLe+5C8MH9SEU2MxHP9iaCHJHXdnuXTHkqvnVwsHTynwA@mail.gmail.com>
 <5e2fff56d3465ca921dbee96f512bf0443f66346.camel@gmail.com>
 <bf202c1aabb6247cdc6c651c6cac3ff3982115db.camel@gmail.com> <CAADnVQ+UAr=kcw_dom=DqqcBWrxK1yWTn2dsabLq9_wopw8Cmw@mail.gmail.com>
In-Reply-To: <CAADnVQ+UAr=kcw_dom=DqqcBWrxK1yWTn2dsabLq9_wopw8Cmw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 17 Sep 2025 13:51:18 -0700
X-Gm-Features: AS18NWBhoK2CQlvHdjvaFUK1TNkSzmkOhi5hSijpXBHi-nESWrabVN6lzDmy9UY
Message-ID: <CAEf4BzarLFHDi3RXp9Gg0tF4YeZPJGAkTpNGTwaQCzxczQFn=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 0/8] bpf: Introduce deferred task context execution
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 7:58=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Sep 16, 2025 at 9:51=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > On Tue, 2025-09-16 at 21:44 -0700, Eduard Zingerman wrote:
> >
> > [...]
> >
> > > In v4 the function invocation looked like:
> > >
> > >   err =3D check_map_field_pointer(env, regno, BPF_TIMER, map->record-=
>timer_off, "bpf_timer");
> > >
> >
> > One option is to pass an address:
> >
> >   err =3D check_map_field_pointer(env, regno, BPF_TIMER, &map->record->=
timer_off, "bpf_timer");
> >
> > But still looks a bit ugly.
>
> and then check that this pointer is > PAGE_SIZE and only then
> access it ?
> I guess that works, but why not something like:
> map->record ? map->record->timer_off : -1

The point of that refactored check_map_field_pointer() was to contain
all the error handling, and now we'll be splitting a bit of
preliminary error handling into every caller, which isn't great.

Furthermore, map->record can be NULL or ERR_PTR() (see map_check_btf,
it can return error-in-pointer), so yay, more bugs like this.

So let's bite the bullet, and have helper as simple as just:

 check_map_field_pointer(env, regno, BPF_TIMER)

And internally resolve BPF_TIMER into "bpf_timer" string (for error
reporting) and into corresponding field offset (for getting actual
offset within map value).

BPF_TIMER, BPF_RES_SPIN_LOCK, etc are currently bits instead of
tightly packed enum, so we can either go with two simple functions
that do a switch, or we can introduce a new internal enum and just do
array lookup. Unless we think this is performance critical, I'd go
with simple switch.

