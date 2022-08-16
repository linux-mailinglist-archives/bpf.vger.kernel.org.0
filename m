Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A088596388
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 22:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbiHPUMU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 16:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbiHPUMT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 16:12:19 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0EC7E82D
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 13:12:18 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id x8-20020a17090a1f8800b001faa9857ef2so592950pja.0
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 13:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=Shnp0g5wrkoE1eY5Xnf56rBilom6MRPqiEkYL/fUlfE=;
        b=biBVxcPpAXVEpVSEdPK+mgLGgkpdDnTDVTJyClBIhvY7BATouTR9rvqClRlE8Q0glv
         4MeYjtmkxqVzeai1AS1J+c7F2ash2RkAgHl5BH/NuxrIk8HMeoskYaOro/VlDtIrleFA
         Fd7W4vyBGUIohvw4qzGuFgZFmPEyU8XEzE7mBXhr5rDVzcJ7jgjVJYiJdfgagRinNGyZ
         yiEslEZdO9ogndRYGWAaomN0WPvpTdNSnWYMePEqY4RQDGwcuo3xI9yPz8z2sOLFxZLe
         5i2pnYgBHOiCYPPGHBhXW8vfXck5jirjnblgtfSeOtbub9J4bRiB/gifshegntOKsg4c
         /Rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=Shnp0g5wrkoE1eY5Xnf56rBilom6MRPqiEkYL/fUlfE=;
        b=h0WXwrfdabBbSi9GUfLVjmtv08w36D4U0sInNZGe75Y0F0NYOGJDvIAfcAGlRlJJX6
         MgJxbHASxwArQMTcFU35tUbc1W85EhZBw8qYRMAjN9gUD7RBUOg3h4Bo7ZrxdETPwA6x
         zkCpft6gjt0/ojWbTU76UukOxD0Cg1/CPF/K1N7j/NFuXwTd7t+W7wdgh5MLqbJs/pVl
         a3E9a5uy9tWgXAIVx3vqCRhyYFW69P3TzsPckdtIgUzPrfkADQSS//O+IEV5kSi0Axny
         Np6vCqXGFPGfzwMqXgo26pIV90b6VLT2yTcdPcPyXDtOdvIINKXjovAx/j5BIbAZDRhn
         6VMg==
X-Gm-Message-State: ACgBeo1c3a46H/EZSoBBNHCZnHeVKvjClvmW6HCnGMvojdXvfQTgp0hc
        g+q1cOHdhzfTzyJI1CyAMgueNKs4+muywKR8t7dIYlPianooE02RKU2OkAgk/pj3DWCtAM9Sum5
        tzW6FbRaiI1IhItxfzMBnKRH9Bniy0Myt7ZxQf+ETi4QxfYCxDw==
X-Google-Smtp-Source: AA6agR6wdAhNc0aEYixctyCLyokMJOqNulz6M7qrOAbdbI9BakKoauQwS9nRRmigAPZo/shE+cJjDsg=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:aa41:b0:16f:85be:f348 with SMTP id
 c1-20020a170902aa4100b0016f85bef348mr23374003plr.15.1660680737489; Tue, 16
 Aug 2022 13:12:17 -0700 (PDT)
Date:   Tue, 16 Aug 2022 13:12:12 -0700
In-Reply-To: <20220816201214.2489910-1-sdf@google.com>
Message-Id: <20220816201214.2489910-2-sdf@google.com>
Mime-Version: 1.0
References: <20220816201214.2489910-1-sdf@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH bpf-next v2 1/3] bpf: Introduce cgroup_{common,current}_func_proto
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Split cgroup_base_func_proto into the following:

* cgroup_common_func_proto - common helpers for all cgroup hooks
* cgroup_current_func_proto - common helpers for all cgroup hooks
  running in the process context (== have meaningful 'current').

Move bpf_{g,s}et_retval and other cgroup-related helpers into
kernel/bpf/cgroup.c so they closer to where they are being used.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf.h  |  18 ++-
 kernel/bpf/cgroup.c  | 301 ++++++++++++++++++++++++++++++++++++++++---
 kernel/bpf/helpers.c | 204 -----------------------------
 net/core/filter.c    |  14 +-
 4 files changed, 301 insertions(+), 236 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a627a02cf8ab..c302d2de073a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1948,6 +1948,10 @@ struct bpf_prog *bpf_prog_by_id(u32 id);
 struct bpf_link *bpf_link_by_id(u32 id);
 
 const struct bpf_func_proto *bpf_base_func_proto(enum bpf_func_id func_id);
+const struct bpf_func_proto *
+cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog);
+const struct bpf_func_proto *
+cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog);
 void bpf_task_storage_free(struct task_struct *task);
 bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
 const struct btf_func_model *
@@ -2154,6 +2158,18 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 	return NULL;
 }
 
+static inline const struct bpf_func_proto *
+cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	return NULL;
+}
+
+static inline const struct bpf_func_proto *
+cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	return NULL;
+}
+
 static inline void bpf_task_storage_free(struct task_struct *task)
 {
 }
@@ -2369,8 +2385,6 @@ extern const struct bpf_func_proto bpf_sk_redirect_map_proto;
 extern const struct bpf_func_proto bpf_spin_lock_proto;
 extern const struct bpf_func_proto bpf_spin_unlock_proto;
 extern const struct bpf_func_proto bpf_get_local_storage_proto;
-extern const struct bpf_func_proto bpf_strtol_proto;
-extern const struct bpf_func_proto bpf_strtoul_proto;
 extern const struct bpf_func_proto bpf_tcp_sock_proto;
 extern const struct bpf_func_proto bpf_jiffies64_proto;
 extern const struct bpf_func_proto bpf_get_ns_current_pid_tgid_proto;
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 59b7eb60d5b4..8ead5df3fafb 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -18,7 +18,9 @@
 #include <linux/bpf_verifier.h>
 #include <net/sock.h>
 #include <net/bpf_sk_storage.h>
+#include <net/cls_cgroup.h>
 
+#include "../lib/kstrtox.h"
 #include "../cgroup/cgroup-internal.h"
 
 DEFINE_STATIC_KEY_ARRAY_FALSE(cgroup_bpf_enabled_key, MAX_CGROUP_BPF_ATTACH_TYPE);
@@ -1527,6 +1529,78 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 	return ret;
 }
 
+BPF_CALL_0(bpf_get_current_cgroup_id)
+{
+	struct cgroup *cgrp;
+	u64 cgrp_id;
+
+	rcu_read_lock();
+	cgrp = task_dfl_cgroup(current);
+	cgrp_id = cgroup_id(cgrp);
+	rcu_read_unlock();
+
+	return cgrp_id;
+}
+
+const struct bpf_func_proto bpf_get_current_cgroup_id_proto = {
+	.func		= bpf_get_current_cgroup_id,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+};
+
+BPF_CALL_1(bpf_get_current_ancestor_cgroup_id, int, ancestor_level)
+{
+	struct cgroup *cgrp;
+	struct cgroup *ancestor;
+	u64 cgrp_id;
+
+	rcu_read_lock();
+	cgrp = task_dfl_cgroup(current);
+	ancestor = cgroup_ancestor(cgrp, ancestor_level);
+	cgrp_id = ancestor ? cgroup_id(ancestor) : 0;
+	rcu_read_unlock();
+
+	return cgrp_id;
+}
+
+const struct bpf_func_proto bpf_get_current_ancestor_cgroup_id_proto = {
+	.func		= bpf_get_current_ancestor_cgroup_id,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_ANYTHING,
+};
+
+BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
+{
+	/* flags argument is not used now,
+	 * but provides an ability to extend the API.
+	 * verifier checks that its value is correct.
+	 */
+	enum bpf_cgroup_storage_type stype = cgroup_storage_type(map);
+	struct bpf_cgroup_storage *storage;
+	struct bpf_cg_run_ctx *ctx;
+	void *ptr;
+
+	/* get current cgroup storage from BPF run context */
+	ctx = container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
+	storage = ctx->prog_item->cgroup_storage[stype];
+
+	if (stype == BPF_CGROUP_STORAGE_SHARED)
+		ptr = &READ_ONCE(storage->buf)->data[0];
+	else
+		ptr = this_cpu_ptr(storage->percpu_buf);
+
+	return (unsigned long)ptr;
+}
+
+const struct bpf_func_proto bpf_get_local_storage_proto = {
+	.func		= bpf_get_local_storage,
+	.gpl_only	= false,
+	.ret_type	= RET_PTR_TO_MAP_VALUE,
+	.arg1_type	= ARG_CONST_MAP_PTR,
+	.arg2_type	= ARG_ANYTHING,
+};
+
 BPF_CALL_0(bpf_get_retval)
 {
 	struct bpf_cg_run_ctx *ctx =
@@ -1557,33 +1631,168 @@ const struct bpf_func_proto bpf_set_retval_proto = {
 	.arg1_type	= ARG_ANYTHING,
 };
 
+#define BPF_STRTOX_BASE_MASK 0x1F
+
+static int __bpf_strtoull(const char *buf, size_t buf_len, u64 flags,
+			  unsigned long long *res, bool *is_negative)
+{
+	unsigned int base = flags & BPF_STRTOX_BASE_MASK;
+	const char *cur_buf = buf;
+	size_t cur_len = buf_len;
+	unsigned int consumed;
+	size_t val_len;
+	char str[64];
+
+	if (!buf || !buf_len || !res || !is_negative)
+		return -EINVAL;
+
+	if (base != 0 && base != 8 && base != 10 && base != 16)
+		return -EINVAL;
+
+	if (flags & ~BPF_STRTOX_BASE_MASK)
+		return -EINVAL;
+
+	while (cur_buf < buf + buf_len && isspace(*cur_buf))
+		++cur_buf;
+
+	*is_negative = (cur_buf < buf + buf_len && *cur_buf == '-');
+	if (*is_negative)
+		++cur_buf;
+
+	consumed = cur_buf - buf;
+	cur_len -= consumed;
+	if (!cur_len)
+		return -EINVAL;
+
+	cur_len = min(cur_len, sizeof(str) - 1);
+	memcpy(str, cur_buf, cur_len);
+	str[cur_len] = '\0';
+	cur_buf = str;
+
+	cur_buf = _parse_integer_fixup_radix(cur_buf, &base);
+	val_len = _parse_integer(cur_buf, base, res);
+
+	if (val_len & KSTRTOX_OVERFLOW)
+		return -ERANGE;
+
+	if (val_len == 0)
+		return -EINVAL;
+
+	cur_buf += val_len;
+	consumed += cur_buf - str;
+
+	return consumed;
+}
+
+static int __bpf_strtoll(const char *buf, size_t buf_len, u64 flags,
+			 long long *res)
+{
+	unsigned long long _res;
+	bool is_negative;
+	int err;
+
+	err = __bpf_strtoull(buf, buf_len, flags, &_res, &is_negative);
+	if (err < 0)
+		return err;
+	if (is_negative) {
+		if ((long long)-_res > 0)
+			return -ERANGE;
+		*res = -_res;
+	} else {
+		if ((long long)_res < 0)
+			return -ERANGE;
+		*res = _res;
+	}
+	return err;
+}
+
+BPF_CALL_4(bpf_strtol, const char *, buf, size_t, buf_len, u64, flags,
+	   long *, res)
+{
+	long long _res;
+	int err;
+
+	err = __bpf_strtoll(buf, buf_len, flags, &_res);
+	if (err < 0)
+		return err;
+	if (_res != (long)_res)
+		return -ERANGE;
+	*res = _res;
+	return err;
+}
+
+static const struct bpf_func_proto bpf_strtol_proto = {
+	.func		= bpf_strtol,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg2_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_PTR_TO_LONG,
+};
+
+BPF_CALL_4(bpf_strtoul, const char *, buf, size_t, buf_len, u64, flags,
+	   unsigned long *, res)
+{
+	unsigned long long _res;
+	bool is_negative;
+	int err;
+
+	err = __bpf_strtoull(buf, buf_len, flags, &_res, &is_negative);
+	if (err < 0)
+		return err;
+	if (is_negative)
+		return -EINVAL;
+	if (_res != (unsigned long)_res)
+		return -ERANGE;
+	*res = _res;
+	return err;
+}
+
+static const struct bpf_func_proto bpf_strtoul_proto = {
+	.func		= bpf_strtoul,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg2_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_PTR_TO_LONG,
+};
+
+#ifdef CONFIG_CGROUP_NET_CLASSID
+BPF_CALL_0(bpf_get_cgroup_classid_curr)
+{
+	return __task_get_classid(current);
+}
+
+const struct bpf_func_proto bpf_get_cgroup_classid_curr_proto = {
+	.func		= bpf_get_cgroup_classid_curr,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+};
+#endif
+
 static const struct bpf_func_proto *
-cgroup_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+cgroup_dev_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
+	const struct bpf_func_proto *func_proto;
+
+	func_proto = cgroup_common_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
+	func_proto = cgroup_current_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
 	switch (func_id) {
-	case BPF_FUNC_get_current_uid_gid:
-		return &bpf_get_current_uid_gid_proto;
-	case BPF_FUNC_get_local_storage:
-		return &bpf_get_local_storage_proto;
-	case BPF_FUNC_get_current_cgroup_id:
-		return &bpf_get_current_cgroup_id_proto;
 	case BPF_FUNC_perf_event_output:
 		return &bpf_event_output_data_proto;
-	case BPF_FUNC_get_retval:
-		return &bpf_get_retval_proto;
-	case BPF_FUNC_set_retval:
-		return &bpf_set_retval_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
 }
 
-static const struct bpf_func_proto *
-cgroup_dev_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
-{
-	return cgroup_base_func_proto(func_id, prog);
-}
-
 static bool cgroup_dev_is_valid_access(int off, int size,
 				       enum bpf_access_type type,
 				       const struct bpf_prog *prog,
@@ -2096,6 +2305,16 @@ static const struct bpf_func_proto bpf_sysctl_set_new_value_proto = {
 static const struct bpf_func_proto *
 sysctl_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
+	const struct bpf_func_proto *func_proto;
+
+	func_proto = cgroup_common_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
+	func_proto = cgroup_current_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
 	switch (func_id) {
 	case BPF_FUNC_strtol:
 		return &bpf_strtol_proto;
@@ -2111,8 +2330,10 @@ sysctl_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sysctl_set_new_value_proto;
 	case BPF_FUNC_ktime_get_coarse_ns:
 		return &bpf_ktime_get_coarse_ns_proto;
+	case BPF_FUNC_perf_event_output:
+		return &bpf_event_output_data_proto;
 	default:
-		return cgroup_base_func_proto(func_id, prog);
+		return bpf_base_func_proto(func_id);
 	}
 }
 
@@ -2233,6 +2454,16 @@ static const struct bpf_func_proto bpf_get_netns_cookie_sockopt_proto = {
 static const struct bpf_func_proto *
 cg_sockopt_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
+	const struct bpf_func_proto *func_proto;
+
+	func_proto = cgroup_common_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
+	func_proto = cgroup_current_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
 	switch (func_id) {
 #ifdef CONFIG_NET
 	case BPF_FUNC_get_netns_cookie:
@@ -2254,8 +2485,10 @@ cg_sockopt_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_tcp_sock:
 		return &bpf_tcp_sock_proto;
 #endif
+	case BPF_FUNC_perf_event_output:
+		return &bpf_event_output_data_proto;
 	default:
-		return cgroup_base_func_proto(func_id, prog);
+		return bpf_base_func_proto(func_id);
 	}
 }
 
@@ -2420,3 +2653,33 @@ const struct bpf_verifier_ops cg_sockopt_verifier_ops = {
 
 const struct bpf_prog_ops cg_sockopt_prog_ops = {
 };
+
+/* Common helpers for cgroup hooks. */
+const struct bpf_func_proto *
+cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	switch (func_id) {
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
+	case BPF_FUNC_get_retval:
+		return &bpf_get_retval_proto;
+	case BPF_FUNC_set_retval:
+		return &bpf_set_retval_proto;
+	default:
+		return NULL;
+	}
+}
+
+/* Common helpers for cgroup hooks with valid process context. */
+const struct bpf_func_proto *
+cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	switch (func_id) {
+	case BPF_FUNC_get_current_uid_gid:
+		return &bpf_get_current_uid_gid_proto;
+	case BPF_FUNC_get_current_cgroup_id:
+		return &bpf_get_current_cgroup_id_proto;
+	default:
+		return NULL;
+	}
+}
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 3c1b9bbcf971..e20a4657cb55 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -386,210 +386,6 @@ const struct bpf_func_proto bpf_jiffies64_proto = {
 	.ret_type	= RET_INTEGER,
 };
 
-#ifdef CONFIG_CGROUPS
-BPF_CALL_0(bpf_get_current_cgroup_id)
-{
-	struct cgroup *cgrp;
-	u64 cgrp_id;
-
-	rcu_read_lock();
-	cgrp = task_dfl_cgroup(current);
-	cgrp_id = cgroup_id(cgrp);
-	rcu_read_unlock();
-
-	return cgrp_id;
-}
-
-const struct bpf_func_proto bpf_get_current_cgroup_id_proto = {
-	.func		= bpf_get_current_cgroup_id,
-	.gpl_only	= false,
-	.ret_type	= RET_INTEGER,
-};
-
-BPF_CALL_1(bpf_get_current_ancestor_cgroup_id, int, ancestor_level)
-{
-	struct cgroup *cgrp;
-	struct cgroup *ancestor;
-	u64 cgrp_id;
-
-	rcu_read_lock();
-	cgrp = task_dfl_cgroup(current);
-	ancestor = cgroup_ancestor(cgrp, ancestor_level);
-	cgrp_id = ancestor ? cgroup_id(ancestor) : 0;
-	rcu_read_unlock();
-
-	return cgrp_id;
-}
-
-const struct bpf_func_proto bpf_get_current_ancestor_cgroup_id_proto = {
-	.func		= bpf_get_current_ancestor_cgroup_id,
-	.gpl_only	= false,
-	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_ANYTHING,
-};
-
-#ifdef CONFIG_CGROUP_BPF
-
-BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
-{
-	/* flags argument is not used now,
-	 * but provides an ability to extend the API.
-	 * verifier checks that its value is correct.
-	 */
-	enum bpf_cgroup_storage_type stype = cgroup_storage_type(map);
-	struct bpf_cgroup_storage *storage;
-	struct bpf_cg_run_ctx *ctx;
-	void *ptr;
-
-	/* get current cgroup storage from BPF run context */
-	ctx = container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
-	storage = ctx->prog_item->cgroup_storage[stype];
-
-	if (stype == BPF_CGROUP_STORAGE_SHARED)
-		ptr = &READ_ONCE(storage->buf)->data[0];
-	else
-		ptr = this_cpu_ptr(storage->percpu_buf);
-
-	return (unsigned long)ptr;
-}
-
-const struct bpf_func_proto bpf_get_local_storage_proto = {
-	.func		= bpf_get_local_storage,
-	.gpl_only	= false,
-	.ret_type	= RET_PTR_TO_MAP_VALUE,
-	.arg1_type	= ARG_CONST_MAP_PTR,
-	.arg2_type	= ARG_ANYTHING,
-};
-#endif
-
-#define BPF_STRTOX_BASE_MASK 0x1F
-
-static int __bpf_strtoull(const char *buf, size_t buf_len, u64 flags,
-			  unsigned long long *res, bool *is_negative)
-{
-	unsigned int base = flags & BPF_STRTOX_BASE_MASK;
-	const char *cur_buf = buf;
-	size_t cur_len = buf_len;
-	unsigned int consumed;
-	size_t val_len;
-	char str[64];
-
-	if (!buf || !buf_len || !res || !is_negative)
-		return -EINVAL;
-
-	if (base != 0 && base != 8 && base != 10 && base != 16)
-		return -EINVAL;
-
-	if (flags & ~BPF_STRTOX_BASE_MASK)
-		return -EINVAL;
-
-	while (cur_buf < buf + buf_len && isspace(*cur_buf))
-		++cur_buf;
-
-	*is_negative = (cur_buf < buf + buf_len && *cur_buf == '-');
-	if (*is_negative)
-		++cur_buf;
-
-	consumed = cur_buf - buf;
-	cur_len -= consumed;
-	if (!cur_len)
-		return -EINVAL;
-
-	cur_len = min(cur_len, sizeof(str) - 1);
-	memcpy(str, cur_buf, cur_len);
-	str[cur_len] = '\0';
-	cur_buf = str;
-
-	cur_buf = _parse_integer_fixup_radix(cur_buf, &base);
-	val_len = _parse_integer(cur_buf, base, res);
-
-	if (val_len & KSTRTOX_OVERFLOW)
-		return -ERANGE;
-
-	if (val_len == 0)
-		return -EINVAL;
-
-	cur_buf += val_len;
-	consumed += cur_buf - str;
-
-	return consumed;
-}
-
-static int __bpf_strtoll(const char *buf, size_t buf_len, u64 flags,
-			 long long *res)
-{
-	unsigned long long _res;
-	bool is_negative;
-	int err;
-
-	err = __bpf_strtoull(buf, buf_len, flags, &_res, &is_negative);
-	if (err < 0)
-		return err;
-	if (is_negative) {
-		if ((long long)-_res > 0)
-			return -ERANGE;
-		*res = -_res;
-	} else {
-		if ((long long)_res < 0)
-			return -ERANGE;
-		*res = _res;
-	}
-	return err;
-}
-
-BPF_CALL_4(bpf_strtol, const char *, buf, size_t, buf_len, u64, flags,
-	   long *, res)
-{
-	long long _res;
-	int err;
-
-	err = __bpf_strtoll(buf, buf_len, flags, &_res);
-	if (err < 0)
-		return err;
-	if (_res != (long)_res)
-		return -ERANGE;
-	*res = _res;
-	return err;
-}
-
-const struct bpf_func_proto bpf_strtol_proto = {
-	.func		= bpf_strtol,
-	.gpl_only	= false,
-	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg2_type	= ARG_CONST_SIZE,
-	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_LONG,
-};
-
-BPF_CALL_4(bpf_strtoul, const char *, buf, size_t, buf_len, u64, flags,
-	   unsigned long *, res)
-{
-	unsigned long long _res;
-	bool is_negative;
-	int err;
-
-	err = __bpf_strtoull(buf, buf_len, flags, &_res, &is_negative);
-	if (err < 0)
-		return err;
-	if (is_negative)
-		return -EINVAL;
-	if (_res != (unsigned long)_res)
-		return -ERANGE;
-	*res = _res;
-	return err;
-}
-
-const struct bpf_func_proto bpf_strtoul_proto = {
-	.func		= bpf_strtoul,
-	.gpl_only	= false,
-	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg2_type	= ARG_CONST_SIZE,
-	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_LONG,
-};
-#endif
 
 BPF_CALL_3(bpf_strncmp, const char *, s1, u32, s1_sz, const char *, s2)
 {
diff --git a/net/core/filter.c b/net/core/filter.c
index 5669248aff25..737bef7ff831 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3004,17 +3004,6 @@ static const struct bpf_func_proto bpf_msg_pop_data_proto = {
 };
 
 #ifdef CONFIG_CGROUP_NET_CLASSID
-BPF_CALL_0(bpf_get_cgroup_classid_curr)
-{
-	return __task_get_classid(current);
-}
-
-static const struct bpf_func_proto bpf_get_cgroup_classid_curr_proto = {
-	.func		= bpf_get_cgroup_classid_curr,
-	.gpl_only	= false,
-	.ret_type	= RET_INTEGER,
-};
-
 BPF_CALL_1(bpf_skb_cgroup_classid, const struct sk_buff *, skb)
 {
 	struct sock *sk = skb_to_full_sk(skb);
@@ -8101,6 +8090,9 @@ sock_ops_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 
 const struct bpf_func_proto bpf_msg_redirect_map_proto __weak;
 const struct bpf_func_proto bpf_msg_redirect_hash_proto __weak;
+const struct bpf_func_proto bpf_get_cgroup_classid_curr_proto __weak;
+const struct bpf_func_proto bpf_get_current_cgroup_id_proto __weak;
+const struct bpf_func_proto bpf_get_current_ancestor_cgroup_id_proto __weak;
 
 static const struct bpf_func_proto *
 sk_msg_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
-- 
2.37.1.595.g718a3a8f04-goog

