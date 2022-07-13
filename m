Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2939757351F
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 13:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbiGMLPP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 07:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbiGMLO5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 07:14:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EB49100CDE
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 04:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657710884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4n1qURFuPsutSWvym+I4lZuwTMswVOZqrEfLZaagqYk=;
        b=gEBYMVVeaSgbugTNlxPYe3EfaZxFtE6l2TZ4bSxV80x2EBLkOqz5EZfF4Q12bmn9bGf0pC
        ch/qygPOt6jXXZgkX4IAZS7NwN+I7IuAKA+xSUQ3C4O0CTX+W0aSBzTmX+kLtutqEJj+Lx
        NdyEfNzMvDTgBLmfdn6pXrtNOP/FttM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-vDvI68JwMyKqQIUKp6kCHQ-1; Wed, 13 Jul 2022 07:14:36 -0400
X-MC-Unique: vDvI68JwMyKqQIUKp6kCHQ-1
Received: by mail-ed1-f69.google.com with SMTP id h17-20020a056402281100b0043aa5c0493dso8202803ede.16
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 04:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4n1qURFuPsutSWvym+I4lZuwTMswVOZqrEfLZaagqYk=;
        b=o8RTTzHsjAZBcl8MnkhxIUXsPy/T6Bfs+myDAI1Ewlel1mjodtTfG8LidWTc624QGE
         48LVe14VTt+Z4nMFrm5n1hUUuUqkYkjSsy2Ro71skd0K+hSveade32tqI6Qh/nBfwW7y
         F7trovod4RbrDEZlZN/4MHNkH4v6G/UA2KeOLQPvztCtwCL43DEim/PmqrKmE8izAvwl
         iX6nAYhIySNFdUkqsG+4OH8lgaKSl6VhJQEHj5GcHYX8ZubKgtfbCsuMAJlDY3IxccW4
         Cth+0JOv8ZYPwo/41S75LwalGgAzXfShTMgVqKTWBsQAOe9TTA3fKRnCYUtzX3JC/nAo
         LQTQ==
X-Gm-Message-State: AJIora+yckmTK8S1IEnL8zTN+ZRR+sgADPFwUTk9PJhxkIDxWfkoGqmr
        L6PemfyVBkGP3wVzVdzY/vPlJvLCpolN2BtWhBXhUWjTwLJMMPF3JlWC8AOm2dcMxGQGh8nFb+0
        n6B7EBKKVfo+R
X-Received: by 2002:a05:6402:1741:b0:433:4e4d:bfb4 with SMTP id v1-20020a056402174100b004334e4dbfb4mr4142728edx.7.1657710874840;
        Wed, 13 Jul 2022 04:14:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1si2uz3D1uFgcQn/a15w/KYB8f1OJeDy20jWcOcf1lbhsMDY+nfRwNBrz+qStsMJhXbmtsn4Q==
X-Received: by 2002:a05:6402:1741:b0:433:4e4d:bfb4 with SMTP id v1-20020a056402174100b004334e4dbfb4mr4142677edx.7.1657710874490;
        Wed, 13 Jul 2022 04:14:34 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id kv20-20020a17090778d400b0072af6f166c2sm4907118ejc.82.2022.07.13.04.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 04:14:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5912D4D98FF; Wed, 13 Jul 2022 13:14:33 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Freysteinn Alfredsson <freysteinn.alfredsson@kau.se>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [RFC PATCH 02/17] bpf: Expand map key argument of bpf_redirect_map to u64
Date:   Wed, 13 Jul 2022 13:14:10 +0200
Message-Id: <20220713111430.134810-3-toke@redhat.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220713111430.134810-1-toke@redhat.com>
References: <20220713111430.134810-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We want to be able to support 64-bit indexes for PIFO maps, so expand the
width of the 'key' argument to the bpf_redirect_map() helper. Since BPF
registers are always 64-bit, this should be safe to do after the fact.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/linux/bpf.h      |  2 +-
 include/linux/filter.h   | 12 ++++++------
 include/uapi/linux/bpf.h |  2 +-
 kernel/bpf/cpumap.c      |  4 ++--
 kernel/bpf/devmap.c      |  4 ++--
 kernel/bpf/verifier.c    |  2 +-
 net/core/filter.c        |  4 ++--
 net/xdp/xskmap.c         |  4 ++--
 8 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2b21f2a3452f..d877d9825e77 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -132,7 +132,7 @@ struct bpf_map_ops {
 	struct bpf_local_storage __rcu ** (*map_owner_storage_ptr)(void *owner);
 
 	/* Misc helpers.*/
-	int (*map_redirect)(struct bpf_map *map, u32 ifindex, u64 flags);
+	int (*map_redirect)(struct bpf_map *map, u64 key, u64 flags);
 
 	/* map_meta_equal must be implemented for maps that can be
 	 * used as an inner map.  It is a runtime check to ensure
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 4c1a8b247545..10167ab1ef95 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -637,13 +637,13 @@ struct bpf_nh_params {
 };
 
 struct bpf_redirect_info {
-	u32 flags;
-	u32 tgt_index;
+	u64 tgt_index;
 	void *tgt_value;
 	struct bpf_map *map;
+	u32 flags;
+	u32 kern_flags;
 	u32 map_id;
 	enum bpf_map_type map_type;
-	u32 kern_flags;
 	struct bpf_nh_params nh;
 };
 
@@ -1486,7 +1486,7 @@ static inline bool bpf_sk_lookup_run_v6(struct net *net, int protocol,
 }
 #endif /* IS_ENABLED(CONFIG_IPV6) */
 
-static __always_inline int __bpf_xdp_redirect_map(struct bpf_map *map, u32 ifindex,
+static __always_inline int __bpf_xdp_redirect_map(struct bpf_map *map, u64 index,
 						  u64 flags, const u64 flag_mask,
 						  void *lookup_elem(struct bpf_map *map, u32 key))
 {
@@ -1497,7 +1497,7 @@ static __always_inline int __bpf_xdp_redirect_map(struct bpf_map *map, u32 ifind
 	if (unlikely(flags & ~(action_mask | flag_mask)))
 		return XDP_ABORTED;
 
-	ri->tgt_value = lookup_elem(map, ifindex);
+	ri->tgt_value = lookup_elem(map, index);
 	if (unlikely(!ri->tgt_value) && !(flags & BPF_F_BROADCAST)) {
 		/* If the lookup fails we want to clear out the state in the
 		 * redirect_info struct completely, so that if an eBPF program
@@ -1509,7 +1509,7 @@ static __always_inline int __bpf_xdp_redirect_map(struct bpf_map *map, u32 ifind
 		return flags & action_mask;
 	}
 
-	ri->tgt_index = ifindex;
+	ri->tgt_index = index;
 	ri->map_id = map->id;
 	ri->map_type = map->map_type;
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 379e68fb866f..aec623f60048 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2607,7 +2607,7 @@ union bpf_attr {
  * 	Return
  * 		0 on success, or a negative error in case of failure.
  *
- * long bpf_redirect_map(struct bpf_map *map, u32 key, u64 flags)
+ * long bpf_redirect_map(struct bpf_map *map, u64 key, u64 flags)
  * 	Description
  * 		Redirect the packet to the endpoint referenced by *map* at
  * 		index *key*. Depending on its type, this *map* can contain
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index f4860ac756cd..2e7ee53ae3e4 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -668,9 +668,9 @@ static int cpu_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 	return 0;
 }
 
-static int cpu_map_redirect(struct bpf_map *map, u32 ifindex, u64 flags)
+static int cpu_map_redirect(struct bpf_map *map, u64 index, u64 flags)
 {
-	return __bpf_xdp_redirect_map(map, ifindex, flags, 0,
+	return __bpf_xdp_redirect_map(map, index, flags, 0,
 				      __cpu_map_lookup_elem);
 }
 
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index c2867068e5bd..980f8928e977 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -992,14 +992,14 @@ static int dev_map_hash_update_elem(struct bpf_map *map, void *key, void *value,
 					 map, key, value, map_flags);
 }
 
-static int dev_map_redirect(struct bpf_map *map, u32 ifindex, u64 flags)
+static int dev_map_redirect(struct bpf_map *map, u64 ifindex, u64 flags)
 {
 	return __bpf_xdp_redirect_map(map, ifindex, flags,
 				      BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS,
 				      __dev_map_lookup_elem);
 }
 
-static int dev_hash_map_redirect(struct bpf_map *map, u32 ifindex, u64 flags)
+static int dev_hash_map_redirect(struct bpf_map *map, u64 ifindex, u64 flags)
 {
 	return __bpf_xdp_redirect_map(map, ifindex, flags,
 				      BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 328cfab3af60..039f7b61c305 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14183,7 +14183,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			BUILD_BUG_ON(!__same_type(ops->map_peek_elem,
 				     (int (*)(struct bpf_map *map, void *value))NULL));
 			BUILD_BUG_ON(!__same_type(ops->map_redirect,
-				     (int (*)(struct bpf_map *map, u32 ifindex, u64 flags))NULL));
+				     (int (*)(struct bpf_map *map, u64 index, u64 flags))NULL));
 			BUILD_BUG_ON(!__same_type(ops->map_for_each_callback,
 				     (int (*)(struct bpf_map *map,
 					      bpf_callback_t callback_fn,
diff --git a/net/core/filter.c b/net/core/filter.c
index 4ef77ec5255e..e23e53ed1b04 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4408,10 +4408,10 @@ static const struct bpf_func_proto bpf_xdp_redirect_proto = {
 	.arg2_type      = ARG_ANYTHING,
 };
 
-BPF_CALL_3(bpf_xdp_redirect_map, struct bpf_map *, map, u32, ifindex,
+BPF_CALL_3(bpf_xdp_redirect_map, struct bpf_map *, map, u64, key,
 	   u64, flags)
 {
-	return map->ops->map_redirect(map, ifindex, flags);
+	return map->ops->map_redirect(map, key, flags);
 }
 
 static const struct bpf_func_proto bpf_xdp_redirect_map_proto = {
diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
index acc8e52a4f5f..771d0fa90ef5 100644
--- a/net/xdp/xskmap.c
+++ b/net/xdp/xskmap.c
@@ -231,9 +231,9 @@ static int xsk_map_delete_elem(struct bpf_map *map, void *key)
 	return 0;
 }
 
-static int xsk_map_redirect(struct bpf_map *map, u32 ifindex, u64 flags)
+static int xsk_map_redirect(struct bpf_map *map, u64 index, u64 flags)
 {
-	return __bpf_xdp_redirect_map(map, ifindex, flags, 0,
+	return __bpf_xdp_redirect_map(map, index, flags, 0,
 				      __xsk_map_lookup_elem);
 }
 
-- 
2.37.0

