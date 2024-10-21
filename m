Return-Path: <bpf+bounces-42651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 532E19A6E1B
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 17:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7E1B1F242DB
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 15:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7180C13B280;
	Mon, 21 Oct 2024 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="JgOCTK5r"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D746137750
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524495; cv=none; b=lWH5txw+KsxG3SeSNsmPTIy25k0aqaz3z+jcjImaU+N3VDbRe3jI1WsrbdeNzIzRrjhzQALHtobYjHOkS8VzVc+wNYlUPapyKQgo2R04ROgln+4KthJa8HmiKlIaKJLnKC617AzBgi90wa+s6S9rHLJuLvFhBNmqspRD9KbPvt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524495; c=relaxed/simple;
	bh=qS2blDBCidHfF25zE4Okbk7nkxt7rihq51+BB3DjzUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hj2WcD1+ZC4pvJHG6lieMpUAVy38R6JyLQW7HgvvtFtQnV8rvCWkpg2EDHUHprxXkyCmwZxleqIOOToy95KTQz9AeFVFIVw7CH020him/PQUb2cIqZ5tLZu0ZAc2b9d8yV/GaUGfoSPktDX9kA/LU3ITkBW7cfzTO7TaSHWnHFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=JgOCTK5r; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=r0txAYb/0ccFJPJzeRuQUfTEMyLoFjbDrhnAwd1k4MM=; b=JgOCTK5rw4wFFqIECyE2ni+a8K
	F2H3cR6h6+VNBFy1qkD2P60gtqryOrZfgD/wxXwvR4j8VMghUtDKZTENJ0ARwrvpjX1cs6BZvFs01
	QNmHBWTN26wo/vYycGU4cF8Yj+4iMXamBKZTozEIgIw60NejC7ND0ik8YZlbWn8b2JIBE2dPI2ejL
	bdQiD0YZ0dUTfkOQTYZWzJDeLU9eMX5mep6Y8DWaJQNC6mAHHYd1M+BooJWHWvqaK41XHiI7F8V8e
	4SGD/LQe1chi0tQJCgWoQrdsiyWuAcoNICox+mTsj/3p3IHwo/iLVHkC+ZTCUfQueMJ3Utz12lGWP
	Mx4yDBZw==;
Received: from 43.248.197.178.dynamic.cust.swisscom.net ([178.197.248.43] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1t2uKI-000Myy-JG; Mon, 21 Oct 2024 17:28:10 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: andrii@kernel.org,
	kongln9170@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf 2/5] bpf: Fix overloading of MEM_UNINIT's meaning
Date: Mon, 21 Oct 2024 17:28:06 +0200
Message-Id: <20241021152809.33343-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021152809.33343-1-daniel@iogearbox.net>
References: <20241021152809.33343-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27434/Mon Oct 21 10:49:31 2024)

Lonial reported an issue in the BPF verifier where check_mem_size_reg()
has the following code:

    if (!tnum_is_const(reg->var_off))
        /* For unprivileged variable accesses, disable raw
         * mode so that the program is required to
         * initialize all the memory that the helper could
         * just partially fill up.
         */
         meta = NULL;

This means that writes are not checked when the register containing the
size of the passed buffer has not a fixed size. Through this bug, a BPF
program can write to a map which is marked as read-only, for example,
.rodata global maps.

The problem is that MEM_UNINIT's initial meaning that "the passed buffer
to the BPF helper does not need to be initialized" which was added back
in commit 435faee1aae9 ("bpf, verifier: add ARG_PTR_TO_RAW_STACK type")
got overloaded over time with "the passed buffer is being written to".

The problem however is that checks such as the above which were added later
via 06c1c049721a ("bpf: allow helpers access to variable memory") set meta
to NULL in order force the user to always initialize the passed buffer to
the helper. Due to the current double meaning of MEM_UNINIT, this bypasses
verifier write checks to the memory (not boundary checks though) and only
assumes the latter memory is read instead.

Fix this by reverting MEM_UNINIT back to its original meaning, and having
MEM_WRITE as an annotation to BPF helpers in order to then trigger the
BPF verifier checks for writing to memory.

Some notes: check_arg_pair_ok() ensures that for ARG_CONST_SIZE{,_OR_ZERO}
we can access fn->arg_type[arg - 1] since it must contain a preceding
ARG_PTR_TO_MEM. For check_mem_reg() the meta argument can be removed
altogether since we do check both BPF_READ and BPF_WRITE. Same for the
equivalent check_kfunc_mem_size_reg().

Fixes: 7b3552d3f9f6 ("bpf: Reject writes for PTR_TO_MAP_KEY in check_helper_mem_access")
Fixes: 97e6d7dab1ca ("bpf: Check PTR_TO_MEM | MEM_RDONLY in check_helper_mem_access")
Fixes: 15baa55ff5b0 ("bpf/verifier: allow all functions to read user provided context")
Reported-by: Lonial Con <kongln9170@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c | 73 +++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 38 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 434de48cd24b..98d4e1aab624 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7432,7 +7432,8 @@ static int check_stack_range_initialized(
 }
 
 static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
-				   int access_size, bool zero_size_allowed,
+				   int access_size, enum bpf_access_type access_type,
+				   bool zero_size_allowed,
 				   struct bpf_call_arg_meta *meta)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
@@ -7444,7 +7445,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 		return check_packet_access(env, regno, reg->off, access_size,
 					   zero_size_allowed);
 	case PTR_TO_MAP_KEY:
-		if (meta && meta->raw_mode) {
+		if (access_type == BPF_WRITE) {
 			verbose(env, "R%d cannot write into %s\n", regno,
 				reg_type_str(env, reg->type));
 			return -EACCES;
@@ -7452,15 +7453,13 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 		return check_mem_region_access(env, regno, reg->off, access_size,
 					       reg->map_ptr->key_size, false);
 	case PTR_TO_MAP_VALUE:
-		if (check_map_access_type(env, regno, reg->off, access_size,
-					  meta && meta->raw_mode ? BPF_WRITE :
-					  BPF_READ))
+		if (check_map_access_type(env, regno, reg->off, access_size, access_type))
 			return -EACCES;
 		return check_map_access(env, regno, reg->off, access_size,
 					zero_size_allowed, ACCESS_HELPER);
 	case PTR_TO_MEM:
 		if (type_is_rdonly_mem(reg->type)) {
-			if (meta && meta->raw_mode) {
+			if (access_type == BPF_WRITE) {
 				verbose(env, "R%d cannot write into %s\n", regno,
 					reg_type_str(env, reg->type));
 				return -EACCES;
@@ -7471,7 +7470,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 					       zero_size_allowed);
 	case PTR_TO_BUF:
 		if (type_is_rdonly_mem(reg->type)) {
-			if (meta && meta->raw_mode) {
+			if (access_type == BPF_WRITE) {
 				verbose(env, "R%d cannot write into %s\n", regno,
 					reg_type_str(env, reg->type));
 				return -EACCES;
@@ -7499,7 +7498,6 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 		 * Dynamically check it now.
 		 */
 		if (!env->ops->convert_ctx_access) {
-			enum bpf_access_type atype = meta && meta->raw_mode ? BPF_WRITE : BPF_READ;
 			int offset = access_size - 1;
 
 			/* Allow zero-byte read from PTR_TO_CTX */
@@ -7507,7 +7505,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 				return zero_size_allowed ? 0 : -EACCES;
 
 			return check_mem_access(env, env->insn_idx, regno, offset, BPF_B,
-						atype, -1, false, false);
+						access_type, -1, false, false);
 		}
 
 		fallthrough;
@@ -7532,6 +7530,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
  */
 static int check_mem_size_reg(struct bpf_verifier_env *env,
 			      struct bpf_reg_state *reg, u32 regno,
+			      enum bpf_access_type access_type,
 			      bool zero_size_allowed,
 			      struct bpf_call_arg_meta *meta)
 {
@@ -7547,15 +7546,12 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 	 */
 	meta->msize_max_value = reg->umax_value;
 
-	/* The register is SCALAR_VALUE; the access check
-	 * happens using its boundaries.
+	/* The register is SCALAR_VALUE; the access check happens using
+	 * its boundaries. For unprivileged variable accesses, disable
+	 * raw mode so that the program is required to initialize all
+	 * the memory that the helper could just partially fill up.
 	 */
 	if (!tnum_is_const(reg->var_off))
-		/* For unprivileged variable accesses, disable raw
-		 * mode so that the program is required to
-		 * initialize all the memory that the helper could
-		 * just partially fill up.
-		 */
 		meta = NULL;
 
 	if (reg->smin_value < 0) {
@@ -7575,9 +7571,8 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 			regno);
 		return -EACCES;
 	}
-	err = check_helper_mem_access(env, regno - 1,
-				      reg->umax_value,
-				      zero_size_allowed, meta);
+	err = check_helper_mem_access(env, regno - 1, reg->umax_value,
+				      access_type, zero_size_allowed, meta);
 	if (!err)
 		err = mark_chain_precision(env, regno);
 	return err;
@@ -7588,13 +7583,11 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 {
 	bool may_be_null = type_may_be_null(reg->type);
 	struct bpf_reg_state saved_reg;
-	struct bpf_call_arg_meta meta;
 	int err;
 
 	if (register_is_null(reg))
 		return 0;
 
-	memset(&meta, 0, sizeof(meta));
 	/* Assuming that the register contains a value check if the memory
 	 * access is safe. Temporarily save and restore the register's state as
 	 * the conversion shouldn't be visible to a caller.
@@ -7604,10 +7597,8 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 		mark_ptr_not_null_reg(reg);
 	}
 
-	err = check_helper_mem_access(env, regno, mem_size, true, &meta);
-	/* Check access for BPF_WRITE */
-	meta.raw_mode = true;
-	err = err ?: check_helper_mem_access(env, regno, mem_size, true, &meta);
+	err = check_helper_mem_access(env, regno, mem_size, BPF_READ, true, NULL);
+	err = err ?: check_helper_mem_access(env, regno, mem_size, BPF_WRITE, true, NULL);
 
 	if (may_be_null)
 		*reg = saved_reg;
@@ -7633,13 +7624,12 @@ static int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg
 		mark_ptr_not_null_reg(mem_reg);
 	}
 
-	err = check_mem_size_reg(env, reg, regno, true, &meta);
-	/* Check access for BPF_WRITE */
-	meta.raw_mode = true;
-	err = err ?: check_mem_size_reg(env, reg, regno, true, &meta);
+	err = check_mem_size_reg(env, reg, regno, BPF_READ, true, &meta);
+	err = err ?: check_mem_size_reg(env, reg, regno, BPF_WRITE, true, &meta);
 
 	if (may_be_null)
 		*mem_reg = saved_reg;
+
 	return err;
 }
 
@@ -8942,9 +8932,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			verbose(env, "invalid map_ptr to access map->key\n");
 			return -EACCES;
 		}
-		err = check_helper_mem_access(env, regno,
-					      meta->map_ptr->key_size, false,
-					      NULL);
+		err = check_helper_mem_access(env, regno, meta->map_ptr->key_size,
+					      BPF_READ, false, NULL);
 		break;
 	case ARG_PTR_TO_MAP_VALUE:
 		if (type_may_be_null(arg_type) && register_is_null(reg))
@@ -8959,9 +8948,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return -EACCES;
 		}
 		meta->raw_mode = arg_type & MEM_UNINIT;
-		err = check_helper_mem_access(env, regno,
-					      meta->map_ptr->value_size, false,
-					      meta);
+		err = check_helper_mem_access(env, regno, meta->map_ptr->value_size,
+					      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
+					      false, meta);
 		break;
 	case ARG_PTR_TO_PERCPU_BTF_ID:
 		if (!reg->btf_id) {
@@ -9003,7 +8992,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		 */
 		meta->raw_mode = arg_type & MEM_UNINIT;
 		if (arg_type & MEM_FIXED_SIZE) {
-			err = check_helper_mem_access(env, regno, fn->arg_size[arg], false, meta);
+			err = check_helper_mem_access(env, regno, fn->arg_size[arg],
+						      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
+						      false, meta);
 			if (err)
 				return err;
 			if (arg_type & MEM_ALIGNED)
@@ -9011,10 +9002,16 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		}
 		break;
 	case ARG_CONST_SIZE:
-		err = check_mem_size_reg(env, reg, regno, false, meta);
+		err = check_mem_size_reg(env, reg, regno,
+					 fn->arg_type[arg - 1] & MEM_WRITE ?
+					 BPF_WRITE : BPF_READ,
+					 false, meta);
 		break;
 	case ARG_CONST_SIZE_OR_ZERO:
-		err = check_mem_size_reg(env, reg, regno, true, meta);
+		err = check_mem_size_reg(env, reg, regno,
+					 fn->arg_type[arg - 1] & MEM_WRITE ?
+					 BPF_WRITE : BPF_READ,
+					 true, meta);
 		break;
 	case ARG_PTR_TO_DYNPTR:
 		err = process_dynptr_func(env, regno, insn_idx, arg_type, 0);
-- 
2.43.0


