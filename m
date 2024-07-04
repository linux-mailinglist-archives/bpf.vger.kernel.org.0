Return-Path: <bpf+bounces-33878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C64C69273F2
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 12:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F731F23A1D
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 10:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990481ABC22;
	Thu,  4 Jul 2024 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYBdov6U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D068E1AB90D
	for <bpf@vger.kernel.org>; Thu,  4 Jul 2024 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088665; cv=none; b=gKswQPNEig5W++6KH96eekr7Pp5pXYY+dmMJeLa++CGWpf0rOzDzIjEpNiTtlroddGoX6FTIGwbOImZpdSBuEFzEApx8vQukhnr9MEQmcSwQMFOG5axpTsQooMkvaFT7/Lc+OTXuco9FZe4gGLCE3Gu/VF5S1AgLYD+aVXuwzu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088665; c=relaxed/simple;
	bh=AzvXWRFLXr7xIiY/rivzljP18btI67BmTenXFccTDA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1XiRC5+aJmYISZeXUl7RACdDPW/1ByqaFwgbwBPTI1sojMHPn41vIxGkMbjjnxqMFnLvr9BzSCS/K1I7D7kttDqaECHF2/iUPfR5ud5bSYpt6ULlHKHuBadLS6gg21LvanNh7VpDq9ZK4j3mx3vo5NQj9xBYQJspLllRh504As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYBdov6U; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c1a4192d55so358666a91.2
        for <bpf@vger.kernel.org>; Thu, 04 Jul 2024 03:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720088663; x=1720693463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrBDEFVo0cfjnqmOyEfJiub0G37zOhdIJoBPwbO1g1U=;
        b=cYBdov6UJX0Mu0Q0rX+oQan7MI6h+Yz2FyRsRp04GF3wSDtk6lexYEUSWT/Mh1xICL
         a/dSpDK7k7vj5FNhD1CrDhCAdPAsEPgwGCoYGJCZs19tERWRAO0djgc2B/lRlYnSi7Bm
         +jGFRhgwfU+UAdreeDFT8wrjpT7gCBjhXQN1vkt5hkf1CqZPwG3aCgb6ykbKksHYV52b
         Dzk1QBBCk8HVWsnzV6bnnCGJFJYyLyshwjlmk+osTuW38q31prZE3LZueglOigMPssRW
         i0munO6OoRzllVC2GXR/+RdeqK6Eq81GWfYh7lbDpQd99LS4dKR5MsKZ8ZlxkigkZfoP
         QILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720088663; x=1720693463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OrBDEFVo0cfjnqmOyEfJiub0G37zOhdIJoBPwbO1g1U=;
        b=o6szb2+BZvh0BS9Ew5Ir0oJZXp0DtFswa+uR7bNrGxfNVfAHI/Ja7ag8OaZ9ggXNGF
         Y8PURgjKKzfNDZm/C1eC4yfTrolD2gpmPlx3JH41S+GLpRxPt0ExankJNF68JhJ7Gxl0
         k8EiuEBW/FlqYoljNQ9LHou+PDkDG8tAZObQQuqO00r8CrtJJIW203cDH57ttsjQPMlV
         BH2H5rGw5eMbJNDpTlpzDB3IhMQJL+dtUlhxbY1mlxCgSAYdJ7Mtjjgl2GESdW34fHi1
         gUL1a/cux3Ew9ZgC048b6DQeANhxkcYJ+furJLJbUl5KkftbkLjBw3sLKdMvtQ0Bsj7l
         kpLA==
X-Gm-Message-State: AOJu0YwbTmv1ukwFXEJh5Nkg/oROeIT1qwcTG2Y0MeCGGu65oF9viy15
	eyNqYnOPiVTd6k+Yd/lBxBfZxb52QeRS7ibILZ43PwM3bmGVqUUOk2EgYA==
X-Google-Smtp-Source: AGHT+IFNUcdBD4+cPDS29qFQ2jxEe42xCFHivWE1llZUrdm+6s05Z/4hJ29drNKyUfIWqzhkvEvbrQ==
X-Received: by 2002:a17:90a:6f82:b0:2c9:7a8d:43f7 with SMTP id 98e67ed59e1d1-2c99c5700d4mr886756a91.23.1720088661741;
        Thu, 04 Jul 2024 03:24:21 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c9a4c0fe8dsm216693a91.0.2024.07.04.03.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 03:24:21 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	jose.marchesi@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next v2 3/9] bpf, x86, riscv, arm: no_caller_saved_registers for bpf_get_smp_processor_id()
Date: Thu,  4 Jul 2024 03:23:55 -0700
Message-ID: <20240704102402.1644916-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704102402.1644916-1-eddyz87@gmail.com>
References: <20240704102402.1644916-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function bpf_get_smp_processor_id() is processed in a different
way, depending on the arch:
- on x86 verifier replaces call to bpf_get_smp_processor_id() with a
  sequence of instructions that modify only r0;
- on riscv64 jit replaces call to bpf_get_smp_processor_id() with a
  sequence of instructions that modify only r0;
- on arm64 jit replaces call to bpf_get_smp_processor_id() with a
  sequence of instructions that modify only r0 and tmp registers.

These rewrites satisfy attribute no_caller_saved_registers contract.
Allow rewrite of no_caller_saved_registers patterns for
bpf_get_smp_processor_id() in order to use this function as a canary
for no_caller_saved_registers tests.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/helpers.c  |  1 +
 kernel/bpf/verifier.c | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 229396172026..26863b162a88 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -158,6 +158,7 @@ const struct bpf_func_proto bpf_get_smp_processor_id_proto = {
 	.func		= bpf_get_smp_processor_id,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
+	.allow_nocsr	= true,
 };
 
 BPF_CALL_0(bpf_get_numa_node_id)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d16a249b59ad..99115c552e3b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16029,7 +16029,14 @@ static u8 get_helper_reg_mask(const struct bpf_func_proto *fn)
  */
 static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
 {
-	return false;
+	switch (imm) {
+#ifdef CONFIG_X86_64
+	case BPF_FUNC_get_smp_processor_id:
+		return env->prog->jit_requested && bpf_jit_supports_percpu_insn();
+#endif
+	default:
+		return false;
+	}
 }
 
 /* If 'insn' is a call that follows no_caller_saved_registers contract
@@ -20703,7 +20710,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 #ifdef CONFIG_X86_64
 		/* Implement bpf_get_smp_processor_id() inline. */
 		if (insn->imm == BPF_FUNC_get_smp_processor_id &&
-		    prog->jit_requested && bpf_jit_supports_percpu_insn()) {
+		    verifier_inlines_helper_call(env, insn->imm)) {
 			/* BPF_FUNC_get_smp_processor_id inlining is an
 			 * optimization, so if pcpu_hot.cpu_number is ever
 			 * changed in some incompatible and hard to support
-- 
2.45.2


