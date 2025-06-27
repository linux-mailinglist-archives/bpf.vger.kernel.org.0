Return-Path: <bpf+bounces-61775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D985DAEC0E4
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 22:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4D1188B81E
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 20:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C616D22331C;
	Fri, 27 Jun 2025 20:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Xh43A8AU"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AE6C2FB;
	Fri, 27 Jun 2025 20:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751056020; cv=none; b=qVZtzNu9cSR3+zzuMsYVgEjjHRqUaR0MHCvYLgR7SnTyzyFDSVpxoWqaHRhdq4l9DupGkkiepP6OR0ftG74IWcjLiCaQBbJXA1eV3p5Plte47IvG0aBe7D9Apu2JukcyJbrmmpan8UM+ZYXfanR1dCAcE0VdvB8ALaIdeEY9Zpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751056020; c=relaxed/simple;
	bh=Ly7QHnrYHlj29CgS16fNm7D2VWmARLszS4eebllMQ+4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=JrKwutrD5U46wnzIVuIIYXmQ9TtdF9IxivPEGmAapI6uoOBJg+GVuvVSM17+IWJ5NQ5ZFdBj4PIO1jVaDWnJbiAnixcnSPQRgrmy3ZfmNq3YhSxmBVzW7qas8vd14FFaHoEGBd5KKvOzy2QvihBVhK/5rmDm++C6b6QQJB/+/ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Xh43A8AU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id 222572124E1F; Fri, 27 Jun 2025 13:26:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 222572124E1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751056018;
	bh=my06lgKPXwPZ/xB18tm4IOWlQUpbE/MSYOljLFPEQfs=;
	h=From:To:Cc:Subject:Date:From;
	b=Xh43A8AUcojnhDBF0uGXR127LWbH1rx91bRl7p1p1zPLoT7hTwL504YMDAfXG/jQB
	 w89C8AGQ695PtAgSLWxYIaCQc4MPxmPMvIMT1XSJm90U3wLuzp8VQinihx6jnbgFhv
	 cv0hb7D4DYtfNmhGoHEw/pmJIOtnqmAWoAB5Q6is=
From: Haiyang Zhang <haiyangz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	decui@microsoft.com,
	stephen@networkplumber.org,
	kys@microsoft.com,
	paulros@microsoft.com,
	olaf@aepfle.de,
	vkuznets@redhat.com,
	davem@davemloft.net,
	wei.liu@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	leon@kernel.org,
	longli@microsoft.com,
	ssengar@linux.microsoft.com,
	linux-rdma@vger.kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	ast@kernel.org,
	hawk@kernel.org,
	tglx@linutronix.de,
	shradhagupta@linux.microsoft.com,
	andrew+netdev@lunn.ch,
	kotaranov@microsoft.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: mana: Handle Reset Request from MANA NIC
Date: Fri, 27 Jun 2025 13:26:23 -0700
Message-Id: <1751055983-29760-1-git-send-email-haiyangz@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

From: Haiyang Zhang <haiyangz@microsoft.com>

Upon receiving the Reset Request, pause the connection and clean up
queues, wait for the specified period, then resume the NIC.
In the cleanup phase, the HWC is no longer responding, so set hwc_timeout
to zero to skip waiting on the response.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 127 ++++++++++++++----
 .../net/ethernet/microsoft/mana/hw_channel.c  |   4 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c |  37 +++--
 include/net/mana/gdma.h                       |  10 ++
 4 files changed, 143 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index ac2f39853bf4..4e344ff44ac1 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -10,6 +10,7 @@
 #include <linux/irqdomain.h>
 
 #include <net/mana/mana.h>
+#include <net/mana/hw_channel.h>
 
 struct dentry *mana_debugfs_root;
 
@@ -65,6 +66,24 @@ static void mana_gd_init_registers(struct pci_dev *pdev)
 		mana_gd_init_vf_regs(pdev);
 }
 
+/* Suppress logging when we set timeout to zero */
+bool mana_need_log(struct gdma_context *gc, int err)
+{
+	struct hw_channel_context *hwc;
+
+	if (err != -ETIMEDOUT)
+		return true;
+
+	if (!gc)
+		return true;
+
+	hwc = gc->hwc.driver_data;
+	if (hwc && hwc->hwc_timeout == 0)
+		return false;
+
+	return true;
+}
+
 static int mana_gd_query_max_resources(struct pci_dev *pdev)
 {
 	struct gdma_context *gc = pci_get_drvdata(pdev);
@@ -275,8 +294,9 @@ static int mana_gd_disable_queue(struct gdma_queue *queue)
 
 	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
 	if (err || resp.hdr.status) {
-		dev_err(gc->dev, "Failed to disable queue: %d, 0x%x\n", err,
-			resp.hdr.status);
+		if (mana_need_log(gc, err))
+			dev_err(gc->dev, "Failed to disable queue: %d, 0x%x\n", err,
+				resp.hdr.status);
 		return err ? err : -EPROTO;
 	}
 
@@ -363,25 +383,12 @@ EXPORT_SYMBOL_NS(mana_gd_ring_cq, "NET_MANA");
 
 #define MANA_SERVICE_PERIOD 10
 
-struct mana_serv_work {
-	struct work_struct serv_work;
-	struct pci_dev *pdev;
-};
-
-static void mana_serv_func(struct work_struct *w)
+static void mana_serv_fpga(struct pci_dev *pdev)
 {
-	struct mana_serv_work *mns_wk;
 	struct pci_bus *bus, *parent;
-	struct pci_dev *pdev;
-
-	mns_wk = container_of(w, struct mana_serv_work, serv_work);
-	pdev = mns_wk->pdev;
 
 	pci_lock_rescan_remove();
 
-	if (!pdev)
-		goto out;
-
 	bus = pdev->bus;
 	if (!bus) {
 		dev_err(&pdev->dev, "MANA service: no bus\n");
@@ -402,7 +409,74 @@ static void mana_serv_func(struct work_struct *w)
 
 out:
 	pci_unlock_rescan_remove();
+}
+
+static void mana_serv_reset(struct pci_dev *pdev)
+{
+	struct gdma_context *gc = pci_get_drvdata(pdev);
+	struct hw_channel_context *hwc;
+
+	if (!gc) {
+		dev_err(&pdev->dev, "MANA service: no GC\n");
+		return;
+	}
+
+	hwc = gc->hwc.driver_data;
+	if (!hwc) {
+		dev_err(&pdev->dev, "MANA service: no HWC\n");
+		goto out;
+	}
+
+	/* HWC is not responding in this case, so don't wait */
+	hwc->hwc_timeout = 0;
+
+	dev_info(&pdev->dev, "MANA reset cycle start\n");
 
+	mana_gd_suspend(pdev, PMSG_SUSPEND);
+
+	msleep(MANA_SERVICE_PERIOD * 1000);
+
+	mana_gd_resume(pdev);
+
+	dev_info(&pdev->dev, "MANA reset cycle completed\n");
+
+out:
+	gc->in_service = false;
+}
+
+struct mana_serv_work {
+	struct work_struct serv_work;
+	struct pci_dev *pdev;
+	enum gdma_eqe_type type;
+};
+
+static void mana_serv_func(struct work_struct *w)
+{
+	struct mana_serv_work *mns_wk;
+	struct pci_dev *pdev;
+
+	mns_wk = container_of(w, struct mana_serv_work, serv_work);
+	pdev = mns_wk->pdev;
+
+	if (!pdev)
+		goto out;
+
+	switch (mns_wk->type) {
+	case GDMA_EQE_HWC_FPGA_RECONFIG:
+		mana_serv_fpga(pdev);
+		break;
+
+	case GDMA_EQE_HWC_RESET_REQUEST:
+		mana_serv_reset(pdev);
+		break;
+
+	default:
+		dev_err(&pdev->dev, "MANA service: unknown type %d\n",
+			mns_wk->type);
+		break;
+	}
+
+out:
 	pci_dev_put(pdev);
 	kfree(mns_wk);
 	module_put(THIS_MODULE);
@@ -459,6 +533,7 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
 		break;
 
 	case GDMA_EQE_HWC_FPGA_RECONFIG:
+	case GDMA_EQE_HWC_RESET_REQUEST:
 		dev_info(gc->dev, "Recv MANA service type:%d\n", type);
 
 		if (gc->in_service) {
@@ -480,6 +555,7 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
 		dev_info(gc->dev, "Start MANA service type:%d\n", type);
 		gc->in_service = true;
 		mns_wk->pdev = to_pci_dev(gc->dev);
+		mns_wk->type = type;
 		pci_dev_get(mns_wk->pdev);
 		INIT_WORK(&mns_wk->serv_work, mana_serv_func);
 		schedule_work(&mns_wk->serv_work);
@@ -631,7 +707,8 @@ int mana_gd_test_eq(struct gdma_context *gc, struct gdma_queue *eq)
 
 	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
 	if (err) {
-		dev_err(dev, "test_eq failed: %d\n", err);
+		if (mana_need_log(gc, err))
+			dev_err(dev, "test_eq failed: %d\n", err);
 		goto out;
 	}
 
@@ -666,7 +743,7 @@ static void mana_gd_destroy_eq(struct gdma_context *gc, bool flush_evenets,
 
 	if (flush_evenets) {
 		err = mana_gd_test_eq(gc, queue);
-		if (err)
+		if (err && mana_need_log(gc, err))
 			dev_warn(gc->dev, "Failed to flush EQ: %d\n", err);
 	}
 
@@ -812,8 +889,9 @@ int mana_gd_destroy_dma_region(struct gdma_context *gc, u64 dma_region_handle)
 
 	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
 	if (err || resp.hdr.status) {
-		dev_err(gc->dev, "Failed to destroy DMA region: %d, 0x%x\n",
-			err, resp.hdr.status);
+		if (mana_need_log(gc, err))
+			dev_err(gc->dev, "Failed to destroy DMA region: %d, 0x%x\n",
+				err, resp.hdr.status);
 		return -EPROTO;
 	}
 
@@ -1113,8 +1191,9 @@ int mana_gd_deregister_device(struct gdma_dev *gd)
 
 	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
 	if (err || resp.hdr.status) {
-		dev_err(gc->dev, "Failed to deregister device: %d, 0x%x\n",
-			err, resp.hdr.status);
+		if (mana_need_log(gc, err))
+			dev_err(gc->dev, "Failed to deregister device: %d, 0x%x\n",
+				err, resp.hdr.status);
 		if (!err)
 			err = -EPROTO;
 	}
@@ -1912,7 +1991,7 @@ static void mana_gd_remove(struct pci_dev *pdev)
 }
 
 /* The 'state' parameter is not used. */
-static int mana_gd_suspend(struct pci_dev *pdev, pm_message_t state)
+int mana_gd_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 
@@ -1928,7 +2007,7 @@ static int mana_gd_suspend(struct pci_dev *pdev, pm_message_t state)
  * fail -- if this happens, it's safer to just report an error than try to undo
  * what has been done.
  */
-static int mana_gd_resume(struct pci_dev *pdev)
+int mana_gd_resume(struct pci_dev *pdev)
 {
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 	int err;
diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index 650d22654d49..ef072e24c46d 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -880,7 +880,9 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 
 	if (!wait_for_completion_timeout(&ctx->comp_event,
 					 (msecs_to_jiffies(hwc->hwc_timeout)))) {
-		dev_err(hwc->dev, "HWC: Request timed out!\n");
+		if (hwc->hwc_timeout != 0)
+			dev_err(hwc->dev, "HWC: Request timed out!\n");
+
 		err = -ETIMEDOUT;
 		goto out;
 	}
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 016fd808ccad..a7973651ae51 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -47,6 +47,15 @@ static const struct file_operations mana_dbg_q_fops = {
 	.read   = mana_dbg_q_read,
 };
 
+static bool mana_en_need_log(struct mana_port_context *apc, int err)
+{
+	if (apc && apc->ac && apc->ac->gdma_dev &&
+	    apc->ac->gdma_dev->gdma_context)
+		return mana_need_log(apc->ac->gdma_dev->gdma_context, err);
+	else
+		return true;
+}
+
 /* Microsoft Azure Network Adapter (MANA) functions */
 
 static int mana_open(struct net_device *ndev)
@@ -854,7 +863,8 @@ static int mana_send_request(struct mana_context *ac, void *in_buf,
 		if (err == -EOPNOTSUPP)
 			return err;
 
-		if (req->req.msg_type != MANA_QUERY_PHY_STAT)
+		if (req->req.msg_type != MANA_QUERY_PHY_STAT &&
+		    mana_need_log(gc, err))
 			dev_err(dev, "Failed to send mana message: %d, 0x%x\n",
 				err, resp->status);
 		return err ? err : -EPROTO;
@@ -931,8 +941,10 @@ static void mana_pf_deregister_hw_vport(struct mana_port_context *apc)
 	err = mana_send_request(apc->ac, &req, sizeof(req), &resp,
 				sizeof(resp));
 	if (err) {
-		netdev_err(apc->ndev, "Failed to unregister hw vPort: %d\n",
-			   err);
+		if (mana_en_need_log(apc, err))
+			netdev_err(apc->ndev, "Failed to unregister hw vPort: %d\n",
+				   err);
+
 		return;
 	}
 
@@ -987,8 +999,10 @@ static void mana_pf_deregister_filter(struct mana_port_context *apc)
 	err = mana_send_request(apc->ac, &req, sizeof(req), &resp,
 				sizeof(resp));
 	if (err) {
-		netdev_err(apc->ndev, "Failed to unregister filter: %d\n",
-			   err);
+		if (mana_en_need_log(apc, err))
+			netdev_err(apc->ndev, "Failed to unregister filter: %d\n",
+				   err);
+
 		return;
 	}
 
@@ -1218,7 +1232,9 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
 	err = mana_send_request(apc->ac, req, req_buf_size, &resp,
 				sizeof(resp));
 	if (err) {
-		netdev_err(ndev, "Failed to configure vPort RX: %d\n", err);
+		if (mana_en_need_log(apc, err))
+			netdev_err(ndev, "Failed to configure vPort RX: %d\n", err);
+
 		goto out;
 	}
 
@@ -1402,7 +1418,9 @@ void mana_destroy_wq_obj(struct mana_port_context *apc, u32 wq_type,
 	err = mana_send_request(apc->ac, &req, sizeof(req), &resp,
 				sizeof(resp));
 	if (err) {
-		netdev_err(ndev, "Failed to destroy WQ object: %d\n", err);
+		if (mana_en_need_log(apc, err))
+			netdev_err(ndev, "Failed to destroy WQ object: %d\n", err);
+
 		return;
 	}
 
@@ -3067,11 +3085,10 @@ static int mana_dealloc_queues(struct net_device *ndev)
 
 	apc->rss_state = TRI_STATE_FALSE;
 	err = mana_config_rss(apc, TRI_STATE_FALSE, false, false);
-	if (err) {
+	if (err && mana_en_need_log(apc, err))
 		netdev_err(ndev, "Failed to disable vPort: %d\n", err);
-		return err;
-	}
 
+	/* Even in err case, still need to cleanup the vPort */
 	mana_destroy_vport(apc);
 
 	return 0;
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 92ab85061df0..57df78cfbf82 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -62,6 +62,7 @@ enum gdma_eqe_type {
 	GDMA_EQE_HWC_FPGA_RECONFIG	= 132,
 	GDMA_EQE_HWC_SOC_RECONFIG_DATA	= 133,
 	GDMA_EQE_HWC_SOC_SERVICE	= 134,
+	GDMA_EQE_HWC_RESET_REQUEST	= 135,
 	GDMA_EQE_RNIC_QP_FATAL		= 176,
 };
 
@@ -584,6 +585,9 @@ enum {
 /* Driver supports dynamic MSI-X vector allocation */
 #define GDMA_DRV_CAP_FLAG_1_DYNAMIC_IRQ_ALLOC_SUPPORT BIT(13)
 
+/* Driver can self reset on EQE notification */
+#define GDMA_DRV_CAP_FLAG_1_SELF_RESET_ON_EQE BIT(14)
+
 /* Driver can self reset on FPGA Reconfig EQE notification */
 #define GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE BIT(17)
 
@@ -594,6 +598,7 @@ enum {
 	 GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT | \
 	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP | \
 	 GDMA_DRV_CAP_FLAG_1_DYNAMIC_IRQ_ALLOC_SUPPORT | \
+	 GDMA_DRV_CAP_FLAG_1_SELF_RESET_ON_EQE | \
 	 GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE)
 
 #define GDMA_DRV_CAP_FLAGS2 0
@@ -921,4 +926,9 @@ void mana_unregister_debugfs(void);
 
 int mana_rdma_service_event(struct gdma_context *gc, enum gdma_service_type event);
 
+int mana_gd_suspend(struct pci_dev *pdev, pm_message_t state);
+int mana_gd_resume(struct pci_dev *pdev);
+
+bool mana_need_log(struct gdma_context *gc, int err);
+
 #endif /* _GDMA_H */
-- 
2.34.1


