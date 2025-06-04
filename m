Return-Path: <bpf+bounces-59640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A04FACE10E
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 17:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441023A7EBB
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 15:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDB329187A;
	Wed,  4 Jun 2025 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lYzCSoQM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AC54AEE0
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749050073; cv=none; b=atrUuWf6w2/RpNd2Yoynu5Wsa9ACBDrZdqsp/Tng3TIo5WQqZ7pYY/pMrvCym3r8BuDP5K65zXvKIcEgLHH7iX8To8hg3KuySG3FxDWwZlFxsmbZo6qPZ7FSrtbP6/SfP8CXMa0MJw3PEKPfrFme+v5/Hw1osKIneMBjorkvggA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749050073; c=relaxed/simple;
	bh=Vz9j+gRU9u8lCxApmtclw2M381IMN+MeB6Q2Te9JwCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eb0B4Jzv+LchAD1BbN11nzVJhBFcVKjG3pr4Vudi4D+HpFvoeEMvpdzSphXqxj933GL/0bGnSvhaSRvWrcR2qny1UTG85cju6WlwPW/3dNu+h2sbAG/HkTZ7U5gXyDqBadRT3eCsNJ7fbbEDH80kTrMkPvkXCby4JnjvqkIVYbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lYzCSoQM; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a58ef58a38so248151cf.0
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 08:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749050070; x=1749654870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utxbGnGIbzF8mH+ke5le74ATfkvfWNo9bI2IYs+ukk0=;
        b=lYzCSoQMcqvJ6myfaxuhILu7NMmHb563kKHRdGsqsWaVwIJpGGPnR+17TNIBmWM5N0
         2ZEy0+oyZYlYzi0S4KCF2BKnluIzUL/uYRhSIY+7Jw94zYiMWfKMcWDHNV/ili9VO+aT
         cGS+AV9wPGW8Zylfh/Cl3ByB7fJr2DBWXF6Nk4qE9Fz2Cek56xA1boOXHlbAnpb3F0xH
         Gbiy8nCQmuKSPv4bBc49fycOSeVQeuV6/YHdMkk6zEEPtztWBvtLocl0S0OmAGEgFGc/
         JZUKFLQ4x+nWXe8OWYSsBorRgtn5MPl9jGTYeqTG0KkbRa3ZOiwQD3aJj48K8frzCmG3
         UAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749050070; x=1749654870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utxbGnGIbzF8mH+ke5le74ATfkvfWNo9bI2IYs+ukk0=;
        b=tWlgYuLUuZLAbkZOazLzMzzHMFswopIdw6hb88wKwtOo+KYN921HHp1fSbPbPE1kOw
         EqshAfPLguLELSXDt6ORJi5yKku8eUHoB2Xl7YjIbDv1XEHmYLkNcjPxAGrItJeyLWkw
         SfnAB+dIOImAmKQsl/x2Kk95j1ts4ZXrMxPdS3TaaxqGivQmg2ILBWg79n1W4X/cfmX1
         pfNBzw4KW3WA339zZmFy7R/5T07YiJxXemrYeDaXDUByzL3MIHWZ6AmjdWnqOuZpBi3r
         dlnS7+UzGr6i3dPRASMNrFz64i115FBZu5ntZu28NoelN6YCWYCcV7haheR3TGSOqZSu
         TTDg==
X-Forwarded-Encrypted: i=1; AJvYcCXv3HrNoQiMyS2oKtrjNE4s/laD9gVNy0BxAl6PrJcJaycRclCkpHbGTFzbjJnVX13GHUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLY2GyfetLlF0QzT8QTHw16W+jnDWEOsDMe5zv5Nr/Wy0mRGMH
	peDFyM/eiG+PXwvyZKmLBwVCYCgJjau6TMP1jDWFQ2rHb01LFKmiUj7rrCu94YcrWIVKx75cFzh
	l0PY4mEhLXzCfqqljF4uzz9u3FjYr6ntfYIS5RkCt
X-Gm-Gg: ASbGncvisPr2tHjEndZrUyTO446kzUYgPGqKQf2LaMmcSf2tF43LmTg2xyGtgpTmik6
	DrgkV4uLuOXWVO4PudKuIMqXgsgPRMLVs+Sc5cG3tjgDNxQHpm6pZrgPBTouIjKxhKb9ArvOjpP
	qYjspqX35Kwgh4HHEYmdr8/QFH3vgZufGDdHV4SPDXHZ0B3B9/EBzcW/ZnV+/C1HDsat7OEnuQ
X-Google-Smtp-Source: AGHT+IG7WUENSnzjQt1432tk0/IC2xUBgjIJ6p1wfQtTmthhSrBkIabqQdFzCkGqvNujLDVYjt6N/VZKebcP/XvFGPs=
X-Received: by 2002:a05:622a:5513:b0:477:9a4:d7ea with SMTP id
 d75a77b69052e-4a5a60d620fmr3781231cf.13.1749050069321; Wed, 04 Jun 2025
 08:14:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604025246.61616-1-byungchul@sk.com> <20250604025246.61616-3-byungchul@sk.com>
In-Reply-To: <20250604025246.61616-3-byungchul@sk.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 4 Jun 2025 08:14:18 -0700
X-Gm-Features: AX0GCFvbLYsMxCrveTLh5QRMe579FQstUyFi0HWrz3vr2pOTHdyUzOaCmMQ3Mp4
Message-ID: <CAJuCfpFCtGFRip72x8HadTfuv_2d+e19qZ2xJowaLa6V9JOGHA@mail.gmail.com>
Subject: Re: [RFC v4 02/18] netmem: introduce netmem alloc APIs to wrap page
 alloc APIs
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	almasrymina@google.com, ilias.apalodimas@linaro.org, harry.yoo@oracle.com, 
	hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net, 
	john.fastabend@gmail.com, andrew+netdev@lunn.ch, asml.silence@gmail.com, 
	toke@redhat.com, tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, 
	saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 7:53=E2=80=AFPM Byungchul Park <byungchul@sk.com> wr=
ote:
>
> To eliminate the use of struct page in page pool, the page pool code
> should use netmem descriptor and APIs instead.
>
> As part of the work, introduce netmem alloc APIs allowing the code to
> use them rather than the existing APIs for struct page.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  net/core/netmem_priv.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
> index cd95394399b4..32e390908bb2 100644
> --- a/net/core/netmem_priv.h
> +++ b/net/core/netmem_priv.h
> @@ -59,4 +59,18 @@ static inline void netmem_set_dma_index(netmem_ref net=
mem,
>         magic =3D netmem_get_pp_magic(netmem) | (id << PP_DMA_INDEX_SHIFT=
);
>         __netmem_clear_lsb(netmem)->pp_magic =3D magic;
>  }
> +
> +static inline netmem_ref alloc_netmems_node(int nid, gfp_t gfp_mask,
> +                                           unsigned int order)
> +{
> +       return page_to_netmem(alloc_pages_node(nid, gfp_mask, order));
> +}
> +
> +static inline unsigned long alloc_netmems_bulk_node(gfp_t gfp, int nid,
> +                                                   unsigned long nr_netm=
ems,
> +                                                   netmem_ref *netmem_ar=
ray)
> +{
> +       return alloc_pages_bulk_node(gfp, nid, nr_netmems,
> +                       (struct page **)netmem_array);
> +}

Note: if you want these allocations to be reported in a separate line
inside /proc/allocinfo you need to use alloc_hooks() like this:

static inline unsigned long alloc_netmems_bulk_node_noprof(gfp_t gfp, int n=
id,
                                                   unsigned long nr_netmems=
,
                                                   netmem_ref *netmem_array=
)
{
       return alloc_pages_bulk_node_noprof((gfp, nid, nr_netmems,
                       (struct page **)netmem_array);
}

#define alloc_netmems_bulk_node(...) \
        alloc_hooks(alloc_netmems_bulk_node_noprof(__VA_ARGS__))



>  #endif
> --
> 2.17.1
>

