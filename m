Return-Path: <bpf+bounces-75299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7168C7D230
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 15:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 110284E75CF
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 14:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EEE24A063;
	Sat, 22 Nov 2025 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LqzUKHwz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3611A9FB7
	for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763820525; cv=none; b=e6JkUiadPbskVOO2MXwqOIsaCeIvMeBokRrK4d2HoG3Bj8z3AgS58wOlL7okMof9rZqzEADBD60q9KdAoFT4XNyorNJqhGrrp9AIb7+iSsLtZz+4IMuxCAVrNaQN4RKsU9MeenBHRp+hxr1favjvZ927/3P0o9sBe1wLQ/+g92Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763820525; c=relaxed/simple;
	bh=hjk+o8o80paPyWfwSKG+PHyDrg8KCIKeJ6mVpIFxuBQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=h6AsBRy3kicGGc/wZdReA6K0YiF+E/XllZZu0v4mwOKYVd2BAzeJkqjmcWJK0llz6vAz3Tn1iEVzhd5bmJU6kQpdduivPlzejUmn8B0DkN5TngG+v379cITTBa6nwfKd+fjjCylzE548ghdNLCHkw1ij6GliIEiML5eSHY0FX/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LqzUKHwz; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-bc240cdb249so2458304a12.3
        for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 06:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763820523; x=1764425323; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CiKyvEObttkjdlU/HxkVL5YvXx0AELKfdJVDLDR7O7E=;
        b=LqzUKHwzKIMxLrCN8k3l8+ttT4HA8gh4yB11l9563KjsYhTj3wGIiLR4R8dpCPGuEe
         Bkwk4fqJVg/XH8Bf/Ti6krmrW5j4a/2IAfJDUcr7w+WL0h78Itex01u5MlyCBG7waUFb
         GGu+i9K9YCuZRE/V/pt4mX3rsluKeZoxV0fEoMnCKtOxLr09GFxUDoBMOsry9BpZcSui
         vGEFvF4Qv/8ythzf8zeAXXTq3qVyHK3U4lo8GdRT2SmE2AXDZ+2VbMUs2JvQv21fZaQn
         dE8YVqwRbGLrOjcSr1RsXsLI7fb9kneJLWfulXv8PBZaTT+J8WFbuOSwEBM8WIIl6Y2i
         yXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763820523; x=1764425323;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CiKyvEObttkjdlU/HxkVL5YvXx0AELKfdJVDLDR7O7E=;
        b=NRbHku7chJ3S5W4MBijKbjUitlCXWQ8JH+gsRNevw2fgYZwwYfRS6i40BJ5XyJXO7m
         weEqa9Hz/jDpPo/vxjGXcc7dCBBJUKhlfy61DzjtlgnMdLDC+Xe4WHoXJtRnqlewJyv5
         FxHk2F+KZdmXiUpP6oDV/WWAZxw0eVLbmcxOdZldVs83Cf8jJPvI1E9RKHs+HtTQCEre
         75dk9XH1JSJdFREfXNb41BOUHAwDzJJDBEjxIrTDsSm39WKXWMvh/eI60AQOeRcZV87q
         LWwHtjxhDv6qNl7VEUpIqwZUDfgMG+4m2Pv4pocrYFN4c1rIJFDwzP5chLNE0TWrNCf/
         Nw+A==
X-Forwarded-Encrypted: i=1; AJvYcCVkRaswNET97qRqN8Yr6p+XJCBTPvPeDnFL4dmk1LE4C3zrd0F+JX35bV4A+XorSgJw3Bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaEwD0onA0hM6KPC1NHhdKQEHIEIP4Dp344OkCeVJBh9D6WFtT
	HVGDszXeNqmwa8BGZ0W241JEmYZw2OnmXxcR7hFVO0siQX9JCg0HxndvtsDP5Qwwdwtzd4fZbp2
	jUaB6H44J1wNhbhGj/H4XhTvUQg==
X-Google-Smtp-Source: AGHT+IGiaUwHMiMte8op02BQ1Y7EuVvIJxvCeVDha4rnblhCSxc3V54Qj6e3HJk/7vwUWsfEzm3eiefI1xmjTS9oQQ==
X-Received: from dlbuy16.prod.google.com ([2002:a05:7022:1e10:b0:119:49ca:6b95])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:4a6:b0:119:e55a:9c05 with SMTP id a92af1059eb24-11c9d864ef6mr3230515c88.33.1763820523481;
 Sat, 22 Nov 2025 06:08:43 -0800 (PST)
Date: Sat, 22 Nov 2025 14:08:36 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251122140839.3922015-1-almasrymina@google.com>
Subject: [PATCH net-next v1] idpf: export RX hardware timestamping information
 to XDP
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: YiFei Zhu <zhuyifei@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Richard Cochran <richardcochran@gmail.com>, intel-wired-lan@lists.osuosl.org, 
	Mina Almasry <almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"

From: YiFei Zhu <zhuyifei@google.com>

The logic is similar to idpf_rx_hwtstamp, but the data is exported
as a BPF kfunc instead of appended to an skb.

A idpf_queue_has(PTP, rxq) condition is added to check the queue
supports PTP similar to idpf_rx_process_skb_fields.

Cc: intel-wired-lan@lists.osuosl.org

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 drivers/net/ethernet/intel/idpf/xdp.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index 21ce25b0567f..850389ca66b6 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2025 Intel Corporation */
 
 #include "idpf.h"
+#include "idpf_ptp.h"
 #include "idpf_virtchnl.h"
 #include "xdp.h"
 #include "xsk.h"
@@ -369,6 +370,31 @@ int idpf_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 				       idpf_xdp_tx_finalize);
 }
 
+static int idpf_xdpmo_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
+{
+	const struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc;
+	const struct libeth_xdp_buff *xdp = (typeof(xdp))ctx;
+	const struct idpf_rx_queue *rxq;
+	u64 cached_time, ts_ns;
+	u32 ts_high;
+
+	rx_desc = xdp->desc;
+	rxq = libeth_xdp_buff_to_rq(xdp, typeof(*rxq), xdp_rxq);
+
+	if (!idpf_queue_has(PTP, rxq))
+		return -ENODATA;
+	if (!(rx_desc->ts_low & VIRTCHNL2_RX_FLEX_TSTAMP_VALID))
+		return -ENODATA;
+
+	cached_time = READ_ONCE(rxq->cached_phc_time);
+
+	ts_high = le32_to_cpu(rx_desc->ts_high);
+	ts_ns = idpf_ptp_tstamp_extend_32b_to_64b(cached_time, ts_high);
+
+	*timestamp = ts_ns;
+	return 0;
+}
+
 static int idpf_xdpmo_rx_hash(const struct xdp_md *ctx, u32 *hash,
 			      enum xdp_rss_hash_type *rss_type)
 {
@@ -392,6 +418,7 @@ static int idpf_xdpmo_rx_hash(const struct xdp_md *ctx, u32 *hash,
 }
 
 static const struct xdp_metadata_ops idpf_xdpmo = {
+	.xmo_rx_timestamp	= idpf_xdpmo_rx_timestamp,
 	.xmo_rx_hash		= idpf_xdpmo_rx_hash,
 };
 

base-commit: e05021a829b834fecbd42b173e55382416571b2c
-- 
2.52.0.rc2.455.g230fcf2819-goog


