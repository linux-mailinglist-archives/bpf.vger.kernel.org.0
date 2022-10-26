Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5507860DD87
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 10:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbiJZIvS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 04:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbiJZIvR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 04:51:17 -0400
Received: from mx.der-flo.net (mx.der-flo.net [IPv6:2001:67c:26f4:224::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9377DF75
        for <bpf@vger.kernel.org>; Wed, 26 Oct 2022 01:51:14 -0700 (PDT)
Received: by mx.der-flo.net (Postfix, from userid 110)
        id 13485160A68; Wed, 26 Oct 2022 10:51:13 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from localhost (unknown [IPv6:2a02:1210:22e1:1f00:fb89:69cb:433e:eb56])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mx.der-flo.net (Postfix) with ESMTPSA id 4364A160A49;
        Wed, 26 Oct 2022 10:51:11 +0200 (CEST)
From:   Florian Lehner <dev@der-flo.net>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, Florian Lehner <dev@der-flo.net>
Subject: [PATCH bpf-next] bpf: check max_entries before allocating memory
Date:   Wed, 26 Oct 2022 10:50:53 +0200
Message-Id: <20221026085053.76561-1-dev@der-flo.net>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For maps of type BPF_MAP_TYPE_CPUMAP memory is allocated first before
checking the max_entries argument. If then max_entries is greater than
NR_CPUS additional work needs to be done to free allocated memory before
an error is returned.
This changes moves the check on max_entries before the allocation
happens.

Signed-off-by: Florian Lehner <dev@der-flo.net>
---
 kernel/bpf/cpumap.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index b5ba34ddd4b6..87e9f89a8140 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -97,29 +97,26 @@ static struct bpf_map *cpu_map_alloc(union bpf_attr *attr)
 	    attr->map_flags & ~BPF_F_NUMA_NODE)
 		return ERR_PTR(-EINVAL);
 
+	/* Pre-limit array size based on NR_CPUS, not final CPU check */
+	if (attr->max_entries > NR_CPUS)
+		return ERR_PTR(-E2BIG);
+
 	cmap = bpf_map_area_alloc(sizeof(*cmap), NUMA_NO_NODE);
 	if (!cmap)
 		return ERR_PTR(-ENOMEM);
 
 	bpf_map_init_from_attr(&cmap->map, attr);
 
-	/* Pre-limit array size based on NR_CPUS, not final CPU check */
-	if (cmap->map.max_entries > NR_CPUS) {
-		err = -E2BIG;
-		goto free_cmap;
-	}
-
 	/* Alloc array for possible remote "destination" CPUs */
 	cmap->cpu_map = bpf_map_area_alloc(cmap->map.max_entries *
 					   sizeof(struct bpf_cpu_map_entry *),
 					   cmap->map.numa_node);
-	if (!cmap->cpu_map)
-		goto free_cmap;
+	if (!cmap->cpu_map) {
+		bpf_map_area_free(cmap);
+		return ERR_PTR(err);
+	}
 
 	return &cmap->map;
-free_cmap:
-	bpf_map_area_free(cmap);
-	return ERR_PTR(err);
 }
 
 static void get_cpu_map_entry(struct bpf_cpu_map_entry *rcpu)
-- 
2.37.3

