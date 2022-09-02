Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6BB5AB9E8
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 23:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiIBVLa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Sep 2022 17:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiIBVL3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Sep 2022 17:11:29 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E5BD9D61
        for <bpf@vger.kernel.org>; Fri,  2 Sep 2022 14:11:28 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id h13-20020a17090a648d00b001fdb9003787so3253984pjj.4
        for <bpf@vger.kernel.org>; Fri, 02 Sep 2022 14:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Hi9c27URf1pim0nXbITJrtMXVEE20b16OwyheBVe8dg=;
        b=nyFySNHumtyDaweiI+wNTYPdjXY4BWQ5NMBx6KD1Di1w5aRHVPoya18N/Yob/nJRMV
         Ej0pB0XqLQYQmQvtykjgk1DQB61/qClKmCDa3Zj84fpp8j0LenGF6J14RxIhYhiHClyW
         rHUHyZhbeXGDvofOyEyMBvl1OqHmp5qubQhTOmWauiwetrBMhrNLPTkwb1Tsz9BKAnXr
         zPj6V6eRqsk556gpWrGvuJ9I7N4dwMd3YkFdZfngQiA+rNu+Td0z9UGee+vMJ7PDoBVy
         osXSykYoyOqeke8GXVuGwy/zaZTK+pgGMJgXNrZy1I5t0yNI/AyDr3dRzLPPQqlOohDR
         Rsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Hi9c27URf1pim0nXbITJrtMXVEE20b16OwyheBVe8dg=;
        b=ht0ZM1abUKG/Dw1HlC4QETVOHN7tEKyQlHlfc017h6oI8tl/5G4sYXaSn/2mCaBfI3
         VVFwnIteOLsSDFM9/iONhHJWk5fcFENmeUgJ+X9jjtH1pzS4WNXbe+McYLKTCVqqKmyW
         YWj6tPTH9bY8jh2WuG7hIOko7FIM/dERkf9v4rvZJL4AA6WVP7uJjPNlfKO1qe8K85EV
         tkW+pDoCs9P+Kqo+o42qRbge1lPWybfpdV8kK6Fj5Ham+kTClngklEnR1sMpVt706j8U
         RyIiw+CXLZtNh6s4Tt2AXeiZEJJIJrpZ1qPgP0OBToT3ItH3E6jSYgeDy1yRX1ixvmpC
         UjPg==
X-Gm-Message-State: ACgBeo0yvIolvHzE4bnCEobIxQ+uVLqO5Ecp4U54TrWdSHFo38+NHnMM
        CTjDz44i9mBHsJ5xcqeMe4w=
X-Google-Smtp-Source: AA6agR4/CNjzZToCIrBs+WK1cPrm9fRUH+9ploLNwUeCp+ww/syu2X08rs6IDZXIBu0jo1zvoe1IEw==
X-Received: by 2002:a17:90a:a415:b0:1fa:749f:ecfb with SMTP id y21-20020a17090aa41500b001fa749fecfbmr6923222pjp.112.1662153088165;
        Fri, 02 Sep 2022 14:11:28 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::c978])
        by smtp.gmail.com with ESMTPSA id y20-20020aa78f34000000b00537b8aa0a46sm2356076pfr.96.2022.09.02.14.11.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Sep 2022 14:11:27 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 bpf-next 07/16] bpf: Optimize call_rcu in non-preallocated hash map.
Date:   Fri,  2 Sep 2022 14:10:49 -0700
Message-Id: <20220902211058.60789-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220902211058.60789-1-alexei.starovoitov@gmail.com>
References: <20220902211058.60789-1-alexei.starovoitov@gmail.com>
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

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/hashtab.c                      |  8 ++++++--
 kernel/bpf/memalloc.c                     |  2 +-
 tools/testing/selftests/bpf/progs/timer.c | 11 -----------
 3 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 36aa16dc43ad..0d888a90a805 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -953,8 +953,12 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
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
index 1c46763d855e..da0721f8c28f 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -281,7 +281,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size)
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

