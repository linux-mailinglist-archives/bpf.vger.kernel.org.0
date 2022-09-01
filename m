Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DB15A9CDF
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 18:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbiIAQQ2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 12:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbiIAQQV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 12:16:21 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88EB48E90
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 09:16:18 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so2878226pjq.3
        for <bpf@vger.kernel.org>; Thu, 01 Sep 2022 09:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Hi9c27URf1pim0nXbITJrtMXVEE20b16OwyheBVe8dg=;
        b=XDJedl0TGYJYEMVy+SyVZrTp/O0ndtJLPhArbdv2y/ghbv3KJ8YYlQHnQ0Xukf04B6
         W7zMc+TrDoxHUOa3tnD/NIF8Zg7iPT3MaNb9s58znIc3O4J3Gm+88RFCzT/okyZ3PtYo
         8k20sDJsM7qkH8Eu1gZ9rFQLG813EchbLB61KUF/e3sJBihspNEkzP12PpgECz6jJhB1
         +GYjLv1YG/uTABwbQEuZxyECdEIo4HMMohgO0cZbD5Edb0JmOVVF8Y8M8JBldyACK7hE
         hUiZAVV8GpKM6aU6D8butSKvqKtoU+dvKlTejL87tfFsxPeV4pTFXj4NXk+gv++7YRcR
         LV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Hi9c27URf1pim0nXbITJrtMXVEE20b16OwyheBVe8dg=;
        b=jV5W3CHy2aLsevH/nBmYgqUiq/GpOJSRodMZOJI3imfLVl1Eqc2RyXHyIE1hO/PX+J
         p6/m1Ti5yLBbj/m2aAcrO2Habot7u0IL087Z2SYfg75UA8rFysIE+h6a2/uNclFHhmoo
         AIbdVT+Osbh1pp4cfmTL6n+btRWUR4YcKUnH93sH86+03m4MhdJin0ZQanT4A6e53fKp
         uolH1DRayZyyI5sCoPbgva9hp/3i6aF4K7PPavtnohWPUOGTeapd87Pax4ZxoU+1LbQO
         1tK84dHrjK/4RwQkw4/uqjfJc4tq73Lw6fSswx81ej6Db4UN3lOPnzhaO21wK5Qw38n/
         nzAQ==
X-Gm-Message-State: ACgBeo2J6cR4FXORhDiPiiRWsdcnhSaD9rmg3/d6jvxV8FH50SGhDrB4
        P5rBkArSjRHIrNnMXg4n53268Bf6KV8=
X-Google-Smtp-Source: AA6agR650XYQ+ZYci8if+HgvgvoSid7GaHbT1zNas30DW/jmjziNiwSgptYBjFIoiScqrSZ9o5rXFg==
X-Received: by 2002:a17:90b:3b92:b0:1fe:b74:3de0 with SMTP id pc18-20020a17090b3b9200b001fe0b743de0mr9437271pjb.217.1662048977750;
        Thu, 01 Sep 2022 09:16:17 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::3:4dc5])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902680500b00174f7d10a03sm7612980plk.86.2022.09.01.09.16.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Sep 2022 09:16:17 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 07/15] bpf: Optimize call_rcu in non-preallocated hash map.
Date:   Thu,  1 Sep 2022 09:15:39 -0700
Message-Id: <20220901161547.57722-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901161547.57722-1-alexei.starovoitov@gmail.com>
References: <20220901161547.57722-1-alexei.starovoitov@gmail.com>
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

