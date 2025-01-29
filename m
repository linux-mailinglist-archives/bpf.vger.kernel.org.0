Return-Path: <bpf+bounces-50042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8E7A22301
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 18:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0632116782D
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 17:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205801DFE31;
	Wed, 29 Jan 2025 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SQHcc07h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0771F149C50
	for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738171966; cv=none; b=lnGuArpye3mAiRYKX3mZNWwDQnAEBcJ6V2m66V8Ugj/tlMQSU6eV18vb+/5y46DXVinJoP6Uq5pd1OhQqcxVh/qB28mQqTLNZ7eHqvVISs9UgH2oCStVZjNAjY04DU42sMyJS5Tn7s8WZkHjyP+LX3LZ9nGn4PrN3peiGTW1Nww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738171966; c=relaxed/simple;
	bh=bzI2HF00fiDQjFXMHdTBDTNovNNwt3zxrGTPuK/4xm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rnWjMqXb4TD3PVTU2GGoQ6+k/r2jIhh0xZdMzWBPlns5G4Pwoksr5a20SYmB4MKGA/T39ozkk7Jqnh1x79a4Yi6Ulcvd8yN2ZdYZNCFjUx8akMnYNgui3Hv+WGOhUuq3MBv3+IArnWf9AV1ivnT4bsKqcGUs8F2GDEg1OqIj7vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SQHcc07h; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5fc0c06e1deso166523eaf.1
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 09:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738171964; x=1738776764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mmqNHhmNdxqC4g8IfZMWhVXE5QHm3xsHzzSXQvlgXs=;
        b=SQHcc07hsid9ukcKvxFdI1BTp5rBtFyJBC5nH0X+/JMyzpi0dLSOfG+AN1p1wU5MA6
         krznTPLO6uXGEA4cR9Mey7xHJRyEyjoxwRWY2RZ+FX3iUFRwQUycrS5yKX17Nc4rpHxn
         NVwd+sGA7nWCgEqGhkKvCH7LBmeA1KOHu+uwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738171964; x=1738776764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mmqNHhmNdxqC4g8IfZMWhVXE5QHm3xsHzzSXQvlgXs=;
        b=gpFjBBQ9WwtpyFpJfdjGfcY2b1ZhOMctGgADuug7ovu6O46o9KCB6UQgMZS89iBisw
         ge5+aRT6CdAB/G1g+jWbOKmvPV09Yz3W6T8FWH0ZxfYTNe1/eOcnFJ7GqCQusZUavt7l
         PqC6ykX/sv/AeQScGT9ODxmHAlBQ6+3/HV2V0TV3Q2znpe3w6lmyMz09SweKqIy2XECz
         q+Oh7OyFxtpIQqLxMC+25twoCiP/GSoAMlQPEKW4y2Vl7wvazlA0ZwALpPG/tw/bPzVI
         VkXCPGKenDyZKIvRngdkiR3FyJuPjpIRxTuqY31KG5j4BnZ/XTLuMKjXqorfXM8GXK/s
         6rrw==
X-Forwarded-Encrypted: i=1; AJvYcCWUMr/PZVLymuip1eF/DT/OrxPHDMdWbTHg0jOKGb1uSE3a6/lL1Q4frBTFlpEKzQDXik0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUcok/DvFFkIg/EALJgP4mJzIPfhfsE9shzlPpEf+YDEufUmKE
	jEYRS2jbh4C/SmAeboTE2ldvJ/I5bpmx2LjP7pnYamp6I0tM3nL7ToW3M0TXlg==
X-Gm-Gg: ASbGncvZbXYA9y1i3frc9GBerVU6uMvzcFfA34S4cpg5z7nKRY/bpAWFM5abOdzLWWv
	CtbcdV0koHmbM9pNh2QLbr0BCLPBZPynzKSu8VVPnZd7r9pvG1ubKQsFj2NxMwvFlGYHl/xrv2L
	SVLZGxryMcu0KlMvAJpt8Vq5TLhZ4B9qVRxSaYHLGEqA42e0FCJq9axl25AZln9UmVEg9DWe1iX
	hgGAuhrGoYDqYITatGPGK8eAaEwPDauLXB6XEnJm+rZYoWyO32dGcca0aqu2a1CuIJRZqbYDKtb
	Eo+ohSnfPab1HFLbUzHtAIo5TtPKpXwAHmMnTw8b6IfjFUKHoVeZWw6z9JFtDdvzQgfQ80iPv2k
	ZiMbVem8tu5GNWx7vZgKqOLkrPO6D
X-Google-Smtp-Source: AGHT+IFFBOio0yS/W6+Ih6T9hzMuo5ZubUZrMuApePYc4nO6eAq1BblChDvzYJG9wtKlB2BVi3YxWg==
X-Received: by 2002:a05:6820:810a:b0:5fa:4c16:e641 with SMTP id 006d021491bc7-5fc00297daamr2598155eaf.3.1738171964013;
        Wed, 29 Jan 2025 09:32:44 -0800 (PST)
Received: from sankartest7x-virtual-machine.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fa8b5296e5sm3623678eaf.7.2025.01.29.09.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 09:32:42 -0800 (PST)
From: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
To: kuba@kernel.org
Cc: alexanderduyck@fb.com,
	alexandr.lobakin@intel.com,
	andrew+netdev@lunn.ch,
	ast@kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ronak.doshi@broadcom.com,
	sankararaman.jayaraman@broadcom.com,
	u9012063@gmail.com
Subject: [PATCH net] vmxnet3: Fix tx queue race condition with XDP
Date: Wed, 29 Jan 2025 23:04:15 +0530
Message-Id: <20250129173414.147705-1-sankararaman.jayaraman@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250127143635.623dc3b0@kernel.org>
References: <20250127143635.623dc3b0@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If XDP traffic runs on a CPU which is greater than or equal to
the number of the Tx queues of the NIC, then vmxnet3_xdp_get_tq()
always picks up queue 0 for transmission as it uses reciprocal scale
instead of simple modulo operation.

vmxnet3_xdp_xmit() and vmxnet3_xdp_xmit_frame() use the above
returned queue without any locking which can lead to race conditions
when multiple XDP xmits run in parallel on different CPU's.

This patch uses a simple module scheme when the current CPU equals or
exceeds the number of Tx queues on the NIC. It also adds locking in
vmxnet3_xdp_xmit() and vmxnet3_xdp_xmit_frame() functions.

Fixes: 54f00cce1178 ("vmxnet3: Add XDP support.")
Signed-off-by: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
---
 drivers/net/vmxnet3/vmxnet3_xdp.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_xdp.c b/drivers/net/vmxnet3/vmxnet3_xdp.c
index 1341374a4588..e3f94b3374f9 100644
--- a/drivers/net/vmxnet3/vmxnet3_xdp.c
+++ b/drivers/net/vmxnet3/vmxnet3_xdp.c
@@ -28,7 +28,7 @@ vmxnet3_xdp_get_tq(struct vmxnet3_adapter *adapter)
 	if (likely(cpu < tq_number))
 		tq = &adapter->tx_queue[cpu];
 	else
-		tq = &adapter->tx_queue[reciprocal_scale(cpu, tq_number)];
+		tq = &adapter->tx_queue[cpu % tq_number];
 
 	return tq;
 }
@@ -124,6 +124,7 @@ vmxnet3_xdp_xmit_frame(struct vmxnet3_adapter *adapter,
 	u32 buf_size;
 	u32 dw2;
 
+	spin_lock(&tq->tx_lock);
 	dw2 = (tq->tx_ring.gen ^ 0x1) << VMXNET3_TXD_GEN_SHIFT;
 	dw2 |= xdpf->len;
 	ctx.sop_txd = tq->tx_ring.base + tq->tx_ring.next2fill;
@@ -134,6 +135,7 @@ vmxnet3_xdp_xmit_frame(struct vmxnet3_adapter *adapter,
 
 	if (vmxnet3_cmd_ring_desc_avail(&tq->tx_ring) == 0) {
 		tq->stats.tx_ring_full++;
+		spin_unlock(&tq->tx_lock);
 		return -ENOSPC;
 	}
 
@@ -142,8 +144,10 @@ vmxnet3_xdp_xmit_frame(struct vmxnet3_adapter *adapter,
 		tbi->dma_addr = dma_map_single(&adapter->pdev->dev,
 					       xdpf->data, buf_size,
 					       DMA_TO_DEVICE);
-		if (dma_mapping_error(&adapter->pdev->dev, tbi->dma_addr))
+		if (dma_mapping_error(&adapter->pdev->dev, tbi->dma_addr)) {
+			spin_unlock(&tq->tx_lock);
 			return -EFAULT;
+		}
 		tbi->map_type |= VMXNET3_MAP_SINGLE;
 	} else { /* XDP buffer from page pool */
 		page = virt_to_page(xdpf->data);
@@ -182,6 +186,7 @@ vmxnet3_xdp_xmit_frame(struct vmxnet3_adapter *adapter,
 	dma_wmb();
 	gdesc->dword[2] = cpu_to_le32(le32_to_cpu(gdesc->dword[2]) ^
 						  VMXNET3_TXD_GEN);
+	spin_unlock(&tq->tx_lock);
 
 	/* No need to handle the case when tx_num_deferred doesn't reach
 	 * threshold. Backend driver at hypervisor side will poll and reset
@@ -226,6 +231,7 @@ vmxnet3_xdp_xmit(struct net_device *dev,
 	struct vmxnet3_adapter *adapter = netdev_priv(dev);
 	struct vmxnet3_tx_queue *tq;
 	int i;
+	struct netdev_queue *nq;
 
 	if (unlikely(test_bit(VMXNET3_STATE_BIT_QUIESCED, &adapter->state)))
 		return -ENETDOWN;
@@ -236,6 +242,9 @@ vmxnet3_xdp_xmit(struct net_device *dev,
 	if (tq->stopped)
 		return -ENETDOWN;
 
+	nq = netdev_get_tx_queue(adapter->netdev, tq->qid);
+
+	__netif_tx_lock(nq, smp_processor_id());
 	for (i = 0; i < n; i++) {
 		if (vmxnet3_xdp_xmit_frame(adapter, frames[i], tq, true)) {
 			tq->stats.xdp_xmit_err++;
@@ -243,6 +252,7 @@ vmxnet3_xdp_xmit(struct net_device *dev,
 		}
 	}
 	tq->stats.xdp_xmit += i;
+	__netif_tx_unlock(nq);
 
 	return i;
 }
-- 
2.25.1


