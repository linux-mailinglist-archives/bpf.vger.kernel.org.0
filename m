Return-Path: <bpf+bounces-49796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4996FA1C2DA
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 11:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A86F3A6386
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 10:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124DB208978;
	Sat, 25 Jan 2025 10:59:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5958E2080C6
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737802758; cv=none; b=Fq9tTth5MrUV7Lcul3KuoKZ3Kn4ry/0RJqNRvVb0k+QR7uq0hRKg+nh6cuFPL6XboFOtoUt0Tq+7CMmVeqCmK1i0JJiNBOWBtDH5Z2X8IjPlOo7OFjfww6ttmD72wnN5yGvqDtTb5qn4O97QZN+jAoxYQCfAi8AOcg2ctXngFu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737802758; c=relaxed/simple;
	bh=//YszhtXQfCRe3+h1puwzTokjXnMv4ll9xEFrM2/b4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AwQOVxpfqpYCEcRk7LoDWgZcslVD6DGdGDvHx9OoAU4+33IDAbhmK+YzupXeKJC3RYbXUcfj1sIh8R4XSAuTQspjzWMJoPaviEqKB42cspJ2JJMDd5nwY7GxqiCPpDY0laCxG5tB6q8MNg4eYCCbNX8rmelKLboGJ7rozTuTaCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YgBWC5YCGz4f3jXt
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:58:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 80A121A1059
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:59:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBXul7zw5Rn79XHBw--.24605S13;
	Sat, 25 Jan 2025 18:59:08 +0800 (CST)
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
Subject: [PATCH bpf-next v2 09/20] bpf: Support map key with dynptr in verifier
Date: Sat, 25 Jan 2025 19:10:58 +0800
Message-Id: <20250125111109.732718-10-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBXul7zw5Rn79XHBw--.24605S13
X-Coremail-Antispam: 1UD129KBjvJXoW3ArWxXw48Cr4DJryxZw1fJFb_yoW3ZF1kpF
	4kG3s3Wr4kKr4IvwsrtFsrAFy5Kw1Iqw47CrWrK3y0yF95XrZ09Fy0kFyUur13trZ8Ca47
	Jw1qqFZxZw1UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

The patch basically does the following three things to enable dynptr key
for bpf map:

1) Only allow PTR_TO_STACK typed register for dynptr key
The main reason is that bpf_dynptr can only be defined in the stack, so
for dynptr key only PTR_TO_STACK typed register is allowed. bpf_dynptr
could also be represented by CONST_PTR_TO_DYNPTR typed register (e.g.,
in callback func or subprog), but it is not supported now.

2) Only allow fixed-offset for PTR_TO_STACK register
Variable-offset for PTR_TO_STACK typed register is disallowed, because
it is impossible to check whether or not the stack access is aligned
with BPF_REG_SIZE and is matched with the location of dynptr or
non-dynptr part in the map key.

3) Check the layout of the stack content is matched with the btf_record
Firstly check the start offset of the stack access is aligned with
BPF_REG_SIZE, then check the offset and the size of dynptr/non-dynptr
parts in the stack range is consistent with the btf_record of the map
key.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/verifier.c | 170 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 164 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 290b9b93017c0..4e8531f246e8a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7705,9 +7705,90 @@ static int allow_uninitialized_stack_range(struct bpf_verifier_env *env, int reg
 	return 1;
 }
 
+struct dynptr_key_state {
+	const struct btf_record *rec;
+	const struct btf_field *cur_dynptr;
+	bool valid_dynptr_id;
+	int cur_dynptr_id;
+};
+
+static int init_dynptr_key_state(struct bpf_verifier_env *env, const struct btf_record *rec,
+				 struct dynptr_key_state *state)
+{
+	unsigned int i;
+
+	/* Find the first dynptr in the dynptr-key */
+	for (i = 0; i < rec->cnt; i++) {
+		if (rec->fields[i].type == BPF_DYNPTR)
+			break;
+	}
+	if (i >= rec->cnt) {
+		verbose(env, "verifier bug: dynptr not found\n");
+		return -EFAULT;
+	}
+
+	state->rec = rec;
+	state->cur_dynptr = &rec->fields[i];
+	state->valid_dynptr_id = false;
+
+	return 0;
+}
+
+static int check_dynptr_key_access(struct bpf_verifier_env *env, struct dynptr_key_state *state,
+				   struct bpf_reg_state *reg, u8 stype, int offset)
+{
+	const struct btf_field *dynptr = state->cur_dynptr;
+
+	/* Non-dynptr part before a dynptr or non-dynptr part after
+	 * the last dynptr.
+	 */
+	if (offset < dynptr->offset || offset >= dynptr->offset + dynptr->size) {
+		if (stype == STACK_DYNPTR) {
+			verbose(env,
+				"dynptr-key expects non-dynptr at offset %d cur_dynptr_offset %u\n",
+				offset, dynptr->offset);
+			return -EACCES;
+		}
+	} else {
+		if (stype != STACK_DYNPTR) {
+			verbose(env,
+				"dynptr-key expects dynptr at offset %d cur_dynptr_offset %u\n",
+				offset, dynptr->offset);
+			return -EACCES;
+		}
+
+		/* A dynptr is composed of parts from two dynptrs */
+		if (state->valid_dynptr_id && reg->id != state->cur_dynptr_id) {
+			verbose(env, "malformed dynptr-key at offset %d cur_dynptr_offset %u\n",
+				offset, dynptr->offset);
+			return -EACCES;
+		}
+		if (!state->valid_dynptr_id) {
+			state->valid_dynptr_id = true;
+			state->cur_dynptr_id = reg->id;
+		}
+
+		if (offset == dynptr->offset + dynptr->size - 1) {
+			const struct btf_record *rec = state->rec;
+			unsigned int i;
+
+			for (i = dynptr - rec->fields + 1; i < rec->cnt; i++) {
+				if (rec->fields[i].type == BPF_DYNPTR) {
+					state->cur_dynptr = &rec->fields[i];
+					state->valid_dynptr_id = false;
+					break;
+				}
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int check_stack_range_initialized(struct bpf_verifier_env *env, int regno,
 					 int min_off, int max_off, int access_size,
-					 enum bpf_access_type type)
+					 enum bpf_access_type type,
+					 struct dynptr_key_state *dynkey)
 {
 	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct bpf_func_state *state = func(env, reg);
@@ -7730,6 +7811,8 @@ static int check_stack_range_initialized(struct bpf_verifier_env *env, int regno
 		stype = &state->stack[spi].slot_type[slot % BPF_REG_SIZE];
 		if (*stype == STACK_MISC)
 			goto mark;
+		if (dynkey && *stype == STACK_DYNPTR)
+			goto mark;
 		if ((*stype == STACK_ZERO) ||
 		    (*stype == STACK_INVALID && env->allow_uninit_stack)) {
 			if (clobber) {
@@ -7762,6 +7845,15 @@ static int check_stack_range_initialized(struct bpf_verifier_env *env, int regno
 		}
 		return -EACCES;
 mark:
+		if (dynkey) {
+			int err = check_dynptr_key_access(env, dynkey,
+							  &state->stack[spi].spilled_ptr,
+							  *stype, i - min_off);
+
+			if (err)
+				return err;
+		}
+
 		/* reading any byte out of 8-byte 'spill_slot' will cause
 		 * the whole slot to be marked as 'read'
 		 *
@@ -7813,7 +7905,60 @@ static int check_stack_range_access(struct bpf_verifier_env *env, int regno, int
 	if (err > 0)
 		return 0;
 
-	return check_stack_range_initialized(env, regno, min_off, max_off, access_size, type);
+	return check_stack_range_initialized(env, regno, min_off, max_off, access_size, type, NULL);
+}
+
+static int check_dynkey_stack_access_offset(struct bpf_verifier_env *env, int regno, int off)
+{
+	struct bpf_reg_state *reg = reg_state(env, regno);
+
+	if (!tnum_is_const(reg->var_off)) {
+		verbose(env, "R%d variable offset prohibited for dynptr-key\n", regno);
+		return -EACCES;
+	}
+
+	off = reg->var_off.value + off;
+	if (off % BPF_REG_SIZE) {
+		verbose(env, "R%d misaligned offset %d for dynptr-key\n", regno, off);
+		return -EACCES;
+	}
+
+	return 0;
+}
+
+/* It is almost the same as check_stack_range_access(), except the following
+ * things:
+ * (1) no need to check whether access_size is zero (due to non-zero key_size)
+ * (2) disallow uninitialized stack range
+ * (3) need BPF_REG_SIZE-aligned access with fixed-size offset
+ * (4) need to check whether the layout of bpf_dynptr part and non-bpf_dynptr
+ *     part in the stack range is the same as the layout of dynptr key
+ */
+static int check_dynkey_stack_range_access(struct bpf_verifier_env *env, int regno, int off,
+					   int access_size, struct bpf_call_arg_meta *meta)
+{
+	enum bpf_access_type type = BPF_READ;
+	struct dynptr_key_state dynkey;
+	int err, min_off, max_off;
+
+	err = check_stack_access_within_bounds(env, regno, off, access_size, type);
+	if (err)
+		return err;
+
+	err = check_dynkey_stack_access_offset(env, regno, off);
+	if (err)
+		return err;
+
+	err = get_stack_access_range(env, regno, off, &min_off, &max_off);
+	if (err)
+		return err;
+
+	err = init_dynptr_key_state(env, meta->map_ptr->key_record, &dynkey);
+	if (err)
+		return err;
+
+	return check_stack_range_initialized(env, regno, min_off, max_off, access_size, type,
+					     &dynkey);
 }
 
 static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
@@ -9383,13 +9528,26 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			verbose(env, "invalid map_ptr to access map->key\n");
 			return -EACCES;
 		}
+
 		key_size = meta->map_ptr->key_size;
-		err = check_helper_mem_access(env, regno, key_size, BPF_READ, false, NULL);
+		/* Only allow PTR_TO_STACK for dynptr-key */
+		if (bpf_map_has_dynptr_key(meta->map_ptr)) {
+			if (base_type(reg->type) != PTR_TO_STACK) {
+				verbose(env, "map dynptr-key requires stack ptr but got %s\n",
+					reg_type_str(env, reg->type));
+				return -EACCES;
+			}
+			err = check_dynkey_stack_range_access(env, regno, reg->off, key_size, meta);
+		} else {
+			err = check_helper_mem_access(env, regno, key_size, BPF_READ, false, NULL);
+			if (!err) {
+				meta->const_map_key = get_constant_map_key(env, reg, key_size);
+				if (meta->const_map_key < 0 && meta->const_map_key != -EOPNOTSUPP)
+					err = meta->const_map_key;
+			}
+		}
 		if (err)
 			return err;
-		meta->const_map_key = get_constant_map_key(env, reg, key_size);
-		if (meta->const_map_key < 0 && meta->const_map_key != -EOPNOTSUPP)
-			return meta->const_map_key;
 		break;
 	case ARG_PTR_TO_MAP_VALUE:
 		if (type_may_be_null(arg_type) && register_is_null(reg))
-- 
2.29.2


