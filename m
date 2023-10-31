Return-Path: <bpf+bounces-13739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D83E7DD5BF
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 19:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D82A281941
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 18:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EF221354;
	Tue, 31 Oct 2023 18:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cDix8IGe"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84437208CF;
	Tue, 31 Oct 2023 18:04:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47ECA6;
	Tue, 31 Oct 2023 11:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698775475; x=1730311475;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UdyGd33bCOwd3XZxRaODc+ORSFQPBXnRQ1wnH5TGCrM=;
  b=cDix8IGeqFPw0PO/uqIHkv3ZR5kKo85WXvL9G9kXLfo4IcS5iJ5OQxyA
   WapHeIukgCcKq5g/OzOMIzjeSqydHddwpFCqBL/6AsxRJOI07I77Gaf/B
   IT9k/MLMzbiZcebSj8lMKJWLJiFLsstj5MTzkB+cJuSgFfDYidGZ9G7a4
   pJtLaYg5OjORKwPknm+WgYz/h32KZjzIf18j4Il/nYyJ4CCjTzOQndzx3
   VSOdOCvCCOMu+/y3avyFc9IeVTYfJXQoKDrjviFH9yvdnJOqDtnUoNm8g
   4YPdtY5d6M2+6lOdYSE4CqrCVFZIRUdER49Eyz0S5piyTfXkqJp7atoci
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="452633539"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="452633539"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 11:04:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="1092085564"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="1092085564"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga005.fm.intel.com with ESMTP; 31 Oct 2023 11:04:31 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 9D8A033E85;
	Tue, 31 Oct 2023 18:04:29 +0000 (GMT)
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
Subject: [PATCH bpf-next v2] net, xdp: allow metadata > 32
Date: Tue, 31 Oct 2023 18:57:37 +0100
Message-ID: <20231031175742.21455-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
v1->v2: replaced 'typeof(metalen)' with the actual type
This patch was previously a part of an old BTF-based hints RFC.
Then it was included into "XDP metadata via kfuncs for ice":
https://lore.kernel.org/bpf/20230811161509.19722-1-larysa.zaremba@intel.com/
It is not longer needed in the series, but presents a useful change on its own.

 include/linux/skbuff.h | 13 ++++++++-----
 include/net/xdp.h      |  7 ++++++-
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 97bfef071255..a361a9b8767c 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4232,10 +4232,13 @@ static inline bool __skb_metadata_differs(const struct sk_buff *skb_a,
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
@@ -4255,11 +4258,11 @@ static inline bool __skb_metadata_differs(const struct sk_buff *skb_a,
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


