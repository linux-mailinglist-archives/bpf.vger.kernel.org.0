Return-Path: <bpf+bounces-60615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3D6AD935E
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 19:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D3E18939F7
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 17:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07191221727;
	Fri, 13 Jun 2025 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lBOWq48e"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05642E11B3;
	Fri, 13 Jun 2025 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749834054; cv=none; b=VFWnf5YgeiZZonszRlvi2pgA1wvFKAr1a8DDHQnnZXggjRr3XmxTuyXGGlcW+1gd2aCo0oq2+eL8Ku99bF0XgAZKMuY1Sr78zEpCtNQ6q1B1aEPjFADLBYUN3CcUOhjOuWikmtNLOM68YeU90TPmJk72e4E2GV7JMBb+gzNYVOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749834054; c=relaxed/simple;
	bh=KX7jK6qf6Ts4XzWAWHyDvYIzeWB/bWHJ2NGXsH7w4ew=;
	h=From:To:Cc:Subject:Date:Message-Id; b=AqaiJxUKAqlEBUQEfpyZKI0TZlvMM5+RDuEqQudVgoPMn4aYHZBvPJDDiyVBcXaoAuqZBo4CYUo3X0j+b9q5kueY4ZAflt4eFsQweaRKuYgilnxLzxx176TXA3ye5tchz8/opcUMJTKBrfAjTdk6hhy0vk/cRZAvfttEUgrZYbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lBOWq48e; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id 1FFA221175A7; Fri, 13 Jun 2025 10:00:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1FFA221175A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749834046;
	bh=8UhqfepXfhCvXH0+pdx3UWMlC1815qt8SHGEMAi8/AU=;
	h=From:To:Cc:Subject:Date:From;
	b=lBOWq48eaQ46TlT8vkleg6fGvOgaY1k1pdulzf6epLjPtwWbIUtRnBKCD3cMdqX8u
	 ZrltlAa6Aial2EOaquS6kFYEJ/bhposC7A18s8Ko/Wf+t+w71RKp+fXHxumb1bQAgs
	 tE359RaFP5w2vPnWyWUgAPyzLn13FnfPgX+URoN8=
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
Subject: [PATCH net-next,v8] net: mana: Add handler for hardware servicing events
Date: Fri, 13 Jun 2025 10:00:34 -0700
Message-Id: <1749834034-18498-1-git-send-email-haiyangz@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

From: Haiyang Zhang <haiyangz@microsoft.com>

To collaborate with hardware servicing events, upon receiving the special
EQE notification from the HW channel, remove the devices on this bus.
Then, after a waiting period based on the device specs, rescan the parent
bus to recover the devices.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v8:
Tested rmmod as suggested by Jakub Kicinski, and found it's necessary to
add back: acquiring module refcnt.

v7:
rebased.

v6:
Not acquiring module refcnt as suggested by Paolo Abeni.

v5:
Get refcnt of the pdev struct to avoid removal before running the work
as suggested by Jakub Kicinski.

v4:
Renamed EQE type 135 to GDMA_EQE_HWC_RESET_REQUEST, since there can
be multiple cases of this reset request.

v3:
Updated for checkpatch warnings as suggested by Simon Horman.

v2:
Added dev_dbg for service type as suggested by Shradha Gupta.
Added driver cap bit.
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 75 +++++++++++++++++++
 include/net/mana/gdma.h                       | 10 ++-
 2 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 3504507477c6..069b7a871b78 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -352,11 +352,59 @@ void mana_gd_ring_cq(struct gdma_queue *cq, u8 arm_bit)
 }
 EXPORT_SYMBOL_NS(mana_gd_ring_cq, "NET_MANA");
 
+#define MANA_SERVICE_PERIOD 10
+
+struct mana_serv_work {
+	struct work_struct serv_work;
+	struct pci_dev *pdev;
+};
+
+static void mana_serv_func(struct work_struct *w)
+{
+	struct mana_serv_work *mns_wk;
+	struct pci_bus *bus, *parent;
+	struct pci_dev *pdev;
+
+	mns_wk = container_of(w, struct mana_serv_work, serv_work);
+	pdev = mns_wk->pdev;
+
+	pci_lock_rescan_remove();
+
+	if (!pdev)
+		goto out;
+
+	bus = pdev->bus;
+	if (!bus) {
+		dev_err(&pdev->dev, "MANA service: no bus\n");
+		goto out;
+	}
+
+	parent = bus->parent;
+	if (!parent) {
+		dev_err(&pdev->dev, "MANA service: no parent bus\n");
+		goto out;
+	}
+
+	pci_stop_and_remove_bus_device(bus->self);
+
+	msleep(MANA_SERVICE_PERIOD * 1000);
+
+	pci_rescan_bus(parent);
+
+out:
+	pci_unlock_rescan_remove();
+
+	pci_dev_put(pdev);
+	kfree(mns_wk);
+	module_put(THIS_MODULE);
+}
+
 static void mana_gd_process_eqe(struct gdma_queue *eq)
 {
 	u32 head = eq->head % (eq->queue_size / GDMA_EQE_SIZE);
 	struct gdma_context *gc = eq->gdma_dev->gdma_context;
 	struct gdma_eqe *eq_eqe_ptr = eq->queue_mem_ptr;
+	struct mana_serv_work *mns_wk;
 	union gdma_eqe_info eqe_info;
 	enum gdma_eqe_type type;
 	struct gdma_event event;
@@ -401,6 +449,33 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
 		eq->eq.callback(eq->eq.context, eq, &event);
 		break;
 
+	case GDMA_EQE_HWC_FPGA_RECONFIG:
+		dev_info(gc->dev, "Recv MANA service type:%d\n", type);
+
+		if (gc->in_service) {
+			dev_info(gc->dev, "Already in service\n");
+			break;
+		}
+
+		if (!try_module_get(THIS_MODULE)) {
+			dev_info(gc->dev, "Module is unloading\n");
+			break;
+		}
+
+		mns_wk = kzalloc(sizeof(*mns_wk), GFP_ATOMIC);
+		if (!mns_wk) {
+			module_put(THIS_MODULE);
+			break;
+		}
+
+		dev_info(gc->dev, "Start MANA service type:%d\n", type);
+		gc->in_service = true;
+		mns_wk->pdev = to_pci_dev(gc->dev);
+		pci_dev_get(mns_wk->pdev);
+		INIT_WORK(&mns_wk->serv_work, mana_serv_func);
+		schedule_work(&mns_wk->serv_work);
+		break;
+
 	default:
 		break;
 	}
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 3ce56a816425..bfae59202669 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -58,7 +58,7 @@ enum gdma_eqe_type {
 	GDMA_EQE_HWC_INIT_EQ_ID_DB	= 129,
 	GDMA_EQE_HWC_INIT_DATA		= 130,
 	GDMA_EQE_HWC_INIT_DONE		= 131,
-	GDMA_EQE_HWC_SOC_RECONFIG	= 132,
+	GDMA_EQE_HWC_FPGA_RECONFIG	= 132,
 	GDMA_EQE_HWC_SOC_RECONFIG_DATA	= 133,
 	GDMA_EQE_HWC_SOC_SERVICE	= 134,
 	GDMA_EQE_RNIC_QP_FATAL		= 176,
@@ -403,6 +403,8 @@ struct gdma_context {
 	u32			test_event_eq_id;
 
 	bool			is_pf;
+	bool			in_service;
+
 	phys_addr_t		bar0_pa;
 	void __iomem		*bar0_va;
 	void __iomem		*shm_base;
@@ -578,12 +580,16 @@ enum {
 /* Driver can handle holes (zeros) in the device list */
 #define GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP BIT(11)
 
+/* Driver can self reset on FPGA Reconfig EQE notification */
+#define GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE BIT(17)
+
 #define GDMA_DRV_CAP_FLAGS1 \
 	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
 	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
 	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG | \
 	 GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT | \
-	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP)
+	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP | \
+	 GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
-- 
2.34.1


