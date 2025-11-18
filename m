Return-Path: <bpf+bounces-74955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2796EC6969F
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 13:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 0A2F62B3F7
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 12:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF5232E12B;
	Tue, 18 Nov 2025 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJ6PDHPU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6588733DED0
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763469424; cv=none; b=CussSt0zQ4Es4FWe0EX+FD9E+4mrttv668zQDIU0brZ+lHemnMaJUSm+X3C20xvRgmClOQRZo0Ao2xZxcdX9381G7gLKBH/CRQ1J0Cf4jpDPTFYSdV+6yxFqdKg8KAA8jWzr9RaCk6v1HIv/Ie+wDFsBmapM6ye6iLfL/6qZnrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763469424; c=relaxed/simple;
	bh=yw0+14vG3MTkylBTsNGEjI1rTbbl51z2DrBpLhZnx4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUgyGrCcYH3a9tE0hJ6gg/uEnlw0mBcfCSNnbdkcVfa82KjJTpo2Ogt7I526KVyGHrpP0ox/8xgoQv6TKYeOL0zB6WYMlu9HKOK5q/BDYSxjc+5RczjUGxg4coPae2WWBnU0owBi9GDUuS1OS6jvb74bKIa/rCvj+XW44rEgZAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJ6PDHPU; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7bab7c997eeso4206331b3a.0
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 04:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763469421; x=1764074221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRkWsGzjZIg7j77yjUEwdtDGoZTowRE1mWBAeLLFj3U=;
        b=XJ6PDHPU/43Hl58ZLURBIl0aD1bLDiWd/ZXkuC7Ivd8A5Xl6SCaLUOPPzeOFplUUmY
         8bdgrxGb8WfYWTclxDAQadta7nXpRXIwXDQTojnC1jqxEMU68wqJQ263XQShenChUM2l
         6cY5SqlwkYbQ2xeOB9OsVEK7X8hle3Dngo6TttlwgMW/uQp8iFcRoUXDOVfJMRP1iNgZ
         GgAATu4QyyiSv9E8Tkzh/Ppl+O17bRcDTfESNfST2L7t+gjZNYRcAnH5imdeQLjno5AH
         RDbezKUFs2Kw5vxcwS6UHhnxV6MZfGHt/YwH9RkE4CZqlBNBiYKkpESBmKuFcFEIq/Na
         AQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763469421; x=1764074221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KRkWsGzjZIg7j77yjUEwdtDGoZTowRE1mWBAeLLFj3U=;
        b=elJCW5tcesSMH9ln0/2aDktzcNJn/80mae1UhXL85ymWNqjpy3GsobV6K20GqrFafp
         mvCKlmD00kHNMt9hD6xxvaNCQiOPUfiXJyLhWQjQlcxG7pxKS9zguTpcdf04k7fU6D8D
         0uiK3d/QbLZkskCSrC54vnseyjrnrmrR5KoTHpc/0IAVZngKgJgYVyE/5lYd0s0j3dgO
         ttUOoEiVGlOL4M2mJpbv8OZK5a2fsantdFxf3vxXuHpq9Qo3shY7DGp73wvZRh451nE+
         h6xrcaEid/ZOwsH2qEFZ4SxVPPtQjwrca+AoRC24SdVaha54txQH02eMDjwBWEfnJCMa
         /urg==
X-Forwarded-Encrypted: i=1; AJvYcCXufiWG9GIq7vhXnEqIPN82+VkhRRsNFIOfe4x5iloH2K6OMJ47EWiEW4gMuQLfMPIhGbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn+5I1PlbJ3rGLfi62819n1snpA/5t2N+sEQSOEZSWQno9EU3h
	aN+ThwJ8x6Rw1moI5SHK8A5htXADRFVWApvcpbGRvFKbhxmozWMWM6U8
X-Gm-Gg: ASbGncsTSXjzPfH8NHGeJPJTqc0ks0THtKtNjV+uH7vpXRCLp7I6Mf5kqp8x5KsPi1+
	FVCq4k77sS3L8vPcXRQxqTHkxDzXY6augOtBX8ObqeT1goJBAd34PpZt4GmmvVXmHrBVng8lImw
	O6XVbbxXCP4li2ML7FMRkNVt9gZODjaYY1nJsDHiu2d7NSo1W9JcP9RZxj0cyBDHVbQhschF7LC
	M5jkefkKS2aOlrnFY7wk8x+M069Lp46oJ8MA60/55rjRFkaF0nZOQcyO7U3WgM1v3GYL7sBeD4d
	Zs6hWG9TfrlGhnpo22z3FjlInWquVzneZfhU5LLjlvjQlvmMEJ5aYs+sVhirAXFpYdD9Xfc4zR2
	x8rPincPVV1EK13eI4XkDPyp/hUtqYvnpE++S9Vhg1SAlLksfjNlERIqOl2+M89cBq/haIzdNDM
	pFjcng5WJ/rbM=
X-Google-Smtp-Source: AGHT+IHLeC9ZWRL2VLtRiE54fQ6H+bxg9/eru6ZBoKg3v7IDmaLDmUU9coK6XPoveKCEmhT4BZJJbA==
X-Received: by 2002:aa7:888c:0:b0:77f:2dc4:4c16 with SMTP id d2e1a72fcca58-7ba3be8c664mr17780783b3a.21.1763469421399;
        Tue, 18 Nov 2025 04:37:01 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b92772e7f2sm16331496b3a.57.2025.11.18.04.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 04:37:01 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	rostedt@goodmis.org
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
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 2/6] x86/ftrace: implement DYNAMIC_FTRACE_WITH_JMP
Date: Tue, 18 Nov 2025 20:36:30 +0800
Message-ID: <20251118123639.688444-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251118123639.688444-1-dongml2@chinatelecom.cn>
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the DYNAMIC_FTRACE_WITH_JMP for x86_64. In ftrace_call_replace,
we will use JMP32_INSN_OPCODE instead of CALL_INSN_OPCODE if the address
should use "jmp".

Meanwhile, adjust the direct call in the ftrace_regs_caller. The RSB is
balanced in the "jmp" mode. Take the function "foo" for example:

 original_caller:
 call foo -> foo:
         call fentry -> fentry:
                 [do ftrace callbacks ]
                 move tramp_addr to stack
                 RET -> tramp_addr
                         tramp_addr:
                         [..]
                         call foo_body -> foo_body:
                                 [..]
                                 RET -> back to tramp_addr
                         [..]
                         RET -> back to original_caller

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/x86/Kconfig            |  1 +
 arch/x86/kernel/ftrace.c    |  7 ++++++-
 arch/x86/kernel/ftrace_64.S | 12 +++++++++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fa3b616af03a..462250a20311 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -230,6 +230,7 @@ config X86
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS	if X86_64
 	select HAVE_FTRACE_REGS_HAVING_PT_REGS	if X86_64
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	select HAVE_DYNAMIC_FTRACE_WITH_JMP	if X86_64
 	select HAVE_SAMPLE_FTRACE_DIRECT	if X86_64
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if X86_64
 	select HAVE_EBPF_JIT
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 4450acec9390..0543b57f54ee 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -74,7 +74,12 @@ static const char *ftrace_call_replace(unsigned long ip, unsigned long addr)
 	 * No need to translate into a callthunk. The trampoline does
 	 * the depth accounting itself.
 	 */
-	return text_gen_insn(CALL_INSN_OPCODE, (void *)ip, (void *)addr);
+	if (ftrace_is_jmp(addr)) {
+		addr = ftrace_jmp_get(addr);
+		return text_gen_insn(JMP32_INSN_OPCODE, (void *)ip, (void *)addr);
+	} else {
+		return text_gen_insn(CALL_INSN_OPCODE, (void *)ip, (void *)addr);
+	}
 }
 
 static int ftrace_verify_code(unsigned long ip, const char *old_code)
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 823dbdd0eb41..a132608265f6 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -285,8 +285,18 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 	RET
 
+1:
+	testb	$1, %al
+	jz	2f
+	andq $0xfffffffffffffffe, %rax
+	movq %rax, MCOUNT_REG_SIZE+8(%rsp)
+	restore_mcount_regs
+	/* Restore flags */
+	popfq
+	RET
+
 	/* Swap the flags with orig_rax */
-1:	movq MCOUNT_REG_SIZE(%rsp), %rdi
+2:	movq MCOUNT_REG_SIZE(%rsp), %rdi
 	movq %rdi, MCOUNT_REG_SIZE-8(%rsp)
 	movq %rax, MCOUNT_REG_SIZE(%rsp)
 
-- 
2.51.2


