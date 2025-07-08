Return-Path: <bpf+bounces-62656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF8EAFC9BC
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 13:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6599A3B6EA4
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 11:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59F32D94A4;
	Tue,  8 Jul 2025 11:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mU0sxF4N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974FB26CE02
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 11:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751974796; cv=none; b=Mwyh0VNT40s4rx/byboPGsNLbBZlLlIePUNUFv8ZWFkNCzqGgKOdJaYyGTModH/6wks94X2M20jKSEEAbtFt9LtCTskenX83LaIBacNkRZPWEUCC/gJFKHbYYKZ5CZqex1DdnY+nsDUzra+Y7dQ2IfQtz4Mf+0lQQqrcqY5iGac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751974796; c=relaxed/simple;
	bh=anrcJkhR0K2UFvABRyTbtjlESGIkubeRDAlquXXlVdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMSByhknh/XrMpWmcJSiXJ5muaFxttWClEQxHXUC1geF/7+tkOhlN/YZll2cY85aq2Q+gQ4Z2JWFwRfMutNldzm4oHj7ujThokOTbojHBF59wGqK5IzqmLu2wn+lFOo3Q0HGREzm9ZarbwGWSUy/Dk/Ry9Lnclz5M0o/+0NJqaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mU0sxF4N; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70e767ce72eso38665767b3.1
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 04:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751974793; x=1752579593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eMeJVMzIthoABLN3c573S0lEtUCztks52HyLR1vSyo=;
        b=mU0sxF4N67OcXvp/G/I8hXBR7tQ5dePAp5fFejtXyB18qBhn/5ajMQM4YAtY7O5gwW
         duOkHtuGmVBebZJxrxRC4INqFuXxxGk+QJo938rJpOy6redeRnw7dgVwKgw2a7HuSDTW
         Jx5Xfuvbj1HeqhotaCq3IPWQXSnOLOFVKhj/ydYGhBvpAV3eXnxWDasjkHmqPOV/v1+1
         0BSqQNHuoFxP1mVcffcUpBuE+8FQgpxePn4b8kI6Mmh9IBPORvyVFYg54eOP68B1Z7kb
         FcPWr8OCKwSqhVCI0lIt+mxIHuQRvuxyClGM8HX5Y3mxbOFFrJd7YG+Us953IVCvEDOH
         Y3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751974793; x=1752579593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9eMeJVMzIthoABLN3c573S0lEtUCztks52HyLR1vSyo=;
        b=n5w8bvfixIn7semTiXs7qvgD3AntlkUYF0K5dpegRmEeUO9pqeQ84MQVn1C2iZ5x+b
         JHXm5IZ2o0ELedWo+UGU7hN9uEA1KzAIY9BVz/dnhncn+UqjQ4OOgMzlP5P9ITX36YS2
         B9Fir7RQX5mELuDwCLPUmrSlxZ6sa+98YK4Phlqlh9AEZ280dBJUCgQoipH3WvgwcD8w
         qFahNSlq+9HfkuTtqAV78ESKzu0a0fseYU3gB86nsNcaHu9dK2wgtBFvUmQiwPOlf7uO
         w3kghOLB4b9SW1z3ZZUP8UVLL/MfVtoLSK/kRi7u3MkoueKvkmfZ9KwSyMH1Gy6/jiSq
         5JVg==
X-Forwarded-Encrypted: i=1; AJvYcCW/gfCDTRyOjOvwHI0MTYJhQFxU+ya55KT1VKbBEvnz1EokKsqu75KVYEyeZU9QHN7HeYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFh+8xLMJxLgMX6wQRNxMgn0c2H+Yy5wpNKdtNXpskU3YNvTFU
	ZI1kOxDVSl8z2rNcAyMis9uHtg1XWpj8pQuVc+8aBGa9iEx/+BRcpxJwB2Vt68CEFwSstygm7P6
	9Tx8trwrrVI/GyGLJzR6XsGwmu+x7G0r9J+btYg0sBQ==
X-Gm-Gg: ASbGncsyOIZaTDUsRyo1z68bYpwNxCSauPqNX/An2COHGolcDLrOrJXjNwpR3nO+lVt
	FPPCW9V7+dpYnymfkA+B8rjUy3SOjA1NO8flx1AaZLbqV/gbedaq4Nn350Jx7APGUtVKYS2LOoS
	Go4rkkvp5GcUTArysW8DYNYdbnUBzcoM0DYWhSSdsLzvc=
X-Google-Smtp-Source: AGHT+IG6kwwi/O1JpxJQzqce7OC4YlDVtNrzWESKs36ZU9aEADMh6ZKR839SIoeejlL3CWzFXOhNldDkEPqgFZcBnJY=
X-Received: by 2002:a05:690c:dc7:b0:70e:6105:2360 with SMTP id
 00721157ae682-71668deda5amr227576207b3.24.1751974793396; Tue, 08 Jul 2025
 04:39:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702053256.4594-1-byungchul@sk.com> <20250702053256.4594-4-byungchul@sk.com>
In-Reply-To: <20250702053256.4594-4-byungchul@sk.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 8 Jul 2025 14:39:16 +0300
X-Gm-Features: Ac12FXwbisTy0vRZbr1dnSDkZ4VZxeOs9_WADPGLv9-1kgfrQv9Qj4QdZfgR36o
Message-ID: <CAC_iWj+mOqEfyanEk52Y7Pw4zMs_tZbES=5xBV7AfAG-nTUPpw@mail.gmail.com>
Subject: Re: [PATCH net-next v8 3/5] page_pool: rename __page_pool_alloc_pages_slow()
 to __page_pool_alloc_netmems_slow()
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
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Jul 2025 at 08:33, Byungchul Park <byungchul@sk.com> wrote:
>
> Now that __page_pool_alloc_pages_slow() is for allocating netmem, not
> struct page, rename it to __page_pool_alloc_netmems_slow() to reflect
> what it does.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  net/core/page_pool.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 95ffa48c7c67..05e2e22a8f7c 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -544,8 +544,8 @@ static struct page *__page_pool_alloc_page_order(stru=
ct page_pool *pool,
>  }
>
>  /* slow path */
> -static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool=
 *pool,
> -                                                       gfp_t gfp)
> +static noinline netmem_ref __page_pool_alloc_netmems_slow(struct page_po=
ol *pool,
> +                                                         gfp_t gfp)
>  {
>         const int bulk =3D PP_ALLOC_CACHE_REFILL;
>         unsigned int pp_order =3D pool->p.order;
> @@ -615,7 +615,7 @@ netmem_ref page_pool_alloc_netmems(struct page_pool *=
pool, gfp_t gfp)
>         if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_=
ops)
>                 netmem =3D pool->mp_ops->alloc_netmems(pool, gfp);
>         else
> -               netmem =3D __page_pool_alloc_pages_slow(pool, gfp);
> +               netmem =3D __page_pool_alloc_netmems_slow(pool, gfp);
>         return netmem;
>  }
>  EXPORT_SYMBOL(page_pool_alloc_netmems);
> --
> 2.17.1
>

