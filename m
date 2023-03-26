Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCB46C9375
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 11:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjCZJWo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Mar 2023 05:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjCZJWg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Mar 2023 05:22:36 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512169761;
        Sun, 26 Mar 2023 02:22:26 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id cn12so2512279qtb.8;
        Sun, 26 Mar 2023 02:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679822545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzrxwrWAnCBXqogVtCjOEq28yTqtM3iptGUsgJEuXWI=;
        b=EOer77E0LtfFk5y/lMefHgP5KaR43zAlptvyxKct+Vk51+7/uX1YJjJTUCQui/7SwY
         jZb/qCgxfZs5JvSKJMWt+3T1/2kFjpKtlw6tWsDDhcOhFMIs4+v3McHXz+Dm0hD3BqxP
         nozGYDtGnh9ZU0zVbyelEFydKVwi4atm1jyOhA+0icYhB7BDM2KZNIsuOtZuTj2u7dtN
         p7FpSKE7UzzpjtyNR6TrkL1m2eaoQIb3TFZQ43E2HWwmVg1HTMXx17GvnAnxwS3vsOPG
         QcOt+QgG+dW9jmzy7iC0FGDaLidTptgmBrRPRU3dV3x/wAUTwKrW7WxRq4HSxeBiDBaJ
         c5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679822545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzrxwrWAnCBXqogVtCjOEq28yTqtM3iptGUsgJEuXWI=;
        b=LY9zQYhAy9i/o6imx9biMdqaE56naPV14XtfihQ85Owe6LLrFqNZWaoGiuRXKi0Z3g
         QXrAY2l9xwWcQZlCYo54jSi76Pz/XmrAhQCDinLbpSRDYjcF169x4H0ozuga2z3cc1Bx
         AK9vyvUnackr6C9X85s2xvpUdp8AuioRyTVuep7IGqfkB0hf4ofSyRvRfR4ZU18BAMS/
         W5/QqQwiNES2MznlrhEzBBUUmT2RBUklVKdyJFUlrO5I7w2oai42gUbaww5Y0vSWBTgc
         yWF376ZHj7CxKO9LQXMf7CfRTJJ2bp+uTbY+gJuo0T3mXdZyWGnGqtPcAnMtHVfpyoB0
         c47w==
X-Gm-Message-State: AAQBX9fl9iH9EuWEI+k3NnxwDgv3xY8OwvGKgJ8RW9bPTD1hM/MjPTIx
        xSwLCyY7NIwPIDwb3SuGu0w=
X-Google-Smtp-Source: AK7set8M6zfz3X5CPC7/DoJ9uXrvklPCsodJDcqWq+WX69uwYe2dRtEx8t4rk6jrJVpxkD+8zVsWhw==
X-Received: by 2002:a05:622a:199a:b0:3d7:db35:f2c1 with SMTP id u26-20020a05622a199a00b003d7db35f2c1mr14762506qtc.15.1679822545146;
        Sun, 26 Mar 2023 02:22:25 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:1000:1a1f:5400:4ff:fe5e:1d32])
        by smtp.gmail.com with ESMTPSA id y5-20020ac87085000000b003e014845d9esm10257987qto.74.2023.03.26.02.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 02:22:24 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 09/13] bpf: Alloc and free bpf_prog id in bpf namespace
Date:   Sun, 26 Mar 2023 09:22:04 +0000
Message-Id: <20230326092208.13613-10-laoar.shao@gmail.com>
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

Similar to bpf map, We only expose the bpf map id under current bpf
namespace to user. The prog->aux->id is still the id in the init bpf
namespace.
The id of used_maps is also the id in current bpf namespace.

The result as follows,

Run bpftool in current namespace,
$ bpftool map show
4: array  name kprobe_b.rodata  flags 0x80
        key 4B  value 37B  max_entries 1  memlock 360B
        btf_id 96  frozen
        pids kprobe(8790)
5: array  name kprobe_b.data  flags 0x400
        key 4B  value 4B  max_entries 1  memlock 8192B
        btf_id 96
        pids kprobe(8790)

$ bpftool prog show
7: kprobe  name kretprobe_run  tag 0de47cc241a2b1b3  gpl
        loaded_at 2023-03-21T10:20:58+0800  uid 0
        xlated 56B  jited 39B  memlock 4096B  map_ids 4
        btf_id 96
9: kprobe  name kprobe_run  tag bf163b23cd3b174d  gpl
        loaded_at 2023-03-21T10:20:58+0800  uid 0
        xlated 48B  jited 35B  memlock 4096B  map_ids 4
        btf_id 96

At the same time, run bpftool in init bpf namespace.
$ bpftool map show
18: array  name kprobe_b.rodata  flags 0x80
        key 4B  value 37B  max_entries 1  memlock 360B
        btf_id 96  frozen
        pids kprobe(8790)
19: array  name kprobe_b.data  flags 0x400
        key 4B  value 4B  max_entries 1  memlock 8192B
        btf_id 96
        pids kprobe(8790)

$ bpftool prog show
29: kprobe  name kretprobe_run  tag 0de47cc241a2b1b3  gpl
        loaded_at 2023-03-21T10:20:58+0800  uid 0
        xlated 56B  jited 39B  memlock 4096B  map_ids 18
        btf_id 96
        pids kprobe(8790)
31: kprobe  name kprobe_run  tag bf163b23cd3b174d  gpl
        loaded_at 2023-03-21T10:20:58+0800  uid 0
        xlated 48B  jited 35B  memlock 4096B  map_ids 18
        btf_id 96
        pids kprobe(8790)

In init bpf namespace, bpftool can also show other bpf progs, but the
bpftool running in the new bpf namespace can't.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/bpf.h                       |  3 +-
 kernel/bpf/bpf_namespace.c                |  1 +
 kernel/bpf/syscall.c                      | 56 ++++++++++---------------------
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c |  3 +-
 4 files changed, 22 insertions(+), 41 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2a1f19c..16f2a01 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1416,6 +1416,7 @@ struct bpf_prog_aux {
 		struct work_struct work;
 		struct rcu_head	rcu;
 	};
+	struct bpf_obj_id *obj_id;
 };
 
 struct bpf_prog {
@@ -1940,8 +1941,6 @@ struct bpf_prog *bpf_prog_get_type_dev(u32 ufd, enum bpf_prog_type type,
 struct bpf_prog * __must_check bpf_prog_inc_not_zero(struct bpf_prog *prog);
 void bpf_prog_put(struct bpf_prog *prog);
 
-void bpf_prog_free_id(struct bpf_prog *prog);
-
 struct btf_field *btf_record_find(const struct btf_record *rec,
 				  u32 offset, u32 field_mask);
 void btf_record_free(struct btf_record *rec);
diff --git a/kernel/bpf/bpf_namespace.c b/kernel/bpf/bpf_namespace.c
index 6a6ef70..8c70945 100644
--- a/kernel/bpf/bpf_namespace.c
+++ b/kernel/bpf/bpf_namespace.c
@@ -12,6 +12,7 @@
 
 #define MAX_BPF_NS_LEVEL 32
 DEFINE_SPINLOCK(map_idr_lock);
+DEFINE_SPINLOCK(prog_idr_lock);
 static struct kmem_cache *bpfns_cachep;
 static struct kmem_cache *obj_id_cache[MAX_PID_NS_LEVEL];
 static struct ns_common *bpfns_get(struct task_struct *task);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 1335200..4725924 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -48,8 +48,6 @@
 #define BPF_OBJ_FLAG_MASK   (BPF_F_RDONLY | BPF_F_WRONLY)
 
 DEFINE_PER_CPU(int, bpf_prog_active);
-static DEFINE_IDR(prog_idr);
-DEFINE_SPINLOCK(prog_idr_lock);
 static DEFINE_IDR(link_idr);
 DEFINE_SPINLOCK(link_idr_lock);
 
@@ -1983,32 +1981,10 @@ static void bpf_audit_prog(const struct bpf_prog *prog, unsigned int op)
 	if (unlikely(!ab))
 		return;
 	audit_log_format(ab, "prog-id=%u op=%s",
-			 prog->aux->id, bpf_audit_str[op]);
+			 bpf_obj_id_vnr(prog->aux->obj_id), bpf_audit_str[op]);
 	audit_log_end(ab);
 }
 
-static int bpf_prog_alloc_id(struct bpf_prog *prog)
-{
-	int id;
-
-	idr_preload(GFP_KERNEL);
-	spin_lock_bh(&prog_idr_lock);
-	id = idr_alloc_cyclic(&prog_idr, prog, 1, INT_MAX, GFP_ATOMIC);
-	spin_unlock_bh(&prog_idr_lock);
-	idr_preload_end();
-
-	return id;
-}
-
-void bpf_prog_free_id(struct bpf_prog *prog)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&prog_idr_lock, flags);
-	idr_remove(&prog_idr, prog->aux->id);
-	spin_unlock_irqrestore(&prog_idr_lock, flags);
-}
-
 static void __bpf_prog_put_rcu(struct rcu_head *rcu)
 {
 	struct bpf_prog_aux *aux = container_of(rcu, struct bpf_prog_aux, rcu);
@@ -2056,7 +2032,7 @@ static void bpf_prog_put_deferred(struct work_struct *work)
 	 * simply waiting for refcnt to drop to be freed.
 	 */
 	if (prog->aux->id) {
-		bpf_prog_free_id(prog);
+		bpf_free_obj_id(prog->aux->obj_id, PROG_OBJ_ID);
 		prog->aux->id = 0;
 	}
 	__bpf_prog_put_noref(prog, true);
@@ -2157,7 +2133,7 @@ static void bpf_prog_show_fdinfo(struct seq_file *m, struct file *filp)
 		   prog->jited,
 		   prog_tag,
 		   prog->pages * 1ULL << PAGE_SHIFT,
-		   prog->aux->id,
+		   bpf_obj_id_vnr(prog->aux->obj_id),
 		   stats.nsecs,
 		   stats.cnt,
 		   stats.misses,
@@ -2468,6 +2444,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
 	enum bpf_prog_type type = attr->prog_type;
 	struct bpf_prog *prog, *dst_prog = NULL;
 	struct btf *attach_btf = NULL;
+	struct bpf_obj_id *obj_id;
 	int err;
 	char license[128];
 	bool is_gpl;
@@ -2621,12 +2598,13 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
 	if (err < 0)
 		goto free_used_maps;
 
-	err = bpf_prog_alloc_id(prog);
-	if (err < 0)
+	obj_id = bpf_alloc_obj_id(current->nsproxy->bpf_ns, prog, PROG_OBJ_ID);
+	if (IS_ERR(obj_id))
 		goto free_used_maps;
-	prog->aux->id = err;
+	prog->aux->obj_id = obj_id;
+	prog->aux->id = bpf_obj_id_nr(obj_id);
 
-	/* Upon success of bpf_prog_alloc_id(), the BPF prog is
+	/* Upon success of bpf_alloc_obj_id(), the BPF prog is
 	 * effectively publicly exposed. However, retrieving via
 	 * bpf_prog_get_fd_by_id() will take another reference,
 	 * therefore it cannot be gone underneath us.
@@ -2803,7 +2781,7 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
 			   "prog_tag:\t%s\n"
 			   "prog_id:\t%u\n",
 			   prog_tag,
-			   prog->aux->id);
+			   bpf_obj_id_vnr(prog->aux->obj_id));
 	}
 	if (link->ops->show_fdinfo)
 		link->ops->show_fdinfo(link, m);
@@ -3706,11 +3684,12 @@ struct bpf_map *bpf_map_get_curr_or_next(u32 *id)
 
 struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id)
 {
+	struct bpf_namespace *ns = current->nsproxy->bpf_ns;
 	struct bpf_prog *prog;
 
 	spin_lock_bh(&prog_idr_lock);
 again:
-	prog = idr_get_next(&prog_idr, id);
+	prog = idr_get_next(&ns->idr[PROG_OBJ_ID], id);
 	if (prog) {
 		prog = bpf_prog_inc_not_zero(prog);
 		if (IS_ERR(prog)) {
@@ -3727,13 +3706,14 @@ struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id)
 
 struct bpf_prog *bpf_prog_by_id(u32 id)
 {
+	struct bpf_namespace *ns = current->nsproxy->bpf_ns;
 	struct bpf_prog *prog;
 
 	if (!id)
 		return ERR_PTR(-ENOENT);
 
 	spin_lock_bh(&prog_idr_lock);
-	prog = idr_find(&prog_idr, id);
+	prog = idr_find(&ns->idr[PROG_OBJ_ID], id);
 	if (prog)
 		prog = bpf_prog_inc_not_zero(prog);
 	else
@@ -3939,7 +3919,7 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 		return -EFAULT;
 
 	info.type = prog->type;
-	info.id = prog->aux->id;
+	info.id = bpf_obj_id_vnr(prog->aux->obj_id);
 	info.load_time = prog->aux->load_time;
 	info.created_by_uid = from_kuid_munged(current_user_ns(),
 					       prog->aux->user->uid);
@@ -4287,7 +4267,7 @@ static int bpf_link_get_info_by_fd(struct file *file,
 	info.type = link->type;
 	info.id = link->id;
 	if (link->prog)
-		info.prog_id = link->prog->aux->id;
+		info.prog_id = bpf_obj_id_vnr(link->prog->aux->obj_id);
 
 	if (link->ops->fill_link_info) {
 		err = link->ops->fill_link_info(link, &info);
@@ -4452,7 +4432,7 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
 			struct bpf_raw_event_map *btp = raw_tp->btp;
 
 			err = bpf_task_fd_query_copy(attr, uattr,
-						     raw_tp->link.prog->aux->id,
+						     bpf_obj_id_vnr(raw_tp->link.prog->aux->obj_id),
 						     BPF_FD_TYPE_RAW_TRACEPOINT,
 						     btp->tp->name, 0, 0);
 			goto put_file;
@@ -5048,7 +5028,7 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 		break;
 	case BPF_PROG_GET_NEXT_ID:
 		err = bpf_obj_get_next_id(&attr, uattr.user,
-					  &prog_idr, &prog_idr_lock);
+					  &ns->idr[PROG_OBJ_ID], &prog_idr_lock);
 		break;
 	case BPF_MAP_GET_NEXT_ID:
 		err = bpf_obj_get_next_id(&attr, uattr.user,
diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
index a71aef7..1fd8ceb 100644
--- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
+++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
@@ -28,7 +28,8 @@ static __always_inline __u32 get_obj_id(void *ent, enum bpf_obj_type type)
 
 	switch (type) {
 	case BPF_OBJ_PROG:
-		return BPF_CORE_READ((struct bpf_prog *)ent, aux, id);
+		obj_id = BPF_CORE_READ((struct bpf_prog *)ent, aux, obj_id);
+		break;
 	case BPF_OBJ_MAP:
 		obj_id = BPF_CORE_READ((struct bpf_map *)ent, obj_id);
 		break;
-- 
1.8.3.1

