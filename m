Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A083DE3C1
	for <lists+bpf@lfdr.de>; Tue,  3 Aug 2021 03:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhHCBD7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Aug 2021 21:03:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:65281 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232849AbhHCBD7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Aug 2021 21:03:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="277327832"
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="277327832"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:48 -0700
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="419480105"
Received: from ticela-or-032.amr.corp.intel.com (HELO localhost.localdomain) ([10.212.166.34])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:48 -0700
From:   Ederson de Souza <ederson.desouza@intel.com>
To:     xdp-hints@xdp-project.net
Cc:     bpf@vger.kernel.org, Saeed Mahameed <saeedm@mellanox.com>
Subject: [[RFC xdp-hints] 01/16] bpf: add btf register/unregister API
Date:   Mon,  2 Aug 2021 18:03:16 -0700
Message-Id: <20210803010331.39453-2-ederson.desouza@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210803010331.39453-1-ederson.desouza@intel.com>
References: <20210803010331.39453-1-ederson.desouza@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Saeed Mahameed <saeedm@mellanox.com>

A device driver can register own BTF format buffers into the kernel.
Will be used in downstream patches by mlx5 XDP driver to advertise and
populated XDP meta data.

Issue: 2114293
Change-Id: I37cc1b18dadd7cf22aa67d2f14d811deae7525b4
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
---
 include/linux/btf.h |   9 +++
 kernel/bpf/btf.c    | 155 +++++++++++++++++++++++++++++++++++---------
 2 files changed, 135 insertions(+), 29 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 214fde93214b..d48e6fcf46dc 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -225,6 +225,8 @@ const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id);
 const char *btf_name_by_offset(const struct btf *btf, u32 offset);
 struct btf *btf_parse_vmlinux(void);
 struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
+struct btf *btf_register(void *data, u32 data_size);
+void btf_unregister(struct btf *btf);
 #else
 static inline const struct btf_type *btf_type_by_id(const struct btf *btf,
 						    u32 type_id)
@@ -236,6 +238,13 @@ static inline const char *btf_name_by_offset(const struct btf *btf,
 {
 	return NULL;
 }
+
+static inline struct btf *btf_register(void *data, u32 data_size)
+{
+	return NULL;
+}
+
+static inline void btf_unregister(struct btf *btf) { }
 #endif
 
 #endif
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7780131f710e..88d8cd02d282 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1509,11 +1509,31 @@ static void btf_free_id(struct btf *btf)
 	spin_unlock_irqrestore(&btf_idr_lock, flags);
 }
 
+static struct btf *btf_alloc(u32 data_size)
+{
+	struct btf *btf;
+
+	btf = kzalloc(sizeof(*btf), GFP_KERNEL | __GFP_NOWARN);
+	if (!btf)
+		return NULL;
+
+	btf->data = kvmalloc(data_size, GFP_KERNEL | __GFP_NOWARN);
+	if (!btf->data) {
+		kfree(btf);
+		return NULL;
+	}
+
+	btf->data_size = data_size;
+	return btf;
+}
+
 static void btf_free(struct btf *btf)
 {
 	kvfree(btf->types);
 	kvfree(btf->resolved_sizes);
 	kvfree(btf->resolved_ids);
+
+	/* stuff allocated via btf_alloc */
 	kvfree(btf->data);
 	kfree(btf);
 }
@@ -1574,6 +1594,13 @@ static int env_resolve_init(struct btf_verifier_env *env)
 	return -ENOMEM;
 }
 
+static struct btf_verifier_env *btf_verifier_env_alloc(void)
+{
+	gfp_t flags = GFP_KERNEL | __GFP_NOWARN;
+
+	return kzalloc(sizeof(struct btf_verifier_env), flags);
+}
+
 static void btf_verifier_env_free(struct btf_verifier_env *env)
 {
 	kvfree(env->visit_states);
@@ -4306,19 +4333,37 @@ static int btf_parse_hdr(struct btf_verifier_env *env)
 	return 0;
 }
 
-static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
-			     u32 log_level, char __user *log_ubuf, u32 log_size)
+static int btf_parse(struct btf_verifier_env *env)
+{
+	struct btf *btf = env->btf;
+	int err;
+
+	err = btf_parse_hdr(env);
+	if (err)
+		return err;
+
+	btf->nohdr_data = btf->data + btf->hdr.hdr_len;
+
+	err = btf_parse_str_sec(env);
+	if (err)
+		return err;
+
+	return btf_parse_type_sec(env);
+}
+
+static struct btf *
+btf_parse_user(bpfptr_t btf_data, u32 btf_data_size,
+	       u32 log_level, char __user *log_ubuf, u32 log_size)
 {
 	struct btf_verifier_env *env = NULL;
 	struct bpf_verifier_log *log;
 	struct btf *btf = NULL;
-	u8 *data;
 	int err;
 
 	if (btf_data_size > BTF_MAX_SIZE)
 		return ERR_PTR(-E2BIG);
 
-	env = kzalloc(sizeof(*env), GFP_KERNEL | __GFP_NOWARN);
+	env = btf_verifier_env_alloc();
 	if (!env)
 		return ERR_PTR(-ENOMEM);
 
@@ -4339,45 +4384,66 @@ static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
 		}
 	}
 
-	btf = kzalloc(sizeof(*btf), GFP_KERNEL | __GFP_NOWARN);
+	btf = btf_alloc(btf_data_size);
 	if (!btf) {
 		err = -ENOMEM;
 		goto errout;
 	}
-	env->btf = btf;
 
-	data = kvmalloc(btf_data_size, GFP_KERNEL | __GFP_NOWARN);
-	if (!data) {
-		err = -ENOMEM;
+	if (copy_from_bpfptr(btf->data, btf_data, btf_data_size)) {
+		err = -EFAULT;
 		goto errout;
 	}
 
-	btf->data = data;
-	btf->data_size = btf_data_size;
+	env->btf = btf;
+	err = btf_parse(env);
+	if (err)
+		goto errout;
 
-	if (copy_from_bpfptr(data, btf_data, btf_data_size)) {
-		err = -EFAULT;
+	if (log->level && bpf_verifier_log_full(log)) {
+		err = -ENOSPC;
 		goto errout;
 	}
 
-	err = btf_parse_hdr(env);
-	if (err)
-		goto errout;
+	btf_verifier_env_free(env);
+	refcount_set(&btf->refcnt, 1);
+	return btf;
 
-	btf->nohdr_data = btf->data + btf->hdr.hdr_len;
+errout:
+	btf_verifier_env_free(env);
+	if (btf)
+		btf_free(btf);
+	return ERR_PTR(err);
+}
 
-	err = btf_parse_str_sec(env);
-	if (err)
-		goto errout;
+static struct btf *btf_parse_raw(void *btf_data, u32 btf_data_size)
+{
+	struct btf_verifier_env *env = NULL;
+	struct btf *btf = NULL;
+	int err;
 
-	err = btf_parse_type_sec(env);
-	if (err)
-		goto errout;
+	if (btf_data_size > BTF_MAX_SIZE)
+		return ERR_PTR(-E2BIG);
 
-	if (log->level && bpf_verifier_log_full(log)) {
-		err = -ENOSPC;
+	env = btf_verifier_env_alloc();
+	if (!env)
+		return ERR_PTR(-ENOMEM);
+
+	/* force log to go to kernel trace buffer */
+	env->log.level = BPF_LOG_KERNEL;
+
+	btf = btf_alloc(btf_data_size);
+	if (!btf) {
+		err = -ENOMEM;
 		goto errout;
 	}
+	memcpy(btf->data, btf_data, btf_data_size);
+
+	env->btf = btf;
+
+	err = btf_parse(env);
+	if (err)
+		goto errout;
 
 	btf_verifier_env_free(env);
 	refcount_set(&btf->refcnt, 1);
@@ -4388,6 +4454,7 @@ static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
 	if (btf)
 		btf_free(btf);
 	return ERR_PTR(err);
+
 }
 
 extern char __weak __start_BTF[];
@@ -5846,10 +5913,10 @@ int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr)
 	struct btf *btf;
 	int ret;
 
-	btf = btf_parse(make_bpfptr(attr->btf, uattr.is_kernel),
-			attr->btf_size, attr->btf_log_level,
-			u64_to_user_ptr(attr->btf_log_buf),
-			attr->btf_log_size);
+	btf = btf_parse_user(make_bpfptr(attr->btf, uattr.is_kernel),
+			     attr->btf_size, attr->btf_log_level,
+			     u64_to_user_ptr(attr->btf_log_buf),
+			     attr->btf_log_size);
 	if (IS_ERR(btf))
 		return PTR_ERR(btf);
 
@@ -5872,6 +5939,35 @@ int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr)
 	return ret;
 }
 
+struct btf *btf_register(void *data, u32 data_size)
+{
+	struct btf *btf;
+	int ret;
+
+	btf = btf_parse_raw(data, data_size);
+	if (IS_ERR(btf))
+		return btf;
+
+	ret = btf_alloc_id(btf);
+	if (ret) {
+		btf_free(btf);
+		return ERR_PTR(ret);
+	}
+
+	return btf;
+}
+EXPORT_SYMBOL(btf_register);
+
+void btf_unregister(struct btf *btf)
+{
+	if (IS_ERR(btf))
+		return;
+
+	/* btf_put since btf might be held by user */
+	btf_put(btf);
+}
+EXPORT_SYMBOL(btf_unregister);
+
 struct btf *btf_get_by_fd(int fd)
 {
 	struct btf *btf;
@@ -5979,6 +6075,7 @@ u32 btf_obj_id(const struct btf *btf)
 {
 	return btf->id;
 }
+EXPORT_SYMBOL(btf_obj_id);
 
 bool btf_is_kernel(const struct btf *btf)
 {
-- 
2.32.0

