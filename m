Return-Path: <bpf+bounces-74688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19546C6246B
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 04:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40B6F4E81D3
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 03:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EC731352E;
	Mon, 17 Nov 2025 03:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkPynhKe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBFC315777
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 03:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763351369; cv=none; b=o8DUGEds/SE75mBvD3vbcqqXwPXsGT1RiKFiZKHX7ciCkLtUTLCRvq4mVc2HlS3tLodQmGJ55k6adPmvPJhoMaZK22IT3gSG6VWZQiBVzbZy0aTldaJe7CQVJ6y0XiwS+lPKBfRLhnMvevxmrWoICnhyUmWNfh9td/aknkV/agI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763351369; c=relaxed/simple;
	bh=yw0+14vG3MTkylBTsNGEjI1rTbbl51z2DrBpLhZnx4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTCQR3Kto/bH9pG8Jagj/P7fpewzkerj4dysktPbdusUW1VpgisUxtrafBylRwD/kjykiqHoreADhzrYAJkicqdzD2ccCR8EsVkcH/zPOMbX+uV5cFzcKi2YsD3VYjwFYopkGIc1JT1JmDr0cMeii0vFUQ6bIZium5AXNE3cg/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkPynhKe; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7aad4823079so3368392b3a.0
        for <bpf@vger.kernel.org>; Sun, 16 Nov 2025 19:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763351366; x=1763956166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRkWsGzjZIg7j77yjUEwdtDGoZTowRE1mWBAeLLFj3U=;
        b=hkPynhKebPTTFVqZuhGue4sgPwRj245N5SF2dcLva3U/90CsNJu4tsf5DWWoVFevGJ
         vQ0rEwVYaT+wyu8CvLqLlEdQEfnmVg3tnQLRgrre8Houy4GFeSbsv5UPOMdrF2+nx+7L
         uV4xTMZ+6uMcKoJnKrKW5JEiQ4ymft5i3P8KrNB0TDAtddCsfWdKsUVO7yCDlif5F6Gg
         F6WJDsK25MVezlk4pX1BikRIWbG3O8amqRMtjgNdXiDEmbksTPnVsGe63oBcR5KDQuXK
         Oj+ux5idxqjqokGvAJLqlfO3Wt1Ct1uj7dfUzDfahH8naZhA2iXWGaJscpsVfDB6L7h0
         UdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763351366; x=1763956166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KRkWsGzjZIg7j77yjUEwdtDGoZTowRE1mWBAeLLFj3U=;
        b=g9Lkf2dduwSZKp4/c+triHCNWfj6uzdYPYOkvY8rFnsP4SfRGLhAl94Co2diCWLy+r
         9WxApUviEGPQ5XZT9mU43S8fcQpkjy8q5JeWdEPSx4thUI+WLyW37TScvnZLaRj9M+g1
         0hj6f2et8iP8/UsMFJ443c1W7zzKiMeysX8r7C3TRiERM7nAdWRXaIy2vrgueyklbd5E
         wnEKtUTy+ogfGzO5iyNQDO/7ALGR/mjrX45i+WhD9u2mVhci/U8LvwanvfcWEzTaArOr
         n7aAeQe5maYjCxd8w2EZxbBELUYxsnrGBZKLUoZ8GFvFttNtxvIfEVODE0ZWZzoE7EUO
         VheA==
X-Forwarded-Encrypted: i=1; AJvYcCVZFPN1LiwKirY8UwELAWHTH5XEtKFBpooihs5TWNYHQOO6/3ON4+3teDkNINvQXkAqkIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzDDBTlZBAGbaAQtcgROzxRpBwmo42WR9HHkVWWGlayVjyw1pT
	UiFh/uRX5piKqMvE4b4qC8FIuQIWv+PlHM1poESHz9YsJZHd9syajXo+
X-Gm-Gg: ASbGncuSF1KxoxCy2d0oWGOVCPt0nvpoBf+0I0Al0GOQsSiO+5FyB5bmdnEuVhGwauf
	9w5shUY+7TRKLTL4zR7H7Xcg1fp8dYxVnoKhSSGTCXbm29Lps9KQuc1KoFWsSoU7AoV6WFVSKta
	JXGeNKj0LV6jPkbpqQf/ZVuxhkaLAiSOwzqx2MHRfaf+dAMXiszInqTGCzlbV8KvZvVOX8xBuTG
	KLTxzjCGZBb3UHAlrUthKJEak5sbCBZfKuKoOBIcDJYhlpwDeSIUMai7pCywd+08Br/q6o9xCOG
	ImY3WavA6Y/XEv0CYs+Swxb77m+AtzCLXcVJWUXo7Lcq70G4YKjqxhUPFILsy0yG+xrhGdx8cDM
	KMV9TsLKK7Epn3zrftAeKZbvo5ntaWBhL4ASu4Wlh63kRi92m/4P3n7b1ukmI3AjOM3SWjf7Wg8
	Hl
X-Google-Smtp-Source: AGHT+IEWoo9NvVrwFggEbU1z4T+s2r8capz8djYg6deD4z5HEE79cQawvyH0KkyQkeiQELrp+e/ovQ==
X-Received: by 2002:a05:6a20:12ce:b0:34f:b50e:e2e2 with SMTP id adf61e73a8af0-35ba2f6eb18mr12762977637.58.1763351366176;
        Sun, 16 Nov 2025 19:49:26 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc37703a0d9sm10348179a12.31.2025.11.16.19.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 19:49:25 -0800 (PST)
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
Subject: [PATCH bpf-next v2 2/6] x86/ftrace: implement DYNAMIC_FTRACE_WITH_JMP
Date: Mon, 17 Nov 2025 11:49:02 +0800
Message-ID: <20251117034906.32036-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251117034906.32036-1-dongml2@chinatelecom.cn>
References: <20251117034906.32036-1-dongml2@chinatelecom.cn>
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


