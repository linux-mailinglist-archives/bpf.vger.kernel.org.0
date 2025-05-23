Return-Path: <bpf+bounces-58799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201D4AC1A6A
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 05:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A4DA22B52
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 03:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48599223709;
	Fri, 23 May 2025 03:26:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53082DCBE7;
	Fri, 23 May 2025 03:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747970786; cv=none; b=Uqx9VjEXCriEsmAe0SZfMU6eISGO2IO1ufCsPcajGNytWTALKSno8I/bkEjqs2bd+nHrsoMzhw642nUMOHSBFJLFHTw0vzTLUYWFect28IE1OIlZwYXqDXimWXeKTu8uXR7E7KnthH7ZpVkF8HLuADjr31vhfXg+IDRFj+huEBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747970786; c=relaxed/simple;
	bh=8EVazZ2kGcJ7wRFdcW84b44D5G++w+ZiAUGmm2O42Rk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=AfIxe+mEwPKPUQVuxqez7Lm1/8wbbFHFq9BFG9JupBG+O9qCiJI/VXotpgmYHRMzf2cSDeenE/EzqSO9XZY1zNgYh733sMzKAdfn7w8cJt1rgy9icL1eo9jkziTEev6vgrccgLr2AovwJIaYccMbeQYqou8hzCcXXSO7yv4iDEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-6c-682feadb6dc4
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	kuba@kernel.org,
	almasrymina@google.com,
	ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com,
	hawk@kernel.org,
	akpm@linux-foundation.org,
	davem@davemloft.net,
	john.fastabend@gmail.com,
	andrew+netdev@lunn.ch,
	asml.silence@gmail.com,
	toke@redhat.com,
	tariqt@nvidia.com,
	edumazet@google.com,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	vishal.moola@gmail.com
Subject: [PATCH 00/18] Split netmem from struct page
Date: Fri, 23 May 2025 12:25:51 +0900
Message-Id: <20250523032609.16334-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAAzXRXUhTcRgGcP87Z2dzOThMqZN9SAOphFyKxVtI2VWniz5Au0kwD+7gDm3T
	pq5ZRmYj0dRCjVIXrTLzYzBd4qb5OecXFppizrTNFL0QM9QcTotyiXc/eJ7nvXmFmMSEBws5
	dTqrUTNKKSHCRT8CXh+bXJApjk98OgUGs4mAunUdvJu28cFQ24Tgl3dSAKuOPgLevPJgYBjS
	47Bm3sBgrndGAO6qeRxac60YzDzuJ6BQv4lBjq2aB8NNRXwo3XiLgTV7WgCjLQYCXKa/fJi3
	F+IwUF6Dg7soBnqNu8EzuIjAYbbywFPwgoCSESMBs3o3gpHuGRwq7hchMLc7+bC5biBiDtGN
	NRM8urn8m4A2WjLo99VhdL5zBKMttXkEbVkpFtBTX1oJuv/5Jk4321Z5dOGDJYJenvuK0z/b
	xwja3DiG0x+NDgG9ajl4hbwmipazSk7LamRnEkUK72QXntoWolse4rLRMpWP/IUUGUXlNYzg
	Oy4bHeT5TJCHKafTi/kcREZQqzN9Wx2RECOX+NScYfN/KXBrsObRI59xMpRyN+r5PovJE1T3
	kpW3fTSEqqvvxHxjinQJqPz+DrQd7KW6qp34E7TLiPxqkYRTa1UMp4wKV2SqOV14UorKgrZ+
	WHX3d7wNrQzH2hEpRNIAsU0kU0j4jDYtU2VHlBCTBol75sMVErGcybzNalKuazKUbJod7RPi
	0j3iSM8tuYRMZtLZGyybymp2Up7QPzgblVZouwqrvekDCczJ8dieP+wzTjWWmSi/eTV53LUQ
	FxnXUT57Pil6I++AIEr2WZdSbL/3ofIlV3+R8R7VPLU/tF4InS419S9kFZUVV3kcCY++G4cq
	91MNXFbBkbN+yS2TOZ6SzqnTlyjp5XrXHZLytC0q4zckuQVtdSGB5/ySpHiagokIwzRpzD+o
	Qvl5vwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAwGiAl39CAMSjwQaCGludGVybmFsIgYKBApOO4Mt2+ovaDDKpCc4nK+sBjir
	+Hg4p+C4BTicqrYBOPT52wc488THBjijofYDOJzPhAQ49a/6AzjlxuIHON+m5gQ4vIe3Azji
	j8gGOI2E+wM4grioAjjDnckFONC2jgU4lPqlAzi3gOAHONO6nAY43qz/BTjmwo0EOMmaqQQ4
	345AOMagFjj2y+wBOMSvtwI49oydBjiT0qAGOOOE3wE40sPiBDibgY4BOK++2AU4+/icBkAi
	SLSp2QJIuZrdB0igsnVIs6gqSIrY0gNIsqqJBkiy8pIHSNzWvAZIyJj7BEi5uPMCSI2D7gZI
	8eXaBEjvvtUGSKPo8AJIr7TVBEjMoMQHUBFaCjxkZWxpdmVyLz5gCmj528EEcL0fePHPaYAB
	8RiKAQkIGBA0GJnTywKKAQkIBhAnGNjY+QOKAQkIFBAxGPPixwSKAQoIAxDuBRjlnPsCigEJ
	CBMQNBj19oQBigEJCAQQJRjftIQFigEJCA0QNRjD7rcCigEJCBgQHxirsMADkAEIoAEAqgEU
	aW52bWFpbDUuc2toeW5peC5jb22yAQYKBKZ9/JG4AfTTR8IBEAgBIgwNKG0vaBIFYXZzeW3C
	ARgIAyIUDcXmLmgSDWRheXplcm9fcnVsZXPCARsIBCIXDUpXZWASEGdhdGVrZWVwZXJfcnVs
	ZXPCAQIICRqAAXhzCpXZsJUENZo2iUQIK9C3VerNw271f56ZwvBIm9xQ9/Wzojv55zYahsFI
	hp8eaPKpqK1POu5au6TwcFJq5MDco5Lh5btTAVLeb1IemYh5+5RL8K+Szqm4vL0Zk+fkEmKK
	qmdIjnEUtnYhI3fZVCd5ZioI04z96wptHoShF9FVIgRzaGExKgNyc2E0Nn/SogIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The MM subsystem is trying to reduce struct page to a single pointer.
The first step towards that is splitting struct page by its individual
users, as has already been done with folio and slab.  This patchset does
that for netmem which is used for page pools.

Matthew Wilcox tried and stopped the same work, you can see in:

   https://lore.kernel.org/linux-mm/20230111042214.907030-1-willy@infradead.org/

Mina Almasry already has done a lot fo prerequisite works by luck, he
said :).  I stacked my patches on the top of his work e.i. netmem.

I focused on removing the page pool members in struct page this time,
not moving the allocation code of page pool from net to mm.  It can be
done later if needed.

My rfc version of this work is:

   https://lore.kernel.org/all/20250509115126.63190-1-byungchul@sk.com/

There are still a lot of works to do, to remove the dependency on struct
page in the network subsystem.  I will continue to work on this after
this base patchset is merged.

---

Changes from rfc:
	1. Rebase on net-next's main branch
	   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/
	2. Fix a build error reported by kernel test robot
	   https://lore.kernel.org/all/202505100932.uzAMBW1y-lkp@intel.com/
	3. Add given 'Reviewed-by's, thanks to Mina and Ilias
	4. Do static_assert() on the size of struct netmem_desc instead
	   of placing place-holder in struct page, feedbacked by Matthew
	5. Do struct_group_tagged(netmem_desc) on struct net_iov instead
	   of wholly renaming it to strcut netmem_desc, feedbacked by
	   Mina and Pavel

Byungchul Park (18):
  netmem: introduce struct netmem_desc struct_group_tagged()'ed on
    struct net_iov
  netmem: introduce netmem alloc APIs to wrap page alloc APIs
  page_pool: use netmem alloc/put APIs in __page_pool_alloc_page_order()
  page_pool: rename __page_pool_alloc_page_order() to
    __page_pool_alloc_large_netmem()
  page_pool: use netmem alloc/put APIs in __page_pool_alloc_pages_slow()
  page_pool: rename page_pool_return_page() to page_pool_return_netmem()
  page_pool: use netmem put API in page_pool_return_netmem()
  page_pool: rename __page_pool_release_page_dma() to
    __page_pool_release_netmem_dma()
  page_pool: rename __page_pool_put_page() to __page_pool_put_netmem()
  page_pool: rename __page_pool_alloc_pages_slow() to
    __page_pool_alloc_netmems_slow()
  mlx4: use netmem descriptor and APIs for page pool
  page_pool: use netmem APIs to access page->pp_magic in
    page_pool_page_is_pp()
  mlx5: use netmem descriptor and APIs for page pool
  netmem: use _Generic to cover const casting for page_to_netmem()
  netmem: remove __netmem_get_pp()
  page_pool: make page_pool_get_dma_addr() just wrap
    page_pool_get_dma_addr_netmem()
  netdevsim: use netmem descriptor and APIs for page pool
  mm, netmem: remove the page pool members in struct page

 drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  46 ++++----
 drivers/net/ethernet/mellanox/mlx4/en_tx.c    |   8 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  18 ++--
 .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  15 ++-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  66 ++++++------
 drivers/net/netdevsim/netdev.c                |  18 ++--
 drivers/net/netdevsim/netdevsim.h             |   2 +-
 include/linux/mm.h                            |   5 +-
 include/linux/mm_types.h                      |  11 --
 include/linux/skbuff.h                        |  14 +++
 include/net/netmem.h                          | 101 ++++++++++--------
 include/net/page_pool/helpers.h               |  11 +-
 net/core/page_pool.c                          |  97 +++++++++--------
 16 files changed, 221 insertions(+), 201 deletions(-)


base-commit: f44092606a3f153bb7e6b277006b1f4a5b914cfc
-- 
2.17.1


