Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386BC3C5C01
	for <lists+bpf@lfdr.de>; Mon, 12 Jul 2021 14:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbhGLMU2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Jul 2021 08:20:28 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:11288 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbhGLMUR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Jul 2021 08:20:17 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GNjMb4PdWz78fP;
        Mon, 12 Jul 2021 20:12:59 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (7.185.36.74) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Jul 2021 20:17:15 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Jul 2021 20:17:15 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>
CC:     <alexander.duyck@gmail.com>, <linux@armlinux.org.uk>,
        <mw@semihalf.com>, <linuxarm@openeuler.org>,
        <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <thomas.petazzoni@bootlin.com>, <hawk@kernel.org>,
        <ilias.apalodimas@linaro.org>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
        <akpm@linux-foundation.org>, <peterz@infradead.org>,
        <will@kernel.org>, <willy@infradead.org>, <vbabka@suse.cz>,
        <fenghua.yu@intel.com>, <guro@fb.com>, <peterx@redhat.com>,
        <feng.tang@intel.com>, <jgg@ziepe.ca>, <mcroce@microsoft.com>,
        <hughd@google.com>, <jonathan.lemon@gmail.com>, <alobakin@pm.me>,
        <willemb@google.com>, <wenxu@ucloud.cn>, <cong.wang@bytedance.com>,
        <haokexin@gmail.com>, <nogikh@google.com>, <elver@google.com>,
        <yhs@fb.com>, <kpsingh@kernel.org>, <andrii@kernel.org>,
        <kafai@fb.com>, <songliubraving@fb.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH rfc v3 0/4] add frag page support in page pool
Date:   Mon, 12 Jul 2021 20:16:31 +0800
Message-ID: <1626092196-44697-1-git-send-email-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset adds frag page support in page pool and
enable skb's page frag recycling based on page pool in
hns3 drvier.

RFC v3:
1. Implement the semantic of "page recycling only wait for the
   page pool user instead of all user of a page" 
2. Support the frag allocation of different sizes
3. Merge patch 4 & 5 to one patch as it does not make sense to
   use page_pool_dev_alloc_pages() API directly with elevated
   refcnt.
4. other minor comment suggested by Alexander.

RFC v2:
1. Split patch 1 to more reviewable one.
2. Repurpose the lower 12 bits of the dma address to store the
   pagecnt_bias as suggested by Alexander.
3. support recycling to pool->alloc for elevated refcnt case
   too.

Yunsheng Lin (4):
  page_pool: keep pp info as long as page pool owns the page
  page_pool: add interface for getting and setting pagecnt_bias
  page_pool: add frag page recycling support in page pool
  net: hns3: support skb's frag page recycling based on page pool

 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c |  79 +++++++++++-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h |   3 +
 drivers/net/ethernet/marvell/mvneta.c           |   6 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c |   2 +-
 drivers/net/ethernet/ti/cpsw.c                  |   2 +-
 drivers/net/ethernet/ti/cpsw_new.c              |   2 +-
 include/linux/skbuff.h                          |   4 +-
 include/net/page_pool.h                         |  58 +++++++--
 net/core/page_pool.c                            | 155 +++++++++++++++++++++---
 9 files changed, 267 insertions(+), 44 deletions(-)

-- 
2.7.4

