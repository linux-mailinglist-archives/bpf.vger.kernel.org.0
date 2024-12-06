Return-Path: <bpf+bounces-46242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 657739E6543
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 05:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30FC6169D04
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 04:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971DD194158;
	Fri,  6 Dec 2024 04:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E6EpELio"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D1619413C
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 04:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733457811; cv=none; b=E/5mxEOtpFecmA95bf4ne5LMNM7j19VEpNtmoQ6SVIzspEOWEHglxK51ynxQYUXo21HXoFBEJoDqR9gr1RyJlY6h6fWUfUyL1PH3Blv+iYoKhd8K2HDYoolGqKQT0UkD3pdq+pHYna3Gspm3XNFRFiR759BG4mfn4yaCcZTpHeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733457811; c=relaxed/simple;
	bh=A3SGk/9v6Ii1r5FgKrlhWkuWJeoFjLubfvA29s6iw2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGQvSyOuBQHJaSkNGYzEyAEcC/LK96y/XLycTR9AKpRjOEZOpceE+ZR3aD5O/fnLVBF0SjbW35ETWYbYx2nFgEjiIneu3BUwDzWNujNsvQ3OuH9dxIMyLMRIU7DZNh4g4pI+VZU3UhaCX0lafh7a39IkZxesnNL/RLWmIIC1VvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E6EpELio; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-466ab386254so80981cf.1
        for <bpf@vger.kernel.org>; Thu, 05 Dec 2024 20:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733457807; x=1734062607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRaBRImZT0bCFGOpetfgswpmtuAWTeO6WYUFKX2APEk=;
        b=E6EpELio2X2lIOXCdEfUO45gP+Hlpo0Ao2w/G0UGYDiX4v9T3Lde/D9HEzQQZ9lDSc
         rL2CTKu7nK/IU1hZNdNAXOy3GQwrP/bPRzX0rux/pFvP8ELZ6+NDYpYvkDMNGhMZs16q
         Grft+EHcmMHkwhGrD7nVrY48W7TkqfWWawAgIjf0s8ThKSxbe3OTXBczdAhsGHKfTdjJ
         6BLWUW2bTJlTRzCyxQ1QW981SvMEaitE0FkZnGnI2m56xzYAnoGOSG5EE61skjPy/5BH
         hLl2iGlRmLGM2UhWC/aQTfP4EDRTzwOlfjoxYlLHHh7ysDWXHD1hj2j6LlsLFXa2Dk18
         oS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733457807; x=1734062607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRaBRImZT0bCFGOpetfgswpmtuAWTeO6WYUFKX2APEk=;
        b=Qkc7Jz7A9ZVcRZfdVjrx5ZsO6U010xx48pT17rMXzA9ITACLqRZ7KPltZv9lW2cf4Q
         TNHnsXhfrXIoZrAxk94/4UGF38LpkeL/c0AAFLxT+djDVcLYDvdljiRFc93iU1TICrqC
         NJmsepPgIJVUa1PIvZRGYFGGrVuCgwwHPctftqk3dF0JoUFmGGw5HOWxbEv4ZM7uTZow
         TATKuymsHDY4BdN05b5CRicHt4OK8Kc/xOxZlgfUD7H+jk+J4ZgSnJBlKSfOcWsR35P1
         7sr7SofOW45xwATDWL5NHTgZWKx+AYnnYg6Z9ajmZKDxJTVNbAfO5TjLqdoBQQ7vx4bj
         dvtg==
X-Forwarded-Encrypted: i=1; AJvYcCXnUBluosHwNYhDa/RQZ0+ZdAnzvZ5rSwP+x9YwqocWT/WG/uXbJCLUf3y8kV16MNJcn/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGLbZ3Thmuvb5qqfPQlx9miLAlN/7VJnZjze7YT9gyG9GfbE7b
	d3WvlyV/ZU6t3VuqKbH2v4fcRTctr+6IiwdDEn6yVAjm91+kscidh9eo14DChMaIgyWGaX+l0Q7
	CU1I6mxqBKnFbZmNBG8OTEMMY/ByC2K7ylbP4
X-Gm-Gg: ASbGncuJtMvSyDfyIfxKWARloTy2mj43wfHVcJRcDUzyPKaZy4vzzCpjeaN0bqwRQt9
	lsDJ1uRsIaL9jYdzxLrsiplZOM2nnNnw=
X-Google-Smtp-Source: AGHT+IGcSSMGxMrlYSk4sKwYQHoFpyylVOqUvzsP50UgoLlDDqZI4Uomn4bdXd0GSHYzl2igGS2FwKfVWS/HX8ILwNM=
X-Received: by 2002:a05:622a:4d04:b0:466:8e4d:e981 with SMTP id
 d75a77b69052e-46736fce6damr1141781cf.3.1733457807069; Thu, 05 Dec 2024
 20:03:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203173733.3181246-1-aleksander.lobakin@intel.com> <20241203173733.3181246-8-aleksander.lobakin@intel.com>
In-Reply-To: <20241203173733.3181246-8-aleksander.lobakin@intel.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 5 Dec 2024 20:03:15 -0800
Message-ID: <CAHS8izNBBOMMywC+v642S1pSD23_iVfg8beBHBxMci5zQt5+RQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/10] netmem: add a couple of page helper wrappers
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, nex.sw.ncis.osdt.itp.upstreaming@intel.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 9:43=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> Add the following netmem counterparts:
>
> * virt_to_netmem() -- simple page_to_netmem(virt_to_page()) wrapper;
> * netmem_is_pfmemalloc() -- page_is_pfmemalloc() for page-backed
>                             netmems, false otherwise;
>
> and the following "unsafe" versions:
>
> * __netmem_to_page()
> * __netmem_get_pp()
> * __netmem_address()
>
> They do the same as their non-underscored buddies, but assume the netmem
> is always page-backed. When working with header &page_pools, you don't
> need to check whether netmem belongs to the host memory and you can
> never get NULL instead of &page. Checks for the LSB, clearing the LSB,
> branches take cycles and increase object code size, sometimes
> significantly. When you're sure your PP is always host, you can avoid
> this by using the underscored counterparts.
>

I can imagine future use cases where net_iov netmems are used for
headers. I'm thinking of a memory provider backed by hugepages
(Eric/Jakub's idea). In that case the netmem may be backed by a tail
page underneath or may be backed by net_iov that happens to be
readable.

But if these ideas ever materialize, we can always revisit this. Some
suggestions for consideration below but either way:

Reviewed-by: Mina Almasry <almasrymina@google.com>

> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/net/netmem.h | 78 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 76 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 8a6e20be4b9d..1b58faa4f20f 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -72,6 +72,22 @@ static inline bool netmem_is_net_iov(const netmem_ref =
netmem)
>         return (__force unsigned long)netmem & NET_IOV;
>  }
>
> +/**
> + * __netmem_to_page - unsafely get pointer to the &page backing @netmem
> + * @netmem: netmem reference to convert
> + *
> + * Unsafe version of netmem_to_page(). When @netmem is always page-backe=
d,
> + * e.g. when it's a header buffer, performs faster and generates smaller
> + * object code (no check for the LSB, no WARN). When @netmem points to I=
OV,
> + * provokes undefined behaviour.
> + *
> + * Return: pointer to the &page (garbage if @netmem is not page-backed).
> + */
> +static inline struct page *__netmem_to_page(netmem_ref netmem)
> +{
> +       return (__force struct page *)netmem;
> +}
> +

nit: I would name it netmem_to_page_unsafe(), just for glaringly
obvious clarity.

>  /* This conversion fails (returns NULL) if the netmem_ref is not struct =
page
>   * backed.
>   */
> @@ -80,7 +96,7 @@ static inline struct page *netmem_to_page(netmem_ref ne=
tmem)
>         if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
>                 return NULL;
>
> -       return (__force struct page *)netmem;
> +       return __netmem_to_page(netmem);
>  }
>
>  static inline struct net_iov *netmem_to_net_iov(netmem_ref netmem)
> @@ -103,6 +119,17 @@ static inline netmem_ref page_to_netmem(struct page =
*page)
>         return (__force netmem_ref)page;
>  }
>
> +/**
> + * virt_to_netmem - convert virtual memory pointer to a netmem reference
> + * @data: host memory pointer to convert
> + *
> + * Return: netmem reference to the &page backing this virtual address.
> + */
> +static inline netmem_ref virt_to_netmem(const void *data)
> +{
> +       return page_to_netmem(virt_to_page(data));
> +}
> +
>  static inline int netmem_ref_count(netmem_ref netmem)
>  {
>         /* The non-pp refcount of net_iov is always 1. On net_iov, we onl=
y
> @@ -127,6 +154,22 @@ static inline struct net_iov *__netmem_clear_lsb(net=
mem_ref netmem)
>         return (struct net_iov *)((__force unsigned long)netmem & ~NET_IO=
V);
>  }
>
> +/**
> + * __netmem_get_pp - unsafely get pointer to the &page_pool backing @net=
mem
> + * @netmem: netmem reference to get the pointer from
> + *
> + * Unsafe version of netmem_get_pp(). When @netmem is always page-backed=
,
> + * e.g. when it's a header buffer, performs faster and generates smaller
> + * object code (avoids clearing the LSB). When @netmem points to IOV,
> + * provokes invalid memory access.
> + *
> + * Return: pointer to the &page_pool (garbage if @netmem is not page-bac=
ked).
> + */
> +static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
> +{
> +       return __netmem_to_page(netmem)->pp;
> +}
> +
>  static inline struct page_pool *netmem_get_pp(netmem_ref netmem)
>  {
>         return __netmem_clear_lsb(netmem)->pp;
> @@ -158,12 +201,43 @@ static inline netmem_ref netmem_compound_head(netme=
m_ref netmem)
>         return page_to_netmem(compound_head(netmem_to_page(netmem)));
>  }
>
> +/**
> + * __netmem_address - unsafely get pointer to the memory backing @netmem
> + * @netmem: netmem reference to get the pointer for
> + *
> + * Unsafe version of netmem_address(). When @netmem is always page-backe=
d,
> + * e.g. when it's a header buffer, performs faster and generates smaller
> + * object code (no check for the LSB). When @netmem points to IOV, provo=
kes
> + * undefined behaviour.
> + *
> + * Return: pointer to the memory (garbage if @netmem is not page-backed)=
.
> + */
> +static inline void *__netmem_address(netmem_ref netmem)
> +{
> +       return page_address(__netmem_to_page(netmem));
> +}
> +
>  static inline void *netmem_address(netmem_ref netmem)
>  {
>         if (netmem_is_net_iov(netmem))
>                 return NULL;
>
> -       return page_address(netmem_to_page(netmem));
> +       return __netmem_address(netmem);
> +}
> +
> +/**
> + * netmem_is_pfmemalloc - check if @netmem was allocated under memory pr=
essure
> + * @netmem: netmem reference to check
> + *
> + * Return: true if @netmem is page-backed and the page was allocated und=
er
> + * memory pressure, false otherwise.
> + */
> +static inline bool netmem_is_pfmemalloc(netmem_ref netmem)
> +{
> +       if (netmem_is_net_iov(netmem))
> +               return false;
> +
> +       return page_is_pfmemalloc(netmem_to_page(netmem));
>  }

Is it better to add these pfmemalloc/address helpers, or better to do:

page =3D netmem_to_page_unsafe(netmem);
page_is_pfmemalloc(page);
page_address(page);

Sure the latter is a bit more of a pain to type, but is arguably more
elegant than having to add *_unsafe() versions of all the netmem
helpers eventually.

--
Thanks,
Mina

