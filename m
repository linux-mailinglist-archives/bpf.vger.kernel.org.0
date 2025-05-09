Return-Path: <bpf+bounces-57919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E011AB1D80
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 21:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A595A98406C
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 19:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C763B25E837;
	Fri,  9 May 2025 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MS2eJrxP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F2725E816
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 19:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746820202; cv=none; b=Jw9CoicywfMkcK3PYgFr2sh15+f+lPf+y2OQFfw2j1hsZnWOmh98xjMt6lHtueqWZZxSHdxKtPD56ew3LQT0Q8fx3TqD6x+ZtvhhdHcVCVUg7CLJjOOmRWTjNFZYMXEv4Qzc+Tzwc9wdZBO8EjaDy4Ct6r6mr8jqZykLsq1TKUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746820202; c=relaxed/simple;
	bh=ujeR9+Yu2v+3m3OQx6qJ/+sPKhJjV9lu0YfCOhOArEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IxO5Td+yTX4io4knBSr28h5i05qCejbHkyDVTHvh4HJNnNk5exaVSN+o4VTaCtN09Sd1WXOw2c+R5KmAEtTfk7jqR3RekoxPcuLfjrdpfWwbQL5qSH+ZPSBVZCyMX7dOhZ3h7Strr0d9Zi/LejQ2ecq/40y/f+HZc8u06iZOwDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MS2eJrxP; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso24730375e9.2
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 12:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746820197; x=1747424997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MoxOrhV92Z+sdG8PEx9fBXDxbF1FW/1DsD7wIgk8cO4=;
        b=MS2eJrxPUgC10c+MtM/eEdx2Mg6hHEe6vKxlVxsC70GcnNwJURPn7M86XnFDc7BfKK
         dklrYsriqlKv6jFz4Eyi8NkXUAXoHhHPtFYyT0t8M4kWvFbc8tm7+9LtCp49uX+RcOxZ
         u+B9NdsagVydwWE+CY+5VucUFM9EnZLydaFmLTgFndETcCs5UhSRM+7ODXzKTCLwJVWQ
         eD41geG+Ba5ALXRxb0/wN7RRN1UKJmUYWspFSralAB61ccAXhZ0eX8xw/70eo6ZXXpNo
         By3r3vqKLSaGhFSjalkewwgTHOuCOsgFJX8oDq5cNlN013FVsMhJOz1rxRNH++DBOFEZ
         CDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746820197; x=1747424997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MoxOrhV92Z+sdG8PEx9fBXDxbF1FW/1DsD7wIgk8cO4=;
        b=jPU1/xqDBm8V1W2ndnvaB/hJGlOEQt7BnqIxnKbwr4aL/k4O6JdwDgUdq+XNsq2faY
         7q0jieDRB5rTPFlTMrC60EYt2QOc+Eb//ahV/tRX3zcAyVForLKXPUnJP5mVlzf5O3tb
         DzNS+HilZnwthHulWPuWr1itIwL+VqyEIaFJqtaw/Yv0TGY0n0SCg4ELRzCM1/WL3XIP
         74lB/Zi9uslW6FhcQN23fIv+FJizHH73kqrS8kJGtxS5XP5BI6JfcHglkD58w1l9CQoF
         IcFyVVw3MOipZxYzTTNKfTVcTWzYm/ZYgWUBMM1uTqNlHvu7k0ozqcodCwz1FsQxAJHA
         br6w==
X-Gm-Message-State: AOJu0YzQ6/2daEAfGlvwhYyeffqH5RteDXEpgRJ4pZUTPtlUKmwzq9kk
	HZo4OLpWWFap294qW92hgTrZj/o+KbFGJjxUEf6BkBFla1daijp4dYGPAubcig8khA==
X-Gm-Gg: ASbGncsz/fvjFUdaFUSFwdw68NSqiVjvnIoFoZxTS0iXrQp2Bb24t2ehbqEC2Q7+3IP
	yKRIdBojd5TXc4HQn56OsA1qodrVjJUjkNpL0vrGK6mlpGiuLr0GfaeieqrW2V9gCKDmNgwR+ab
	bLUVc4285+UVn2kSokss4n7ns7fosUj73yCI69wdyaNszaCBhcHeHK6IhNzWwjWzPJn36DWS3WV
	/TlW6zOc5qMS0GzE7xVq5J4h8FXXJIZaURIxtpkmUFRbnMLzmU7Nb7FKeoKQckqwKJk6PXt+ruG
	yLOv3TiwczDWP4AJuv8hkNc6Pp3u3ZHXg945GcBj
X-Google-Smtp-Source: AGHT+IFLKmNiXn7s50XqOSeHWenusDnUjVTzwdhZg9H3HSM6vpLcdLK5ux8cksDXr5Qcl3wYq3haJQ==
X-Received: by 2002:a05:600c:4454:b0:440:6a5f:c308 with SMTP id 5b1f17b1804b1-442d6d44bd0mr50052725e9.13.1746820197256;
        Fri, 09 May 2025 12:49:57 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:4::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd328f0fsm84503585e9.7.2025.05.09.12.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 12:49:56 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1] bpf, x86: Add support for signed arena loads
Date: Fri,  9 May 2025 12:49:56 -0700
Message-ID: <20250509194956.1635207-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5825; h=from:subject; bh=ubJJfnHXbant5FrCnZDPS9jz2jwMZYaQH9fQp+px/Ho=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoHlvOTcNPo5Btc+/CyCMkw83MQvi1gpkOQHtMpPKm fFwsv46JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaB5bzgAKCRBM4MiGSL8RytJrD/ 9eXNaXVz/l6XDKuakpoDJdKwGeuFes4bWv3lSgKlyq6T+uYMzPZDDR3CFXOXn+mtjy+TcpwPgtelr3 WZ9XWjkIsY6ZgOJDsG3c5TcnPl0Ye33CErIjCLJZXR4W3KYG0En5rzkdL8WQ9sEvqF72cKit9931vJ S/NA1LV2bFY4N46Igu2SdNlleJAPHRPXgza8lKUxg4n56kiuQo6PNvjTu22ZiBcr91EoKJV3p9zMLA HIg6144XiVQ/MuwG9cIS0XDzzUMQx43VjAfOb8E6TuT4hcxHPIoQJ42VqiRVHQ/F7K0DbQ5mlzdy9J 6Gr0w4uT4HG/rwHy4DOPR+iIAbX8Il9trt6FCT2JpyGdRuufEBJvgdhFTSFwbOpFB+lQQxt5T/mP5H YhT6M6Vt6apPuDYw/x8k3a7BAiV702DKp0RDA8ru5xFY47Lz8AtyqzuBorhoLA4BqRVrU3BOujYksS hU3VVxY6IgKmDWY1wyEto0KzY6hueFD/ZmtibYuNCLpxrR1pl2XivmX03DCM+iY5VJbzR8BXd8uRkt /oKtPiSV/KvoKrN5TbZnT9es3LPjviPP0yBCoEFhnMbI4oYkktJEAs/UK1PagaDPtAH7v/qOkr7Rz5 4oyfmxKelu4EC6kyScK/MUO2Z2mePWs8Q3DalzOVN/l5FUOLhQ7rIja0iW1Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Currently, signed load instructions into arena memory are unsupported.
The compiler is free to generate these, and on GCC-14 we see a
corresponding error when it happens. The hurdle in supporting them is
deciding which unused opcode to use to mark them for the JIT's own
consumption. After much thinking, it appears 0xc0 / BPF_NOSPEC can be
combined with load instructions to identify signed arena loads. Use
this to recognize and JIT them appropriately, and remove the verifier
side limitation on the program if the JIT supports them.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 40 ++++++++++++++++++++++++++++++++++++-
 include/linux/filter.h      |  4 ++++
 kernel/bpf/core.c           |  5 +++++
 kernel/bpf/verifier.c       | 10 +++++++---
 4 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 9e5fe2ba858f..1f1ed0cb7416 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1146,11 +1146,38 @@ static void emit_ldx_index(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, u32 i
 	*pprog = prog;
 }

+static void emit_ldsx_index(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, u32 index_reg, int off)
+{
+	u8 *prog = *pprog;
+
+	switch (size) {
+	case BPF_B:
+		/* movsx rax, byte ptr [rax + r12 + off] */
+		EMIT3(add_3mod(0x40, src_reg, dst_reg, index_reg), 0x0F, 0xBE);
+		break;
+	case BPF_H:
+		/* movsx rax, word ptr [rax + r12 + off] */
+		EMIT3(add_3mod(0x40, src_reg, dst_reg, index_reg), 0x0F, 0xBF);
+		break;
+	case BPF_W:
+		/* movsx rax, dword ptr [rax + r12 + off] */
+		EMIT2(add_3mod(0x40, src_reg, dst_reg, index_reg), 0x63);
+		break;
+	}
+	emit_insn_suffix_SIB(&prog, src_reg, dst_reg, index_reg, off);
+	*pprog = prog;
+}
+
 static void emit_ldx_r12(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
 {
 	emit_ldx_index(pprog, size, dst_reg, src_reg, X86_REG_R12, off);
 }

+static void emit_ldsx_r12(u8 **prog, u32 size, u32 dst_reg, u32 src_reg, int off)
+{
+	emit_ldsx_index(prog, size, dst_reg, src_reg, X86_REG_R12, off);
+}
+
 /* STX: *(u8*)(dst_reg + off) = src_reg */
 static void emit_stx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
 {
@@ -2010,13 +2037,19 @@ st:			if (is_imm8(insn->off))
 		case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
 		case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
 		case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
+		case BPF_LDX | BPF_PROBE_MEM32SX | BPF_B:
+		case BPF_LDX | BPF_PROBE_MEM32SX | BPF_H:
+		case BPF_LDX | BPF_PROBE_MEM32SX | BPF_W:
 		case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
 		case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
 		case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
 		case BPF_STX | BPF_PROBE_MEM32 | BPF_DW:
 			start_of_ldx = prog;
 			if (BPF_CLASS(insn->code) == BPF_LDX)
-				emit_ldx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
+				if (BPF_MODE(insn->code) == BPF_PROBE_MEM32SX)
+					emit_ldsx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
+				else
+					emit_ldx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
 			else
 				emit_stx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
 populate_extable:
@@ -3875,3 +3908,8 @@ bool bpf_jit_supports_timed_may_goto(void)
 {
 	return true;
 }
+
+bool bpf_jit_supports_signed_arena_load(void)
+{
+	return true;
+}
diff --git a/include/linux/filter.h b/include/linux/filter.h
index f5cf4d35d83e..af7e13037850 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -78,6 +78,9 @@ struct ctl_table_header;
 /* unused opcode to mark special atomic instruction */
 #define BPF_PROBE_ATOMIC 0xe0

+/* unused opcode to mark special ldsx instruction. Same as BPF_NOSPEC */
+#define BPF_PROBE_MEM32SX 0xc0
+
 /* unused opcode to mark call to interpreter with arguments */
 #define BPF_CALL_ARGS	0xe0

@@ -1138,6 +1141,7 @@ bool bpf_jit_supports_arena(void);
 bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
 bool bpf_jit_supports_private_stack(void);
 bool bpf_jit_supports_timed_may_goto(void);
+bool bpf_jit_supports_signed_arena_load(void);
 u64 bpf_arch_uaddress_limit(void);
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie);
 u64 arch_bpf_timed_may_goto(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index a3e571688421..2a0431a8741c 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3076,6 +3076,11 @@ bool __weak bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 	return false;
 }

+bool __weak bpf_jit_supports_signed_arena_load(void)
+{
+	return false;
+}
+
 u64 __weak bpf_arch_uaddress_limit(void)
 {
 #if defined(CONFIG_64BIT) && defined(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 28f5a7899bd6..792de030e1ad 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20957,10 +20957,14 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			continue;
 		case PTR_TO_ARENA:
 			if (BPF_MODE(insn->code) == BPF_MEMSX) {
-				verbose(env, "sign extending loads from arena are not supported yet\n");
-				return -EOPNOTSUPP;
+				if (!bpf_jit_supports_signed_arena_load()) {
+					verbose(env, "sign extending loads from arena are not supported yet\n");
+					return -EOPNOTSUPP;
+				}
+				insn->code = BPF_CLASS(insn->code) | BPF_PROBE_MEM32SX | BPF_SIZE(insn->code);
+			} else {
+				insn->code = BPF_CLASS(insn->code) | BPF_PROBE_MEM32 | BPF_SIZE(insn->code);
 			}
-			insn->code = BPF_CLASS(insn->code) | BPF_PROBE_MEM32 | BPF_SIZE(insn->code);
 			env->prog->aux->num_exentries++;
 			continue;
 		default:
--
2.47.1


