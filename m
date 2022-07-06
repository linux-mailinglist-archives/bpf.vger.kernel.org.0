Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03070568E78
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 17:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiGFP7T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 11:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiGFP7S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 11:59:18 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901102124A
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 08:59:17 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id r1so13980504plo.10
        for <bpf@vger.kernel.org>; Wed, 06 Jul 2022 08:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=akEDbMUXW18lVVQMnLNZ0DPKQK+T5iUzEbwO1jR/ako=;
        b=FXEJgVPiMgIv2LHB9IwzVjkuSs7SuJ7a1DMIa50+4kEVPvktNPnYJHR3fpD6Q9sSw2
         FrZS/+EIjUWwNreOb950nRMNfkIt7uH7fLHIKYhPeVgmnTP3VF+ENOQosxks6attZoeQ
         ge5QHZiiPluutYlz4CYAH0Mj8+ZYE6bfNHsnKkmwiGloSq8F6qsbB97bewQZCsh3ohmJ
         TvORLn6KlaOiQjqgiJcpFj+f+IzAyx58taO0pF/cF9dtz++DmM//RLwTBZPTZBblmygm
         Uh9tIzN7FMV1bXxAEgTQ9lbvvCWHlmX5slEgz+kG8+dcPpSZZXPvwWkJBhBk1WgVFYJ3
         ZTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akEDbMUXW18lVVQMnLNZ0DPKQK+T5iUzEbwO1jR/ako=;
        b=MaWP7cYzlBgTiIo3OW0keY0gBnNBk5d1XTCKgLJg/NeD20Zd6Z+6W94+AatZwNQWyW
         45TEBc4Hv9uZkFNCdr7kRx6162HCawhff/Unw2KMIXnwt3NADlFbhgv51rEXNP1a4Kt4
         cv3x4Ljmta5uc70aWyUPopU9xtuwk/9odfNMi7Z6sMAYeY+xr8FXzVx4McDJcYpVmdNy
         RZaILhsFfYl3eTYuc3fqXsHjJe+QfIpp19lw8EoWHTu4SbK5P9C/du3AevjPuedLBlfO
         jzRB28Bzorp2uaBZ+2RUOpMJihyOi/NT3qIPloKuPigNiPF5oMG49u6/cn/UuAXhG/om
         mymQ==
X-Gm-Message-State: AJIora9BHr6UwwQakhMQIXVubZbr9pH8U9io25sxkM8iFlH91c2YbnY5
        4wb3K5P3r3dCn2LE4QC2/OA=
X-Google-Smtp-Source: AGRyM1snHtZZfSlKUu7WDNCUWn+NAwcO4M3uUNYneopXFzAEKsGmMfdreFFMrbhM0NYfdFoNhlJVCg==
X-Received: by 2002:a17:902:d2c8:b0:16c:58d:7278 with SMTP id n8-20020a170902d2c800b0016c058d7278mr2434798plc.45.1657123157082;
        Wed, 06 Jul 2022 08:59:17 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:3e22:5400:4ff:fe0f:2b20])
        by smtp.gmail.com with ESMTPSA id n17-20020a056a0007d100b0051bada81bc7sm25000125pfu.161.2022.07.06.08.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 08:59:16 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, roman.gushchin@linux.dev, haoluo@google.com
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 1/2] bpf: Make non-preallocated allocation low priority
Date:   Wed,  6 Jul 2022 15:58:47 +0000
Message-Id: <20220706155848.4939-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220706155848.4939-1-laoar.shao@gmail.com>
References: <20220706155848.4939-1-laoar.shao@gmail.com>
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

GFP_ATOMIC doesn't cooperate well with memcg pressure so far, especially
if we allocate too much GFP_ATOMIC memory. For example, when we set the
memcg limit to limit a non-preallocated bpf memory, the GFP_ATOMIC can
easily break the memcg limit by force charge. So it is very dangerous to
use GFP_ATOMIC in non-preallocated case. One way to make it safe is to
remove __GFP_HIGH from GFP_ATOMIC, IOW, use (__GFP_ATOMIC |
__GFP_KSWAPD_RECLAIM) instead, then it will be limited if we allocate
too much memory.

We introduced BPF_F_NO_PREALLOC is because full map pre-allocation is
too memory expensive for some cases. That means removing __GFP_HIGH
doesn't break the rule of BPF_F_NO_PREALLOC, but has the same goal with
it-avoiding issues caused by too much memory. So let's remove it.

The force charge of GFP_ATOMIC was introduced in
commit 869712fd3de5 ("mm: memcontrol: fix network errors from failing
__GFP_ATOMIC charges") by checking __GFP_ATOMIC, then got improved in
commit 1461e8c2b6af ("memcg: unify force charging conditions") by
checking __GFP_HIGH (that is no problem because both __GFP_HIGH and
__GFP_ATOMIC are set in GFP_AOMIC). So, if we want to fix it in memcg,
we have to carefully verify all the callsites. Now that we can fix it in
BPF, we'd better not modify the memcg code.

This fix can also apply to other run-time allocations, for example, the
allocation in lpm trie, local storage and devmap. So let fix it
consistently over the bpf code

__GFP_KSWAPD_RECLAIM doesn't cooperate well with memcg pressure neither
currently. But the memcg code can be improved to make
__GFP_KSWAPD_RECLAIM work well under memcg pressure if desired.

It also fixes a typo in the comment.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 kernel/bpf/devmap.c        | 3 ++-
 kernel/bpf/hashtab.c       | 8 +++++---
 kernel/bpf/local_storage.c | 3 ++-
 kernel/bpf/lpm_trie.c      | 3 ++-
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index c2867068e5bd..7672946126d5 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -845,7 +845,8 @@ static struct bpf_dtab_netdev *__dev_map_alloc_node(struct net *net,
 	struct bpf_dtab_netdev *dev;
 
 	dev = bpf_map_kmalloc_node(&dtab->map, sizeof(*dev),
-				   GFP_ATOMIC | __GFP_NOWARN,
+				   __GFP_ATOMIC | __GFP_NOWARN |
+				   __GFP_KSWAPD_RECLAIM,
 				   dtab->map.numa_node);
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 17fb69c0e0dc..9d4559a1c032 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -61,7 +61,7 @@
  *
  * As regular device interrupt handlers and soft interrupts are forced into
  * thread context, the existing code which does
- *   spin_lock*(); alloc(GPF_ATOMIC); spin_unlock*();
+ *   spin_lock*(); alloc(GFP_ATOMIC); spin_unlock*();
  * just works.
  *
  * In theory the BPF locks could be converted to regular spinlocks as well,
@@ -978,7 +978,8 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 				goto dec_count;
 			}
 		l_new = bpf_map_kmalloc_node(&htab->map, htab->elem_size,
-					     GFP_ATOMIC | __GFP_NOWARN,
+					     __GFP_ATOMIC | __GFP_NOWARN |
+					     __GFP_KSWAPD_RECLAIM,
 					     htab->map.numa_node);
 		if (!l_new) {
 			l_new = ERR_PTR(-ENOMEM);
@@ -996,7 +997,8 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 		} else {
 			/* alloc_percpu zero-fills */
 			pptr = bpf_map_alloc_percpu(&htab->map, size, 8,
-						    GFP_ATOMIC | __GFP_NOWARN);
+						    __GFP_ATOMIC | __GFP_NOWARN |
+						    __GFP_KSWAPD_RECLAIM);
 			if (!pptr) {
 				kfree(l_new);
 				l_new = ERR_PTR(-ENOMEM);
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 8654fc97f5fe..534b69682b17 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -165,7 +165,8 @@ static int cgroup_storage_update_elem(struct bpf_map *map, void *key,
 	}
 
 	new = bpf_map_kmalloc_node(map, struct_size(new, data, map->value_size),
-				   __GFP_ZERO | GFP_ATOMIC | __GFP_NOWARN,
+				   __GFP_ZERO | __GFP_ATOMIC | __GFP_NOWARN |
+				   __GFP_KSWAPD_RECLAIM,
 				   map->numa_node);
 	if (!new)
 		return -ENOMEM;
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index f0d05a3cc4b9..7bae7133f1dd 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -285,7 +285,8 @@ static struct lpm_trie_node *lpm_trie_node_alloc(const struct lpm_trie *trie,
 	if (value)
 		size += trie->map.value_size;
 
-	node = bpf_map_kmalloc_node(&trie->map, size, GFP_ATOMIC | __GFP_NOWARN,
+	node = bpf_map_kmalloc_node(&trie->map, size, __GFP_ATOMIC |
+				    __GFP_KSWAPD_RECLAIM | __GFP_NOWARN,
 				    trie->map.numa_node);
 	if (!node)
 		return NULL;
-- 
2.17.1

