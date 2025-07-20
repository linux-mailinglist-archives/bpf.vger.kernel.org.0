Return-Path: <bpf+bounces-63827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606BAB0B47F
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 11:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96DAF17992F
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 09:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934D51E885A;
	Sun, 20 Jul 2025 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMycx7t7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B071EA65;
	Sun, 20 Jul 2025 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753002700; cv=none; b=Su4+xHtSl8M+D6pIcJHbvrJHjNSwed5sYPbVXKhjnrZX9XhIEnwTd0PoEfa7RA2TFsZ/3r8B+LMtuQMyeydA1qBRsIcXM+39F9D4t6HC6gYyCxKrljtITAi7zpuLdzxO8PMHMWdbItbsqf6xIZYhF82cDVn68NZtIqOl44MQEsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753002700; c=relaxed/simple;
	bh=pr0KVu739veIqCYBWKfvuWFLMLsBVD/rfBy1E6wPT/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mfJbGc7UeFBoPXwLiYY5XlMzjbRB8v0G6RBtQmNU/b1Mucj4uiidqe6GaOhFsubnovRNtfnrgt+eDWZPcC4ZEBc0swLuyjW3USLUCdSnQdSb/WoQ17G453OIQtdATyBFVeaQJVMgJkUnTPzUNRKa3R2ZxlPguVQePo+LF2RF4+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMycx7t7; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74b50c71b0aso1824253b3a.0;
        Sun, 20 Jul 2025 02:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753002697; x=1753607497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rt9sbSI84k+hriqQ4Yv6ukeqAyVbcIdSlA7NkaxNd1E=;
        b=LMycx7t7y5g70W63FKqsW2YDdt9xvEz/CPQw2eHeFU1yuTfjmF3ij67CMgrgymxu0i
         eK5HIoLyb9Nsbv+B+ljjPkJvjfcCSuBcL3v4YQiFUpCtYCahCMKxoQm51SqK887F0TwJ
         kAZObkjlsV/VoSXk79+dpGxbN4aE44Bc1B9jrQZG40f3l5BU462uLrnUsBN7ATkpkT7V
         M9uXB1P+vL3Gbqx/ItYaCWw1wPKfi6/BWAh1qD1sh5SjWbejA8GbGRmF8xeTjicqDCmC
         2ZI296tF9iyQzCAr+N1uXjuY9FymX91vTq5D11ykGYmbiEZcH4WPnYUBqyBDGwGj/wmq
         qW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753002697; x=1753607497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rt9sbSI84k+hriqQ4Yv6ukeqAyVbcIdSlA7NkaxNd1E=;
        b=quHEL90oXzil9yrgCxeRoSHtIX45LyUBtsNKIdv9CIzMPcNK7qQABOGi01arTM0t3t
         Elj1jEk81tak3ORHBfYfldgtDJNI95dm/rNkYHB2Lc6cl1EKq3jqPtnXPk1szb9ARdYk
         7kjN1FO4Ewjg1wfVZsYPu1vRv6jAIIrZ/mtGm0nDGwpyZljQuEU3fXX6vArvVYhlXCF9
         cYa33v20LewNpZ1hm5aWVhZNw8pZ61WCMrygaNLyIzxszVh4udIROLCGnq5HS0E1+xpV
         m0j5eq1zVNCoRsBMB31t3lrrCb/6qtuZIHrErq6+XhFMJWzsweLLmuwvQ3pDPfU9/ncp
         CHqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7+Pr1czA/ybkSXxdx3gY6fF0+XuzixbChsuPMB05fXYqKJrTou6m3QdvwyRHwhukeB3nM8XI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw04lQZGzehfo/g4aRv0+XJJOWsxxU1Ck+MpQZWXwPeMoRimOJL
	RWJezz404jdkjyOLt9e4ItoXEaZHjPgqF1mN0qpMjjSFMiKWb7E+pLAo
X-Gm-Gg: ASbGncvXtVjVDCrJhFC/XWJIfU3CCpeh9ugeWPTC47FKMEn4lXkU5RlyAiC+M/BqiqI
	TEEcYMR3WaGWX0HgDAz9+DZyOrJrquAD47dLh70NpBDWUywcS/LbGwRtbDP8Yk3zCz1LEp6dMv1
	w9pTmG3RoeowTLCXlLsJW9Kam4FyC8gWqWTCAdH+zC2Pi+7TwO1oA2jeLzcMTZxZqw8nOHRWcvu
	g5y1lo1DqZGATzEtqD8Ugw8mM6khYUcbnwH7w8cUXiM0U49180IBfE8GHhQx9nNRffkw65J9vtS
	mPjlEad454HEvcglKzG5I//dVqVGs8gugydqBYaRz8uEkKd8GJnNkEq28yg7hvoCO3ME+184A9n
	QFQ2uWApwDwpTn6CGwFczzg4u/LUTZ5MWY7hrwhrhoDBGzBXb5KGSNjOU/xI=
X-Google-Smtp-Source: AGHT+IE1nwxPPLoq731AChr7kpARPbWq+izW7FIXX6nSxuCyYB+jHt/5I11t6TB2f0G51tM6hDiVXQ==
X-Received: by 2002:a05:6a00:1795:b0:74e:aba0:6dfd with SMTP id d2e1a72fcca58-75723165609mr19294085b3a.10.1753002696663;
        Sun, 20 Jul 2025 02:11:36 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.24.59])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb76d53fsm3902585b3a.105.2025.07.20.02.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 02:11:36 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 1/5] ixgbe: xsk: remove budget from ixgbe_clean_xdp_tx_irq
Date: Sun, 20 Jul 2025 17:11:19 +0800
Message-Id: <20250720091123.474-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250720091123.474-1-kerneljasonxing@gmail.com>
References: <20250720091123.474-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Since 'budget' parameter in ixgbe_clean_xdp_tx_irq() takes no effect,
the patch removes it. No functional change here.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c        | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 6122a0abb41f..a59fd8f74b5e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3591,7 +3591,7 @@ int ixgbe_poll(struct napi_struct *napi, int budget)
 
 	ixgbe_for_each_ring(ring, q_vector->tx) {
 		bool wd = ring->xsk_pool ?
-			  ixgbe_clean_xdp_tx_irq(q_vector, ring, budget) :
+			  ixgbe_clean_xdp_tx_irq(q_vector, ring) :
 			  ixgbe_clean_tx_irq(q_vector, ring, budget);
 
 		if (!wd)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
index 78deea5ec536..788722fe527a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
@@ -42,7 +42,7 @@ int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
 			  const int budget);
 void ixgbe_xsk_clean_rx_ring(struct ixgbe_ring *rx_ring);
 bool ixgbe_clean_xdp_tx_irq(struct ixgbe_q_vector *q_vector,
-			    struct ixgbe_ring *tx_ring, int napi_budget);
+			    struct ixgbe_ring *tx_ring);
 int ixgbe_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags);
 void ixgbe_xsk_clean_tx_ring(struct ixgbe_ring *tx_ring);
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index ac58964b2f08..0ade15058d98 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -454,7 +454,7 @@ static void ixgbe_clean_xdp_tx_buffer(struct ixgbe_ring *tx_ring,
 }
 
 bool ixgbe_clean_xdp_tx_irq(struct ixgbe_q_vector *q_vector,
-			    struct ixgbe_ring *tx_ring, int napi_budget)
+			    struct ixgbe_ring *tx_ring)
 {
 	u16 ntc = tx_ring->next_to_clean, ntu = tx_ring->next_to_use;
 	unsigned int total_packets = 0, total_bytes = 0;
-- 
2.41.3


