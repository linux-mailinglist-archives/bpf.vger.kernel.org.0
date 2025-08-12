Return-Path: <bpf+bounces-65472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE5DB23BDD
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 00:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C971AA873B
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 22:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1B52D63E5;
	Tue, 12 Aug 2025 22:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsgG2lN0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB21280308;
	Tue, 12 Aug 2025 22:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755037465; cv=none; b=FafWQNMUOkHNwyBeXjLd8tOUr8mbvTSAHi1xhr+bQkVmqAI3EhOc+7SIp+fzYm0A2CcvuTONwK0yK4nobXUTb1t7isctUlmOjJPZ+ysV7GtirP/9VDF/9DZzOdzt9sexOQNlsXyF8HMQpjw6tzcQbVZDAd/HQTs0yNEe99C5HQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755037465; c=relaxed/simple;
	bh=VTu1YlP6cbBxPd8KlY7/RgMoLKQvCZlYMTO6Lr73lws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJ/8AtMQ1kRi/7mVZBGK3giJque5zDKQdno4k0N21paFr0WTaXk4yLMSlP1szm2li/NweLdK3UcPAp6f5fDr8kiLhKiJVCRfvdEyatFLmc98qHxXCTWB92KEweCzWnY4ErSvtYj8MxpfCINtdcCKOZIv2WvOHJlxfX1LkZ6+cq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsgG2lN0; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b783ea502eso203346f8f.1;
        Tue, 12 Aug 2025 15:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755037462; x=1755642262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtjUK0AZOjm4eF0vnry/hWr4fc/ZinEdNV9kmjIXNAY=;
        b=UsgG2lN0/dfvuiGD/r5glWiHVrG4l89saV+mlnzWnKFzmWWfFufR+ttIQPnxpwoTuK
         Xz4/VHGXDCCFZyoxXOcsYB36Wck3M0v2TzVxKzI87M58bJOrsPvDXPyeOWtigvfp6TPC
         k/i5ilA+ePGDSKJBp5IlTI+TBe7n7OwSdW43/bhUaxk65sB35FhSxL5R64J0myrBFMdp
         /ODx6S+LIoVfKqg+CuMxydF+3BvqxaxvF/Rh6oO8FuF8uMsGZqat9TbZXUciQZ+2aO5r
         6blGBtVOavLwBOkRZhfE5gQ+4/exWFbt8EHIpPZ6VgTWGkPy0yks4wtnvR4RryW0PCxh
         XVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755037462; x=1755642262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtjUK0AZOjm4eF0vnry/hWr4fc/ZinEdNV9kmjIXNAY=;
        b=Jy0kVZOLv6cZgF/rd+Xje4arfcQAK1N3xFlktuQBFrlHo+khivCawW9kSMisB+eZKe
         sGReooHIRzrftzvEsl5pJHPeijr1ZnKvEqGm7/gq1nFpAqwKmx1C5lMW+cDBvM5XSutR
         w/UTeqs19NoSdvNhdIjnA6eGeSSL1kpYy3m6+jhXv3SceJxsEeI2SZmg8ub5AiuBeaJD
         z/MdcSbZDmmiQLwAhia2RUQcumLXzMWvZV0mVBrGw9pAU+C/lRphYwnm+ZHDICHh6iqe
         uR1LG/x6qwsfp807Q834F+nZ+tiaCBrvAiBLOtHqGT3VECYye3UnXsXLTe+REImts6MY
         evwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU26KLfefZxtdrid992cL40r7mUKF/drLukWXnbj4vXvSNeqql/R0l7VnecEZjwUGC5KWw=@vger.kernel.org, AJvYcCVBTCaX7FMNyorDmaboS17h084f8ea8YKVqjlnJJZRVYZQ7GvAtA6nz1oSgFdLCash3GiDHLQuyPf/m@vger.kernel.org, AJvYcCWI3mGJrhAHMFlAZlaS29x5jOfEMts4K+loweGnVBW9gZn5cJwfPp37Oo25gsud7CRu4biFZd315jMkkvog@vger.kernel.org
X-Gm-Message-State: AOJu0YxE8e5Zu+HfDuK5YSHgaEhirWFNHt+39FGQjR9tuXmjPFU3gBp8
	yX2XTnstzG3jetGIt6MUHCCDdCluiYQVVNI1tYH7jw3h6qR8WJHWm9YdKBIZM3LB
X-Gm-Gg: ASbGncsu4O/9fpdBv2cLXQ4wM4DcddjS01qpGSD6eLEVhmVPoGfF1Kwzw3M0x6onJrL
	ZscYl2Ej+VSA2P3CLZ+McaG4tP5eQoykP9xgKTeAsGkgmQvavgoD//V2sZ1CBoWBL8ngYWBgErn
	6ex2HsjtwTmdzuiQ1fKAGKk4D9wYk3t1cB5U0cdzEGuup/lcM7x3A+LzdGhMKdEUn/4wdb9pnPg
	ipk+EC0D7gQYy/EvCH8IhsCWKu0FzmC8NobtWo+BUalXaSQH/FYomO55FEeaOOIVlHReVz6EsTA
	aMN+VcQvvYaeIu7SPQ1qtyM/L9Rsk4kqKsX+53FXC+8zkdFwEILYZxzaBdFLmaIrCgWgeuWzIv5
	KfSCjIa6SD12uZ31sDUfKHH45jKRwv80Vf88=
X-Google-Smtp-Source: AGHT+IHJr9x4tPHQB488BcmKjtF7JFP/uv+eKfUyu+Ss45vTGSVkFV0Ahpktarr49m9/oxGrmVivog==
X-Received: by 2002:a05:6000:3107:b0:3b9:16e5:bd38 with SMTP id ffacd0b85a97d-3b918c4cebcmr138431f8f.4.1755037461620;
        Tue, 12 Aug 2025 15:24:21 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:2::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abedesm46018339f8f.3.2025.08.12.15.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 15:24:19 -0700 (PDT)
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
Subject: [PATCH net-next V3 9/9] eth: fbnic: Report XDP stats via ethtool
Date: Tue, 12 Aug 2025 15:24:17 -0700
Message-ID: <20250812222417.268420-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250812220150.161848-1-mohsin.bashr@gmail.com>
References: <20250812220150.161848-1-mohsin.bashr@gmail.com>
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


