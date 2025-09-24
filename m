Return-Path: <bpf+bounces-69511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9C1B9887F
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 09:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2163217D716
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 07:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E22275844;
	Wed, 24 Sep 2025 07:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQ2xqMfw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31E54C98
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758698827; cv=none; b=msVJZi6wcg0YCPOLvfsQ8211OAn8dum7O5kMXF+F8MfO6CEoJe2m6oGf5VVIuEaBnnijtlzsW4rGe9ztOMUKHFD8bpeNRx0wXYMKU+ar+pOxoBqcTk5n3+xEqXwT3xPjpkLPvz80sqCGRCAtn8BSXOtVnxnmFUuP4GDDp/i0C8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758698827; c=relaxed/simple;
	bh=kKd/0SH7KLlnWPyQwzrOFgEvD1tK7cplUSpXrS5xxdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SIEjJ4bKtupEGm1Ky713iP+DG5W/GaFgAbzhdVrtza2zkVWXdHPTFDMEv/NKcDqjcXDK/c6spgdSMQFLI2Zz+t4ZzGDUhTgS3hpRlgInMITBBJPHTSemy1gzgY4iqEjklw+/i2+YAT/HCXNNXKiKppiByAm/Xoz4eLpji0lIycQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQ2xqMfw; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3fa528f127fso434303f8f.1
        for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 00:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758698824; x=1759303624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKd/0SH7KLlnWPyQwzrOFgEvD1tK7cplUSpXrS5xxdM=;
        b=MQ2xqMfwKSCpWzkmz23Dcawi/IIP0gToOZ6xCmyE3Y2nYPjrr6Z0Z/a+MWfuYlXIWv
         ETJrhTXypWBsoSLBqqv85GbcnppQegkLhdIFdvnk0HpDwEeHH03YteWWkeST91Dw99qk
         OHVCKjcSgtZaUtRnJ0tJ3zS9WpZmH86omv1WMtY4CjoVFjDUoEAxWqOVVP/dFwvP/JhL
         ON+mF6EaAibdh7y0tz8ZxZ9LFE57X/sFdoNUID+zgHUGlNdwn9Hgckb82zpeNrlERmMJ
         PCiwg+Mu8OT05qOgklVG7Pd5HOO7eA2Qrnr+LqMJ7DAPOZr4L2JGClvkpjp2ljx2Bhvd
         UEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758698824; x=1759303624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKd/0SH7KLlnWPyQwzrOFgEvD1tK7cplUSpXrS5xxdM=;
        b=W3mxmgCApqZFqKWuVtjDkgr0nrYPZnUve9hxsGHwe9hpoWJ9AQSmDPT+QkwBs0fTLO
         c2v+ikeDF1BgWMaZ//xzJhmCE5lnBi5jsT/bT7lhh7X9dck4HN/YU30oyj4XPWZCGkK0
         VUPp0b+EGCjFzcfzijyvB+F3c4xVHAd/72xfg5BK5pxcWlkQaLE/LCgh89yj0qcKStm0
         N386P3OPV2XEeG+Vm31S2KumyR5Khb4s6Hv4j2dlL6xXY8ZrLLw82IjR/irAVCDex4LG
         NH7zaIpmftW/v4fxaviViBjO6psMmkk+MrSjvPjx/NTNVEMA29bRnOC/2lhvcH8Nc9Tb
         3RAA==
X-Forwarded-Encrypted: i=1; AJvYcCVxvBlyZ1awzTtOo1HQtJ7l3FlCB2fABxYzBn2ADZvrwR/Ly8RswdemGUiW/beCOQBNHsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YymcMHeeM1GhHdS7c7Z4dzb0T5h+8j9NJ0p9fMlPKhcbkUSmXBk
	JlfEbcV6zb0y5fRBNNDETN4PJarqRrQj2yjgHG2xiMgCqocgd4jYzGyUVWvWZyjDrtHqd4q3O7z
	1lwKc7G/vOJh3rkoVOsFx0I8QgoIJqwg=
X-Gm-Gg: ASbGncuSb3czPKYqi9xnir0Knq0BQI+4Kze/D1GWK61c944TzvoyDHyM4PmgYlvpHPe
	Ik450ANZqYs3iFfCVVYuhtj/4/Zrv9FY6aLV0hPH/3nktiULWh4gOwIcnJqSB4Oc2/wKkGQTdwW
	AlxTkusYfLtRaxpuy7UNM3mhEUkVk70Je4z6OXS19ejGxxHsNCfXh+OaYoBtbNuL9MxC3nNJTBX
	fKNF5qX
X-Google-Smtp-Source: AGHT+IGLNNRnatkzs2PS9mwCeAmAu3km/CQA86BU9lC7p8aF9rucMtWvbE7HDIL2to7RDbr3cdFo5QyUqY3OjgTsdaY=
X-Received: by 2002:adf:a157:0:b0:400:818:bafd with SMTP id
 ffacd0b85a97d-40aa86a7c1emr917618f8f.0.1758698823899; Wed, 24 Sep 2025
 00:27:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822140553.46273-1-arighi@nvidia.com> <aNOQkZjLNwQOlioo@gpd4>
In-Reply-To: <aNOQkZjLNwQOlioo@gpd4>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Sep 2025 00:26:52 -0700
X-Gm-Features: AS18NWD0XANWSdUTmSwk5htgTTGLq1huKkchko52JM6L8ODxigS2EoOokmPGSxE
Message-ID: <CAADnVQLBtpsS_rkgoq7rOOXBzp4epAKy6PrObMdCUrvNkTJf2Q@mail.gmail.com>
Subject: Re: [PATCH] bpf: Mark kfuncs as __noclone
To: Andrea Righi <arighi@nvidia.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Vernet <void@manifault.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 11:33=E2=80=AFPM Andrea Righi <arighi@nvidia.com> w=
rote:
>
> On Fri, Aug 22, 2025 at 04:05:53PM +0200, Andrea Righi wrote:
> > Some distributions (e.g., CachyOS) support building the kernel with -O3=
,
> > but doing so may break kfuncs, resulting in their symbols not being
> > properly exported.
> >
> > In fact, with gcc -O3, some kfuncs may be optimized away despite being
> > annotated as noinline. This happens because gcc can still clone the
> > function during IPA optimizations, e.g., by duplicating or inlining it
> > into callers, and then dropping the standalone symbol. This breaks BTF
> > ID resolution since resolve_btfids relies on the presence of a global
> > symbol for each kfunc.
> >
> > Currently, this is not an issue for upstream, because we don't allow
> > building the kernel with -O3, but it may be safer to address it anyway,
> > to prevent potential issues in the future if compilers become more
> > aggressive with optimizations.
> >
> > Therefore, add __noclone to __bpf_kfunc to ensure kfuncs are never
> > cloned and remain distinct, globally visible symbols, regardless of
> > the optimization level.
> >
> > Fixes: 57e7c169cd6af ("bpf: Add __bpf_kfunc tag for marking kernel func=
tions as kfuncs")
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
>
> Gentle ping.
>
> Anyone has any concerns with this? Do you think we can apply it (so we
> don't have to keep carrying it out of tree)? :)

The patch expired in pw.
Pls resubmit with [PATCH bpf-next] subject.

