Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13385633432
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 04:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbiKVDup (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 22:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbiKVDuo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 22:50:44 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262272B182;
        Mon, 21 Nov 2022 19:50:42 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VVQAdoD_1669089039;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VVQAdoD_1669089039)
          by smtp.aliyun-inc.com;
          Tue, 22 Nov 2022 11:50:40 +0800
From:   Heng Qi <hengqi@linux.alibaba.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        John Fastabend <john.fastabend@gmail.com>, toke@kernel.org
Subject: [PATCH 1/2] Revert "bpf: veth driver panics when xdp prog attached before veth_open"
Date:   Tue, 22 Nov 2022 11:50:14 +0800
Message-Id: <20221122035015.19296-2-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20221122035015.19296-1-hengqi@linux.alibaba.com>
References: <20221122035015.19296-1-hengqi@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This reverts commit 5e5dc33d5dacb34b0165061bc5a10efd2fd3b66f.

This patch fixes the panic maked by 2e0de6366ac16. Now Paolo
and Toke suggest reverting the patch 2e0de6366ac16 and making
it stronger, so do this first.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/veth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 2a4592780141..b1ed5a93b6c5 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1125,7 +1125,7 @@ static int veth_enable_xdp(struct net_device *dev)
 	int err, i;
 
 	rq = &priv->rq[0];
-	napi_already_on = rcu_access_pointer(rq->napi);
+	napi_already_on = (dev->flags & IFF_UP) && rcu_access_pointer(rq->napi);
 
 	if (!xdp_rxq_info_is_reg(&priv->rq[0].xdp_rxq)) {
 		err = veth_enable_xdp_range(dev, 0, dev->real_num_rx_queues, napi_already_on);
-- 
2.19.1.6.gb485710b

