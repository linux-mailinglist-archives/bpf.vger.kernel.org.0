Return-Path: <bpf+bounces-34334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6144B92C7A2
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 02:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7E9EB21C61
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 00:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B9915CB;
	Wed, 10 Jul 2024 00:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZqFtvdI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665CC1362
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 00:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720571174; cv=none; b=YkimESBYlzkAvs4rOv8Xr1SLrWepX3WJ/jBXslrFPyADvKrb18mcbLj9UIlP8zFAR3S8TJm8xn+t1fwElhKrB7CHw8R2PcRM7p0JhvV95hw927HHXsd+zz+wqrOzfSEZVoVnDcjnwqc06vUhSDmHwvTwifgaYxODlDDx+CBtR0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720571174; c=relaxed/simple;
	bh=HtjbhEnYcWHtFCF2iiNXeEPY35WAxyWga6bf7TuUg6c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ewkj3Qxukop/aRoTARbFmuoUtCIC+U+l+lee1Dvz7VCI2QtLW775KQ5rUwVnQ8Vvg0NAdp1eyv8zgs70asaYSES478QABSheR1VupzVsTqXWUyuXqb1wquzH60oJfMNFKUHKpkFOFOi9TBcNTjyECuR8ncu9vI+rTUjuCUMU/K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZqFtvdI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fa55dbf2e7so29428285ad.2
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 17:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720571173; x=1721175973; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w1bftJqZ8M+ILe9lK8qp7fx9bObFBuCnqfWnx4xQKwQ=;
        b=XZqFtvdIT/4UwHEq6VT62zejGRxrLWytbQQRPXr8LwcV37Pa6XkPKHvNNwCz6MYXxW
         CcwCB86FUmxzYlUaaKomJfuZjVp48U+UhA6ISQcjA3Af4jXWN4hg5FC/tvjZWhB2ziYY
         vMGZTh6/yCkKhPBH3pU11QMor4kuLLm1QrtYGfrxA+3I4w90TLQVFPPjNSle942DFDuU
         rRa78DcR/UbNqfbRzh2ueOW5Orh54AjE06d02sWIlsMvo7EbEMia9iPpVNJoxwCZIsHv
         1Dq5mHukIN6ytvce5y3uIX2GLJQjS5QlBkMfKSE9fnHvAKC+sE+9rA3ZlZ79v3hZS2+Q
         t2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720571173; x=1721175973;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w1bftJqZ8M+ILe9lK8qp7fx9bObFBuCnqfWnx4xQKwQ=;
        b=iWmW6G6SzMZOkwxXk3gy0nftZQ6lwivnILgi/v/74FQ3YbqExBptFgGUGmJth74UU1
         ngr5Qh2WwPbHh+++zM3KH9qcnltDMmt9KHGEJEf3l96nMgt8p/ufuuqEEEF1K44AMDRc
         8LKpgK2WcnxANPbBGr3TVXkBfxM500XZTyHftoQBZBVpTa1+yNApJIpUFSGWhXCv72uC
         j0jgZ7t4C4Mvr5PLjyaE+vQSeM14AXTApKSiLBw4xL5iuwwfEB3xfaQ+eKgEgewyb9Id
         8ZR9pdvE06JeXk01sRNpO+qSWIrVO2PMd/BewbDoXsrXuvMs3nhASjUqv4JzZBQZTvqn
         7Jeg==
X-Gm-Message-State: AOJu0YyGSgtvhL8loAq5VqADj7fi+r3/UFnl0ul6sfokwMeXobyXb0+m
	t3HtGnTiMS9scMKCtvioCZu4khDqbF9o2Oz3w0ZEVzM0R1s0zGkl
X-Google-Smtp-Source: AGHT+IH44f8PoctJ+UUQoHuBK8wO76OKya6Ekoqj1caqFZBD2nIe6wuoZbw7YTlPevjde8uf9vIttA==
X-Received: by 2002:a17:903:1c8:b0:1fb:85ff:3f92 with SMTP id d9443c01a7336-1fbb6ea0722mr36906775ad.53.1720571172534;
        Tue, 09 Jul 2024 17:26:12 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a2accasm21896065ad.75.2024.07.09.17.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 17:26:12 -0700 (PDT)
Message-ID: <e782ca3a8162d5acc24120e4017938f8c0625a2e.camel@gmail.com>
Subject: Re: [RFC bpf-next v2 1/9] bpf: add a get_helper_proto() utility
 function
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  puranjay@kernel.org, jose.marchesi@oracle.com
Date: Tue, 09 Jul 2024 17:26:06 -0700
In-Reply-To: <CAEf4BzZq5p-CgJM6y6G=EyxwRwp46RxwhSvv=vvBodGKFrpMMA@mail.gmail.com>
References: <20240704102402.1644916-1-eddyz87@gmail.com>
	 <20240704102402.1644916-2-eddyz87@gmail.com>
	 <CAEf4BzZq5p-CgJM6y6G=EyxwRwp46RxwhSvv=vvBodGKFrpMMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-09 at 16:42 -0700, Andrii Nakryiko wrote:

[...]

> > @@ -10261,6 +10261,24 @@ static void update_loop_inline_state(struct bp=
f_verifier_env *env, u32 subprogno
> >                                  state->callback_subprogno =3D=3D subpr=
ogno);
> >  }
> >=20
> > +static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
> > +                           const struct bpf_func_proto **ptr)
> > +{
> > +       const struct bpf_func_proto *result =3D NULL;
> > +
> > +       if (func_id < 0 || func_id >=3D __BPF_FUNC_MAX_ID)
> > +               return -ERANGE;
> > +
> > +       if (env->ops->get_func_proto)
> > +               result =3D env->ops->get_func_proto(func_id, env->prog)=
;
> > +
> > +       if (!result)
> > +               return -EINVAL;
>=20
> result is a bit unnecessary. We could do either
>=20
> *ptr =3D NULL;
> if (env->ops->get_func_proto)
>     *ptr =3D env->ops->get_func_proto(func_id, env->prog);
> return *ptr ? 0 : -EINVAL;
>=20
>=20
> or just
>=20
> if (!env->ops->get_func_proto)
>     return -EINVAL;
>=20
> *ptr =3D env->ops->get_func_proto(func_id, env->prog);
>=20
> return *ptr ? 0 : -EINVAL;

Ok, will change in v3.

[...]

