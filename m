Return-Path: <bpf+bounces-9731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E38C679CA10
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 10:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF5E1C20401
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 08:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7074422;
	Tue, 12 Sep 2023 08:34:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67613631;
	Tue, 12 Sep 2023 08:34:46 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5D1B9;
	Tue, 12 Sep 2023 01:34:45 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RlGyD5V9wzMlK5;
	Tue, 12 Sep 2023 16:31:16 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 12 Sep 2023 16:34:42 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<bpf@vger.kernel.org>
Subject: [PATCH net-next v8 0/6] introduce page_pool_alloc() related API
Date: Tue, 12 Sep 2023 16:31:19 +0800
Message-ID: <20230912083126.65484-1-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

In [1] & [2] & [3], there are usecases for veth and virtio_net
to use frag support in page pool to reduce memory usage, and it
may request different frag size depending on the head/tail
room space for xdp_frame/shinfo and mtu/packet size. When the
requested frag size is large enough that a single page can not
be split into more than one frag, using frag support only have
performance penalty because of the extra frag count handling
for frag support.

So this patchset provides a page pool API for the driver to
allocate memory with least memory utilization and performance
penalty when it doesn't know the size of memory it need
beforehand.

1. https://patchwork.kernel.org/project/netdevbpf/patch/d3ae6bd3537fbce379382ac6a42f67e22f27ece2.1683896626.git.lorenzo@kernel.org/
2. https://patchwork.kernel.org/project/netdevbpf/patch/20230526054621.18371-3-liangchen.linux@gmail.com/
3. https://github.com/alobakin/linux/tree/iavf-pp-frag

V8: Store the dma addr on a shifted u32 instead of using
    dma_addr_t explicitly for 32-bit arch with 64-bit DMA.
    Update document according to discussion in v7.

V7: Fix a compile error, a few typo and use kernel-doc syntax.

V6: Add a PP_FLAG_PAGE_SPLIT_IN_DRIVER flag to fail the page_pool
    creation for 32-bit arch with 64-bit DMA when driver tries to
    do the page splitting itself, adjust the requested size to
    include head/tail room in veth, and rebased on the latest
    next-net.

v5 RFC: Add a new page_pool_cache_alloc() API, and other minor
        change as discussed in v4. As there seems to be three
        comsumers that might be made use of the new API, so
        repost it as RFC and CC the relevant authors to see
        if the new API fits their need.

V4. Fix a typo and add a patch to update document about frag
    API, PAGE_POOL_DMA_USE_PP_FRAG_COUNT is not renamed yet
    as we may need a different thread to discuss that.

V3: Incorporate changes from the disscusion with Alexander,
    mostly the inline wraper, PAGE_POOL_DMA_USE_PP_FRAG_COUNT
    change split to separate patch and comment change.
V2: Add patch to remove PP_FLAG_PAGE_FRAG flags and mention
    virtio_net usecase in the cover letter.
V1: Drop RFC tag and page_pool_frag patch.

Yunsheng Lin (6):
  page_pool: frag API support for 32-bit arch with 64-bit DMA
  page_pool: unify frag_count handling in page_pool_is_last_frag()
  page_pool: remove PP_FLAG_PAGE_FRAG
  page_pool: introduce page_pool[_cache]_alloc() API
  page_pool: update document about frag API
  net: veth: use newly added page pool API for veth with xdp

 Documentation/networking/page_pool.rst        |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   2 -
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |   3 +-
 .../marvell/octeontx2/nic/otx2_common.c       |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   2 +-
 drivers/net/veth.c                            |  25 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c |   2 +-
 include/linux/mm_types.h                      |  13 +-
 include/net/page_pool/helpers.h               | 225 +++++++++++++++---
 include/net/page_pool/types.h                 |   6 +-
 net/core/page_pool.c                          |  31 ++-
 net/core/skbuff.c                             |   2 +-
 12 files changed, 240 insertions(+), 77 deletions(-)

-- 
2.33.0


