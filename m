Return-Path: <bpf+bounces-77781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04730CF0FB8
	for <lists+bpf@lfdr.de>; Sun, 04 Jan 2026 14:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE4823053325
	for <lists+bpf@lfdr.de>; Sun,  4 Jan 2026 13:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD3B30214B;
	Sun,  4 Jan 2026 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eC19nzPq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175A83019C8
	for <bpf@vger.kernel.org>; Sun,  4 Jan 2026 13:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767532631; cv=none; b=G4Izyzjs1aOD6sMXk5oRfBdHbRoRds+LeCw2ulk/8dqr5lkGz5VdGUwPvfG3XVUCYGDJWnszRQ9O8TxFM+KCcmfZO5rCIbMl2nPX+D+YlVkYAsaBaKXc7bwROz4UECk0cWECL9UPbJVL8amKLr12fYsiIp+Sb28C2+5MVFKp30A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767532631; c=relaxed/simple;
	bh=/qur8w2m3vMGNgXbvDT1SsOMMmCsCxiM8C5YcQdLMW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4+nhA0KlDJ7ycHG9db+TLWuH9Duc/m3wEahVcgo9vsazNqwCwIxEg0X7TCPnCIcg8NzMwZ9yr+fUwnqoreyosYIRQjxZGSCnnA3+VcVM4ZalSGo3mgHsCd9OjK3qXBgqINouNw1TZDHfiXB0kHayXwYXkjWOgY3zHzWBqeo5j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eC19nzPq; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-34b75f7a134so9664956a91.0
        for <bpf@vger.kernel.org>; Sun, 04 Jan 2026 05:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767532625; x=1768137425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZWi9RoYleJZ65oSevNjm7jxGwIwYCJsYhnSjqS+rL0=;
        b=eC19nzPqpukaTS/kMlsUq6SmoU3TEpSkG1Kuyvwf35oWlxAdSrUVd31/X4fEfpjKWi
         2Jii6diZL0WU//ZLmfzC16N7ngU3rctdDeAIafWtM+sH4GRVovLX9St6Uk10TkYR32W7
         BueWSJU0qNBh8GnZOt4Te3Ab1/gcg+Ut3iLThKkCj6O89m+0vD7KWCxxmaGYZcCCyS58
         nu5oInQoFaD+2uJKrGXkZ4m/Qx2ZsWz+R+kJUV0YQVWUbjBCOkGw9T16dCc5kw36/xJ6
         thWnkRQ2q2iqsBefjuqxYM0UBLq71yrwku27BufL3VsW6RnGLiIe8x0HrpBqsiRfoxb/
         vFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767532625; x=1768137425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BZWi9RoYleJZ65oSevNjm7jxGwIwYCJsYhnSjqS+rL0=;
        b=XM+jDto20BAwLURck6h+zFE0LPmsinYgFEzaqtUBBTX+JeIfqArtwLATgcrcmIrv6w
         iyz9SC8rtyJozi2ouiZ5UceUMqAJBQSuQwYV3aBi4LS2CG5BEpp+dNu4jesEIKBwEkV0
         UZGhY5b3lbvB9IQdOzFPFhM5ZVjuqziFQjQXfXqWwwLdlFgr8v0TYVT5sfc+1QZFM9at
         OPGDVM8jqg7xfWdS6q3hEK9Xl0TP59W9UUqVbSlpoztxatkYxKYWFK0XRB5BjxZ5Oq6k
         qisD79ecd9uxfC0x5xe64/uC0vY+ezXm3jRJTD5+hNLhW6JtBbTdA1CsXxaTdSwS1c9Z
         cK3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZalqsu6EF0Tp1+jeflEefOHjMfeap28yja1cSBqJj0o1aa4Ba4iODzCVwzvzU51z+wrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDcIRTO/P4X6u4i4O7XctnPagmkc1Tm4gPDt9F+W5bVF/0ZCfa
	Qfny83uXMddYsPt1MZ4DPZgEQy9T4Tz0tXH5xsLrjx4bqz2N70LvhR1R
X-Gm-Gg: AY/fxX6MzAJrt/6VEohC2xjZ2L6JwlP9u4bFpSP8Qh6UIyoFj2gCesPFvDZv/tKXS27
	Z+cd5aI3z99kyEqKG06fCRjYRWqalFBr5RKBoqo0sXUYPYLHEt+TwSplCFrPARBO8RZWRCHQmRr
	6Xsv/XSGR4n3Iwe+wdufLaAZUu/wF+r2EtktNOdwDHA/KC4QOkiXJ5Hd2xql+xMVe6kobKUjcZX
	S0Rfj8Nq/+yrXV4sYOiQEZWnJDa0KF4hre4WDT/LB/Lki3GvQRVwDfi9meZbQ0wVS3D4oIfAjSr
	bSc1lTH+Dij/IQzZoSy20G77aIT5FHRfWhYHzPqjwy/4WqvX8WrtivTFkA7cu5MsYp0U+az3fBT
	AQAIx/V/+8h4StnNrgQLziygKF7VkVmG38o2uDKDrzI+/Uq8uSybh3bTNwBkBWn4F6cD3YDBmHU
	Tad9gjQ20=
X-Google-Smtp-Source: AGHT+IG0dPYNFfnc0boh/nEnep4wDuUjmOO/6IO4xvFFOws0Hne1b/dfxRdokETIhohuNf3Ig79YzQ==
X-Received: by 2002:a17:90b:3f90:b0:340:bc27:97bd with SMTP id 98e67ed59e1d1-34e92129212mr35917760a91.9.1767532624769;
        Sun, 04 Jan 2026 05:17:04 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f4777b765sm3701582a91.17.2026.01.04.05.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 05:17:04 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	eddyz87@gmail.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 1/2] bpf, x86: inline bpf_get_current_task() for x86_64
Date: Sun,  4 Jan 2026 21:16:34 +0800
Message-ID: <20260104131635.27621-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104131635.27621-1-dongml2@chinatelecom.cn>
References: <20260104131635.27621-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
to obtain better performance. The instruction we use here is:

  65 48 8B 04 25 [offset] // mov rax, gs:[offset]

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- check the variable type in emit_ldx_percpu_r0 with __verify_pcpu_ptr
- remove the usage of const_current_task
---
 arch/x86/net/bpf_jit_comp.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e3b1c4b1d550..f5ff7c77aad7 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1300,6 +1300,25 @@ static void emit_st_r12(u8 **pprog, u32 size, u32 dst_reg, int off, int imm)
 	emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
 }
 
+static void __emit_ldx_percpu_r0(u8 **pprog, __force unsigned long ptr)
+{
+	u8 *prog = *pprog;
+
+	/* mov rax, gs:[ptr] */
+	EMIT2(0x65, 0x48);
+	EMIT2(0x8B, 0x04);
+	EMIT1(0x25);
+	EMIT((u32)ptr, 4);
+
+	*pprog = prog;
+}
+
+#define emit_ldx_percpu_r0(prog, variable)					\
+	do {									\
+		__verify_pcpu_ptr(&(variable));					\
+		__emit_ldx_percpu_r0(&prog, (__force unsigned long)&(variable));\
+	} while (0)
+
 static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
 			   u32 dst_reg, u32 src_reg, s16 off, u8 bpf_size)
 {
@@ -2441,6 +2460,12 @@ st:			if (is_imm8(insn->off))
 		case BPF_JMP | BPF_CALL: {
 			u8 *ip = image + addrs[i - 1];
 
+			if (insn->src_reg == 0 && (insn->imm == BPF_FUNC_get_current_task ||
+						   insn->imm == BPF_FUNC_get_current_task_btf)) {
+				emit_ldx_percpu_r0(prog, current_task);
+				break;
+			}
+
 			func = (u8 *) __bpf_call_base + imm32;
 			if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
 				LOAD_TAIL_CALL_CNT_PTR(stack_depth);
@@ -4082,3 +4107,14 @@ bool bpf_jit_supports_timed_may_goto(void)
 {
 	return true;
 }
+
+bool bpf_jit_inlines_helper_call(s32 imm)
+{
+	switch (imm) {
+	case BPF_FUNC_get_current_task:
+	case BPF_FUNC_get_current_task_btf:
+		return true;
+	default:
+		return false;
+	}
+}
-- 
2.52.0


