Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 867251A5B6C
	for <lists+bpf@lfdr.de>; Sun, 12 Apr 2020 01:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgDKXDu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Apr 2020 19:03:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgDKXDt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Apr 2020 19:03:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A97F320787;
        Sat, 11 Apr 2020 23:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646229;
        bh=ruELdCIwIsG51HM10SRoF+WDAbU0xuAVNAScsbo5bxc=;
        h=From:To:Cc:Subject:Date:From;
        b=O0zU2ODGELY6aXDAUBMEERTwwk6D8jRgeswk1h6VqSP6Z2YOSDk8GE/S/1swu05s0
         XX7XTvpdF9P/3pvX7v8N9k0BjWdhuCZwhAKwG/deZkaKLK6ihaFhlXVWn+IpsdQj86
         sNBxfgsGqlNAaPx+GKd1x1GpqAPUuzEzlc2WFht4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 001/149] net: hns3: drop the WQ_MEM_RECLAIM flag when allocating WQ
Date:   Sat, 11 Apr 2020 19:01:18 -0400
Message-Id: <20200411230347.22371-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

[ Upstream commit 16deaef205b6da832f88a98770c55c8b85aaadfa ]

The WQ in hns3 driver is allocated with WQ_MEM_RECLAIM flag
in order to guarantee forward progress, which may cause hns3'
WQ_MEM_RECLAIM WQ flushing infiniband' !WQ_MEM_RECLAIM WQ
warning:

[11246.200168] hns3 0000:bd:00.1: Reset done, hclge driver initialization finished.
[11246.209979] hns3 0000:bd:00.1 eth7: net open
[11246.227608] ------------[ cut here ]------------
[11246.237370] workqueue: WQ_MEM_RECLAIM hclge:hclge_service_task [hclge] is flushing !WQ_MEM_RECLAIM infiniband:0x0
[11246.237391] WARNING: CPU: 50 PID: 2279 at ./kernel/workqueue.c:2605 check_flush_dependency+0xcc/0x140
[11246.260412] Modules linked in: hclgevf hns_roce_hw_v2 rdma_test(O) hns3 xt_CHECKSUM iptable_mangle xt_conntrack ipt_REJECT nf_reject_ipv4 ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter bpfilter vfio_iommu_type1 vfio_pci vfio_virqfd vfio ib_isert iscsi_target_mod ib_ipoib ib_umad rpcrdma ib_iser libiscsi scsi_transport_iscsi aes_ce_blk crypto_simd cryptd aes_ce_cipher sunrpc nls_iso8859_1 crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce joydev input_leds hid_generic usbkbd usbmouse sbsa_gwdt usbhid usb_storage hid ses hclge hisi_zip hisi_hpre hisi_sec2 hnae3 hisi_qm ahci hisi_trng_v2 evbug uacce rng_core gpio_dwapb autofs4 hisi_sas_v3_hw megaraid_sas hisi_sas_main libsas scsi_transport_sas [last unloaded: hns_roce_hw_v2]
[11246.325742] CPU: 50 PID: 2279 Comm: kworker/50:0 Kdump: loaded Tainted: G           O      5.4.0-rc4+ #1
[11246.335181] Hardware name: Huawei TaiShan 200 (Model 2280)/BC82AMDD, BIOS 2280-V2 CS V3.B140.01 12/18/2019
[11246.344802] Workqueue: hclge hclge_service_task [hclge]
[11246.350007] pstate: 60c00009 (nZCv daif +PAN +UAO)
[11246.354779] pc : check_flush_dependency+0xcc/0x140
[11246.359549] lr : check_flush_dependency+0xcc/0x140
[11246.364317] sp : ffff800268a73990
[11246.367618] x29: ffff800268a73990 x28: 0000000000000001
[11246.372907] x27: ffffcbe4f5868000 x26: ffffcbe4f5541000
[11246.378196] x25: 00000000000000b8 x24: ffff002fdd0ff868
[11246.383483] x23: ffff002fdd0ff800 x22: ffff2027401ba600
[11246.388770] x21: 0000000000000000 x20: ffff002fdd0ff800
[11246.394059] x19: ffff202719293b00 x18: ffffcbe4f5541948
[11246.399347] x17: 000000006f8ad8dd x16: 0000000000000002
[11246.404634] x15: ffff8002e8a734f7 x14: 6c66207369205d65
[11246.409922] x13: 676c63685b206b73 x12: 61745f6563697672
[11246.415208] x11: 65735f65676c6368 x10: 3a65676c6368204d
[11246.420494] x9 : 49414c4345525f4d x8 : 6e6162696e69666e
[11246.425782] x7 : 69204d49414c4345 x6 : ffffcbe4f5765145
[11246.431068] x5 : 0000000000000000 x4 : 0000000000000000
[11246.436355] x3 : 0000000000000030 x2 : 00000000ffffffff
[11246.441642] x1 : 3349eb1ac5310100 x0 : 0000000000000000
[11246.446928] Call trace:
[11246.449363]  check_flush_dependency+0xcc/0x140
[11246.453785]  flush_workqueue+0x110/0x410
[11246.457691]  ib_cache_cleanup_one+0x54/0x468
[11246.461943]  __ib_unregister_device+0x70/0xa8
[11246.466279]  ib_unregister_device+0x2c/0x40
[11246.470455]  hns_roce_exit+0x34/0x198 [hns_roce_hw_v2]
[11246.475571]  __hns_roce_hw_v2_uninit_instance.isra.56+0x3c/0x58 [hns_roce_hw_v2]
[11246.482934]  hns_roce_hw_v2_reset_notify+0xd8/0x210 [hns_roce_hw_v2]
[11246.489261]  hclge_notify_roce_client+0x84/0xe0 [hclge]
[11246.494464]  hclge_reset_rebuild+0x60/0x730 [hclge]
[11246.499320]  hclge_reset_service_task+0x400/0x5a0 [hclge]
[11246.504695]  hclge_service_task+0x54/0x698 [hclge]
[11246.509464]  process_one_work+0x15c/0x458
[11246.513454]  worker_thread+0x144/0x520
[11246.517186]  kthread+0xfc/0x128
[11246.520314]  ret_from_fork+0x10/0x18
[11246.523873] ---[ end trace eb980723699c2585 ]---
[11246.528710] hns3 0000:bd:00.2: Func clear success after reset.
[11246.528747] hns3 0000:bd:00.0: Func clear success after reset.
[11246.907710] hns3 0000:bd:00.1 eth7: link up

According to [1] and [2]:

There seems to be no specific guidance about how to handling the
forward progress guarantee of network device's WQ yet, and other
network device's WQ seem to be marked with WQ_MEM_RECLAIM without
a clear reason.

So this patch removes the WQ_MEM_RECLAIM flag when allocating WQ
to aviod the above warning.

1. https://www.spinics.net/lists/netdev/msg631646.html
2. https://www.spinics.net/lists/netdev/msg632097.html

Fixes: 0ea68902256e ("net: hns3: allocate WQ with WQ_MEM_RECLAIM flag")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index d3b0cd74ecd23..b3518070306b1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -10666,7 +10666,7 @@ static int hclge_init(void)
 {
 	pr_info("%s is initializing\n", HCLGE_NAME);
 
-	hclge_wq = alloc_workqueue("%s", WQ_MEM_RECLAIM, 0, HCLGE_NAME);
+	hclge_wq = alloc_workqueue("%s", 0, 0, HCLGE_NAME);
 	if (!hclge_wq) {
 		pr_err("%s: failed to create workqueue\n", HCLGE_NAME);
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 0510d85a7f6ae..3c58f0bbaebff 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -3188,7 +3188,7 @@ static int hclgevf_init(void)
 {
 	pr_info("%s is initializing\n", HCLGEVF_NAME);
 
-	hclgevf_wq = alloc_workqueue("%s", WQ_MEM_RECLAIM, 0, HCLGEVF_NAME);
+	hclgevf_wq = alloc_workqueue("%s", 0, 0, HCLGEVF_NAME);
 	if (!hclgevf_wq) {
 		pr_err("%s: failed to create workqueue\n", HCLGEVF_NAME);
 		return -ENOMEM;
-- 
2.20.1

