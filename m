Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FF96AB899
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 09:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjCFImo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 03:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjCFImm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 03:42:42 -0500
Received: from out-63.mta1.migadu.com (out-63.mta1.migadu.com [95.215.58.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BED32197A
        for <bpf@vger.kernel.org>; Mon,  6 Mar 2023 00:42:40 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678092158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jtss5LJMscJIu0BKahkxUY02PtUx65WAWlv0onfntHg=;
        b=OZGTUlsrIP17meJbt1OowJxt1Xj3koVBs7ZRQRLg+0xukVnH/YHYAcp40PkjHc8fGmRjeO
        1Qkep/hYwloLVrVnnr1P/vWnjykOyDYe2zSxLK4sUNoo04sxNQxSQ1sUOj4NRb/X4O31iT
        nh3VWkGhjhDmPLHguJJ58HmQGvmB0go=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Subject: [PATCH bpf-next 03/16] bpf: Remove __bpf_local_storage_map_alloc
Date:   Mon,  6 Mar 2023 00:42:03 -0800
Message-Id: <20230306084216.3186830-4-martin.lau@linux.dev>
In-Reply-To: <20230306084216.3186830-1-martin.lau@linux.dev>
References: <20230306084216.3186830-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

bpf_local_storage_map_alloc() is the only caller of
__bpf_local_storage_map_alloc().  The remaining logic in
bpf_local_storage_map_alloc() is only a one liner setting
the smap->cache_idx.

Remove __bpf_local_storage_map_alloc() to simplify code.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/bpf_local_storage.c | 63 ++++++++++++++--------------------
 1 file changed, 26 insertions(+), 37 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 4d2bc7c97f7d..acedf6b07c54 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -601,40 +601,6 @@ int bpf_local_storage_map_alloc_check(union bpf_attr *attr)
 	return 0;
 }
 
-static struct bpf_local_storage_map *__bpf_local_storage_map_alloc(union bpf_attr *attr)
-{
-	struct bpf_local_storage_map *smap;
-	unsigned int i;
-	u32 nbuckets;
-
-	smap = bpf_map_area_alloc(sizeof(*smap), NUMA_NO_NODE);
-	if (!smap)
-		return ERR_PTR(-ENOMEM);
-	bpf_map_init_from_attr(&smap->map, attr);
-
-	nbuckets = roundup_pow_of_two(num_possible_cpus());
-	/* Use at least 2 buckets, select_bucket() is undefined behavior with 1 bucket */
-	nbuckets = max_t(u32, 2, nbuckets);
-	smap->bucket_log = ilog2(nbuckets);
-
-	smap->buckets = bpf_map_kvcalloc(&smap->map, sizeof(*smap->buckets),
-					 nbuckets, GFP_USER | __GFP_NOWARN);
-	if (!smap->buckets) {
-		bpf_map_area_free(smap);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	for (i = 0; i < nbuckets; i++) {
-		INIT_HLIST_HEAD(&smap->buckets[i].list);
-		raw_spin_lock_init(&smap->buckets[i].lock);
-	}
-
-	smap->elem_size = offsetof(struct bpf_local_storage_elem,
-				   sdata.data[attr->value_size]);
-
-	return smap;
-}
-
 int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 				    const struct btf *btf,
 				    const struct btf_type *key_type,
@@ -694,10 +660,33 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 			    struct bpf_local_storage_cache *cache)
 {
 	struct bpf_local_storage_map *smap;
+	unsigned int i;
+	u32 nbuckets;
+
+	smap = bpf_map_area_alloc(sizeof(*smap), NUMA_NO_NODE);
+	if (!smap)
+		return ERR_PTR(-ENOMEM);
+	bpf_map_init_from_attr(&smap->map, attr);
+
+	nbuckets = roundup_pow_of_two(num_possible_cpus());
+	/* Use at least 2 buckets, select_bucket() is undefined behavior with 1 bucket */
+	nbuckets = max_t(u32, 2, nbuckets);
+	smap->bucket_log = ilog2(nbuckets);
 
-	smap = __bpf_local_storage_map_alloc(attr);
-	if (IS_ERR(smap))
-		return ERR_CAST(smap);
+	smap->buckets = bpf_map_kvcalloc(&smap->map, sizeof(*smap->buckets),
+					 nbuckets, GFP_USER | __GFP_NOWARN);
+	if (!smap->buckets) {
+		bpf_map_area_free(smap);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	for (i = 0; i < nbuckets; i++) {
+		INIT_HLIST_HEAD(&smap->buckets[i].list);
+		raw_spin_lock_init(&smap->buckets[i].lock);
+	}
+
+	smap->elem_size = offsetof(struct bpf_local_storage_elem,
+				   sdata.data[attr->value_size]);
 
 	smap->cache_idx = bpf_local_storage_cache_idx_get(cache);
 	return &smap->map;
-- 
2.30.2

