Return-Path: <bpf+bounces-60145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F31ADAD34BF
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 13:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B618D3AD6FA
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 11:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EFE2857FB;
	Tue, 10 Jun 2025 11:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WkJr4faw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D417226527
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749554174; cv=none; b=UelzpX7De5Hqe5QsOnfuYqlIgXWBfZIqwXUXf0F5sXqIBE83pCrLxIsfN5Vt+Cl5JsxW1+R6dY6hKjnCYgLOPL+Jdo/h3ensxb6ocxQM+n8kWuNkxemW8SVHS5kq+pR1VNM8zuEJYCpb4jsNFbbX2ml2zBBR/MuEUm8lDiua6v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749554174; c=relaxed/simple;
	bh=Pq58LFalI0G1zQzquQdKV8kMWEePGzvcw/jnWKRfvvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIGIWtRPG457Ibs2o6G1jVBRCiHeZ6mQy1U2geLTIfiWnWRjSEzeUifMAjwAJaic80rvEcn+VLH48QULrIgXC0eXl4FZGRVvFkiFIf/90ATU8Cp86vT2K1KZnjvrKA5AqYiAWN9GcyjlfjIb8qPUZ6LbhId6Vbxn5ZpxGTz5Hcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WkJr4faw; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70e3980757bso41657187b3.1
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 04:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749554170; x=1750158970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRYdrxByQfviVMjn3PfJspn+iiLr6NbvXjzKXMXNGnw=;
        b=WkJr4faw7/WgrZ4DiFxmW4xIQOv8za+iao1hOKEeGPZIa43hR6Eg3PMrgOpoUSSeBz
         FrA3VP1I9wG/a+HFL7xoThaZAvsAQI7f/QOjNZcFVqupnIRCTLEEC+H32g7EzV/VxWx0
         PwNIOarldN3Go/atYWgQMH6lveSlS9FqV7JsgOa9mdr0y4FupnMZyv0BHdembghLooj/
         r721pOBJF2BS+li5IxOi8eW8md1Hozp4Be6HTb/JZ/0vjttQnwArG7O1KymFzWfWgIg/
         wN0HL3ivj7YNGN2BvTywz9RL7yBtyCNc1Us3HJhqjmKsVHBGH/Ddr5zrX3d4EUCBRYvx
         itOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749554170; x=1750158970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRYdrxByQfviVMjn3PfJspn+iiLr6NbvXjzKXMXNGnw=;
        b=ubVRvUEiZJj0h0V5UcXNKhLFPUnnj4WvRAP5i9Z7FjyAjFxq3RVC/qxPxNzNuxE0Pn
         C2ueBUK1cde3W+vhqBHtazOyfSvMIbAIBhR8IuVayl46VDM3ok5AGp6xv6vhTVAFQyVh
         UHDqIyuVIfLmbFEnAKGf3rcFMCvddvmdb6OEGg7qzOFeoeZzPHZiBKm11JnBYyrvd8rA
         f/azhYFUPhvqDVeuq/abIlfMODSBZZXRO35SVCxn1PGbYK/Kpc4m71ZAEy2YdURg21Nz
         3P+zwbO5GTVD1MwTYsk2oI/WYWnI6ffSAt/jr0fdNsrPoPK8Am8QKi8RikvpEHmDAz+N
         cJzg==
X-Forwarded-Encrypted: i=1; AJvYcCWZk1y/rCv7waMsFg5AWF3q5p8Fw2QP5wlRXElnqUsP7r7pP/ZENNGxWp6VxUtNsKQWUQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywmt99Lm1H/Fe+2r7OLXU/Tg8oHxFUAXfzv2MVdNFrAwV+oLSJ
	1WIsb0c4wfv93mQMDLXklkd0M/bWdaOSv1caamO0hlTu9O3jy+2WSorgjyDfnJuOX28tl50Z+0r
	jZ62oAZO59TN8c5GbytM+kdC4V17f/xWUQMZ36syFSQ==
X-Gm-Gg: ASbGnctitfz+om1Ve898pVSd3icv18dEfs/iTP13cwntth0UMTau138JZiKazfTh8o4
	9OcbUYuvgYaUPBgwcXnAJY3LwICIB0MlcGGoBsWUHnNn/gk7GaIAtlCGaAZ0AtNWCqHSJDxJ/sc
	mqQsMs0cDvH9l+uiKoPXQDQLIWWp2Iso6NJUGbX6tAUD2M
X-Google-Smtp-Source: AGHT+IFiYu6L+0hOxUKTy81XogIL5OBe3zG8xFQH7UF6Pa7lD69xoMiBUt6KHLP9DHyWMKkzA1qKEvCm9OEUHUfS28M=
X-Received: by 2002:a05:690c:9b06:b0:70e:2804:9925 with SMTP id
 00721157ae682-711338b2842mr43149497b3.9.1749554170517; Tue, 10 Jun 2025
 04:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609043225.77229-1-byungchul@sk.com> <20250609043225.77229-3-byungchul@sk.com>
In-Reply-To: <20250609043225.77229-3-byungchul@sk.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 10 Jun 2025 14:15:34 +0300
X-Gm-Features: AX0GCFu56urTmOISlprLwgHXC6db0zVW3wr-lqRXXoQOUbGJ5t4MqPrNUZKW9wU
Message-ID: <CAC_iWjKn6y9ku6HE7CcdPT6jL8P2Ee92oN0joMN3aJv9UsG27Q@mail.gmail.com>
Subject: Re: [PATCH net-next 2/9] page_pool: rename page_pool_return_page() to page_pool_return_netmem()
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	almasrymina@google.com, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Jun 2025 at 07:32, Byungchul Park <byungchul@sk.com> wrote:
>
> Now that page_pool_return_page() is for returning netmem, not struct
> page, rename it to page_pool_return_netmem() to reflect what it does.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  net/core/page_pool.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 4011eb305cee..460d11a31fbc 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -371,7 +371,7 @@ struct page_pool *page_pool_create(const struct page_=
pool_params *params)
>  }
>  EXPORT_SYMBOL(page_pool_create);
>
> -static void page_pool_return_page(struct page_pool *pool, netmem_ref net=
mem);
> +static void page_pool_return_netmem(struct page_pool *pool, netmem_ref n=
etmem);
>
>  static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool=
 *pool)
>  {
> @@ -409,7 +409,7 @@ static noinline netmem_ref page_pool_refill_alloc_cac=
he(struct page_pool *pool)
>                          * (2) break out to fallthrough to alloc_pages_no=
de.
>                          * This limit stress on page buddy alloactor.
>                          */
> -                       page_pool_return_page(pool, netmem);
> +                       page_pool_return_netmem(pool, netmem);
>                         alloc_stat_inc(pool, waive);
>                         netmem =3D 0;
>                         break;
> @@ -712,7 +712,7 @@ static __always_inline void __page_pool_release_page_=
dma(struct page_pool *pool,
>   * a regular page (that will eventually be returned to the normal
>   * page-allocator via put_page).
>   */
> -void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
> +static void page_pool_return_netmem(struct page_pool *pool, netmem_ref n=
etmem)
>  {
>         int count;
>         bool put;
> @@ -829,7 +829,7 @@ __page_pool_put_page(struct page_pool *pool, netmem_r=
ef netmem,
>          * will be invoking put_page.
>          */
>         recycle_stat_inc(pool, released_refcnt);
> -       page_pool_return_page(pool, netmem);
> +       page_pool_return_netmem(pool, netmem);
>
>         return 0;
>  }
> @@ -872,7 +872,7 @@ void page_pool_put_unrefed_netmem(struct page_pool *p=
ool, netmem_ref netmem,
>         if (netmem && !page_pool_recycle_in_ring(pool, netmem)) {
>                 /* Cache full, fallback to free pages */
>                 recycle_stat_inc(pool, ring_full);
> -               page_pool_return_page(pool, netmem);
> +               page_pool_return_netmem(pool, netmem);
>         }
>  }
>  EXPORT_SYMBOL(page_pool_put_unrefed_netmem);
> @@ -915,7 +915,7 @@ static void page_pool_recycle_ring_bulk(struct page_p=
ool *pool,
>          * since put_page() with refcnt =3D=3D 1 can be an expensive oper=
ation.
>          */
>         for (; i < bulk_len; i++)
> -               page_pool_return_page(pool, bulk[i]);
> +               page_pool_return_netmem(pool, bulk[i]);
>  }
>
>  /**
> @@ -998,7 +998,7 @@ static netmem_ref page_pool_drain_frag(struct page_po=
ol *pool,
>                 return netmem;
>         }
>
> -       page_pool_return_page(pool, netmem);
> +       page_pool_return_netmem(pool, netmem);
>         return 0;
>  }
>
> @@ -1012,7 +1012,7 @@ static void page_pool_free_frag(struct page_pool *p=
ool)
>         if (!netmem || page_pool_unref_netmem(netmem, drain_count))
>                 return;
>
> -       page_pool_return_page(pool, netmem);
> +       page_pool_return_netmem(pool, netmem);
>  }
>
>  netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
> @@ -1079,7 +1079,7 @@ static void page_pool_empty_ring(struct page_pool *=
pool)
>                         pr_crit("%s() page_pool refcnt %d violation\n",
>                                 __func__, netmem_ref_count(netmem));
>
> -               page_pool_return_page(pool, netmem);
> +               page_pool_return_netmem(pool, netmem);
>         }
>  }
>
> @@ -1112,7 +1112,7 @@ static void page_pool_empty_alloc_cache_once(struct=
 page_pool *pool)
>          */
>         while (pool->alloc.count) {
>                 netmem =3D pool->alloc.cache[--pool->alloc.count];
> -               page_pool_return_page(pool, netmem);
> +               page_pool_return_netmem(pool, netmem);
>         }
>  }
>
> @@ -1252,7 +1252,7 @@ void page_pool_update_nid(struct page_pool *pool, i=
nt new_nid)
>         /* Flush pool alloc cache, as refill will check NUMA node */
>         while (pool->alloc.count) {
>                 netmem =3D pool->alloc.cache[--pool->alloc.count];
> -               page_pool_return_page(pool, netmem);
> +               page_pool_return_netmem(pool, netmem);
>         }
>  }
>  EXPORT_SYMBOL(page_pool_update_nid);
> --
> 2.17.1
>

