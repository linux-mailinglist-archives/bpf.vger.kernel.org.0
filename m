Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68275A1F0C
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 04:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbiHZCpE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 22:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244846AbiHZCpD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 22:45:03 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229041835A
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:45:02 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p9-20020a17090a2d8900b001fb86ec43aaso293467pjd.0
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=PaPuYu1jW6l30jyUgEzf6fCeC16QOg08yHB4Ew2HdVM=;
        b=GRWpSaM70EZmvKMlFNvW71O+vyfhIii8KVD3IfMCQDb8TiWvtRl//AZ0NMAoAnkp52
         lCPxgH8uRmBE7iuNdblxsUTzr7XnprwwQjuPsDEZL2N9jm1C53QVEzWXezafTMsByITm
         0MHH6PmJRDm1vOWc76ZZ/IprpTh2GBWLqeDp3HNMbXLUh7shyvKYYYWnqKuKU95tGXWY
         gufIxRKVaOfKTpoqxebuo+OYy+AZ8LDWxoZ6QPFjF73r5Ljl9f8+nn/N1HNXc31xx52/
         dECetY7+9Fmelb70kDDTVQh9MGPbJ8LK4ubKuMnUws8UqnwmbIyhAxbTElaqiIMWFrN3
         MMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=PaPuYu1jW6l30jyUgEzf6fCeC16QOg08yHB4Ew2HdVM=;
        b=rQydIk0L+2OayCHBcea5f0dHf0AtHrcKH/KhDl+63Vd1UPi7z71eCTuZ9ugGnq6nTL
         UoNyQMCZFeYNPnNJiU4UF8rQ/9WtP1ZFyakQOa1qI564zdMxn3OurqQoWQQBrtC46lj4
         1LOIBAmNz7qvhg7JfCs6PQTsysFU9745h4MY5txpe8KPj/xAW//pT7BmzfW9UgzYDY3l
         Q+IT3eij++lcBqm4J2g8/ALw8O+duPnxXwkiNPgqFv4wX/LrmMn35Yy0eeDxvWIzUwiN
         U3gaWgh+auEm+dPu7CCKOBjCM1Ku1GOqbzncMiToxeCiXLVnXk8dUNPqHhc3ix1xUhCc
         biAg==
X-Gm-Message-State: ACgBeo3ONW6pysW75d1vc04TVOm7jZzrrn+4RQYmTzHzbU9EgYZuIZBc
        yVu0eBemJa/9XvS7ufex/SA=
X-Google-Smtp-Source: AA6agR5R7JS+PwvjO3raqPgX79bYewUm8RfaJcq/kT1isr5WF/WqZYncmh5vmqWXfYf/7p1jNenqbA==
X-Received: by 2002:a17:90a:de96:b0:1fa:e427:e18e with SMTP id n22-20020a17090ade9600b001fae427e18emr2152653pjv.116.1661481901540;
        Thu, 25 Aug 2022 19:45:01 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:15dc])
        by smtp.gmail.com with ESMTPSA id k6-20020a170902ce0600b0015e8d4eb1dbsm292164plg.37.2022.08.25.19.45.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Aug 2022 19:45:01 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 07/15] bpf: Optimize call_rcu in non-preallocated hash map.
Date:   Thu, 25 Aug 2022 19:44:22 -0700
Message-Id: <20220826024430.84565-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
References: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
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
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/hashtab.c                      |  8 ++++++--
 kernel/bpf/memalloc.c                     |  2 +-
 tools/testing/selftests/bpf/progs/timer.c | 11 -----------
 3 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 8f68c6e13339..299ab98f9811 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -940,8 +940,12 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
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
index 29f340016e9e..c1817f14c25a 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -277,7 +277,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size)
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

