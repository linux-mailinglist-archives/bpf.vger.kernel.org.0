Return-Path: <bpf+bounces-68847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F8FB86843
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 20:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580A51658E8
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 18:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2042D9491;
	Thu, 18 Sep 2025 18:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1uA2Qb+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F8D2D7DE5
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221296; cv=none; b=giCjP6ZJnjmVCiFfsw6AEzI3mo5jdgHYFBNdY8SIB1sipwwjnSun1Kmjtmz4zQJLEg97IoNOPHgtk405IeVfBMLSv+4OLFjkIVJIfn0E33ixz5aFuJBmCLaFucxsSq76/sNEsFgaUdnI9M/qXDQJp1L1z7MQU5E83L7wwYqw1cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221296; c=relaxed/simple;
	bh=zipibxK7e8E7AqJeGeeuzWI18TE4T0i6q2+SMqvqjhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQJbTs9Lk2xN8RhiqEOIz3wqC1dMp1a88FptAvHl2UI7cHceTis1Rae5St3xYRKSLaa+E/MUjjWiReSoXTV8tFjU47mOx/RlGxvMyP+JhfJ9jkbAy6voQxwsZv+KYBoNC9MSKxT6NUTnsKjiwjllBQx7mdOt+C+xQaVqY28LIkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1uA2Qb+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-267f0fe72a1so8283305ad.2
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 11:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758221293; x=1758826093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7zdTirwgqxNkjl7hXobC5v9YYqVcoI9+xqJRxYIjWg=;
        b=c1uA2Qb+SdEJcqKk/Zj+2vePh5QBHS+ibwlMTdxZeFqIa08xzImb/Ogy9duPXlQFVC
         o0DmtkK3E2IRulXfkQvTEYSjYppQH6iGo2hHQHcjQ6vI55DkRPHVmvQcjSN5vjQBGw4Y
         Wi6LF4SxYalYbXgRQhfTI1uXeky+k7fJoj1tTxMofol+3fpmAoeDV0IziluTXlDx4uAy
         bibdkzzBKHUu/cfSI/zT5anPi+CKK+EACAZqZ78/VOOxRYueeaYTbTcjztwjQRbHXLUi
         NpuphSzpcQTMQP8O3csh94AYSERaqpcdDC3G3CdiH4voVHARke0MF8HBmavWrMZWBWE7
         0yGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758221293; x=1758826093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7zdTirwgqxNkjl7hXobC5v9YYqVcoI9+xqJRxYIjWg=;
        b=a3pjdElhHqhjS8ladPiY2zDfN5Wl174mx/saVSuyV8Z/6W91eXjH1qu3dVOiAiRU+Q
         g/L66GbLRsmAW3nFJnqacxsaIr4swzvjbBg68QqdIqxCYvvu7ViyvrNrzUP0pJzUxrCg
         mvvE1fUyMAi+0hUs+VAfzZDaSCgIuLAJujM1zJEweJd7a2ajUNxt0DQcDZAqLtIMzW8h
         4vgkTkgKys4MQIMTzN90lsw7shXSIGjp1piKSGD3YWN+Pz8Tazj0/fuSe7yukR2r+SaD
         9seOGAfb8vsQqmHxqfcyYECilWUyIgIVXxa+2I/v/+d8CRWD7wLS6zc1CpkfG+ZQ5uFm
         vdyg==
X-Gm-Message-State: AOJu0YyK7NBbSjeGUgk3Es6zlig1g3aviHtNrdrlKjCHKleScMKZba9Q
	JgZ3FyHRP6GrCZO7mH44viglUnFggljcGVv4ZTk6W3eouPXPyxfKrtnO/FD3lWAw
X-Gm-Gg: ASbGncsoPrMtSwYSNLzfe8mz0HghqOdS/2m7XIt6l8MglIUm/EmNlCAs0wwCTb5gTCB
	/s7v26coa4MlxmWyMaWbHsMtAiLoTYljGQ7NxUrH16RDQBE/SKCrZEcIWtn/5bnApFi2xKJVErr
	djyD/0+Qx5EegVS0z+6lS3MpzzIAe5M0UvpoAfTtjI1IIL+FCQ2vb33zK/eRC3Rwfm1PWZqfgfw
	3DkrSIwyS7Dp6hvlAZnA177Sb3JMUUmvxa7lgWRaI4m+LLDTEceypwTMi5gUEHiyPLRaU7n5yZn
	NsewC7cueyI3BOyywUNG7ymrPPlh0IniDU1N5gStvgPv4SkBR0EwGbBnvhZPUH6KRW6s0f0TVor
	jTN1IXVbS4d805+N+6HBtR4Df+xfSjQu4fVA=
X-Google-Smtp-Source: AGHT+IF7JbQH2BIjmlSPEzaNmmSBG0LZULKO1a3VeYi7EW/gzE8MGAIhgeE+XvGpjqgiQ9b4C40NuQ==
X-Received: by 2002:a17:903:950:b0:25b:ee2b:da92 with SMTP id d9443c01a7336-269ba4f01f4mr8192935ad.39.1758221293292;
        Thu, 18 Sep 2025 11:48:13 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e00b3sm32361505ad.90.2025.09.18.11.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 11:48:13 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 10/12] bpf: table based bpf_insn_successors()
Date: Thu, 18 Sep 2025 11:47:39 -0700
Message-ID: <20250918-callchain-sensitive-liveness-v2-10-214ed2653eee@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918-callchain-sensitive-liveness-v2-0-214ed2653eee@gmail.com>
References: <20250918-callchain-sensitive-liveness-v2-0-214ed2653eee@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
 kernel/bpf/liveness.c        | 51 +++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        | 72 +-------------------------------------------
 3 files changed, 53 insertions(+), 71 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c7515da8500c56d9e6152657a00eb4fd76477856..4c497e839526a40a66c0c9f1054c19763ac9d41a 100644
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
index 6f9dfaaf6e64faeaee074926be7fcdaa57b22bc3..81ba7cd5d747f5a257f4bc97753cfe489a7526a4 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -433,6 +433,57 @@ static void log_mask_change(struct bpf_verifier_env *env, struct callchain *call
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
index 933f59166f4381bf9fb2bfdea5793c64c1d5638e..ae021c8af4ec2442c47537e7dcbf3f963f04e624 100644
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
@@ -23913,67 +23904,6 @@ static int process_fd_array(struct bpf_verifier_env *env, union bpf_attr *attr,
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
2.51.0

