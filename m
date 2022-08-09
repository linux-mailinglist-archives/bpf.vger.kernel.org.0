Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8449558D303
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 06:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbiHIEtR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 00:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiHIEtQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 00:49:16 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07BBB1D32B;
        Mon,  8 Aug 2022 21:49:09 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.12.77.33])
        by mail-app2 (Coremail) with SMTP id by_KCgC3vvYY5_FiY7Z_Ag--.15876S4;
        Tue, 09 Aug 2022 12:48:24 +0800 (CST)
From:   Lin Ma <linma@zju.edu.cn>
To:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Lin Ma <linma@zju.edu.cn>
Subject: [PATCH v2] igb: Add lock to avoid data race
Date:   Tue,  9 Aug 2022 12:48:20 +0800
Message-Id: <20220809044820.2861-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: by_KCgC3vvYY5_FiY7Z_Ag--.15876S4
X-Coremail-Antispam: 1UD129KBjvJXoWxur4xCr13XF48ZrykuF17ZFb_yoWrZr1rpF
        4DX342yr10qF12qa97Xa18Ary3K3yrtrWfK3W3uw4F93Z8JryqqrWFyryjvFyFk393u3ZI
        yryDuw4fZ3WDAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvl1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The commit c23d92b80e0b ("igb: Teardown SR-IOV before
unregister_netdev()") places the unregister_netdev() call after the
igb_disable_sriov() call to avoid functionality issue.

However, it introduces several race conditions when detaching a device.
For example, when .remove() is called, the below interleaving leads to
use-after-free.

 (FREE from device detaching)      |   (USE from netdev core)
igb_remove                         |  igb_ndo_get_vf_config
 igb_disable_sriov                 |  vf >= adapter->vfs_allocated_count?
  kfree(adapter->vf_data)          |
  adapter->vfs_allocated_count = 0 |
                                   |    memcpy(... adapter->vf_data[vf]

Moreover, just as commit 1e53834ce541 ("ixgbe: Add locking to
prevent panic when setting sriov_numvfs to zero") shows. The
igb_disable_sriov function also need to watch out the requests from VF
driver.

To this end, this commit first eliminates the data races from netdev
core by using rtnl_lock (similar to commit 719479230893 ("dpaa2-eth: add
MAC/PHY support through phylink")). And then adds a spinlock just as
1d53834ce541 did.

Fixes: c23d92b80e0b ("igb: Teardown SR-IOV before unregister_netdev()")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
V1 -> V2:  fix typo in title idb -> igb
V0 -> V1:  change title from "Add rtnl_lock" to "Add lock"
           add additional spinlock as suggested by Jakub, according to
           1e53834ce541 ("ixgbe: Add locking to prevent panic when setting
           sriov_numvfs to zero")

 drivers/net/ethernet/intel/igb/igb.h      |  2 ++
 drivers/net/ethernet/intel/igb/igb_main.c | 12 +++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 2d3daf022651..015b78144114 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -664,6 +664,8 @@ struct igb_adapter {
 	struct igb_mac_addr *mac_table;
 	struct vf_mac_filter vf_macs;
 	struct vf_mac_filter *vf_mac_list;
+	/* lock for VF resources */
+	spinlock_t vfs_lock;
 };
 
 /* flags controlling PTP/1588 function */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index d8b836a85cc3..2796e81d2726 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3637,6 +3637,7 @@ static int igb_disable_sriov(struct pci_dev *pdev)
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
+	unsigned long flags;
 
 	/* reclaim resources allocated to VFs */
 	if (adapter->vf_data) {
@@ -3649,12 +3650,13 @@ static int igb_disable_sriov(struct pci_dev *pdev)
 			pci_disable_sriov(pdev);
 			msleep(500);
 		}
-
+		spin_lock_irqsave(&adapter->vfs_lock, flags);
 		kfree(adapter->vf_mac_list);
 		adapter->vf_mac_list = NULL;
 		kfree(adapter->vf_data);
 		adapter->vf_data = NULL;
 		adapter->vfs_allocated_count = 0;
+		spin_unlock_irqrestore(&adapter->vfs_lock, flags);
 		wr32(E1000_IOVCTL, E1000_IOVCTL_REUSE_VFQ);
 		wrfl();
 		msleep(100);
@@ -3814,7 +3816,9 @@ static void igb_remove(struct pci_dev *pdev)
 	igb_release_hw_control(adapter);
 
 #ifdef CONFIG_PCI_IOV
+	rtnl_lock();
 	igb_disable_sriov(pdev);
+	rtnl_unlock();
 #endif
 
 	unregister_netdev(netdev);
@@ -3974,6 +3978,9 @@ static int igb_sw_init(struct igb_adapter *adapter)
 
 	spin_lock_init(&adapter->nfc_lock);
 	spin_lock_init(&adapter->stats64_lock);
+
+	/* init spinlock to avoid concurrency of VF resources */
+	spin_lock_init(&adapter->vfs_lock);
 #ifdef CONFIG_PCI_IOV
 	switch (hw->mac.type) {
 	case e1000_82576:
@@ -7958,8 +7965,10 @@ static void igb_rcv_msg_from_vf(struct igb_adapter *adapter, u32 vf)
 static void igb_msg_task(struct igb_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
+	unsigned long flags;
 	u32 vf;
 
+	spin_lock_irqsave(&adapter->vfs_lock, flags);
 	for (vf = 0; vf < adapter->vfs_allocated_count; vf++) {
 		/* process any reset requests */
 		if (!igb_check_for_rst(hw, vf))
@@ -7973,6 +7982,7 @@ static void igb_msg_task(struct igb_adapter *adapter)
 		if (!igb_check_for_ack(hw, vf))
 			igb_rcv_ack_from_vf(adapter, vf);
 	}
+	spin_unlock_irqrestore(&adapter->vfs_lock, flags);
 }
 
 /**
-- 
2.36.1

