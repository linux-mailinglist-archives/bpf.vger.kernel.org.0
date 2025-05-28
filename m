Return-Path: <bpf+bounces-59084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA56EAC600E
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D0A4A40CA
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394F81E8338;
	Wed, 28 May 2025 03:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dfqEMqrq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A8E1DC997
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 03:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748402770; cv=none; b=q7UFT2JL9SPJKlMoJ7f3Wf0CABJqjIiyjkbEBnxAh3nT8wApJCcheMUdIWXwYEExo5D+JMySLQQzFe+RRn4vS8lVITDvaf0oh+b4JbeCByS2Ty/n+hRuV/HsX+GX7zjx6Et26+33tNrUhrsgchkkGlGMa7hFCUV5IeIPJ/7FIxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748402770; c=relaxed/simple;
	bh=irICf6c+dbWcps5WUkpRBcsuJ4acrR/1KHZQjMl8zgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5XjGrzq+zyVrprmvAcgn8TuIxo3727RMOy9scXhBwkFoEJH5u7Wnd3KF5tJqRjxg3vKUEfCuW29V3yKTlpQiodijKj1EKBHkGi0+AByYoizWs1lMvllKaYQ73I06rs/kjDz/88TQ4JcgrFmYqA76cEfQsvJcEFOy9vymMSFWBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dfqEMqrq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2348ac8e0b4so71795ad.1
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 20:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748402768; x=1749007568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pC6sHkIPVDjbbp/TvAjB2CiwQtgjU9LtSMl4Eh3TE4g=;
        b=dfqEMqrq0mZp5xR+BW8pMCikI/NEUt1Uf1fY2jJsq+00vq1U9pxDWRbfqAvmJ8A0rw
         xgLG3r+eZnFOyLP32L8MEBa79BqjjkJaR6Lapx2MGiwV1vXGy/2lsptbaMdMOQyyRSKz
         8zYBjNpETf4muisL71jZskFjy/x9joPF5nWkCuUgGePagIPyBv9Dqo1csdvIsG7+zypq
         SodMIOR+mWC+aLR72u+lr3frmjlTN4DeS5Kp5J18T+QTQAGRE9V9xCZCqx3LQg55vYXD
         KvhdqBVvzjCUEbVCZyyR0Bxl4qqdU1EE1Hg2xZwhRXJuXO9auKmmaqPgXednZIErVZhS
         MGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748402768; x=1749007568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pC6sHkIPVDjbbp/TvAjB2CiwQtgjU9LtSMl4Eh3TE4g=;
        b=Ypq0Rv1somRIwylBGqzUHsJNWJGnJHNGGtqwtis96MHlk1cSIXKx6VhW3CKF918WE8
         cGamZDqHgsi4Ca1faUBK3VZrDPl6y8xvxitwTEiF7e8IBOVXfaeVUQlwUbrQVegjqIRf
         KrpkKxq8hP8biyWhckbdP8NQWFq0tjY0tY/h9PwUfhAvAMKLxVilFJCoG7HawYAcBOjM
         qzFhUjG86GX5ExWagUtMWKjnzgPulXI1geOZe30T6NuMJUF6YLk+4pDPqCig/OKP15cV
         MI12rEQyBpNJb44f+Tdaepo+usftVrNfAEeSMaXa3NKfPz8YvsxTb4PYQ0n5/qb0o8Qa
         h3ng==
X-Forwarded-Encrypted: i=1; AJvYcCUGYNL8LfdMocQ2AGfTrsvZlyvzHNAdHdFAazMIhxfreultAOFhn+F+KrsYmT2k9Ojed9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYSuBV0+e0BNPFVGZ9HSssYGYsGmtc9hyhifV4k45iDyIecltq
	KTFpPEcUB1hhEad9fuD4MhrEUwMFsdakAUFZ/FW1Vkd8uYCIS18T6LcRZqJyzUIjfcC5+lnqbfa
	h3l/dE7L7o1ZVE/VnR8TJkqrsVkHr0YPuK4MNxcB6
X-Gm-Gg: ASbGncuiZOWKHfoHRWiM2h893ASINNzglAFYiLd6CYWdW3a8cOcJJYYXjP4S2h2xzBA
	ySVSOgs2dgh95VWfIO/N14VNyeQcpe488ADT5ARtYWEnBtvyBxlpsr3hjM1AVz/nyzUGOJoWI9E
	f6XGwOtXtYQRxsJwULEfoxzXFW/XDWv4HA/lWPUYDCdeu1
X-Google-Smtp-Source: AGHT+IH0SdWqtpcrx7kZULvFQ/jBiI4ccb33aNOal3Xvlxj7HLVrkYsHJhBPn+sBv7pWcjn5U7lmk2tHlbR4olhV5EM=
X-Received: by 2002:a17:902:cccc:b0:234:afcf:d9de with SMTP id
 d9443c01a7336-234cbe66525mr983825ad.29.1748402768251; Tue, 27 May 2025
 20:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528022911.73453-1-byungchul@sk.com> <20250528022911.73453-16-byungchul@sk.com>
In-Reply-To: <20250528022911.73453-16-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 27 May 2025 20:25:54 -0700
X-Gm-Features: AX0GCFsF3llt1Wv3Opom6aB7xsmP7fiWyPOynYW18ouw8kopxdeymljCjENmAog
Message-ID: <CAHS8izMwUvLYZipvj+0gcK4Ch8EqGu3g00aP488563VD3d9N9g@mail.gmail.com>
Subject: Re: [PATCH v2 15/16] netdevsim: use netmem descriptor and APIs for
 page pool
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 7:29=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> To simplify struct page, the effort to separate its own descriptor from
> struct page is required and the work for page pool is on going.
>
> Use netmem descriptor and APIs for page pool in netdevsim code.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  drivers/net/netdevsim/netdev.c    | 19 ++++++++++---------
>  drivers/net/netdevsim/netdevsim.h |  2 +-
>  2 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netde=
v.c
> index af545d42961c..d134a6195bfa 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -821,7 +821,7 @@ nsim_pp_hold_read(struct file *file, char __user *dat=
a,
>         struct netdevsim *ns =3D file->private_data;
>         char buf[3] =3D "n\n";
>
> -       if (ns->page)
> +       if (ns->netmem)
>                 buf[0] =3D 'y';
>
>         return simple_read_from_buffer(data, count, ppos, buf, 2);
> @@ -841,18 +841,19 @@ nsim_pp_hold_write(struct file *file, const char __=
user *data,
>
>         rtnl_lock();
>         ret =3D count;
> -       if (val =3D=3D !!ns->page)
> +       if (val =3D=3D !!ns->netmem)
>                 goto exit;
>
>         if (!netif_running(ns->netdev) && val) {
>                 ret =3D -ENETDOWN;
>         } else if (val) {
> -               ns->page =3D page_pool_dev_alloc_pages(ns->rq[0]->page_po=
ol);
> -               if (!ns->page)
> +               ns->netmem =3D page_pool_alloc_netmems(ns->rq[0]->page_po=
ol,
> +                                                    GFP_ATOMIC | __GFP_N=
OWARN);

Can we add a page_pool_dev_alloc_netmems instead of doing this GFP at
the callsite? Other drivers will be interested in using
_dev_alloc_netmems as well.

--=20
Thanks,
Mina

