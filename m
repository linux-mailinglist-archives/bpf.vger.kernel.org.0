Return-Path: <bpf+bounces-21222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA23D849ADE
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 13:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7DE1C21116
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 12:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BC01CAB1;
	Mon,  5 Feb 2024 12:46:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690911CA96;
	Mon,  5 Feb 2024 12:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137162; cv=none; b=iAYIUEU+Tjfw3HQsuW0RI45hpunvqcG1Sz56K3g0fqMqzQ5C//VYOfvahiVc9bXWL0qioidZoQB1PC6XjoUk/ZBPiRBkmFSKOM2WC8fAOTTrrAPwt4bSd/74Q5m8d3SDJUpsoKdBNlePvFl92+lgaUFBpl/HRpyx3qtLgqk+4qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137162; c=relaxed/simple;
	bh=K9NQ711AaThaChaubLcbYB35dUqY9bQKxxkjG43DOjk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s53dn5LEdCLrk5zeH/Ily4vEL98BTajz5SmsqaBxUy4izXUpM+3cAOv6h0JEtmnpyQoceOL9DPLjh0fqH6SIpOCXNwUrnlcD6jEOj6U3VuIWnQZKdHG5pCtVoHtuDOjcy9nevlkv02IacU+I59XYuv3Fr3ha7kKK053DEWTyJ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TT5fS6XRvz29gPR;
	Mon,  5 Feb 2024 20:44:00 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id CF306180060;
	Mon,  5 Feb 2024 20:45:55 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 20:45:55 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<bpf@vger.kernel.org>
Subject: [PATCH net-next v5 0/5] remove page frag implementation in vhost_net
Date: Mon, 5 Feb 2024 20:45:00 +0800
Message-ID: <20240205124506.57670-1-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)

Currently there are three implementations for page frag:

1. mm/page_alloc.c: net stack seems to be using it in the
   rx part with 'struct page_frag_cache' and the main API
   being page_frag_alloc_align().
2. net/core/sock.c: net stack seems to be using it in the
   tx part with 'struct page_frag' and the main API being
   skb_page_frag_refill().
3. drivers/vhost/net.c: vhost seems to be using it to build
   xdp frame, and it's implementation seems to be a mix of
   the above two.

This patchset tries to unfiy the page frag implementation a
little bit by unifying gfp bit for order 3 page allocation
and replacing page frag implementation in vhost.c with the
one in page_alloc.c.

After this patchset, we are not only able to unify the page
frag implementation a little, but also able to have about
0.5% performance boost testing by using the vhost_net_test
introduced in the last patch.

Before this patchset:
Performance counter stats for './vhost_net_test' (10 runs):

     305325.78 msec task-clock                       #    1.738 CPUs utilized               ( +-  0.12% )
       1048668      context-switches                 #    3.435 K/sec                       ( +-  0.00% )
            11      cpu-migrations                   #    0.036 /sec                        ( +- 17.64% )
            33      page-faults                      #    0.108 /sec                        ( +-  0.49% )
  244651819491      cycles                           #    0.801 GHz                         ( +-  0.43% )  (64)
   64714638024      stalled-cycles-frontend          #   26.45% frontend cycles idle        ( +-  2.19% )  (67)
   30774313491      stalled-cycles-backend           #   12.58% backend cycles idle         ( +-  7.68% )  (70)
  201749748680      instructions                     #    0.82  insn per cycle
                                              #    0.32  stalled cycles per insn     ( +-  0.41% )  (66.76%)
   65494787909      branches                         #  214.508 M/sec                       ( +-  0.35% )  (64)
    4284111313      branch-misses                    #    6.54% of all branches             ( +-  0.45% )  (66)

       175.699 +- 0.189 seconds time elapsed  ( +-  0.11% )


After this patchset:
Performance counter stats for './vhost_net_test' (10 runs):

     303974.38 msec task-clock                       #    1.739 CPUs utilized               ( +-  0.14% )
       1048807      context-switches                 #    3.450 K/sec                       ( +-  0.00% )
            14      cpu-migrations                   #    0.046 /sec                        ( +- 12.86% )
            33      page-faults                      #    0.109 /sec                        ( +-  0.46% )
  251289376347      cycles                           #    0.827 GHz                         ( +-  0.32% )  (60)
   67885175415      stalled-cycles-frontend          #   27.01% frontend cycles idle        ( +-  0.48% )  (63)
   27809282600      stalled-cycles-backend           #   11.07% backend cycles idle         ( +-  0.36% )  (71)
  195543234672      instructions                     #    0.78  insn per cycle
                                              #    0.35  stalled cycles per insn     ( +-  0.29% )  (69.04%)
   62423183552      branches                         #  205.357 M/sec                       ( +-  0.48% )  (67)
    4135666632      branch-misses                    #    6.63% of all branches             ( +-  0.63% )  (67)

       174.764 +- 0.214 seconds time elapsed  ( +-  0.12% )

Changelog:
V5: Address the comment from jason in vhost_net_test.c and the
    comment about leaving out the gfp change for page frag in
    sock.c as suggested by Paolo.

V4: Resend based on latest net-next branch.

V3:
1. Add __page_frag_alloc_align() which is passed with the align mask
   the original function expected as suggested by Alexander.
2. Drop patch 3 in v2 suggested by Alexander.
3. Reorder patch 4 & 5 in v2 suggested by Alexander.

Note that placing this gfp flags handing for order 3 page in an inline
function is not considered, as we may be able to unify the page_frag
and page_frag_cache handling.

V2: Change 'xor'd' to 'masked off', add vhost tx testing for
    vhost_net_test.

V1: Fix some typo, drop RFC tag and rebase on latest net-next.


Yunsheng Lin (5):
  mm/page_alloc: modify page_frag_alloc_align() to accept align as an
    argument
  page_frag: unify gfp bits for order 3 page allocation
  net: introduce page_frag_cache_drain()
  vhost/net: remove vhost_net_page_frag_refill()
  tools: virtio: introduce vhost_net_test

 drivers/net/ethernet/google/gve/gve_main.c |  11 +-
 drivers/net/ethernet/mediatek/mtk_wed_wo.c |  17 +-
 drivers/nvme/host/tcp.c                    |   7 +-
 drivers/nvme/target/tcp.c                  |   4 +-
 drivers/vhost/net.c                        |  91 ++--
 include/linux/gfp.h                        |  16 +-
 mm/page_alloc.c                            |  22 +-
 net/core/skbuff.c                          |   9 +-
 tools/virtio/.gitignore                    |   1 +
 tools/virtio/Makefile                      |   8 +-
 tools/virtio/linux/virtio_config.h         |   4 +
 tools/virtio/vhost_net_test.c              | 536 +++++++++++++++++++++
 12 files changed, 613 insertions(+), 113 deletions(-)
 create mode 100644 tools/virtio/vhost_net_test.c

-- 
2.33.0


