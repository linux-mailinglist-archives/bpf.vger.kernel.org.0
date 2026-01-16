Return-Path: <bpf+bounces-79310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C6AD379F0
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 18:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F8023035072
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 17:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C043939BE;
	Fri, 16 Jan 2026 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vgBOHjzx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B78730EF7A
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768584173; cv=pass; b=lfF2lzNafqmZ+2rldOl3IRnDxWsGjYuMdDgWHEMKGTSU8yU0KbUAzhsp8PspiTf4Rv0dx8wfztQn38mVi8raW6tQQjKGbqenNyhEpH4oKAZuw3415nGE7i+bzxw4aJgAOkt3VL83B/9xHoO39tEXCbdfWTqbCwKqew2jYp+iM/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768584173; c=relaxed/simple;
	bh=hlDDNKYMaWOnKMiZZysallNw/K6iyHZJPklDuaoHxoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAHoDn/d9oTdzNFUuKF4LH1RqPHMYKPS+Z4ufpCSk7pmmRufx5LKsNNsveUhmCAgyrkjXruocQlvEBclsovJ25R8R2P5sgfSKTwl/39OqP72AQUIP09UlK1BYuI7x3VZJAZVL+vOLa29nRS5O+Msbej01BstYUUcn1XkuUw1AIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vgBOHjzx; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50299648ae9so532081cf.1
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 09:22:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768584167; cv=none;
        d=google.com; s=arc-20240605;
        b=Hcexm6XMh5FBfGmVDtjWTLmJLQIoK3nSxdpTmhjVVX01j1kUGMS7DovOdPWT3IzGVU
         6jq0uG7vTp/edOuhtugVo/n2BLVjtVB12mkC9ixxgMqpjdyFmpB1yu17KOW5ykLyoZtz
         mT+N0uNxfynbXGF/WjLwSmaS/2rtI0t+vRbg/+sXx5HJd00SAFXr4ZpgZTF91FlBmWqd
         BBQp5vCo0n2AhNIQ0p6a89EZPVvVKitDk3nv/GlBXd7DdDKW4IFZaN+l4MyKKUl4wLET
         7hfGUzQ1oBSGT+29KP6AuzO/5NyO9MLJ+m8xtM76HU7op41Fd8AhpnUz+lP1tbwcpGwR
         kSMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o8bloAHXlRqX7bbyuExKq5up0OoLL7i4hXe/j4ALHlo=;
        fh=G1qpSCpt+ru0E4tVKD97dWsqc4/B1KqE5VgkzZz+iZw=;
        b=ECM3mf5AHgiOGbKO2HhP/bLkNXTRVXtoJz1KOIIAOVA+kcMhgsYYzGrUBehx4oDI3G
         /pGJur72n3ketYGzkLIK9ze6Ra4Lncl7qYitO+d/tut/hqwY0DZsrJo4ShaghEXfRjRj
         rb/riq7miXJs2ZlZfwCkpkMc9fFKuS8z1W9yRNGW2gug5c4LkPJiabUDJIEYdJLjeUo7
         PMRycdq+c1HsxIE2o/CRrQyzV8iQDcRjEcTe56CEpwPaburxmRLiHW2oqx0nikWIJPiJ
         Bg2Q0eKvAs6Il8G32+BLaBrqh0tWkqysgqGiJ7ZcIlPBqOk37xFYgmDEOkPEFBfE6OCx
         apTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768584167; x=1769188967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8bloAHXlRqX7bbyuExKq5up0OoLL7i4hXe/j4ALHlo=;
        b=vgBOHjzx1yxeDP4t9CWYh65aX2qbYKllA0hRB4RFTsmJuxFTaxLoS2T3EpXS1TTQ2u
         O+/fPh1HDgUpY/qcZJLRR9fTqSjCULDxaSYa1gjxsVbLRGXm14mrAbqzgex7DrysPMbk
         rXJQoltgjhmfVKHM5JvNi68lzIujfOOYTd59yY/7RTg1ZDz9x4IAo/eF779wcgftVQhj
         ST62RwdwYNosvR+mQqrKkDhiMCO+b5N3IqyEIcoCvVu3cJC4jUE8kNNIQNBc3eSvhZr2
         kLScPq+ZgFhZQgeJtVFYfChSuDFlM1hFtKOhysRiDgDeBb4L2s0Vstxq+C7tOxBcer+s
         GQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768584167; x=1769188967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o8bloAHXlRqX7bbyuExKq5up0OoLL7i4hXe/j4ALHlo=;
        b=us0fZmha9E858Ab+20kQWSCcUBkPxDLcXL/bn46c7DkO3U2H05e1Nxul2YABYjvw3k
         pNCpR+U9Cgw85YL5nwZor/6bYBzsPbjLZjaBvDOZwEko43jpVOd1W4ZFAEOZ6d8UMJiL
         ni6Nte7LcfP9sIKKESLWo6hv75L0bA1dZIxwQiujcjex7Dt059tUyprA4H875g7S9iPD
         yO8vziyIpoXp6sCy/aOpIJrQMA+My4MqgfUcgy82a5G1expuE8nHZNqbZ2ksg+53xpUt
         GXOyTWeWmOXrGbV1Ym5LcH30Bo7alJm6cU+WriB1TYT1PwPk0q6QqvHHcjUI94NuFYm6
         Cu3g==
X-Forwarded-Encrypted: i=1; AJvYcCVE9kqhFI9uUEmRWqQI/rnpZ4qt7KW1lRISdSRrCLmUHAa8zlCZj3fxkQxqIkrMk3v41wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgFylhBRThZ7SEzPK7Lk2D0IgFJ4fc39y6B9x+0jMixcKe541K
	bby7CdMB4jr9y7Kf7kMn4wyhtt7nfvY/qcFbQIHGtmIDqU+TpCYSUyLe19w16Jwf3FD+Kjt5OaI
	MZysyEwJs++6Ob/6XvKZYCiSlEAHtbaYj9UuCjbOp
X-Gm-Gg: AY/fxX7dA5PRQLvBJg14urshjJa1iUvR8uQ1/yn/CPgDxv+x4kg+ce4ONpNHJtPG4fV
	t8D7c5Hp4cBr3gD+h2rGgvbmtA1Qbk4U7NJHgBPdPrjkCw9WNopU+Ka+9dbF3y8rwTb8vQ4A42D
	Eh+tRGIcm1qybwRmyKYpxkPkgulzQK6mU8EB8owg9Ihnfh5ySRnCjesi2okSpUsc2SDBBucimE5
	bSDXcJ6Of8niO/xR5tqHtPk0avq+Ns6FdmMqJWJ2Wefz6ABXOa5ExIIsBwMZg1kwbw3ww==
X-Received: by 2002:a05:622a:1446:b0:4ed:a65c:88d0 with SMTP id
 d75a77b69052e-502a22d2091mr4481531cf.6.1768584166336; Fri, 16 Jan 2026
 09:22:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz> <20260116-sheaves-for-all-v3-2-5595cb000772@suse.cz>
In-Reply-To: <20260116-sheaves-for-all-v3-2-5595cb000772@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 16 Jan 2026 09:22:34 -0800
X-Gm-Features: AZwV_Qi0GmjrM2TkwQbQz0K1_wtQP23K0QN4VNJnjVMrHBscdtK49aOG8chDQLg
Message-ID: <CAJuCfpG0SCGf-TOTRi0d8e0Zoh4r5-xXByhnmJRSiyUt9=LO4w@mail.gmail.com>
Subject: Re: [PATCH v3 02/21] slab: add SLAB_CONSISTENCY_CHECKS to SLAB_NEVER_MERGE
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 6:40=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> All the debug flags prevent merging, except SLAB_CONSISTENCY_CHECKS. This
> is suboptimal because this flag (like any debug flags) prevents the
> usage of any fastpaths, and thus affect performance of any aliased
> cache. Also the objects from an aliased cache than the one specified for
> debugging could also interfere with the debugging efforts.
>
> Fix this by adding the whole SLAB_DEBUG_FLAGS collection to
> SLAB_NEVER_MERGE instead of individual debug flags, so it now also
> includes SLAB_CONSISTENCY_CHECKS.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/slab_common.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index ee994ec7f251..e691ede0e6a8 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -45,9 +45,8 @@ struct kmem_cache *kmem_cache;
>  /*
>   * Set of flags that will prevent slab merging
>   */
> -#define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER =
| \
> -               SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
> -               SLAB_FAILSLAB | SLAB_NO_MERGE)
> +#define SLAB_NEVER_MERGE (SLAB_DEBUG_FLAGS | SLAB_TYPESAFE_BY_RCU | \
> +               SLAB_NOLEAKTRACE | SLAB_FAILSLAB | SLAB_NO_MERGE)
>
>  #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
>                          SLAB_CACHE_DMA32 | SLAB_ACCOUNT)
>
> --
> 2.52.0
>

