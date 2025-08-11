Return-Path: <bpf+bounces-65397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B757B217C2
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 23:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96901A20424
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 21:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3352E3B1C;
	Mon, 11 Aug 2025 21:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9H3H+sj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5524F2E3AEF;
	Mon, 11 Aug 2025 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754949430; cv=none; b=LjRNDIq0VvdYaVDZAkrlVYkGoDHzDBiXxuyXhrwhZAbLuFI7KRKQ0bWKlbdVuOJjohtqIbERkJUCIxXSgUTHhbnj6SGU/bfWBPIRjFUNk9URWuEVgrRIK32iCCkkGaVVM6a/msDZ9O06Rpgbp/jo+bx1eb4wEWQBGhW+FeE0vWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754949430; c=relaxed/simple;
	bh=VTu1YlP6cbBxPd8KlY7/RgMoLKQvCZlYMTO6Lr73lws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhEjb8sVLuASfd5mlH6XnFcHfke0aqqi3eupfl+524aXenne+g78SmpnUYbrt9UpqTRQD2K1mvWx2D/17CjrFpo524xACsu+/dArkmvFEAGSisElnxt/Ce7CXfhKxeoeCicr55+fyb8pihwNQfXMIJubB8qXzNg9J2KMTYPhJi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9H3H+sj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-459d4d7c745so44688705e9.1;
        Mon, 11 Aug 2025 14:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754949426; x=1755554226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtjUK0AZOjm4eF0vnry/hWr4fc/ZinEdNV9kmjIXNAY=;
        b=A9H3H+sjRH3SHEolvAxTDZFzalmqQohvCx9Zw5MPrOxoDpiQTnwPTM3+cLu+aJBA3Q
         oDsH5fFGiJ4GJ/6TRopGzgQ6Opl8NrjrC5/brfKHPRc179Sbh9O/l92Mr5S9GfNnuKcB
         HWHJ7Mgg+rV0Z2YJ1J+B9chwj3sYSPsb0OqD5BPLmdEQTdlgMYEM0KiPFCGeVVwcOpYY
         LpmoLAmEMEFmVY41bNflJkn3gNcMMKVeZ/htlDp1sdrT9LzM0moWYr5XW5iIkme0EsBh
         X2l28VMe2+bVnV9y3P1TkdHSoJkxgTEo0zcQ2PIm9ReZ4jrCYX+Ug/jy7FHUwVdG6v6u
         bD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754949426; x=1755554226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtjUK0AZOjm4eF0vnry/hWr4fc/ZinEdNV9kmjIXNAY=;
        b=K2xLE0PHx25fpCTYW5Xx0ldcbrwxmzY2jDKvrO14I/b1K9EUyYrgkRvaJxdRc9fIX3
         to1hAwYOgJtt4Bokm7WK3d3nsAbeCy16HeabTSaFx/4mRumjRYz74JX/9ayC34roAGnh
         ZKkAavTjN2WaDkYRgVtwM6U5CsYG2cpYKouThRzlPT2yOPSjqeLOJykoPaiKmZKeHMUz
         Z1E5MVZ9Gs2MJWPY9Vr1qGdu4+cBAhfwU/UgxDIRYbjwwOZ+VO456xMKv4bynlfpRMT4
         Y0ud8VjXY5yMkpBHnUBaQtu23WtNfqDa5zDvVW0wnBLXPdWbji2sOcjyL6lv1Bzs/gwu
         paVw==
X-Forwarded-Encrypted: i=1; AJvYcCV00Mz/mbdQTPGTtmAIzns38qA5czJoi3M/NptJHclpLxFMiCPTMp7p0B89gedB7yYzTyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiaJBRZaXGQnJkjbnX/MtLdsHtCX8AYmDdq2IGd9Se6bjNJ4W4
	oRl8PSY6GxTwRj6mBvxK8WDMMrRokOpOAS0FIvdgLkfvSTCQmaaLfXWeWafq9wVk
X-Gm-Gg: ASbGncsFf34lPlqd8Qp4Em/dnIrbNX2EDRPSGOzO5qw3Wwl3CJCzVrzM+DcbfXVCtpV
	DiaB2l0kGMRxr85T21sZF+WftWBQZpqVMTovEzbNg+Hjr4M66CYKX1FLkGqaG7YmeN3l+S/w0M2
	PQ7FNmVxozQhHn5660OQ6iaecb7rqiM4YePQHUFgtRtQmfRtmqWpRpAFcQCh7VnXRxXw//u/9RB
	Pp9lS80lJPCD7Vh5f2Bw8TlrEYNbq/kPdiF4Ym+v09lnBY1CJ4WcBJR1uUXbdrcKBcrUzx9j0En
	KyFryOVVMtrjueqnd3dRcVGXOpzPTCFC7se9gAFn2iCJKgP53zDz+WlKUdtozP7ZbshKNwDvhVK
	cZ6aVwLn/kD4DTRXLGR4=
X-Google-Smtp-Source: AGHT+IGzVY3VtjvHrvlwIemUXQkAqyXoAKgVgWE2uQMrAMznJ52e9vgWC5xGiEFYyN+ybcJz0L19ww==
X-Received: by 2002:a05:600c:3b97:b0:458:bfb1:1fb6 with SMTP id 5b1f17b1804b1-45a11e79ac3mr177265e9.2.1754949426086;
        Mon, 11 Aug 2025 14:57:06 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:7::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c485444sm42454096f8f.66.2025.08.11.14.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 14:57:05 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
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
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	vadim.fedorenko@linux.dev,
	aleksander.lobakin@intel.com
Subject: [PATCH net-next V2 9/9] eth: fbnic: Report XDP stats via ethtool
Date: Mon, 11 Aug 2025 14:57:03 -0700
Message-ID: <20250811215703.1065830-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250811211338.857992-1-mohsin.bashr@gmail.com>
References: <20250811211338.857992-1-mohsin.bashr@gmail.com>
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


