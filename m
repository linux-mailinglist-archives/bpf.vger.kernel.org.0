Return-Path: <bpf+bounces-79197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 181E1D2D0E5
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 08:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBF73307766A
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 07:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448BE30EF69;
	Fri, 16 Jan 2026 07:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFopeO5r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CB52DF13F
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768547881; cv=none; b=CHuACH9Y5DqWosT31uAEdI7xUYAZfRA7P4ax1EjUsiUpu5YURISDXD9lLueTNAXgN4bD24/NeglJ2kQGLaDjfqqZinaR4EDWG3dAsZuqCBcjJn+qL+hrRWvuK0Mfudf1wo9fci7/Yai/y27wcH/JafQCDjWXvXM2EWqbPf+ggpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768547881; c=relaxed/simple;
	bh=sVKvb5Nz1A+WPx1wLx+juOJWf6PmzJcfp77DQOrJTzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSL+WGgWTrd/zqytXe1htxQEy4hcFz05npKlMLkK5x6nVqeAUxY1QPIYChdS3KxypaSz4lMp2jmdTKJiNqMMKCto5YlMOpqo9IQ+G9Q0ezQiHujx/4euTpgQWxYUZ6Kk9zGLcRh1cJ41AeaOEh4F6nh8LCKXWkYe02+G2+oJ/gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFopeO5r; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a2ea96930cso11066685ad.2
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 23:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768547879; x=1769152679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/38jAZCyYx52GHr4cYx6xhDB60Qm+8nD9DL091nuyss=;
        b=cFopeO5rmtJxJ1mKdAJm/BefMHjqMme0PVR1hLLvDg0vWCgEE6+Jw+5mYNPgPe2bWt
         4itli1YwDfx61z5q3xa/9CghHDr+4Tbh8zgeaoKbcsym6nwUAF9OBM4d+1j2tsDCgjwb
         dmVgsw1zcg+pYb+/sYlhCGUjJ0XXC6/scU1z9aB1ng9ARLgpU18cErHyOBDA5D4Bovr6
         SmH/wb5m3FNmRaZXgSzQAyMEqrgIpGF72OpjJFBy1sRDjrZvEY92KnuFR4riB2l+rsN+
         132Tvkuh0n/K4G+lJEBFcRbCMK2nEe3Pfdx1RvsjK601r3rPHK+6eVvVLs+LyU7N19We
         ZpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768547879; x=1769152679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/38jAZCyYx52GHr4cYx6xhDB60Qm+8nD9DL091nuyss=;
        b=L31YCkQMsoHgUgQLm3aAYi9OE7Y+YO3Le8BEVWmDAVcpz9NR1UROreN1lmT/ZE1e2O
         QjUtffEN8fpZLIndk/1ioxNLrAexvMigzwGo7ubMbGYfEHJbyYUyt+GqEf/kUPDUWskU
         Zig3sDhyGD0LafuHjQ039+VXH5kyD/0Qjqv/Z8YHv/uzGbEZvBiHPGkL/Daw24HCaPrZ
         KOPNY07kHQtkR3vTwrDCm2pqh+Kqvv3rKeOPlm7fmIjx4GxaFfnGVWjZz4uUrIKWO72x
         8H7Zj0XHu6/bHXGdEt7oEdlQ5D/PvvEkfdmpRenEE/cqT84UcJzbY39FTcoXVoc+WR97
         ZhRw==
X-Forwarded-Encrypted: i=1; AJvYcCX83UtlKLuAWpp6wFgXYVGvcuzCr1Fs4JHA0sHMU3dyP9FHygIZR+qbBGC2npTek+Vp9tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPUc2lTsWD6VxCJz5Hlz4l5szO7XSE/lcO+pslC0vzXMGa0GTj
	baWK3f9r1FWvuregeBRD+cJv4f2/Y47eNGvEhTUaGaXNv8tKCkZWdynl
X-Gm-Gg: AY/fxX7wAL8RmzqaCq7GidAiDsy+CoTFyTuVhRo1QeRagM+/EL5LOLHpbPY7vx9wJ1z
	0Putd1376SdU/4Lmm+XHWAQ6YaXfX17UxQWUsqI7MgIyLmi53O6fP3j4Dl0mMf6cR4P+boVuUJ9
	Y66bVwLqdr7KkBpS9/cXEtdiO2cKXhJOK9y0TyIx6bgOkVmTLREloPBEAklvK1/w0NNshg53iK3
	Qd9rs82GSWZbPV+n+ZzwYjYmv9k29dPacLykG62pnwAwUWUrmuWuOGNmlWRotXAqA3RAeqoTB0U
	cukf3sH1WRB/gNfMXzQIAh5CmlxHpGkeU0cS/4WmD32CPzIyIEG2lEoz2Xqjs0JijhSJ+z3gyE2
	jdxtIWUjewzySKStZj/aGy8vr6Uepu+zqE0I/kr6dw5khSlqYMokQhDrY/oVjsd2qtDTbWXGZyv
	uL7qUj7QM=
X-Received: by 2002:a17:903:40cb:b0:2a0:faf1:782 with SMTP id d9443c01a7336-2a717519edbmr16762915ad.9.1768547879099;
        Thu, 15 Jan 2026 23:17:59 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce2ebsm12508275ad.32.2026.01.15.23.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 23:17:58 -0800 (PST)
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
Subject: [PATCH bpf-next v2 1/2] bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
Date: Fri, 16 Jan 2026 15:17:38 +0800
Message-ID: <20260116071739.121182-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116071739.121182-1-dongml2@chinatelecom.cn>
References: <20260116071739.121182-1-dongml2@chinatelecom.cn>
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
v2:
- for nr_args, skip first 'void *__data' argument in btf_trace_##name
  typedef
---
 kernel/bpf/verifier.c    | 36 ++++++++++++++++++++++++++++++++----
 kernel/trace/bpf_trace.c |  4 ++--
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index faa1ecc1fe9d..422d35c100ff 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23316,8 +23316,22 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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
+				/*
+				 * skip first 'void *__data' argument in btf_trace_##name
+				 * typedef
+				 */
+				nr_args = btf_type_vlen(prog->aux->attach_func_proto) - 1;
+				/* Save nr_args to reg0 */
+				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args);
+			} else {
+				/* Load nr_args from ctx - 8 */
+				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+			}
 			insn_buf[1] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
 			insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
 			insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
@@ -23369,8 +23383,22 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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
+				/*
+				 * skip first 'void *__data' argument in btf_trace_##name
+				 * typedef
+				 */
+				nr_args = btf_type_vlen(prog->aux->attach_func_proto) - 1;
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


