Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7E447A393
	for <lists+bpf@lfdr.de>; Mon, 20 Dec 2021 03:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbhLTCS1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Dec 2021 21:18:27 -0500
Received: from smtp23.cstnet.cn ([159.226.251.23]:33028 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237200AbhLTCS0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Dec 2021 21:18:26 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-03 (Coremail) with SMTP id rQCowADX3S3S579hCULiAw--.4507S2;
        Mon, 20 Dec 2021 10:17:55 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com,
        davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        kpsingh@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v3] sfc: potential dereference null pointer of rx_queue->page_ring
Date:   Mon, 20 Dec 2021 10:17:53 +0800
Message-Id: <20211220021753.723161-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADX3S3S579hCULiAw--.4507S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWUAw17KFWxJr1xJF1rXrb_yoW8ZFWkpa
        1xK347ua1ktw45Xas7Cw4kZF98JasxtFWxWrySk3yrZwn5AF15ZrsrtFW5uF4vyrWDWF42
        yrWUZFnIyF4DJwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
        4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
        628vn2kIc2xKxwCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0D
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x0JUmLvtUUUUU=
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The return value of kcalloc() needs to be checked.
To avoid dereference of null pointer in case of the failure of alloc,
such as efx_fini_rx_recycle_ring().
Therefore, it should be better to change the definition of page_ptr_mask
to signed int and then assign the page_ptr_mask to -1 when page_ring is
NULL, in order to avoid the use in the loop.

Fixes: 3d95b884392f ("sfc: move more rx code")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog:

v2 -> v3

*Change 1. Casade return -ENOMEM when alloc fails and deal with the
error.
*Change 2. Set size to -1 instead of return error.
---
 drivers/net/ethernet/sfc/net_driver.h | 2 +-
 drivers/net/ethernet/sfc/rx_common.c  | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 9b4b25704271..beba3e0a6027 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -407,7 +407,7 @@ struct efx_rx_queue {
 	unsigned int page_recycle_count;
 	unsigned int page_recycle_failed;
 	unsigned int page_recycle_full;
-	unsigned int page_ptr_mask;
+	int page_ptr_mask;
 	unsigned int max_fill;
 	unsigned int fast_fill_trigger;
 	unsigned int min_fill;
diff --git a/drivers/net/ethernet/sfc/rx_common.c b/drivers/net/ethernet/sfc/rx_common.c
index 68fc7d317693..d9d0a5805f1c 100644
--- a/drivers/net/ethernet/sfc/rx_common.c
+++ b/drivers/net/ethernet/sfc/rx_common.c
@@ -150,7 +150,10 @@ static void efx_init_rx_recycle_ring(struct efx_rx_queue *rx_queue)
 					    efx->rx_bufs_per_page);
 	rx_queue->page_ring = kcalloc(page_ring_size,
 				      sizeof(*rx_queue->page_ring), GFP_KERNEL);
-	rx_queue->page_ptr_mask = page_ring_size - 1;
+	if (!rx_queue->page_ring)
+		rx_queue->page_ptr_mask = -1;
+	else
+		rx_queue->page_ptr_mask = page_ring_size - 1;
 }
 
 static void efx_fini_rx_recycle_ring(struct efx_rx_queue *rx_queue)
-- 
2.25.1

