Return-Path: <bpf+bounces-63169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8DBB03DFB
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 14:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5041A611B1
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 12:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561EC248F72;
	Mon, 14 Jul 2025 12:01:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D132522DA1B;
	Mon, 14 Jul 2025 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494461; cv=none; b=MjvfHFb1PPVpSIRHFdv+nm1TBp6lAQ/kJ1nGHybUFb049UbKcUsrejMP+kMxgnBDRozMBPwKm6mCE2xbEB12HPsv/ecOl9jvYfbb1V243Sndrb11EHiGpdtPsPUMD+WbMCppNAW4wqvtotyhHEhObakBWHQLpjjNZtg0pHROX+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494461; c=relaxed/simple;
	bh=SxFEtTI5tFR5W7cAfJjOqImKVFz+4rXjR3GIBRzEsKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QGgzO5yvJIB+Fu1OCiiiNe1BFLXveucS6Na8feB42ql9UPel1Yd2X9JMQAogzKN24fe+e6kYvQbVrDNwfcWO45BFaRBaG0Y+MR4J46fUBDNXOQUNBopi8rXI56fLevb2Ozx6ID3lbpzWDF7PP5OrPYPRUiwpusszxVUNsMnwJL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-1f-6874f179d144
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
Subject: [PATCH net-next v10 03/12] mlx4: access ->pp_ref_count through netmem_desc instead of page
Date: Mon, 14 Jul 2025 21:00:38 +0900
Message-Id: <20250714120047.35901-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250714120047.35901-1-byungchul@sk.com>
References: <20250714120047.35901-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAz2Se0yTZxTGfb/3u7WhyZfK9FMzZ5oRicu8ojmJxjj1jzcao5sxcWoCnXyz
	ndwsF8HEiK5ssQoS0QSwZJWC4xaLRWinLZeWCYLKRaxVgQJGUaxOBRsqKBbM/O+Xc57zPOck
	h8fKh8x8XpuQIukS1HEqVk7LX4YVf5/xJkWz/FT7WjBaqljoGr3IQOV4Ovw9YGegu1yE653j
	FBgr6hCMBR9xYD3Zi2G0uYUF88UAhmB1Ng3GDj0N7yzvMTy5McRBq+sDDZXWbeC79JQGx582
	DO53ETB0ppWFbP0EhoL+LBamHk4w4Ay+4uCEvYwC54taDjrrchg4974Ugy1zIJT12MPA3WtG
	Fu7+3oWgv2qKgaeuUKC/rJeDnMpCBK6GchZO6FeBv3aMg9fnmzH4cjbAx/w0uGGaA4F2P4JH
	pfcomHLYObjTf5mBZouNgp7BIIbA6SIWDC/PILhXcI2CW0XVDJS091ChPXaCZ2qSgrxuEwuP
	9T4E3e4hGi4cz0Fgqfcy8MYROnli3Mhu2Ejc/v8wsfeVIHK1/AFFnuV+pIi3vo0i/xT2ccRk
	TSU1ZUuI2fGcIgZvNybWipMssb49y5Fej4MlrfkTNKkpOUae1RSgHV/vka+LleK0aZJu2foY
	ueZOo51JypKl/xs040zUwBmQjBeFKPH6YNUXLu7Xo2lmhcWi1xvE0xwurBBHh1poA5LzWLgd
	Jjpr8qnpxmxhv9jTlz0jooUI0XfOPMMKYbVYnPWE+mz6jVhZ3ThTlwlrxL+KBmcClCFNvaEE
	T5uKgkUm3m/4A30emCc2lXnpXKQwoVkVSKlNSItXa+OilmoyErTpS/cnxltR6OMuHZ3ca0dv
	O3e6kMAjVZgCRlI0SkadlpwR70Iij1XhipE+nUapiFVnHJF0idG61Dgp2YUW8LRqrmJl4HCs
	UjigTpEOSlKSpPu/S/Gy+Zlo5ZHaFyIsryOFi4o3d7RFHLN2LTvdeOi+w+f27fp248jmfTGB
	H+a1/mob2GLO2v5z/Gv0Y0z7cEekrSo2FZqGdcNs2J7cyYU/DUd68gZNuzuFJv+FZufWfYEr
	X0UeGtM6+MSbv4x/R60r9Z797epBp+dDi9A2qyAyaZM7L4rtqo5W0cka9YolWJes/gQWUuHg
	bQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0xTZxjG953v3NrYeCxVj5ro7CQmzsuMc3kXjTGZ0S9LNpcs2UX/0CJH
	21gqaQsBk0UmJUodFW8ZMAhXHVCzg+XS6solBRF0cwgIndJWIRAv3bxwSStoLRj/+73v8+R9
	nj9eHqvdzFLeYLJKZpPOqGWVtPLrLdnrMl9Y9Z/YShOhWL7Mwp3xcgackQz4/YGHgd4aEf7s
	iVBQXNuEYCJ6nwNX7hCG8Y4bLFSWT2GI1uXRUPyPjYZJ+RWG0c5hDrp8r2lwur6C0KUxGrwn
	3BjaJxNh+HQXC3m2aQyFwRwWYvemGWiO/s/BcU81Be0l3fHxaSMHPU0OBs6/uojBnfUgHjgy
	wEDftWIW+rLvIAhejjEw5ounhquHOHA4ixD4WmtYOG7bBOHGCQ6eX+jAEHJshzcF6dBZtgim
	boUR3L94l4KY18PB7eAfDHTIbgr6H0YxTP1SwoL9v9MI7hZeo+CvkjoGqm71U/Ee38JAbIaC
	c71lLIzYQgh624dp+O1nBwK5xc/AC6+N3v4FaQ8/w8QTqEKkoeZfijzKf0MRf8tNilwtCnCk
	zJVG6qvXkErvY4rY/b2YuGpzWeJ6eZYjQwNelnQVTNOkvuoYeVRfiL5Zvke5NVkyGtIl84Zt
	+5X6220eJjVHkXE9WomzUCtnRwpeFD4VK4I2NMussFr0+6N4ljXCRnF8+AZtR0oeC3/PE5vr
	C6hZIUE4IPYH8uZMtJAohs5XzrFK2CxW5IxS746uEJ11bXN7hfCZWFrycC5AHfe02KtwPlKW
	oQ9qkcZgSk/RGYyb11sO6zNNhoz1B46kuFD8nS79NHPGgyb6dvmQwCPtPBU8serVjC7dkpni
	QyKPtRrVk4BZr1Yl6zKPSuYj+8xpRsniQ8t4WrtY9eX30n61cEhnlQ5LUqpkfq9SvGJpFgou
	+DipITLatorU7lE4x/0bBu1rm/dliwnf1d08eCV/pmh+dlNqw05Ld4Xjh55fn3ZuNctydRgj
	98qdx04madaW2hJyPzeGMH+0370kNtK4I8na2rVw4b1SOWnk8d5O+6nA5GD+4u5k3Y/yRxHL
	wQ875ivHll83yZElz5ndoZcaLW3R6zauwWaL7i1WlvDdSgMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

To eliminate the use of struct page in page pool, the page pool users
should use netmem descriptor and APIs instead.

Make mlx4 access ->pp_ref_count through netmem_desc instead of page.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_rx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index b33285d755b9..92a16ddb7d86 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -460,9 +460,11 @@ static int mlx4_en_complete_rx_desc(struct mlx4_en_priv *priv,
 
 		truesize += frag_info->frag_stride;
 		if (frag_info->frag_stride == PAGE_SIZE / 2) {
+			struct netmem_desc *desc = pp_page_to_nmdesc(page);
+
 			frags->page_offset ^= PAGE_SIZE / 2;
 			release = page_count(page) != 1 ||
-				  atomic_long_read(&page->pp_ref_count) != 1 ||
+				  atomic_long_read(&desc->pp_ref_count) != 1 ||
 				  page_is_pfmemalloc(page) ||
 				  page_to_nid(page) != numa_mem_id();
 		} else if (!priv->rx_headroom) {
-- 
2.17.1


