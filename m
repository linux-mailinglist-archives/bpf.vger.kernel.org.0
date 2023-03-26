Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3DA6C9370
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 11:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjCZJWh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Mar 2023 05:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjCZJW1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Mar 2023 05:22:27 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC029744;
        Sun, 26 Mar 2023 02:22:24 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id x1so5867859qtr.7;
        Sun, 26 Mar 2023 02:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679822544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAnrIb2gJlyVBdwgYJnkHeO4jmGKmm9oA7p2u8wyILQ=;
        b=HuluRPIl7ODzzyoZP/Ot+Yfvh1vDS809QCerFAqbUTJMfINtQFFxYQoMXevlC1wTLe
         6pfDOgx/aIGmBCo+uZBZqCirUwnnPlzjhsw/p50ZiPNLFlZM9FAP3ur1LyPwoAOPer3T
         eKO/uDefVr6QW9mmTtb/RaXCIHSQGHRzJXzJBis9xemUkzJWtuTRGAg9ZreL4FUMbsa0
         G0vVinwhSvfucXH5zocbSZCCWFy71JG0DsDmHw5+Yan66FF3I5WEVrpt1Xfw6jt23W8f
         y5J3h/buyjplq8rPRb9vn0Gcohr1gJSrZ5Ed6ojfZnziGCvcCXKnguffyROmMDMKXNdi
         vZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679822544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAnrIb2gJlyVBdwgYJnkHeO4jmGKmm9oA7p2u8wyILQ=;
        b=mnHq4yGbcFcUeIfR4cAmN49OWSCnaNMVXQE59WVnet7+2aksCQtQEuZoKC6Xx/Nu/I
         e8+36TDrXEBx47dkh66NbTjWZeOdfByeSm88dgzNnRw25uYFXcGx2x+Fc23ZIOtZYAvV
         qWcu/80SSMjmhHxuqcSrBbwK1hoSiGkxfuwg6vsHSR+R1LfrFhLN4edQyV/3fsw/KMIO
         zHMnOI0e4TSCrw2LYxdOk6J7vXzROcqzMFOHTzKcIINL+9XS7bozMFKV/eOHP6JyUKFB
         tOJ5QbSKz6H4KGMOQ0KIKm1gtjIi28VIoAYzBt44juy2KEQ/SbqLIXr0SB6kp0wksKgo
         o5MQ==
X-Gm-Message-State: AO0yUKWpx8EAG1YQkM1i/7bbCWlmwtrFinoE2MI5PFVNAJmoDVkyfnpV
        FVh7TuHrr84xRa30zztxleY=
X-Google-Smtp-Source: AK7set/N7UeljOUhwLWgA1VlTZpVEocvGAOCAVIuK5GyvbdfpXs5BiCuNEOADmm8KzerjN1aOdebGQ==
X-Received: by 2002:a05:622a:15d2:b0:3e3:8502:fbcb with SMTP id d18-20020a05622a15d200b003e38502fbcbmr14140636qty.40.1679822544166;
        Sun, 26 Mar 2023 02:22:24 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:1000:1a1f:5400:4ff:fe5e:1d32])
        by smtp.gmail.com with ESMTPSA id y5-20020ac87085000000b003e014845d9esm10257987qto.74.2023.03.26.02.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 02:22:23 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 08/13] bpf: Alloc and free bpf_map id in bpf namespace
Date:   Sun, 26 Mar 2023 09:22:03 +0000
Message-Id: <20230326092208.13613-9-laoar.shao@gmail.com>
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

We only expose the bpf map id under current bpf namespace to user. The
map->id is still the id in the init bpf namespace.

The result as follows,

Run bpftool in a new bpf namespace
$ bpftool map show
4: array  name kprobe_b.rodata  flags 0x80
        key 4B  value 37B  max_entries 1  memlock 360B
        btf_id 159  frozen
        pids kprobe(20490)
5: array  name kprobe_b.data  flags 0x400
        key 4B  value 4B  max_entries 1  memlock 8192B
        btf_id 159
        pids kprobe(20490)
$ bpftool prog show
91: kprobe  name kretprobe_run  tag 0de47cc241a2b1b3  gpl
        loaded_at 2023-03-20T22:19:16+0800  uid 0
        xlated 56B  jited 39B  memlock 4096B  map_ids 4
        btf_id 159
        pids kprobe(20490)
93: kprobe  name kprobe_run  tag bf163b23cd3b174d  gpl
        loaded_at 2023-03-20T22:19:16+0800  uid 0
        xlated 48B  jited 35B  memlock 4096B  map_ids 4
        btf_id 159
        pids kprobe(20490)

At the same time, run bpftool in init bpf namespace,
$ bpftool map show
48: array  name kprobe_b.rodata  flags 0x80
        key 4B  value 37B  max_entries 1  memlock 360B
        btf_id 159  frozen
        pids kprobe(20490)
49: array  name kprobe_b.data  flags 0x400
        key 4B  value 4B  max_entries 1  memlock 8192B
        btf_id 159
        pids kprobe(20490)
$ bpftool prog show
91: kprobe  name kretprobe_run  tag 0de47cc241a2b1b3  gpl
        loaded_at 2023-03-20T22:19:16+0800  uid 0
        xlated 56B  jited 39B  memlock 4096B  map_ids 48
        btf_id 159
        pids kprobe(20490)
93: kprobe  name kprobe_run  tag bf163b23cd3b174d  gpl
        loaded_at 2023-03-20T22:19:16+0800  uid 0
        xlated 48B  jited 35B  memlock 4096B  map_ids 48
        btf_id 159
        pids kprobe(20490)

In init bpf namespace, bpftool can also show other bpf maps, but the
bpftool running in the new bpf namespace can't.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/bpf.h                       |  3 +-
 kernel/bpf/bpf_namespace.c                |  1 +
 kernel/bpf/offload.c                      |  3 +-
 kernel/bpf/syscall.c                      | 58 ++++++++++---------------------
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c |  7 +++-
 5 files changed, 30 insertions(+), 42 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c94034a..2a1f19c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -29,6 +29,7 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/static_call.h>
 #include <linux/memcontrol.h>
+#include <linux/bpf_namespace.h>
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -279,6 +280,7 @@ struct bpf_map {
 	} owner;
 	bool bypass_spec_v1;
 	bool frozen; /* write-once; write-protected by freeze_mutex */
+	struct bpf_obj_id *obj_id;
 };
 
 static inline const char *btf_field_type_name(enum btf_field_type type)
@@ -1939,7 +1941,6 @@ struct bpf_prog *bpf_prog_get_type_dev(u32 ufd, enum bpf_prog_type type,
 void bpf_prog_put(struct bpf_prog *prog);
 
 void bpf_prog_free_id(struct bpf_prog *prog);
-void bpf_map_free_id(struct bpf_map *map);
 
 struct btf_field *btf_record_find(const struct btf_record *rec,
 				  u32 offset, u32 field_mask);
diff --git a/kernel/bpf/bpf_namespace.c b/kernel/bpf/bpf_namespace.c
index 1e98d1d..6a6ef70 100644
--- a/kernel/bpf/bpf_namespace.c
+++ b/kernel/bpf/bpf_namespace.c
@@ -11,6 +11,7 @@
 #include <linux/bpf_namespace.h>
 
 #define MAX_BPF_NS_LEVEL 32
+DEFINE_SPINLOCK(map_idr_lock);
 static struct kmem_cache *bpfns_cachep;
 static struct kmem_cache *obj_id_cache[MAX_PID_NS_LEVEL];
 static struct ns_common *bpfns_get(struct task_struct *task);
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index aec70e0..7a90ebe 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -25,6 +25,7 @@
 #include <linux/rhashtable.h>
 #include <linux/rtnetlink.h>
 #include <linux/rwsem.h>
+#include <linux/bpf_namespace.h>
 
 /* Protects offdevs, members of bpf_offload_netdev and offload members
  * of all progs.
@@ -145,7 +146,7 @@ static void __bpf_map_offload_destroy(struct bpf_offloaded_map *offmap)
 	 * refcnt to drop to be freed.
 	 */
 	if (map->id) {
-		bpf_map_free_id(map);
+		bpf_free_obj_id(map->obj_id, MAP_OBJ_ID);
 		map->id = 0;
 	}
 	list_del_init(&offmap->offloads);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f24e550..1335200 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -35,6 +35,7 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/memcontrol.h>
 #include <linux/trace_events.h>
+#include <linux/bpf_namespace.h>
 
 #define IS_FD_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
 			  (map)->map_type == BPF_MAP_TYPE_CGROUP_ARRAY || \
@@ -49,8 +50,6 @@
 DEFINE_PER_CPU(int, bpf_prog_active);
 static DEFINE_IDR(prog_idr);
 DEFINE_SPINLOCK(prog_idr_lock);
-static DEFINE_IDR(map_idr);
-DEFINE_SPINLOCK(map_idr_lock);
 static DEFINE_IDR(link_idr);
 DEFINE_SPINLOCK(link_idr_lock);
 
@@ -375,30 +374,6 @@ void bpf_map_init_from_attr(struct bpf_map *map, union bpf_attr *attr)
 	map->map_extra = attr->map_extra;
 }
 
-static int bpf_map_alloc_id(struct bpf_map *map)
-{
-	int id;
-
-	idr_preload(GFP_KERNEL);
-	spin_lock_bh(&map_idr_lock);
-	id = idr_alloc_cyclic(&map_idr, map, 1, INT_MAX, GFP_ATOMIC);
-	spin_unlock_bh(&map_idr_lock);
-	idr_preload_end();
-
-	return id;
-}
-
-void bpf_map_free_id(struct bpf_map *map)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&map_idr_lock, flags);
-
-	idr_remove(&map_idr, map->id);
-
-	spin_unlock_irqrestore(&map_idr_lock, flags);
-}
-
 #ifdef CONFIG_MEMCG_KMEM
 static void bpf_map_save_memcg(struct bpf_map *map)
 {
@@ -737,9 +712,9 @@ static void bpf_map_put_uref(struct bpf_map *map)
 void bpf_map_put(struct bpf_map *map)
 {
 	if (atomic64_dec_and_test(&map->refcnt)) {
-		/* bpf_map_free_id() must be called first. */
+		/* bpf_free_obj_id() must be called first. */
 		if (map->id) {
-			bpf_map_free_id(map);
+			bpf_free_obj_id(map->obj_id, MAP_OBJ_ID);
 			map->id = 0;
 		}
 		btf_put(map->btf);
@@ -817,7 +792,7 @@ static void bpf_map_show_fdinfo(struct seq_file *m, struct file *filp)
 		   map->map_flags,
 		   (unsigned long long)map->map_extra,
 		   bpf_map_memory_usage(map),
-		   map->id,
+		   bpf_obj_id_vnr(map->obj_id),
 		   READ_ONCE(map->frozen));
 	if (type) {
 		seq_printf(m, "owner_prog_type:\t%u\n", type);
@@ -1115,6 +1090,7 @@ static int map_create(union bpf_attr *attr)
 {
 	int numa_node = bpf_map_attr_numa_node(attr);
 	struct btf_field_offs *foffs;
+	struct bpf_obj_id *obj_id;
 	struct bpf_map *map;
 	int f_flags;
 	int err;
@@ -1206,10 +1182,11 @@ static int map_create(union bpf_attr *attr)
 	if (err)
 		goto free_map_field_offs;
 
-	err = bpf_map_alloc_id(map);
-	if (err < 0)
+	obj_id = bpf_alloc_obj_id(current->nsproxy->bpf_ns, map, MAP_OBJ_ID);
+	if (IS_ERR(obj_id))
 		goto free_map_sec;
-	map->id = err;
+	map->obj_id = obj_id;
+	map->id = bpf_obj_id_nr(obj_id);
 
 	bpf_map_save_memcg(map);
 
@@ -1217,7 +1194,7 @@ static int map_create(union bpf_attr *attr)
 	if (err < 0) {
 		/* failed to allocate fd.
 		 * bpf_map_put_with_uref() is needed because the above
-		 * bpf_map_alloc_id() has published the map
+		 * bpf_alloc_obj_id() has published the map
 		 * to the userspace and the userspace may
 		 * have refcnt-ed it through BPF_MAP_GET_FD_BY_ID.
 		 */
@@ -3709,11 +3686,12 @@ static int bpf_obj_get_next_id(const union bpf_attr *attr,
 
 struct bpf_map *bpf_map_get_curr_or_next(u32 *id)
 {
+	struct bpf_namespace *ns = current->nsproxy->bpf_ns;
 	struct bpf_map *map;
 
 	spin_lock_bh(&map_idr_lock);
 again:
-	map = idr_get_next(&map_idr, id);
+	map = idr_get_next(&ns->idr[MAP_OBJ_ID], id);
 	if (map) {
 		map = __bpf_map_inc_not_zero(map, false);
 		if (IS_ERR(map)) {
@@ -3791,6 +3769,7 @@ static int bpf_prog_get_fd_by_id(const union bpf_attr *attr)
 
 static int bpf_map_get_fd_by_id(const union bpf_attr *attr)
 {
+	struct bpf_namespace *ns = current->nsproxy->bpf_ns;
 	struct bpf_map *map;
 	u32 id = attr->map_id;
 	int f_flags;
@@ -3808,7 +3787,7 @@ static int bpf_map_get_fd_by_id(const union bpf_attr *attr)
 		return f_flags;
 
 	spin_lock_bh(&map_idr_lock);
-	map = idr_find(&map_idr, id);
+	map = idr_find(&ns->idr[MAP_OBJ_ID], id);
 	if (map)
 		map = __bpf_map_inc_not_zero(map, true);
 	else
@@ -3896,7 +3875,7 @@ static struct bpf_insn *bpf_insn_prepare_dump(const struct bpf_prog *prog,
 		map = bpf_map_from_imm(prog, imm, &off, &type);
 		if (map) {
 			insns[i].src_reg = type;
-			insns[i].imm = map->id;
+			insns[i].imm = bpf_obj_id_vnr(map->obj_id);
 			insns[i + 1].imm = off;
 			continue;
 		}
@@ -3978,7 +3957,7 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 		u32 i;
 
 		for (i = 0; i < ulen; i++)
-			if (put_user(prog->aux->used_maps[i]->id,
+			if (put_user(bpf_obj_id_vnr(prog->aux->used_maps[i]->obj_id),
 				     &user_map_ids[i])) {
 				mutex_unlock(&prog->aux->used_maps_mutex);
 				return -EFAULT;
@@ -4242,7 +4221,7 @@ static int bpf_map_get_info_by_fd(struct file *file,
 
 	memset(&info, 0, sizeof(info));
 	info.type = map->map_type;
-	info.id = map->id;
+	info.id = bpf_obj_id_vnr(map->obj_id);
 	info.key_size = map->key_size;
 	info.value_size = map->value_size;
 	info.max_entries = map->max_entries;
@@ -4994,6 +4973,7 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
 
 static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 {
+	struct bpf_namespace *ns = current->nsproxy->bpf_ns;
 	union bpf_attr attr;
 	bool capable;
 	int err;
@@ -5072,7 +5052,7 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 		break;
 	case BPF_MAP_GET_NEXT_ID:
 		err = bpf_obj_get_next_id(&attr, uattr.user,
-					  &map_idr, &map_idr_lock);
+					  &ns->idr[MAP_OBJ_ID], &map_idr_lock);
 		break;
 	case BPF_BTF_GET_NEXT_ID:
 		err = bpf_obj_get_next_id(&attr, uattr.user,
diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
index eb05ea5..a71aef7 100644
--- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
+++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
@@ -24,11 +24,14 @@ enum bpf_obj_type {
 
 static __always_inline __u32 get_obj_id(void *ent, enum bpf_obj_type type)
 {
+	void *obj_id;
+
 	switch (type) {
 	case BPF_OBJ_PROG:
 		return BPF_CORE_READ((struct bpf_prog *)ent, aux, id);
 	case BPF_OBJ_MAP:
-		return BPF_CORE_READ((struct bpf_map *)ent, id);
+		obj_id = BPF_CORE_READ((struct bpf_map *)ent, obj_id);
+		break;
 	case BPF_OBJ_BTF:
 		return BPF_CORE_READ((struct btf *)ent, id);
 	case BPF_OBJ_LINK:
@@ -36,6 +39,8 @@ static __always_inline __u32 get_obj_id(void *ent, enum bpf_obj_type type)
 	default:
 		return 0;
 	}
+
+	return bpf_find_obj_id(obj_id);
 }
 
 /* could be used only with BPF_LINK_TYPE_PERF_EVENT links */
-- 
1.8.3.1

