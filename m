Return-Path: <bpf+bounces-58219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9062AB734B
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 19:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3941B675B3
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 17:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19A328135D;
	Wed, 14 May 2025 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAzDKHZ5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B5B1DE4E3
	for <bpf@vger.kernel.org>; Wed, 14 May 2025 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747245263; cv=none; b=bQeuBbUX5UimujuqF2OxHu/OJoicp010XuOZ/1yC64XKolLUmqHFe5qy5VQx0yo+AxXJLjoBDPl6QxQJh5psvscMC7mNm4KoaGTttqpa41dwRSMSIHM4tt5h97/gbTdl/bI2uG7VqbGRq0QghFuj6dSGTddQQJ03Pt0DoqlFUaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747245263; c=relaxed/simple;
	bh=JTDe78uJpf82TUyDu8gZLZvTkhHCeOJHhE+jQ8zrQOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qJohXlxrSRMzIKm4sAlpGac14ZmJeJAYeaYuDqyiO0SpoxMR7jiVOnSugpoQGZQZyFa9ogtTvzzhquLHV3HY6SSMXh80V/u0Idtrcc1Qa6r1bO3GbScJvx0yzf7TdaMcbK0XkaTdJ9Q2sCFkVC6djgMjZA2ERt7oIPUVs9RjhLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAzDKHZ5; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-442ccf0e1b3so961535e9.3
        for <bpf@vger.kernel.org>; Wed, 14 May 2025 10:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747245257; x=1747850057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bQ+O66URuyey7H1vv93R868WovwkRDn4kOa1PUgm7CQ=;
        b=LAzDKHZ552B0He1n1CenukIhVk9AIbIXdR+M7v0929Bk61MCjPqk3SK7LlHEjHL0Nl
         0sLZxoM6KF/jjlnaTg6BmK7lfLRjoNfyQqLEKIk73crxN+jNUExxpN+Ungqu6I3LyAMr
         EtD9c+RQB/Y0K79hz0SmgJ8d7LNSGWuZb4Sx4foBdfF1KE79slmNH9otttvVxNf3ON+u
         KvkYd3pKwR7D8pfn5mxJ5Ym5jxUOe7mbjJ6m47BZy8Od8nsjCTN3qjFjKwAfrJl6bIz9
         EmlUHYQT14tuQmm7EzFdRrgpJjug0pGUAgasaQ//eO9ky/P//OiGabrxAoY8yF7fOrpv
         FmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747245257; x=1747850057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bQ+O66URuyey7H1vv93R868WovwkRDn4kOa1PUgm7CQ=;
        b=mDoI51OgQqkmTPWCGleBLfX5hkxt5yfCZx+9ExMQblnqNU+rrOc80LH0nB5dJtv6xr
         JtONXAinOgSfBsNGTJMgG1eJmN0z7aROF7DbHfzNb3tqskEL/wc/TT9sWsjoFrvRCel6
         /emCwu1xoBDGCOTCaipuLlP1b9QjE59Ud9i4474nsCJoQdwbcTVSUHWnuZ191bJ6GALB
         AL9ow7VcFk6am6PExJv0FxolFJTtyr2axqslVDqJn/ZDpVduJmGWmaA+jBHfOmDmLi3x
         a8brcMxabVewunvsZnm0wS0Rnp8arTK++Jw7gv9G0Dg/zEVzXwxOIgG0W0jgZoTDcg3S
         7Ijw==
X-Gm-Message-State: AOJu0YwiW4FbLBh9Doo9ClmN5zd9xW6q7yJIE9fx9tZKUz75iwj4rOTF
	0526KsrR6LNl19P3JxAX2X9gwj4rupqpI6qXDiKaGJEiq1XGIzUaF4y8DXA+PUjGbQ==
X-Gm-Gg: ASbGncvXAW3AIO5NK0KbyqFo3HVo7oCTzAvSBgRa2lAnOpkscPiWNwqwwtW0UwN/mvx
	9MVA5QuNM4BPIrveR/AOZwFVJEMfYmkqUAMTSCHBFR2M5aT/FvUNCrOnYP5zEAkLBkSY59diTjm
	Xs88SOnrTxzAC1IE80HMP8FU20zulY7yQbhyncVTDjV7qn/XKWwdBL6YB8Q1NhfhkbIcG0yZY+8
	bh2LMmAwLXi6L+XyVpZXqPOQr2KAAet9nH1VBxAFyN/blenxu/w0u2wvftOtxx3daNL/i/ENN1m
	ZweZi11D1iLajaIF1qDar7T37LW16FEJ9CP6LrSPsA==
X-Google-Smtp-Source: AGHT+IH2Icud5C9sWVXAirZXoIRzoy1eRLsuXXBYfXxmPKJFsdRMln+Khc4ktUU15cFd/lsuDd/LwQ==
X-Received: by 2002:a05:600c:4e0e:b0:43c:fdbe:4398 with SMTP id 5b1f17b1804b1-442f20bae9amr40739775e9.6.1747245256756;
        Wed, 14 May 2025 10:54:16 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:58::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3967f62sm37374835e9.25.2025.05.14.10.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 10:54:15 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2] bpf, x86: Add support for signed arena loads
Date: Wed, 14 May 2025 10:54:15 -0700
Message-ID: <20250514175415.2045783-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5879; h=from:subject; bh=yh4YVc8YUzSLLXlyb/EA9Dz4qOvDSLw2sR2sys/L1Qk=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoJNf59jGw+NtUSN4EKo7gJXansMEUZ2hO+GXhsLUf gdhVneyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaCTX+QAKCRBM4MiGSL8RyivHEA CL68dI/L26AEltZboREAWo+jkJ3QAKi6g+CosfYzbA6UPlm75/w8T88+qTs219sDR1aWjComo/O1HA K7bXb/5b0q3Dz0tLikSwAlt+9/ovv2f20zwAX1Kaev2n820minLQTCkZOQOThWH1BcBpkwK19daEJO U1P6cK1St8/NVWyazUS/KM1+t0i45JwaVXU6LGdWuT8EuJrK5tHFUVVkpvnkpBS8Wzh5BjVVsrduXE zloYHfdAG5ACIFmRXZa/rl6koZn5W5UoAH82gmfEqO+dp2LhYCPGIM/WmaA6dCKwCGrHiYsiwOVZ1L 6ip7swYAx1l9P99XbEtRDZPJTZO0+i6pdaHuZv6OzzYSELUeXT4Pz/5p35UeltHmMT8n8Q1XBKIrD6 +kpJZ0t6KEFAd9087oU31NphC11awEB5RshGGEBcn/kSsUdysyw35DjQ2o8x92T7Cd8xAj9+ELwGXV hL3xAW4Y7Olm1iOOLbYk2HzS9AwPsgoCiYoLgXtYF+8Xp16/AjGea084yr7NsuuU47K670mVMmvz9b nvFkcXZYw4ctatcr5Pf2STGFxSC2FeqLxBSzRPc1E9y79RdwTIkYjak3SYbsN73v4UjJeKp5OJ1sWH 1etSwGgrexksv2At4Ni8U4nnYbtvA8/Qjtlx5wy6lJ9caoPNGNBrdlXldFfg==
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
Changelog:
v1 -> v2
v1: https://lore.kernel.org/bpf/20250509194956.1635207-1-memxor@gmail.com

 * Use bpf_jit_supports_insn. (Alexei)
---
 arch/arm64/net/bpf_jit_comp.c |  5 +++++
 arch/s390/net/bpf_jit_comp.c  |  5 +++++
 arch/x86/net/bpf_jit_comp.c   | 35 ++++++++++++++++++++++++++++++++++-
 include/linux/filter.h        |  3 +++
 kernel/bpf/verifier.c         | 10 +++++++---
 5 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 70d7c89d3ac9..19524694151d 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2753,6 +2753,11 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 		if (!bpf_atomic_is_load_store(insn) &&
 		    !cpus_have_cap(ARM64_HAS_LSE_ATOMICS))
 			return false;
+		break;
+	case BPF_LDX | BPF_MEMSX | BPF_B:
+	case BPF_LDX | BPF_MEMSX | BPF_H:
+	case BPF_LDX | BPF_MEMSX | BPF_W:
+		return false;
 	}
 	return true;
 }
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 0776dfde2dba..cdcd33646f71 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2928,6 +2928,11 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 	case BPF_STX | BPF_ATOMIC | BPF_DW:
 		if (bpf_atomic_is_load_store(insn))
 			return false;
+		break;
+	case BPF_LDX | BPF_MEMSX | BPF_B:
+	case BPF_LDX | BPF_MEMSX | BPF_H:
+	case BPF_LDX | BPF_MEMSX | BPF_W:
+		return false;
 	}
 	return true;
 }
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 9e5fe2ba858f..79662b5a1e08 100644
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
diff --git a/include/linux/filter.h b/include/linux/filter.h
index f5cf4d35d83e..aab2f1ec4542 100644
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

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 28f5a7899bd6..917bada34c2f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20957,10 +20957,14 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			continue;
 		case PTR_TO_ARENA:
 			if (BPF_MODE(insn->code) == BPF_MEMSX) {
-				verbose(env, "sign extending loads from arena are not supported yet\n");
-				return -EOPNOTSUPP;
+				if (!bpf_jit_supports_insn(insn, true)) {
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


