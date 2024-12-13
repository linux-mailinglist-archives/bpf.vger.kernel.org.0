Return-Path: <bpf+bounces-46834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 109E69F0C54
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 13:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0FA9284CCF
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 12:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E931DF97F;
	Fri, 13 Dec 2024 12:34:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A201DF256;
	Fri, 13 Dec 2024 12:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734093273; cv=none; b=ce9YKy9IMb70vxPQ+xu3vBgF/rpOZwhn6YlqLH3DD1OGlbA1BBbDf76v7D39sTq8chCb1wI37I93bs0j4hqnWnU6q6dfANyz5cZ7o/swLwdwqn46glTWS/rpTbMCKftxX9pYunQwJWqVZ8PbGjhgG/W790LSjVHHOCxpns6Hgto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734093273; c=relaxed/simple;
	bh=4o5NI4bsGY6wIj4gfMamlO8SkUMVjCEA4aebTAcSTpk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eSKlfQb+L48YmfU7nTLwbH3ieeRg2BdzESQNYZ+/xC2MmEwlNb2CMiwMsz7QdExJqo/YXgSITR5HkO+bQ9uWFF5Ab2XlINFcuU51JnQNLaqrfbFd/BOUsVkApGnV+6bmQw6tqd1q48wa6TqhQ/GYS23dKdrgEqlz/rd/My3lV/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Y8pcZ33WXzhZTt;
	Fri, 13 Dec 2024 20:31:58 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 538CD140123;
	Fri, 13 Dec 2024 20:34:25 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Dec 2024 20:34:25 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <somnath.kotur@broadcom.com>, <liuyonglong@huawei.com>,
	<fanghaiqing@huawei.com>, <zhangkun09@huawei.com>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Alexander Duyck
	<alexander.duyck@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, IOMMU
	<iommu@lists.linux.dev>, MM <linux-mm@kvack.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: [PATCH RFCv5 0/8] fix two bugs related to page_pool
Date: Fri, 13 Dec 2024 20:27:31 +0800
Message-ID: <20241213122739.4050137-1-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

This version is mainly to see if using page_pool_item metadata
to keep track of all pages is the correct way to fix the dma
API misuse problem.

Note, it is not based on the latest net-next tree yet, but based
on the below commit in net-next:
commit da4fa00abe56 ("Merge branch 'mitigate-the-two-reallocations-issue-for-iptunnels'")

From the below performance data, the overhead is avoided as much as possible
for time_bench_page_pool01_fast_path() and time_bench_page_pool02_ptr_ring,
and there is about 20ns overhead for time_bench_page_pool03_slow() for fixing
the bug.

Before this patchset:
root@(none)$ insmod bench_page_pool_simple.ko
root@(none)$ insmod bench_page_pool_simple.ko
[   67.667196] bench_page_pool_simple: Loaded
[   67.748321] time_bench: Type:for_loop Per elem: 0 cycles(tsc) 0.769 ns (step:0) - (measurement period time:0.076977910 sec time_interval:76977910) - (invoke count:100000000 tsc_interval:7697783)
[   69.851812] time_bench: Type:atomic_inc Per elem: 2 cycles(tsc) 20.862 ns (step:0) - (measurement period time:2.086207700 sec time_interval:2086207700) - (invoke count:100000000 tsc_interval:208620764)
[   70.019852] time_bench: Type:lock Per elem: 1 cycles(tsc) 15.015 ns (step:0) - (measurement period time:0.150151600 sec time_interval:150151600) - (invoke count:10000000 tsc_interval:15015154)
[   70.691100] time_bench: Type:rcu Per elem: 0 cycles(tsc) 6.541 ns (step:0) - (measurement period time:0.654142450 sec time_interval:654142450) - (invoke count:100000000 tsc_interval:65414239)
[   70.708119] bench_page_pool_simple: time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
[   70.975262] time_bench: Type:no-softirq-page_pool01 Per elem: 2 cycles(tsc) 25.785 ns (step:0) - (measurement period time:0.257850110 sec time_interval:257850110) - (invoke count:10000000 tsc_interval:25785005)
[   70.993931] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
[   71.575053] time_bench: Type:no-softirq-page_pool02 Per elem: 5 cycles(tsc) 57.191 ns (step:0) - (measurement period time:0.571916900 sec time_interval:571916900) - (invoke count:10000000 tsc_interval:57191684)
[   71.593722] bench_page_pool_simple: time_bench_page_pool03_slow(): Cannot use page_pool fast-path
[   73.384560] time_bench: Type:no-softirq-page_pool03 Per elem: 17 cycles(tsc) 178.197 ns (step:0) - (measurement period time:1.781979820 sec time_interval:1781979820) - (invoke count:10000000 tsc_interval:178197975)
[   73.403581] bench_page_pool_simple: pp_tasklet_handler(): in_serving_softirq fast-path
[   73.411485] bench_page_pool_simple: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
[   73.678410] time_bench: Type:tasklet_page_pool01_fast_path Per elem: 2 cycles(tsc) 25.780 ns (step:0) - (measurement period time:0.257807630 sec time_interval:257807630) - (invoke count:10000000 tsc_interval:25780758)
[   73.697686] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
[   74.242807] time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 5 cycles(tsc) 53.608 ns (step:0) - (measurement period time:0.536089620 sec time_interval:536089620) - (invoke count:10000000 tsc_interval:53608957)
[   74.261996] bench_page_pool_simple: time_bench_page_pool03_slow(): in_serving_softirq fast-path
[   76.115762] time_bench: Type:tasklet_page_pool03_slow Per elem: 18 cycles(tsc) 184.508 ns (step:0) - (measurement period time:1.845082100 sec time_interval:1845082100) - (invoke count:10000000 tsc_interval:184508203)

After this patchset:
root@(none)$ insmod bench_page_pool_simple.ko
[   88.665991] bench_page_pool_simple: Loaded
[   88.747105] time_bench: Type:for_loop Per elem: 0 cycles(tsc) 0.769 ns (step:0) - (measurement period time:0.076981170 sec time_interval:76981170) - (invoke count:100000000 tsc_interval:7698109)
[   91.585102] time_bench: Type:atomic_inc Per elem: 2 cycles(tsc) 28.206 ns (step:0) - (measurement period time:2.820699360 sec time_interval:2820699360) - (invoke count:100000000 tsc_interval:282069929)
[   91.753048] time_bench: Type:lock Per elem: 1 cycles(tsc) 15.005 ns (step:0) - (measurement period time:0.150057320 sec time_interval:150057320) - (invoke count:10000000 tsc_interval:15005727)
[   92.424306] time_bench: Type:rcu Per elem: 0 cycles(tsc) 6.541 ns (step:0) - (measurement period time:0.654151520 sec time_interval:654151520) - (invoke count:100000000 tsc_interval:65415145)
[   92.441325] bench_page_pool_simple: time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
[   92.696225] time_bench: Type:no-softirq-page_pool01 Per elem: 2 cycles(tsc) 24.560 ns (step:0) - (measurement period time:0.245607210 sec time_interval:245607210) - (invoke count:10000000 tsc_interval:24560715)
[   92.714893] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
[   93.336550] time_bench: Type:no-softirq-page_pool02 Per elem: 6 cycles(tsc) 61.245 ns (step:0) - (measurement period time:0.612451380 sec time_interval:612451380) - (invoke count:10000000 tsc_interval:61245127)
[   93.355219] bench_page_pool_simple: time_bench_page_pool03_slow(): Cannot use page_pool fast-path
[   95.402370] time_bench: Type:no-softirq-page_pool03 Per elem: 20 cycles(tsc) 203.828 ns (step:0) - (measurement period time:2.038286740 sec time_interval:2038286740) - (invoke count:10000000 tsc_interval:203828660)
[   95.421395] bench_page_pool_simple: pp_tasklet_handler(): in_serving_softirq fast-path
[   95.429301] bench_page_pool_simple: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
[   95.684025] time_bench: Type:tasklet_page_pool01_fast_path Per elem: 2 cycles(tsc) 24.560 ns (step:0) - (measurement period time:0.245605490 sec time_interval:245605490) - (invoke count:10000000 tsc_interval:24560544)
[   95.703301] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
[   96.401877] time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 6 cycles(tsc) 68.954 ns (step:0) - (measurement period time:0.689544160 sec time_interval:689544160) - (invoke count:10000000 tsc_interval:68954410)
[   96.421065] bench_page_pool_simple: time_bench_page_pool03_slow(): in_serving_softirq fast-path
[   98.496283] time_bench: Type:tasklet_page_pool03_slow Per elem: 20 cycles(tsc) 206.653 ns (step:0) - (measurement period time:2.066533210 sec time_interval:2066533210) - (invoke count:10000000 tsc_interval:206653316)

1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/

CC: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Robin Murphy <robin.murphy@arm.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: IOMMU <iommu@lists.linux.dev>
CC: MM <linux-mm@kvack.org>

Change log:
V5:
  1. Support unlimit inflight pages.
  2. Add some optimization to avoid the overhead of fixing bug.

V4:
  1. use scanning to do the unmapping
  2. spilt dma sync skipping into separate patch

V3:
  1. Target net-next tree instead of net tree.
  2. Narrow the rcu lock as the discussion in v2.
  3. Check the ummapping cnt against the inflight cnt.

V2:
  1. Add a item_full stat.
  2. Use container_of() for page_pool_to_pp().

Yunsheng Lin (8):
  page_pool: introduce page_pool_to_pp() API
  page_pool: fix timing for checking and disabling napi_local
  page_pool: fix IOMMU crash when driver has already unbound
  page_pool: support unlimited number of inflight pages
  page_pool: skip dma sync operation for inflight pages
  page_pool: use list instead of ptr_ring for ring cache
  page_pool: batch refilling pages to reduce atomic operation
  page_pool: use list instead of array for alloc cache

 drivers/net/ethernet/freescale/fec_main.c     |   8 +-
 .../ethernet/google/gve/gve_buffer_mgmt_dqo.c |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   |   6 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  14 +-
 drivers/net/ethernet/intel/libeth/rx.c        |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |   3 +-
 drivers/net/netdevsim/netdev.c                |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |   2 +-
 include/linux/mm_types.h                      |   2 +-
 include/linux/skbuff.h                        |   1 +
 include/net/libeth/rx.h                       |   3 +-
 include/net/netmem.h                          |  10 +-
 include/net/page_pool/helpers.h               |  11 +
 include/net/page_pool/types.h                 |  57 +-
 net/core/devmem.c                             |   4 +-
 net/core/netmem_priv.h                        |   5 +-
 net/core/page_pool.c                          | 660 ++++++++++++++----
 net/core/page_pool_priv.h                     |  12 +-
 net/core/skbuff.c                             |   3 +-
 net/core/xdp.c                                |   3 +-
 20 files changed, 650 insertions(+), 164 deletions(-)

-- 
2.33.0


