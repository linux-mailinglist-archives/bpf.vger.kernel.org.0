Return-Path: <bpf+bounces-35057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D019374D1
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 10:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E694B1F21DBF
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 08:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA5C78286;
	Fri, 19 Jul 2024 08:13:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1626C17BA1;
	Fri, 19 Jul 2024 08:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721376810; cv=none; b=DwzC0rfu60Q/Zb4d3f0Ha9VfwsiumbIcGzg9V2femDe9hGHp6OrJYonDa9lE2rkT8/rM9iTE0AumzQEqdQhqIMmMW8Xen9yry+E6mtOGLGNg2wM5A9l6wAwVo6adXL+1f89Y9OkH+ov0CgylEFnrggUxeAP8xTZE0GIgsoWAmq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721376810; c=relaxed/simple;
	bh=h6QqusRCwUdR5gF9ZWLsbCy1fy0X/4oYZK/KDZHdM88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WoqahrBUcc/lz1JqFCZuuPzyq8YBNGoWk/oMRz4a/WAvOne2f7C/d+k4xFw9VmaUiWCjQMXzeu7ZiHYE9DmosWYi1t1Rg5p66L7NkuF406Foq2SLGmSLUtXFX618BtgRedrlzaFaXJP3zBh6WrEIJzi3Da2lhRgiqxoAQXIyrpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WQMqr6KLYz4f3jsV;
	Fri, 19 Jul 2024 16:13:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 0CB421A1329;
	Fri, 19 Jul 2024 16:13:25 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP3 (Coremail) with SMTP id _Ch0CgCXo04hIJpm5CslAg--.56491S4;
	Fri, 19 Jul 2024 16:13:24 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Kees Cook <kees@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Florent Revest <revest@google.com>
Subject: [PATCH bpf-next v1 2/9] bpf, lsm: Add check for BPF LSM return value
Date: Fri, 19 Jul 2024 16:17:42 +0800
Message-Id: <20240719081749.769748-3-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240719081749.769748-1-xukuohai@huaweicloud.com>
References: <20240719081749.769748-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCXo04hIJpm5CslAg--.56491S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr1UAr1rGrykuFW8JFWfGrg_yoWfAFWDpF
	s3Gr95Cr40vrW3uFnrtan7ZFyrJr10g3yIkFy7GryFvFWavrn5XF1qgryjvr1fCrWkCw1x
	Cr4jgrZ8u34UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0I3
	85UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

A bpf prog returning a positive number attached to file_alloc_security
hook makes kernel panic.

This happens because file system can not filter out the positive number
returned by the LSM prog using IS_ERR, and misinterprets this positive
number as a file pointer.

Given that hook file_alloc_security never returned positive number
before the introduction of BPF LSM, and other BPF LSM hooks may
encounter similar issues, this patch adds LSM return value check
in verifier, to ensure no unexpected value is returned.

Fixes: 520b7aa00d8c ("bpf: lsm: Initialize the BPF LSM hooks")
Reported-by: Xin Liu <liuxin350@huawei.com>
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf.h     |  1 +
 include/linux/bpf_lsm.h |  8 ++++++
 kernel/bpf/bpf_lsm.c    | 34 ++++++++++++++++++++++-
 kernel/bpf/btf.c        |  5 +++-
 kernel/bpf/verifier.c   | 60 ++++++++++++++++++++++++++++++++++-------
 5 files changed, 97 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4f1d4a97b9d1..d255201035c4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -927,6 +927,7 @@ struct bpf_insn_access_aux {
 		};
 	};
 	struct bpf_verifier_log *log; /* for verbose logs */
+	bool is_retval; /* is accessing function return value ? */
 };
 
 static inline void
diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 1de7ece5d36d..aefcd6564251 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -9,6 +9,7 @@
 
 #include <linux/sched.h>
 #include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
 #include <linux/lsm_hooks.h>
 
 #ifdef CONFIG_BPF_LSM
@@ -45,6 +46,8 @@ void bpf_inode_storage_free(struct inode *inode);
 
 void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog, bpf_func_t *bpf_func);
 
+int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
+			     struct bpf_retval_range *range);
 #else /* !CONFIG_BPF_LSM */
 
 static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
@@ -78,6 +81,11 @@ static inline void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
 {
 }
 
+static inline int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
+					   struct bpf_retval_range *range)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_BPF_LSM */
 
 #endif /* _LINUX_BPF_LSM_H */
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 1f596ad6257c..6292ac5f9bd1 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -11,7 +11,6 @@
 #include <linux/lsm_hooks.h>
 #include <linux/bpf_lsm.h>
 #include <linux/kallsyms.h>
-#include <linux/bpf_verifier.h>
 #include <net/bpf_sk_storage.h>
 #include <linux/bpf_local_storage.h>
 #include <linux/btf_ids.h>
@@ -417,3 +416,36 @@ const struct bpf_verifier_ops lsm_verifier_ops = {
 	.get_func_proto = bpf_lsm_func_proto,
 	.is_valid_access = btf_ctx_access,
 };
+
+/* hooks return 0 or 1 */
+BTF_SET_START(bool_lsm_hooks)
+#ifdef CONFIG_SECURITY_NETWORK_XFRM
+BTF_ID(func, bpf_lsm_xfrm_state_pol_flow_match)
+#endif
+#ifdef CONFIG_AUDIT
+BTF_ID(func, bpf_lsm_audit_rule_known)
+#endif
+BTF_ID(func, bpf_lsm_inode_xattr_skipcap)
+BTF_SET_END(bool_lsm_hooks)
+
+int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
+			     struct bpf_retval_range *retval_range)
+{
+	/* no return value range for void hooks */
+	if (!prog->aux->attach_func_proto->type)
+		return -EINVAL;
+
+	if (btf_id_set_contains(&bool_lsm_hooks, prog->aux->attach_btf_id)) {
+		retval_range->minval = 0;
+		retval_range->maxval = 1;
+	} else {
+		/* All other available LSM hooks, except task_prctl, return 0
+		 * on success and negative error code on failure.
+		 * To keep things simple, we only allow bpf progs to return 0
+		 * or negative errno for task_prctl too.
+		 */
+		retval_range->minval = -MAX_ERRNO;
+		retval_range->maxval = 0;
+	}
+	return 0;
+}
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 520f49f422fe..95426d5b634e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6416,8 +6416,11 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 
 	if (arg == nr_args) {
 		switch (prog->expected_attach_type) {
-		case BPF_LSM_CGROUP:
 		case BPF_LSM_MAC:
+			/* mark we are accessing the return value */
+			info->is_retval = true;
+			fallthrough;
+		case BPF_LSM_CGROUP:
 		case BPF_TRACE_FEXIT:
 			/* When LSM programs are attached to void LSM hooks
 			 * they use FEXIT trampolines and when attached to
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8da132a1ef28..fefa1d5d2faa 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2334,6 +2334,25 @@ static void mark_reg_unknown(struct bpf_verifier_env *env,
 	__mark_reg_unknown(env, regs + regno);
 }
 
+static int __mark_reg_s32_range(struct bpf_verifier_env *env,
+				struct bpf_reg_state *regs,
+				u32 regno,
+				s32 s32_min,
+				s32 s32_max)
+{
+	struct bpf_reg_state *reg = regs + regno;
+
+	reg->s32_min_value = max_t(s32, reg->s32_min_value, s32_min);
+	reg->s32_max_value = min_t(s32, reg->s32_max_value, s32_max);
+
+	reg->smin_value = max_t(s64, reg->smin_value, s32_min);
+	reg->smax_value = min_t(s64, reg->smax_value, s32_max);
+
+	reg_bounds_sync(reg);
+
+	return reg_bounds_sanity_check(env, reg, "s32_range");
+}
+
 static void __mark_reg_not_init(const struct bpf_verifier_env *env,
 				struct bpf_reg_state *reg)
 {
@@ -5587,11 +5606,12 @@ static int check_packet_access(struct bpf_verifier_env *env, u32 regno, int off,
 /* check access to 'struct bpf_context' fields.  Supports fixed offsets only */
 static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off, int size,
 			    enum bpf_access_type t, enum bpf_reg_type *reg_type,
-			    struct btf **btf, u32 *btf_id)
+			    struct btf **btf, u32 *btf_id, bool *is_retval)
 {
 	struct bpf_insn_access_aux info = {
 		.reg_type = *reg_type,
 		.log = &env->log,
+		.is_retval = false,
 	};
 
 	if (env->ops->is_valid_access &&
@@ -5604,6 +5624,7 @@ static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off,
 		 * type of narrower access.
 		 */
 		*reg_type = info.reg_type;
+		*is_retval = info.is_retval;
 
 		if (base_type(*reg_type) == PTR_TO_BTF_ID) {
 			*btf = info.btf;
@@ -6772,6 +6793,17 @@ static int check_stack_access_within_bounds(
 	return grow_stack_state(env, state, -min_off /* size */);
 }
 
+static bool get_func_retval_range(struct bpf_prog *prog,
+				  struct bpf_retval_range *range)
+{
+	if (prog->type == BPF_PROG_TYPE_LSM &&
+		prog->expected_attach_type == BPF_LSM_MAC &&
+		!bpf_lsm_get_retval_range(prog, range)) {
+		return true;
+	}
+	return false;
+}
+
 /* check whether memory at (regno + off) is accessible for t = (read | write)
  * if t==write, value_regno is a register which value is stored into memory
  * if t==read, value_regno is a register which will receive the value from memory
@@ -6876,6 +6908,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		if (!err && value_regno >= 0 && (t == BPF_READ || rdonly_mem))
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (reg->type == PTR_TO_CTX) {
+		bool is_retval = false;
+		struct bpf_retval_range range;
 		enum bpf_reg_type reg_type = SCALAR_VALUE;
 		struct btf *btf = NULL;
 		u32 btf_id = 0;
@@ -6891,7 +6925,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			return err;
 
 		err = check_ctx_access(env, insn_idx, off, size, t, &reg_type, &btf,
-				       &btf_id);
+				       &btf_id, &is_retval);
 		if (err)
 			verbose_linfo(env, insn_idx, "; ");
 		if (!err && t == BPF_READ && value_regno >= 0) {
@@ -6900,7 +6934,14 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			 * case, we know the offset is zero.
 			 */
 			if (reg_type == SCALAR_VALUE) {
-				mark_reg_unknown(env, regs, value_regno);
+				if (is_retval && get_func_retval_range(env->prog, &range)) {
+					err = __mark_reg_s32_range(env, regs, value_regno,
+								   range.minval, range.maxval);
+					if (err)
+						return err;
+				} else {
+					mark_reg_unknown(env, regs, value_regno);
+				}
 			} else {
 				mark_reg_known_zero(env, regs,
 						    value_regno);
@@ -15674,12 +15715,13 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 
 	case BPF_PROG_TYPE_LSM:
 		if (env->prog->expected_attach_type != BPF_LSM_CGROUP) {
-			/* Regular BPF_PROG_TYPE_LSM programs can return
-			 * any value.
-			 */
-			return 0;
-		}
-		if (!env->prog->aux->attach_func_proto->type) {
+			/* no range found, any return value is allowed */
+			if (!get_func_retval_range(env->prog, &range))
+				return 0;
+			/* no restricted range, any return value is allowed */
+			if (range.minval == S32_MIN && range.maxval == S32_MAX)
+				return 0;
+		} else if (!env->prog->aux->attach_func_proto->type) {
 			/* Make sure programs that attach to void
 			 * hooks don't try to modify return value.
 			 */
-- 
2.30.2


