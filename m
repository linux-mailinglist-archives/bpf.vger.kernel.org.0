Return-Path: <bpf+bounces-58819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE91AC1CE1
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 08:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B353B3CB2
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 06:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593A422618F;
	Fri, 23 May 2025 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWJDTqQ6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA5F10A3E;
	Fri, 23 May 2025 06:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747981243; cv=none; b=pRiACJsKl7hE7ji+sfPjvwQ+2oe1aHpbJYL6aCqxWhGHIUpDxI7K5kmtRLRgKXOFgVM85Kkjv/OLaa+DJrPUBb9irm3jQOShnwMis/zLQCv+PAbtRuWToqHYMjeukU6ARCNMyPlHCo55cBIXIwq6LCW7EMk2T+xnEma4yrJ7U+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747981243; c=relaxed/simple;
	bh=mJlXIqaDSLJv2xahICj+/scxRlbgF0AGsJSa8Df/Onc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qz/PExDpk9Rtd/qd1eIhkqPsTyR88bw3RqGeaDWoBGtQXWkbopLhp7S34FUmoft5f0Zel3xFBvsihSP5KyykyOXK+5qjJO5gBng96WZA7/yTY2A5A9DE8AwSqk7palQb4pxjK2pS492IF5k8l6zBZXNjSjItCwN6ktye/GJ7/ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWJDTqQ6; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6020ff8d54bso6482978a12.2;
        Thu, 22 May 2025 23:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747981239; x=1748586039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJKle3xhIDDR9OqTTDo3kadxyXGdGsylyJI+gVZs2nc=;
        b=JWJDTqQ6CJqDkBb1YM6VTrjTdFGWGFaJxIcbPTlk1E9xtpqDhdeDypy4sfp9hk4K8f
         0p2mm0F17vLEWiHHuQs0/i48JZvorzAeaPFbo3EkepazNc1123ptNgx7/qYVJeipSzQC
         yWmdnPU5+0PbpBy062Cs8o2mpwfMP7mj2w8Gi0kbSLjtBNULoT20xdd7/q9+eptC6qho
         7txwmJA2XxF5jVKyAUzPgtqbf7xD7doRM6b8fYPO+MB8X6QGaQ62uwfmO7xSPAOry1Y9
         bVlfCQQ5GuA04AF0fA+sLEB7N53mFcqzlZcUd1VP04rF5QwWUC5L2H1KT5spc6Zj4ela
         eEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747981239; x=1748586039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJKle3xhIDDR9OqTTDo3kadxyXGdGsylyJI+gVZs2nc=;
        b=JyDYkxRs3iIHYD9l2Lipi4PbbBRlEuLiWquXmEHJ5JuhEWDHIzVPiSY92ZfxpJ/PVh
         PlHdkMzRHvDxp7TSa6SpkcP1U3DoxickZFwOvCDgsFKTiuuptNlT8IUJFxvvBCQEXXXP
         E+f5/SgMpq3UdAJHOBXs0NG2BDbA6D8HPN2s0v4iEv2O8wI1OojZhR5gwWGrR9zuHuHt
         SHYa95xlfBJI9ztH8EijXOt+FxAymm1YBVJRk2u+I3Ly5QYnD3T7KyZ+gRouQNmg1OUp
         uJNuWbahK2N2TrDFW6V5t1bO7jtgCVWqsVz4FIGdk2k6ul664j7+ylSRpBWj/acTxjW8
         YfXw==
X-Forwarded-Encrypted: i=1; AJvYcCUCA6dTQ1bs3wPKKhqnzPBYZ+ypC/I0QN6mkWf5E1FxlC/8AgGyARBoaOCYHdkixDsJo4rvn6GpZ4lo2g==@vger.kernel.org, AJvYcCVOicHkFjD82nyEjz4lvwxYkMoHIqc/7wlkfaZvzNd6MIO+zSGmNCToE8raRdtutWXqlos6QMw88B58Sn7q@vger.kernel.org, AJvYcCVQ+Y0VZ6tEpeQH4kHy9FegZAgMI1lxHKJBmPMRjnZ5uh3s9XTPlNg7B3BFVftkD4AIEX1w/Web@vger.kernel.org, AJvYcCWXw/5u+nFbsSlc3TDbVnumSDzZJ9a2Cj+KZj5f/hKzKVQv+Td64toOdLxmr8AbdMLzVws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze22y6DsfATB8JTX72hKAV2crjRegMJgIb8nZEC+/zHkI6zoP9
	4GTh/sMO5esH0OsroDu6Dbujwb4ia+1zYfh1r50NORGBQEz4lsF7BzkAB+EvlSsfCR4IIU9PY1+
	xABz+QIVzFOnrROG8RNx5CTkJ+dcJ8O0=
X-Gm-Gg: ASbGncvzD97iY1iMVKdbGd+EuWS4wO/4lUg+Wr/sYqIqYM6mYvropIBIKgL10AY560W
	R6VMp1jz5Xz5vAI32hLzhs8O0XTM24zepKFnZLx4qMQs2j5IEqzFK6N4WwgKCkzJT7UlyfUIEHT
	eMFGWkH8DQ6gF+kBg6a4LLjD4IyCwbNGeOhgpqw6hoXRdj2Q==
X-Google-Smtp-Source: AGHT+IGbTR82/LzienQDKEDXoJF5IcGdBgl4Man5RPmJSQnxzH+IiU2ooaMYWOxIUaA7swrBIT0sR6ZoDWL2aYGtGtI=
X-Received: by 2002:a05:6402:3494:b0:602:225e:1d46 with SMTP id
 4fb4d7f45d1cf-6029163eb6fmr1466817a12.3.1747981239301; Thu, 22 May 2025
 23:20:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523032609.16334-1-byungchul@sk.com>
In-Reply-To: <20250523032609.16334-1-byungchul@sk.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 23 May 2025 15:20:27 +0900
X-Gm-Features: AX0GCFubwjG0J56ovWaE10v3Q9RxO1SAGGmwA1wkCCPwSFKvPmaSkQrB3cPFVV4
Message-ID: <CAMArcTWx+8GFzk4=A2-DCUZkMtyYRaDZSqf+HvOf2KyC80BqsA@mail.gmail.com>
Subject: Re: [PATCH 00/18] Split netmem from struct page
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	almasrymina@google.com, ilias.apalodimas@linaro.org, harry.yoo@oracle.com, 
	hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net, 
	john.fastabend@gmail.com, andrew+netdev@lunn.ch, asml.silence@gmail.com, 
	toke@redhat.com, tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, 
	saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org, 
	vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 12:36=E2=80=AFPM Byungchul Park <byungchul@sk.com> =
wrote:
>

Hi Byungchul,
Thanks a lot for this work!

> The MM subsystem is trying to reduce struct page to a single pointer.
> The first step towards that is splitting struct page by its individual
> users, as has already been done with folio and slab.  This patchset does
> that for netmem which is used for page pools.
>
> Matthew Wilcox tried and stopped the same work, you can see in:
>
>    https://lore.kernel.org/linux-mm/20230111042214.907030-1-willy@infrade=
ad.org/
>
> Mina Almasry already has done a lot fo prerequisite works by luck, he
> said :).  I stacked my patches on the top of his work e.i. netmem.
>
> I focused on removing the page pool members in struct page this time,
> not moving the allocation code of page pool from net to mm.  It can be
> done later if needed.
>
> My rfc version of this work is:
>
>    https://lore.kernel.org/all/20250509115126.63190-1-byungchul@sk.com/
>
> There are still a lot of works to do, to remove the dependency on struct
> page in the network subsystem.  I will continue to work on this after
> this base patchset is merged.

There is a compile failure.

In file included from drivers/net/ethernet/intel/libeth/rx.c:4:
./include/net/libeth/rx.h: In function =E2=80=98libeth_rx_sync_for_cpu=E2=
=80=99:
./include/net/libeth/rx.h:140:40: error: =E2=80=98struct page=E2=80=99 has =
no member named =E2=80=98pp=E2=80=99
  140 |         page_pool_dma_sync_for_cpu(page->pp, page, fqe->offset, len=
);
      |                                        ^~
drivers/net/ethernet/intel/libeth/rx.c: In function =E2=80=98libeth_rx_recy=
cle_slow=E2=80=99:
drivers/net/ethernet/intel/libeth/rx.c:210:38: error: =E2=80=98struct page=
=E2=80=99
has no member named =E2=80=98pp=E2=80=99
  210 |         page_pool_recycle_direct(page->pp, page);
      |                                      ^~
make[7]: *** [scripts/Makefile.build:203:
drivers/net/ethernet/intel/libeth/rx.o] Error 1
make[6]: *** [scripts/Makefile.build:461:
drivers/net/ethernet/intel/libeth] Error 2
make[5]: *** [scripts/Makefile.build:461: drivers/net/ethernet/intel] Error=
 2
make[5]: *** Waiting for unfinished jobs....

There are page->pp usecases in drivers/net
./drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c:1574:
 } else if (page->pp) {
./drivers/net/ethernet/freescale/fec_main.c:1046:
                 page_pool_put_page(page->pp, page, 0, false);
./drivers/net/ethernet/freescale/fec_main.c:1584:
 page_pool_put_page(page->pp, page, 0, true);
./drivers/net/ethernet/freescale/fec_main.c:3351:
         page_pool_put_page(page->pp, page, 0, false);
./drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c:370:
page_pool_recycle_direct(page->pp, page);
./drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c:395:
page_pool_recycle_direct(page->pp, page);
./drivers/net/ethernet/ti/icssg/icssg_common.c:111:
page_pool_recycle_direct(page->pp, swdata->data.page);
./drivers/net/ethernet/intel/idpf/idpf_txrx.c:389:
page_pool_put_full_page(rx_buf->page->pp, rx_buf->page, false);
./drivers/net/ethernet/intel/idpf/idpf_txrx.c:3254:     u32 hr =3D
rx_buf->page->pp->p.offset;
./drivers/net/ethernet/intel/idpf/idpf_txrx.c:3286:     dst =3D
page_address(hdr->page) + hdr->offset + hdr->page->pp->p.offset;
./drivers/net/ethernet/intel/idpf/idpf_txrx.c:3287:     src =3D
page_address(buf->page) + buf->offset + buf->page->pp->p.offset;
./drivers/net/ethernet/intel/idpf/idpf_txrx.c:3305:     u32 hr =3D
buf->page->pp->p.offset;
./drivers/net/ethernet/intel/libeth/rx.c:210:
page_pool_recycle_direct(page->pp, page);
./drivers/net/ethernet/intel/iavf/iavf_txrx.c:1200:     u32 hr =3D
rx_buffer->page->pp->p.offset;
./drivers/net/ethernet/intel/iavf/iavf_txrx.c:1217:     u32 hr =3D
rx_buffer->page->pp->p.offset;
./drivers/net/wireless/mediatek/mt76/mt76.h:1800:
page_pool_put_full_page(page->pp, page, allow_direct);
./include/net/libeth/rx.h:140:  page_pool_dma_sync_for_cpu(page->pp,
page, fqe->offset, len);

Thanks a lot!
Taehee Yoo

>
> ---
>
> Changes from rfc:
>         1. Rebase on net-next's main branch
>            https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-nex=
t.git/
>         2. Fix a build error reported by kernel test robot
>            https://lore.kernel.org/all/202505100932.uzAMBW1y-lkp@intel.co=
m/
>         3. Add given 'Reviewed-by's, thanks to Mina and Ilias
>         4. Do static_assert() on the size of struct netmem_desc instead
>            of placing place-holder in struct page, feedbacked by Matthew
>         5. Do struct_group_tagged(netmem_desc) on struct net_iov instead
>            of wholly renaming it to strcut netmem_desc, feedbacked by
>            Mina and Pavel
>
> Byungchul Park (18):
>   netmem: introduce struct netmem_desc struct_group_tagged()'ed on
>     struct net_iov
>   netmem: introduce netmem alloc APIs to wrap page alloc APIs
>   page_pool: use netmem alloc/put APIs in __page_pool_alloc_page_order()
>   page_pool: rename __page_pool_alloc_page_order() to
>     __page_pool_alloc_large_netmem()
>   page_pool: use netmem alloc/put APIs in __page_pool_alloc_pages_slow()
>   page_pool: rename page_pool_return_page() to page_pool_return_netmem()
>   page_pool: use netmem put API in page_pool_return_netmem()
>   page_pool: rename __page_pool_release_page_dma() to
>     __page_pool_release_netmem_dma()
>   page_pool: rename __page_pool_put_page() to __page_pool_put_netmem()
>   page_pool: rename __page_pool_alloc_pages_slow() to
>     __page_pool_alloc_netmems_slow()
>   mlx4: use netmem descriptor and APIs for page pool
>   page_pool: use netmem APIs to access page->pp_magic in
>     page_pool_page_is_pp()
>   mlx5: use netmem descriptor and APIs for page pool
>   netmem: use _Generic to cover const casting for page_to_netmem()
>   netmem: remove __netmem_get_pp()
>   page_pool: make page_pool_get_dma_addr() just wrap
>     page_pool_get_dma_addr_netmem()
>   netdevsim: use netmem descriptor and APIs for page pool
>   mm, netmem: remove the page pool members in struct page
>
>  drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  46 ++++----
>  drivers/net/ethernet/mellanox/mlx4/en_tx.c    |   8 +-
>  drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |   4 +-
>  drivers/net/ethernet/mellanox/mlx5/core/en.h  |   4 +-
>  .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  18 ++--
>  .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |   2 +-
>  .../net/ethernet/mellanox/mlx5/core/en_main.c |  15 ++-
>  .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  66 ++++++------
>  drivers/net/netdevsim/netdev.c                |  18 ++--
>  drivers/net/netdevsim/netdevsim.h             |   2 +-
>  include/linux/mm.h                            |   5 +-
>  include/linux/mm_types.h                      |  11 --
>  include/linux/skbuff.h                        |  14 +++
>  include/net/netmem.h                          | 101 ++++++++++--------
>  include/net/page_pool/helpers.h               |  11 +-
>  net/core/page_pool.c                          |  97 +++++++++--------
>  16 files changed, 221 insertions(+), 201 deletions(-)
>
>
> base-commit: f44092606a3f153bb7e6b277006b1f4a5b914cfc
> --
> 2.17.1
>
>

