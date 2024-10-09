Return-Path: <bpf+bounces-41431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 802F399700C
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 17:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A5921F2165E
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 15:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BD01E8849;
	Wed,  9 Oct 2024 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWV8dWJK"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DC41E8832;
	Wed,  9 Oct 2024 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487764; cv=none; b=YVUV0U1UBkPJ6j3G0WO7yOXclM/hJgUIz3Ge9pN03e/MJeFbmuy62pqoBoJMdtYyMnqriGiqLhoiwNVwPM57afwP4DQ9x3Ffz+1fZyAW/j4g2iaEfruGP5gz0xNt5KoRaleAj53MbGAnjZi/zTn4jFIO7NMb7U6+Wtf4FdSI2c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487764; c=relaxed/simple;
	bh=LCEFH9KlY6JQ9yCP9DuaP4kDqbezbMoCnG4tID+CZ0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKNp3fjXdXwPjDun6ao7FderTNHfN662vkj1F2p3XiVTnkJAQ2QlvHAaEh0iAxh8A/UV1W6OQ7eRduVSFJGgHm+wqflcPyupufiUyxwDJxa8HwGROD6Ey9npKOi5CSOOaspf63HBOboUQlaYeURSi9Tt8fUbvr1qGBYA0GiAJwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWV8dWJK; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728487763; x=1760023763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LCEFH9KlY6JQ9yCP9DuaP4kDqbezbMoCnG4tID+CZ0U=;
  b=FWV8dWJKVfaXPJgjnNzz46HGS8F5FSurSqIW+1usc6hDHkT9IVaFZaBO
   tTV/3MNj6HleEZBaVsr/l8++ZPUZqazzdx6F+kpMHuV2YgchXWz20sqIt
   fbq23v+uu872PlchVDGqNUxP3ewIcsvzLAx9T1pVCwRuLxQyVwQo1FDgx
   QUvTqzU4Mw9tks6oVfX/TB4QeVPi3uvPBn/qeDRPb4LmQcvq0dcDHFpYj
   dmpiC6UZtZAaK7rT3vVP16QJugl6romJqN0ElGIUVE5X4BpFeVWXY60kp
   zZ33Pa2Imjf4WC3lc10Ol1Lt0bl3oRKtwYA8kTMDDydO/R6i+GU7AProE
   g==;
X-CSE-ConnectionGUID: ++1Jp371TIWRwVqHA8QXDA==
X-CSE-MsgGUID: mscUF9t6Twe6eKXc9dLYEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27675822"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="27675822"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 08:29:22 -0700
X-CSE-ConnectionGUID: iq3on9AhSMSfrodyWfGVeQ==
X-CSE-MsgGUID: H84xCq7rQsqxkQQqPq2Zkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="81306011"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 09 Oct 2024 08:29:19 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 12/18] xdp: add generic xdp_build_skb_from_buff()
Date: Wed,  9 Oct 2024 17:27:50 +0200
Message-ID: <20241009152756.3113697-13-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009152756.3113697-1-aleksander.lobakin@intel.com>
References: <20241009152756.3113697-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code which builds an skb from an &xdp_buff keeps multiplying itself
around the drivers with almost no changes. Let's try to stop that by
adding a generic function.
There's __xdp_build_skb_from_frame() already, so just convert it to take
&xdp_buff instead, while making the original one a wrapper. The original
one always took an already allocated skb, allow both variants here -- if
no skb passed, which is expected when calling from a driver, pick one via
napi_build_skb().

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/xdp.h |  1 +
 net/core/xdp.c    | 55 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index ae92af8b782d..fa56570b15d7 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -330,6 +330,7 @@ xdp_update_skb_shared_info(struct sk_buff *skb, u8 nr_frags,
 void xdp_warn(const char *msg, const char *func, const int line);
 #define XDP_WARN(msg) xdp_warn(msg, __func__, __LINE__)
 
+struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp);
 struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp);
 struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					   struct sk_buff *skb,
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 63f4f418e4e1..e5395048a925 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -614,6 +614,61 @@ void xdp_warn(const char *msg, const char *func, const int line)
 };
 EXPORT_SYMBOL_GPL(xdp_warn);
 
+/**
+ * xdp_build_skb_from_buff - create an skb from an &xdp_buff
+ * @xdp: &xdp_buff to convert to an skb
+ *
+ * Perform common operations to create a new skb to pass up the stack from
+ * an &xdp_buff: allocate an skb head from the NAPI percpu cache, initialize
+ * skb data pointers and offsets, set the recycle bit if the buff is PP-backed,
+ * Rx queue index, protocol and update frags info.
+ *
+ * Return: new &sk_buff on success, %NULL on error.
+ */
+struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
+{
+	const struct xdp_rxq_info *rxq = xdp->rxq;
+	const struct skb_shared_info *sinfo;
+	struct sk_buff *skb;
+	u32 nr_frags = 0;
+	int metalen;
+
+	if (unlikely(xdp_buff_has_frags(xdp))) {
+		sinfo = xdp_get_shared_info_from_buff(xdp);
+		nr_frags = sinfo->nr_frags;
+	}
+
+	skb = napi_build_skb(xdp->data_hard_start, xdp->frame_sz);
+	if (unlikely(!skb))
+		return NULL;
+
+	skb_reserve(skb, xdp->data - xdp->data_hard_start);
+	__skb_put(skb, xdp->data_end - xdp->data);
+
+	metalen = xdp->data - xdp->data_meta;
+	if (metalen > 0)
+		skb_metadata_set(skb, metalen);
+
+	if (is_page_pool_compiled_in() && rxq->mem.type == MEM_TYPE_PAGE_POOL)
+		skb_mark_for_recycle(skb);
+
+	skb_record_rx_queue(skb, rxq->queue_index);
+
+	if (unlikely(nr_frags)) {
+		u32 ts;
+
+		ts = sinfo->xdp_frags_truesize ? : nr_frags * xdp->frame_sz;
+		xdp_update_skb_shared_info(skb, nr_frags,
+					   sinfo->xdp_frags_size, ts,
+					   xdp_buff_is_frag_pfmemalloc(xdp));
+	}
+
+	skb->protocol = eth_type_trans(skb, rxq->dev);
+
+	return skb;
+}
+EXPORT_SYMBOL_GPL(xdp_build_skb_from_buff);
+
 struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					   struct sk_buff *skb,
 					   struct net_device *dev)
-- 
2.46.2


