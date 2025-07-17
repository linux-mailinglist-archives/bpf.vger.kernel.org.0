Return-Path: <bpf+bounces-63566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7F6B085F1
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 09:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1C83AC503
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 07:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730E3221FC7;
	Thu, 17 Jul 2025 07:01:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572A11DDC2A;
	Thu, 17 Jul 2025 07:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735673; cv=none; b=u+JYWMUY05zN8ZsvGjjkcjYA3FcJhZaIe/KOaNjNAw1kX1IsyxO9JgFsPjc/hRSMl6wwEcBHBKrMul4us2uBsin7Hs35oStg3C5I+t/T/xr+BpwueDLlYBdLrTgwGLjuHZPkT+pxY108yDkTh3HjDrft2tLIopBuYE9iqveWqyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735673; c=relaxed/simple;
	bh=BVyviliQIyStLmHDy3EdTYcZUrGXmYB6sHwHlAHH4GQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=qLI01PfyNz8utGY0Pmtn+8yjwmiu00C56hujPW8kTVvJWq35a3J4L16erZDfeaHIjdf7Sc+EG1qLDqTNYq50TdYY2DAt7Exy0YyHPDnex7Mk+EVfXYltRKKy4uf88sIHeewOG69ifJ4Z0G5FkOO9S8RJFdokEyb1sFjUCwnN+TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-b7-68789fb2baf4
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	almasrymina@google.com,
	ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com,
	akpm@linux-foundation.org,
	andrew+netdev@lunn.ch,
	asml.silence@gmail.com,
	toke@redhat.com,
	david@redhat.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	vishal.moola@gmail.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	jackmanb@google.com,
	wei.fang@nxp.com,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	bbhushan2@marvell.com,
	tariqt@nvidia.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	saeedm@nvidia.com,
	leon@kernel.org,
	mbloch@nvidia.com,
	danishanwar@ti.com,
	rogerq@kernel.org,
	nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	aleksander.lobakin@intel.com,
	horms@kernel.org,
	m-malladi@ti.com,
	krzysztof.kozlowski@linaro.org,
	matthias.schiffer@ew.tq-group.com,
	robh@kernel.org,
	imx@lists.linux.dev,
	intel-wired-lan@lists.osuosl.org,
	linux-arm-kernel@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v11 00/12] Split netmem from struct page
Date: Thu, 17 Jul 2025 16:00:40 +0900
Message-Id: <20250717070052.6358-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0xTdxjG/Z//udG1ybFz25nX2MyYgTfAudfojKgfzhcToyZG/DA6ObGN
	XEzB2joX0TEY5SJBMaAlgBTGzUHaAQWLQumEqGgtlNRxc+iYl7ILCKG2o2u9fPvlffI+z/sk
	L4vldmopq05JFzUpyiQFLSElU9LK9ZZynWrTg7yPwNjUSMPDmUoKGuZ18NNjKwWuOh5uOOcJ
	MNa3InjlG2bAnDOCYcbRS0NV5RwGX3M+CcYHmSTMNr3G8MftCQb67P+R0GDeC+M1kyTYstsw
	9MyugYkLfTTkZ/oxlI79QEPwNz8Fnb6/GDhvrSWg82ULA87WAgouva7G0JbxOJT1ZIiCgQ4j
	DQPfP0Qw1hikYNIeCvTWjjBQ0HAFgf1WHQ3nM2PB2/KKgX+KHRjGC3bCQokWbld8DHN3vQiG
	q90EBG1WBu6P/UyBo6mNgMHffRjm8spoMExdQOAu7SDgXlkzBaa7g0TojgMwFAwQcNFVQcOT
	zHEErp4JEq6eK0DQdNNDwb+2UGX/vJHeuUvo8f6NBeuoCQm/1D0ihGeFC4TguXmHENqvjDJC
	hfmkYKmNFKpszwnB4HFhwVyfQwvm6SJGGBmy0UJfiZ8ULKazwjNLKdq3Il6yPVFMUmtFzcYd
	CRJVv8NEnhjdostqm2QykDHKgCJYntvMG7qr6fdcXP6CDDPNreU9Hh8O8xIump+Z6A3NJSzm
	+qV8p6WECAsfcnH85Ud2Kswkt4bvyHn6xkgWMsoymMm3pqv4huYuHF7muasRfFVh4J3wKd9d
	6yEL0QcVaFE9kqtTtMlKddLmDSp9ilq34WhqshmFPqvmu8ARK5p2HrAjjkUKqSyh+ZRKTim1
	afpkO+JZrFgiu+jSquSyRKX+tKhJ/VpzMklMs6NlLKn4RBYzdypRzh1TpovHRfGEqHmvEmzE
	0gzEH8zX9njjEg6fCwwm71bGtR8z/Hh2Xfz27ulf89xFe3DsyPIO9eXDEfqu4n0tRanfkqu7
	vqrZ2h644c/O7n2ZPxAri1rsLmd0UZQTWLeiU/YN92Wr84szMVulvD534Ezu1J/7HdciV674
	nFr/2fX+YMm2xcMBacaW4KYYdPCQKVZBpqmU0ZFYk6b8HwCH6iBVAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0yTZxjFfb/3u1GpaZDMb5ho0sSYuMxpJvPRLQtOo++MGhNNTOZ0NONj
	bQSqLVZYQgApLBQpKGoKFkFBubm1K5N2UATbKnhBoSipchUnwmRzWEAKKGuz7L/fc05yzvnj
	4XFEGRPFq5KSRU2SIkHOSmjJns+zPraVpSjXNb+MBrPlGgtd/ksM1M2kQNWQgwFvjQBNnTMU
	mGsbEEwGejmw5fZh8HvaWKi4NI0hYM2nwfxQT8OUZRbDi9vDHLS73tFQZ9sNg1dHaHD+ZMfg
	nloFwwXtLOTr5zAUD2SzsPB0joHmwN8cnHRUU+AuvRM8X13noLPByMDZ2SsY7BlDwcLnPQx0
	N5pZ6M7qQjBwbYGBEVewdby6jwNjXQkCV0sNCyf1n8L49UkO/jnnwTBojIH3Jh3cLv8Apu+N
	I+i98piCBaeDgwcDvzDgsdgpePQsgGH6VCkLhr8KEDwubqTgfqmVgcp7j6jgjn3QszBPQZG3
	nIXn+kEEXvcwDRcyjQgsN3wMTDj1dMxW4h5/jYmjvxKR32qeUGS08D1FfDfuUuT3kn6OlNuO
	k/rqNaTCOUYRg8+Lia02lyW2N2c40tfjZEm7aY4m9ZXpZLS+GO1d8Y3kizgxQaUTNZ98GStR
	dngq6aP9n6Xk2Ee4DGT+yIDCeEG2QThX9icdYla2WvD5AjjEkbL1gn+4LahLeCzrCBea601U
	yFgq2yKcf+JiQkzLVgmNuX+wIZYGg3IMNvq/0JVCnbUVFyK+HC2qRZGqJF2iQpUQvVZ7RJma
	pEpZ+7060YaCb3M1bf60A01273AhGY/k4dJY6wllBKPQaVMTXUjgsTxSWuTVKSOkcYrUH0WN
	+jvN8QRR60LLeVq+TLrzgBgbIftBkSweEcWjouZ/l+LDojJQQ/72Kn/ZUsu2qCUZY2GbN51V
	mzYUnja1PXjrSe0Y20fZWw9He781FO06xLVMdFgrNja1vM4jabfyZxLjcfbPJYH99uRf0+I+
	dG91lXqfZb29/OrN0MS6zN4tl+PTO9VdB7mLeXNTi+2o1aC+ua0v/WBOgb/7TMGmr47Zz/uN
	2Qe+ltNapWL9GqzRKv4FRv03hjIDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hi all,

The MM subsystem is trying to reduce struct page to a single pointer.
See the following link for your information:

   https://kernelnewbies.org/MatthewWilcox/Memdescs/Path

The first step towards that is splitting struct page by its individual
users, as has already been done with folio and slab.  This patchset does
that for page pool.

Matthew Wilcox tried and stopped the same work, you can see in:

   https://lore.kernel.org/linux-mm/20230111042214.907030-1-willy@infradead.org/

I focused on removing the page pool members in struct page this time,
not moving the allocation code of page pool from net to mm.  It can be
done later if needed.

The final patch that removes the page pool fields will be posted once
all the conversions are completed.

	Byungchul
---
Changes from v10:
	1. Introduce __netmem_to_nmdesc() and use it in
	   __netmem_get_pp(). (feedbacked by Mina)
	2. Fix a bug that fails on casting 'const page -> const
	   netmem_desc', by using macros and _Generic. (feedbacked by
	   test robot)
	3. Add comment on pp_page_to_nmdesc() to ask for more attention
	   before using the helper. (feedbacked by Mina)

Changes from v9:
	1. Remove the patch 'page_pool: access ->pp_magic through
	   netmem_desc in page_pool_page_is_pp()' and decide to wait for
	   Pavel's work of PageNetpp() to identify page type for page
	   pool, that doesn't need to access ->pp_magic.
	2. Rename page_to_nmdesc() to pp_page_to_nmdesc() and add
	   DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(page)) in it,
	   just in case. (feedbacked by Pavel)
	3. Apply just simple casting from page to netmem_desc for
	   accessing ->pp and ->pp_ref_count, instead of full converting
	   page to netmem_ref for network drivers e.g. mlx4, netdevsim,
	   and mt76.
	4. Expand the support for drivers to access ->pp and
	   ->pp_ref_count to fec, octeontx2-pf, iavf, idpf, mlx5, ti,
	   and xdp.
	5. Squash each helper with its first user. (feedbacked by Mina)

Changes from v8:
	1. Rebase on net-next/main as of Jul 10.
	2. Exclude non-controversial patches that have already been
	   merged to net-next.
	3. Re-add the patches that focus on removing accessing the page
	   pool fields in struct page.
	4. Add utility APIs e.g. casting, to use struct netmem_desc as
	   descriptor, to support __netmem_get_pp() that has started to
	   be used again e.g. by libeth.

Changes from v7 (no actual updates):
	1. Exclude "netmem: introduce struct netmem_desc mirroring
	   struct page" that might be controversial.
	2. Exclude "netmem: introduce a netmem API,
	   virt_to_head_netmem()" since there are no users.

Changes from v6 (no actual updates):
	1. Rebase on net-next/main as of Jun 25.
	2. Supplement a comment describing struct net_iov.
	3. Exclude a controversial patch, "page_pool: access ->pp_magic
	   through struct netmem_desc in page_pool_page_is_pp()".
	4. Exclude "netmem: remove __netmem_get_pp()" since the API
	   started to be used again by libeth.

Changes from v5 (no actual updates):
	1. Rebase on net-next/main as of Jun 20.
	2. Add given 'Reviewed-by's and 'Acked-by's, thanks to all.
	3. Add missing cc's.

Changes from v4:
	1. Add given 'Reviewed-by's, thanks to all.
	2. Exclude potentially controversial patches.

Changes from v3:
	1. Relocates ->owner and ->type of net_iov out of netmem_desc
	   and make them be net_iov specific.
	2. Remove __force when casting struct page to struct netmem_desc.

Changes from v2:
	1. Introduce a netmem API, virt_to_head_netmem(), and use it
	   when it's needed.
	2. Introduce struct netmem_desc as a new struct and union'ed
	   with the existing fields in struct net_iov.
	3. Make page_pool_page_is_pp() access ->pp_magic through struct
	   netmem_desc instead of struct page.
	4. Move netmem alloc APIs from include/net/netmem.h to
	   net/core/netmem_priv.h.
	5. Apply trivial feedbacks, thanks to Mina, Pavel, and Toke.
	6. Add given 'Reviewed-by's, thanks to Mina.

Changes from v1:
	1. Rebase on net-next's main as of May 26.
	2. Check checkpatch.pl, feedbacked by SJ Park.
	3. Add converting of page to netmem in mt76.
	4. Revert 'mlx5: use netmem descriptor and APIs for page pool'
	   since it's on-going by Tariq Toukan.  I will wait for his
	   work to be done.
	5. Revert 'page_pool: use netmem APIs to access page->pp_magic
	   in page_pool_page_is_pp()' since we need more discussion.
	6. Revert 'mm, netmem: remove the page pool members in struct
	   page' since there are some prerequisite works to remove the
	   page pool fields from struct page.  I can submit this patch
	   separatedly later.
	7. Cancel relocating a page pool member in struct page.
	8. Modify static assert for offests and size of struct
	   netmem_desc.

Changes from rfc:
	1. Rebase on net-next's main branch.
	   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/
	2. Fix a build error reported by kernel test robot.
	   https://lore.kernel.org/all/202505100932.uzAMBW1y-lkp@intel.com/
	3. Add given 'Reviewed-by's, thanks to Mina and Ilias.
	4. Do static_assert() on the size of struct netmem_desc instead
	   of placing place-holder in struct page, feedbacked by
	   Matthew.
	5. Do struct_group_tagged(netmem_desc) on struct net_iov instead
	   of wholly renaming it to strcut netmem_desc, feedbacked by
	   Mina and Pavel.

Byungchul Park (12):
  netmem: introduce struct netmem_desc mirroring struct page
  netmem: use netmem_desc instead of page to access ->pp in
    __netmem_get_pp()
  netmem, mlx4: access ->pp_ref_count through netmem_desc instead of
    page
  netdevsim: access ->pp through netmem_desc instead of page
  mt76: access ->pp through netmem_desc instead of page
  net: fec: access ->pp through netmem_desc instead of page
  octeontx2-pf: access ->pp through netmem_desc instead of page
  iavf: access ->pp through netmem_desc instead of page
  idpf: access ->pp through netmem_desc instead of page
  mlx5: access ->pp through netmem_desc instead of page
  net: ti: icssg-prueth: access ->pp through netmem_desc instead of page
  libeth: xdp: access ->pp through netmem_desc instead of page

 drivers/net/ethernet/freescale/fec_main.c     |  10 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   |   2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |   8 +-
 .../marvell/octeontx2/nic/otx2_txrx.c         |   2 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c    |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |   3 +-
 .../net/ethernet/ti/icssg/icssg_prueth_sr1.c  |   4 +-
 drivers/net/netdevsim/netdev.c                |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |   3 +-
 include/net/libeth/xdp.h                      |   2 +-
 include/net/netmem.h                          | 153 +++++++++++++++---
 11 files changed, 159 insertions(+), 38 deletions(-)


base-commit: c65d34296b2252897e37835d6007bbd01b255742
-- 
2.17.1


