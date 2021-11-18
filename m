Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B56455A36
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 12:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343813AbhKRLaF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 06:30:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49049 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343871AbhKRL27 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 06:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637234759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ou9vYmCA8xtdoxix/C23Lw9M4Y94LjiNquU/4qPFDn4=;
        b=L8+CH/eX66ynFqT020zvg5qcd1SWzAmNH3kDHXSK/yK8tTXkQV47CLbZhpHbsrfMVdE6Mt
        6OqgYnwR89MXvluHzpjpMHBFHWu8ZffEei8YkiWjkjeWyLvG514/IqCfT2CrLOXR65K48u
        TxCoHGz69++CL6szdhQM53L5PULS8ps=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-7HPJB4hBMPOyBtG7fMLnxA-1; Thu, 18 Nov 2021 06:25:58 -0500
X-MC-Unique: 7HPJB4hBMPOyBtG7fMLnxA-1
Received: by mail-ed1-f69.google.com with SMTP id m8-20020a056402510800b003e29de5badbso4962836edd.18
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 03:25:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ou9vYmCA8xtdoxix/C23Lw9M4Y94LjiNquU/4qPFDn4=;
        b=ny5Ze6XbaXiB0KAH3IrdAf4OqH5kB6PB+tvHtyG4plnM7a+FmcD5KMnJgqqiHUBmUY
         4zILlo/6MNHsibRgGVOkBDKtKZbROudqxFbz22gwUCukFCx+2OYUsvPE3DJGzT3D+7Hn
         F+xgNlTgEsZQQYFkC4KU1dhTXKqKZ7FnC++0SC97HLhoHNvrKw+s5oM8Jqx9P6B+7D1B
         HDLuDYZTEsbxkFALH24odDDqzK+7dACmlVcGUqaOzq8u3wH6ghud+XeFiu50A6wmy0nF
         kM6gW3hlBalG4wX3NOsUjQHIsY9dz7ukxiKyRAxjPgQ6QPBLsbgqTZCp9Bb8qdJ4p4I8
         zwdw==
X-Gm-Message-State: AOAM531gAdsjfapVBaZJx8J5PRp2coUyrM5d1RuENNN2hSqVd91eRtx3
        EHKGlF4przJ1do3vHDNVt5VT7Kvb0tQw4wZExtpxGikG0E8UoeqFmDwO/VvODFE7Suz4K9b8X9H
        TNXGB+rEZABq5
X-Received: by 2002:a17:906:dc90:: with SMTP id cs16mr31926212ejc.432.1637234757196;
        Thu, 18 Nov 2021 03:25:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEz7U2o5WUZUjYnrN1aPFkLKsHXVXO/dxfGOUDUALgO5wAoUf0tkvMHTcujM2ZGuZMYPiThA==
X-Received: by 2002:a17:906:dc90:: with SMTP id cs16mr31926181ejc.432.1637234756997;
        Thu, 18 Nov 2021 03:25:56 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id jy28sm1146959ejc.118.2021.11.18.03.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 03:25:56 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: [PATCH bpf-next 10/29] bpf: Add bpf_trampoline_id object
Date:   Thu, 18 Nov 2021 12:24:36 +0100
Message-Id: <20211118112455.475349-11-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211118112455.475349-1-jolsa@kernel.org>
References: <20211118112455.475349-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Replacing the bpf_trampoline's key with struct bpf_tramp_id object,
that currently holds only obj_id/btf_id, so same data as key.

Having the key in the struct will allow us to add more ids (functions)
to single trampoline in following patches.

No functional change is intended.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h          | 18 +++++++++--
 include/linux/bpf_verifier.h | 19 ------------
 kernel/bpf/syscall.c         | 30 +++++++++++++-----
 kernel/bpf/trampoline.c      | 59 +++++++++++++++++++++++++++++++-----
 kernel/bpf/verifier.c        | 14 ++++++---
 5 files changed, 99 insertions(+), 41 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 35f484f323f3..2ce8b1c49af7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -671,13 +671,18 @@ struct bpf_tramp_image {
 	};
 };
 
+struct bpf_tramp_id {
+	u32 obj_id;
+	u32 btf_id;
+};
+
 struct bpf_trampoline {
 	/* hlist for trampoline_table */
 	struct hlist_node hlist;
 	/* serializes access to fields of this trampoline */
 	struct mutex mutex;
 	refcount_t refcnt;
-	u64 key;
+	struct bpf_tramp_id *id;
 	struct {
 		struct btf_func_model model;
 		void *addr;
@@ -732,9 +737,16 @@ static __always_inline __nocfi unsigned int bpf_dispatcher_nop_func(
 	return bpf_func(ctx, insnsi);
 }
 #ifdef CONFIG_BPF_JIT
+struct bpf_tramp_id *bpf_tramp_id_alloc(void);
+void bpf_tramp_id_free(struct bpf_tramp_id *id);
+bool bpf_tramp_id_is_empty(struct bpf_tramp_id *id);
+int bpf_tramp_id_is_equal(struct bpf_tramp_id *a, struct bpf_tramp_id *b);
+void bpf_tramp_id_init(struct bpf_tramp_id *id,
+		       const struct bpf_prog *tgt_prog,
+		       struct btf *btf, u32 btf_id);
 int bpf_trampoline_link_prog(struct bpf_prog *prog, struct bpf_trampoline *tr);
 int bpf_trampoline_unlink_prog(struct bpf_prog *prog, struct bpf_trampoline *tr);
-struct bpf_trampoline *bpf_trampoline_get(u64 key,
+struct bpf_trampoline *bpf_trampoline_get(struct bpf_tramp_id *id,
 					  struct bpf_attach_target_info *tgt_info);
 void bpf_trampoline_put(struct bpf_trampoline *tr);
 #define BPF_DISPATCHER_INIT(_name) {				\
@@ -792,7 +804,7 @@ static inline int bpf_trampoline_unlink_prog(struct bpf_prog *prog,
 {
 	return -ENOTSUPP;
 }
-static inline struct bpf_trampoline *bpf_trampoline_get(u64 key,
+static inline struct bpf_trampoline *bpf_trampoline_get(struct bpf_tramp_id *id,
 							struct bpf_attach_target_info *tgt_info)
 {
 	return ERR_PTR(-EOPNOTSUPP);
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b561c0b08e68..0c01a50180a0 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -503,25 +503,6 @@ int check_ctx_reg(struct bpf_verifier_env *env,
 int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		   u32 regno, u32 mem_size);
 
-/* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
-static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
-					     struct btf *btf, u32 btf_id)
-{
-	if (tgt_prog)
-		return ((u64)tgt_prog->aux->id << 32) | btf_id;
-	else
-		return ((u64)btf_obj_id(btf) << 32) | 0x80000000 | btf_id;
-}
-
-/* unpack the IDs from the key as constructed above */
-static inline void bpf_trampoline_unpack_key(u64 key, u32 *obj_id, u32 *btf_id)
-{
-	if (obj_id)
-		*obj_id = key >> 32;
-	if (btf_id)
-		*btf_id = key & 0x7FFFFFFF;
-}
-
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 648155f0a4b1..f99ea3237f9c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2703,9 +2703,8 @@ static int bpf_tracing_link_fill_link_info(const struct bpf_link *link,
 	struct bpf_trampoline *tr = link_trampoline(tr_link);
 
 	info->tracing.attach_type = tr_link->attach_type;
-	bpf_trampoline_unpack_key(tr->key,
-				  &info->tracing.target_obj_id,
-				  &info->tracing.target_btf_id);
+	info->tracing.target_obj_id = tr->id->obj_id;
+	info->tracing.target_btf_id = tr->id->btf_id;
 
 	return 0;
 }
@@ -2726,7 +2725,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	struct bpf_prog *tgt_prog = NULL;
 	struct bpf_trampoline *tr = NULL;
 	struct bpf_tracing_link *link;
-	u64 key = 0;
+	struct bpf_tramp_id *id = NULL;
 	int err;
 
 	switch (prog->type) {
@@ -2767,6 +2766,12 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 			goto out_put_prog;
 		}
 
+		id = bpf_tramp_id_alloc();
+		if (!id) {
+			err = -ENOMEM;
+			goto out_put_prog;
+		}
+
 		tgt_prog = bpf_prog_get(tgt_prog_fd);
 		if (IS_ERR(tgt_prog)) {
 			err = PTR_ERR(tgt_prog);
@@ -2774,7 +2779,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 			goto out_put_prog;
 		}
 
-		key = bpf_trampoline_compute_key(tgt_prog, NULL, btf_id);
+		bpf_tramp_id_init(id, tgt_prog, NULL, btf_id);
 	}
 
 	link = kzalloc(sizeof(*link), GFP_USER);
@@ -2823,12 +2828,20 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 			err = -EINVAL;
 			goto out_unlock;
 		}
+
+		id = bpf_tramp_id_alloc();
+		if (!id) {
+			err = -ENOMEM;
+			goto out_unlock;
+		}
+
 		btf_id = prog->aux->attach_btf_id;
-		key = bpf_trampoline_compute_key(NULL, prog->aux->attach_btf, btf_id);
+		bpf_tramp_id_init(id, NULL, prog->aux->attach_btf, btf_id);
 	}
 
 	if (!prog->aux->dst_trampoline ||
-	    (key && key != prog->aux->dst_trampoline->key)) {
+	    (!bpf_tramp_id_is_empty(id) &&
+	      bpf_tramp_id_is_equal(id, prog->aux->dst_trampoline->id))) {
 		/* If there is no saved target, or the specified target is
 		 * different from the destination specified at load time, we
 		 * need a new trampoline and a check for compatibility
@@ -2840,7 +2853,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		if (err)
 			goto out_unlock;
 
-		tr = bpf_trampoline_get(key, &tgt_info);
+		tr = bpf_trampoline_get(id, &tgt_info);
 		if (!tr) {
 			err = -ENOMEM;
 			goto out_unlock;
@@ -2900,6 +2913,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 out_put_prog:
 	if (tgt_prog_fd && tgt_prog)
 		bpf_prog_put(tgt_prog);
+	bpf_tramp_id_free(id);
 	return err;
 }
 
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index e98de5e73ba5..ae2573c36653 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -59,16 +59,57 @@ void bpf_image_ksym_del(struct bpf_ksym *ksym)
 			   PAGE_SIZE, true, ksym->name);
 }
 
-static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
+static u64 bpf_tramp_id_key(struct bpf_tramp_id *id)
+{
+	return ((u64) id->obj_id << 32) | id->btf_id;
+}
+
+bool bpf_tramp_id_is_empty(struct bpf_tramp_id *id)
+{
+	return !id || (!id->obj_id && !id->btf_id);
+}
+
+int bpf_tramp_id_is_equal(struct bpf_tramp_id *a,
+			  struct bpf_tramp_id *b)
+{
+	return !memcmp(a, b, sizeof(*a));
+}
+
+struct bpf_tramp_id *bpf_tramp_id_alloc(void)
+{
+	struct bpf_tramp_id *id;
+
+	return kzalloc(sizeof(*id), GFP_KERNEL);
+}
+
+void bpf_tramp_id_init(struct bpf_tramp_id *id,
+		       const struct bpf_prog *tgt_prog,
+		       struct btf *btf, u32 btf_id)
+{
+	if (tgt_prog)
+		id->obj_id = tgt_prog->aux->id;
+	else
+		id->obj_id = btf_obj_id(btf);
+	id->btf_id = btf_id;
+}
+
+void bpf_tramp_id_free(struct bpf_tramp_id *id)
+{
+	kfree(id);
+}
+
+static struct bpf_trampoline *bpf_trampoline_lookup(struct bpf_tramp_id *id)
 {
 	struct bpf_trampoline *tr;
 	struct hlist_head *head;
+	u64 key;
 	int i;
 
+	key = bpf_tramp_id_key(id);
 	mutex_lock(&trampoline_mutex);
 	head = &trampoline_table[hash_64(key, TRAMPOLINE_HASH_BITS)];
 	hlist_for_each_entry(tr, head, hlist) {
-		if (tr->key == key) {
+		if (bpf_tramp_id_is_equal(tr->id, id)) {
 			refcount_inc(&tr->refcnt);
 			goto out;
 		}
@@ -77,7 +118,7 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
 	if (!tr)
 		goto out;
 
-	tr->key = key;
+	tr->id = id;
 	INIT_HLIST_NODE(&tr->hlist);
 	hlist_add_head(&tr->hlist, head);
 	refcount_set(&tr->refcnt, 1);
@@ -291,12 +332,14 @@ static void bpf_tramp_image_put(struct bpf_tramp_image *im)
 	call_rcu_tasks_trace(&im->rcu, __bpf_tramp_image_put_rcu_tasks);
 }
 
-static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, u32 idx)
+static struct bpf_tramp_image*
+bpf_tramp_image_alloc(struct bpf_tramp_id *id, u32 idx)
 {
 	struct bpf_tramp_image *im;
 	struct bpf_ksym *ksym;
 	void *image;
 	int err = -ENOMEM;
+	u64 key;
 
 	im = kzalloc(sizeof(*im), GFP_KERNEL);
 	if (!im)
@@ -317,6 +360,7 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, u32 idx)
 
 	ksym = &im->ksym;
 	INIT_LIST_HEAD_RCU(&ksym->lnode);
+	key = bpf_tramp_id_key(id);
 	snprintf(ksym->name, KSYM_NAME_LEN, "bpf_trampoline_%llu_%u", key, idx);
 	bpf_image_ksym_add(image, ksym);
 	return im;
@@ -351,7 +395,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr)
 		goto out;
 	}
 
-	im = bpf_tramp_image_alloc(tr->key, tr->selector);
+	im = bpf_tramp_image_alloc(tr->id, tr->selector);
 	if (IS_ERR(im)) {
 		err = PTR_ERR(im);
 		goto out;
@@ -482,12 +526,12 @@ int bpf_trampoline_unlink_prog(struct bpf_prog *prog, struct bpf_trampoline *tr)
 	return err;
 }
 
-struct bpf_trampoline *bpf_trampoline_get(u64 key,
+struct bpf_trampoline *bpf_trampoline_get(struct bpf_tramp_id *id,
 					  struct bpf_attach_target_info *tgt_info)
 {
 	struct bpf_trampoline *tr;
 
-	tr = bpf_trampoline_lookup(key);
+	tr = bpf_trampoline_lookup(id);
 	if (!tr)
 		return NULL;
 
@@ -521,6 +565,7 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
 	 * multiple rcu callbacks.
 	 */
 	hlist_del(&tr->hlist);
+	bpf_tramp_id_free(tr->id);
 	kfree(tr);
 out:
 	mutex_unlock(&trampoline_mutex);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index af6a39bbb0dc..a1e4389b0e9e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13929,8 +13929,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	struct bpf_attach_target_info tgt_info = {};
 	u32 btf_id = prog->aux->attach_btf_id;
 	struct bpf_trampoline *tr;
+	struct bpf_tramp_id *id;
 	int ret;
-	u64 key;
 
 	if (prog->type == BPF_PROG_TYPE_SYSCALL) {
 		if (prog->aux->sleepable)
@@ -13995,11 +13995,17 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		return -EINVAL;
 	}
 
-	key = bpf_trampoline_compute_key(tgt_prog, prog->aux->attach_btf, btf_id);
-	tr = bpf_trampoline_get(key, &tgt_info);
-	if (!tr)
+	id = bpf_tramp_id_alloc();
+	if (!id)
 		return -ENOMEM;
 
+	bpf_tramp_id_init(id, tgt_prog, prog->aux->attach_btf, btf_id);
+	tr = bpf_trampoline_get(id, &tgt_info);
+	if (!tr) {
+		bpf_tramp_id_free(id);
+		return -ENOMEM;
+	}
+
 	prog->aux->dst_trampoline = tr;
 	return 0;
 }
-- 
2.31.1

