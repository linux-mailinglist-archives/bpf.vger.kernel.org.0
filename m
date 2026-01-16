Return-Path: <bpf+bounces-79178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0DAD2AFDF
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 04:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 341013065AB6
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 03:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7612D342CA7;
	Fri, 16 Jan 2026 03:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lpl0y07W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE9929A1
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 03:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768535443; cv=none; b=seZ2NpK0L5c7WN3Q/t6XhTbKRHtR9Fr2/rsjGAOi9Ioa0uX+CjTh9IkC1ugQp+itWqkQBnQrMIhPbWJ3WkFSiHcGwOZsGp0MKBIWgR+dqlJpxRxEMK5L9kqI5xFjlds0vSLRqXpUmP/BY0ZJktMmrCn7zWpagRfIjeyC+l1glm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768535443; c=relaxed/simple;
	bh=zY4lZ/WMgcwk7KKWgJshhVk7lhJb+yixU/AKr0hQg7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oM5sNNO6q7OpxNghv0jNwWUdCyBmyqqv3TQLkrTdottYe/9GPs2sDivzF81OsXiF5j8HDxGKmvOoaIU3gCKc0ht4DSSYNgAu565+qrYwZx2hTS9Ry4TjQuQyMo6nvCK1kywhtzuaSiOFa159MX1B/EpnlTbRk8MsisP1y18tPm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lpl0y07W; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-34e730f5fefso1030985a91.0
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 19:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768535441; x=1769140241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slOe1FPJhANQ1vYoC8HEpAu7LLkuMBjol/KDdw72Pdw=;
        b=Lpl0y07WMPHwr8G+d0TDk9fDHg5C0Xs9Yw+7OgBcZ13/8xY8Ht1zjp47PYY17pYSSD
         /2lDmt+KJDvUZTqVukCJKTXoINUfeeQdNrme+1dWmD6HrWeILqLZFx8l3SaswgBo+uEf
         C8UbmxbEtIzYRKHPVBgGvBOQYMrMVZM6rQ61gF65I9+ENOemJjERZGkrbdr4+54LxhVq
         PxXSxQ7o++yHedCwDA19rk+Hsxh2XCeVyKUVbaZIZ+mSrJGPyLLO8nrVd6SK9kgEwXpz
         rNF/5MKOJ2NTIM+XWuIHNUinLdorjSOW8JfQATDvly0Gz18oJvPwabH0aW2OXvpUOM+v
         vDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768535441; x=1769140241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=slOe1FPJhANQ1vYoC8HEpAu7LLkuMBjol/KDdw72Pdw=;
        b=e/MthxW2NTqE0MTi5+O6kGerKHlDvBMwgP25kbrfMLUmOmBi1/G/jpmdjZRGgyTW+W
         yv9ov4lRp2Nn+86HcJSG3pziFZtflCV5I4dfjEVylsodnNFBAjm2ALrmhhgCXTb5GCah
         Ims2W6ONWNJ5qrb/l4lAaapcOXAdWaGcNGzrbz4tZhSzkkoNMuPHyXe2N8YcFFTESQRg
         /aaWAPsEqwrMYwi7E1+TYWw1fis6kIiwJ9OYwZ/R3ERyTCa/HueXqJVi9M0rtSy0tu7n
         bdMI7XF0zmtopUnMtE4eAx+D5E5x3YIrrBS3tdCng1/gugwWtnjInBrGDReFb5vD+Ywa
         IzGA==
X-Forwarded-Encrypted: i=1; AJvYcCXOhjGmc6FgwRwW/FG7AnuqDPPq5peq1rJzr9TlvUBQDK0TAz/3m9L983CP6SQTaGW0PPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwId0LF12stVHz5VMqIEzBFGK/IZyeKAc9uZ/H/4+DSSI5icxCN
	4a7rz7kIliPFxA8EZS270hlrNcLFrUmcPVpLrfFcfzi0lPGEz/SQCtP+
X-Gm-Gg: AY/fxX60D3qZff5iZg6ENCDgslED+/YqIcwYEG606wxgApSgmoPzUdBQ7vkG2OW6Z90
	6W9XtvfT4+M9ONgzqTNf+Qvoa6ifVZB62goOjSKCiYdxifcn7+acQzbgyqkGEAUrRGlPfHLEBdM
	dES6158vmiPBtISuSdqH7l327l5eYzgMbshAWqqVdKKBod1M2tA8O5EYQS9QzbyFJovZQ/W/mls
	TtYu5p/N1m2e51NykCbHh6Frfx5kVxrSQqNHO8PMGTDAkarBUsul236mXsDR3eUJKCFuDm2AJlY
	DSuIWDwv9wB6qH+xglHD4i2XH1moyBJwKE/TPysi0zi9gv0bQ5QkoIR2AjjDA3CvwcPT4LQK1j3
	5MZlp7XfV/NYIZ838N0keCtR0aAaF9meyaYZj9zNPGObw7ln5T7LnOgJpZYtYXgPfjzJkRea1cz
	mlIYtDEBI=
X-Received: by 2002:a17:90b:2f44:b0:34a:48ff:694 with SMTP id 98e67ed59e1d1-35272fa908emr1225888a91.31.1768535441060;
        Thu, 15 Jan 2026 19:50:41 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf37c9d7sm684504a12.35.2026.01.15.19.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 19:50:40 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
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
Subject: [PATCH bpf-next 1/2] bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
Date: Fri, 16 Jan 2026 11:50:23 +0800
Message-ID: <20260116035024.98214-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116035024.98214-1-dongml2@chinatelecom.cn>
References: <20260116035024.98214-1-dongml2@chinatelecom.cn>
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
therefore we can get the function argument conut from the function
prototype instead of the stack.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/bpf/verifier.c    | 28 ++++++++++++++++++++++++----
 kernel/trace/bpf_trace.c |  4 ++--
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index faa1ecc1fe9d..6dee0defa291 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23316,8 +23316,18 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		/* Implement bpf_get_func_arg inline. */
 		if (prog_type == BPF_PROG_TYPE_TRACING &&
 		    insn->imm == BPF_FUNC_get_func_arg) {
-			/* Load nr_args from ctx - 8 */
-			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+			if (eatype == BPF_TRACE_RAW_TP) {
+				int nr_args;
+
+				if (!prog->aux->attach_func_proto)
+					return -EINVAL;
+				nr_args = btf_type_vlen(prog->aux->attach_func_proto);
+				/* Save nr_args to reg0 */
+				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args);
+			} else {
+				/* Load nr_args from ctx - 8 */
+				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+			}
 			insn_buf[1] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
 			insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
 			insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
@@ -23369,8 +23379,18 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		/* Implement get_func_arg_cnt inline. */
 		if (prog_type == BPF_PROG_TYPE_TRACING &&
 		    insn->imm == BPF_FUNC_get_func_arg_cnt) {
-			/* Load nr_args from ctx - 8 */
-			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+			if (eatype == BPF_TRACE_RAW_TP) {
+				int nr_args;
+
+				if (!prog->aux->attach_func_proto)
+					return -EINVAL;
+				nr_args = btf_type_vlen(prog->aux->attach_func_proto);
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


