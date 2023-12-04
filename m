Return-Path: <bpf+bounces-16565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC4D802DB3
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 09:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B28E1F21167
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 08:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D26C11722;
	Mon,  4 Dec 2023 08:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAYaC39+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854C083;
	Mon,  4 Dec 2023 00:59:28 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2ca0715f0faso5490491fa.0;
        Mon, 04 Dec 2023 00:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701680367; x=1702285167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zLkzq4LH7qNlQ4R2u0+qoSFWaByEk2XvcwE8gCptUKs=;
        b=jAYaC39+pi18OkhVSnnxRUdhCOzE+J2SuWEAlT8EaKRILmEDV5T3cDhjhnyW2qSLvF
         vWglB0wT6Hr7lnhFJZDG7pPXnWWp3pqsKtttW+W/Dj2LNOhffMNy8OGcGdySH+vlccIm
         1ufzwPmBnCLEGy7JJgjdm3c53IRQ+N/rvFLvdoWuJ31HBY5TvoLP1i/dNt6K9ExYqk0T
         c0bf5dIaEQih3M0mEsD259gqNcbnOHwUhQNVIlfXyl6G1ZdeZXx85IOgSzJqchCgPIbH
         sgHC0fshUQ/JMjG6IAjCUQjYRbjmqWoUolkn5NncOMpxmN9UJ6mBZuwflAx8KXu8RkE8
         Rzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701680367; x=1702285167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLkzq4LH7qNlQ4R2u0+qoSFWaByEk2XvcwE8gCptUKs=;
        b=Y3uCvIgKrgY6DW1SC8nMrCQhzWZ5Ia2NqY0ZkdlSwALj5xvKXv547eCLFRjPEn1Sce
         4hKL8iKFBVO6dQftj8iirqHwqc3KDt0qLm/uqdbbUrivCYSg8LCp/+EIZd50r/6PMyRq
         p+/L2X8jGoxcPj3f2J1F68iXT/5ribjD7iPs9TvG29q+nT8+Y/7/SC838ZMix5Ye2qIT
         tZcZ45J99hzh0hkwNPXSkE5IRkgXUUeD/QdBlVmaszoRdlj3H90w706vilzSun3lOHAR
         w8kZ9z7sXPWTLrYBIvFNrt/7F6QSlBRyl0noOPV/UpZtpnrEVfoqSShW5Y16kgjlrgGB
         0aYw==
X-Gm-Message-State: AOJu0Yz3/UK6+d4n+xLT5ZwwjTJqmiHJdAWD5Dgb/p+kSZtyQW8jTCFs
	IgvITTMj3oASK9kiAW0GeNw=
X-Google-Smtp-Source: AGHT+IE82gdSoQHkIX6sW/TGs1kWdZkYu7hNPBJN6aj+F37YHJCBIYDbXsGrUffPnYSoFa8FuAy5Sw==
X-Received: by 2002:a2e:3814:0:b0:2c9:f71f:c00f with SMTP id f20-20020a2e3814000000b002c9f71fc00fmr1101183lja.30.1701680366458;
        Mon, 04 Dec 2023 00:59:26 -0800 (PST)
Received: from localhost.localdomain ([93.175.11.252])
        by smtp.gmail.com with ESMTPSA id o5-20020a05651c050500b002ca0abab79bsm108294ljp.4.2023.12.04.00.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 00:59:26 -0800 (PST)
From: Daniil Maximov <daniil31415it@gmail.com>
To: Egor Pomozov <epomozov@marvell.com>
Cc: Daniil Maximov <daniil31415it@gmail.com>,
	Igor Russkikh <irusskikh@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Taehee Yoo <ap420073@gmail.com>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] net: atlantic: Fix NULL dereference of skb pointer in
Date: Mon,  4 Dec 2023 11:58:10 +0300
Message-Id: <20231204085810.1681386-1-daniil31415it@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If is_ptp_ring == true in the loop of __aq_ring_xdp_clean function,
then a timestamp is stored from a packet in a field of skb object,
which is not allocated at the moment of the call (skb == NULL).

Generalize aq_ptp_extract_ts and other affected functions so they don't
work with struct sk_buff*, but with struct skb_shared_hwtstamps*.

Found by Linux Verification Center (linuxtesting.org) with SVACE

Fixes: 26efaef759a1 ("net: atlantic: Implement xdp data plane")
Signed-off-by: Daniil Maximov <daniil31415it@gmail.com>
---
 .../net/ethernet/aquantia/atlantic/aq_ptp.c    | 10 +++++-----
 .../net/ethernet/aquantia/atlantic/aq_ptp.h    |  4 ++--
 .../net/ethernet/aquantia/atlantic/aq_ring.c   | 18 ++++++++++++------
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
index 80b44043e6c5..28c9b6f1a54f 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
@@ -553,17 +553,17 @@ void aq_ptp_tx_hwtstamp(struct aq_nic_s *aq_nic, u64 timestamp)
 
 /* aq_ptp_rx_hwtstamp - utility function which checks for RX time stamp
  * @adapter: pointer to adapter struct
- * @skb: particular skb to send timestamp with
+ * @shhwtstamps: particular skb_shared_hwtstamps to save timestamp
  *
  * if the timestamp is valid, we convert it into the timecounter ns
  * value, then store that result into the hwtstamps structure which
  * is passed up the network stack
  */
-static void aq_ptp_rx_hwtstamp(struct aq_ptp_s *aq_ptp, struct sk_buff *skb,
+static void aq_ptp_rx_hwtstamp(struct aq_ptp_s *aq_ptp, struct skb_shared_hwtstamps *shhwtstamps,
 			       u64 timestamp)
 {
 	timestamp -= atomic_read(&aq_ptp->offset_ingress);
-	aq_ptp_convert_to_hwtstamp(aq_ptp, skb_hwtstamps(skb), timestamp);
+	aq_ptp_convert_to_hwtstamp(aq_ptp, shhwtstamps, timestamp);
 }
 
 void aq_ptp_hwtstamp_config_get(struct aq_ptp_s *aq_ptp,
@@ -639,7 +639,7 @@ bool aq_ptp_ring(struct aq_nic_s *aq_nic, struct aq_ring_s *ring)
 	       &aq_ptp->ptp_rx == ring || &aq_ptp->hwts_rx == ring;
 }
 
-u16 aq_ptp_extract_ts(struct aq_nic_s *aq_nic, struct sk_buff *skb, u8 *p,
+u16 aq_ptp_extract_ts(struct aq_nic_s *aq_nic, struct skb_shared_hwtstamps *shhwtstamps, u8 *p,
 		      unsigned int len)
 {
 	struct aq_ptp_s *aq_ptp = aq_nic->aq_ptp;
@@ -648,7 +648,7 @@ u16 aq_ptp_extract_ts(struct aq_nic_s *aq_nic, struct sk_buff *skb, u8 *p,
 						   p, len, &timestamp);
 
 	if (ret > 0)
-		aq_ptp_rx_hwtstamp(aq_ptp, skb, timestamp);
+		aq_ptp_rx_hwtstamp(aq_ptp, shhwtstamps, timestamp);
 
 	return ret;
 }
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.h b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.h
index 28ccb7ca2df9..210b723f2207 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.h
@@ -67,7 +67,7 @@ int aq_ptp_hwtstamp_config_set(struct aq_ptp_s *aq_ptp,
 /* Return either ring is belong to PTP or not*/
 bool aq_ptp_ring(struct aq_nic_s *aq_nic, struct aq_ring_s *ring);
 
-u16 aq_ptp_extract_ts(struct aq_nic_s *aq_nic, struct sk_buff *skb, u8 *p,
+u16 aq_ptp_extract_ts(struct aq_nic_s *aq_nic, struct skb_shared_hwtstamps *shhwtstamps, u8 *p,
 		      unsigned int len);
 
 struct ptp_clock *aq_ptp_get_ptp_clock(struct aq_ptp_s *aq_ptp);
@@ -143,7 +143,7 @@ static inline bool aq_ptp_ring(struct aq_nic_s *aq_nic, struct aq_ring_s *ring)
 }
 
 static inline u16 aq_ptp_extract_ts(struct aq_nic_s *aq_nic,
-				    struct sk_buff *skb, u8 *p,
+				    struct skb_shared_hwtstamps *shhwtstamps, u8 *p,
 				    unsigned int len)
 {
 	return 0;
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index 4de22eed099a..694daeaf3e61 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -647,7 +647,7 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self, struct napi_struct *napi,
 		}
 		if (is_ptp_ring)
 			buff->len -=
-				aq_ptp_extract_ts(self->aq_nic, skb,
+				aq_ptp_extract_ts(self->aq_nic, skb_hwtstamps(skb),
 						  aq_buf_vaddr(&buff->rxdata),
 						  buff->len);
 
@@ -742,6 +742,8 @@ static int __aq_ring_xdp_clean(struct aq_ring_s *rx_ring,
 		struct aq_ring_buff_s *buff = &rx_ring->buff_ring[rx_ring->sw_head];
 		bool is_ptp_ring = aq_ptp_ring(rx_ring->aq_nic, rx_ring);
 		struct aq_ring_buff_s *buff_ = NULL;
+		u16 ptp_hwtstamp_len = 0;
+		struct skb_shared_hwtstamps shhwtstamps;
 		struct sk_buff *skb = NULL;
 		unsigned int next_ = 0U;
 		struct xdp_buff xdp;
@@ -810,11 +812,12 @@ static int __aq_ring_xdp_clean(struct aq_ring_s *rx_ring,
 		hard_start = page_address(buff->rxdata.page) +
 			     buff->rxdata.pg_off - rx_ring->page_offset;
 
-		if (is_ptp_ring)
-			buff->len -=
-				aq_ptp_extract_ts(rx_ring->aq_nic, skb,
-						  aq_buf_vaddr(&buff->rxdata),
-						  buff->len);
+		if (is_ptp_ring) {
+			ptp_hwtstamp_len = aq_ptp_extract_ts(rx_ring->aq_nic, &shhwtstamps,
+							     aq_buf_vaddr(&buff->rxdata),
+							     buff->len);
+			buff->len -= ptp_hwtstamp_len;
+		}
 
 		xdp_init_buff(&xdp, frame_sz, &rx_ring->xdp_rxq);
 		xdp_prepare_buff(&xdp, hard_start, rx_ring->page_offset,
@@ -834,6 +837,9 @@ static int __aq_ring_xdp_clean(struct aq_ring_s *rx_ring,
 		if (IS_ERR(skb) || !skb)
 			continue;
 
+		if (ptp_hwtstamp_len > 0)
+			*skb_hwtstamps(skb) = shhwtstamps;
+
 		if (buff->is_vlan)
 			__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
 					       buff->vlan_rx_tag);
-- 
2.25.1


