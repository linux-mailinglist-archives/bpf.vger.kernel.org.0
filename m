Return-Path: <bpf+bounces-41206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5259699438F
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF22282A66
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7571DEFC9;
	Tue,  8 Oct 2024 09:02:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FB816DEB4
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378154; cv=none; b=DX5QqqjxtdIfd06yV2+/xejGs+If4E31bnZcPIjthtGRTEDwiFFjsBkxO1pZZjs9tx6qqBLEMo1grLDmxVGXm8TGO/6xdBvj2LHQSSdJCE/KgpM2QO3yHlq3yqunMg0IXXIu0l/eXih9LhjQPpPoDpFZWTCR08lwljtn+XbUJaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378154; c=relaxed/simple;
	bh=8lAeQSX2SWsoFS95RbSvF8IAzPpYQeVpyKHetiCvKXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jBUr/Y9xB7M211CSu0+Gw6qhhGeVOnBe/10xKnkNN1JrEGPWuMzZj5G2Jhxu1HSK1VDLVX4sZDsqTGFeimjoJc9+r8BpHN0jcGkDEvS3THvGfPOexJEHkjzTWqXAeezgNdnWsOR7euZRaoDaVhT+8tR/nurGHsiOtChBWWYJRU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XN94x5vHjz4f3lfT
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:02:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5CE111A018D
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:02:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.60])
	by APP4 (Coremail) with SMTP id gCh0CgDH+sYd9QRnbOEHDg--.25681S9;
	Tue, 08 Oct 2024 17:02:27 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
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
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next 05/16] bpf: Support map key with dynptr in verifier
Date: Tue,  8 Oct 2024 17:14:50 +0800
Message-ID: <20241008091501.8302-6-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241008091501.8302-1-houtao@huaweicloud.com>
References: <20241008091501.8302-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+sYd9QRnbOEHDg--.25681S9
X-Coremail-Antispam: 1UD129KBjvJXoW3ArWxXw48Aw47ZrWkKw15Jwb_yoW3try5pF
	4kGa4Sgr1kKr42vwsxtFsrAry5Kw4xZw47CrWFg340vFy8Jr909ry0qFy5ur15trWkA3y7
	Aws0qFZ0v3WUJFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07Udl1kUUUUU=
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
parts in the stack content is consistent with the btf_record of the map
key.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/verifier.c | 143 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 134 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2090d2472d7c..345b45edf2a7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5042,6 +5042,7 @@ enum bpf_access_src {
 };
 
 #define ACCESS_F_ZERO_SIZE_ALLOWED BIT(0)
+#define ACCESS_F_DYNPTR_READ_ALLOWED BIT(1)
 
 static int check_stack_range_initialized(struct bpf_verifier_env *env,
 					 int regno, int off, int access_size,
@@ -7267,6 +7268,86 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	return 0;
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
 /* When register 'regno' is used to read the stack (either directly or through
  * a helper function) make sure that it's within stack boundary and, depending
  * on the access type and privileges, that all elements of the stack are
@@ -7287,6 +7368,8 @@ static int check_stack_range_initialized(
 	int err, min_off, max_off, i, j, slot, spi;
 	char *err_extra = type == ACCESS_HELPER ? " indirect" : "";
 	enum bpf_access_type bounds_check_type;
+	struct dynptr_key_state dynptr_key;
+	bool dynptr_read_allowed;
 	/* Some accesses can write anything into the stack, others are
 	 * read-only.
 	 */
@@ -7312,9 +7395,14 @@ static int check_stack_range_initialized(
 	if (err)
 		return err;
 
-
+	dynptr_read_allowed = access_flags & ACCESS_F_DYNPTR_READ_ALLOWED;
 	if (tnum_is_const(reg->var_off)) {
 		min_off = max_off = reg->var_off.value + off;
+
+		if (dynptr_read_allowed && (min_off % BPF_REG_SIZE)) {
+			verbose(env, "R%d misaligned offset %d for dynptr-key\n", regno, min_off);
+			return -EACCES;
+		}
 	} else {
 		/* Variable offset is prohibited for unprivileged mode for
 		 * simplicity since it requires corresponding support in
@@ -7329,6 +7417,12 @@ static int check_stack_range_initialized(
 				regno, err_extra, tn_buf);
 			return -EACCES;
 		}
+
+		if (dynptr_read_allowed) {
+			verbose(env, "R%d variable offset prohibited for dynptr-key\n", regno);
+			return -EACCES;
+		}
+
 		/* Only initialized buffer on stack is allowed to be accessed
 		 * with variable offset. With uninitialized buffer it's hard to
 		 * guarantee that whole memory is marked as initialized on
@@ -7373,19 +7467,26 @@ static int check_stack_range_initialized(
 		return 0;
 	}
 
+	if (dynptr_read_allowed) {
+		err = init_dynptr_key_state(env, meta->map_ptr->key_record, &dynptr_key);
+		if (err)
+			return err;
+	}
 	for (i = min_off; i < max_off + access_size; i++) {
 		u8 *stype;
 
 		slot = -i - 1;
 		spi = slot / BPF_REG_SIZE;
 		if (state->allocated_stack <= slot) {
-			verbose(env, "verifier bug: allocated_stack too small");
+			verbose(env, "verifier bug: allocated_stack too small\n");
 			return -EFAULT;
 		}
 
 		stype = &state->stack[spi].slot_type[slot % BPF_REG_SIZE];
 		if (*stype == STACK_MISC)
 			goto mark;
+		if (dynptr_read_allowed && *stype == STACK_DYNPTR)
+			goto mark;
 		if ((*stype == STACK_ZERO) ||
 		    (*stype == STACK_INVALID && env->allow_uninit_stack)) {
 			if (clobber) {
@@ -7418,18 +7519,28 @@ static int check_stack_range_initialized(
 		}
 		return -EACCES;
 mark:
+		if (dynptr_read_allowed) {
+			err = check_dynptr_key_access(env, &dynptr_key,
+						      &state->stack[spi].spilled_ptr, *stype,
+						      i - min_off);
+			if (err)
+				return err;
+		}
+
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
+
 	}
+
 	return 0;
 }
 
@@ -8933,6 +9044,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		meta->map_uid = reg->map_uid;
 		break;
 	case ARG_PTR_TO_MAP_KEY:
+	{
+		u32 access_flags = 0;
+
 		/* bpf_map_xxx(..., map_ptr, ..., key) call:
 		 * check that [key, key + map->key_size) are within
 		 * stack limits and initialized
@@ -8946,10 +9060,21 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			verbose(env, "invalid map_ptr to access map->key\n");
 			return -EACCES;
 		}
+		/* Only allow PTR_TO_STACK for dynptr-key */
+		if (bpf_map_has_dynptr_key(meta->map_ptr)) {
+			if (base_type(reg->type) != PTR_TO_STACK) {
+				verbose(env, "map dynptr-key requires stack ptr but got %s\n",
+					reg_type_str(env, reg->type));
+				return -EACCES;
+			}
+			access_flags |= ACCESS_F_DYNPTR_READ_ALLOWED;
+		}
+		meta->raw_mode = false;
 		err = check_helper_mem_access(env, regno,
-					      meta->map_ptr->key_size, 0,
-					      NULL);
+					      meta->map_ptr->key_size, access_flags,
+					      meta);
 		break;
+	}
 	case ARG_PTR_TO_MAP_VALUE:
 		if (type_may_be_null(arg_type) && register_is_null(reg))
 			return 0;
-- 
2.44.0


