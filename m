Return-Path: <bpf+bounces-41201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D40994389
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314CA2845BB
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1396E17A589;
	Tue,  8 Oct 2024 09:02:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE92313A878
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378151; cv=none; b=Q2QRj64RV9RUK91iLOqjElDfGPx6sHGM7dlazYFZ1bN5sRzUk9wCfwRebl3xDUpbv+TaYsiOaVTh+cAoYvIMCSDkxnsRlswAjHwdenmdJsW+jbJWrQADhBjFqU1iszEXCQeV9w0/y9RtwStLgITQzcIAJ8Qh0jARhnFtKTnydUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378151; c=relaxed/simple;
	bh=doHkw15zBUtQWRlRh7DR+1LlCpB4SjxUsQ/0M9cVuMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRvgF6UMOqLdyHOMN1jHoVY0iOr/x2ihlTBhG2512wMn3716pYIOLn66rFpVFHHaWmMEz2LSalijmwgHQFDqG111KsoymRlfPKVVbFZsqbldPuEq9gBlKWkdbfH7y19Ig/LzN8oFEXlL2j5MeCzPB0CA/yMKPb3fe8i2+Zb9tXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XN94x6wC1z4f3jY8
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:02:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BF9B11A0568
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:02:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.60])
	by APP4 (Coremail) with SMTP id gCh0CgDH+sYd9QRnbOEHDg--.25681S8;
	Tue, 08 Oct 2024 17:02:26 +0800 (CST)
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
Subject: [PATCH bpf-next 04/16] bpf: Pass flags instead of bool to check_helper_mem_access()
Date: Tue,  8 Oct 2024 17:14:49 +0800
Message-ID: <20241008091501.8302-5-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDH+sYd9QRnbOEHDg--.25681S8
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr4rKryftrWxGF1kKFWfZrb_yoWxJw43pr
	48G397Kr4ktF4xX3W2yFnrAa4UA348tw4fC3yfta4Iyr15ursxWF1vqryj9ryrArWvyw1x
	C3W0vrs3Aw1UCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07Udl1kUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Extend "bool zero_size_allowed" into "unsigned int flags", so more flags
could by passed to check_helper_mem_access().

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/verifier.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9a7ed527e47e..2090d2472d7c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5041,9 +5041,11 @@ enum bpf_access_src {
 	ACCESS_HELPER = 2,  /* the access is performed by a helper */
 };
 
+#define ACCESS_F_ZERO_SIZE_ALLOWED BIT(0)
+
 static int check_stack_range_initialized(struct bpf_verifier_env *env,
 					 int regno, int off, int access_size,
-					 bool zero_size_allowed,
+					 unsigned int access_flags,
 					 enum bpf_access_src type,
 					 struct bpf_call_arg_meta *meta);
 
@@ -5077,7 +5079,7 @@ static int check_stack_read_var_off(struct bpf_verifier_env *env,
 	/* Note that we pass a NULL meta, so raw access will not be permitted.
 	 */
 	err = check_stack_range_initialized(env, ptr_regno, off, size,
-					    false, ACCESS_DIRECT, NULL);
+					    0, ACCESS_DIRECT, NULL);
 	if (err)
 		return err;
 
@@ -7277,7 +7279,7 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
  */
 static int check_stack_range_initialized(
 		struct bpf_verifier_env *env, int regno, int off,
-		int access_size, bool zero_size_allowed,
+		int access_size, unsigned int access_flags,
 		enum bpf_access_src type, struct bpf_call_arg_meta *meta)
 {
 	struct bpf_reg_state *reg = reg_state(env, regno);
@@ -7290,7 +7292,7 @@ static int check_stack_range_initialized(
 	 */
 	bool clobber = false;
 
-	if (access_size == 0 && !zero_size_allowed) {
+	if (access_size == 0 && !(access_flags & ACCESS_F_ZERO_SIZE_ALLOWED)) {
 		verbose(env, "invalid zero-sized read\n");
 		return -EACCES;
 	}
@@ -7432,9 +7434,10 @@ static int check_stack_range_initialized(
 }
 
 static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
-				   int access_size, bool zero_size_allowed,
+				   int access_size, unsigned int access_flags,
 				   struct bpf_call_arg_meta *meta)
 {
+	bool zero_size_allowed = access_flags & ACCESS_F_ZERO_SIZE_ALLOWED;
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
 	u32 *max_access;
 
@@ -7488,7 +7491,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 		return check_stack_range_initialized(
 				env,
 				regno, reg->off, access_size,
-				zero_size_allowed, ACCESS_HELPER, meta);
+				access_flags, ACCESS_HELPER, meta);
 	case PTR_TO_BTF_ID:
 		return check_ptr_to_btf_access(env, regs, regno, reg->off,
 					       access_size, BPF_READ, -1);
@@ -7532,9 +7535,10 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
  */
 static int check_mem_size_reg(struct bpf_verifier_env *env,
 			      struct bpf_reg_state *reg, u32 regno,
-			      bool zero_size_allowed,
+			      unsigned int access_flags,
 			      struct bpf_call_arg_meta *meta)
 {
+	bool zero_size_allowed = access_flags & ACCESS_F_ZERO_SIZE_ALLOWED;
 	int err;
 
 	/* This is used to refine r0 return value bounds for helpers
@@ -7577,7 +7581,7 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 	}
 	err = check_helper_mem_access(env, regno - 1,
 				      reg->umax_value,
-				      zero_size_allowed, meta);
+				      access_flags, meta);
 	if (!err)
 		err = mark_chain_precision(env, regno);
 	return err;
@@ -7604,11 +7608,11 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 		mark_ptr_not_null_reg(reg);
 	}
 
-	err = check_helper_mem_access(env, regno, mem_size, true, &meta);
+	err = check_helper_mem_access(env, regno, mem_size, ACCESS_F_ZERO_SIZE_ALLOWED, &meta);
 	/* Check access for BPF_WRITE */
 	meta.raw_mode = true;
-	err = err ?: check_helper_mem_access(env, regno, mem_size, true, &meta);
-
+	err = err ?: check_helper_mem_access(env, regno, mem_size, ACCESS_F_ZERO_SIZE_ALLOWED,
+					     &meta);
 	if (may_be_null)
 		*reg = saved_reg;
 
@@ -7633,10 +7637,10 @@ static int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg
 		mark_ptr_not_null_reg(mem_reg);
 	}
 
-	err = check_mem_size_reg(env, reg, regno, true, &meta);
+	err = check_mem_size_reg(env, reg, regno, ACCESS_F_ZERO_SIZE_ALLOWED, &meta);
 	/* Check access for BPF_WRITE */
 	meta.raw_mode = true;
-	err = err ?: check_mem_size_reg(env, reg, regno, true, &meta);
+	err = err ?: check_mem_size_reg(env, reg, regno, ACCESS_F_ZERO_SIZE_ALLOWED, &meta);
 
 	if (may_be_null)
 		*mem_reg = saved_reg;
@@ -8943,7 +8947,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return -EACCES;
 		}
 		err = check_helper_mem_access(env, regno,
-					      meta->map_ptr->key_size, false,
+					      meta->map_ptr->key_size, 0,
 					      NULL);
 		break;
 	case ARG_PTR_TO_MAP_VALUE:
@@ -8960,7 +8964,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		}
 		meta->raw_mode = arg_type & MEM_UNINIT;
 		err = check_helper_mem_access(env, regno,
-					      meta->map_ptr->value_size, false,
+					      meta->map_ptr->value_size, 0,
 					      meta);
 		break;
 	case ARG_PTR_TO_PERCPU_BTF_ID:
@@ -9003,7 +9007,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		 */
 		meta->raw_mode = arg_type & MEM_UNINIT;
 		if (arg_type & MEM_FIXED_SIZE) {
-			err = check_helper_mem_access(env, regno, fn->arg_size[arg], false, meta);
+			err = check_helper_mem_access(env, regno,
+						      fn->arg_size[arg], 0,
+						      meta);
 			if (err)
 				return err;
 			if (arg_type & MEM_ALIGNED)
@@ -9011,10 +9017,10 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		}
 		break;
 	case ARG_CONST_SIZE:
-		err = check_mem_size_reg(env, reg, regno, false, meta);
+		err = check_mem_size_reg(env, reg, regno, 0, meta);
 		break;
 	case ARG_CONST_SIZE_OR_ZERO:
-		err = check_mem_size_reg(env, reg, regno, true, meta);
+		err = check_mem_size_reg(env, reg, regno, ACCESS_F_ZERO_SIZE_ALLOWED, meta);
 		break;
 	case ARG_PTR_TO_DYNPTR:
 		err = process_dynptr_func(env, regno, insn_idx, arg_type, 0);
-- 
2.44.0


