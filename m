Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623456D96FD
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 14:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237427AbjDFM0b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 08:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjDFM0a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 08:26:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B8F6EB6;
        Thu,  6 Apr 2023 05:26:28 -0700 (PDT)
Received: from dggpeml500010.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Psgf36vJrzKwrC;
        Thu,  6 Apr 2023 20:23:55 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Apr
 2023 20:26:25 +0800
From:   Xin Liu <liuxin350@huawei.com>
To:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>
CC:     <bpf@vger.kernel.org>, <hsinweih@uci.edu>,
        <linux-kernel@vger.kernel.org>, <yanan@huawei.com>,
        <wuchangye@huawei.com>, <xiesongyang@huawei.com>,
        <kongweibin2@huawei.com>, <liuxin350@huawei.com>,
        <zhangmingyi5@huawei.com>
Subject: [PATCH bpf-next] bpf, sockmap: fix deadlocks in the sockhash and sockmap
Date:   Thu, 6 Apr 2023 20:26:22 +0800
Message-ID: <20230406122622.109978-1-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When huang uses sched_switch tracepoint, the tracepoint
does only one thing in the mounted ebpf program, which
deletes the fixed elements in sockhash ([0])

It seems that elements in sockhash are rarely actively
deleted by users or ebpf program. Therefore, we do not
pay much attention to their deletion. Compared with hash
maps, sockhash only provides spin_lock_bh protection.
This causes it to appear to have self-locking behavior
in the interrupt context.

  [0]:https://lore.kernel.org/all/CABcoxUayum5oOqFMMqAeWuS8+EzojquSOSyDA3J_2omY=2EeAg@mail.gmail.com/

Reported-by: Hsin-Wei Hung <hsinweih@uci.edu>
Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Xin Liu <liuxin350@huawei.com>
---
 net/core/sock_map.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 7c189c2e2fbf..66305b7bf8b7 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -414,8 +414,9 @@ static int __sock_map_delete(struct bpf_stab *stab, struct sock *sk_test,
 {
 	struct sock *sk;
 	int err = 0;
+	unsigned long flags;
 
-	raw_spin_lock_bh(&stab->lock);
+	raw_spin_lock_irqsave(&stab->lock, flags);
 	sk = *psk;
 	if (!sk_test || sk_test == sk)
 		sk = xchg(psk, NULL);
@@ -425,7 +426,7 @@ static int __sock_map_delete(struct bpf_stab *stab, struct sock *sk_test,
 	else
 		err = -EINVAL;
 
-	raw_spin_unlock_bh(&stab->lock);
+	raw_spin_unlock_irqrestore(&stab->lock, flags);
 	return err;
 }
 
@@ -932,11 +933,12 @@ static long sock_hash_delete_elem(struct bpf_map *map, void *key)
 	struct bpf_shtab_bucket *bucket;
 	struct bpf_shtab_elem *elem;
 	int ret = -ENOENT;
+	unsigned long flags;
 
 	hash = sock_hash_bucket_hash(key, key_size);
 	bucket = sock_hash_select_bucket(htab, hash);
 
-	raw_spin_lock_bh(&bucket->lock);
+	raw_spin_lock_irqsave(&bucket->lock, flags);
 	elem = sock_hash_lookup_elem_raw(&bucket->head, hash, key, key_size);
 	if (elem) {
 		hlist_del_rcu(&elem->node);
@@ -944,7 +946,7 @@ static long sock_hash_delete_elem(struct bpf_map *map, void *key)
 		sock_hash_free_elem(htab, elem);
 		ret = 0;
 	}
-	raw_spin_unlock_bh(&bucket->lock);
+	raw_spin_unlock_irqrestore(&bucket->lock, flags);
 	return ret;
 }
 
-- 
2.33.0

