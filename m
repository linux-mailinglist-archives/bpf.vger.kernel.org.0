Return-Path: <bpf+bounces-50717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D37E4A2B899
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 03:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99DE61888A41
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 02:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36B0154439;
	Fri,  7 Feb 2025 02:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0F3zl6z7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FBF1487C8
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 02:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738893941; cv=none; b=JZTkyU5VM5+4DDVPf7FHy+kNydmH/LshBFvH8Fb4Ul6/r+tD6/0QV2lWqHexmryoZGk6TCf/c15R3riZWCXtBLe6cWyJsAqH06BNlgy/RzqCqgXgGj+kIjW4HvNRHa9c8Wewgq47zNQoOaL0NwrXteQ6LfbljHWOdluWY7N4m+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738893941; c=relaxed/simple;
	bh=Q2OkqnaEywltUrTvLR9BEhPUZfK5Xxof8YuvKLY13QU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OCsosC9LnQTCN2Ftry/x2W9pJx398AmneDK7qZTqVc/ZW/9hUghpt1+xRjeOmtOHwAV2TkeTTJ0+sRi76fecpx47Y4qO531tWsX1OjIPkbRCyI9BlmAW5drkUzOROCEDxA00mEba8U/7z8xGjU9uaA7lA7eGVZ9Svxgs9gETzpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0F3zl6z7; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fa11d8e448so3707609a91.0
        for <bpf@vger.kernel.org>; Thu, 06 Feb 2025 18:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738893939; x=1739498739; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G0ksBymLsFxBv6dTHVXwRUMsPxued+iewutBsq02rrE=;
        b=0F3zl6z7IU/2gHkgczbWDC4O0lUQdtSX8LmnjIvSsPuLM+lgenSfRzqG5IubZFHFvj
         vryKzmdatssv9uKQoBPOOAsmHuy7fD3QYjZllwrgT7sc2EpHFvI8ZB37SNp26+roLzQQ
         JqLU832PLxNFQnc1n4epCQwbNU/3zzjUn97Scynro/NAmO+Pq9J+hdEM2ZISlqlU/C6d
         ivDk3nGqZceNc0nI4rcbOJyAy3itKisORrfLU3qM/WpfOpIE8zP7FCOpBdlhsVHeQKEc
         JSRQSZ4nmbWUNEHasmacdgM/UYAge9/ldrLkSUUG8bh45Yp4JPsa4oKhGdqdxgt2GPaT
         XPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738893939; x=1739498739;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G0ksBymLsFxBv6dTHVXwRUMsPxued+iewutBsq02rrE=;
        b=JixYGhmZXzqAetcv6F05yyI7eVwHxzXFFoAQMagL4GTR6c5et/FQlF3Eh+gGiwYM5v
         xgIT6to423T9TXGU8lDKBisn/PEQjs/EF3zX13j+Nkl5Nab0MKNA6Kbs/ZoUBVXd9Vnz
         QxiUJA4ecMSaCQN4urAI39hZ/K8D32C/cxF5gpsKgk2HwmdUyVYuYkVKkEiYl0zU3OVO
         TJV0f7Pi771AtZVc6XDZI0U+LH1mh79TlM77jLvokqSozOZ0H6aQnAwjGUsZI6rf59Qz
         ZB/PXfvVNtCpKq2vjuSszjd1ieVCtCDwk5+8Cx6E9pBkIMlWufUmO7E0OplFKxkIECdp
         cPeQ==
X-Gm-Message-State: AOJu0YxrGjAJxNoet8C26Tt/Lnv3AlxId+L6UG9tT0ZFjWZ6xLGt71cy
	BI6sGPAZRNvAkRKKtng7+bVjmnz/0P/TCYqnelilInOv0mM8LZ2QWD/ae6iSxjh+Q3zkxMz0uh+
	ZaCl9exZTiCFg4NlxgVS4145zrmHQsjVHse5MgbIkSbRWT8JSq6IqhwzjeWT52x0kPyKf79EeBJ
	sJyhOS8C21LO7+visUhs74/pFBdJw3h/FrhAu2LRE=
X-Google-Smtp-Source: AGHT+IEQXS8/Za22ftZ1p+Phe57YwI7GpMBkpoOV+QxJBEcmY8iFZ5iWxAf92Zvu9JrzhNYd5itkmkXtR2L03w==
X-Received: from pfai16.prod.google.com ([2002:aa7:9090:0:b0:72b:ccb:c99b])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:882:b0:71e:6b8:2f4a with SMTP id d2e1a72fcca58-7305d47c9d1mr2600297b3a.12.1738893938799;
 Thu, 06 Feb 2025 18:05:38 -0800 (PST)
Date: Fri,  7 Feb 2025 02:05:34 +0000
In-Reply-To: <cover.1738888641.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1738888641.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <363538659933fb2e289d937d81fc8eecb284ea7b.1738888641.git.yepeilin@google.com>
Subject: [PATCH bpf-next v2 3/9] bpf/verifier: Factor out check_load_mem() and check_store_reg()
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peilin Ye <yepeilin@google.com>, bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, David Vernet <void@manifault.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Yingchi Long <longyingchi24s@ict.ac.cn>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Extract BPF_LDX and most non-atomic BPF_STX instruction handling logic
in do_check() into helper functions to be used later.  While we are
here, make that comment about "reserved fields" more specific.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 kernel/bpf/verifier.c | 110 +++++++++++++++++++++++++-----------------
 1 file changed, 67 insertions(+), 43 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 39eb990ec003..82a5a4acf576 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7536,6 +7536,67 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type type,
 			     bool allow_trust_mismatch);
 
+static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
+			  bool strict_alignment_once, bool is_ldsx,
+			  bool allow_trust_mismatch, const char *ctx)
+{
+	struct bpf_reg_state *regs = cur_regs(env);
+	enum bpf_reg_type src_reg_type;
+	int err;
+
+	/* check src operand */
+	err = check_reg_arg(env, insn->src_reg, SRC_OP);
+	if (err)
+		return err;
+
+	/* check dst operand */
+	err = check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
+	if (err)
+		return err;
+
+	src_reg_type = regs[insn->src_reg].type;
+
+	/* Check if (src_reg + off) is readable. The state of dst_reg will be
+	 * updated by this call.
+	 */
+	err = check_mem_access(env, env->insn_idx, insn->src_reg, insn->off,
+			       BPF_SIZE(insn->code), BPF_READ, insn->dst_reg,
+			       strict_alignment_once, is_ldsx);
+	err = err ?: save_aux_ptr_type(env, src_reg_type,
+				       allow_trust_mismatch);
+	err = err ?: reg_bounds_sanity_check(env, &regs[insn->dst_reg], ctx);
+
+	return err;
+}
+
+static int check_store_reg(struct bpf_verifier_env *env, struct bpf_insn *insn,
+			   bool strict_alignment_once)
+{
+	struct bpf_reg_state *regs = cur_regs(env);
+	enum bpf_reg_type dst_reg_type;
+	int err;
+
+	/* check src1 operand */
+	err = check_reg_arg(env, insn->src_reg, SRC_OP);
+	if (err)
+		return err;
+
+	/* check src2 operand */
+	err = check_reg_arg(env, insn->dst_reg, SRC_OP);
+	if (err)
+		return err;
+
+	dst_reg_type = regs[insn->dst_reg].type;
+
+	/* Check if (dst_reg + off) is writeable. */
+	err = check_mem_access(env, env->insn_idx, insn->dst_reg, insn->off,
+			       BPF_SIZE(insn->code), BPF_WRITE, insn->src_reg,
+			       strict_alignment_once, false);
+	err = err ?: save_aux_ptr_type(env, dst_reg_type, false);
+
+	return err;
+}
+
 static int check_atomic_rmw(struct bpf_verifier_env *env,
 			    struct bpf_insn *insn)
 {
@@ -19051,35 +19112,16 @@ static int do_check(struct bpf_verifier_env *env)
 				return err;
 
 		} else if (class == BPF_LDX) {
-			enum bpf_reg_type src_reg_type;
-
-			/* check for reserved fields is already done */
-
-			/* check src operand */
-			err = check_reg_arg(env, insn->src_reg, SRC_OP);
-			if (err)
-				return err;
+			bool is_ldsx = BPF_MODE(insn->code) == BPF_MEMSX;
 
-			err = check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
-			if (err)
-				return err;
-
-			src_reg_type = regs[insn->src_reg].type;
-
-			/* check that memory (src_reg + off) is readable,
-			 * the state of dst_reg will be updated by this func
+			/* Check for reserved fields is already done in
+			 * resolve_pseudo_ldimm64().
 			 */
-			err = check_mem_access(env, env->insn_idx, insn->src_reg,
-					       insn->off, BPF_SIZE(insn->code),
-					       BPF_READ, insn->dst_reg, false,
-					       BPF_MODE(insn->code) == BPF_MEMSX);
-			err = err ?: save_aux_ptr_type(env, src_reg_type, true);
-			err = err ?: reg_bounds_sanity_check(env, &regs[insn->dst_reg], "ldx");
+			err = check_load_mem(env, insn, false, is_ldsx, true,
+					     "ldx");
 			if (err)
 				return err;
 		} else if (class == BPF_STX) {
-			enum bpf_reg_type dst_reg_type;
-
 			if (BPF_MODE(insn->code) == BPF_ATOMIC) {
 				err = check_atomic(env, insn);
 				if (err)
@@ -19093,25 +19135,7 @@ static int do_check(struct bpf_verifier_env *env)
 				return -EINVAL;
 			}
 
-			/* check src1 operand */
-			err = check_reg_arg(env, insn->src_reg, SRC_OP);
-			if (err)
-				return err;
-			/* check src2 operand */
-			err = check_reg_arg(env, insn->dst_reg, SRC_OP);
-			if (err)
-				return err;
-
-			dst_reg_type = regs[insn->dst_reg].type;
-
-			/* check that memory (dst_reg + off) is writeable */
-			err = check_mem_access(env, env->insn_idx, insn->dst_reg,
-					       insn->off, BPF_SIZE(insn->code),
-					       BPF_WRITE, insn->src_reg, false, false);
-			if (err)
-				return err;
-
-			err = save_aux_ptr_type(env, dst_reg_type, false);
+			err = check_store_reg(env, insn, false);
 			if (err)
 				return err;
 		} else if (class == BPF_ST) {
-- 
2.48.1.502.g6dc24dfdaf-goog


