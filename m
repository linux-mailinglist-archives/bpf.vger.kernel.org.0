Return-Path: <bpf+bounces-74488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD14C5C4A8
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 10:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AD77D3628CC
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 09:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7DE3081BF;
	Fri, 14 Nov 2025 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjmZXHsv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC7C30748A
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112310; cv=none; b=EIxUEomvhzeyrAw+G3Di31R71Hpelj4FBpNQ0nPk28YSThSt34Xm+lXgjSs5WUVJyckovBevMg50moUF3ZzxFdVgGFEW1b+X1LwVC1l+2pqoXMPbqHrA+KSKRIX7VntgHFt86fMh2WvEORQNJzSIbEXNi7SMQQdttpnI0/fiM7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112310; c=relaxed/simple;
	bh=gokrqToajl3qLeodPuzcgSTB9cabw/WpaV1bSGQlVLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqR6donxolWeuglZTYAKgxo6SzDSUStf/ocjBzvISIPN5Qg79gSv1WIsHLnjA99Nv/nmKA9waJ0QxmLk58sL+LjWnbkb3q19i243bRr7GnMiCT6sBEIS2hegco4AMd2Uf9REWncflWl4biJHr0fQpliqmiBL4TUtkLyv1VitblA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjmZXHsv; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-29853ec5b8cso19943265ad.3
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 01:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763112309; x=1763717109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2wIn/kARIOhJ0xgPL8i1YkD6/QkhYtCyZijlaHlovw=;
        b=PjmZXHsvrHkZX1BfPdMHG1LHO+98ercxeRnouDfeem7fxEpj+PUhudvllYXeEuQ4/U
         FuT6ehPHuJspLMumi9AINBr1vPA2JVl8S2YQLy4FKYSZ6aSZF48ZLZofhFbvOxWJ/02/
         +LF+cz/cia+PdpH0TvPIjwx1CV4uiTfIsCQFIq2IyxzpsujoFwm6UWx/v2m/bqbzoJFD
         ef8XIhouSlk/N3xz6iEFvQuI/U3MjK0ieSITtEbufSq0P8QmdA9sZXuT4iTfOrlzLUnf
         IRfnShm2o5/zgstgFCRkgWEoI2RGObF7GMJB/d10XZX/TZdxprnqQrmgqzF73LpIXbOr
         +ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112309; x=1763717109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c2wIn/kARIOhJ0xgPL8i1YkD6/QkhYtCyZijlaHlovw=;
        b=TCBhM1ovkXjgbrS19kvXz9SakKRcxFQcgDKv9/Tx8awmf4V9TxenQc5Hmcxh0Hn3vW
         HnQ4y9fUqyP1Y8YjVy7RYDot2sPX3/OxdQ2p9IMcOpdCfqnJz5VyXp0oKEAnKF3Z2bAb
         zVIBys1zJEHVo9E70ElEIyr6bC/LEV7DFvl6iqLbUolKLDp/YZl8Nyob1AJ9fBjhvQOL
         paYs7YFdoB3Vn42eeAtFWSHapBzaMRIfuNEhZBnJKjYXkXdEb2ZCDUjeki+kbUvd3EqV
         2AHOrYmi/zjthz+zwXyxfaMuEUpvHsdNTqQMebg8wPJ2rNmhIT5Qhtdd16fSD6ebF0j6
         D/hg==
X-Forwarded-Encrypted: i=1; AJvYcCVkJVatEGgNx0HIhHUglcDLmiqQiic9dsTzpLX4d58zZNExcEZY1fc9Whv79BbeDftuh1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YziwYUhyPq8FT7zrFpRs1zr/YAmHOWevgb9wmsjZwCbgU50+Va7
	pDMsxDTazLfUYZ2VsG64OT0ujqCJMrwFoYUgNMA25dPKof/MUN1K39Fq
X-Gm-Gg: ASbGnctgD5o9tur113Ek6lSgoSILqj7Z64Us1nNS8JEyU3qiBnINf717v06jWW5PvXB
	CZU0R6G2yDnolvMVme3sHHY8G3V+yGLjl5EuakjLUkFLf+NG/PDsnx/oCUWHnKPQZud/YnDTL66
	MFrXS2wk5t54k4oE3xhentI0Y/fXyv6Vq0wpz/5cwopelBI0G8T2baAY0lhErMhUcRX1hYCO+ze
	hy+CyXSrw9u0o5FMtuTtPgaeyoYGQPJ4E+Gxpo/a3rqVBBYwzHjmSarmW5QjsO55Bumbo0F7H9X
	oKi18is94zW1EpXJJOY2SmKreQJp0bG0q+5JrI5eci39rGqFP03uuE7aA8WyjDwWTJ9Hx5E/uAk
	WlD1eHkY6daMcD/yRKV8BqdFRB5DIDoyNHGHz2TsQYGcyOmTDYh54yS95W+c/pmzVNbi1xTi0Bc
	Z6
X-Google-Smtp-Source: AGHT+IG5VnwBl+1lxPrp6qdos/kEJNYbsFAuD4akbBy67+ZoqlT1tPAQmEIH9GoRP72WFoHDwsjAMw==
X-Received: by 2002:a17:902:f60e:b0:290:c0ed:de42 with SMTP id d9443c01a7336-2986a7417b8mr26050145ad.36.1763112308699;
        Fri, 14 Nov 2025 01:25:08 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346dasm50451525ad.7.2025.11.14.01.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:25:08 -0800 (PST)
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC bpf-next 2/7] x86/ftrace: implement DYNAMIC_FTRACE_WITH_JMP
Date: Fri, 14 Nov 2025 17:24:45 +0800
Message-ID: <20251114092450.172024-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251114092450.172024-1-dongml2@chinatelecom.cn>
References: <20251114092450.172024-1-dongml2@chinatelecom.cn>
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

Meanwhile, adjust the direct call in the ftrace_regs_caller.

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
index 367da3638167..068242e9c857 100644
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


