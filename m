Return-Path: <bpf+bounces-66329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E04DCB3257A
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 01:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3539AAE51C0
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 23:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0B02D7DD5;
	Fri, 22 Aug 2025 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2tzuoFg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49382D6E73
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 23:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755906639; cv=none; b=WFQSVM2OgRTQhypbVVz6mJ4cYMgBru6ZxQSZmlgxTum8DccKiG++ydqy4vAc7mWPQiN1pOZyCQFZxL5CXLPxw2nOpvXUm6B6o3cK/DhbHskuKKmN33K9mj1lp8nX0hn7mAmZSuFCWwK9Q+2CQXQU6jRCuY+8Ta9rhH5KQCAWGzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755906639; c=relaxed/simple;
	bh=G0R7CAyiILV+/pNincRo/H/GeQaqBHSX2A/UO5uegdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aBwl210GXBeRsDa2TH21T9Ub4FXGv7PKACAcdH9ZgAZXApDcH4Y8xGIhyaAR+ZMBdgARejCZM5ucxbNhpmtyYwWuQeLeaDbOwhY6WWekWBXmacOl73PPk7UBZEko+5Igot4K4lmu51ZfwJTVFr8QDpaRjP8hu/ANP/rK3R1WpuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2tzuoFg; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-50f8b94596fso1499944137.3
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 16:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755906634; x=1756511434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Io1uxwHIqBZin6oRR58ENoOxZLQOdCQCOkitibc5+Us=;
        b=d2tzuoFgWjBEP968VBPPnYo0ovzfG0UgHZkGPZGExtiZKHAgRtrUE7Co2lyK1xslhc
         E8w9gPgoKK9ZDXvAhlWyDdeKIjmJ73Bm3XWyPaDYwJNcz4vX0JSsPuAVAwUnvem3/u0i
         3qPw53WHiKc4B9tYzY/fppnOvi+mPXQomSwdam8SNNfCQ0a9Ed2A1u2YkojPDZ2FwJhQ
         AL55TbO57tKVHoqXQxcu9epqFW4fKSb1AU9xPogD1/uqlrgjgkbuyMwqI+HEVgbe6mTt
         Xlm/R37QaYdCJxI9wAgV4lvsqSBGNPsf/Q6eGo06PVw3Hvh6SYNBlh08FM4pCNQCcy8d
         n90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755906634; x=1756511434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Io1uxwHIqBZin6oRR58ENoOxZLQOdCQCOkitibc5+Us=;
        b=qy6ML8MbyR3RWh1df1UE9e2x8OhN/g4tGESIkmskFboKT78bQ7XZcewqF/BcjpOacl
         6xEpXivoKagEz/Eg23pWA/PGOBs42xAIMSSxM3/tjakMFLxElsTd+yvr3wp7A3NRgJ7k
         A0HCfKjI4rRQ0UndvIqXCgrde6VV/J1gv5COKJ4XgY/6/pPHMIraUR1umsb1BkR3yrts
         ardaaD9SSduO3aBt3VlQ3M4jvpjy8Kg3hYdT78igHVIopJ0H1X1NkHservuMw3AnDZrz
         9xB5fJnpXaRxib2HdxsjmXs6fvb4CMyGWmDPV+hfrok2ibRqi0TmArjt3Kxwdp8fntS3
         QLJg==
X-Forwarded-Encrypted: i=1; AJvYcCXu+MODo61Yw6O7ItBaTnYqfO51b68325uRBumO/4qqunZYJ6naWlAN/xuuI+FOHbJg4qw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1kpiHvO0EKGqRP4i7DQtOWcAwrn8KY4cV4fj23a+bkvZDPiJL
	iiwQh2yGGuwtRFRdn0Ucf9xZZn2ds2iE+2x+CpV5MjpKMCiqTNM7Sy5vPSND8kN+Nst/yHAwVaq
	FlOp/9CTQPghO/qxzm7QVWdM7ikFTL4A=
X-Gm-Gg: ASbGnctnUz3sDvo0ltvoy5tcFFgSI2xEHJkWQtREbWughmBBZh67UX0OkWWc1jGhD90
	ONz90fTbHDvSY24t+2Tz+YlLIl+jMfmrzzDW/Yjpesq/qSsH5EHdQIT3OmIpWO4iP3VmhIczKKo
	CsPEwmArJCpHObvd62T3mL/PwZydUIIMXyHEXr1KVi+F9/LATifg8vz2EmSkDC70bPtl+75qz4P
	7Ix67j98KgXoq+d24wzVpOPGNWOgg7vqM5J75/Rmg==
X-Google-Smtp-Source: AGHT+IHg5+nk5JHdfwO15HJu9vOcBrjyh42XliCsMlQNqksVbOroodQSsEuENGZsvTbUZTkqvOAK3vDaeIv/trlO8PY=
X-Received: by 2002:a05:6102:334d:b0:519:534a:6c50 with SMTP id
 ada2fe7eead31-51d0f712609mr1536298137.34.1755906634529; Fri, 22 Aug 2025
 16:50:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822170821.2053848-1-nandakumar@nandakumar.co.in> <8834d8df16f050ec9e906a850c894b481dfa022c.camel@gmail.com>
In-Reply-To: <8834d8df16f050ec9e906a850c894b481dfa022c.camel@gmail.com>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Fri, 22 Aug 2025 19:50:23 -0400
X-Gm-Features: Ac12FXxZPtvxUp6tV1g5MrQdbjUHduRiBL0K_BxvxE82bsrW4TFjzmH_ra3G8Gg
Message-ID: <CAM=Ch052ZOCAtLE-foPBccjC0X2YVx2qDU=Mt5Z3bxN7iYGD=Q@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/2] bpf: improve the general precision of tnum_mul
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Nandakumar Edamana <nandakumar@nandakumar.co.in>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 5:50=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2025-08-22 at 22:38 +0530, Nandakumar Edamana wrote:
[...]
>   +struct tnum tnum_mul_new(struct tnum a, struct tnum b)
>   +{
>   +       struct tnum ab =3D __tnum_mul_new(a, b);
>   +       struct tnum ba =3D __tnum_mul_new(b, a);
>   +
>   +       return __builtin_popcountl(ab.mask) < __builtin_popcountl(ba.ma=
sk) ? ab : ba;
>   +}
>   +

We had originally observed in our paper [1] that tnum_mul is not
commutative, and considered
taking the best of two possible results (a*b) versus (b*a). Indeed,
the new tnum_mul is also not
commutative so we can do this.

We decided against it eventually because this approach involves
running two loops,
each of which will run 64 times in the worst case.

[1] https://arxiv.org/pdf/2105.05398


> For the 8-bit case I get the following stats (using the same [1] as
> before):
>
>   Patch as-is                 Patch with above modification
>   -----------                 -----------------------------
>   Tnums  : 6560
>   New win: 30086328    70 %   31282549    73 %
>   Old win: 1463809      3 %   907850       2 %
>   Same   : 11483463    27 %   10843201    25 %
>
>
> Looks a bit ugly, though.
> Wdyt?
>
> [1] https://github.com/eddyz87/tnum_mul_compare/blob/master/README.md
>
> [...]

