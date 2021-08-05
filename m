Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775DE3E136F
	for <lists+bpf@lfdr.de>; Thu,  5 Aug 2021 13:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240724AbhHELGn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Aug 2021 07:06:43 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:16050 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240623AbhHELGm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Aug 2021 07:06:42 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GgQgX0csKzZxmj;
        Thu,  5 Aug 2021 19:02:48 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (7.185.36.74) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 19:06:22 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 19:06:22 +0800
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
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <chenhao288@hisilicon.com>
Subject: [PATCH net-next 0/4] add frag page support in page pool
Date:   Thu, 5 Aug 2021 19:05:22 +0800
Message-ID: <1628161526-29076-1-git-send-email-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset adds frag page support in page pool and
enable skb's page frag recycling based on page pool in
hns3 drvier.

V1:
1. avoid atomic_long_read() in case of freeing or draining
   page frag, and drop RFC tag.

RFC v6:
1. Disable frag page support in system 32-bit arch and
   64-bit DMA.

RFC v5:
1. Rename dma_addr[0] to pp_frag_count and adjust codes
   according to the rename.

RFC v4:
1. Use the dma_addr[1] to store bias.
2. Default to a pagecnt_bias of PAGE_SIZE - 1.
3. other minor comment suggested by Alexander.

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
  page_pool: add interface to manipulate frag count in page pool
  page_pool: add frag page recycling support in page pool
  net: hns3: support skb's frag page recycling based on page pool

 drivers/net/ethernet/hisilicon/Kconfig          |   1 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c |  79 +++++++++++++++--
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h |   3 +
 drivers/net/ethernet/marvell/mvneta.c           |   6 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c |   2 +-
 drivers/net/ethernet/ti/cpsw.c                  |   2 +-
 drivers/net/ethernet/ti/cpsw_new.c              |   2 +-
 include/linux/mm_types.h                        |  18 ++--
 include/linux/skbuff.h                          |   4 +-
 include/net/page_pool.h                         |  68 +++++++++++---
 net/core/page_pool.c                            | 112 +++++++++++++++++++++++-
 11 files changed, 258 insertions(+), 39 deletions(-)

-- 
2.7.4

