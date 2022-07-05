Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F9B5669FF
	for <lists+bpf@lfdr.de>; Tue,  5 Jul 2022 13:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiGELmF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Jul 2022 07:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiGELlz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Jul 2022 07:41:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A2A167FA;
        Tue,  5 Jul 2022 04:41:53 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lcggg0tMjzhYwh;
        Tue,  5 Jul 2022 19:39:27 +0800 (CST)
Received: from kwepemm600016.china.huawei.com (7.193.23.20) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 5 Jul 2022 19:41:50 +0800
Received: from localhost.localdomain (10.67.165.24) by
 kwepemm600016.china.huawei.com (7.193.23.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 5 Jul 2022 19:41:49 +0800
From:   Guangbin Huang <huangguangbin2@huawei.com>
To:     <jbrouer@redhat.com>, <hawk@kernel.org>, <brouer@redhat.com>,
        <ilias.apalodimas@linaro.org>, <davem@davemloft.net>,
        <kuba@kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>
CC:     <lorenzo@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <lipeng321@huawei.com>, <huangguangbin2@huawei.com>,
        <chenhao288@hisilicon.com>
Subject: [PATCH net-next v3] net: page_pool: optimize page pool page allocation in NUMA scenario
Date:   Tue, 5 Jul 2022 19:35:15 +0800
Message-ID: <20220705113515.54342-1-huangguangbin2@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600016.china.huawei.com (7.193.23.20)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jie Wang <wangjie125@huawei.com>

Currently NIC packet receiving performance based on page pool deteriorates
occasionally. To analysis the causes of this problem page allocation stats
are collected. Here are the stats when NIC rx performance deteriorates:

bandwidth(Gbits/s)		16.8		6.91
rx_pp_alloc_fast		13794308	21141869
rx_pp_alloc_slow		108625		166481
rx_pp_alloc_slow_h		0		0
rx_pp_alloc_empty		8192		8192
rx_pp_alloc_refill		0		0
rx_pp_alloc_waive		100433		158289
rx_pp_recycle_cached		0		0
rx_pp_recycle_cache_full	0		0
rx_pp_recycle_ring		362400		420281
rx_pp_recycle_ring_full		6064893		9709724
rx_pp_recycle_released_ref	0		0

The rx_pp_alloc_waive count indicates that a large number of pages' numa
node are inconsistent with the NIC device numa node. Therefore these pages
can't be reused by the page pool. As a result, many new pages would be
allocated by __page_pool_alloc_pages_slow which is time consuming. This
causes the NIC rx performance fluctuations.

The main reason of huge numa mismatch pages in page pool is that page pool
uses alloc_pages_bulk_array to allocate original pages. This function is
not suitable for page allocation in NUMA scenario. So this patch uses
alloc_pages_bulk_array_node which has a NUMA id input parameter to ensure
the NUMA consistent between NIC device and allocated pages.

Repeated NIC rx performance tests are performed 40 times. NIC rx bandwidth
is higher and more stable compared to the datas above. Here are three test
stats, the rx_pp_alloc_waive count is zero and rx_pp_alloc_slow which
indicates pages allocated from slow patch is relatively low.

bandwidth(Gbits/s)		93		93.9		93.8
rx_pp_alloc_fast		60066264	61266386	60938254
rx_pp_alloc_slow		16512		16517		16539
rx_pp_alloc_slow_ho		0		0		0
rx_pp_alloc_empty		16512		16517		16539
rx_pp_alloc_refill		473841		481910		481585
rx_pp_alloc_waive		0		0		0
rx_pp_recycle_cached		0		0		0
rx_pp_recycle_cache_full	0		0		0
rx_pp_recycle_ring		29754145	30358243	30194023
rx_pp_recycle_ring_full		0		0		0
rx_pp_recycle_released_ref	0		0		0

Signed-off-by: Jie Wang <wangjie125@huawei.com>

---
v2->v3:
1, Delete the #ifdefs
2, Use 'pool->p.nid' in the call to alloc_pages_bulk_array_node()

v1->v2:
1, Remove two inappropriate comments.
2, Use NUMA_NO_NODE instead of numa_mem_id() for code maintenance.
---
 net/core/page_pool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index f18e6e771993..b74905fcc3a1 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -389,7 +389,8 @@ static struct page *__page_pool_alloc_pages_slow(struct page_pool *pool,
 	/* Mark empty alloc.cache slots "empty" for alloc_pages_bulk_array */
 	memset(&pool->alloc.cache, 0, sizeof(void *) * bulk);
 
-	nr_pages = alloc_pages_bulk_array(gfp, bulk, pool->alloc.cache);
+	nr_pages = alloc_pages_bulk_array_node(gfp, pool->p.nid, bulk,
+					       pool->alloc.cache);
 	if (unlikely(!nr_pages))
 		return NULL;
 
-- 
2.33.0

