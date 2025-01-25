Return-Path: <bpf+bounces-49798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4D7A1C2E0
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 12:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66FD61888951
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 10:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2812B20897E;
	Sat, 25 Jan 2025 10:59:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595321E7C11
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737802758; cv=none; b=k3Ouzl2skD5Obroe+f4myyfcLI4PtMp+i3SV2KAyp6MpCQxWOjLekEa+B4KlO+sjwvvVrGeAYs+fAv8DzpGOvUQjke3v1jjXK2HIrWCS2FHDytkYe+gl2/sfIH1B+sBTfPVc92EO8iBRDP6raL3RFrqyh/FWUuEceIMlcVIWHsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737802758; c=relaxed/simple;
	bh=mwYKdUUMyj0/U/n5kcjeHBbZ0RUeugD2XSUCrzWKN7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SBMncrJTnw/uwtPQaUeNiYsHSaryeaRO+iS4wYsBuBBSplnQFsZKsurQ99XDyYlQ/0E4oLKOjwmrYQpv+iCKWQHeqVj5d8oQIDmq5/ej+8eR77DCenwOS7TEKOUoLr088yTSYmBW3u1rdnvBNuKC4xK092aBf7VwIfTTkdtQ7EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YgBWC158vz4f3jXp
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:58:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DD68F1A166C
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:59:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBXul7zw5Rn79XHBw--.24605S12;
	Sat, 25 Jan 2025 18:59:07 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next v2 08/20] bpf: Split check_stack_range_initialized() into small functions
Date: Sat, 25 Jan 2025 19:10:57 +0800
Message-Id: <20250125111109.732718-9-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250125111109.732718-1-houtao@huaweicloud.com>
References: <20250125111109.732718-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXul7zw5Rn79XHBw--.24605S12
X-Coremail-Antispam: 1UD129KBjvJXoW3KF1fGw15XryrJFWrCrWUtwb_yoWDtFy5pr
	s7Wa9rCr4kKay8Xa12v3ZrAFy5CrWvqrWUC345ta4xZr1rur90gFyvqFyjvr1fCrZ2kw1x
	KF1vvrZrAw4DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUF9NVUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

It is a preparatory patch for supporting map key with bpf_dynptr in
verifier. The patch splits check_stack_range_initialized() into multiple
small functions and the following patch will reuse these functions to
check whether the access of stack range which contains bpf_dynptr is
valid or not.

Beside the splitting of check_stack_range_initialized(), the patch also
changes its name to check_stack_range_access() to better reflect its
purpose, because the function also allows uninitialized stack range.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/verifier.c | 209 ++++++++++++++++++++++++------------------
 1 file changed, 121 insertions(+), 88 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 74525392714e2..290b9b93017c0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -791,7 +791,7 @@ static void invalidate_dynptr(struct bpf_verifier_env *env, struct bpf_func_stat
 	 * While we don't allow reading STACK_INVALID, it is still possible to
 	 * do <8 byte writes marking some but not all slots as STACK_MISC. Then,
 	 * helpers or insns can do partial read of that part without failing,
-	 * but check_stack_range_initialized, check_stack_read_var_off, and
+	 * but check_stack_range_access, check_stack_read_var_off, and
 	 * check_stack_read_fixed_off will do mark_reg_read for all 8-bytes of
 	 * the slot conservatively. Hence we need to prevent those liveness
 	 * marking walks.
@@ -5301,11 +5301,11 @@ enum bpf_access_src {
 	ACCESS_HELPER = 2,  /* the access is performed by a helper */
 };
 
-static int check_stack_range_initialized(struct bpf_verifier_env *env,
-					 int regno, int off, int access_size,
-					 bool zero_size_allowed,
-					 enum bpf_access_type type,
-					 struct bpf_call_arg_meta *meta);
+static int check_stack_range_access(struct bpf_verifier_env *env,
+				    int regno, int off, int access_size,
+				    bool zero_size_allowed,
+				    enum bpf_access_type type,
+				    struct bpf_call_arg_meta *meta);
 
 static struct bpf_reg_state *reg_state(struct bpf_verifier_env *env, int regno)
 {
@@ -5336,8 +5336,8 @@ static int check_stack_read_var_off(struct bpf_verifier_env *env,
 
 	/* Note that we pass a NULL meta, so raw access will not be permitted.
 	 */
-	err = check_stack_range_initialized(env, ptr_regno, off, size,
-					    false, BPF_READ, NULL);
+	err = check_stack_range_access(env, ptr_regno, off, size,
+				       false, BPF_READ, NULL);
 	if (err)
 		return err;
 
@@ -7625,44 +7625,13 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	return 0;
 }
 
-/* When register 'regno' is used to read the stack (either directly or through
- * a helper function) make sure that it's within stack boundary and, depending
- * on the access type and privileges, that all elements of the stack are
- * initialized.
- *
- * 'off' includes 'regno->off', but not its dynamic part (if any).
- *
- * All registers that have been spilled on the stack in the slots within the
- * read offsets are marked as read.
- */
-static int check_stack_range_initialized(
-		struct bpf_verifier_env *env, int regno, int off,
-		int access_size, bool zero_size_allowed,
-		enum bpf_access_type type, struct bpf_call_arg_meta *meta)
+static int get_stack_access_range(struct bpf_verifier_env *env, int regno, int off,
+				  int *min_off, int *max_off)
 {
 	struct bpf_reg_state *reg = reg_state(env, regno);
-	struct bpf_func_state *state = func(env, reg);
-	int err, min_off, max_off, i, j, slot, spi;
-	/* Some accesses can write anything into the stack, others are
-	 * read-only.
-	 */
-	bool clobber = false;
-
-	if (access_size == 0 && !zero_size_allowed) {
-		verbose(env, "invalid zero-sized read\n");
-		return -EACCES;
-	}
-
-	if (type == BPF_WRITE)
-		clobber = true;
-
-	err = check_stack_access_within_bounds(env, regno, off, access_size, type);
-	if (err)
-		return err;
-
 
 	if (tnum_is_const(reg->var_off)) {
-		min_off = max_off = reg->var_off.value + off;
+		*min_off = *max_off = reg->var_off.value + off;
 	} else {
 		/* Variable offset is prohibited for unprivileged mode for
 		 * simplicity since it requires corresponding support in
@@ -7677,49 +7646,76 @@ static int check_stack_range_initialized(
 				regno, tn_buf);
 			return -EACCES;
 		}
-		/* Only initialized buffer on stack is allowed to be accessed
-		 * with variable offset. With uninitialized buffer it's hard to
-		 * guarantee that whole memory is marked as initialized on
-		 * helper return since specific bounds are unknown what may
-		 * cause uninitialized stack leaking.
-		 */
-		if (meta && meta->raw_mode)
-			meta = NULL;
 
-		min_off = reg->smin_value + off;
-		max_off = reg->smax_value + off;
+		*min_off = reg->smin_value + off;
+		*max_off = reg->smax_value + off;
 	}
 
-	if (meta && meta->raw_mode) {
-		/* Ensure we won't be overwriting dynptrs when simulating byte
-		 * by byte access in check_helper_call using meta.access_size.
-		 * This would be a problem if we have a helper in the future
-		 * which takes:
-		 *
-		 *	helper(uninit_mem, len, dynptr)
-		 *
-		 * Now, uninint_mem may overlap with dynptr pointer. Hence, it
-		 * may end up writing to dynptr itself when touching memory from
-		 * arg 1. This can be relaxed on a case by case basis for known
-		 * safe cases, but reject due to the possibilitiy of aliasing by
-		 * default.
-		 */
-		for (i = min_off; i < max_off + access_size; i++) {
-			int stack_off = -i - 1;
+	return 0;
+}
 
-			spi = __get_spi(i);
-			/* raw_mode may write past allocated_stack */
-			if (state->allocated_stack <= stack_off)
-				continue;
-			if (state->stack[spi].slot_type[stack_off % BPF_REG_SIZE] == STACK_DYNPTR) {
-				verbose(env, "potential write to dynptr at off=%d disallowed\n", i);
-				return -EACCES;
-			}
-		}
-		meta->access_size = access_size;
-		meta->regno = regno;
+static int allow_uninitialized_stack_range(struct bpf_verifier_env *env, int regno,
+					   int min_off, int max_off, int access_size,
+					   struct bpf_call_arg_meta *meta)
+{
+	struct bpf_reg_state *reg = reg_state(env, regno);
+	struct bpf_func_state *state = func(env, reg);
+	int i, stack_off, spi;
+
+	/* Disallow uninitialized buffer on stack */
+	if (!meta || !meta->raw_mode)
+		return 0;
+
+	/* Only initialized buffer on stack is allowed to be accessed
+	 * with variable offset. With uninitialized buffer it's hard to
+	 * guarantee that whole memory is marked as initialized on
+	 * helper return since specific bounds are unknown what may
+	 * cause uninitialized stack leaking.
+	 */
+	if (!tnum_is_const(reg->var_off))
 		return 0;
+
+	/* Ensure we won't be overwriting dynptrs when simulating byte
+	 * by byte access in check_helper_call using meta.access_size.
+	 * This would be a problem if we have a helper in the future
+	 * which takes:
+	 *
+	 *	helper(uninit_mem, len, dynptr)
+	 *
+	 * Now, uninint_mem may overlap with dynptr pointer. Hence, it
+	 * may end up writing to dynptr itself when touching memory from
+	 * arg 1. This can be relaxed on a case by case basis for known
+	 * safe cases, but reject due to the possibilitiy of aliasing by
+	 * default.
+	 */
+	for (i = min_off; i < max_off + access_size; i++) {
+		stack_off = -i - 1;
+		spi = __get_spi(i);
+		/* raw_mode may write past allocated_stack */
+		if (state->allocated_stack <= stack_off)
+			continue;
+		if (state->stack[spi].slot_type[stack_off % BPF_REG_SIZE] == STACK_DYNPTR) {
+			verbose(env, "potential write to dynptr at off=%d disallowed\n", i);
+			return -EACCES;
+		}
 	}
+	meta->access_size = access_size;
+	meta->regno = regno;
+
+	return 1;
+}
+
+static int check_stack_range_initialized(struct bpf_verifier_env *env, int regno,
+					 int min_off, int max_off, int access_size,
+					 enum bpf_access_type type)
+{
+	struct bpf_reg_state *reg = reg_state(env, regno);
+	struct bpf_func_state *state = func(env, reg);
+	int i, j, slot, spi;
+	/* Some accesses can write anything into the stack, others are
+	 * read-only.
+	 */
+	bool clobber = type == BPF_WRITE;
 
 	for (i = min_off; i < max_off + access_size; i++) {
 		u8 *stype;
@@ -7768,19 +7764,58 @@ static int check_stack_range_initialized(
 mark:
 		/* reading any byte out of 8-byte 'spill_slot' will cause
 		 * the whole slot to be marked as 'read'
-		 */
-		mark_reg_read(env, &state->stack[spi].spilled_ptr,
-			      state->stack[spi].spilled_ptr.parent,
-			      REG_LIVE_READ64);
-		/* We do not set REG_LIVE_WRITTEN for stack slot, as we can not
+		 *
+		 * We do not set REG_LIVE_WRITTEN for stack slot, as we can not
 		 * be sure that whether stack slot is written to or not. Hence,
 		 * we must still conservatively propagate reads upwards even if
 		 * helper may write to the entire memory range.
 		 */
+		mark_reg_read(env, &state->stack[spi].spilled_ptr,
+			      state->stack[spi].spilled_ptr.parent,
+			      REG_LIVE_READ64);
 	}
+
 	return 0;
 }
 
+/* When register 'regno' is used to read the stack (either directly or through
+ * a helper function) make sure that it's within stack boundary and, depending
+ * on the access type and privileges, that all elements of the stack are
+ * initialized.
+ *
+ * 'off' includes 'regno->off', but not its dynamic part (if any).
+ *
+ * All registers that have been spilled on the stack in the slots within the
+ * read offsets are marked as read.
+ */
+static int check_stack_range_access(struct bpf_verifier_env *env, int regno, int off,
+				    int access_size, bool zero_size_allowed,
+				    enum bpf_access_type type, struct bpf_call_arg_meta *meta)
+{
+	int err, min_off, max_off;
+
+	if (access_size == 0 && !zero_size_allowed) {
+		verbose(env, "invalid zero-sized read\n");
+		return -EACCES;
+	}
+
+	err = check_stack_access_within_bounds(env, regno, off, access_size, type);
+	if (err)
+		return err;
+
+	err = get_stack_access_range(env, regno, off, &min_off, &max_off);
+	if (err)
+		return err;
+
+	err = allow_uninitialized_stack_range(env, regno, min_off, max_off, access_size, meta);
+	if (err < 0)
+		return err;
+	if (err > 0)
+		return 0;
+
+	return check_stack_range_initialized(env, regno, min_off, max_off, access_size, type);
+}
+
 static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 				   int access_size, enum bpf_access_type access_type,
 				   bool zero_size_allowed,
@@ -7834,10 +7869,8 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 					   access_size, zero_size_allowed,
 					   max_access);
 	case PTR_TO_STACK:
-		return check_stack_range_initialized(
-				env,
-				regno, reg->off, access_size,
-				zero_size_allowed, access_type, meta);
+		return check_stack_range_access(env, regno, reg->off, access_size,
+						zero_size_allowed, access_type, meta);
 	case PTR_TO_BTF_ID:
 		return check_ptr_to_btf_access(env, regs, regno, reg->off,
 					       access_size, BPF_READ, -1);
-- 
2.29.2


