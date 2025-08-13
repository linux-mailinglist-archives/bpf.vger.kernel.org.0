Return-Path: <bpf+bounces-65579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772D1B25678
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 00:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8DA884E05
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 22:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7530C302744;
	Wed, 13 Aug 2025 22:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjtgX1a9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D5C2FE067;
	Wed, 13 Aug 2025 22:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755123237; cv=none; b=txjhduxFPOTx3XMnxvhcSWFyKCPtA9pROd36ReKjqZr3Mw0ustkIzxQIjYhb2t+tPwaltWazAp1B7vkJ5TGb+aNRpGqACIIF5dXQX7UAoGU8LcLcKewq8FICXFYvJnQ2EFDrM3LZT6Z3vlHsgnOXay0orYMZFVWW5ypxBmyGCpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755123237; c=relaxed/simple;
	bh=VTu1YlP6cbBxPd8KlY7/RgMoLKQvCZlYMTO6Lr73lws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjH8y/RkbTLXSJ4TrsMjEeuT2QhV4JWK+MK/V1et/BaJx+9fDIHv/B4H+mbWe3vtQYxI9qha+wmxN7AZc+q86EFNEqKlnDOypWKEe/8qHz/DF/zHplGRZoAmvOgbS97G6K7Qq+H2/2VOMbajaxLzQdlQKKC31YieLm/IVjEWwTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjtgX1a9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b001f55so1374695e9.0;
        Wed, 13 Aug 2025 15:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755123233; x=1755728033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtjUK0AZOjm4eF0vnry/hWr4fc/ZinEdNV9kmjIXNAY=;
        b=RjtgX1a93HGEm3VhOTw/CVWVGuLeDsVdnkMCpQed8DHC+nIzKJVFFs/EqnOQoklQk0
         VNfOQPwHLCyLI4ZEsdnDW5K7MlheIP+t7qcd07mZYK4i03kcjhqx9pHwvVUze+VuHeDA
         Ip3s2SDRpj5JkfvM7GapzPkJaSCRwT52kyVlJP1o2FPiw3xK0lwrRmUTwCkOmAhkRFMu
         AE0C78fSj8Z3NhxFaBXJdKqVgCxna/H2KQCvoJP6nlyXLrBseUk/kAQhroW9fQhFtHcc
         etVZplB/LQRsVaCt3rhCezXWrOdbDuoFhBTfJTSc2qqZGtz1rPFCgpsggj+WMpa3BlUx
         fX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755123233; x=1755728033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtjUK0AZOjm4eF0vnry/hWr4fc/ZinEdNV9kmjIXNAY=;
        b=DzXvH5qcMwOCfMM8C2onpjcWmvuuVkRWAIdwbMByC+0KT09tedlGRzuh/sh0NZWNh/
         bOgHtxDBCB44FUyBZgNib/6th+Tg5Cn4OXqMLpM9ZhUhxUplrFO9BD5Oxna6QLkXR09c
         yA/e7kjlcC1m+xLWDJUtx+xRy/RI+byFKxXwrIBXz9Z/Srj/0OvkEUi1ojOAhZj5TRdJ
         PkVyDR6HhgsyQAJUsCgdz4E9qhvzO1i07q6mDfAMHY5Wvtc7sPnzOu6gpLzFtxOVvi+d
         P3XrittofbWE3jP/mh6ERj8NZU+y39mzpOUH6kaMcvdMXCdqI4vpt67g6NfsgTuDK6qu
         ozfw==
X-Forwarded-Encrypted: i=1; AJvYcCU/ySMAQObuT9NI0sxITyInzIfJOeqpreQKoyv+xDGWqK1GRKc7XWEG4fMRW9Nh2IPV9nkv7GmRUafWwc51@vger.kernel.org, AJvYcCWd6pm86q9uslxwd3gTO4gdEA5bg5P3KFxykdfGoUCbWWX0x2oJSZ6tb/hU1bdtOFYuA1Y=@vger.kernel.org, AJvYcCXrzH+CYv+Dxa//PFIKNnXrIZetToLuoluWioaIH9zL+UecUj4rgZiBPGlzLfwj3bAaAZ5rDo+881bA@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1dsiTZeT0nr2Aspij6yPfYaIn3kqx2eYAdymvRoW9vaw8Ga6j
	ahVfsDmlFpwdb6gxqfR1Wjue2BslNr3ARjp3AU5DdQjFD5R8zUut335C8EAOoSUv
X-Gm-Gg: ASbGnct0QR6CYnY8VSYdf3dYZkEw4lniD4Uz8gVxo1OEoAVdbBcC6k6I0wv1CRIKWcp
	2nXr1HLgLp38al48BYVRKtQbISc5EFdUVec+3+HOxmaNclGdxr05q6sIOwitPxdo7zjy1eWA3XZ
	XG/a0VHSfu0xnRWgbjyAVJi/U1bZo90fXG6Z9lmxlsoUxOJVNrIbMo5XGHKHfZB8y906YuMQTHm
	+wA8vVMTi4wR4NlwBT39Qm0X/xAcZ/y/qgvMpUmxweUKI6UkrEdjy8Ji8r6jejPft8AQy1cbxVP
	3P5D/0JntuFx2rDHWdr72wGncNl2iM5EI1pBpW9ytY8os0tAX3j3CM67C1cmIiRjfa8wUNPymvQ
	raFk7IgSu+q+fPw6WIbrQwYWaTA==
X-Google-Smtp-Source: AGHT+IEgB2v+gCGAWANNa3EKMpLphRvnlwapSV7jWPPQcd9HuQt+NoEXnt3jKfFlDc25gkCc0Dio4g==
X-Received: by 2002:a05:600c:4f16:b0:442:e9eb:1b48 with SMTP id 5b1f17b1804b1-45a1b65634bmr2958025e9.24.1755123232973;
        Wed, 13 Aug 2025 15:13:52 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:71::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a59019dsm15967745e9.21.2025.08.13.15.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 15:13:52 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: aleksander.lobakin@intel.com,
	alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	ast@kernel.org,
	bpf@vger.kernel.org,
	corbet@lwn.net,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	hawk@kernel.org,
	horms@kernel.org,
	john.fastabend@gmail.com,
	kernel-team@meta.com,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next V4 9/9] eth: fbnic: Report XDP stats via ethtool
Date: Wed, 13 Aug 2025 15:13:19 -0700
Message-ID: <20250813221319.3367670-10-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250813221319.3367670-1-mohsin.bashr@gmail.com>
References: <20250813221319.3367670-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to collect XDP stats via ethtool API. We record
packets and bytes sent, and packets dropped on the XDP_TX path.

ethtool -S eth0 | grep xdp | grep -v "0"
     xdp_tx_queue_13_packets: 2
     xdp_tx_queue_13_bytes: 16126

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 50 ++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 742b557d0e56..ceb8f88ae41c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -112,6 +112,20 @@ static const struct fbnic_stat fbnic_gstrings_hw_q_stats[] = {
 	 FBNIC_HW_RXB_DEQUEUE_STATS_LEN * FBNIC_RXB_DEQUEUE_INDICES + \
 	 FBNIC_HW_Q_STATS_LEN * FBNIC_MAX_QUEUES)
 
+#define FBNIC_QUEUE_STAT(name, stat) \
+	FBNIC_STAT_FIELDS(fbnic_ring, name, stat)
+
+static const struct fbnic_stat fbnic_gstrings_xdp_stats[] = {
+	FBNIC_QUEUE_STAT("xdp_tx_queue_%u_packets", stats.packets),
+	FBNIC_QUEUE_STAT("xdp_tx_queue_%u_bytes", stats.bytes),
+	FBNIC_QUEUE_STAT("xdp_tx_queue_%u_dropped", stats.dropped),
+};
+
+#define FBNIC_XDP_STATS_LEN ARRAY_SIZE(fbnic_gstrings_xdp_stats)
+
+#define FBNIC_STATS_LEN \
+	(FBNIC_HW_STATS_LEN + FBNIC_XDP_STATS_LEN * FBNIC_MAX_XDPQS)
+
 static void
 fbnic_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
 {
@@ -422,6 +436,16 @@ static void fbnic_get_rxb_dequeue_strings(u8 **data, unsigned int idx)
 		ethtool_sprintf(data, stat->string, idx);
 }
 
+static void fbnic_get_xdp_queue_strings(u8 **data, unsigned int idx)
+{
+	const struct fbnic_stat *stat;
+	int i;
+
+	stat = fbnic_gstrings_xdp_stats;
+	for (i = 0; i < FBNIC_XDP_STATS_LEN; i++, stat++)
+		ethtool_sprintf(data, stat->string, idx);
+}
+
 static void fbnic_get_strings(struct net_device *dev, u32 sset, u8 *data)
 {
 	const struct fbnic_stat *stat;
@@ -447,6 +471,9 @@ static void fbnic_get_strings(struct net_device *dev, u32 sset, u8 *data)
 			for (i = 0; i < FBNIC_HW_Q_STATS_LEN; i++, stat++)
 				ethtool_sprintf(&data, stat->string, idx);
 		}
+
+		for (i = 0; i < FBNIC_MAX_XDPQS; i++)
+			fbnic_get_xdp_queue_strings(&data, i);
 		break;
 	}
 }
@@ -464,6 +491,24 @@ static void fbnic_report_hw_stats(const struct fbnic_stat *stat,
 	}
 }
 
+static void fbnic_get_xdp_queue_stats(struct fbnic_ring *ring, u64 **data)
+{
+	const struct fbnic_stat *stat;
+	int i;
+
+	if (!ring) {
+		*data += FBNIC_XDP_STATS_LEN;
+		return;
+	}
+
+	stat = fbnic_gstrings_xdp_stats;
+	for (i = 0; i < FBNIC_XDP_STATS_LEN; i++, stat++, (*data)++) {
+		u8 *p = (u8 *)ring + stat->offset;
+
+		**data = *(u64 *)p;
+	}
+}
+
 static void fbnic_get_ethtool_stats(struct net_device *dev,
 				    struct ethtool_stats *stats, u64 *data)
 {
@@ -511,13 +556,16 @@ static void fbnic_get_ethtool_stats(struct net_device *dev,
 				      FBNIC_HW_Q_STATS_LEN, &data);
 	}
 	spin_unlock(&fbd->hw_stats_lock);
+
+	for (i = 0; i < FBNIC_MAX_XDPQS; i++)
+		fbnic_get_xdp_queue_stats(fbn->tx[i + FBNIC_MAX_TXQS], &data);
 }
 
 static int fbnic_get_sset_count(struct net_device *dev, int sset)
 {
 	switch (sset) {
 	case ETH_SS_STATS:
-		return FBNIC_HW_STATS_LEN;
+		return FBNIC_STATS_LEN;
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.47.3


