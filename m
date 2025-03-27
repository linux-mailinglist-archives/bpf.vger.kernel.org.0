Return-Path: <bpf+bounces-54787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1717A72B54
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 09:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3706C1898309
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 08:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA652054E6;
	Thu, 27 Mar 2025 08:22:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63013204F77
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743063779; cv=none; b=I0PKtbM0/ICvA7Dyd6r3iJTZ4n+Yibrfz6PDXBtodjqA2Wbt9uBAHjjU2jOwED5AhyFY8vrjEOSHTtPR+Ng5kiaINWtypqoYJGVsNzTL/VfK5klG8M3jHFIpTtxgtD1sSHI9us5StC+Tgg6fIRh4Vr55VOZN5g3fU7bSuzdXpfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743063779; c=relaxed/simple;
	bh=ZsHbutmQo8o9nGkfQUHT5dKNOUBipznv/JtT6paLB7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UUKQpP+FWijohZhVF6wnPeQfQttUQ8d/mSiXfzyAthaEujz+GQIWmaoU0qx2EuA+tdt6xa61FxAxyRIQLMcpDNCyzz654hYrQeVBT9DB7H/bnhtXHHBvw0pevxFTUnAmSTeUMeuDsJYDNswE7W3FrAhUypzG01RRzS8C1dAS7ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZNc8r3H5Pz4f3jZd
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:22:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0AB751A0E99
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:22:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAXe1_XCuVnluzSHg--.7420S9;
	Thu, 27 Mar 2025 16:22:53 +0800 (CST)
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
	houtao1@huawei.com
Subject: [PATCH bpf-next v3 05/16] bpf: Support map key with dynptr in verifier
Date: Thu, 27 Mar 2025 16:34:44 +0800
Message-Id: <20250327083455.848708-6-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250327083455.848708-1-houtao@huaweicloud.com>
References: <20250327083455.848708-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXe1_XCuVnluzSHg--.7420S9
X-Coremail-Antispam: 1UD129KBjvJXoW3ArWxXw48Aw43Gw4DKry5XFb_yoW3ur4UpF
	4kG3sxWr4kKr4IvwsFqFsrAF15Kw1Iqw47GrWrK340yFyrXrZ09Fy0kFyUur13trZ8C347
	Jw1qqFZ8uw4UJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U1aLvJUUUUU==
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
 kernel/bpf/verifier.c | 186 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 173 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9d611d5152789..05a5636ae4984 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7950,9 +7950,90 @@ static int allow_uninitialized_stack_range(struct bpf_verifier_env *env, int reg
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
@@ -7975,6 +8056,8 @@ static int check_stack_range_initialized(struct bpf_verifier_env *env, int regno
 		stype = &state->stack[spi].slot_type[slot % BPF_REG_SIZE];
 		if (*stype == STACK_MISC)
 			goto mark;
+		if (dynkey && *stype == STACK_DYNPTR)
+			goto mark;
 		if ((*stype == STACK_ZERO) ||
 		    (*stype == STACK_INVALID && env->allow_uninit_stack)) {
 			if (clobber) {
@@ -8007,6 +8090,15 @@ static int check_stack_range_initialized(struct bpf_verifier_env *env, int regno
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
@@ -8058,7 +8150,60 @@ static int check_stack_range_access(struct bpf_verifier_env *env, int regno, int
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
@@ -9676,18 +9821,33 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			verbose(env, "invalid map_ptr to access map->key\n");
 			return -EACCES;
 		}
+
 		key_size = meta->map_ptr->key_size;
-		err = check_helper_mem_access(env, regno, key_size, BPF_READ, false, NULL);
-		if (err)
-			return err;
-		if (can_elide_value_nullness(meta->map_ptr->map_type)) {
-			err = get_constant_map_key(env, reg, key_size, &meta->const_map_key);
-			if (err < 0) {
-				meta->const_map_key = -1;
-				if (err == -EOPNOTSUPP)
-					err = 0;
-				else
-					return err;
+		/* Only allow PTR_TO_STACK for dynptr-key */
+		if (bpf_map_has_dynptr_key(meta->map_ptr)) {
+			if (base_type(reg->type) != PTR_TO_STACK) {
+				verbose(env, "map dynptr-key requires stack ptr but got %s\n",
+					reg_type_str(env, reg->type));
+				return -EACCES;
+			}
+			err = check_dynkey_stack_range_access(env, regno, reg->off, key_size, meta);
+			if (err)
+				return err;
+		} else {
+			err = check_helper_mem_access(env, regno, key_size, BPF_READ, false, NULL);
+			if (err)
+				return err;
+
+			if (can_elide_value_nullness(meta->map_ptr->map_type)) {
+				err = get_constant_map_key(env, reg, key_size,
+							   &meta->const_map_key);
+				if (err < 0) {
+					meta->const_map_key = -1;
+					if (err == -EOPNOTSUPP)
+						err = 0;
+					else
+						return err;
+				}
 			}
 		}
 		break;
-- 
2.29.2


