Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B90E9A4D5
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2019 03:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731592AbfHWBN7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Aug 2019 21:13:59 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:55682 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387676AbfHWBN7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Aug 2019 21:13:59 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id 0F8CEBDD19C0BD7E4CD3;
        Fri, 23 Aug 2019 09:13:57 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id x7N1Dgrq054529;
        Fri, 23 Aug 2019 09:13:42 +0800 (GMT-8)
        (envelope-from zhang.lin16@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019082309141585-3127175 ;
          Fri, 23 Aug 2019 09:14:15 +0800 
From:   zhanglin <zhang.lin16@zte.com.cn>
To:     davem@davemloft.net
Cc:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, willemb@google.com,
        edumazet@google.com, deepa.kernel@gmail.com, arnd@arndb.de,
        dh.herrmann@gmail.com, gnault@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        jiang.xuexin@zte.com.cn, zhanglin <zhang.lin16@zte.com.cn>
Subject: [PATCH] [PATCH v3] sock: fix potential memory leak in proto_register()
Date:   Fri, 23 Aug 2019 09:14:11 +0800
Message-Id: <1566522851-24018-1-git-send-email-zhang.lin16@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-08-23 09:14:15,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-08-23 09:13:47,
        Serialize complete at 2019-08-23 09:13:47
X-MAIL: mse-fl2.zte.com.cn x7N1Dgrq054529
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If protocols registered exceeded PROTO_INUSE_NR, prot will be
added to proto_list, but no available bit left for prot in
proto_inuse_idx.

Changes since v2:
* Propagate the error code properly

Signed-off-by: zhanglin <zhang.lin16@zte.com.cn>
---
 net/core/sock.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index bc3512f230a3..f39163071384 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3139,16 +3139,17 @@ static __init int net_inuse_init(void)
 
 core_initcall(net_inuse_init);
 
-static void assign_proto_idx(struct proto *prot)
+static int assign_proto_idx(struct proto *prot)
 {
 	prot->inuse_idx = find_first_zero_bit(proto_inuse_idx, PROTO_INUSE_NR);
 
 	if (unlikely(prot->inuse_idx == PROTO_INUSE_NR - 1)) {
 		pr_err("PROTO_INUSE_NR exhausted\n");
-		return;
+		return -ENOSPC;
 	}
 
 	set_bit(prot->inuse_idx, proto_inuse_idx);
+	return 0;
 }
 
 static void release_proto_idx(struct proto *prot)
@@ -3157,8 +3158,9 @@ static void release_proto_idx(struct proto *prot)
 		clear_bit(prot->inuse_idx, proto_inuse_idx);
 }
 #else
-static inline void assign_proto_idx(struct proto *prot)
+static inline int assign_proto_idx(struct proto *prot)
 {
+	return 0;
 }
 
 static inline void release_proto_idx(struct proto *prot)
@@ -3207,6 +3209,8 @@ static int req_prot_init(const struct proto *prot)
 
 int proto_register(struct proto *prot, int alloc_slab)
 {
+	int ret = -ENOBUFS;
+
 	if (alloc_slab) {
 		prot->slab = kmem_cache_create_usercopy(prot->name,
 					prot->obj_size, 0,
@@ -3243,20 +3247,27 @@ int proto_register(struct proto *prot, int alloc_slab)
 	}
 
 	mutex_lock(&proto_list_mutex);
+	ret = assign_proto_idx(prot);
+	if (ret) {
+		mutex_unlock(&proto_list_mutex);
+		goto out_free_timewait_sock_slab_name;
+	}
 	list_add(&prot->node, &proto_list);
-	assign_proto_idx(prot);
 	mutex_unlock(&proto_list_mutex);
-	return 0;
+	return ret;
 
 out_free_timewait_sock_slab_name:
-	kfree(prot->twsk_prot->twsk_slab_name);
+	if (alloc_slab && prot->twsk_prot)
+		kfree(prot->twsk_prot->twsk_slab_name);
 out_free_request_sock_slab:
-	req_prot_cleanup(prot->rsk_prot);
+	if (alloc_slab) {
+		req_prot_cleanup(prot->rsk_prot);
 
-	kmem_cache_destroy(prot->slab);
-	prot->slab = NULL;
+		kmem_cache_destroy(prot->slab);
+		prot->slab = NULL;
+	}
 out:
-	return -ENOBUFS;
+	return ret;
 }
 EXPORT_SYMBOL(proto_register);
 
-- 
2.17.1

