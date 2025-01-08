Return-Path: <bpf+bounces-48222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA66A051B6
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 04:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91F8E7A17C7
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 03:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A109F17C20F;
	Wed,  8 Jan 2025 03:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RVYYl6Ci"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C762E40E
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 03:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736308018; cv=none; b=T6XTzZv/rzj7cZF201DWVrZ3IgEh+/ydAbMus+bTEtP7fzuLkSrjJ+6h8GfQQ3bXoGyNSoVkBp8HlBL3l89Qle3u/iqZmLBam4tf9KccfDulruhdqGrlgR1Uo384NBJ9Vsj+RMBIgCWrOIiD5efSWohxk/AX8qMhm2x8w+JeCTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736308018; c=relaxed/simple;
	bh=3LCFBWDpX022awbUxg9j7aAgxggjyLlvGDhxQ1mEMrs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BvdrqLXa76HlMbav2JUEEdl3Zuk8oQabvzTT6HpbAHjgA2GTDgCbjHqBdxTBOB/9uPe9r4GqduDqZylDw/8uhcWn4dzhS+EDAExxWt6SmP+gIT3Gjz6eraepUIEmkJF6xbUmJlwqcy1MAUdTVgkBlljcChVMySR2qfZcR/KD8ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RVYYl6Ci; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21670dce0a7so67998555ad.1
        for <bpf@vger.kernel.org>; Tue, 07 Jan 2025 19:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736308016; x=1736912816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mi+CGQoubQ0WXyV85u6vVi98repRddgcWF9ItWY6PUQ=;
        b=RVYYl6Cisgam4g+5s6BT95TRidn//RJFkxcIfaCxiyyXRAJ08ykbau5Ax9V4713amU
         N7Qc/U+grXWuL7qKOpJ+BDJWRfw7NiziClOKmj0LJTouN7ZfM5XdbYApAzq/sC+N5GgB
         ybOwEohVzqYw1O9AVBKZCa7CkNcUtAAxJ0qbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736308016; x=1736912816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mi+CGQoubQ0WXyV85u6vVi98repRddgcWF9ItWY6PUQ=;
        b=Kq/+nzvpfoUP4MNCvGqcJLYrHZUGXxvsAsJVmfBhq2OoqGbtjv8pG83O0pJnWvuTUK
         SOidceeWYNw4GuWkFbxPzjqubBS0FfQQHowVpmF99p4oI5bnxZa3/A0WQzNrXuvKrqyb
         sw6zKol0XRZVmSM0SZtugmQE7jDQAEzL8ycg+T5aSvL8xFpEJjo2M1iOhyIxB7Z8xZuv
         Vepx5qmgoHyzAr9gQIRtDSitBrD86OeII92Cl3XNuKX6C3zmdyri6jY/6eoau4EywFBG
         HKZOGDw1lRU7xzGAvIb+Reu4WhWVUP+VDs/2jUvgrX3TguFfAWAc0jIumqHv+fPtsJJo
         L9aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVekgH9ymOGW9bUu3Kpw8gs1GKJVhcAiydpEAXnmBy6IsKsqoqaD/esb0E+J4nZxc9GxJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGtirU6jsZ+bnMNJzniwvPgqWSASzwdy8piSnocxFgiedY0Xx6
	WQVBoow8cXrawATA5UrAf7zin6gNlLETd2G4N7OzVt1MQD/qvy61e+XyDbdFFkNwHMOoYCV9O/d
	ZCVV8GpLc5AoixmsS6du8fm2G8BcdvFJzfOHeomo=
X-Gm-Gg: ASbGncuEuOdjVQxn+NcWRgVyU004ZByJBa3UFNv2emJbJzAqL3sYgFkLMYoSk5E/J0Y
	EOxASoC9PCr7SU1rOjA0+PeOcottv+75/iDUAxsKYM1zwGwFALNhyW/HINwgz1sJ6B0IL9Xypdg
	0h3g1oCJ2O1yb1CJ3tJ2wuoW5OUGny8teHayFIRqKHf5hzT/uIq/HjUBHNEyV/Ouk03WD3LtNqF
	QYXCRQ/ig8rq+1H+93K/FsPBXtL/VBu08OUjYYF4Jlc2uAW9T45JKCx652QLeA42mKWfyK/NpVl
	BooBi25eZCy4iN9W0SbBB/3yWKVdcbOM/gsslS5T1s9m5exDcMRbSwy7RRdCmgkwd2UgEg==
X-Google-Smtp-Source: AGHT+IFA3KkhNN51bihNTZB7UgR77WHxD+kD+M3694lYFJZ0xWcKF5NN4koPeSDvsfNeikL1QuiMaQ==
X-Received: by 2002:a17:902:d48a:b0:215:603e:2141 with SMTP id d9443c01a7336-21a83f57383mr21318875ad.19.1736308015712;
        Tue, 07 Jan 2025 19:46:55 -0800 (PST)
Received: from sankartest7x-virtual-machine.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a2ad3b7sm331253a91.31.2025.01.07.19.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 19:46:55 -0800 (PST)
From: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
To: netdev@vger.kernel.org
Cc: sankararaman.jayaraman@broadcom.com,
	ronak.doshi@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	u9012063@gmail.com,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ast@kernel.org,
	alexandr.lobakin@intel.com,
	alexanderduyck@fb.com,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Subject: [PATCH net] vmxnet3: Fix tx queue race condition with XDP
Date: Wed,  8 Jan 2025 09:18:18 +0530
Message-Id: <20250108034818.46634-1-sankararaman.jayaraman@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

If XDP traffic runs on a CPU which is greater than or equal to
the number of the Tx queues of the NIC, then vmxnet3_xdp_get_tq()
always picks up queue 0 for transmission as it uses reciprocal scale
instead of simple modulo operation.

vmxnet3_xdp_xmit() and vmxnet3_xdp_xmit_frame() use the above
returned queue without any locking which can lead to race conditions
when multiple XDP xmits run in parallel on different=C2=A0CPU's.

This patch uses a simple module scheme when the current CPU equals or
exceeds the number of Tx queues on the NIC. It also adds locking in
vmxnet3_xdp_xmit() and vmxnet3_xdp_xmit_frame() functions.

Fixes: 54f00cce1178 ("vmxnet3: Add XDP support.")
Signed-off-by: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
---
 drivers/net/vmxnet3/vmxnet3_xdp.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_xdp.c b/drivers/net/vmxnet3/vmxnet=
3_xdp.c
index 1341374a4588..5f177e77cfcb 100644
--- a/drivers/net/vmxnet3/vmxnet3_xdp.c
+++ b/drivers/net/vmxnet3/vmxnet3_xdp.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Linux driver for VMware's vmxnet3 ethernet NIC.
- * Copyright (C) 2008-2023, VMware, Inc. All Rights Reserved.
+ * Copyright (C) 2008-2025, VMware, Inc. All Rights Reserved.
  * Maintained by: pv-drivers@vmware.com
  *
  */
@@ -28,7 +28,7 @@ vmxnet3_xdp_get_tq(struct vmxnet3_adapter *adapter)
 	if (likely(cpu < tq_number))
 		tq =3D &adapter->tx_queue[cpu];
 	else
-		tq =3D &adapter->tx_queue[reciprocal_scale(cpu, tq_number)];
+		tq =3D &adapter->tx_queue[cpu % tq_number];
=20
 	return tq;
 }
@@ -123,7 +123,9 @@ vmxnet3_xdp_xmit_frame(struct vmxnet3_adapter *adapter,
 	struct page *page;
 	u32 buf_size;
 	u32 dw2;
+	unsigned long irq_flags;
=20
+	spin_lock_irqsave(&tq->tx_lock, irq_flags);
 	dw2 =3D (tq->tx_ring.gen ^ 0x1) << VMXNET3_TXD_GEN_SHIFT;
 	dw2 |=3D xdpf->len;
 	ctx.sop_txd =3D tq->tx_ring.base + tq->tx_ring.next2fill;
@@ -134,6 +136,7 @@ vmxnet3_xdp_xmit_frame(struct vmxnet3_adapter *adapter,
=20
 	if (vmxnet3_cmd_ring_desc_avail(&tq->tx_ring) =3D=3D 0) {
 		tq->stats.tx_ring_full++;
+		spin_unlock_irqrestore(&tq->tx_lock, irq_flags);
 		return -ENOSPC;
 	}
=20
@@ -142,8 +145,10 @@ vmxnet3_xdp_xmit_frame(struct vmxnet3_adapter *adapter=
,
 		tbi->dma_addr =3D dma_map_single(&adapter->pdev->dev,
 					       xdpf->data, buf_size,
 					       DMA_TO_DEVICE);
-		if (dma_mapping_error(&adapter->pdev->dev, tbi->dma_addr))
+		if (dma_mapping_error(&adapter->pdev->dev, tbi->dma_addr)) {
+			spin_unlock_irqrestore(&tq->tx_lock, irq_flags);
 			return -EFAULT;
+		}
 		tbi->map_type |=3D VMXNET3_MAP_SINGLE;
 	} else { /* XDP buffer from page pool */
 		page =3D virt_to_page(xdpf->data);
@@ -182,6 +187,7 @@ vmxnet3_xdp_xmit_frame(struct vmxnet3_adapter *adapter,
 	dma_wmb();
 	gdesc->dword[2] =3D cpu_to_le32(le32_to_cpu(gdesc->dword[2]) ^
 						  VMXNET3_TXD_GEN);
+	spin_unlock_irqrestore(&tq->tx_lock, irq_flags);
=20
 	/* No need to handle the case when tx_num_deferred doesn't reach
 	 * threshold. Backend driver at hypervisor side will poll and reset
@@ -226,6 +232,7 @@ vmxnet3_xdp_xmit(struct net_device *dev,
 	struct vmxnet3_adapter *adapter =3D netdev_priv(dev);
 	struct vmxnet3_tx_queue *tq;
 	int i;
+	struct netdev_queue *nq;
=20
 	if (unlikely(test_bit(VMXNET3_STATE_BIT_QUIESCED, &adapter->state)))
 		return -ENETDOWN;
@@ -236,6 +243,9 @@ vmxnet3_xdp_xmit(struct net_device *dev,
 	if (tq->stopped)
 		return -ENETDOWN;
=20
+	nq =3D netdev_get_tx_queue(adapter->netdev, tq->qid);
+
+	__netif_tx_lock(nq, smp_processor_id());
 	for (i =3D 0; i < n; i++) {
 		if (vmxnet3_xdp_xmit_frame(adapter, frames[i], tq, true)) {
 			tq->stats.xdp_xmit_err++;
@@ -243,6 +253,7 @@ vmxnet3_xdp_xmit(struct net_device *dev,
 		}
 	}
 	tq->stats.xdp_xmit +=3D i;
+	__netif_tx_unlock(nq);
=20
 	return i;
 }
--=20
2.25.1


--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

