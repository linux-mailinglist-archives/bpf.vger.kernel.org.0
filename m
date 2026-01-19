Return-Path: <bpf+bounces-79400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D983FD39C68
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 03:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAB7F3007C90
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 02:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB8C2417C6;
	Mon, 19 Jan 2026 02:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqJr8rX2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24A615746F
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 02:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768790271; cv=none; b=GSm+RQExtY2SNpJRyzLlKhSHXPaHqe7nDWFfN0yiHwELzGUBH4s5ieIGPMuvKCSkcTtG3eAno/tmIb5g6LTbFhMbmVKKBG/45Y4Gbsh4mTDvY3pkzuwwYBcmChfRUkMVp3eRWYYfQWCQnEoA6RJEuIvGG7F6Pt0VOmPu2G4r9BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768790271; c=relaxed/simple;
	bh=Q6QisaRcToNU+9dAs/6R0e31RVIED+7qcjILmQrFk9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXEYa1BFDJb0ngQ223rAem2EcBm7bxK5Lsw3qARdrrohnSd6egHEZUarNLtt0G6etob5b4LHLzVDpfOZql6JnT7MMpM9gSEph1crxi69jSjVwK6PJL/xX8MBYshdBKRG9B6EcHOVHEJKDAZSsVtLWjmgIqLpfDQt5niW6fVO14c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqJr8rX2; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a081c163b0so20592165ad.0
        for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 18:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768790269; x=1769395069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RDbE4NMRF9BAKqVTKl+RK/Ugc6GtBbotY5ablyCjC4=;
        b=dqJr8rX21WTHDxfm8QWWfmqrx5GGKwYvnhHM1R1m/oSHluahGf1j6S2YxmXKJSReDP
         cxU6SzSy/8rl8MlTzz1Vq1ghfPlqB3adgXQ8SbdTdSOjkBjPt6e9KPi1MxV77QI203gh
         6Epmz0ZVAsXjg3zECyHgFLFEYxlF8Eqicf5MCTQKpYzn9DSPCBflibvn//K8cz9j213P
         yo/US9TGtVgh4Xc+Pwegvq+IXTOupeQv2yQt20sMjsAbRh9+NAqM87mMPm7+AzMWE2zW
         GeoNyH6NWep6bXVtU3q6mPM4V6CZfsqsCaFR0AyWity5A2NpjFNSQ8toai81PaHFewiJ
         1Qug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768790269; x=1769395069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3RDbE4NMRF9BAKqVTKl+RK/Ugc6GtBbotY5ablyCjC4=;
        b=XjogBk3E57QmLPvCn+xY1uFpCrvBfThb3qKYefpCOBj7xXrYG6PDCTl69S+wqkCDlM
         su845P+LFsXilnx4+5aMhCFCTiRiLpK6EWPYm1YkCAK2H7sEq5X57/19TgyKaKrG3kh2
         CFdy1kMUWFou+1JO34H6DfwnipgEKlmNXPfCF4IJXv1Bgkcxc9edmrmNdxSWTfxRUA/H
         d9S9kEys5mqaCdlRdC9H/ViYRCCxI9fQZrD+BM/1ixXKc5zQpYhshUKBz6TfnWVaEogF
         OkNCg7Z5RVfOGCEupIJY7CwTxGYHIH+XvgpXaLe6/KRJaND9eMlX5Mox46ZZPkcCdiBD
         9Rfg==
X-Forwarded-Encrypted: i=1; AJvYcCUFzVlGXlEEs2anPFJjgeQk7kaMjaP9PKkFtCztVjQPn7I0D/v6dpko8Jr59C+Q85RBtxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ1zVkg1ZylHRuS3Xviulecq+FwTS0GtnFeUDIcGeN4kd7rQhv
	rvpQlHOwAvu3D1MRlqWaT+DPnCvum8YjMMFKpMaJ5TonL0DmhNFpTobG
X-Gm-Gg: AY/fxX4/C1nnlHxOP5Sn5ec/3G36mxxHan1e/OLED75QxuqvisVrc4gS0Bv977GeWPk
	l6iy/0knVQxloku9Qeo5XAAvZ3QBuwChqeulQdBeVuP7f5chgdG9BtUU5XCgJgM7hQFLrgfoftn
	A/9XqDXOXqKJPqWPRHruXRuo0u2QUF4XL3uiNzvIXFupbEYzSr5RPRfMKdXpUmcAqsAA39GMaiH
	lcCWweN4x6n8C4SHaDpUyH2/t6Bf1IeUaRwp2w3p4w9sWG0+FzzPnMB9ylLvvpCL02CGE5bLHbO
	9DE+AwJSALvT/KmnjeEY1+GUABtD6MxuR6/yXFWUNNbW6Al8FAmlthZID2QUz4Xx4L7JlHr5Esj
	UHiz5tbu5qcYCLs7A6ut8W5hLjeNW2Mdl43x2lCMsdB/alEgTPvfLesYWJEiEOaoN/KE/x5ZkmL
	1goHf5b11w
X-Received: by 2002:a17:903:1b64:b0:2a1:243:94a8 with SMTP id d9443c01a7336-2a7177db0f2mr89032255ad.49.1768790268992;
        Sun, 18 Jan 2026 18:37:48 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190c9ee9sm77154645ad.22.2026.01.18.18.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 18:37:48 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org,
	ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 1/2] bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
Date: Mon, 19 Jan 2026 10:37:31 +0800
Message-ID: <20260119023732.130642-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119023732.130642-1-dongml2@chinatelecom.cn>
References: <20260119023732.130642-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, bpf_get_func_arg() and bpf_get_func_arg_cnt() is not supported by
the BPF_TRACE_RAW_TP, which is not convenient to get the argument of the
tracepoint, especially for the case that the position of the arguments in
a tracepoint can change.

The target tracepoint BTF type id is specified during loading time,
therefore we can get the function argument count from the function
prototype instead of the stack.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
- remove unnecessary NULL checking for prog->aux->attach_func_proto

v2:
- for nr_args, skip first 'void *__data' argument in btf_trace_##name
  typedef
---
 kernel/bpf/verifier.c    | 32 ++++++++++++++++++++++++++++----
 kernel/trace/bpf_trace.c |  4 ++--
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index faa1ecc1fe9d..4f52342573f0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23316,8 +23316,20 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		/* Implement bpf_get_func_arg inline. */
 		if (prog_type == BPF_PROG_TYPE_TRACING &&
 		    insn->imm == BPF_FUNC_get_func_arg) {
-			/* Load nr_args from ctx - 8 */
-			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+			if (eatype == BPF_TRACE_RAW_TP) {
+				int nr_args = btf_type_vlen(prog->aux->attach_func_proto);
+
+				/*
+				 * skip first 'void *__data' argument in btf_trace_##name
+				 * typedef
+				 */
+				nr_args--;
+				/* Save nr_args to reg0 */
+				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args);
+			} else {
+				/* Load nr_args from ctx - 8 */
+				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+			}
 			insn_buf[1] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
 			insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
 			insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
@@ -23369,8 +23381,20 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		/* Implement get_func_arg_cnt inline. */
 		if (prog_type == BPF_PROG_TYPE_TRACING &&
 		    insn->imm == BPF_FUNC_get_func_arg_cnt) {
-			/* Load nr_args from ctx - 8 */
-			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+			if (eatype == BPF_TRACE_RAW_TP) {
+				int nr_args = btf_type_vlen(prog->aux->attach_func_proto);
+
+				/*
+				 * skip first 'void *__data' argument in btf_trace_##name
+				 * typedef
+				 */
+				nr_args--;
+				/* Save nr_args to reg0 */
+				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args);
+			} else {
+				/* Load nr_args from ctx - 8 */
+				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+			}
 
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
 			if (!new_prog)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 6e076485bf70..9b1b56851d26 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1734,11 +1734,11 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_d_path:
 		return &bpf_d_path_proto;
 	case BPF_FUNC_get_func_arg:
-		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_proto : NULL;
+		return &bpf_get_func_arg_proto;
 	case BPF_FUNC_get_func_ret:
 		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_ret_proto : NULL;
 	case BPF_FUNC_get_func_arg_cnt:
-		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_cnt_proto : NULL;
+		return &bpf_get_func_arg_cnt_proto;
 	case BPF_FUNC_get_attach_cookie:
 		if (prog->type == BPF_PROG_TYPE_TRACING &&
 		    prog->expected_attach_type == BPF_TRACE_RAW_TP)
-- 
2.52.0


