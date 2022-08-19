Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BA359A7E6
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 23:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbiHSVnD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 17:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbiHSVnC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 17:43:02 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9928510E7AD
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 14:43:01 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 12so4661123pga.1
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 14:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=R7CCPPKWPgzyGKsplgrBfSdH/nOmKmQ7KDErBAIDa18=;
        b=W109X9RhtblogGbY/aVlPs1Y4LZp8SnbcvVkgcoF8tC4PawP3w35jFiqmf99IA4VfR
         lNl6t9GtQBMfrrLFXxkGSfCj5BGXJg/Afiw91kdLkjh44GEkUw3CyszIGlkf2dAxLOV8
         IsTsIhRf6AIjxIS6Or2OPut3RHRKf/6bv0PxJYrg5tNq8EQvIRtTqGZDMwEegLFAjJlu
         R7EXthDU0ZmhTptdSHzFdiW57EwqU0bMHyHzcgiV96oBiqNly4eCk+bDi753HCZ6s8cF
         XSzINLFY2+KEGJonLOROpd4rFrRv8rvHafNS0iH3L/JZrlU8AtjdKMZ35S/7t/AdBMuV
         dhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=R7CCPPKWPgzyGKsplgrBfSdH/nOmKmQ7KDErBAIDa18=;
        b=QnAVUjTzJPYV2W8OOruFw2yH7NDRm+MmAljFZ71cDZrsxlnygm/Gk7KauGlbPckLDE
         DRl4cZ8E+K07MXl+fFK0cbPt+pNo3SHFToYeLvBjHQvnJawbqUr+6EpdFgso05wjwFtv
         hspzKubD+ZO9zqUc4CTE/3kdg0CZuMjdH9KzawAGk4aPRC5b53+ZfujxasWMBPsTJMTO
         TzxHxmQzcd/q3eJYDY+Fq0FdW45dNjMeVYcRSFDirPLKAW2maGeY74wuQ91pLs3WaKEu
         HorHEJNIE3fzaOd+zSyIEKQinBCauyENEnfcHST4izSFcxYzme9U9p8CxSmk7rgNkNOR
         B++w==
X-Gm-Message-State: ACgBeo0OaakwItvfLaZjr5OPP5rOxzrT3zfj4sgHEelSO0J/v0SzMDsM
        cKaqf2lztqfg8lIpC901+3Q=
X-Google-Smtp-Source: AA6agR601MFqy59cpbHMqgqpRSfKpiJoe5v62VbSTaZ9Yb5MeIfvR/bq2hylOcfwGkv2xgu4gTHZ/Q==
X-Received: by 2002:a62:1c81:0:b0:52f:ccb5:9de1 with SMTP id c123-20020a621c81000000b0052fccb59de1mr9648921pfc.45.1660945380983;
        Fri, 19 Aug 2022 14:43:00 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::1:c4b1])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090301cd00b0016ef6c2375fsm3620437plh.217.2022.08.19.14.42.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Aug 2022 14:43:00 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 07/15] bpf: Optimize call_rcu in non-preallocated hash map.
Date:   Fri, 19 Aug 2022 14:42:24 -0700
Message-Id: <20220819214232.18784-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
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
index 293380eaea41..cfa07f539eda 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -276,7 +276,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size)
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

