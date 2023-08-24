Return-Path: <bpf+bounces-8513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 458B17878D0
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 21:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F361C2816B3
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 19:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48871E50F;
	Thu, 24 Aug 2023 19:34:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6851E506;
	Thu, 24 Aug 2023 19:34:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F501B0;
	Thu, 24 Aug 2023 12:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692905666; x=1724441666;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5p/6LrkVhD1srZ1C0shnBPSltvtTeK9faThdhrldm0U=;
  b=ABrFOlPFBsrWUqU1217NM390Lp8oONkyGtoPX+AqR48XFW36oEXB8f3w
   3qb+I8YLTaamjsJkX637WfpqNI0/3tA59CNCVtlfVw2I4FzO1EUq5L1gh
   TPV59vIUoAPcWxixRykh3lBAHs2dBdoiau40Wj0LvashPXF62HF8bSVFP
   6U2nds7Y1ExiA8WfPYuvcYSTvMHSugjir3oI3CjWTh87wqJnb77fRUIZj
   HiZCZlKVejHWgyuh6VTv6zeg5JDrLjaWgIg69Dse3yiEZThJj7J/FCyAw
   Gc4Gz5R7uZSkf/1Tr499fuVl1bkmlUnr7oeqh/+GJCj044Y+hcBq36pT+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="354865386"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="354865386"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 12:34:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="860830553"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="860830553"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga004.jf.intel.com with ESMTP; 24 Aug 2023 12:34:19 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id C38A133EA3;
	Thu, 24 Aug 2023 20:34:17 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maryam Tahhan <mtahhan@redhat.com>,
	xdp-hints@xdp-project.net,
	netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Simon Horman <simon.horman@corigine.com>,
	Tariq Toukan <tariqt@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	Aleksander Lobakin <aleksander.lobakin@intel.com>
Subject: [RFC bpf-next 15/23] net, xdp: allow metadata > 32
Date: Thu, 24 Aug 2023 21:26:54 +0200
Message-ID: <20230824192703.712881-16-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824192703.712881-1-larysa.zaremba@intel.com>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Aleksander Lobakin <aleksander.lobakin@intel.com>

When using XDP hints, metadata sometimes has to be much bigger
than 32 bytes. Relax the restriction, allow metadata larger than 32 bytes
and make __skb_metadata_differs() work with bigger lengths.

Now size of metadata is only limited by the fact it is stored as u8
in skb_shared_info, so maximum possible value is 255. Other important
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
index aa57e2eca33b..0e455678cb8a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4216,10 +4216,13 @@ static inline bool __skb_metadata_differs(const struct sk_buff *skb_a,
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
@@ -4239,11 +4242,11 @@ static inline bool __skb_metadata_differs(const struct sk_buff *skb_a,
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
index 495c4d2a2c50..05234f156a73 100644
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


