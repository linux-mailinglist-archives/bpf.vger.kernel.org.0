Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507B56C936B
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 11:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjCZJW2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Mar 2023 05:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjCZJWY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Mar 2023 05:22:24 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559ED40EE;
        Sun, 26 Mar 2023 02:22:23 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id x1so5867823qtr.7;
        Sun, 26 Mar 2023 02:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679822542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqkDpvKGwevEK4sVI1Ozexg4BYNSROrbvWrzdtcWQzE=;
        b=gaP3awW30XRgrsax39c/QyIC65S9xvOX5NJ6A8Uvm396oWrTYMoqlb3xRoe1AJFTYi
         vcViKitZy7ju4PIuRlsz5fBE78ptR+jfM/hvBWvA2fwGXUwb3VdZpi1u8H4RIwuRo2u0
         appsU0EZ1vBLKd2OmE7am1ADiqorhjykLhKDPYf69ho01H221OvtCczZATv0L06ozIbW
         4r3B8NPEPnQkWzGG0QydnxsWfwIIleb3gYykBEjpkzZtorbvvYN53Z86ld564TWW7PEL
         9NyYD8t6MIuI524FGj84dFsG6y14lcvXNc4HtgWus9cma7KuPzXiBsCr3ljXNI1lrfz9
         X2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679822542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqkDpvKGwevEK4sVI1Ozexg4BYNSROrbvWrzdtcWQzE=;
        b=xTyXDqGq/l7rnxDTPPqeB/bMionKxlGIlEnjzm/O+P72kvfZQGcc+LPKJ98kZlaGNu
         WWmnqKNA0FzKxz9RBPfjwxwogP/m9yW41EG+AH3lyWsFcWY4PQHHr6mkkuQ6jr+uc1xq
         QCEbwsaAMejZYtdq5lUPfNqcogrKY5aZh7ICBWc9/BpF8EG420fWw7TXvR/otASLaM0f
         29JW1hoi+JGn7/i9InzytxEvT6devylWEzmh3J+0e/t/+/TAUqGs67U0SL2W4+NJqiPm
         2P8VmsKkVZ6tvYxJAXYBzVmd4DPjvC3zP1hUVT3MTs1/XFNHT52OJXKMlPUa2YuMA8sA
         O1jg==
X-Gm-Message-State: AO0yUKXOaOUBF+u7w8vHnCA2Uvks1paiIi94e3SBnYkRzj6WvPLWgVAW
        HFt1VzrX9PKASZX8xkRwV0o=
X-Google-Smtp-Source: AK7set+aJQlIoCdZzW8J6891dxzViF6iBvna1uPyP/Fg7uRMPMyIncvl8Q8sJJ+MU4+kZ09DK7sBPQ==
X-Received: by 2002:a05:622a:614:b0:3e4:37ac:8203 with SMTP id z20-20020a05622a061400b003e437ac8203mr14417134qta.6.1679822542369;
        Sun, 26 Mar 2023 02:22:22 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:1000:1a1f:5400:4ff:fe5e:1d32])
        by smtp.gmail.com with ESMTPSA id y5-20020ac87085000000b003e014845d9esm10257987qto.74.2023.03.26.02.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 02:22:21 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 06/13] bpf: Helpers to alloc and free object id in bpf namespace
Date:   Sun, 26 Mar 2023 09:22:01 +0000
Message-Id: <20230326092208.13613-7-laoar.shao@gmail.com>
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

Introduce generic helpers to alloc bpf_{map,prog,link} in bpf namespace.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/bpf_namespace.h | 36 ++++++++++++++++++
 kernel/bpf/bpf_namespace.c    | 86 +++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c          |  6 +--
 3 files changed, 125 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_namespace.h b/include/linux/bpf_namespace.h
index 06aa51f..50bd68c 100644
--- a/include/linux/bpf_namespace.h
+++ b/include/linux/bpf_namespace.h
@@ -38,9 +38,45 @@ struct bpf_namespace {
 
 extern struct bpf_namespace init_bpf_ns;
 extern struct proc_ns_operations bpfns_operations;
+extern spinlock_t map_idr_lock;
+extern spinlock_t prog_idr_lock;
+extern spinlock_t link_idr_lock;
 
 struct bpf_namespace *copy_bpfns(unsigned long flags,
 								struct user_namespace *user_ns,
 								struct bpf_namespace *old_ns);
 void put_bpfns(struct bpf_namespace *ns);
+struct bpf_obj_id *bpf_alloc_obj_id(struct bpf_namespace *ns,
+									void *obj, int type);
+void bpf_free_obj_id(struct bpf_obj_id *obj_id, int type);
+
+/*
+ * The helpers to get the bpf_id's id seen from different namespaces
+ *
+ * bpf_id_nr()    : global id, i.e. the id seen from the init namespace;
+ * bpf_id_vnr()   : virtual id, i.e. the id seen from the pid namespace of
+ *                  current.
+ * bpf_id_nr_ns() : id seen from the ns specified.
+ *
+ * see also task_xid_nr() etc in include/linux/sched.h
+ */
+static inline int bpf_obj_id_nr(struct bpf_obj_id *obj_id)
+{
+	if (obj_id)
+		return obj_id->numbers[0].nr;
+	return 0;
+}
+
+static inline int bpf_obj_id_nr_ns(struct bpf_obj_id *obj_id,
+								   struct bpf_namespace *ns)
+{
+	if (obj_id && ns->level <= obj_id->level)
+		return obj_id->numbers[ns->level].nr;
+	return 0;
+}
+
+static inline int bpf_obj_id_vnr(struct bpf_obj_id *obj_id)
+{
+	return bpf_obj_id_nr_ns(obj_id, current->nsproxy->bpf_ns);
+}
 #endif /* _LINUX_BPF_ID_NS_H */
diff --git a/kernel/bpf/bpf_namespace.c b/kernel/bpf/bpf_namespace.c
index 88a86cd..1e98d1d 100644
--- a/kernel/bpf/bpf_namespace.c
+++ b/kernel/bpf/bpf_namespace.c
@@ -217,3 +217,89 @@ static __init int bpf_namespaces_init(void)
 }
 
 late_initcall(bpf_namespaces_init);
+
+struct bpf_obj_id *bpf_alloc_obj_id(struct bpf_namespace *ns,
+									void *obj, int type)
+{
+	struct bpf_namespace *tmp = ns;
+	struct bpf_obj_id *obj_id;
+	spinlock_t *idr_lock;
+	unsigned long flags;
+	int id;
+	int i;
+
+	switch (type) {
+	case MAP_OBJ_ID:
+		idr_lock = &map_idr_lock;
+		break;
+	case PROG_OBJ_ID:
+		idr_lock = &prog_idr_lock;
+		break;
+	case LINK_OBJ_ID:
+		idr_lock = &link_idr_lock;
+		break;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+
+	obj_id = kmem_cache_alloc(ns->obj_id_cachep, GFP_KERNEL);
+	if (!obj_id)
+		return ERR_PTR(-ENOMEM);
+
+	obj_id->level = ns->level;
+	for (i = ns->level; i >= 0; i--) {
+		idr_preload(GFP_KERNEL);
+		spin_lock_bh(idr_lock);
+		id = idr_alloc_cyclic(&tmp->idr[type], obj, 1, INT_MAX, GFP_ATOMIC);
+		spin_unlock_bh(idr_lock);
+		idr_preload_end();
+		if (id < 0)
+			goto out_free;
+		obj_id->numbers[i].nr = id;
+		obj_id->numbers[i].ns = tmp;
+		tmp = tmp->parent;
+	}
+
+	return obj_id;
+
+out_free:
+	for (; i <= ns->level; i++) {
+		tmp = obj_id->numbers[i].ns;
+		spin_lock_irqsave(idr_lock, flags);
+		idr_remove(&tmp->idr[type], obj_id->numbers[i].nr);
+		spin_unlock_irqrestore(idr_lock, flags);
+	}
+	kmem_cache_free(ns->obj_id_cachep, obj_id);
+	return ERR_PTR(id);
+}
+
+void bpf_free_obj_id(struct bpf_obj_id *obj_id, int type)
+{
+	struct bpf_namespace *ns;
+	spinlock_t *idr_lock;
+	unsigned long flags;
+	int i;
+
+	switch (type) {
+	case MAP_OBJ_ID:
+		idr_lock = &map_idr_lock;
+		break;
+	case PROG_OBJ_ID:
+		idr_lock = &prog_idr_lock;
+		break;
+	case LINK_OBJ_ID:
+		idr_lock = &link_idr_lock;
+		break;
+	default:
+		return;
+	}
+	/* Note that the level-0 should be freed at last */
+	for (i = obj_id->level; i >= 0; i--) {
+		spin_lock_irqsave(idr_lock, flags);
+		ns = obj_id->numbers[i].ns;
+		idr_remove(&ns->idr[type], obj_id->numbers[i].nr);
+		spin_unlock_irqrestore(idr_lock, flags);
+	}
+	ns = obj_id->numbers[obj_id->level].ns;
+	kmem_cache_free(ns->obj_id_cachep, obj_id);
+}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ee1297d..f24e550 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -48,11 +48,11 @@
 
 DEFINE_PER_CPU(int, bpf_prog_active);
 static DEFINE_IDR(prog_idr);
-static DEFINE_SPINLOCK(prog_idr_lock);
+DEFINE_SPINLOCK(prog_idr_lock);
 static DEFINE_IDR(map_idr);
-static DEFINE_SPINLOCK(map_idr_lock);
+DEFINE_SPINLOCK(map_idr_lock);
 static DEFINE_IDR(link_idr);
-static DEFINE_SPINLOCK(link_idr_lock);
+DEFINE_SPINLOCK(link_idr_lock);
 
 int sysctl_unprivileged_bpf_disabled __read_mostly =
 	IS_BUILTIN(CONFIG_BPF_UNPRIV_DEFAULT_OFF) ? 2 : 0;
-- 
1.8.3.1

