Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4486C937E
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 11:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjCZJXI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Mar 2023 05:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjCZJWv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Mar 2023 05:22:51 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA2BA245;
        Sun, 26 Mar 2023 02:22:28 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id g19so5857127qts.9;
        Sun, 26 Mar 2023 02:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679822548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSwgby0UrYndbAxTM77AgxLovcrhl/Mtkc5Vceujv1A=;
        b=T8x9POr0Lj1AqtVdVvWfyzSmtHtHn2wyWRjHAsTh+AtYmG4W8fa7xJrjXMtItajUm2
         D7uC04UFqTWRyv2z88AjdBNPAVHbc2yH+jkkn1CRECrA592SOZUZypoupsbsCkV05HYO
         8eRramfOGqMbt9kRg0hNCktEIaMYNdup6Kw0y8xFKl1BI+kM04G4Zgbak624ghy1/hSU
         TLgld8TVf8JeVlY3bYLrwPBN9L6YPIgT+e3u6X6qkE7YwbtdUPVDLLbdLqymkuSsb9pQ
         FxxW84SucUSkRKh1ccuFeLT9jIwFs76Nszp+20uI1o0Sqq7usuOQc7LpmlKeYlTveJzR
         kwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679822548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSwgby0UrYndbAxTM77AgxLovcrhl/Mtkc5Vceujv1A=;
        b=rlqZrJNYnPzSmprNkJr/8+EV1FP1eKMQ55JoB/kGFAle3sAiTtBhHwNDRhFNZ7GCNA
         QQlcxGFO1OCze2HD3ckUXu1KFhRmZuZlc8KRo0MujFQ18hhcK38eXOX7vxX0ITT/qk9N
         k/PghQciXQquytAKbFkPxCkecDGpA7s52x7iwYdIouL1vXFI53AsSlvOr+WXrqqnOHvr
         NS381C0T+4Zow5bPNHWmWCLEusVGVtUUWDb2tkMnnosUcoaV8qiRcfLaTQR4M1U5Plkb
         RgcP1qxwYPD87SINv9uMyYpXrCJp2K9mNT0jUAejOuDb+QZ+1K6znGlu9d5RvB3xFSj7
         WPMg==
X-Gm-Message-State: AO0yUKV3Gga8oqsQrrNoD25KL8O7retwWX5IYttORYH8Qp55tnvtBkNx
        q5PMFf8WkNdroIqd84+KRjE=
X-Google-Smtp-Source: AK7set8gkEDowD9aPU7oLgh91OWH0kdZjlTpcpSbqOXtKxC2i3dKsI2PZ9nf7IIsIxs0s9Jf5mZqDQ==
X-Received: by 2002:ac8:5a09:0:b0:3e3:9185:cb15 with SMTP id n9-20020ac85a09000000b003e39185cb15mr14418072qta.7.1679822547864;
        Sun, 26 Mar 2023 02:22:27 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:1000:1a1f:5400:4ff:fe5e:1d32])
        by smtp.gmail.com with ESMTPSA id y5-20020ac87085000000b003e014845d9esm10257987qto.74.2023.03.26.02.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 02:22:27 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 12/13] bpf: Use bpf_idr_lock array instead
Date:   Sun, 26 Mar 2023 09:22:07 +0000
Message-Id: <20230326092208.13613-13-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230326092208.13613-1-laoar.shao@gmail.com>
References: <20230326092208.13613-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use an array instead, that will make the code more clear.
It is a cleanup.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/bpf_namespace.h |  4 +---
 kernel/bpf/bpf_namespace.c    | 37 ++++++-------------------------------
 kernel/bpf/syscall.c          | 42 +++++++++++++++++++++---------------------
 3 files changed, 28 insertions(+), 55 deletions(-)

diff --git a/include/linux/bpf_namespace.h b/include/linux/bpf_namespace.h
index f484791..4d58986 100644
--- a/include/linux/bpf_namespace.h
+++ b/include/linux/bpf_namespace.h
@@ -39,9 +39,7 @@ struct bpf_namespace {
 
 extern struct bpf_namespace init_bpf_ns;
 extern struct proc_ns_operations bpfns_operations;
-extern spinlock_t map_idr_lock;
-extern spinlock_t prog_idr_lock;
-extern spinlock_t link_idr_lock;
+extern spinlock_t bpf_idr_lock[OBJ_ID_NUM];
 
 struct bpf_namespace *copy_bpfns(unsigned long flags,
 								struct user_namespace *user_ns,
diff --git a/kernel/bpf/bpf_namespace.c b/kernel/bpf/bpf_namespace.c
index c7d62ef..51c240f 100644
--- a/kernel/bpf/bpf_namespace.c
+++ b/kernel/bpf/bpf_namespace.c
@@ -11,9 +11,7 @@
 #include <linux/bpf_namespace.h>
 
 #define MAX_BPF_NS_LEVEL 32
-DEFINE_SPINLOCK(map_idr_lock);
-DEFINE_SPINLOCK(prog_idr_lock);
-DEFINE_SPINLOCK(link_idr_lock);
+spinlock_t bpf_idr_lock[OBJ_ID_NUM];
 static struct kmem_cache *bpfns_cachep;
 static struct kmem_cache *obj_id_cache[MAX_PID_NS_LEVEL];
 static struct ns_common *bpfns_get(struct task_struct *task);
@@ -208,8 +206,10 @@ static void __init bpfns_idr_init(void)
 
 	init_bpf_ns.obj_id_cachep =
 		KMEM_CACHE(pid, SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
-	for (i = 0; i < OBJ_ID_NUM; i++)
+	for (i = 0; i < OBJ_ID_NUM; i++) {
 		idr_init(&init_bpf_ns.idr[i]);
+		spin_lock_init(&bpf_idr_lock[i]);
+	}
 }
 
 static __init int bpf_namespaces_init(void)
@@ -231,24 +231,11 @@ struct bpf_obj_id *bpf_alloc_obj_id(struct bpf_namespace *ns,
 	int id;
 	int i;
 
-	switch (type) {
-	case MAP_OBJ_ID:
-		idr_lock = &map_idr_lock;
-		break;
-	case PROG_OBJ_ID:
-		idr_lock = &prog_idr_lock;
-		break;
-	case LINK_OBJ_ID:
-		idr_lock = &link_idr_lock;
-		break;
-	default:
-		return ERR_PTR(-EINVAL);
-	}
-
 	obj_id = kmem_cache_alloc(ns->obj_id_cachep, GFP_KERNEL);
 	if (!obj_id)
 		return ERR_PTR(-ENOMEM);
 
+	idr_lock = &bpf_idr_lock[type];
 	obj_id->level = ns->level;
 	for (i = ns->level; i >= 0; i--) {
 		idr_preload(GFP_KERNEL);
@@ -283,19 +270,7 @@ void bpf_free_obj_id(struct bpf_obj_id *obj_id, int type)
 	unsigned long flags;
 	int i;
 
-	switch (type) {
-	case MAP_OBJ_ID:
-		idr_lock = &map_idr_lock;
-		break;
-	case PROG_OBJ_ID:
-		idr_lock = &prog_idr_lock;
-		break;
-	case LINK_OBJ_ID:
-		idr_lock = &link_idr_lock;
-		break;
-	default:
-		return;
-	}
+	idr_lock = &bpf_idr_lock[type];
 	/* Note that the level-0 should be freed at last */
 	for (i = obj_id->level; i >= 0; i--) {
 		spin_lock_irqsave(idr_lock, flags);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8a72694..7cbaaa9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1269,7 +1269,7 @@ struct bpf_map *bpf_map_get_with_uref(u32 ufd)
 	return map;
 }
 
-/* map_idr_lock should have been held or the map should have been
+/* map idr_lock should have been held or the map should have been
  * protected by rcu read lock.
  */
 struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool uref)
@@ -1287,9 +1287,9 @@ struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool uref)
 
 struct bpf_map *bpf_map_inc_not_zero(struct bpf_map *map)
 {
-	spin_lock_bh(&map_idr_lock);
+	spin_lock_bh(&bpf_idr_lock[MAP_OBJ_ID]);
 	map = __bpf_map_inc_not_zero(map, false);
-	spin_unlock_bh(&map_idr_lock);
+	spin_unlock_bh(&bpf_idr_lock[MAP_OBJ_ID]);
 
 	return map;
 }
@@ -2195,7 +2195,7 @@ void bpf_prog_inc(struct bpf_prog *prog)
 }
 EXPORT_SYMBOL_GPL(bpf_prog_inc);
 
-/* prog_idr_lock should have been held */
+/* prog idr_lock should have been held */
 struct bpf_prog *bpf_prog_inc_not_zero(struct bpf_prog *prog)
 {
 	int refold;
@@ -2836,10 +2836,10 @@ int bpf_link_prime(struct bpf_link *link, struct bpf_link_primer *primer)
 int bpf_link_settle(struct bpf_link_primer *primer)
 {
 	/* make bpf_link fetchable by ID */
-	spin_lock_bh(&link_idr_lock);
+	spin_lock_bh(&bpf_idr_lock[LINK_OBJ_ID]);
 	primer->link->id = primer->id;
 	primer->link->obj_id = primer->obj_id;
-	spin_unlock_bh(&link_idr_lock);
+	spin_unlock_bh(&bpf_idr_lock[LINK_OBJ_ID]);
 	/* make bpf_link fetchable by FD */
 	fd_install(primer->fd, primer->file);
 	/* pass through installed FD */
@@ -3648,7 +3648,7 @@ struct bpf_map *bpf_map_get_curr_or_next(u32 *id)
 	struct bpf_namespace *ns = current->nsproxy->bpf_ns;
 	struct bpf_map *map;
 
-	spin_lock_bh(&map_idr_lock);
+	spin_lock_bh(&bpf_idr_lock[MAP_OBJ_ID]);
 again:
 	map = idr_get_next(&ns->idr[MAP_OBJ_ID], id);
 	if (map) {
@@ -3658,7 +3658,7 @@ struct bpf_map *bpf_map_get_curr_or_next(u32 *id)
 			goto again;
 		}
 	}
-	spin_unlock_bh(&map_idr_lock);
+	spin_unlock_bh(&bpf_idr_lock[MAP_OBJ_ID]);
 
 	return map;
 }
@@ -3668,7 +3668,7 @@ struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id)
 	struct bpf_namespace *ns = current->nsproxy->bpf_ns;
 	struct bpf_prog *prog;
 
-	spin_lock_bh(&prog_idr_lock);
+	spin_lock_bh(&bpf_idr_lock[PROG_OBJ_ID]);
 again:
 	prog = idr_get_next(&ns->idr[PROG_OBJ_ID], id);
 	if (prog) {
@@ -3678,7 +3678,7 @@ struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id)
 			goto again;
 		}
 	}
-	spin_unlock_bh(&prog_idr_lock);
+	spin_unlock_bh(&bpf_idr_lock[PROG_OBJ_ID]);
 
 	return prog;
 }
@@ -3693,13 +3693,13 @@ struct bpf_prog *bpf_prog_by_id(u32 id)
 	if (!id)
 		return ERR_PTR(-ENOENT);
 
-	spin_lock_bh(&prog_idr_lock);
+	spin_lock_bh(&bpf_idr_lock[PROG_OBJ_ID]);
 	prog = idr_find(&ns->idr[PROG_OBJ_ID], id);
 	if (prog)
 		prog = bpf_prog_inc_not_zero(prog);
 	else
 		prog = ERR_PTR(-ENOENT);
-	spin_unlock_bh(&prog_idr_lock);
+	spin_unlock_bh(&bpf_idr_lock[PROG_OBJ_ID]);
 	return prog;
 }
 
@@ -3747,13 +3747,13 @@ static int bpf_map_get_fd_by_id(const union bpf_attr *attr)
 	if (f_flags < 0)
 		return f_flags;
 
-	spin_lock_bh(&map_idr_lock);
+	spin_lock_bh(&bpf_idr_lock[MAP_OBJ_ID]);
 	map = idr_find(&ns->idr[MAP_OBJ_ID], id);
 	if (map)
 		map = __bpf_map_inc_not_zero(map, true);
 	else
 		map = ERR_PTR(-ENOENT);
-	spin_unlock_bh(&map_idr_lock);
+	spin_unlock_bh(&bpf_idr_lock[MAP_OBJ_ID]);
 
 	if (IS_ERR(map))
 		return PTR_ERR(map);
@@ -4735,7 +4735,7 @@ struct bpf_link *bpf_link_by_id(u32 id)
 	if (!id)
 		return ERR_PTR(-ENOENT);
 
-	spin_lock_bh(&link_idr_lock);
+	spin_lock_bh(&bpf_idr_lock[LINK_OBJ_ID]);
 	/* before link is "settled", ID is 0, pretend it doesn't exist yet */
 	link = idr_find(&ns->idr[LINK_OBJ_ID], id);
 	if (link) {
@@ -4746,7 +4746,7 @@ struct bpf_link *bpf_link_by_id(u32 id)
 	} else {
 		link = ERR_PTR(-ENOENT);
 	}
-	spin_unlock_bh(&link_idr_lock);
+	spin_unlock_bh(&bpf_idr_lock[LINK_OBJ_ID]);
 	return link;
 }
 
@@ -4755,7 +4755,7 @@ struct bpf_link *bpf_link_get_curr_or_next(u32 *id)
 	struct bpf_namespace *ns = current->nsproxy->bpf_ns;
 	struct bpf_link *link;
 
-	spin_lock_bh(&link_idr_lock);
+	spin_lock_bh(&bpf_idr_lock[LINK_OBJ_ID]);
 again:
 	link = idr_get_next(&ns->idr[LINK_OBJ_ID], id);
 	if (link) {
@@ -4765,7 +4765,7 @@ struct bpf_link *bpf_link_get_curr_or_next(u32 *id)
 			goto again;
 		}
 	}
-	spin_unlock_bh(&link_idr_lock);
+	spin_unlock_bh(&bpf_idr_lock[LINK_OBJ_ID]);
 
 	return link;
 }
@@ -5011,11 +5011,11 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 		break;
 	case BPF_PROG_GET_NEXT_ID:
 		err = bpf_obj_get_next_id(&attr, uattr.user,
-					  &ns->idr[PROG_OBJ_ID], &prog_idr_lock);
+					  &ns->idr[PROG_OBJ_ID], &bpf_idr_lock[PROG_OBJ_ID]);
 		break;
 	case BPF_MAP_GET_NEXT_ID:
 		err = bpf_obj_get_next_id(&attr, uattr.user,
-					  &ns->idr[MAP_OBJ_ID], &map_idr_lock);
+					  &ns->idr[MAP_OBJ_ID], &bpf_idr_lock[MAP_OBJ_ID]);
 		break;
 	case BPF_BTF_GET_NEXT_ID:
 		err = bpf_obj_get_next_id(&attr, uattr.user,
@@ -5069,7 +5069,7 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 		break;
 	case BPF_LINK_GET_NEXT_ID:
 		err = bpf_obj_get_next_id(&attr, uattr.user,
-					  &ns->idr[LINK_OBJ_ID], &link_idr_lock);
+					  &ns->idr[LINK_OBJ_ID], &bpf_idr_lock[LINK_OBJ_ID]);
 		break;
 	case BPF_ENABLE_STATS:
 		err = bpf_enable_stats(&attr);
-- 
1.8.3.1

