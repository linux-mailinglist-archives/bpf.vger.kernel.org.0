Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0CD59A7EB
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 23:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiHSVmo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 17:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiHSVmo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 17:42:44 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A29810E799
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 14:42:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c2so5165356plo.3
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 14:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=DB/TYi6+dkOmK19tEIPXNQRA+MB2a2IbEFWliUNeEu8=;
        b=I3BC4qvSpRZy/Za86lRfd3dZyHz2E2X7+Zgz68m4kYn9WlssEZ17khve9pczdJDK7N
         vw/TGP0hoQXpIpZQbQiqD0MiwX+jNP4OqpAWNdIvV6pkzFArLjAdMTdZJrZ21Tb5TlQC
         WAOPka1VrnciztMz8b0RZsM6eve4VMneZwAtW/FAC4lRmYaflPUMSl/2N+x0/6bks26M
         8atASL0/0ip8MEp/hPxxVigGmDmzF+CtTUIwBNGqC9/QeVJ3DbrGu+RyvNj/iE3RoH1/
         WQkQaVu8tJxMdtCxAL8hjACeOTRD3KJu2BNKX/RHX596ShBmeoHb+8HVIsUXk7aBZI+V
         mZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DB/TYi6+dkOmK19tEIPXNQRA+MB2a2IbEFWliUNeEu8=;
        b=tR4/CH3c+pjtVB9oLX2BLs6oJzkkyqwMBgRsFV5Nx4ylBPfU+fZmMWXtPDcuS2/K7c
         7nzo/oNomnUcgw1GOt3bN9nH05jLzIgWiARZ47MJXdHYm78Jgn6eO19wgbHNywvUkM5c
         CoJ+K3smVLI2+sCApbD1RjoBbrJsvoNCv6eQ7foCXhmrrKyRHZq6slWGIqZ5sQ+Y2Fzq
         Sz0L+e6gdSmhc7/AqDlowzRszcJibRtwoOWDrWgX0FGCrJGjwsDQ4H2TYWd5JMpWcHx0
         O2oTfQCWVE1+RWxatRT+j+rkWLihbpbwsL9BzU8foFVrn19R9TxQKd7xcZ/3lmAYIRxf
         ssBg==
X-Gm-Message-State: ACgBeo1ny7opmJniNMz9n52fuCfyDGxqrlAiT2NxQ7WOwb8amjW1dbrm
        m30Y3LoCD81Y4RUV51oAXjk=
X-Google-Smtp-Source: AA6agR6EcXVBwH4FRcz5zQ0ds7wQ5sfrqP4e5JMj4aW3I0FYrktzqq90TCS0DrTvnsXrIzz1PL2IAA==
X-Received: by 2002:a17:902:d2c3:b0:16e:ea56:7840 with SMTP id n3-20020a170902d2c300b0016eea567840mr9183680plc.142.1660945362784;
        Fri, 19 Aug 2022 14:42:42 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::1:c4b1])
        by smtp.gmail.com with ESMTPSA id q18-20020a63d612000000b0041d628dde58sm3226219pgg.30.2022.08.19.14.42.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Aug 2022 14:42:42 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 02/15] bpf: Convert hash map to bpf_mem_alloc.
Date:   Fri, 19 Aug 2022 14:42:19 -0700
Message-Id: <20220819214232.18784-3-alexei.starovoitov@gmail.com>
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

Convert bpf hash map to use bpf memory allocator.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/hashtab.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index b301a63afa2f..bd23c8830d49 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -14,6 +14,7 @@
 #include "percpu_freelist.h"
 #include "bpf_lru_list.h"
 #include "map_in_map.h"
+#include <linux/bpf_mem_alloc.h>
 
 #define HTAB_CREATE_FLAG_MASK						\
 	(BPF_F_NO_PREALLOC | BPF_F_NO_COMMON_LRU | BPF_F_NUMA_NODE |	\
@@ -92,6 +93,7 @@ struct bucket {
 
 struct bpf_htab {
 	struct bpf_map map;
+	struct bpf_mem_alloc ma;
 	struct bucket *buckets;
 	void *elems;
 	union {
@@ -563,6 +565,10 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 			if (err)
 				goto free_prealloc;
 		}
+	} else {
+		err = bpf_mem_alloc_init(&htab->ma, htab->elem_size);
+		if (err)
+			goto free_map_locked;
 	}
 
 	return &htab->map;
@@ -573,6 +579,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	for (i = 0; i < HASHTAB_MAP_LOCK_COUNT; i++)
 		free_percpu(htab->map_locked[i]);
 	bpf_map_area_free(htab->buckets);
+	bpf_mem_alloc_destroy(&htab->ma);
 free_htab:
 	lockdep_unregister_key(&htab->lockdep_key);
 	bpf_map_area_free(htab);
@@ -849,7 +856,7 @@ static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l)
 	if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
 		free_percpu(htab_elem_get_ptr(l, htab->map.key_size));
 	check_and_free_fields(htab, l);
-	kfree(l);
+	bpf_mem_cache_free(&htab->ma, l);
 }
 
 static void htab_elem_free_rcu(struct rcu_head *head)
@@ -973,9 +980,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 				l_new = ERR_PTR(-E2BIG);
 				goto dec_count;
 			}
-		l_new = bpf_map_kmalloc_node(&htab->map, htab->elem_size,
-					     GFP_NOWAIT | __GFP_NOWARN,
-					     htab->map.numa_node);
+		l_new = bpf_mem_cache_alloc(&htab->ma);
 		if (!l_new) {
 			l_new = ERR_PTR(-ENOMEM);
 			goto dec_count;
@@ -994,7 +999,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			pptr = bpf_map_alloc_percpu(&htab->map, size, 8,
 						    GFP_NOWAIT | __GFP_NOWARN);
 			if (!pptr) {
-				kfree(l_new);
+				bpf_mem_cache_free(&htab->ma, l_new);
 				l_new = ERR_PTR(-ENOMEM);
 				goto dec_count;
 			}
@@ -1489,6 +1494,7 @@ static void htab_map_free(struct bpf_map *map)
 	bpf_map_free_kptr_off_tab(map);
 	free_percpu(htab->extra_elems);
 	bpf_map_area_free(htab->buckets);
+	bpf_mem_alloc_destroy(&htab->ma);
 	for (i = 0; i < HASHTAB_MAP_LOCK_COUNT; i++)
 		free_percpu(htab->map_locked[i]);
 	lockdep_unregister_key(&htab->lockdep_key);
-- 
2.30.2

