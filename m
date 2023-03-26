Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A576C9365
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 11:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjCZJWY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Mar 2023 05:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjCZJWW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Mar 2023 05:22:22 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D36140EE;
        Sun, 26 Mar 2023 02:22:20 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id n14so5854766qta.10;
        Sun, 26 Mar 2023 02:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679822540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhyLQ7UYumv+WDRskz2d3S0DvVb7k7Pdnk50s5ULN88=;
        b=LgWjCfQPW96aOHnMVq1nRspU1h2cX8WSfoqtvehGvZeGVM8Fk+1z38MitJwaD+VQ1m
         a1DzigR/DlstuMePJAOE+PL1hi/Wv43CjyP9atiTXEnE8D6Lw9gyB8ZkcYochl3NYyz/
         1MkBiF+Fgkt4WlOCeBnrpIzaUROEApGiYPo8aWJ4FGR5cvvRN+yJlWbgnQDP7cB1gG6w
         jg5TcJhjRTPJ11kKAG6su2RmC8OSoAforxKy/Sdo9aQcXhwX09QGj/D87Hu/q2QO83vE
         a+5/SM/apSkAfZmjC+SSZ4H5yRkd7x27BZPsoxb3F6ImVuoIov1+WFqZVi+S9jx8A88u
         Gp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679822540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhyLQ7UYumv+WDRskz2d3S0DvVb7k7Pdnk50s5ULN88=;
        b=1hLrEjLN3jB3EHZsKqi25UHW7KbGUp0HI39bZqDAM3ded7hwlEwzAaNusbF7RUf/NS
         gewDRuRtu6DixI6dHgOWXSrWfLrL4N3+bp56lQOdWI3FyGSBgMrvWDxp605OSye9KukE
         89rhR0xEyftr1VKv94EIY9apBzy6eHdKHT92VgACOwnWvUmC+LqrV2gMSuWOTR56yy2g
         pyzkR3AWhhpmFdK4+z+c2OvKfSXjQx7sA+XZH4xPosQ1IRNHvbub5QfW9wip5130oRp+
         YN8epdOtlihoq33jHVo1lL8yGLP0EVJ71ezopJK2BDWKLTou2yG0d/jXlOnOvPhgb4hn
         r42Q==
X-Gm-Message-State: AO0yUKXvnA5+aYAyPWTP42UL7Gyi+YJ1EmFpSQW13SUxwlAd5b4qS0wS
        bXrNmGM5PqSSDWHAi+q3fEg=
X-Google-Smtp-Source: AK7set/MLQGWLPcaWrkNF1oMgaLnh9FItragX1D+PrIw2lcRq9FVElYDRq+Y+MS72LnghzlsCCsRJg==
X-Received: by 2002:ac8:5fcd:0:b0:3de:94da:4fd7 with SMTP id k13-20020ac85fcd000000b003de94da4fd7mr16056824qta.39.1679822539726;
        Sun, 26 Mar 2023 02:22:19 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:1000:1a1f:5400:4ff:fe5e:1d32])
        by smtp.gmail.com with ESMTPSA id y5-20020ac87085000000b003e014845d9esm10257987qto.74.2023.03.26.02.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 02:22:19 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 03/13] bpf: Implement bpf namespace
Date:   Sun, 26 Mar 2023 09:21:58 +0000
Message-Id: <20230326092208.13613-4-laoar.shao@gmail.com>
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

It is similar with pid namespace. When we create a new bpf object in a
child BPF namespace, it will alloc the id in current BPF namespace and
its parent BPF namespace. The hierarchy as follows,

    init_bpf_ns                  : level = 0
    /        \
  child_a   child_b              : level = 1
            /    \
       child_b_a  child_b_b      : level = 2

When we create a bpf object in child_bb, it will allocate IDs for this
object in child_bb, child_b and the init_bpf_ns.

We will allocate the id for bpf_map, bpf_prog and bpf_link in bpf
namespace.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 fs/proc/namespaces.c           |   4 +
 include/linux/bpf_namespace.h  |  46 +++++++++
 include/linux/nsproxy.h        |   4 +
 include/linux/proc_ns.h        |   1 +
 include/linux/user_namespace.h |   1 +
 kernel/bpf/Makefile            |   1 +
 kernel/bpf/bpf_namespace.c     | 219 +++++++++++++++++++++++++++++++++++++++++
 kernel/nsproxy.c               |  19 +++-
 kernel/ucount.c                |   1 +
 9 files changed, 294 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/bpf_namespace.h
 create mode 100644 kernel/bpf/bpf_namespace.c

diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index 8e159fc..1a36757 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -9,6 +9,7 @@
 #include <linux/ipc_namespace.h>
 #include <linux/pid_namespace.h>
 #include <linux/user_namespace.h>
+#include <linux/bpf_namespace.h>
 #include "internal.h"
 
 
@@ -37,6 +38,9 @@
 	&timens_operations,
 	&timens_for_children_operations,
 #endif
+#ifdef CONFIG_BPF
+	&bpfns_operations,
+#endif
 };
 
 static const char *proc_ns_get_link(struct dentry *dentry,
diff --git a/include/linux/bpf_namespace.h b/include/linux/bpf_namespace.h
new file mode 100644
index 0000000..06aa51f
--- /dev/null
+++ b/include/linux/bpf_namespace.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_BPF_ID_NS_H
+#define _LINUX_BPF_ID_NS_H
+#include <linux/types.h>
+#include <linux/idr.h>
+#include <linux/ns_common.h>
+#include <linux/user_namespace.h>
+
+struct ubpf_obj_id {
+	int nr;
+	struct bpf_namespace *ns;
+};
+
+struct bpf_obj_id {
+	refcount_t count;
+	unsigned int level;
+	struct rcu_head rcu;
+	struct ubpf_obj_id numbers[1];
+};
+
+enum {
+	MAP_OBJ_ID = 0,
+	PROG_OBJ_ID,
+	LINK_OBJ_ID,
+	OBJ_ID_NUM,
+};
+
+struct bpf_namespace {
+	struct idr idr[OBJ_ID_NUM];
+	struct rcu_head rcu;
+	int level;
+	struct ns_common ns;
+	struct user_namespace *user_ns;
+	struct kmem_cache *obj_id_cachep;
+	struct bpf_namespace *parent;
+	struct ucounts *ucounts;
+};
+
+extern struct bpf_namespace init_bpf_ns;
+extern struct proc_ns_operations bpfns_operations;
+
+struct bpf_namespace *copy_bpfns(unsigned long flags,
+								struct user_namespace *user_ns,
+								struct bpf_namespace *old_ns);
+void put_bpfns(struct bpf_namespace *ns);
+#endif /* _LINUX_BPF_ID_NS_H */
diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index fee881c..d24ab6b 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -10,6 +10,9 @@
 struct ipc_namespace;
 struct pid_namespace;
 struct cgroup_namespace;
+#ifdef CONFIG_BPF
+struct bpf_namespace;
+#endif
 struct fs_struct;
 
 /*
@@ -38,6 +41,7 @@ struct nsproxy {
 	struct time_namespace *time_ns;
 	struct time_namespace *time_ns_for_children;
 	struct cgroup_namespace *cgroup_ns;
+	struct bpf_namespace *bpf_ns;
 };
 extern struct nsproxy init_nsproxy;
 
diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index 555c257..c10ce2c 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -46,6 +46,7 @@ enum {
 	PROC_PID_INIT_INO	= 0xEFFFFFFCU,
 	PROC_CGROUP_INIT_INO	= 0xEFFFFFFBU,
 	PROC_TIME_INIT_INO	= 0xEFFFFFFAU,
+	PROC_BPF_INIT_INO	= 0xEFFFFFF9U,
 };
 
 #ifdef CONFIG_PROC_FS
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 45f09be..93eb618 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -54,6 +54,7 @@ enum ucount_type {
 	UCOUNT_FANOTIFY_GROUPS,
 	UCOUNT_FANOTIFY_MARKS,
 #endif
+	UCOUNT_BPF_NAMESPACES,
 	UCOUNT_COUNTS,
 };
 
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 0224261..828aef0 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -44,3 +44,4 @@ obj-$(CONFIG_BPF_PRELOAD) += preload/
 obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
 $(obj)/relo_core.o: $(srctree)/tools/lib/bpf/relo_core.c FORCE
 	$(call if_changed_rule,cc_o_c)
+obj-$(CONFIG_BPF_SYSCALL) += bpf_namespace.o
diff --git a/kernel/bpf/bpf_namespace.c b/kernel/bpf/bpf_namespace.c
new file mode 100644
index 0000000..88a86cd
--- /dev/null
+++ b/kernel/bpf/bpf_namespace.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/ns_common.h>
+#include <linux/syscalls.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/proc_ns.h>
+#include <linux/sched/task.h>
+#include <linux/sched/signal.h>
+#include <linux/idr.h>
+#include <linux/user_namespace.h>
+#include <linux/bpf_namespace.h>
+
+#define MAX_BPF_NS_LEVEL 32
+static struct kmem_cache *bpfns_cachep;
+static struct kmem_cache *obj_id_cache[MAX_PID_NS_LEVEL];
+static struct ns_common *bpfns_get(struct task_struct *task);
+static void bpfns_put(struct ns_common *ns);
+static struct kmem_cache *create_bpf_cachep(unsigned int level);
+static DEFINE_MUTEX(obj_id_caches_mutex);
+
+static int bpfns_install(struct nsset *nsset, struct ns_common *ns)
+{
+	pr_info("setns not supported for bpf namespace");
+	return -EOPNOTSUPP;
+}
+
+struct proc_ns_operations bpfns_operations = {
+	.name = "bpf",
+	.type = CLONE_NEWBPF,
+	.get  = bpfns_get,
+	.put  = bpfns_put,
+	.install = bpfns_install,
+};
+
+struct bpf_namespace init_bpf_ns = {
+	.level = 0,
+	.user_ns = &init_user_ns,
+	.ns.ops = &bpfns_operations,
+	.ns.inum = PROC_BPF_INIT_INO,
+};
+
+static struct bpf_namespace *get_bpfns(struct bpf_namespace *ns)
+{
+	if (ns != &init_bpf_ns)
+		refcount_inc(&ns->ns.count);
+	return ns;
+}
+
+static struct ns_common *bpfns_get(struct task_struct *task)
+{
+	struct ns_common *ns = NULL;
+	struct nsproxy *nsproxy;
+
+	rcu_read_lock();
+	nsproxy = task->nsproxy;
+	if (nsproxy) {
+		ns = &nsproxy->bpf_ns->ns;
+		get_bpfns(container_of(ns, struct bpf_namespace, ns));
+	}
+	rcu_read_unlock();
+	return ns;
+}
+
+static struct ucounts *inc_bpf_namespaces(struct user_namespace *ns)
+{
+	return inc_ucount(ns, current_euid(), UCOUNT_BPF_NAMESPACES);
+}
+
+static void dec_bpf_namespaces(struct ucounts *ucounts)
+{
+	dec_ucount(ucounts, UCOUNT_BPF_NAMESPACES);
+}
+
+static void delayed_free_bpfns(struct rcu_head *p)
+{
+	struct bpf_namespace *ns = container_of(p, struct bpf_namespace, rcu);
+
+	dec_bpf_namespaces(ns->ucounts);
+	put_user_ns(ns->user_ns);
+	kmem_cache_free(bpfns_cachep, ns);
+}
+
+static void destroy_bpf_namespace(struct bpf_namespace *ns)
+{
+	int i;
+
+	ns_free_inum(&ns->ns);
+	for (i = 0; i < OBJ_ID_NUM; i++)
+		idr_destroy(&ns->idr[i]);
+	call_rcu(&ns->rcu, delayed_free_bpfns);
+}
+
+void put_bpfns(struct bpf_namespace *ns)
+{
+	struct bpf_namespace *parent;
+
+	while (ns != &init_bpf_ns) {
+		parent = ns->parent;
+		if (!refcount_dec_and_test(&ns->ns.count))
+			break;
+		destroy_bpf_namespace(ns);
+		ns = parent;
+	}
+}
+
+static void bpfns_put(struct ns_common *ns)
+{
+	struct bpf_namespace *bpf_ns;
+
+	bpf_ns = container_of(ns, struct bpf_namespace, ns);
+	put_bpfns(bpf_ns);
+}
+
+static struct bpf_namespace *
+create_bpf_namespace(struct user_namespace *user_ns,
+						struct bpf_namespace *parent_bpfns)
+{
+	struct bpf_namespace *ns;
+	unsigned int level = parent_bpfns->level + 1;
+	struct ucounts *ucounts;
+	int err;
+	int i;
+
+	err = -EINVAL;
+	if (!in_userns(parent_bpfns->user_ns, user_ns))
+		goto out;
+
+	err = -ENOSPC;
+	if (level > MAX_BPF_NS_LEVEL)
+		goto out;
+	ucounts = inc_bpf_namespaces(user_ns);
+	if (!ucounts)
+		goto out;
+
+	err = -ENOMEM;
+	ns = kmem_cache_zalloc(bpfns_cachep, GFP_KERNEL);
+	if (!ns)
+		goto out_dec;
+
+	for (i = 0; i < OBJ_ID_NUM; i++)
+		idr_init(&ns->idr[i]);
+
+	ns->obj_id_cachep = create_bpf_cachep(level);
+	if (!ns->obj_id_cachep)
+		goto out_free_idr;
+
+	err = ns_alloc_inum(&ns->ns);
+	if (err)
+		goto out_free_idr;
+	ns->ns.ops = &bpfns_operations;
+
+	refcount_set(&ns->ns.count, 1);
+	ns->level = level;
+	ns->parent = get_bpfns(parent_bpfns);
+	ns->user_ns = get_user_ns(user_ns);
+	ns->ucounts = ucounts;
+	return ns;
+
+out_free_idr:
+	for (i = 0; i < OBJ_ID_NUM; i++)
+		idr_destroy(&ns->idr[i]);
+	kmem_cache_free(bpfns_cachep, ns);
+out_dec:
+	dec_bpf_namespaces(ucounts);
+out:
+	return ERR_PTR(err);
+}
+
+struct bpf_namespace *copy_bpfns(unsigned long flags,
+								 struct user_namespace *user_ns,
+								 struct bpf_namespace *old_ns)
+{
+	if (!(flags & CLONE_NEWBPF))
+		return get_bpfns(old_ns);
+	return create_bpf_namespace(user_ns, old_ns);
+}
+
+static struct kmem_cache *create_bpf_cachep(unsigned int level)
+{
+	/* Level 0 is init_bpf_ns.obj_id_cachep */
+	struct kmem_cache **pkc = &obj_id_cache[level - 1];
+	struct kmem_cache *kc;
+	char name[4 + 10 + 1];
+	unsigned int len;
+
+	kc = READ_ONCE(*pkc);
+	if (kc)
+		return kc;
+
+	snprintf(name, sizeof(name), "bpf_%u", level + 1);
+	len = sizeof(struct bpf_obj_id) + level * sizeof(struct ubpf_obj_id);
+	mutex_lock(&obj_id_caches_mutex);
+	/* Name collision forces to do allocation under mutex. */
+	if (!*pkc)
+		*pkc = kmem_cache_create(name, len, 0,
+					 SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT, NULL);
+	mutex_unlock(&obj_id_caches_mutex);
+	/* current can fail, but someone else can succeed. */
+	return READ_ONCE(*pkc);
+}
+
+static void __init bpfns_idr_init(void)
+{
+	int i;
+
+	init_bpf_ns.obj_id_cachep =
+		KMEM_CACHE(pid, SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
+	for (i = 0; i < OBJ_ID_NUM; i++)
+		idr_init(&init_bpf_ns.idr[i]);
+}
+
+static __init int bpf_namespaces_init(void)
+{
+	bpfns_cachep = KMEM_CACHE(bpf_namespace, SLAB_PANIC | SLAB_ACCOUNT);
+	bpfns_idr_init();
+	return 0;
+}
+
+late_initcall(bpf_namespaces_init);
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index a487ff2..6a6fa70 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -19,6 +19,7 @@
 #include <net/net_namespace.h>
 #include <linux/ipc_namespace.h>
 #include <linux/time_namespace.h>
+#include <linux/bpf_namespace.h>
 #include <linux/fs_struct.h>
 #include <linux/proc_fs.h>
 #include <linux/proc_ns.h>
@@ -26,6 +27,7 @@
 #include <linux/syscalls.h>
 #include <linux/cgroup.h>
 #include <linux/perf_event.h>
+#include <linux/bpf_namespace.h>
 
 static struct kmem_cache *nsproxy_cachep;
 
@@ -47,6 +49,9 @@ struct nsproxy init_nsproxy = {
 	.time_ns		= &init_time_ns,
 	.time_ns_for_children	= &init_time_ns,
 #endif
+#ifdef CONFIG_BPF
+	.bpf_ns		= &init_bpf_ns,
+#endif
 };
 
 static inline struct nsproxy *create_nsproxy(void)
@@ -121,8 +126,16 @@ static struct nsproxy *create_new_namespaces(unsigned long flags,
 	}
 	new_nsp->time_ns = get_time_ns(tsk->nsproxy->time_ns);
 
+	new_nsp->bpf_ns = copy_bpfns(flags, user_ns, tsk->nsproxy->bpf_ns);
+	if (IS_ERR(new_nsp->bpf_ns)) {
+		err = PTR_ERR(new_nsp->bpf_ns);
+		goto out_bpf;
+	}
 	return new_nsp;
 
+out_bpf:
+	put_time_ns(new_nsp->time_ns);
+	put_time_ns(new_nsp->time_ns_for_children);
 out_time:
 	put_net(new_nsp->net_ns);
 out_net:
@@ -156,7 +169,7 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
 
 	if (likely(!(flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
 			      CLONE_NEWPID | CLONE_NEWNET |
-			      CLONE_NEWCGROUP | CLONE_NEWTIME)))) {
+			      CLONE_NEWCGROUP | CLONE_NEWTIME | CLONE_NEWBPF)))) {
 		if ((flags & CLONE_VM) ||
 		    likely(old_ns->time_ns_for_children == old_ns->time_ns)) {
 			get_nsproxy(old_ns);
@@ -203,6 +216,8 @@ void free_nsproxy(struct nsproxy *ns)
 		put_time_ns(ns->time_ns_for_children);
 	put_cgroup_ns(ns->cgroup_ns);
 	put_net(ns->net_ns);
+	if (ns->bpf_ns)
+		put_bpfns(ns->bpf_ns);
 	kmem_cache_free(nsproxy_cachep, ns);
 }
 
@@ -218,7 +233,7 @@ int unshare_nsproxy_namespaces(unsigned long unshare_flags,
 
 	if (!(unshare_flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
 			       CLONE_NEWNET | CLONE_NEWPID | CLONE_NEWCGROUP |
-			       CLONE_NEWTIME)))
+			       CLONE_NEWTIME | CLONE_NEWBPF)))
 		return 0;
 
 	user_ns = new_cred ? new_cred->user_ns : current_user_ns();
diff --git a/kernel/ucount.c b/kernel/ucount.c
index ee8e57f..97e0ae3 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -87,6 +87,7 @@ static int set_permissions(struct ctl_table_header *head,
 	UCOUNT_ENTRY("max_fanotify_groups"),
 	UCOUNT_ENTRY("max_fanotify_marks"),
 #endif
+	UCOUNT_ENTRY("max_bpf_namespaces"),
 	{ }
 };
 #endif /* CONFIG_SYSCTL */
-- 
1.8.3.1

