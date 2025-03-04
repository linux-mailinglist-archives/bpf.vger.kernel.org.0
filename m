Return-Path: <bpf+bounces-53167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68739A4D537
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 08:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38EB1170E69
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 07:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BE513C67C;
	Tue,  4 Mar 2025 07:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3sd9ITz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB7C1F9A83
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 07:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074221; cv=none; b=VQoue4nhha03GuJKJtFqRp+e3erqZVlaXDexB2FaxShtH7ZuHb2UXBfwyvXbKO3BvnV6I1CrrZMBfoVdCflLmL30caE6S5vdrSEWff5RzhRgcJo5yfcgiU/Bsx465dxKj1qyg8PWJ6Rhm4XaGGwVle6ZnGSYTIXsQALbE7X/DAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074221; c=relaxed/simple;
	bh=G9kwgp1XYHzwS4zv9hmeFHnK+OlbyYCUY0IKzyg1f9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0mjV+20L0q8seDh/xOex5rNQGoEc/PSd0a6Lk3ISW13xzb/uf02+2OKN7JDmVAh2EUimUeINM3E21V3DkVhftVId54D5bgxdvVj6OjgHzQzDKElaxiv1KWgy6GZz3A1ZTOCHSlT1CM+KopQagJDQ/zSPQlzc/LloOtDyJlHZCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3sd9ITz; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fef5c978ccso3275974a91.1
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 23:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741074219; x=1741679019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUKUKmhVLNzAt9Oxo2/kipJeEcV/Mmy5AU+trlWFn+c=;
        b=R3sd9ITz1mzQZ4GZAS8aGIPE7TMr/2mY2DAj2Zn8OCzyBemNQl5ij1LnjpDDsuIDbp
         TMnF+N9b3Kr2ZIESa8MTWnxwuDlbRmXQ9KnFqE9+EPa320qu75BDttahJM4RK30FgE6F
         1YlBn2GBpLwdfzUGrPT2fgg/WeYYfa2Gij56BLBA0mM5HN+aRHwFw0BjDDqjpk19sHEX
         MscK7rGM6X4UingvqDbipUsjUvysaRv2GzZJA7CvQxZQJ17jsfD/IPbjsDTcLM/b1zQH
         +qNXD+apF1NG6XbZLiz545MPaUvxiCcXUsZbHyFzQ+wBXEVOieIx5/kvkrsY4Lp3kOHF
         t/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741074219; x=1741679019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUKUKmhVLNzAt9Oxo2/kipJeEcV/Mmy5AU+trlWFn+c=;
        b=Ot98+VXYP6Bsq3INcTZ9JvC0G3DNEhAprj2/pRme0f6mnUtrtJDepf1QstkqasFFcV
         fkhBePRzx4MgKIz0P1mJcvQwPxqDDuGjJR358iEP6hbLsBqtqCckNVIPRmskxQ7LkIBE
         TmozQc5hvSxI7f5oY4ioAwVGzJ0AeMZZtxeC03j2qa9ifNABWgk509+iXu+zwQc3NwBk
         81sPJebLv4nZqrZiYcpcXkD3Mruz8AXfeiudqjvYKE3f+12XbvuD+mmxwOlrMQXNcy33
         6B003pqQwtER5YBBnLk4zlF2CVqMg0phDN0WOElwwyYKya7XJnYdweO88MYxK3Bcx3E+
         MUhA==
X-Gm-Message-State: AOJu0YzVSpkzHpGG28+UaiZ2atAGTg9V/yA/aY03tghUgkyH2IzkRlNa
	5FHAJkqTxKGSG5PPOSJFs7racGtVHsYFkaqC+I8mAYC5FnSwu2hfibeVxQ==
X-Gm-Gg: ASbGncvJjEUG4diUMGDHMGonR33knICyTg6aJtQ2zaV4bAIdbiXC3U9wQwgSDT3dwM3
	t+Hp/eE2HSEvVFARtVkOwJ+BPkpCjMQB4i2Eyl9c/MsGEBEerp8jgxuD0DWN3s9cM5ITVkXonZU
	VBPqFpapjSH+tfv0huM+r4sVrCS58+TCUn06lkvRhb7ohor1n/7ZuMv/eFpsJMqnn4JZsWvuqjZ
	pKA8kD/Cs8uyUFiE1mDuwqm6/1ig+bYWzB49XJBFCYEo61wneoaoUQcLrjbWB6lSC4KpNRc3b4R
	njJLY868k/RTdZHJqUgfV733NTYpaOJPmU432K5u
X-Google-Smtp-Source: AGHT+IE+L2ZQ7KB+sInMsg2+47Q3R8k0qD6ZbExFkN1u2/MxJvhvAXELx4iUgF3JU3fkSgZNP4thOQ==
X-Received: by 2002:a17:90b:3f50:b0:2ee:af31:a7bd with SMTP id 98e67ed59e1d1-2febab2bdcbmr23299422a91.5.1741074218831;
        Mon, 03 Mar 2025 23:43:38 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235050d7c1sm89545125ad.198.2025.03.03.23.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 23:43:38 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 1/5] bpf: jmp_offset() and verbose_insn() utility functions
Date: Mon,  3 Mar 2025 23:42:35 -0800
Message-ID: <20250304074239.2328752-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304074239.2328752-1-eddyz87@gmail.com>
References: <20250304074239.2328752-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract two utility functions:
- One BPF jump instruction uses .imm field to encode jump offset,
  while the rest use .off. Encapsulate this detail as jmp_offset()
  function.
- Avoid duplicating instruction printing callback definitions by
  defining a verbose_insn() function, which disassembles an
  instruction into the verifier log while hiding this detail.

These functions will be used in the next patch.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b6664d0f6914..25910b740bbc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3360,6 +3360,15 @@ static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 	return 0;
 }
 
+static int jmp_offset(struct bpf_insn *insn)
+{
+	u8 code = insn->code;
+
+	if (code == (BPF_JMP32 | BPF_JA))
+		return insn->imm;
+	return insn->off;
+}
+
 static int check_subprogs(struct bpf_verifier_env *env)
 {
 	int i, subprog_start, subprog_end, off, cur_subprog = 0;
@@ -3386,10 +3395,7 @@ static int check_subprogs(struct bpf_verifier_env *env)
 			goto next;
 		if (BPF_OP(code) == BPF_EXIT || BPF_OP(code) == BPF_CALL)
 			goto next;
-		if (code == (BPF_JMP32 | BPF_JA))
-			off = i + insn[i].imm + 1;
-		else
-			off = i + insn[i].off + 1;
+		off = i + jmp_offset(&insn[i]) + 1;
 		if (off < subprog_start || off >= subprog_end) {
 			verbose(env, "jump out of range from insn %d to %d\n", i, off);
 			return -EINVAL;
@@ -3919,6 +3925,17 @@ static const char *disasm_kfunc_name(void *data, const struct bpf_insn *insn)
 	return btf_name_by_offset(desc_btf, func->name_off);
 }
 
+static void verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *insn)
+{
+	const struct bpf_insn_cbs cbs = {
+		.cb_call	= disasm_kfunc_name,
+		.cb_print	= verbose,
+		.private_data	= env,
+	};
+
+	print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
+}
+
 static inline void bt_init(struct backtrack_state *bt, u32 frame)
 {
 	bt->frame = frame;
@@ -4119,11 +4136,6 @@ static bool calls_callback(struct bpf_verifier_env *env, int insn_idx);
 static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			  struct bpf_insn_hist_entry *hist, struct backtrack_state *bt)
 {
-	const struct bpf_insn_cbs cbs = {
-		.cb_call	= disasm_kfunc_name,
-		.cb_print	= verbose,
-		.private_data	= env,
-	};
 	struct bpf_insn *insn = env->prog->insnsi + idx;
 	u8 class = BPF_CLASS(insn->code);
 	u8 opcode = BPF_OP(insn->code);
@@ -4141,7 +4153,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 		fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN, bt_stack_mask(bt));
 		verbose(env, "stack=%s before ", env->tmp_str_buf);
 		verbose(env, "%d: ", idx);
-		print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
+		verbose_insn(env, insn);
 	}
 
 	/* If there is a history record that some registers gained range at this insn,
@@ -19273,19 +19285,13 @@ static int do_check(struct bpf_verifier_env *env)
 		}
 
 		if (env->log.level & BPF_LOG_LEVEL) {
-			const struct bpf_insn_cbs cbs = {
-				.cb_call	= disasm_kfunc_name,
-				.cb_print	= verbose,
-				.private_data	= env,
-			};
-
 			if (verifier_state_scratched(env))
 				print_insn_state(env, state, state->curframe);
 
 			verbose_linfo(env, env->insn_idx, "; ");
 			env->prev_log_pos = env->log.end_pos;
 			verbose(env, "%d: ", env->insn_idx);
-			print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
+			verbose_insn(env, insn);
 			env->prev_insn_print_pos = env->log.end_pos - env->prev_log_pos;
 			env->prev_log_pos = env->log.end_pos;
 		}
-- 
2.48.1


