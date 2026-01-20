Return-Path: <bpf+bounces-79567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D3ED3C0A8
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 08:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 642BD546ACC
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 07:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31893A7DF4;
	Tue, 20 Jan 2026 07:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/EiCrKw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AD83A4F53
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 07:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768894269; cv=none; b=e1SP1yznWMkLOx88tWzHzT8UO+5MUhOMuumobeO2WDkUjoEvy7myZseyqEHdOVlNTmCRZdTv74pgfivft1h4Piqqpe5mQIMPY3hkp90C3YTlAnPxkdPcQdsY/NPvgRYUmA+8u9RAj59X2fg5myjLRKQG5fnz7JOsqzr0TTqECtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768894269; c=relaxed/simple;
	bh=ymRYVJhzeWdJ4sQTO/2s3yQRHdQfXonPvc7Kh15OU7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQ7yfO1uSZ91+y3W2RetgsC5TVH8idIG87ELPcGkWOz+mx4NR4H0SmKb++4dXS3Kh/gitYHAaxWwZdTLsnT4e3NVpmzpApKdGuq1M8G5de8KzP1p0YffYk0CPrVNM40kUJu564edVThKAY1ufJAP7D+smk+kyOa6LVV7mnZGQnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/EiCrKw; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-c2af7d09533so3261477a12.1
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 23:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768894267; x=1769499067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NLuN810LB84TxNhioCDEyB0yA1LlvJHeD3a2KMbZiY=;
        b=d/EiCrKwRVZ9rmnG9hCsEgyEwTB76Z++RrCYiCiLVJG3kOI5LdMOwadnOu+XPo2tes
         aH+hRD65esvwgSyHeOAaaxY8XH8CsmFpiHKia+u6t41g7rE7nhiyZbNdyXiRPoTepaeO
         1elVQHHrhR/Dn5tHp23NKo317dJDroPAfRYQs56fZYh7EiibKMDmcS+y3VmldOsaw54U
         s+va71QPJewTbHvOFaCxYXNMjy2ZVOgigFMfZj0OIPUvwgOggLSIDakRFIoXxOn85+kh
         2CwNp4aZltegmCJtZsPoV7kh3BHvfovK96QX2HWCpeLdmaWGl0xfptXkC4PJt+0+Tn22
         UimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768894267; x=1769499067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7NLuN810LB84TxNhioCDEyB0yA1LlvJHeD3a2KMbZiY=;
        b=Q596mtcI4w/6NIlYYSE7Kh7yDUgVgVKCyuivUX6n4IAH/hJHfzTUaZBzYolPWnKmDm
         0vHYseOcA9vT/2lw3FxrRDu2K/9F3DmqIyluFnUPqsuXsdSGtIYc8P49t6pgd0Hb+FNN
         +0c+ugyUbrcR4TJX6LDVWicEybURCednNOwOdutAnYLSZAft12PS9+ucSqq4gBbCKTXL
         emkFn525wikNe/GGyq75fQ56eRD/H987/lcs4Qbz5EMAUDdksa82JIprNQHe8+fK3a5h
         u+mLW3tDLILgwyRS6l4XdE9McD4TXPZey8bCRocByoApfJhSlZHM5sykbU1fw5zYmP2u
         67Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVwQszszz3sYzUe+zHDj3IYozrMPH+yhbkFqfC9a7sFLIEAkJs5vK/h9Jna40Sxk8daTUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu75FcoDUb/p9rcUgMxdp8kyl3I/GMldwVd6nr8WdWIkfV8zVW
	iFq5rYU9dnqayOVC59dl5Kb7geDyxivNc3EtcmPolsvU9FFmvO1GaFsX
X-Gm-Gg: AY/fxX6V6u2HqsiNz0yptIV+tBG0En2qnVUKkOq9g33ebHSjnHPe+QKq48/HjFM1YPx
	BrGmyIh2rwlmXZ4Tauk2w3iI7INAnJGoOphSTESkStEUMcSBAuwYE3N9HgktaO0nI2dCl7CwdJS
	7of/zswUSK3gCQHw/XY5ERhPRf84MzOL3DsCeqUStxPbTso2QWftx3gyhDUjlSn1Vb3jx2yUOwf
	09SggtFYefDa93EmOmrlXok8XsePiABto1GbWDvr7PVPRZUedBgOgbJyBp8TW7ymcOOC/5jkHSJ
	E+mRQ/6o/ie9WHYFJIs6uo9w6kO0i8dHHXxt32Djve4/8lKf1raJCB2xMZeMWQraz3LSbMCLrnh
	a6bIBeht01UpX2Di8x4PqkvFgiPXa6mGugcblWXNjBFFwBi6Olut8a3EY7fFTWtHj0Bi+yXqPLO
	GPUvtbmm2h
X-Received: by 2002:a05:6a21:a8e:b0:35d:5d40:6d75 with SMTP id adf61e73a8af0-38dfe67bc7dmr12929011637.29.1768894266523;
        Mon, 19 Jan 2026 23:31:06 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf2363e5sm10822395a12.4.2026.01.19.23.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 23:31:06 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org,
	yonghong.song@linux.dev
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
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
Subject: [PATCH bpf-next v4 1/2] bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
Date: Tue, 20 Jan 2026 15:30:45 +0800
Message-ID: <20260120073046.324342-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120073046.324342-1-dongml2@chinatelecom.cn>
References: <20260120073046.324342-1-dongml2@chinatelecom.cn>
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
v4:
- fix the error of using bpf_get_func_arg() for BPF_TRACE_ITER

v3:
- remove unnecessary NULL checking for prog->aux->attach_func_proto

v2:
- for nr_args, skip first 'void *__data' argument in btf_trace_##name
  typedef
---
 kernel/bpf/verifier.c    | 32 ++++++++++++++++++++++++++++----
 kernel/trace/bpf_trace.c |  4 ++++
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9de0ec0c3ed9..0b281b7c41eb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23323,8 +23323,20 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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
@@ -23376,8 +23388,20 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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
index f73e08c223b5..0efdad3adcce 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1734,10 +1734,14 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_d_path:
 		return &bpf_d_path_proto;
 	case BPF_FUNC_get_func_arg:
+		if (prog->expected_attach_type == BPF_TRACE_RAW_TP)
+			return &bpf_get_func_arg_proto;
 		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_proto : NULL;
 	case BPF_FUNC_get_func_ret:
 		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_ret_proto : NULL;
 	case BPF_FUNC_get_func_arg_cnt:
+		if (prog->expected_attach_type == BPF_TRACE_RAW_TP)
+			return &bpf_get_func_arg_cnt_proto;
 		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_cnt_proto : NULL;
 	case BPF_FUNC_get_attach_cookie:
 		if (prog->type == BPF_PROG_TYPE_TRACING &&
-- 
2.52.0


