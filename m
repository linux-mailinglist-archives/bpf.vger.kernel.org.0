Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F175F5978A8
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 23:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242274AbiHQVE4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 17:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242287AbiHQVEv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 17:04:51 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17FAAB4FB
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 14:04:48 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id f21so1049185pjt.2
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 14:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Lv5oDDXoP51M0FtVQV1jm/w40k3x4dVuENG348Cw/nw=;
        b=ZXSpm8lQbBrV+pU9U4pQEM3v4XLsgwAXKotmTp5zpOTDkVdKlyc1PHW2NqIaTuLID9
         zjWx0yK9Nf9DCOQUS4E5vWFC/5GOZEKuWPCQNm3NbjWvsTXeQtK+jF0yvay0Yhkfl7wp
         uCd/Y/GtWHw6FGX+R0eG4ApsZGRJ6Zu1cdApjTl1pSy9kKAyX8eg/a2Yp7EoIgxzpGEa
         0MGCBdWTPy/TFHVgy6eqioEsQsy9uxFOC0u0RBX8f/Da9M/j4nc39CsGAO5riu9i5HuF
         CaCsIbw7LqPMlu0gbj/IQaJfRHksrMb0FNBg4oFTfAugLITLAD8DZNWMLy/VY6VHN8go
         rNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Lv5oDDXoP51M0FtVQV1jm/w40k3x4dVuENG348Cw/nw=;
        b=Y3PytdM8B4KOYNInEixF91P1dzm/8Ga8Hf0pA91bJVo3h48ARMyJZHnCQ82hTsA1jo
         +Cnsf651Erz8vMq2zHhLiUPBDq1V0tG7ObLa1VM+WiUNRYGFz7kHsyFBYocWvVovTxwY
         een0K4g2WA8Iek0wNRIL7I54F+T3yiOvE3iM4nxE60NE8DhxSDPSvboekUFUEb1davCp
         rCQF19fwsdu3TjHknqiaPMIfL9F26pDATBKwZATtOXDJ7cvwiCui+Thwai7oMZeoIbxD
         wiQ8iT+jpY+8SShsBUIKgOH2YJDKlaqg4Q7UbALWLlx+SZUHbRI0X9slXiFCUFg57YPx
         3dZg==
X-Gm-Message-State: ACgBeo0kuaPYevfQXgMhJPx8Uz5SBiHksR4wieAvSC5glWLVwmaHk/8g
        2EDf3Ty+NmLG2kY/PqGKsPo=
X-Google-Smtp-Source: AA6agR5R8107j9CXk3t1Ru7cJ4EvMgwEyjWC6iEOO06AeiuQYxrSsdNX9l+nsIhYNHB8+KnEVmvG1Q==
X-Received: by 2002:a17:90b:4390:b0:1f7:2cb1:9e43 with SMTP id in16-20020a17090b439000b001f72cb19e43mr5542773pjb.91.1660770288439;
        Wed, 17 Aug 2022 14:04:48 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::1:ccd6])
        by smtp.gmail.com with ESMTPSA id h26-20020aa79f5a000000b0052d33bf14d6sm10934193pfr.63.2022.08.17.14.04.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Aug 2022 14:04:48 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 bpf-next 07/12] bpf: Optimize call_rcu in non-preallocated hash map.
Date:   Wed, 17 Aug 2022 14:04:14 -0700
Message-Id: <20220817210419.95560-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220817210419.95560-1-alexei.starovoitov@gmail.com>
References: <20220817210419.95560-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Doing call_rcu() million times a second becomes a bottle neck.
Convert non-preallocated hash map from call_rcu to SLAB_TYPESAFE_BY_RCU.
The rcu critical section is no longer observed for one htab element
which makes non-preallocated hash map behave just like preallocated hash map.
The map elements are released back to kernel memory after observing
rcu critical section.
This improves 'map_perf_test 4' performance from 100k events per second
to 250k events per second.

bpf_mem_alloc + percpu_counter + typesafe_by_rcu provide 10x performance
boost to non-preallocated hash map and make it within few % of preallocated map
while consuming fraction of memory.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/hashtab.c                      |  8 ++++++--
 kernel/bpf/memalloc.c                     |  2 +-
 tools/testing/selftests/bpf/progs/timer.c | 11 -----------
 3 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 65ebe5a719f5..3c1d15fd052a 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -944,8 +944,12 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 		__pcpu_freelist_push(&htab->freelist, &l->fnode);
 	} else {
 		dec_elem_count(htab);
-		l->htab = htab;
-		call_rcu(&l->rcu, htab_elem_free_rcu);
+		if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH) {
+			l->htab = htab;
+			call_rcu(&l->rcu, htab_elem_free_rcu);
+		} else {
+			htab_elem_free(htab, l);
+		}
 	}
 }
 
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 8de268922380..a43630371b9f 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -332,7 +332,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size)
 			return -ENOMEM;
 		size += LLIST_NODE_SZ; /* room for llist_node */
 		snprintf(buf, sizeof(buf), "bpf-%u", size);
-		kmem_cache = kmem_cache_create(buf, size, 8, 0, NULL);
+		kmem_cache = kmem_cache_create(buf, size, 8, SLAB_TYPESAFE_BY_RCU, NULL);
 		if (!kmem_cache) {
 			free_percpu(pc);
 			return -ENOMEM;
diff --git a/tools/testing/selftests/bpf/progs/timer.c b/tools/testing/selftests/bpf/progs/timer.c
index 5f5309791649..0053c5402173 100644
--- a/tools/testing/selftests/bpf/progs/timer.c
+++ b/tools/testing/selftests/bpf/progs/timer.c
@@ -208,17 +208,6 @@ static int timer_cb2(void *map, int *key, struct hmap_elem *val)
 		 */
 		bpf_map_delete_elem(map, key);
 
-		/* in non-preallocated hashmap both 'key' and 'val' are RCU
-		 * protected and still valid though this element was deleted
-		 * from the map. Arm this timer for ~35 seconds. When callback
-		 * finishes the call_rcu will invoke:
-		 * htab_elem_free_rcu
-		 *   check_and_free_timer
-		 *     bpf_timer_cancel_and_free
-		 * to cancel this 35 second sleep and delete the timer for real.
-		 */
-		if (bpf_timer_start(&val->timer, 1ull << 35, 0) != 0)
-			err |= 256;
 		ok |= 4;
 	}
 	return 0;
-- 
2.30.2

