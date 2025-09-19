Return-Path: <bpf+bounces-68895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13862B87B6C
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 04:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D483BA6FB
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 02:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70C0246789;
	Fri, 19 Sep 2025 02:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akqtKJZK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850F62741A0
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 02:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248352; cv=none; b=t4XBei44eYi41ZP2e3C18zsw/tKW1Jc5moPeUWpRstACsuI6XJRc02kDjruIhOME5wukOgEmxV9aRIwsxK9Ax3BX0dcF1rx4RxxI13U3/Y8eGYlkb6lkAe0QQUp/NdYHTCjY2ll1dleEIwIKMfkQsRNTMLDTwCjhajxmIB124TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248352; c=relaxed/simple;
	bh=gl8sQFYNBqJX0EIhSnujJErNUsQbL+xQqRxwpnBG4t4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YIiH3cei6mQlVnyITAOgr36q0lzEU43XfhXPqfO7ksumBpsVXe6LMeJGsam/g93yUEdWQY1BNErRYRQd8G98MBDB+FazYeCcKk3Lu/dF8jmaZAClteTGWREwfCOT6qSSTnHfgZZJ32XvATLOxKMZrgvQCCkokAV10EPqBIAeyW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akqtKJZK; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24b13313b1bso11712025ad.2
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 19:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758248349; x=1758853149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkRXs2vLD8wdfveXvYYxqdWzYeX+8b/PIFVXhmvvASQ=;
        b=akqtKJZKVRMkUITTnovZ2qXjvS28WlKcLLHLrQ3zMRC+i8sE92A+GS6JzBGERid7Ae
         ajL+sQB6JCoXAfA189Qem/J4G/Lq7qJGATjqQQ78mEijuw5jc11HclKJdoU1w+sEgxRB
         z+CWQe8fEB71CKhgc0agWNcVkFgySmDfX/HZLpIzc5QTp8kgd2TsOBjxxTs+vJbiiFle
         kijp1ijcZ2pR/6QGn7yr4prVDzA1NfeFWdS0lWB71xneyRC9Rp9+7N+2lO+bKxOSY4I+
         8qsFYw99Rygm7Nzi7MVoB7hkVvhwntORx3l3Tkq+2K9Z+/PLuImpUUo4iaEX3YKplb6S
         1Aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758248349; x=1758853149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkRXs2vLD8wdfveXvYYxqdWzYeX+8b/PIFVXhmvvASQ=;
        b=D6UVCG/PX4K+s1CjhvlT7Jjr7nK8CwcppRMLP9cNq1wEasyHxEyCZ4GBFbdYPEH9ON
         +uwvZ3RsLG19tyROr3sklCD/v+EYZ6q3adQlefZep1+fIbzrJQyEhti+XNGe21pTDOwZ
         k3qpA98pigOCBHqlCghurysx2vabcw8m1Tp/ArVLMlNvZa1Y32sa5fSdswPdEH4s/Smu
         tObigKnbg6kvT1QhCa51aGnkfhvoolBOrO16duvurjbAX4dqcE7ok6IWM+CPQE0Q8zD9
         qkrLSL3uSucOvTi2v++kUFJbKHMFeLB3McLR/CYyipsFjK8hOZ24Ds0xqE/3/J/rcwJb
         UQKA==
X-Gm-Message-State: AOJu0Yy+kSMgc2wdPooLL2RtX8TC9rTBPSPdheCb1x1Tpsvz4WS3xP9B
	WLndvfO9wIyhlarRdqbLc8Lhf2ADHbLDXdS+gtJPOABq3pGVAK/sg9KNEvqPtA==
X-Gm-Gg: ASbGnct4akI+ghfOxjNTOOUuDJXakSdLC7V0xelsmVcZEzNa8Hh+ktHi/R/vLdQ/OXU
	rX87ufMWjjggPMYU1GIbXQ9zpeHC1SwOkYm7u+e+aZjCf3VoW4kNdMyx5hB6bflMAsfyl5uU/RS
	UAz6WdwBZSDRcOep97JNk2e3dhts93Bk1gvqTxUsYKLcUnJ5H0DSmOq/BdizWx0HpW6tHDfBsM3
	KGLS+MltUFIQeSTgIjnBF1CONSo7I9k1lNH6kifcWShd+nz/A9WKGOUDPO3MV3JphpsZPf8zvz4
	Ee6NDQzKvJqQaNB1uzt75UTCmq5Q98W6TPZfU7O+64pna/imqW9SBJ0wDQR3qo/Hzl3YrtDSVLw
	/5vLoQl1JaZQAKz3hCecT4oD10KI=
X-Google-Smtp-Source: AGHT+IFkRSXRWtXzK7nC+YZ+33NuLebGvhBObOqjTXRsaYA1WioGB5qfZFAP/jySUDxHHpk53JUyaA==
X-Received: by 2002:a17:903:2342:b0:269:8d1b:40c3 with SMTP id d9443c01a7336-269ba435239mr23141255ad.12.1758248349504;
        Thu, 18 Sep 2025 19:19:09 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033a3e5sm39186235ad.126.2025.09.18.19.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 19:19:09 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 10/12] bpf: table based bpf_insn_successors()
Date: Thu, 18 Sep 2025 19:18:43 -0700
Message-ID: <20250918-callchain-sensitive-liveness-v3-10-c3cd27bacc60@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918-callchain-sensitive-liveness-v3-0-c3cd27bacc60@gmail.com>
References: <20250918-callchain-sensitive-liveness-v3-0-c3cd27bacc60@gmail.com>
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
 kernel/bpf/liveness.c        | 56 ++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        | 72 +-------------------------------------------
 3 files changed, 58 insertions(+), 71 deletions(-)

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
index 6f9dfaaf6e64faeaee074926be7fcdaa57b22bc3..3c611aba7f52c541408627b780ea664776145e8b 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -433,6 +433,62 @@ static void log_mask_change(struct bpf_verifier_env *env, struct callchain *call
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
+__diag_push();
+__diag_ignore_all("-Woverride-init", "Allow field initialization overrides for opcode_info_tbl");
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
+__diag_pop();
+
 static struct func_instance *get_outer_instance(struct bpf_verifier_env *env,
 						struct func_instance *instance)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c2a4007e3027b21067f85983debb6733a801b3ee..bcb80c865cac99511935a76231596669c4cce6e4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3485,15 +3485,6 @@ static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
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
@@ -3520,7 +3511,7 @@ static int check_subprogs(struct bpf_verifier_env *env)
 			goto next;
 		if (BPF_OP(code) == BPF_EXIT || BPF_OP(code) == BPF_CALL)
 			goto next;
-		off = i + jmp_offset(&insn[i]) + 1;
+		off = i + bpf_jmp_offset(&insn[i]) + 1;
 		if (off < subprog_start || off >= subprog_end) {
 			verbose(env, "jump out of range from insn %d to %d\n", i, off);
 			return -EINVAL;
@@ -23938,67 +23929,6 @@ static int process_fd_array(struct bpf_verifier_env *env, union bpf_attr *attr,
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

