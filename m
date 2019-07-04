Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9879B5F1CF
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2019 05:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfGDDb0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Jul 2019 23:31:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726696AbfGDDb0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Jul 2019 23:31:26 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 45656930A83C8CE4AB25;
        Thu,  4 Jul 2019 11:31:23 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Thu, 4 Jul 2019 11:31:16 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Jassi Brar <jaswinder.singh@linaro.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jakub Kicinski" <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>
CC:     YueHaibing <yuehaibing@huawei.com>, <netdev@vger.kernel.org>,
        <xdp-newbies@vger.kernel.org>, <bpf@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH v3 net-next] net: socionext: remove set but not used variable 'pkts'
Date:   Thu, 4 Jul 2019 03:37:45 +0000
Message-ID: <20190704033745.1758-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190704032129.169282-1-yuehaibing@huawei.com>
References: <20190704032129.169282-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/ethernet/socionext/netsec.c: In function 'netsec_clean_tx_dring':
drivers/net/ethernet/socionext/netsec.c:637:15: warning:
 variable 'pkts' set but not used [-Wunused-but-set-variable]

It is not used since commit ba2b232108d3 ("net: netsec: add XDP support")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
v3: remove misplaced cc in patch log
v2: keep reverse christmas-tree ordering of the local variables
---
 drivers/net/ethernet/socionext/netsec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index 5544a722543f..d8d640b01119 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -634,15 +634,14 @@ static void netsec_set_rx_de(struct netsec_priv *priv,
 static bool netsec_clean_tx_dring(struct netsec_priv *priv)
 {
 	struct netsec_desc_ring *dring = &priv->desc_ring[NETSEC_RING_TX];
-	unsigned int pkts, bytes;
 	struct netsec_de *entry;
 	int tail = dring->tail;
+	unsigned int bytes;
 	int cnt = 0;
 
 	if (dring->is_xdp)
 		spin_lock(&dring->lock);
 
-	pkts = 0;
 	bytes = 0;
 	entry = dring->vaddr + DESC_SZ * tail;



