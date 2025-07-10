Return-Path: <bpf+bounces-62964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638FDB00B4F
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 20:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249C55A22FE
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 18:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F12F2FCFC3;
	Thu, 10 Jul 2025 18:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qObU1zue"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D16E2F0C4A
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752171987; cv=none; b=ExyxsRRH4GCdHw61Unz4NwRYIbGW3A4INmrl98RYCtteDkTP8kjnfxlysk7yX1631lp6TFA2OnZxFqh4IA0Nzy/9n8dg/K+F7aiTTMY134tYLnOUiNP6h3eHDe3JqVUD/YI5Aje2EAF35/96DrQtUioBvyujAIFVbKcEaZi0ZQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752171987; c=relaxed/simple;
	bh=DQ/y57eCcvCivMqXieykxCIkDza/1dPM5uPabJRz16o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTYG3c2KwH48boDAZW0eTekYZkXudjVUVQHqPd7ObIVMUcONnaVbDCldwNZypyDabkSa5R41//aOn+SRNro8hue6jSqFqh3v3GtC6iSB5+3Slg0Jp8XKAZ4tylT071M8kXuKszlCt2q/ypofng6fLkhZ+xW2tnkwj1okYqzYS4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qObU1zue; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso1512a12.1
        for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 11:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752171983; x=1752776783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpVeUDzlloshth7hyY4uUrRygX8GK+L0hY7EdHxCTWk=;
        b=qObU1zuerGhbYWlfulILtsMApJEO572cb99Ey657M5ZIW5FJn9qSNnybTUmZwPXmoo
         6P1pcpOL17ZItstd3CjuuSqb+erRZa4J7rQHM4ORASF5f11JNxKu0xDSlD/J1YA71gHW
         fRONoNj2vmMzTagcuqJ8ulV5PLMfLTdVZdq9OlnKV82aY69cKtL9CZ7kzUANxH271wGA
         P/Hks07foD1XCHZENTyruReqQLmOfQkLM1ii2gdSVPyMb9nohjNE0lRXOR4A/JvkN58F
         LwP+GaUG6r4NOEEdxPUCvO054zG9vCYleh3rFncue61UmbDCdFOBqnJEfIScIY/iHIC5
         JcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752171983; x=1752776783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpVeUDzlloshth7hyY4uUrRygX8GK+L0hY7EdHxCTWk=;
        b=enUPvJBROxsHNVPsQ5Yu4173B7+5vzqEgS20jzd/KQoH/jH+LhyseL4vCxdQAKf1j6
         9dqhTgDR4hUlJmR49gdlImg3GMEa/0eA/+hUlplORUVW+D3UWJnnNa6qw9ifYnKx37m1
         CQyBs70i/oc8rzLpdRV3PLJ0DPCjmQkCw2EDuDJG5pCDahd4/T/RUdD4+n12sl97rhSs
         sexNEh8jkWFtuf0TiNQePFnXQuebQU0G4/m19Q7IyvWhwdslCZowmDWlXuussaS0yEZE
         OlR4miIj0Qwttu56CVKtv4NWOTMj9J0NWYx2EOMYQOYmBzSXUlSmo63CBM6HcJNtbWtT
         ZISQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/P6pLJNpUp3hSzkVIV0ytnzVfHQ52FBCEBkDD5FL2LOkv6LNdgr9QsgA12oc2DvH460o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2CR9cZzkUmOsXrfvrfULkADHsU6944A2QXRTS6VBcGc0kAlpQ
	SEymZ8bJzu3RdaAuH4PBju1hzEqp+DctuTzdZbDFh0osjwYCYxvkDS1QEvtrR/I2gDPMNPu+D9/
	oRHXI2P1wCMXV8S3ZOiR7f9IJU4EgHpAiu/crgjFs
X-Gm-Gg: ASbGncuBEDuvX9tAbZyV43Va+bg/hs+A3sucvi1zgYWJ+yQkLeGtQ25h/pYXle1z/c2
	npIzS5QeULbW4+J9PWeKCUZT3f2ZwXL+Nqpi1a5K7/vU0CvYwF1/1SadmXMg8XXMbosJ5lzHugR
	1Kbtc0t7CcFQzfIzwN9vVVlPVjAysBFgWJo0lUhb/Rkvywb9cGAfR10XrjzxQNde/AtA63/Ao=
X-Google-Smtp-Source: AGHT+IFt7W8JAheHiVqwt4ZBR3CQtXpumX/T7A5/rBmH2QebswkJBxnWs6YN36d9U3n7K42s+O7r2vNQ3sha7Qd9AVA=
X-Received: by 2002:a05:6402:24d3:b0:607:d206:7657 with SMTP id
 4fb4d7f45d1cf-611e687e614mr10195a12.2.1752171982710; Thu, 10 Jul 2025
 11:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710082807.27402-1-byungchul@sk.com> <20250710082807.27402-8-byungchul@sk.com>
In-Reply-To: <20250710082807.27402-8-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 10 Jul 2025 11:26:05 -0700
X-Gm-Features: Ac12FXyyC8r-KEBOBjPhKMa8MrPinEu-RU7EeVBu--QTlNg-z0ciuFeVDRS6Ldc
Message-ID: <CAHS8izMo5QLb5CrrdfBnaG_1kWd=D7iQM+2vB0Gm-pbH9tmk1g@mail.gmail.com>
Subject: Re: [PATCH net-next v9 7/8] netdevsim: use netmem descriptor and APIs
 for page pool
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
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 1:28=E2=80=AFAM Byungchul Park <byungchul@sk.com> w=
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
> index e36d3e846c2d..ba19870524c5 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -812,7 +812,7 @@ nsim_pp_hold_read(struct file *file, char __user *dat=
a,
>         struct netdevsim *ns =3D file->private_data;
>         char buf[3] =3D "n\n";
>
> -       if (ns->page)
> +       if (ns->netmem)
>                 buf[0] =3D 'y';
>
>         return simple_read_from_buffer(data, count, ppos, buf, 2);
> @@ -832,18 +832,19 @@ nsim_pp_hold_write(struct file *file, const char __=
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

Add page_pool_dev_alloc_netmems helper.


--=20
Thanks,
Mina

