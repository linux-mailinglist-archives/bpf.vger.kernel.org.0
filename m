Return-Path: <bpf+bounces-50049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38416A223B2
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 19:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D152A3A4B24
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 18:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D611DF749;
	Wed, 29 Jan 2025 18:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J8WJTv1l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42A31DE2DC
	for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738174522; cv=none; b=d1mt+miMOT4BqAUncgqpBeGTaimMtdexVPJXNRmZ+lf20SeKskVMaSZS397U2xbJnsDODTdjGa9ZLktnxmERMq5U1Ar+HosC2DGSSln2BDdg7Q6OAUEFFAAuZ5Lm19THDbDS1hzwpmDoPtlRy7dc85PrkpDOJ5NKF4aoV+2QNss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738174522; c=relaxed/simple;
	bh=wCFnbIIybuKiwpXxrJcymmC7JymqorEFQQf8dYEqH5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3L2BFXV42/HC+rwzdsLH3HoK6g/uj0DG7nMxRIVjQbAOW4ZL6YfiIKl6XZwYMzxPjob+IaiSdLgFoQunfAVIUdrzDnzPTY+PPnskf2liux+72W6LabgmU6Z5gJWGaI7Px8RaIO1l1de7sCE0M6+OpzVidTy7Hmi1EHTb9D0Y6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=J8WJTv1l; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3eb7e725aa0so2940078b6e.0
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 10:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738174518; x=1738779318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73largg9wahTKmlr8ZZdxSEO4OgWDT1fPbBkex8RVTQ=;
        b=J8WJTv1ljKT6QwrWr5FBslVnBajKXTmKNzBOmjBlbZ4juSX2b3OlF/qNvfy28DC3C2
         GSrUC/oT7XILVyme3xSVxJEqg+Rx/qFAZwds75hQQE74T+IcP7YaEOo3Jw6AMcvbPu5a
         8Fte/vmYo8APJeesvv5Y78aYhSk5aN7o5zDhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738174518; x=1738779318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73largg9wahTKmlr8ZZdxSEO4OgWDT1fPbBkex8RVTQ=;
        b=LLSEMzKgfSgIqpCn7mmCdy1RZwnh5B7CUL7xXoIvpDKv0AU1pCaC0GUAfGj2dSryr/
         i7MmJx7ZkITAmYYUSHUvsM1LqXFTZd8Jm0WefaH3uPR+xj2b1dwNU6ShZMt4SjbQSR+M
         HycESIn5mD+m8DfsSuZUKTi9XavA8g9i/hsdOxmTCllXYtwsRNN1BMc5d4uviaU3hTj/
         8/O9Hp9a/91s7ABkrIUfB4DSuSaEFVG/CkW2F65dlIY4fr5kfCkTgmksOAVSeNfP3mRR
         NGV3yPqylol5HvmTrU1Lj3BWDkk37W6TfKclOEuf/nH4LP9nPieWvodYbHvaM+VBse2P
         uh2w==
X-Forwarded-Encrypted: i=1; AJvYcCVgYG4Bd5IrTuUWIuq89e70wnzebT8WwFFufH7DhEira5F54yOGkdghWMBpoAuFiGHFIDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJBEPMGH20rlqheadPJT6mVviVCN/nSpCCzzrWzGo3DhT9SGLg
	wFhnpQCxUPwaODBvq1PfXpumTQ1G4fFR2J83SWQp19kTvvLvXaAGcdkLr7Ch/A==
X-Gm-Gg: ASbGnct7GgXvDPgoJ6lwXAK8K3LD/FcUsNTlW7LMmZQ8R+ouUzovNO1Ax4TcxZ+aBLy
	FHa/pumS4r0aZEx0nDr6HikbQXFCzrAz0m/YtWQBd1H6KawGjryYUKkb53pBNNjCKsQGaMpFfHb
	DGek8TnfhtHovzD4RY82DStvNU96XuGKE0LBAlzoznEESRVF6X0ecVyxdwJxU74h+Lh0ZDqdMbu
	GTQq0V7NevGUN4lAL3aYWTFVj6q60hNX3Z/nZ603fi6LVyy+U4AFi7gpODBV7fWIdVQTFSxaQk+
	CjydatCay69mH+Gv0+idrSRMHM3ejDyA6/Q7h+96H/YLQL7CSfeUprrCH01cwpU73Xy5ajzX4Co
	ofA3UCBBJtHkxYdN4/yaj7PGOgDU7
X-Google-Smtp-Source: AGHT+IHP3/qOhhMPBOFZAjk+2oHo8/Wdv9U9RQ3phvQekxuOjvAA0q8p/sGBWqtGI+atxjtqN53LTw==
X-Received: by 2002:a05:6870:2183:b0:29e:3d40:ab48 with SMTP id 586e51a60fabf-2b32f2d94d7mr2505453fac.34.1738174518629;
        Wed, 29 Jan 2025 10:15:18 -0800 (PST)
Received: from sankartest7x-virtual-machine.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b28f0f325dsm4487810fac.6.2025.01.29.10.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:15:18 -0800 (PST)
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
Subject: [PATCH net v2] vmxnet3: Fix tx queue race condition with XDP
Date: Wed, 29 Jan 2025 23:47:03 +0530
Message-Id: <20250129181703.148027-1-sankararaman.jayaraman@broadcom.com>
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
Changes v1-> v2:
Retained the copyright dates as it is.
Used spin_lock()/spin_unlock() instead of spin_lock_irqsave(). 
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


