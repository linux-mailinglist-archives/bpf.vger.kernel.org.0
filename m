Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2898956CA63
	for <lists+bpf@lfdr.de>; Sat,  9 Jul 2022 17:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiGIPpH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Jul 2022 11:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGIPpF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Jul 2022 11:45:05 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C3C1A3BB
        for <bpf@vger.kernel.org>; Sat,  9 Jul 2022 08:45:03 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id x22so1007703qkf.13
        for <bpf@vger.kernel.org>; Sat, 09 Jul 2022 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bkLct7+3x09q3TPrw9hr1g7AQwWmVQubLfPgu28Dhr0=;
        b=Q7yw0wFIPOJflUJiXHOo6vvgX5eAazVsQSyQo+3EM00n1vjxcSp0MPsktNjtXotXyb
         SCUm1SVXetSbg2CthqfDdW9tiiO05DFrQ7Cci270NKwZx45jnez/jmMz8iXGo5yMH6ns
         QP8p9SLRrv/9zuJ2IRfvXUBoggIehg3rBCQzNJd8e4fCoc2EiF+aFxN+A98p4M6qmWad
         HPgtddGUzz5sAScyXjvzJHvbb8mgTVJqDLbr0pwjNSeR3zpKLDjrTPgvWm7yeojDvnIH
         EfdXzndAdsmgSOGiFn2q7vCUx554Y9wFypQ0mpHKwERHFyhIdTBC9uipsW03M9EybnJC
         3+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bkLct7+3x09q3TPrw9hr1g7AQwWmVQubLfPgu28Dhr0=;
        b=RpcWuT2pFleuYXUSBpdFvBiJSXnn5ak/cbbwf3kkh8ZfFS/3d2MXGjQgqqZbb7Kuvn
         y36Vhqvph8GBWW+jrP6LlLyS1PK57pNoP/ARZB1HeWaBvcIpCfNaLnuj2vLxJ2ib9HvP
         04OrUbFAmgIwihd3sDcY/79/JppqwD5j9B2R92PGnc24DtBSFu6q1j+Ir3cHPRbeMdH2
         Lnn0Z8PlHugRKNh8l74ubV58F5HC10F5v2fxzbeYPWIYqBnWk7MVq027ST7tr6MfkB9X
         Yt2pO6hm45NTCzwl1aANpVjYhO+ogx3wxPxjmZ21/xdqYUh8sNGddfna3ooyx/XbJF1M
         QV4Q==
X-Gm-Message-State: AJIora94O8jalB/kJ0Dc1GycCYcNMhdG7WDUTS6mfbHf9JZC8kZD0Ru0
        AYgl5eSWv3HPkeJxWtibiDM=
X-Google-Smtp-Source: AGRyM1vM2NyKCJqvfdCCZjo75kvFKaaQ+FzJQlbCqBZZqXIDAZhZWRqSBi7BW6ePAsZ4AE6yx2IjCQ==
X-Received: by 2002:a05:620a:258a:b0:6a7:9479:655e with SMTP id x10-20020a05620a258a00b006a79479655emr5699121qko.681.1657381502269;
        Sat, 09 Jul 2022 08:45:02 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:5:6e4b:5400:4ff:fe10:17bb])
        by smtp.gmail.com with ESMTPSA id u14-20020a05620a430e00b006a6a6f148e6sm1682411qko.17.2022.07.09.08.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 08:45:01 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, roman.gushchin@linux.dev, haoluo@google.com,
        shakeelb@google.com
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>, NeilBrown <neilb@suse.de>
Subject: [PATCH bpf-next v3 1/2] bpf: Make non-preallocated allocation low priority
Date:   Sat,  9 Jul 2022 15:44:56 +0000
Message-Id: <20220709154457.57379-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220709154457.57379-1-laoar.shao@gmail.com>
References: <20220709154457.57379-1-laoar.shao@gmail.com>
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
too much memory. There's a plan to completely remove __GFP_ATOMIC in the
mm side[1], so let's use GFP_NOWAIT instead.

We introduced BPF_F_NO_PREALLOC is because full map pre-allocation is
too memory expensive for some cases. That means removing __GFP_HIGH
doesn't break the rule of BPF_F_NO_PREALLOC, but has the same goal with
it-avoiding issues caused by too much memory. So let's remove it.

This fix can also apply to other run-time allocations, for example, the
allocation in lpm trie, local storage and devmap. So let fix it
consistently over the bpf code

It also fixes a typo in the comment.

[1]. https://lore.kernel.org/linux-mm/163712397076.13692.4727608274002939094@noble.neil.brown.name/

Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: NeilBrown <neilb@suse.de>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/devmap.c        | 2 +-
 kernel/bpf/hashtab.c       | 6 +++---
 kernel/bpf/local_storage.c | 2 +-
 kernel/bpf/lpm_trie.c      | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index c2867068e5bd..1400561efb15 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -845,7 +845,7 @@ static struct bpf_dtab_netdev *__dev_map_alloc_node(struct net *net,
 	struct bpf_dtab_netdev *dev;
 
 	dev = bpf_map_kmalloc_node(&dtab->map, sizeof(*dev),
-				   GFP_ATOMIC | __GFP_NOWARN,
+				   GFP_NOWAIT | __GFP_NOWARN,
 				   dtab->map.numa_node);
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 17fb69c0e0dc..da7578426a46 100644
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
@@ -978,7 +978,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 				goto dec_count;
 			}
 		l_new = bpf_map_kmalloc_node(&htab->map, htab->elem_size,
-					     GFP_ATOMIC | __GFP_NOWARN,
+					     GFP_NOWAIT | __GFP_NOWARN,
 					     htab->map.numa_node);
 		if (!l_new) {
 			l_new = ERR_PTR(-ENOMEM);
@@ -996,7 +996,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 		} else {
 			/* alloc_percpu zero-fills */
 			pptr = bpf_map_alloc_percpu(&htab->map, size, 8,
-						    GFP_ATOMIC | __GFP_NOWARN);
+						    GFP_NOWAIT | __GFP_NOWARN);
 			if (!pptr) {
 				kfree(l_new);
 				l_new = ERR_PTR(-ENOMEM);
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 8654fc97f5fe..49ef0ce040c7 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -165,7 +165,7 @@ static int cgroup_storage_update_elem(struct bpf_map *map, void *key,
 	}
 
 	new = bpf_map_kmalloc_node(map, struct_size(new, data, map->value_size),
-				   __GFP_ZERO | GFP_ATOMIC | __GFP_NOWARN,
+				   __GFP_ZERO | GFP_NOWAIT | __GFP_NOWARN,
 				   map->numa_node);
 	if (!new)
 		return -ENOMEM;
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index f0d05a3cc4b9..d789e3b831ad 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -285,7 +285,7 @@ static struct lpm_trie_node *lpm_trie_node_alloc(const struct lpm_trie *trie,
 	if (value)
 		size += trie->map.value_size;
 
-	node = bpf_map_kmalloc_node(&trie->map, size, GFP_ATOMIC | __GFP_NOWARN,
+	node = bpf_map_kmalloc_node(&trie->map, size, GFP_NOWAIT | __GFP_NOWARN,
 				    trie->map.numa_node);
 	if (!node)
 		return NULL;
-- 
2.17.1

