Return-Path: <bpf+bounces-4319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6141274A54C
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 22:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7B21C20E71
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 20:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1D91773E;
	Thu,  6 Jul 2023 20:48:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C45D17732;
	Thu,  6 Jul 2023 20:48:00 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015051992;
	Thu,  6 Jul 2023 13:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688676478; x=1720212478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NG2cngL/x7Rt47R4BiOY8tgcmkWfKkfzCGJz0+0qCQM=;
  b=FcmNtnucC2EwPctxsp6aKDq1+LBdgql6cqVQYwspuj2Vd0t/sIB0Di6t
   BMtjaFX0ffl9PNBe+9DXQ+jUrUR8Gqj+pVxOnaIk4aEvL5glCkPk4PZhs
   yiz7tzoZ8qd4WoYoeXcliRg1ck9Xj3FTfjMIT/im3er4a9vUqqfUpJCcU
   4RwEP1H3bZkLvM5dTRy37WGEuzZWpFfk5JF05WvxI3Vms9pPz/wnJn6/S
   YoZ4Jw4GsIwcRfWWufo+Ipk0CXTNLRK68qaFyPnOFisxJPy652P546hZe
   CaBQasDBOws3dcGvw6/ntbX0696swrKxAacVLNZ2Ysin2S4Q5LSWJJ4lV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="361195485"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="361195485"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 13:47:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="785059617"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="785059617"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jul 2023 13:47:56 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	tirthendu.sarkar@intel.com,
	maciej.fijalkowski@intel.com,
	simon.horman@corigine.com,
	toke@kernel.org
Subject: [PATCH v5 bpf-next 14/24] xsk: support ZC Tx multi-buffer in batch API
Date: Thu,  6 Jul 2023 22:46:40 +0200
Message-Id: <20230706204650.469087-15-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230706204650.469087-1-maciej.fijalkowski@intel.com>
References: <20230706204650.469087-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Modify xskq_cons_read_desc_batch() in a way that each processed
descriptor will be checked if it is an EOP one or not and act
accordingly to that.

Change the behavior of mentioned function to break the processing when
stumbling upon invalid descriptor instead of skipping it. Furthermore,
let us give only full packets down to ZC driver.
With these two assumptions ZC drivers will not have to take care of an
intermediate state of incomplete frames, which will simplify its
implementations a lot.

Last but not least, stop processing when count of frags would exceed
max supported segments on underlying device.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xsk_queue.h | 45 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index bac32027f865..13354a1e4280 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -48,6 +48,11 @@ struct xsk_queue {
 	size_t ring_vmalloc_size;
 };
 
+struct parsed_desc {
+	u32 mb;
+	u32 valid;
+};
+
 /* The structure of the shared state of the rings are a simple
  * circular buffer, as outlined in
  * Documentation/core-api/circular-buffers.rst. For the Rx and
@@ -218,30 +223,52 @@ static inline void xskq_cons_release_n(struct xsk_queue *q, u32 cnt)
 	q->cached_cons += cnt;
 }
 
-static inline u32 xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
-					    u32 max)
+static inline void parse_desc(struct xsk_queue *q, struct xsk_buff_pool *pool,
+			      struct xdp_desc *desc, struct parsed_desc *parsed)
+{
+	parsed->valid = xskq_cons_is_valid_desc(q, desc, pool);
+	parsed->mb = xp_mb_desc(desc);
+}
+
+static inline
+u32 xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
+			      u32 max)
 {
 	u32 cached_cons = q->cached_cons, nb_entries = 0;
 	struct xdp_desc *descs = pool->tx_descs;
+	u32 total_descs = 0, nr_frags = 0;
 
+	/* track first entry, if stumble upon *any* invalid descriptor, rewind
+	 * current packet that consists of frags and stop the processing
+	 */
 	while (cached_cons != q->cached_prod && nb_entries < max) {
 		struct xdp_rxtx_ring *ring = (struct xdp_rxtx_ring *)q->ring;
 		u32 idx = cached_cons & q->ring_mask;
+		struct parsed_desc parsed;
 
 		descs[nb_entries] = ring->desc[idx];
-		if (unlikely(!xskq_cons_is_valid_desc(q, &descs[nb_entries], pool))) {
-			/* Skip the entry */
-			cached_cons++;
-			continue;
+		cached_cons++;
+		parse_desc(q, pool, &descs[nb_entries], &parsed);
+		if (unlikely(!parsed.valid))
+			break;
+
+		if (likely(!parsed.mb)) {
+			total_descs += (nr_frags + 1);
+			nr_frags = 0;
+		} else {
+			nr_frags++;
+			if (nr_frags == pool->netdev->xdp_zc_max_segs) {
+				nr_frags = 0;
+				break;
+			}
 		}
-
 		nb_entries++;
-		cached_cons++;
 	}
 
+	cached_cons -= nr_frags;
 	/* Release valid plus any invalid entries */
 	xskq_cons_release_n(q, cached_cons - q->cached_cons);
-	return nb_entries;
+	return total_descs;
 }
 
 /* Functions for consumers */
-- 
2.34.1


