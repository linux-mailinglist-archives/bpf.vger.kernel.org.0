Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 832B21798C9
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 20:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgCDTTC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 14:19:02 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41497 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbgCDTTC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 14:19:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id v4so3868163wrs.8
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2020 11:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WWtZI2A0hmIEG0llfgLQpxiUN3KWtDRPNvPAySOvq1M=;
        b=cqjc9v23mitxaMXQf8aHqW5gzEHp6s6IyTnrVtm7GBcKbsdhChc5ytpJYPypWqQmkJ
         ikr5tef0zbpWBemrVABFPv3GUJ5Td1WMy8tQVfagF/TXF8IKPm9hjIggtz3Ev7q5TfXQ
         zEpaqad8KkgyFbKf3PDhsLlXaNjed64xMu7CA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WWtZI2A0hmIEG0llfgLQpxiUN3KWtDRPNvPAySOvq1M=;
        b=Ijarbw1TxclOrb0EXKGmSLqHh+LVOrZWgmM/NJDVIMLRkfuoZhLtFyeoRfnUUuHYPU
         LEviBE2qAKLF4Wnz0nKesJNJIKV4Z9HwhE9fT31YmjudDSyBzEeQ6dn6oxggZFHKlc6g
         1mqDTNsod1xVTlyBobRhv49LxduN/sZZKwH2/4HZ7x+rhW9O8dA/p8maMQheJiALd+/F
         9P6HRhB9ye1Nrw7EPrv3K/u0UUFQf+Bhm2qzex6MNwZuv3pLGBQQOVRzFRHWOpzGXDIi
         wHXTWF965ei+77ueGlaq/IcSjCXa1/mIk9vruVh+qqdRktWO5VhYsX0UTRDTXLjkpDOD
         hUyQ==
X-Gm-Message-State: ANhLgQ3nsR+VXEz7jEFNSeyR6EXDD8TH/2OuQk1odwFHP/6dWKGaLaLk
        CM8Y6ZmS7kjCBFK8ReuJuOiolQ==
X-Google-Smtp-Source: ADFU+vtPo96cnWToK+KAUona3kPvrZp0O6zmn0FVxipDMLpxTnEt9XkW5jJbaaEHhIdWFiPLFkTThg==
X-Received: by 2002:a05:6000:8f:: with SMTP id m15mr5272596wrx.378.1583349540737;
        Wed, 04 Mar 2020 11:19:00 -0800 (PST)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id w9sm2018556wrn.35.2020.03.04.11.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 11:19:00 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v4 2/7] bpf: JIT helpers for fmod_ret progs
Date:   Wed,  4 Mar 2020 20:18:48 +0100
Message-Id: <20200304191853.1529-3-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304191853.1529-1-kpsingh@chromium.org>
References: <20200304191853.1529-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

* Split the invoke_bpf program to prepare for special handling of
  fmod_ret programs introduced in a subsequent patch.
* Move the definition of emit_cond_near_jump and emit_nops as they are
  needed for fmod_ret.
* Refactor branch target alignment into its own generic helper function
  i.e. emit_align.

Signed-off-by: KP Singh <kpsingh@google.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 arch/x86/net/bpf_jit_comp.c | 148 +++++++++++++++++++++---------------
 1 file changed, 85 insertions(+), 63 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 15c7d28bc05c..d6349e930b06 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1361,35 +1361,95 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_args,
 			 -(stack_size - i * 8));
 }
 
+static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
+			   struct bpf_prog *p, int stack_size)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+
+	if (emit_call(&prog, __bpf_prog_enter, prog))
+		return -EINVAL;
+	/* remember prog start time returned by __bpf_prog_enter */
+	emit_mov_reg(&prog, true, BPF_REG_6, BPF_REG_0);
+
+	/* arg1: lea rdi, [rbp - stack_size] */
+	EMIT4(0x48, 0x8D, 0x7D, -stack_size);
+	/* arg2: progs[i]->insnsi for interpreter */
+	if (!p->jited)
+		emit_mov_imm64(&prog, BPF_REG_2,
+			       (long) p->insnsi >> 32,
+			       (u32) (long) p->insnsi);
+	/* call JITed bpf program or interpreter */
+	if (emit_call(&prog, p->bpf_func, prog))
+		return -EINVAL;
+
+	/* arg1: mov rdi, progs[i] */
+	emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32,
+		       (u32) (long) p);
+	/* arg2: mov rsi, rbx <- start time in nsec */
+	emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
+	if (emit_call(&prog, __bpf_prog_exit, prog))
+		return -EINVAL;
+
+	*pprog = prog;
+	return 0;
+}
+
+static void emit_nops(u8 **pprog, unsigned int len)
+{
+	unsigned int i, noplen;
+	u8 *prog = *pprog;
+	int cnt = 0;
+
+	while (len > 0) {
+		noplen = len;
+
+		if (noplen > ASM_NOP_MAX)
+			noplen = ASM_NOP_MAX;
+
+		for (i = 0; i < noplen; i++)
+			EMIT1(ideal_nops[noplen][i]);
+		len -= noplen;
+	}
+
+	*pprog = prog;
+}
+
+static void emit_align(u8 **pprog, u32 align)
+{
+	u8 *target, *prog = *pprog;
+
+	target = PTR_ALIGN(prog, align);
+	if (target != prog)
+		emit_nops(&prog, target - prog);
+
+	*pprog = prog;
+}
+
+static int emit_cond_near_jump(u8 **pprog, void *func, void *ip, u8 jmp_cond)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+	s64 offset;
+
+	offset = func - (ip + 2 + 4);
+	if (!is_simm32(offset)) {
+		pr_err("Target %p is out of range\n", func);
+		return -EINVAL;
+	}
+	EMIT2_off32(0x0F, jmp_cond + 0x10, offset);
+	*pprog = prog;
+	return 0;
+}
+
 static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 		      struct bpf_tramp_progs *tp, int stack_size)
 {
+	int i;
 	u8 *prog = *pprog;
-	int cnt = 0, i;
 
 	for (i = 0; i < tp->nr_progs; i++) {
-		if (emit_call(&prog, __bpf_prog_enter, prog))
-			return -EINVAL;
-		/* remember prog start time returned by __bpf_prog_enter */
-		emit_mov_reg(&prog, true, BPF_REG_6, BPF_REG_0);
-
-		/* arg1: lea rdi, [rbp - stack_size] */
-		EMIT4(0x48, 0x8D, 0x7D, -stack_size);
-		/* arg2: progs[i]->insnsi for interpreter */
-		if (!tp->progs[i]->jited)
-			emit_mov_imm64(&prog, BPF_REG_2,
-				       (long) tp->progs[i]->insnsi >> 32,
-				       (u32) (long) tp->progs[i]->insnsi);
-		/* call JITed bpf program or interpreter */
-		if (emit_call(&prog, tp->progs[i]->bpf_func, prog))
-			return -EINVAL;
-
-		/* arg1: mov rdi, progs[i] */
-		emit_mov_imm64(&prog, BPF_REG_1, (long) tp->progs[i] >> 32,
-			       (u32) (long) tp->progs[i]);
-		/* arg2: mov rsi, rbx <- start time in nsec */
-		emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
-		if (emit_call(&prog, __bpf_prog_exit, prog))
+		if (invoke_bpf_prog(m, &prog, tp->progs[i], stack_size))
 			return -EINVAL;
 	}
 	*pprog = prog;
@@ -1531,42 +1591,6 @@ int arch_prepare_bpf_trampoline(void *image, void *image_end,
 	return prog - (u8 *)image;
 }
 
-static int emit_cond_near_jump(u8 **pprog, void *func, void *ip, u8 jmp_cond)
-{
-	u8 *prog = *pprog;
-	int cnt = 0;
-	s64 offset;
-
-	offset = func - (ip + 2 + 4);
-	if (!is_simm32(offset)) {
-		pr_err("Target %p is out of range\n", func);
-		return -EINVAL;
-	}
-	EMIT2_off32(0x0F, jmp_cond + 0x10, offset);
-	*pprog = prog;
-	return 0;
-}
-
-static void emit_nops(u8 **pprog, unsigned int len)
-{
-	unsigned int i, noplen;
-	u8 *prog = *pprog;
-	int cnt = 0;
-
-	while (len > 0) {
-		noplen = len;
-
-		if (noplen > ASM_NOP_MAX)
-			noplen = ASM_NOP_MAX;
-
-		for (i = 0; i < noplen; i++)
-			EMIT1(ideal_nops[noplen][i]);
-		len -= noplen;
-	}
-
-	*pprog = prog;
-}
-
 static int emit_fallback_jump(u8 **pprog)
 {
 	u8 *prog = *pprog;
@@ -1589,7 +1613,7 @@ static int emit_fallback_jump(u8 **pprog)
 
 static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs)
 {
-	u8 *jg_reloc, *jg_target, *prog = *pprog;
+	u8 *jg_reloc, *prog = *pprog;
 	int pivot, err, jg_bytes = 1, cnt = 0;
 	s64 jg_offset;
 
@@ -1644,9 +1668,7 @@ static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs)
 	 * Coding Rule 11: All branch targets should be 16-byte
 	 * aligned.
 	 */
-	jg_target = PTR_ALIGN(prog, 16);
-	if (jg_target != prog)
-		emit_nops(&prog, jg_target - prog);
+	emit_align(&prog, 16);
 	jg_offset = prog - jg_reloc;
 	emit_code(jg_reloc - jg_bytes, jg_offset, jg_bytes);
 
-- 
2.20.1

