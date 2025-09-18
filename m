Return-Path: <bpf+bounces-68780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56105B84ADD
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 14:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31AF13A779B
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 12:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930C8304BAB;
	Thu, 18 Sep 2025 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FauBYyuV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E522FB622
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199901; cv=none; b=tleRnLLY6ZGo5Sr2FUeGbuzidxcB7VleqBBh2uLS/92Q+nYU3OHFBAdz3q+WH8o1eWrEAx1z+G6kyQVuhiE26kZFzKv77Em0RX39FLK0OW9UoxxcFrqT3GwDtnszBHp+qHEgH++1KapQfYndBxtGI5pYo26QkYggPQ1hu1LHBbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199901; c=relaxed/simple;
	bh=kQvQlJ4Ntkejel7Bjw96+PBXVk0IMsnf/Ap3QHrmNCI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DvrO2JRz14oHYhMCmUgvkNbmEyuymMpmnCDoxTXPFhLECeXZf1oF6gwqfvYw1MG8ucGXEKLtk0bRgaapns8l+AG9XZFXKoYZC/h6B5ev/60+ywaoJaq/+JIkQwfjILavm8BrZqvVee1R88bviQS9PrfifaTQeXyMrbS9usNUz+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FauBYyuV; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-78f58f4230cso8062216d6.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 05:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758199898; x=1758804698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lgi+BTeRK9OMV3Te7iHLbRBW1UdG0wv6serJphMr1ec=;
        b=GK1N8FX54utE3kS/y4HQ7bIatEmaWKdW7ng14fUvMWcQZ2NgNz52gcj/VJzUil5d/L
         U4OxHEwSVGoK+ApdhqwJ00Xu1ikBmwnhmgSj3II7ZJCkf4V3D0mGg+HZAOv3R+Oac6eH
         LypOxE95cACGclyCP70hRlxseA75G5hBGDbikKJZ9FeGqh6G79xkL0sMcN2az75J9G6B
         NKFjTEmPJiNovUYHqs1jhowZIFLr8wdn/OwafHV1eifeXknhUgzOqNETIsRez/iF1/8x
         fVnmkctiQR2S+XrXYI9dP6O2e8GoBHlnoMr8rTfmN9x6npMLmbIUZDS5uw63ac+B7LwD
         NYCA==
X-Forwarded-Encrypted: i=1; AJvYcCX5Tw+31li31fk54VRWVGNK/nEmBOQ6pkMKBTxOB2+/nTWrUl65t3xnHc5sHZBHsbUfbYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKgdRvoz3wkI679xLlec7QvvJKW7R1HXFxzLj9HNotlXK4973b
	zL8mo4oXXc0wqeDUYxlF6KEyPHJRfzBgMDmLxRKZxa6+EaB/qYnEtJbouoPha544M05lsXe7b3H
	kW8ScFDbMNno4P7LIaFR0HTK6BQ5ePFXDoGGTaEMjBfKLn3Hkw7y6uv2QkjuaEVYhCWwAb4kSpS
	vj2VpOXfV86YNwhZ61La6ax4McYJNFm9B4/oXjRkjAfWy4+EmDZu5adfMUIG8j8NIU2ldHuKrKK
	4wh
X-Gm-Gg: ASbGncvlUhZLHDCef8kOYRr5/3zRijfLN+DCdqZTeGrGt+trzJisy48BLMgT1t2Yg+B
	w7QwZJAvPIX0MXX708xNRTUXb7tZvqE1bCHPqqBCqIt/kxRVic8/xy8KKW2tvSZvi6ILr5H2735
	tq53Mh7aF4u2EI/bINPt9Goef4pXMa5jvN7YC+ccTZUtsup1mcQmdTeb8hO1YEDSYJyIVx9djCh
	+kTWPrRgRQ+hox2cta8aQNmpw3REluBunu1UEUXRA3c20nS2Iiuq/rE/DUqF07pOR1HEGANOzCG
	ebWsTzT6TnwkjRGJybOkOXO0+zZ1f2pSonzeNiioTkNnzy1BUMKd6cEf2bCzFkZnrjn2sVieR0i
	DSt3LQaUQs1ob+6CX24MshpzhfuT7Ntv+LRrOulDehwh6q0jrwGDRgmZT3u6272f8rz6sEUjVAO
	s=
X-Google-Smtp-Source: AGHT+IGSo4YO+VMV5/UwSqzvvntgHz3lbPovsve96JngJqcVyPTf/nAwuejCXQBmUecu+KeQa8T7679iNbRK
X-Received: by 2002:a05:6214:40e:b0:766:769e:8c8b with SMTP id 6a1803df08f44-78ece93e269mr56726386d6.46.1758199898342;
        Thu, 18 Sep 2025 05:51:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-79350777108sm1740156d6.34.2025.09.18.05.51.38
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2025 05:51:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8178135137fso194339885a.2
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 05:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758199898; x=1758804698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lgi+BTeRK9OMV3Te7iHLbRBW1UdG0wv6serJphMr1ec=;
        b=FauBYyuV9RU3PYdBbhT/xbRKdmsvPRJY5jeIF2P1+iA28OnnPvQOPbf5azb6HNYg1o
         RP9t3pwCs3pdwDb2SMQd961YZdOTfkLdKHfjnQW9u7IP63dgEj7F2GhfwfI9DoS+CZzS
         uNO1Q5WMPI2CmP+xTUgeh+DVYPVKYw+A1Ri/U=
X-Forwarded-Encrypted: i=1; AJvYcCX+OD+YRXctf47XlfZgybp34o4Zf1qn1zsCnbn9TdQ9Qpk9dgs6TSSnGVdTal6mTXb5B7w=@vger.kernel.org
X-Received: by 2002:a05:620a:2685:b0:82e:6ec8:9899 with SMTP id af79cd13be357-8310ef30b26mr617475585a.48.1758199897494;
        Thu, 18 Sep 2025 05:51:37 -0700 (PDT)
X-Received: by 2002:a05:620a:2685:b0:82e:6ec8:9899 with SMTP id af79cd13be357-8310ef30b26mr617472985a.48.1758199896971;
        Thu, 18 Sep 2025 05:51:36 -0700 (PDT)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836278b77fasm159592685a.23.2025.09.18.05.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 05:51:36 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: pv-drivers@vmware.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	sankararaman.jayaraman@broadcom.com,
	ronak.doshi@broadcom.com,
	florian.fainelli@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	tapas.kundu@broadcom.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH v6.6-v6.12] vmxnet3: unregister xdp rxq info in the reset path
Date: Thu, 18 Sep 2025 12:37:32 +0000
Message-Id: <20250918123732.502171-1-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.40.4
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>

[ Upstream commit 0dd765fae295832934bf28e45dd5a355e0891ed4 ]

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
Link: https://patch.msgid.link/20250320045522.57892-1-sankararaman.jayaraman@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Ajay: Modified to apply on v6.6, v6.12]
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 6793fa09f9d1a..3df6aabc7e339 100644
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
2.39.5

