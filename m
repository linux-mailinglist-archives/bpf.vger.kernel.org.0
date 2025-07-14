Return-Path: <bpf+bounces-63172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5A0B03E0A
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 14:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5FF1A617F8
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 12:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EBF253351;
	Mon, 14 Jul 2025 12:01:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C21178372;
	Mon, 14 Jul 2025 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494463; cv=none; b=Kqt/vRKS/hz6Ltm1XTZzscxkkrO4AoCRucDufkXlf8QVnCEHa0DlYl/JgopwbTAxO7yz6iLl7IPrQQ6HmJd7HhG32B3ikXysYPKjPa/XgkIVTRkpVcNwSNw+RHuy4G7GElRP/8olV23c8RhkOzpJp2RwBvXzEB9ibq7zyUIgRQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494463; c=relaxed/simple;
	bh=DKtpnwmgtwr3ulIqs99dUHLBjCDPmbzOQGaSeTJIesM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=u3ZHlWf31BUyQqyYDXPGzAKl5MzsPXevWDBGe5VjEWhsPIXVVW+pvQSUXzgraAVKDHL/7ExDZ3EoxzOsOf9kDpKZJc9STi7pGkJgTfPnbVFZXnO5gBnzX68XkNCbkp/crHBSeKvgOlLhje4FW87OMrT6y1oThkXAYJHFCjb1TwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-e8-6874f17962cc
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
Subject: [PATCH net-next v10 00/12] Split netmem from struct page
Date: Mon, 14 Jul 2025 21:00:35 +0900
Message-Id: <20250714120047.35901-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa2yLcRTG/f/vdbUmb2rhRRBNBMPckyNBxqeXREJEJEam0TfarBvartuE
	mCli2YYh6baiZWYX0WmxotvohjGXmV06unXmkpmaWW3WDdVNfHtyfuc5zznJYQmZm5rCqpP0
	ojZJoZHTElLyNfLSgrTvetWi7qdzwWy7RsOrgJWCsqFUuNrppKCxhId7DUMYzKW3EfwIvmXA
	fsJLQKD2MQ2XrYMEBMuzSTC/NJIwYBsm4OOjLgbq3L9JKLNvAF/RJxJcxysIqBmYBV0n62jI
	No4QkNdxlIbQmxEKKoO9DGQ4izFUfrnFQMPtHArODl8hoCK9M5z1voWC13fNNLw+8gpBx7UQ
	BZ/c4UB/sZeBnLJ8BO7qEhoyjEvBf+sHA33nagnw5cTCH5MBHlkmwmC9H8HbK80YQi4nAy86
	rlNQa6vA0PQuSMBg1nkaMr+eRNCcdxfDs/PlFBTWN+HwHpuhJfQLw5lGCw3vjT4EjTVdJBQc
	zkFgq/JQ8N0VPnlkyEzHrhVq/N8IwdleiISbJW1Y6D71BwueqqdYuJPfzggWe7LgKI4WLrs+
	YyHT00gI9tITtGDvz2UEb4uLFupMI6TgKDwkdDvy0MZp2yQrlaJGbRC1C1fvlKgKAr14r3dp
	qs8TwOkoMCcTRbA8t4w/XRIg/uussw5mVNPcbN7jCY7Vo7jFfKDrMZmJJCzBPY/kKx0mPAom
	cGt4a6h5rInkZvFNx/xjZim3nM86XYD/DZ3Bl5XfJ0bNPFcQwXsufqT+gcn8g2IPeQqNt6Bx
	pUimTjIkKtSaZTGqtCR1asyuPYl2FP6sooO/4pyov2GzG3EskkdKoUevklEKgy4t0Y14lpBH
	SXvatSqZVKlI2y9q98RrkzWizo2msqR8knTJYIpSxu1W6MUEUdwrav9TzEZMSUerUmJ5Ur9i
	/DyHBW+tVmqe/Owz6SZcVLKFQz38+txom3RS/E4UF79vvr31SXXcQEuCN/tIT+V23wHjGeva
	bbkZ4uFeo5k8t39L55y2/NUmyFP/TvBPd6ybWbShL+O49RKz6cKH5NaOHTfEhwObdqUMa4Mx
	BqY+MqZ/R+xG7mGKnNSpFIujCa1O8ReSf+AMVQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0yTZxTGfb/3u7Wj8ROJfkE3TY2BmIgaLzmJRlk02TsXjcn+mMFErfrF
	Nlw0LVbYdIJ2W6wIqMxwaSfMKpeiYKtQoaIpTJmKSrnYzXJZvQS0gq7Y0KLWovG/5+R5nvM7
	fxwex55h4nlNRqakzVClKVk5Ld+48sjC7NeZ6sV/VSvAVFfLQmegggHreBZUDjoYcFeL0Pxg
	nAJTTQOCsdAjDmxHvRgCbbdYOFsRxBCqP06D6b6Bhjd1YQxPb/o4aHe9o8Fq2wAD55/R4Pyt
	EUPrm/ngK2hn4bhhAkNJ/y8sRP6dYOBaaISDw44qClrNf0fHF1c4eNCQz0BR+ByGxpzBKPBx
	LwNdTSYWuo50IuivjTDwzBWl+qu8HORbSxG4rlezcNiwFPxXxjh49XsbhoH8ZHhfrIeb5TMg
	eMeP4NG5HgoiTgcH9/ovMtBW10hB938hDME8MwvGlwUIekqaKLhrrmfAcqebit7xPfRG3lJw
	yl3OwmPDAAJ3q4+Gstx8BHUtHgZeOw108lrS6h/FxNFnQeRy9T8UGSp8TxFPy22KXC3t40i5
	bR+xVy0gZ53DFDF63JjYao6yxPb/SY54e50saS+eoIndcogM2UvQpq9S5Kt2SWkavaRdtHq7
	XF0WGKH2epdmDXgCVA4KJBqRjBeFZWJekZ2b1KyQIHo8ITyp44QlYsB3izYiOY+Fjhjxmr2Y
	mjSmC1+LFZGejyFamC92/+r/WFYIy8W8E2XUp6VzRGv9DVyI+HI0pQbFaTL06SpN2vIkXao6
	O0OTlbRzT7oNRd/m/MG3JxxorOsbFxJ4pIxRwPNMdSyj0uuy011I5LEyTvG8T6uOVexSZf8o
	afds0+5Lk3QuNIunlTMV63+QtscKu1WZUqok7ZW0n12Kl8XnoMIm4xdcf8dmevhbb0qLY658
	IkXvK9LlDppOW2b3NBwrZf5Ikl1IsLlTH343ellWqmk60GGfqi4Ir9i6ctqBeZah3K5Fnbjl
	y9TK5Kc79v90qWFkzY5E62hi8Od1W2KCzePck7zuOfJNq+XkVPzBYU6WsJmEzbnmu2c6/pxh
	bg4TJa1Tq5YswFqd6gPgoPYEMgMAAA==
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
  mlx4: access ->pp_ref_count through netmem_desc instead of page
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
 include/net/netmem.h                          | 129 +++++++++++++++---
 11 files changed, 135 insertions(+), 38 deletions(-)


base-commit: c65d34296b2252897e37835d6007bbd01b255742
-- 
2.17.1


