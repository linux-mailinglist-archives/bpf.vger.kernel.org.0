Return-Path: <bpf+bounces-76956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BE2CCA155
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 03:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 081E23028F40
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 02:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADA22FC86B;
	Thu, 18 Dec 2025 02:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="auPdLCaL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1172F83D8
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 02:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766024995; cv=none; b=nJA+YH60aEal/+END1HnK6yPq0LA65sYkVLOcvb3qip8Y96K79EgKI5Oeb/tSiWjwPt2TC6nk+ISxA2F0hIPcO0IsaODuwpHtAht2h4A3GepxlWWyCj1w4x9cemd1Qp101o+fbF4hvN+wtZ2ygKktpsYwjCGn1qKLXKIOOrQriM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766024995; c=relaxed/simple;
	bh=zlziAxvPwJj8HgeZzSpcXhPCekluk2rCReJ0Fw/8umI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UVjfrtdeIuEsl5MVGiNcyr9Ai3uYe3Em1rNUwo7b7ZLK0o0RIyZ4aUdnWxFfDVy48HrEgk51pa1G+Va7XJvkVq7E9XMvwQqKZMAdkMFQb5jW31KcJM22NmNwSIMbLN7Xi7o3/StFtnNJ6vogdZ8oCtoqhETNK4o++wlhuqko8ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=auPdLCaL; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b80de683efso356243b3a.3
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 18:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766024993; x=1766629793; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mbkt/LgClY9Ed+U/AqFg7ozVmIhVbSqVhAx0YrbLQGM=;
        b=auPdLCaLlkQy1M/9nZdm6uFAKeS7L18O3gf6MxeCrUa3GCPDKcnXGec8Dgx0IUN+2h
         JF7sGTiJqVE9U4QSixNOhow+OX+Q3vrxmJZgsgga1GQRplD7VxCtvFe/sB1uE47fPL83
         +ra7aEqWsQ1RSVWi4zFov6YuI8wlJwXCtGp0C/Wvp0pEzDyt1e1Im6bM/QwRrBS9qaYB
         zD540uwf/HPJqlWxgJ39x+cACzJVOvT0f4i4ap0EbJQmRjbD3njiBiphGi73th6rsq0w
         Xh5+pRXwCNCpT1IPTU8HKQgEXOXlonyPE+dfoX5KTLI2FxNdnC9wfVTuhsBSGDJg7PiJ
         mE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766024993; x=1766629793;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mbkt/LgClY9Ed+U/AqFg7ozVmIhVbSqVhAx0YrbLQGM=;
        b=VmYg1QbiyGuuIeFe5tN/aXqwvLfUE3V6FxqI8AujHq8KDTkcRiTpIxz90OX+WU0q+P
         k4IkYNesBI4sLx4Al2IradXrUrjqEDRtLI51whDfRZBPo5qs30Adud1JD3OGcNiysMx4
         4TySHAoC8L/Z3zsYcKXin5q7J2XnXPPZlob3YYzcyQ3hvI6/Xs3WNHI4zgai/9blvreQ
         r6qXVQhTsiKaONw0CPZOCmOJj3kSRtnpyIY7CnnphWFF8Ak7NxaG5HmCTuym0btZXnAS
         R2FfZ5ozi11TtLCOMCu9CCDyO95wbfVA99Iz3xhJgEpHLMDv/5o88iMKrbP8R+k38HTv
         xvhg==
X-Forwarded-Encrypted: i=1; AJvYcCUPpHoCq9/CyCWQzy+r17xjBI7LqbV7K0VngLC0XKLlc82k2WtbSpCj5JGF/XKXoBZBGQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjyzkwKhlGMW6yMWrtnBZr6i+rpxS8NjTeS+eN9KbMmmh+DaV5
	3vIYtG3YSqb7j3btqIFQGYOLgWB845qikQL8qi1Af+k2vF6nTYCA+VSDsG7N5UBj8h3IZJfWyte
	4FWHH/AurzVvtji//VSMtQpoEQA==
X-Google-Smtp-Source: AGHT+IFE6xajScfzbLpRFiQQS67W5ZN8gStF0mO1QPIpwdD4OiKSevZ12bwmQxwPQs3VZazL0vtBUS/b7RY63UwVGw==
X-Received: from dlbrj5.prod.google.com ([2002:a05:7022:f405:b0:11f:2e2e:de3])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2902:b0:11b:8f02:a876 with SMTP id a92af1059eb24-11f354cce50mr11251803c88.23.1766024992932;
 Wed, 17 Dec 2025 18:29:52 -0800 (PST)
Date: Thu, 18 Dec 2025 02:29:36 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.313.g674ac2bdf7-goog
Message-ID: <20251218022948.3288897-1-almasrymina@google.com>
Subject: [PATCH net-next v2] idpf: export RX hardware timestamping information
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
	Mina Almasry <almasrymina@google.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"

From: YiFei Zhu <zhuyifei@google.com>

The logic is similar to idpf_rx_hwtstamp, but the data is exported
as a BPF kfunc instead of appended to an skb.

A idpf_queue_has(PTP, rxq) condition is added to check the queue
supports PTP similar to idpf_rx_process_skb_fields.

Cc: intel-wired-lan@lists.osuosl.org

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

---

v2: https://lore.kernel.org/netdev/20251122140839.3922015-1-almasrymina@google.com/
- Fixed alphabetical ordering
- Use the xdp desc type instead of virtchnl one (required some added
  helpers)

---
 drivers/net/ethernet/intel/idpf/xdp.c | 29 +++++++++++++++++++++++++++
 drivers/net/ethernet/intel/idpf/xdp.h | 17 ++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index 958d16f87424..7744d6898f74 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2025 Intel Corporation */
 
 #include "idpf.h"
+#include "idpf_ptp.h"
 #include "idpf_virtchnl.h"
 #include "xdp.h"
 #include "xsk.h"
@@ -391,8 +392,36 @@ static int idpf_xdpmo_rx_hash(const struct xdp_md *ctx, u32 *hash,
 				    pt);
 }
 
+static int idpf_xdpmo_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
+{
+	const struct libeth_xdp_buff *xdp = (typeof(xdp))ctx;
+	struct idpf_xdp_rx_desc desc __uninitialized;
+	const struct idpf_rx_queue *rxq;
+	u64 cached_time, ts_ns;
+	u32 ts_high;
+
+	idpf_xdp_get_qw1(&desc, xdp->desc);
+	rxq = libeth_xdp_buff_to_rq(xdp, typeof(*rxq), xdp_rxq);
+
+	if (!idpf_queue_has(PTP, rxq))
+		return -ENODATA;
+	if (!(idpf_xdp_rx_ts_low(&desc) & VIRTCHNL2_RX_FLEX_TSTAMP_VALID))
+		return -ENODATA;
+
+	cached_time = READ_ONCE(rxq->cached_phc_time);
+
+	idpf_xdp_get_qw3(&desc, xdp->desc);
+
+	ts_high = idpf_xdp_rx_ts_high(&desc);
+	ts_ns = idpf_ptp_tstamp_extend_32b_to_64b(cached_time, ts_high);
+
+	*timestamp = ts_ns;
+	return 0;
+}
+
 static const struct xdp_metadata_ops idpf_xdpmo = {
 	.xmo_rx_hash		= idpf_xdpmo_rx_hash,
+	.xmo_rx_timestamp	= idpf_xdpmo_rx_timestamp,
 };
 
 void idpf_xdp_set_features(const struct idpf_vport *vport)
diff --git a/drivers/net/ethernet/intel/idpf/xdp.h b/drivers/net/ethernet/intel/idpf/xdp.h
index 479f5ef3c604..86be6cae9689 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.h
+++ b/drivers/net/ethernet/intel/idpf/xdp.h
@@ -112,11 +112,13 @@ struct idpf_xdp_rx_desc {
 	aligned_u64		qw1;
 #define IDPF_XDP_RX_BUF		GENMASK_ULL(47, 32)
 #define IDPF_XDP_RX_EOP		BIT_ULL(1)
+#define IDPF_XDP_RX_TS_LOW	GENMASK_ULL(31, 24)
 
 	aligned_u64		qw2;
 #define IDPF_XDP_RX_HASH	GENMASK_ULL(31, 0)
 
 	aligned_u64		qw3;
+#define IDPF_XDP_RX_TS_HIGH	GENMASK_ULL(63, 32)
 } __aligned(4 * sizeof(u64));
 static_assert(sizeof(struct idpf_xdp_rx_desc) ==
 	      sizeof(struct virtchnl2_rx_flex_desc_adv_nic_3));
@@ -128,6 +130,8 @@ static_assert(sizeof(struct idpf_xdp_rx_desc) ==
 #define idpf_xdp_rx_buf(desc)	FIELD_GET(IDPF_XDP_RX_BUF, (desc)->qw1)
 #define idpf_xdp_rx_eop(desc)	!!((desc)->qw1 & IDPF_XDP_RX_EOP)
 #define idpf_xdp_rx_hash(desc)	FIELD_GET(IDPF_XDP_RX_HASH, (desc)->qw2)
+#define idpf_xdp_rx_ts_low(desc)	FIELD_GET(IDPF_XDP_RX_TS_LOW, (desc)->qw1)
+#define idpf_xdp_rx_ts_high(desc)	FIELD_GET(IDPF_XDP_RX_TS_HIGH, (desc)->qw3)
 
 static inline void
 idpf_xdp_get_qw0(struct idpf_xdp_rx_desc *desc,
@@ -166,6 +170,19 @@ idpf_xdp_get_qw2(struct idpf_xdp_rx_desc *desc,
 #endif
 }
 
+static inline void
+idpf_xdp_get_qw3(struct idpf_xdp_rx_desc *desc,
+		 const struct virtchnl2_rx_flex_desc_adv_nic_3 *rxd)
+{
+#ifdef __LIBETH_WORD_ACCESS
+	desc->qw3 = ((const typeof(desc))rxd)->qw3;
+#else
+	desc->qw3 = ((u64)le32_to_cpu(rxd->ts_high) << 32) |
+		    ((u64)le16_to_cpu(rxd->fmd6) << 16) |
+		    le16_to_cpu(rxd->l2tag1);
+#endif
+}
+
 void idpf_xdp_set_features(const struct idpf_vport *vport);
 
 int idpf_xdp(struct net_device *dev, struct netdev_bpf *xdp);

base-commit: 8f7aa3d3c7323f4ca2768a9e74ebbe359c4f8f88
-- 
2.52.0.313.g674ac2bdf7-goog


