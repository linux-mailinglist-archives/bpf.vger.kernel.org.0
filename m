Return-Path: <bpf+bounces-68073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45526B52577
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 03:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A3C580AEE
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 01:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126BC189906;
	Thu, 11 Sep 2025 01:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCg3KTOk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069C91DF25C
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 01:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757552703; cv=none; b=rlZO03gyZHSgipqffLr3Q524MrzTZrZWe9YnP9yHecEsZSBThFoCBPGlE2MBx0qD+93zT5VhYd7NfYZV3wR1NmYVyeJ6dMRJvXCBN6rI88aHvvgu8QKfrDjeSeAbxsxxz0evDHZezp5FG2fq0GVCceynestLdS5aEEJ3UOk+UzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757552703; c=relaxed/simple;
	bh=qC9RfOXac8uwdLfPF9v9VhEzw3X+ZvgYG5+/AuvierI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+IX4WADMUKKPmABdqNayUI06xf4VDtZ9f3zCgJUqMorGPclXlHCVW1oDLfCwrXRqgihrfWmX4XemQTK2VlZfq2wYql0CJ477wn0js7w9aQaqiBbQlpcljenyFEdYKGi7Nvcfm+ikOB1hmxRmO94hVeYRbOO+7upZ+v9kyLLLXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCg3KTOk; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-323266cdf64so123689a91.0
        for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 18:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757552701; x=1758157501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OoSq8o9ZUaXHisM0ZuJw1hWdgl2/E9/KXCMMZmDSuLE=;
        b=NCg3KTOk1/cBCr0Qy/OP0cDeGJLwdBAi8syWwP37xUa21lJgJnR7G8atTSOr6LwIf/
         EL+t89LAzmul2f17pXdG4+OtQdt4TlRqJZ314wUY6LiMaemtMKNskHU/A5QJ1oY7M9ei
         CI6hV/5xyCqYBiLr1VAtL/cf+SbuxeQW1d9/yiemKvBPX2DRNtOQIoSyUmmCnwih2T4s
         oEDZ0sWr3azWqWj9hYLPqyVH1/uXA+wZpkEBQ5QNnzRqqkHCreI3FLgL6gmab9lszoSC
         qG7Yvf09NoOQ9Xo+y+gjGQ98sSOVbkZoN92UtBYNJPSfAgSBv6fxFKgHZ1XSvq5ofwKe
         ofPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757552701; x=1758157501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OoSq8o9ZUaXHisM0ZuJw1hWdgl2/E9/KXCMMZmDSuLE=;
        b=aJq16oASQiFa9XnS9fBSyfML1uPcqTQogweK1yzemgNjzUb2CRfDaCB+VY96RgqYQL
         9U975VQq++qR4zSGDAmFQ0DHNX2cis/5y6OubU0gZvIKu/A04IQaoPC+uCMpwMrynDT6
         rTA+Lq6O+rgJ/qIQ4oszlKhLxGICJIbgvh8d3pLNedJMiPdqKsRzKTEdw2KQ1Svyga3u
         IAmsZeZyrnveevhLnHsNlEPpBwEJpdrDX0d4r1xwN1kWzDrTYmryZZFbs/BL6MfMNThj
         N/c7yuZJNN7WXLNGCits0nY1Ja5t0qrwc5krC405DvQS0jw/XCuD470k5U1U9VfhiDxv
         jP/w==
X-Gm-Message-State: AOJu0Yw1yUhn25C7uBHG8ShEd23LC1pmECRebm9ogrKQKIyjPdA8BpOT
	8NUET0kX9MZJ9FWGrAmOsJpQ0eVuVqWlcbWpvXetlUO8wgbg4JYUz+Pk4nIkHQ==
X-Gm-Gg: ASbGncvq1y5kQTbLHCwPB+NrZl7o++Qyc79qQafTxJFcxLViTSSv/It8GGdEGZiIn92
	jA+Bbpix8WGehCxPKcylBzA2eCScm6XBN3fYal92a3coyFQZvBsfv02WggfI+MdMVP06niQ1GaU
	k+mcd5DDAO/EesY2FNtVggiYXzx5UjpTtz+VXWp2f6qVyRThVcHckL6DdfEg/JyBCuc4Ov/RixA
	hcEwecLYcCpLQo521m6ScVJBVcbpCSijNi6BLzofZloL2PDTIGDcvam9bky7aUR1SF7xHjkiDBH
	Gxr/LoH7GytEWdWBl3RHJCCZf8DnWTZkop9oJpxBQR/lTmiA47a85zfbmsQfsE7NoJqUR3w8HEf
	/bM+SeT6lYvJClSyCQdOIRkR4JOE86BHYIw==
X-Google-Smtp-Source: AGHT+IEWulU3W5c4XVlOXjBG9SCJVMGVTDn7AOZXuMJGogpHeG+J70vB2jZE/th6aJqM2yI899ZTDQ==
X-Received: by 2002:a17:90a:e7cf:b0:32b:a2b9:b200 with SMTP id 98e67ed59e1d1-32d43f0501bmr20767951a91.13.1757552700829;
        Wed, 10 Sep 2025 18:05:00 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd61eaa27sm545511a91.1.2025.09.10.18.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 18:05:00 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v1 10/10] bpf: table based bpf_insn_successors()
Date: Wed, 10 Sep 2025 18:04:35 -0700
Message-ID: <20250911010437.2779173-11-eddyz87@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911010437.2779173-1-eddyz87@gmail.com>
References: <20250911010437.2779173-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Converting bpf_insn_successors() to use lookup table makes it ~1.5
times faster.

Also remove unnecessary conditionals:
- `idx + 1 < prog->len` is unnecessary because after check_cfg() all
  jump targets are guaranteed to be within a program;
- `i == 0 || succ[0] != dst` is unnecessary because any client of
  bpf_insn_successors() can handle duplicate edges:
  - compute_live_registers()
  - compute_scc()

Moving bpf_insn_successors() to liveness.c allows its inlining in
liveness.c:__update_stack_liveness().
Such inlining speeds up __update_stack_liveness() by ~40%.
bpf_insn_successors() is used in both verifier.c and liveness.c.
perf shows such move does not negatively impact users in verifier.c,
as these are executed only once before main varification pass.
Unlike __update_stack_liveness() which can be triggered multiple
times.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/liveness.c        | 51 +++++++++++++++++++++++++
 kernel/bpf/verifier.c        | 72 +-----------------------------------
 3 files changed, 53 insertions(+), 71 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c7515da8500c..4c497e839526 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1049,6 +1049,7 @@ void print_insn_state(struct bpf_verifier_env *env, const struct bpf_verifier_st
 		      u32 frameno);
 
 struct bpf_subprog_info *bpf_find_containing_subprog(struct bpf_verifier_env *env, int off);
+int bpf_jmp_offset(struct bpf_insn *insn);
 int bpf_insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2]);
 void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
 bool bpf_calls_callback(struct bpf_verifier_env *env, int insn_idx);
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 2b2e909ec944..6fb79a63d216 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -428,6 +428,57 @@ static void log_mask_change(struct bpf_verifier_env *env, struct callchain *call
 	bpf_log(&env->log, "\n");
 }
 
+int bpf_jmp_offset(struct bpf_insn *insn)
+{
+	u8 code = insn->code;
+
+	if (code == (BPF_JMP32 | BPF_JA))
+		return insn->imm;
+	return insn->off;
+}
+
+inline int bpf_insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2])
+{
+	static const struct opcode_info {
+		bool can_jump;
+		bool can_fallthrough;
+	} opcode_info_tbl[256] = {
+		[0 ... 255] = {.can_jump = false, .can_fallthrough = true},
+	#define _J(code, ...) \
+		[BPF_JMP   | code] = __VA_ARGS__, \
+		[BPF_JMP32 | code] = __VA_ARGS__
+
+		_J(BPF_EXIT,  {.can_jump = false, .can_fallthrough = false}),
+		_J(BPF_JA,    {.can_jump = true,  .can_fallthrough = false}),
+		_J(BPF_JEQ,   {.can_jump = true,  .can_fallthrough = true}),
+		_J(BPF_JNE,   {.can_jump = true,  .can_fallthrough = true}),
+		_J(BPF_JLT,   {.can_jump = true,  .can_fallthrough = true}),
+		_J(BPF_JLE,   {.can_jump = true,  .can_fallthrough = true}),
+		_J(BPF_JGT,   {.can_jump = true,  .can_fallthrough = true}),
+		_J(BPF_JGE,   {.can_jump = true,  .can_fallthrough = true}),
+		_J(BPF_JSGT,  {.can_jump = true,  .can_fallthrough = true}),
+		_J(BPF_JSGE,  {.can_jump = true,  .can_fallthrough = true}),
+		_J(BPF_JSLT,  {.can_jump = true,  .can_fallthrough = true}),
+		_J(BPF_JSLE,  {.can_jump = true,  .can_fallthrough = true}),
+		_J(BPF_JCOND, {.can_jump = true,  .can_fallthrough = true}),
+		_J(BPF_JSET,  {.can_jump = true,  .can_fallthrough = true}),
+	#undef _J
+	};
+	struct bpf_insn *insn = &prog->insnsi[idx];
+	const struct opcode_info *opcode_info;
+	int i = 0, insn_sz;
+
+	opcode_info = &opcode_info_tbl[BPF_CLASS(insn->code) | BPF_OP(insn->code)];
+	insn_sz = bpf_is_ldimm64(insn) ? 2 : 1;
+	if (opcode_info->can_fallthrough)
+		succ[i++] = idx + insn_sz;
+
+	if (opcode_info->can_jump)
+		succ[i++] = idx + bpf_jmp_offset(insn) + 1;
+
+	return i;
+}
+
 static struct func_instance *get_outer_instance(struct bpf_verifier_env *env,
 						struct func_instance *instance)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6efb555a1e8a..9fd75a3e45b3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3470,15 +3470,6 @@ static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 	return 0;
 }
 
-static int jmp_offset(struct bpf_insn *insn)
-{
-	u8 code = insn->code;
-
-	if (code == (BPF_JMP32 | BPF_JA))
-		return insn->imm;
-	return insn->off;
-}
-
 static int check_subprogs(struct bpf_verifier_env *env)
 {
 	int i, subprog_start, subprog_end, off, cur_subprog = 0;
@@ -3505,7 +3496,7 @@ static int check_subprogs(struct bpf_verifier_env *env)
 			goto next;
 		if (BPF_OP(code) == BPF_EXIT || BPF_OP(code) == BPF_CALL)
 			goto next;
-		off = i + jmp_offset(&insn[i]) + 1;
+		off = i + bpf_jmp_offset(&insn[i]) + 1;
 		if (off < subprog_start || off >= subprog_end) {
 			verbose(env, "jump out of range from insn %d to %d\n", i, off);
 			return -EINVAL;
@@ -23907,67 +23898,6 @@ static int process_fd_array(struct bpf_verifier_env *env, union bpf_attr *attr,
 	return 0;
 }
 
-static bool can_fallthrough(struct bpf_insn *insn)
-{
-	u8 class = BPF_CLASS(insn->code);
-	u8 opcode = BPF_OP(insn->code);
-
-	if (class != BPF_JMP && class != BPF_JMP32)
-		return true;
-
-	if (opcode == BPF_EXIT || opcode == BPF_JA)
-		return false;
-
-	return true;
-}
-
-static bool can_jump(struct bpf_insn *insn)
-{
-	u8 class = BPF_CLASS(insn->code);
-	u8 opcode = BPF_OP(insn->code);
-
-	if (class != BPF_JMP && class != BPF_JMP32)
-		return false;
-
-	switch (opcode) {
-	case BPF_JA:
-	case BPF_JEQ:
-	case BPF_JNE:
-	case BPF_JLT:
-	case BPF_JLE:
-	case BPF_JGT:
-	case BPF_JGE:
-	case BPF_JSGT:
-	case BPF_JSGE:
-	case BPF_JSLT:
-	case BPF_JSLE:
-	case BPF_JCOND:
-	case BPF_JSET:
-		return true;
-	}
-
-	return false;
-}
-
-int bpf_insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2])
-{
-	struct bpf_insn *insn = &prog->insnsi[idx];
-	int i = 0, insn_sz;
-	u32 dst;
-
-	insn_sz = bpf_is_ldimm64(insn) ? 2 : 1;
-	if (can_fallthrough(insn) && idx + 1 < prog->len)
-		succ[i++] = idx + insn_sz;
-
-	if (can_jump(insn)) {
-		dst = idx + jmp_offset(insn) + 1;
-		if (i == 0 || succ[0] != dst)
-			succ[i++] = dst;
-	}
-
-	return i;
-}
-
 /* Each field is a register bitmask */
 struct insn_live_regs {
 	u16 use;	/* registers read by instruction */
-- 
2.47.3


