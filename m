Return-Path: <bpf+bounces-54432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE6BA69F22
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 05:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609E51786EC
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 04:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296F21DE4E0;
	Thu, 20 Mar 2025 04:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IPEBQCh+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D790A926
	for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 04:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742446595; cv=none; b=hDzOTx7UtiqwavSIqyU5ZxHV6uwzjEciribSzFRU5REJZtHUp6G/99HOXvI4j03TLPSqHOlhEVqFRv2UEnN4J+7oLC4w5X9DKmk90foe4HRmxyAnDUeJcSEpBqlX9HIqPgPV41JCwhfYE+hhGW1zyxoXHMnmfm+V4dD8CQyjIAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742446595; c=relaxed/simple;
	bh=FqwmkQuXgv+LvKbpAHhzYxMfH0CDvjBiwXX/0Mg8NqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MVxC2hQ/5CF6Lfh/E0t7WbzI1hhHOFcVpxG3UB7jzV/QkXyog2gRdxuUMkHKbaMAkfd1JUa89D6sG+cOuQVV5A1LcU4NQ0UgF8Hi9W746f8UkXGJYuXX/ac2YQ37REmOW6AfbpDUI7Gqwn0l0WoVV7PXxSMTl64bqWfcx6HbWNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IPEBQCh+; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3fe83c8cbdbso90186b6e.3
        for <bpf@vger.kernel.org>; Wed, 19 Mar 2025 21:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1742446593; x=1743051393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eiHuxZFeR0z3qepLbbfoyYyyhunqYYoRUFEmmXRrBZQ=;
        b=IPEBQCh+ui4qxoTa69sngz0xrycotwg1Ab61bMzQn/InFd3iMRAwNmD4ssP+fcGRLM
         EhwOAqORHcZURVvmt6cu9sIQOcJTWqOcFXYXmb7PEYG+Xs8ixJZxa4Z0ZWXJr8I9o2ek
         mhPG6Y6aQLSt8+ZFk/rfwhAfbEuxrlDcMg9Bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742446593; x=1743051393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eiHuxZFeR0z3qepLbbfoyYyyhunqYYoRUFEmmXRrBZQ=;
        b=PCJJNqOFjkLQ2Hxx4JVGueIE1Bsuew+6nBna4GE2yPisZzgkOVRTZhW8Jnyj3lgBxR
         PjGkavvBz49NV3Bdu1MhxPHj1/2uRyVm1NGvB/s2WYKktwOuMfj5V+u1PzEb0ko1qDSM
         uQlB4GmKHoLvTRgJwmp8JT/yxS8vSsKmf2PbUhlMdg2nkXAUtnz56yjBarUu/KubLZ4V
         phBHfj0F9TeG6knKywO0VfBg5cXkunyC1WWtP2I0HETBGyCLk1Qx4OJAOFzytS0TvJxt
         KlTLF6yp3VV+FAG3QFOiH6JiwRz0IXoB1ySZseGMuSBi+GCI+8aGF6YkERFp+3KgNRxL
         rmng==
X-Forwarded-Encrypted: i=1; AJvYcCWq1FjIaU7w/+JMTkbzY2z0/LwHqBSJNXxs+GcHFa/AQ4z4Rfi2VFmHbr/4Dq5/Rx0ZROw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4cT+Br8TnfhK8hrwH5SRYYSP3Gi7PN7wrX0ak0RYegnWdlmay
	spQfmhv/0jAseE+EjyYtGjlhw94Aa5S+HokBqONd+YQDlw+lz5sOw0pA8T9Slw==
X-Gm-Gg: ASbGncsAb45dRyKahTTKKltkiQgF1fpZ6SI8WQ7NxWhLJzZTHDtd5dtiugw/415ydMb
	cNtV7lYxAL1vtaqGFSA316Rhd4Xe8CVcjrLSWO09t6iqW9ZO4a7o6Podzf0w4E2O/oYLtDJMb16
	vNVb6y7NJ1aQ9ecbrw9xZaOhMtTDPtxkQO1kX5n9u+qmAzsS8vNSVb+oQvoPFQ9Xyp4VbS4k4Wm
	Or9ViiORmuNdltF4bb6RL/UQ2PKmCrV/hvdSe/9ufSc6hjAn0gH5Y3xcj5bWhAjdNPNZaOXDKKJ
	q47w/vE2aUImoRDjtU4HSsYeMbZZI29Igg7P45ZOzJpJwFmbQPOnqDvSccCnF/MBXuzu0S1zMoe
	qkbubgRpqSMdtN8Lvnr8aCYbGw7WiQBuUNeJjX3O32j99RriAd9d6Z5nhbnKqNn6xgz8X
X-Google-Smtp-Source: AGHT+IGryUTxMq4wQF/kLVnELBMnVT8Hzh/H4A4e+JRdpwNZJb7WqBUC+IW9z2+FyNKb9fBwJfr0aw==
X-Received: by 2002:a05:6808:2203:b0:3fa:1ed7:f7c3 with SMTP id 5614622812f47-3fead5b6ab4mr3167314b6e.29.1742446593155;
        Wed, 19 Mar 2025 21:56:33 -0700 (PDT)
Received: from sankartest7x-virtual-machine.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c6712e5774sm3571771fac.31.2025.03.19.21.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 21:56:31 -0700 (PDT)
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
Subject: [PATCH net] vmxnet3: unregister xdp rxq info in the reset path
Date: Thu, 20 Mar 2025 10:25:22 +0530
Message-Id: <20250320045522.57892-1-sankararaman.jayaraman@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vmxnet3 does not unregister xdp rxq info in the
vmxnet3_reset_work() code path as vmxnet3_rq_destroy()
is not invoked in this code path. So, we get below message with a
backtrace.

Missing unregister, handled but fix driver
WARNING: CPU:48 PID: 500 at net/core/xdp.c:182
__xdp_rxq_info_reg+0x93/0xf0

This patch fixes the problem by moving the unregister
code of XDP from vmxnet3_rq_destroy() to vmxnet3_rq_cleanup().

Fixes: 54f00cce1178 ("vmxnet3: Add XDP support.")
Signed-off-by: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 6793fa09f9d1..3df6aabc7e33 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2033,6 +2033,11 @@ vmxnet3_rq_cleanup(struct vmxnet3_rx_queue *rq,
 
 	rq->comp_ring.gen = VMXNET3_INIT_GEN;
 	rq->comp_ring.next2proc = 0;
+
+	if (xdp_rxq_info_is_reg(&rq->xdp_rxq))
+		xdp_rxq_info_unreg(&rq->xdp_rxq);
+	page_pool_destroy(rq->page_pool);
+	rq->page_pool = NULL;
 }
 
 
@@ -2073,11 +2078,6 @@ static void vmxnet3_rq_destroy(struct vmxnet3_rx_queue *rq,
 		}
 	}
 
-	if (xdp_rxq_info_is_reg(&rq->xdp_rxq))
-		xdp_rxq_info_unreg(&rq->xdp_rxq);
-	page_pool_destroy(rq->page_pool);
-	rq->page_pool = NULL;
-
 	if (rq->data_ring.base) {
 		dma_free_coherent(&adapter->pdev->dev,
 				  rq->rx_ring[0].size * rq->data_ring.desc_size,
-- 
2.25.1


