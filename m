Return-Path: <bpf+bounces-31548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 435D18FF841
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 01:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD77C28626C
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 23:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D7113E05C;
	Thu,  6 Jun 2024 23:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jx5tSKEl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C038349646
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717717195; cv=none; b=ck/Ysk0zMHAz5Inv20rvAL+MxNimPQLBRjX1AMBUuFZGVZLbrLDnmlr/9c/vgOAeQg5V6PnJnjyKtJmIByX8t45lKKHaOtN/kAYaBCGEhqAIFta5WlJtZ2ZmF5jdhfEIkemg61KBk9KVsXqCOZ5o3PDuEOPtRkiQ6XrkYLR48eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717717195; c=relaxed/simple;
	bh=v4R7aAn341XBaaFny22D8LeWjKea1uh7+wb8XOXOxkc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oTi99NH8kIiKt0GbRJrLzBoxPtRLCnmAPm9TYyW/sgCkzqmIL+pKoSPrHm+cfZP+1391eoI7t3nxv/nKvuSXJcQPXjaDCuFlcm9MKTHYwsV2vHyruokfuxqcrw13eaSE9l7bVQKlRqAQ6tnnhILy82VggQ712LsvhSgPbkxKtuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jx5tSKEl; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7025c5e6b94so1309506b3a.0
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2024 16:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717717193; x=1718321993; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LWHcmvy78oJtR3IHHg6m6RiMjA+v8NOqtQexrEfnxQM=;
        b=jx5tSKEl+1i0rVndWsAhnxNl5M7ecFZRyjdrhBR3s21w6QTkdR27aPAPVRJ2TOoqGB
         QlOj8sRB4hbJvZNnfMnASNEIuY+XT2rCnoypqq21bom38vVsOimeWUjVzmfcLZEO/+yK
         1vRACbcOfRCRIhYpEJtTKgy+5Io9A9peXC5BTp8/Pgxz094I9n/xWbq7ZxvP3Sr079+c
         2NKjKZ7ClWlAOZMTmapsQ855BkcKQ8jG/vxHTsmCe4eLwcsxALvzSBvVJX99CqWAmkxZ
         nV2LQYi6mzdHpREsTY2kqKIvGhmqhf+ot7czHRe2nMo+hq11lU7x+zcopIWCYhJY7x4v
         ephw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717717193; x=1718321993;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LWHcmvy78oJtR3IHHg6m6RiMjA+v8NOqtQexrEfnxQM=;
        b=c1oRmV5P37J/4Tg1cWZGMYKwvsqoB8kbaEE1+GiZd8hsDLrEUP8u/D1EdhX+hH9vSm
         mwGkONdFst+sgJCkbGmiIdYrOqtElysWKMgeg8O4eR8iE/o+9+i/YMzixKgud6azC4AF
         4sGEtNcKfWrBri5tMKeZhLPkhgE7D4mTEzq6ku+7/UEZGBLkrlP9RsJUPJXMDAorQad3
         gFPeSOa7Vf0NHeM/a3Wui1enaK1UKyOGfni8+x3CvVWp6iwxGD74FQ3kEyZtdeT62Uus
         sddMD/5HjGuYvC4kh2p0AKnIKJkIjC4H4sgfs49pm+QugbMcAMp9fR2p+Y9c5FqQieBx
         Y9gA==
X-Gm-Message-State: AOJu0YyloIOqADYBgSIm7AWCnW1orbqXWXezM7aQD2drV45N6KEBYQwE
	w7+fgNuoFbkXonK8VS9gHH9kWPqOz7UNuaK8dBrEd/Ln96Wt09HQ
X-Google-Smtp-Source: AGHT+IHUn4CuIrebTvmqCS9UMDUJBdNhW+Vj5ide1oEbdzMMGioIsIQS7l2vdYtiShMPlJzvTliGyw==
X-Received: by 2002:a05:6a00:1387:b0:702:2749:6090 with SMTP id d2e1a72fcca58-7040c619befmr1122093b3a.5.1717717192958;
        Thu, 06 Jun 2024 16:39:52 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd394c88sm1591827b3a.53.2024.06.06.16.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 16:39:52 -0700 (PDT)
Message-ID: <0f197e908df8b33187a6c9a8da34457cb01a746e.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/3] bpf: Relax precision marking in open
 coded iters and may_goto loop.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel
 Team <kernel-team@fb.com>
Date: Thu, 06 Jun 2024 16:39:47 -0700
In-Reply-To: <098d570be9bb15fc804355851b4b99837f18c664.camel@gmail.com>
References: <20240606005425.38285-1-alexei.starovoitov@gmail.com>
	 <20240606005425.38285-2-alexei.starovoitov@gmail.com>
	 <6dbfd5e14ffbf9d828d63c5855f9bb783ac2506a.camel@gmail.com>
	 <CAADnVQ+KFoNW-yJCa5fFmNzXjoEN4ECvPeQ1YoCeSZpyR9uO5Q@mail.gmail.com>
	 <098d570be9bb15fc804355851b4b99837f18c664.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-06 at 15:19 -0700, Eduard Zingerman wrote:

[...]

> For the following C code:
>=20
>     long arr1[1024];
>=20
>     SEC("socket")
>     __success
>     int test1(const void *ctx)
>     {
>         long i;
>    =20
>         for (i =3D 0; i < 1024 && can_loop; i++)
>                 arr1[i] =3D i;
>         return 0;
>     }
>    =20
> clang generates the following BPF code:
>=20
> 0000000000000340 <test1>:
>      104:       r1 =3D 0x0
>      105:       r2 =3D 0x0 ll
>=20
> 0000000000000358 <LBB28_1>:
>      107:       may_goto +0x4 <LBB28_3>
>      108:       *(u64 *)(r2 + 0x0) =3D r1
>      109:       r2 +=3D 0x8
>      110:       r1 +=3D 0x1
>      111:       if r1 !=3D 0x400 goto -0x5 <LBB28_1>
>=20
> 0000000000000380 <LBB28_3>:
>      112:       w0 =3D 0x0
>      113:       exit

[...]

I've also took a look why the same program could be verified w/o
can_loop, but fails with can_loop (with this series applied):

0000000000000358 <LBB28_1>:
     107:       may_goto +0x4 <LBB28_3>
     108:       *(u64 *)(r2 + 0x0) =3D r1
     109:       r2 +=3D 0x8
     110:       r1 +=3D 0x1
     111:       if r1 !=3D 0x400 goto -0x5 <LBB28_1>
                   ^^
    r1 is no longer marked precise,
    thus maybe_widen_reg() forgets the range for it
    when widen_imprecise_scalars() is called from
    may_goto processing logic.
   =20
As a result, verifier enumerates states
{r2=3D0P,r1=3Dscalar()}, {r2=3D8P,r1=3Dscalar()}, {r2=3D16P,r1=3Dscalar()},=
 ...
eventually hitting the value of r2 that does not fit in 'arr1' bounds.

