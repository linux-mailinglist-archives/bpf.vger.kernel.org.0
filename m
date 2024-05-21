Return-Path: <bpf+bounces-30158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B3F8CB46E
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 21:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7D31F235BE
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 19:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444561494C0;
	Tue, 21 May 2024 19:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrWaQahE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DADD14900F
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 19:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716320962; cv=none; b=jUMXUPPqNEqGoBmotNZtd0ZYtk3wB5t2qRa62KwwOFGRBt3q+lqinByKDIrmBDZ01eBPBSbSISGIsIQoTk40fDXVIfHSNQfA1gL3/fMMvNHy+DjMxBrUcbUx4/zFLBVW2QKgO1HDgjc/Uam6xxR+bce8o7g+2H35QJXr39+jrjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716320962; c=relaxed/simple;
	bh=ZmCDMzNrBmi0NeCIDt33StwiVLxjiTaXmhPFjz84yRk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I4jjUQnad1Vk8OF8cXHZXb66pxmsuvpcW3tGYK5A1HrUfZ8sDrIdjKbQGEvjCMCXphULKgi4ai1uJlwgpXM7yKmDVXUmfWV5fxVlAkySN7ZuIVeA2KZIBG4kRHUMyaK0a6lVJ/pSm0iEr5wDfkzXfmnh/9I+qeE4vs5w6XQ8Wzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrWaQahE; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b2d065559cso1842250eaf.3
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 12:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716320960; x=1716925760; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K2yUOsfjVsTrNaxBW7CxVM4Mor20lc+2uybSGWoTccA=;
        b=DrWaQahEGIAkzi2Mc1uU62qlZw7RRwP1FApfcccjokCjr1LZ/TGmy2OL9rKOCiLNlq
         A+gHNU5KmoMQ3K5IIPTbvgdVtlsD/Ylf1OTUq0vTW925uOTPndDRkKACIr+HrKv+PC4A
         KFR0T0NAVsvHj2cKGGifM7JLsMdWWEZ1bReRprQjN5YMpSvnZFBulPuzqk69zGqrlBvV
         o8UDKqI/J7BbCrB0f4wFxyh8Dr3LgfF1IdAll8NVreIi12ftCCXwPT+ItAoKWuvkcGh3
         y0CZJ/uxlf2l+AVXVIIOiyNd6P8N78fmsB5pxV/aI1lyBXupC6/fjfSZzuY3in7/pt5c
         7M3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716320960; x=1716925760;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K2yUOsfjVsTrNaxBW7CxVM4Mor20lc+2uybSGWoTccA=;
        b=l0i7nHj2LGgDbpXyUsP2Se7BIsKtTuC5dPcvReOOD4YIy249RekIHUhoV95g8ZIq3I
         kZjE06+Ku92nUWsAZI+Xl7hn80mCWVKhLkKM7aHVjpN7jLe/VaFkJKSwA3vl3MvBGDzR
         SmACTjHMzoehhXKq//Jart0BGU4nBTA9GgNEPqmphRY9lI+dIk+D1uCcQmW/sUUnFk3P
         Q7uWvYaKxvbyZEIxe8V9eP13e+ueAqrRoTmmNcdnmtwPmwRR/t72ZUXFx+7yZoi6smVA
         +OCrtqvil4auQu+sF9jSowdW8iV6rskxAhPPNKdY7Oq3iGCiqo9vIUds1ONe8zPPGkgQ
         61SQ==
X-Gm-Message-State: AOJu0YyHFLnJQ+2/QVT+z2Gd9iFRFBIkduS3Jx34JDamUlrqak65uPoD
	NlUnHaQEt3+SiuWkXo1QY3tUMgihOj6LnI0x26ZdSq0foum22J69
X-Google-Smtp-Source: AGHT+IG4hyQcnxrWbYF0H0IqcxTnSHANXEqec47eyLdrHaTIaonHJlIAJUh7aaZ4183TO2gyyvKD7w==
X-Received: by 2002:a05:6359:7c15:b0:193:f888:c67e with SMTP id e5c5f4694b2df-193f888c7e2mr3059249055d.29.1716320960347;
        Tue, 21 May 2024 12:49:20 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f67f5eaf36sm10109817b3a.14.2024.05.21.12.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:49:19 -0700 (PDT)
Message-ID: <145770024a2ab5c1b0e6d5f5705c437e9a4e7c15.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] selftests: bpf: crypto: adjust bench to
 use nullable IV
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vadim Fedorenko <vadfed@meta.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>,  Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org
Date: Tue, 21 May 2024 12:49:19 -0700
In-Reply-To: <20240510122823.1530682-5-vadfed@meta.com>
References: <20240510122823.1530682-1-vadfed@meta.com>
	 <20240510122823.1530682-5-vadfed@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-10 at 05:28 -0700, Vadim Fedorenko wrote:
> The bench shows some improvements, around 4% faster on decrypt.
>=20
> Before:
>=20
> Benchmark 'crypto-decrypt' started.
> Iter   0 (325.719us): hits    5.105M/s (  5.105M/prod), drops 0.000M/s, t=
otal operations    5.105M/s
> Iter   1 (-17.295us): hits    5.224M/s (  5.224M/prod), drops 0.000M/s, t=
otal operations    5.224M/s
> Iter   2 (  5.504us): hits    4.630M/s (  4.630M/prod), drops 0.000M/s, t=
otal operations    4.630M/s
> Iter   3 (  9.239us): hits    5.148M/s (  5.148M/prod), drops 0.000M/s, t=
otal operations    5.148M/s
> Iter   4 ( 37.885us): hits    5.198M/s (  5.198M/prod), drops 0.000M/s, t=
otal operations    5.198M/s
> Iter   5 (-53.282us): hits    5.167M/s (  5.167M/prod), drops 0.000M/s, t=
otal operations    5.167M/s
> Iter   6 (-17.809us): hits    5.186M/s (  5.186M/prod), drops 0.000M/s, t=
otal operations    5.186M/s
> Summary: hits    5.092 =C2=B1 0.228M/s (  5.092M/prod), drops    0.000 =
=C2=B10.000M/s, total operations    5.092 =C2=B1 0.228M/s
>=20
> After:
>=20
> Benchmark 'crypto-decrypt' started.
> Iter   0 (268.912us): hits    5.312M/s (  5.312M/prod), drops 0.000M/s, t=
otal operations    5.312M/s
> Iter   1 (124.869us): hits    5.354M/s (  5.354M/prod), drops 0.000M/s, t=
otal operations    5.354M/s
> Iter   2 (-36.801us): hits    5.334M/s (  5.334M/prod), drops 0.000M/s, t=
otal operations    5.334M/s
> Iter   3 (254.628us): hits    5.334M/s (  5.334M/prod), drops 0.000M/s, t=
otal operations    5.334M/s
> Iter   4 (-77.691us): hits    5.275M/s (  5.275M/prod), drops 0.000M/s, t=
otal operations    5.275M/s
> Iter   5 (-164.510us): hits    5.313M/s (  5.313M/prod), drops 0.000M/s, =
total operations    5.313M/s
> Iter   6 (-81.376us): hits    5.346M/s (  5.346M/prod), drops 0.000M/s, t=
otal operations    5.346M/s
> Summary: hits    5.326 =C2=B1 0.029M/s (  5.326M/prod), drops    0.000 =
=C2=B10.000M/s, total operations    5.326 =C2=B1 0.029M/s
>=20
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

