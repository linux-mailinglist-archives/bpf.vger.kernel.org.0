Return-Path: <bpf+bounces-15964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A837FA949
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 19:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426C22817AF
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 18:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DB63DBA1;
	Mon, 27 Nov 2023 18:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HKzWHzH2"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA36CD4D;
	Mon, 27 Nov 2023 10:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701111103; x=1732647103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G6N5BWdcxTgKtZ03TKk2tuA+8QGXvp1vc8qUVDweir4=;
  b=HKzWHzH2UCH4x1VJtydW9azHbjzV6pJSt49ZQiRPcpSUuslEJ7zbVRrN
   7XB31hREIxs7fTd7bXFHQijeEsG5q7LkXQmn+WP/2knEcLwro/wVOiOXy
   eTjb78MnhxoXHg+wYRycsGfmHvA7HXAZ+2E9TUbzw9QgKBYQAvYAgnyXD
   8C0hIKustmIpOOdRzaIeqPdTIgY1u9GwgBc004PEZ883VoRwf5N6AdI97
   EAZuFjjQW8j7OZ2JQuGZJ0J7yIa0Pmh8npWtZSfdYkaRstWxuuPu8TNSB
   NJGNXW0qgrBR2jFhSTrAfY3aiGkC2XUNshVQoNuCtuJo2n4mtMgOql8fo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="392519041"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="392519041"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 10:51:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="891824103"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="891824103"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga004.jf.intel.com with ESMTP; 27 Nov 2023 10:51:39 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 92E5338D82;
	Mon, 27 Nov 2023 18:33:55 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Aleksander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH bpf-next v3 2/2] net, xdp: allow metadata > 32
Date: Mon, 27 Nov 2023 19:32:16 +0100
Message-ID: <20231127183216.269958-3-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231127183216.269958-1-larysa.zaremba@intel.com>
References: <20231127183216.269958-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aleksander Lobakin <aleksander.lobakin@intel.com>

32 bytes may be not enough for some custom metadata. Relax the restriction,
allow metadata larger than 32 bytes and make __skb_metadata_differs() work
with bigger lengths.

Now size of metadata is only limited by the fact it is stored as u8
in skb_shared_info, so the upper limit is now is 255. Other important
conditions, such as having enough space for xdp_frame building, are already
checked in bpf_xdp_adjust_meta().

The requirement of having its length aligned to 4 bytes is still
valid.

Signed-off-by: Aleksander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 include/linux/skbuff.h | 13 ++++++++-----
 include/net/xdp.h      |  7 ++++++-
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 27998f73183e..6520ac186d96 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4235,10 +4235,13 @@ static inline bool __skb_metadata_differs(const struct sk_buff *skb_a,
 {
 	const void *a = skb_metadata_end(skb_a);
 	const void *b = skb_metadata_end(skb_b);
-	/* Using more efficient varaiant than plain call to memcmp(). */
-#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && BITS_PER_LONG == 64
 	u64 diffs = 0;
 
+	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) ||
+	    BITS_PER_LONG != 64)
+		goto slow;
+
+	/* Using more efficient variant than plain call to memcmp(). */
 	switch (meta_len) {
 #define __it(x, op) (x -= sizeof(u##op))
 #define __it_diff(a, b, op) (*(u##op *)__it(a, op)) ^ (*(u##op *)__it(b, op))
@@ -4258,11 +4261,11 @@ static inline bool __skb_metadata_differs(const struct sk_buff *skb_a,
 		fallthrough;
 	case  4: diffs |= __it_diff(a, b, 32);
 		break;
+	default:
+slow:
+		return memcmp(a - meta_len, b - meta_len, meta_len);
 	}
 	return diffs;
-#else
-	return memcmp(a - meta_len, b - meta_len, meta_len);
-#endif
 }
 
 static inline bool skb_metadata_differs(const struct sk_buff *skb_a,
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 349c36fb5fd8..5d3673afc037 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -369,7 +369,12 @@ xdp_data_meta_unsupported(const struct xdp_buff *xdp)
 
 static inline bool xdp_metalen_invalid(unsigned long metalen)
 {
-	return (metalen & (sizeof(__u32) - 1)) || (metalen > 32);
+	unsigned long meta_max;
+
+	meta_max = type_max(typeof_member(struct skb_shared_info, meta_len));
+	BUILD_BUG_ON(!__builtin_constant_p(meta_max));
+
+	return !IS_ALIGNED(metalen, sizeof(u32)) || metalen > meta_max;
 }
 
 struct xdp_attachment_info {
-- 
2.41.0


