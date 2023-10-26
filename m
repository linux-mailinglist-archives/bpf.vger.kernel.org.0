Return-Path: <bpf+bounces-13341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207207D872D
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 19:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4D68B2132D
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 17:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E775381D9;
	Thu, 26 Oct 2023 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iADv91EP"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAE8381C9;
	Thu, 26 Oct 2023 17:04:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F821B5;
	Thu, 26 Oct 2023 10:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698339845; x=1729875845;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uOwmvX9Y5Cas5qzMbqeNsCEyT4PVaRx4nrMBxydXsAY=;
  b=iADv91EPJTijd3/NyYoI6Awua5gaIvME6erc45m5qFbbOwIpcr7+KgU1
   OQfgfkpkxitXDukMXciZccNdeJrAbYg5s8sqIRghl0uFqPacOKcSddQx7
   aCL4+maEK8WxjnXCr/fRBJ3OFYyPCYQ0pxq4bj3cxGdGq8NBmLjzknWD2
   kVjPS15eV3XMdv7G/0wVpoPT1S+3V213QrSon6h3NYS8hJxPy9BoswmEL
   p8OiT+14kdNdoF3iJLaWCauIDWnoG1E7pgOzXXgtrrz4EoMKEQwBoRySv
   JCzrpVpcOwuo3d3HZ/lVEfJplleaEUV59wtRfS2hGyjxf6z4CJ0JieLu3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="454064382"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="454064382"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 10:04:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="1090653128"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="1090653128"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga005.fm.intel.com with ESMTP; 26 Oct 2023 10:04:00 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 5C56144288;
	Thu, 26 Oct 2023 18:03:58 +0100 (IST)
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
	Simon Horman <simon.horman@corigine.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Aleksander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH bpf-next] net, xdp: allow metadata > 32
Date: Thu, 26 Oct 2023 18:56:59 +0200
Message-ID: <20231026165701.65878-1-larysa.zaremba@intel.com>
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
index 349c36fb5fd8..84ba1bb50b8e 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -369,7 +369,12 @@ xdp_data_meta_unsupported(const struct xdp_buff *xdp)
 
 static inline bool xdp_metalen_invalid(unsigned long metalen)
 {
-	return (metalen & (sizeof(__u32) - 1)) || (metalen > 32);
+	typeof(metalen) meta_max;
+
+	meta_max = type_max(typeof_member(struct skb_shared_info, meta_len));
+	BUILD_BUG_ON(!__builtin_constant_p(meta_max));
+
+	return !IS_ALIGNED(metalen, sizeof(u32)) || metalen > meta_max;
 }
 
 struct xdp_attachment_info {
-- 
2.41.0


