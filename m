Return-Path: <bpf+bounces-20116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57014839A06
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 21:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAAB8B28530
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 20:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BBD86127;
	Tue, 23 Jan 2024 20:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="U+ifQrZR"
X-Original-To: bpf@vger.kernel.org
Received: from mx15lb.world4you.com (mx15lb.world4you.com [81.19.149.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DF485C47;
	Tue, 23 Jan 2024 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706040567; cv=none; b=bR/8wWaFvL0XoJm40jqh+/Q37H7/OlBzP4VMtG73uf65oebxRv7Aocoy4gdiktf/tzV1R9xglo/MONHfIglaP/1+FoTzY9LW/lnrLmb/T9UqQJKwrRg4DuYw4HfpP0QEBdPDhEDY7OinRRHLqyVDQ7FCj7SR7AjWASn14gezpoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706040567; c=relaxed/simple;
	bh=OnF2NS8E5Rgd8oS5vEXS5MCrFLcOWVVF9f2KxhbA5gs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fA5XZ1ODjBScjftklNU4dOtjkPadErkqS9MTYLl/meuIHqOCi0Jv7u1VvxWYDtw0nE7ZIBFJ9xjeaz0iWfvAme6VkKFfjYvfQ4KNZzlnfrwUKNRsn4y1IqUU0Kacy0JwvKM97rB3U9VG0HmSlFFp8DSRUFef02N80ZwDh2o0NEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=U+ifQrZR; arc=none smtp.client-ip=81.19.149.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2j/QEu67spPks8eR09A9FtkHTZs1MTEwycM7n70OG4k=; b=U+ifQrZRGm4N9PihiovK87B5MO
	hxn1eS/eSqsOXKF7uI50nOU1Yf04Lo6aIMYhIx0Nnf9Z5akPgjlDkT2AFv/6godKRjKTu82IXr/wa
	WbxZ77m5guK2gWQQThjQGIDWcGRvuw5PO39wIg/Wvt/fj7s4ASikxFP1/3G8P0x86C8k=;
Received: from 88-117-59-234.adsl.highway.telekom.at ([88.117.59.234] helo=hornet.engleder.at)
	by mx15lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1rSN5I-0006xu-26;
	Tue, 23 Jan 2024 21:09:24 +0100
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH net 2/2] tsnep: Fix XDP_RING_NEED_WAKEUP for empty fill ring
Date: Tue, 23 Jan 2024 21:09:18 +0100
Message-Id: <20240123200918.61219-3-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123200918.61219-1-gerhard@engleder-embedded.com>
References: <20240123200918.61219-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

The fill ring of the XDP socket may contain not enough buffers to
completey fill the RX queue during socket creation. In this case the
flag XDP_RING_NEED_WAKEUP is not set as this flag is only set if the RX
queue is not completely filled during polling.

Set XDP_RING_NEED_WAKEUP flag also if RX queue is not completely filled
during XDP socket creation.

Fixes: 3fc2333933fd ("tsnep: Add XDP socket zero-copy RX support")
Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
---
 drivers/net/ethernet/engleder/tsnep_main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index d380a407e175..ae0b8b37b9bf 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -1764,6 +1764,19 @@ static void tsnep_rx_reopen_xsk(struct tsnep_rx *rx)
 			allocated--;
 		}
 	}
+
+	/* set need wakeup flag immediately if ring is not filled completely,
+	 * first polling would be too late as need wakeup signalisation would
+	 * be delayed for an indefinite time
+	 */
+	if (xsk_uses_need_wakeup(rx->xsk_pool)) {
+		int desc_available = tsnep_rx_desc_available(rx);
+
+		if (desc_available)
+			xsk_set_rx_need_wakeup(rx->xsk_pool);
+		else
+			xsk_clear_rx_need_wakeup(rx->xsk_pool);
+	}
 }
 
 static bool tsnep_pending(struct tsnep_queue *queue)
-- 
2.39.2


