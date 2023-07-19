Return-Path: <bpf+bounces-5298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C36B87596E2
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 15:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC5228102A
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 13:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D9923BF7;
	Wed, 19 Jul 2023 13:25:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FD223BCE;
	Wed, 19 Jul 2023 13:25:27 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B565B113;
	Wed, 19 Jul 2023 06:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689773125; x=1721309125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NG2cngL/x7Rt47R4BiOY8tgcmkWfKkfzCGJz0+0qCQM=;
  b=a4B4CAhCiMWLpLj8505u1NoO9MxhZ90Lpurd4Uj2fBn1O3MmQt5y0LdT
   umVHaJnJC+iYVJzQMO3fZCcELSUEdQfndEneD0DA9UrfZl52hdwHMh3Po
   a6qgKA4/AlLhvP4/9eTTO6BH9EEgYP9zOWXl0IZf7vWRKnZXkXljclzT2
   6S9wVId/bBF2SDKlTdFd2u8eNDUix8fx0FkDI/OmZ5fTWoibyYV38PVLW
   uFRUH1CLXU3OTNLsBJbXiIwsoIl+AAGR40z2FRPk6r2D1SIdI8N3owibg
   w97d8mL/K/qEa1eDbphtsB+DygivP6bNU33xSrMd3gsM7Y3VWJlbffP0g
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="363920684"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="363920684"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 06:25:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="717978159"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="717978159"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga007.jf.intel.com with ESMTP; 19 Jul 2023 06:25:13 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	toke@kernel.org,
	kuba@kernel.org,
	horms@kernel.org,
	tirthendu.sarkar@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v7 bpf-next 14/24] xsk: support ZC Tx multi-buffer in batch API
Date: Wed, 19 Jul 2023 15:24:11 +0200
Message-Id: <20230719132421.584801-15-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230719132421.584801-1-maciej.fijalkowski@intel.com>
References: <20230719132421.584801-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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


