Return-Path: <bpf+bounces-58842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0162BAC2809
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 19:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D94B178CC5
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 17:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EF7297A4C;
	Fri, 23 May 2025 17:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ghHD7nnw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC7A211A11
	for <bpf@vger.kernel.org>; Fri, 23 May 2025 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748019672; cv=none; b=XITb3Vafgwj6KTvHvdZnK2CaFzjCdwBQeRiCA1r7wvKkaSczSdvT/5HFBDr8or7AIra1dPl+03j+ML0Hbu8kjHHmVeveJGLhLXf9+t9iJWujnmZAH6VDTnmXRyDKgTzp3chsmfBttn3fFVgnFsMO9MJKfY9Q37SNBeUZnlKu5L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748019672; c=relaxed/simple;
	bh=hExa2Cwm4bAPttUEZjJfYoGFUNfZ4ZleOpu3VTcmpaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ua4ioylXlVfz3sR7fc9kx07kptkO4KTCxuJrupcb/iOMsHyj6LJJunqt1qJnSC2lowp3pzNe0jOhl0+01OCJXDi8aydkKiIf0mdXhvdjcw4NC3SUIC0Uf51xoBYzCgla/DD8GG9j+90PrPyTOT0BjT/tXy6B6YfQbMJATHQS0HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ghHD7nnw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-231f6c0b692so8275ad.0
        for <bpf@vger.kernel.org>; Fri, 23 May 2025 10:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748019669; x=1748624469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOSRKDWId4W8kN+rUt+nVQlh5cnha/mrBYJj+eK+Jf0=;
        b=ghHD7nnwMk4MPKcpkQnGayp4Nv24ozaA/sQig6FtW9RTCw4U/o7Qp2YHsZUmRkMLZm
         h4Ml4frDUIz75uSXS0vMhdX17TCuSWCXZ1SUXGWWYfRBJc43nSaG+0UsHLzaDSG7uZI3
         +eeSHHd7As90Sfs9K2sc3OpzH/oX/IrbIbqNnzUfZ6LolqM22MrmDIty4ytW3ovPzRZK
         8xSbTjG/mW9nlfa0z/pLNOXLWMeeRaGo+trZUA3fQdHwRk7lcHta2rdzWCjdwnEzd6KR
         IWsuVgn/9amsmTjLgCKy7iX3TijPiCc4TaJ4ki2NQyMtlzrnA7Lb7fb0f6raUFfwUnxV
         jD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748019669; x=1748624469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOSRKDWId4W8kN+rUt+nVQlh5cnha/mrBYJj+eK+Jf0=;
        b=DK86Oth5MiEA4V+1fwrqYaQI6Gx9tMhkEFefN6NqWqdR1ehIDPBP13eVLzhoA+nkwj
         ZB6hZYjO+vscuDz0Oe4nZXddLDYjcAetC5LIXT7deojrIuLrIV7T3E70CU1yT9Sj0opU
         QMrLX8C5udhVhIYW3VmZE8DlGqkeQW4STgWkPIPZB9IfU8lYN4ztpXd77OXbwb9H8ZoN
         nxqmbTE+ibd0QF4RTiRHHTazny1qphcXtc4KTgQPSaQQ52S+nRMf3qb4itSs0aTYjD7t
         /ObuZWKc4+imPZikN5FSi7A2FSMJmetIaNK8b8dmHRXDra7kMR7vF6dtJlfZCshUsJIZ
         UqcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJQqyh1Nt49CYG+psZ8Z94FfxH5rmhgCbRYrFao31n2BVbVP2oZd1OPm3J+ZF0dROYusM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKuCKBRNu6cyqUb8aoe3DS99NI9PjNmLvJzahMJ4zKYGC7eLa3
	5hGJqlI8ZeFc2HoYmq1EtnV2DXIT3CNVMUY5tHvS0+SXqqpJD7EqWuDT8bG2L21idG6CGyfenBv
	cC590s4wiATMBxUKkCREyJ6ELF2VdG6Cashm2eKOf
X-Gm-Gg: ASbGncvB8VD+n4yCihgbO3so1G0YMF4VdoE64kxW2XnS0mu6w1JGH1czWZx+yLB7d3d
	ShAaeJXs2NcyNIJ7Y1c8U+UZPK30Zeh6Ds9PPloImUAQdxmFsU2eQpa+ZXVpaWhspgd6xDDuTTa
	0kjdym2iVoLkGM/Ehl0RdZbp20YCQoyvw1gGobKNyUXVbaFhu8WQSrnDMVyJtjQxFnpyZlcQSk3
	g==
X-Google-Smtp-Source: AGHT+IGJuHYQfZLr7hfQil+IpUEJXAuKmCwI79/rmEAXhTB8FY4jWtiRvq1iHUteieQZgEsK3rVaeZy0sUBH+cb+uvM=
X-Received: by 2002:a17:903:22d2:b0:231:e069:6195 with SMTP id
 d9443c01a7336-233f357c50cmr2674495ad.23.1748019669119; Fri, 23 May 2025
 10:01:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523032609.16334-1-byungchul@sk.com> <20250523032609.16334-2-byungchul@sk.com>
In-Reply-To: <20250523032609.16334-2-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 23 May 2025 10:00:55 -0700
X-Gm-Features: AX0GCFsW6gNVDYJM6WPqUUcEweldiOyGkOySslyL-ATgJPZxy65Z4gtkC0ipm7U
Message-ID: <CAHS8izPYrMMcqKiF1DmNqWW_=92joVrPE55rQTqGWaJ2=itHaw@mail.gmail.com>
Subject: Re: [PATCH 01/18] netmem: introduce struct netmem_desc
 struct_group_tagged()'ed on struct net_iov
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

On Thu, May 22, 2025 at 8:26=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> To simplify struct page, the page pool members of struct page should be
> moved to other, allowing these members to be removed from struct page.
>
> Introduce a network memory descriptor to store the members, struct
> netmem_desc, reusing struct net_iov that already mirrored struct page.
>
> While at it, relocate _pp_mapping_pad to group struct net_iov's fields.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  include/linux/mm_types.h |  2 +-
>  include/net/netmem.h     | 43 +++++++++++++++++++++++++++++++++-------
>  2 files changed, 37 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 56d07edd01f9..873e820e1521 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -120,13 +120,13 @@ struct page {
>                         unsigned long private;
>                 };
>                 struct {        /* page_pool used by netstack */
> +                       unsigned long _pp_mapping_pad;
>                         /**
>                          * @pp_magic: magic value to avoid recycling non
>                          * page_pool allocated pages.
>                          */
>                         unsigned long pp_magic;
>                         struct page_pool *pp;
> -                       unsigned long _pp_mapping_pad;

Like Toke says, moving this to the beginning of this struct is not
allowed. The first 3 bits of pp_magic are overlaid with page->lru so
the pp makes sure not to use them. _pp_mapping_pad is overlaid with
page->mapping, so the pp makes sure not to use it. AFAICT, this moving
of _pp_mapping_pad is not necessary for this patch. I think just drop
it.

>                         unsigned long dma_addr;
>                         atomic_long_t pp_ref_count;
>                 };
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 386164fb9c18..08e9d76cdf14 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -31,12 +31,41 @@ enum net_iov_type {
>  };
>
>  struct net_iov {
> -       enum net_iov_type type;
> -       unsigned long pp_magic;
> -       struct page_pool *pp;
> -       struct net_iov_area *owner;
> -       unsigned long dma_addr;
> -       atomic_long_t pp_ref_count;
> +       /*
> +        * XXX: Now that struct netmem_desc overlays on struct page,
> +        * struct_group_tagged() should cover all of them.  However,
> +        * a separate struct netmem_desc should be declared and embedded,
> +        * once struct netmem_desc is no longer overlayed but it has its
> +        * own instance from slab.  The final form should be:
> +        *
> +        *    struct netmem_desc {
> +        *         unsigned long pp_magic;
> +        *         struct page_pool *pp;
> +        *         unsigned long dma_addr;
> +        *         atomic_long_t pp_ref_count;
> +        *    };
> +        *
> +        *    struct net_iov {
> +        *         enum net_iov_type type;
> +        *         struct net_iov_area *owner;
> +        *         struct netmem_desc;
> +        *    };
> +        */

I'm unclear on why moving to this format is a TODO for the future. Why
isn't this state in the comment the state in the code? I think I gave
the same code snippet on the RFC, but here again:

struct netmem_desc {
                        /**
                         * @pp_magic: magic value to avoid recycling non
                         * page_pool allocated pages.
                         */
                        unsigned long pp_magic;
                        struct page_pool *pp;
                       unsigned long _pp_mapping_pad;
                        unsigned long dma_addr;
                        atomic_long_t pp_ref_count;
};

(Roughly):

struct page {
   ...
  struct {        /* page_pool used by netstack */
     struct netmem_desc;
  };
  ...
};

struct net_iov {
    enum net_iov_type type;
    struct netmem_desc;
    struct net_iov_area *owner;
}

AFAICT, this should work..?

--=20
Thanks,
Mina

