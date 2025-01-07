Return-Path: <bpf+bounces-48134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ADCA044A6
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 16:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24CBD3A76F0
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2211F7076;
	Tue,  7 Jan 2025 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XyRiXiQ9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2901EE005;
	Tue,  7 Jan 2025 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263912; cv=none; b=lgxO3+dHGD35VkfTJSXgZsz7e8agPkuqjYOTw8YRzARORSiTzIEVMdOnHTJmPq+lahimANI/KKlv8oOrZnrL5XQCz4+jZuQ2DUhb3XH8nGyknQojQbZSQ1W1JR9KWCGYZamvMxDhW8NUIdcpFyYQ+tRLedc3t29f5egv6v1Kfhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263912; c=relaxed/simple;
	bh=0sR/99KRA3uFOX+Nf43kw7ZFqZnZ15E1sW+l26uxc+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmAf7j7LVwjRoHR1Y9bi9p0AF6f89Zfd7l4ErwWecbIkyAKZPCLP10B1u+wmCIjozhOPb0U4gIzhqEtLyPDegcfeVf8AN/bLqxVG7Do66scwH8db/L3+qDpcwCVjvdGT/5FS1x4z2LvrsbZEduEOO5leDZ8C6Gpg4hUAkEGO4Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XyRiXiQ9; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736263908; x=1767799908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0sR/99KRA3uFOX+Nf43kw7ZFqZnZ15E1sW+l26uxc+A=;
  b=XyRiXiQ9FQfV58cLW4ripHNMPaBhXi6z2fIV5l+uKA7VRK6nzjidxebq
   wiguRbWuVQ48ZbYRE3LlJNaeZHUoq4vRkegcNANkWENk/wv6wFfvUrzHU
   Yu05UAMnNg4Le4tG2oB+tRFnmNlBc818baNdIwwfEgLXJ2FwX4KP3J6Z1
   LoOvdaoycbLzV2YnskGaWaGLwSInEqrmQNoAs/PFANMZTLdCy7UTNn6q9
   Prp2YbGOqI/hYgbs0w3tTyXBak6EOCQg4xDYzSRh1dPkpjrrZ999PpDv8
   Zu6Pcm8UVDZNmGnSelxpbNuIwtYdYSWKAJl36PF8dpiPhejauB6cOiQ2W
   A==;
X-CSE-ConnectionGUID: swH9dXo3RQSYzAM1MIv1kQ==
X-CSE-MsgGUID: oD73s8XKRau/bDtVrrtNKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="35685902"
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; 
   d="scan'208";a="35685902"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 07:31:35 -0800
X-CSE-ConnectionGUID: uLPvjOufREqR8kXHh3lYNA==
X-CSE-MsgGUID: AlQEMmPLQBSykwSk4HA4YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103646972"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 07 Jan 2025 07:31:31 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 7/8] veth: use napi_skb_cache_get_bulk() instead of xdp_alloc_skb_bulk()
Date: Tue,  7 Jan 2025 16:29:39 +0100
Message-ID: <20250107152940.26530-8-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107152940.26530-1-aleksander.lobakin@intel.com>
References: <20250107152940.26530-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we can bulk-allocate skbs from the NAPI cache, use that
function to do that in veth as well instead of direct allocation from
the kmem caches. veth uses NAPI and GRO, so this is both context-safe
and beneficial.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/veth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 01251868a9c2..7634ee8843bc 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -684,8 +684,7 @@ static void veth_xdp_rcv_bulk_skb(struct veth_rq *rq, void **frames,
 	void *skbs[VETH_XDP_BATCH];
 	int i;
 
-	if (xdp_alloc_skb_bulk(skbs, n_xdpf,
-			       GFP_ATOMIC | __GFP_ZERO) < 0) {
+	if (unlikely(!napi_skb_cache_get_bulk(skbs, n_xdpf))) {
 		for (i = 0; i < n_xdpf; i++)
 			xdp_return_frame(frames[i]);
 		stats->rx_drops += n_xdpf;
-- 
2.47.1


