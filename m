Return-Path: <bpf+bounces-21069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D88828474E0
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 17:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 095261C241DD
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 16:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34AE148FE6;
	Fri,  2 Feb 2024 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Hbok9IzP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0722E3E1
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891665; cv=none; b=PYnJ+uYBYWha7yxVy0Igwc2/EdZsa0msUyIjZngD6eLWXjQ8TSia7FeRWZ9xQSevvS6Pz7I4fUlynsDRh3+1m2nhsLYf9G0U7jvy8bCx2KiaPjWCpHPMSqYUhmFws5otAFHe8rXjAijJMHskp68JHx+8hbYM+EF9waqtRAKUNI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891665; c=relaxed/simple;
	bh=mzSJZq3Jc5DiGLGTDSv6JFgvcsw52wo529lFsU7tDeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g2Yn+FvtzH+LfIdi1vhpAUZrqvfnmKFGf6+wpjDbOEWv1489ueSa2vfGMvJ6gn6NwpM5adyZtk1kVUgoCue+js0haS/zmFecAJoR+MJIFyblHIeR43m5JL7GmKQz2Of6p4MiePbqCzhhgYzo8TrNGs9dwZv7U+ohF3KHVZGqsXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=Hbok9IzP; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so3126632a12.0
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 08:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1706891661; x=1707496461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWrCvGoDQwOWMpVcb46eMyJCzvJuUZPcrKCneQA7xTs=;
        b=Hbok9IzPRVN1MaYQIFlA4O9xwM3VljW5Sa4i65wGlAgvzdg7LmepTQenk0/UAfNIUI
         3YuKgPLBsr35BZUE9+ddhIqIjNrGXjoveYCNzgab0KXofBw5S7dLkhXwoy7MpLO3/v0e
         k5LluqMto43LlrR9EMhcALgQIEnu1AD6WpFuQjoY6cJSS8Nbslzm4NIkM9jD9e7C/JwV
         XVLmVIj2YcAz0fsGcTObwLTcRdNUql1cAp79d+zntj3s6IxHaDgkgMXYqCKu3PU4QMUy
         MjUD2XOTIdydqwoAUTtD0wlCpggaxnZlStTZ7bnc9iemZUkRM0eQ01EtPIs/6P0THVQH
         LTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891661; x=1707496461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWrCvGoDQwOWMpVcb46eMyJCzvJuUZPcrKCneQA7xTs=;
        b=LYapqbkC9VKJuNKS/a/ASZCGkk3cAil7TGAKtgpM/DAVDdMAa204Nj3sRHn3fbW6mK
         49fFwPZ5sIZF8Uxwn3O3s14LVv160a49iGs0aW220/IzQIUdOZbYveX9B0LfF5ekqmdO
         zW0PDwklP33SpprU0vWWJkcTtZADwPYCJUr/M0Om0BgeSlDFAbpNLp2ttMMyW7dg4oFf
         X0CF8DQHIZIqzCfIJr61hora7YhWoVauxF/jSoOt6rUzm/rDnbyizJBt8hiXkpmAoaCB
         pjVk1MHoqqXBYeEFp1m/io7qs6GS+knSt21ychJjp3nLI8cF/73ocpGnCxGeWwACF6R2
         0xsg==
X-Gm-Message-State: AOJu0Yzuw/i13IPU/q+1vRz0lt1aYhW/uppOgRv/oOb721m21HmnUXQ+
	NPjKA2gG6rJnD0seusM0hTm3T8GEXdDnhI9lhwe+ORyZGSiakxMx4NMZwF87/jg=
X-Google-Smtp-Source: AGHT+IEafoDqngvIZ3JoIAvTtWUcJ5pbxsnL17NJuvWQPo6jRYYh5iq9u/2vNaPdBG2eaYeDHqDnzg==
X-Received: by 2002:aa7:d710:0:b0:55f:1728:3b33 with SMTP id t16-20020aa7d710000000b0055f17283b33mr95019edq.40.1706891661474;
        Fri, 02 Feb 2024 08:34:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWhTtlC7UMW0/mPCkyhSmvN0k9mS60j+hmiKGf4tS+l6EBb+WKP9uXUDlLnC1BtYYkMEslqQTakQHwY0LmAgb51X+sHOyzX/kS7nmQTDQdW+Wp5nv/JqNXu57IoqC7Ao7nu3LDlAVCjSFAjXfJ/MDTRUyX+b4K+MXP9M80N832ZQyZ8+LxuiBaUl2IJhxnxlHXOhxFPJlOhUzrixlh9M0p0FRs24PV8OCsch7E7Ll69udNEgGJpFX/QJd+dlEVknDQI86cwzMOuEulHVJOYsvsxgqGYzQmNfSqGZL0o0xbYrXx8qdcbaGI=
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id l19-20020aa7c313000000b0055edbe94b34sm952544edq.54.2024.02.02.08.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 08:34:21 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <quentin@isovalent.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v1 bpf-next 6/9] bpf: add support for an extended JA instruction
Date: Fri,  2 Feb 2024 16:28:10 +0000
Message-Id: <20240202162813.4184616-7-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202162813.4184616-1-aspsk@isovalent.com>
References: <20240202162813.4184616-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for a new version of JA instruction, a static branch JA. Such
instructions may either jump to the specified offset or act as nops. To
distinguish such instructions from normal JA the BPF_STATIC_BRANCH_JA flag
should be set for the SRC register.

By default on program load such instructions are jitted as a normal JA.
However, if the BPF_STATIC_BRANCH_NOP flag is set in the SRC register,
then the instruction is jitted to a NOP.

In order to generate BPF_STATIC_BRANCH_JA instructions using llvm two new
instructions were added:

	asm volatile goto ("nop_or_gotol %l[label]" :::: label);

will generate the BPF_STATIC_BRANCH_JA|BPF_STATIC_BRANCH_NOP instuction and

	asm volatile goto ("gotol_or_nop %l[label]" :::: label);

will generate a BPF_STATIC_BRANCH_JA instruction, without an extra bit set.
The reason for adding two instructions is that both are required to implement
static keys functionality for BPF.

The verifier logic is extended to check both possible paths: jump and nop.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 arch/x86/net/bpf_jit_comp.c    | 19 +++++++++++++--
 include/uapi/linux/bpf.h       | 10 ++++++++
 kernel/bpf/verifier.c          | 43 +++++++++++++++++++++++++++-------
 tools/include/uapi/linux/bpf.h | 10 ++++++++
 4 files changed, 71 insertions(+), 11 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a80b8c1e7afe..b291b5c79d26 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1131,6 +1131,15 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
 	*pprog = prog;
 }
 
+static bool is_static_ja_nop(const struct bpf_insn *insn)
+{
+	u8 code = insn->code;
+
+	return (code == (BPF_JMP | BPF_JA) || code == (BPF_JMP32 | BPF_JA)) &&
+	       (insn->src_reg & BPF_STATIC_BRANCH_JA) &&
+	       (insn->src_reg & BPF_STATIC_BRANCH_NOP);
+}
+
 #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
 
 /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
@@ -2016,9 +2025,15 @@ st:			if (is_imm8(insn->off))
 					}
 					emit_nops(&prog, INSN_SZ_DIFF - 2);
 				}
-				EMIT2(0xEB, jmp_offset);
+				if (is_static_ja_nop(insn))
+					emit_nops(&prog, 2);
+				else
+					EMIT2(0xEB, jmp_offset);
 			} else if (is_simm32(jmp_offset)) {
-				EMIT1_off32(0xE9, jmp_offset);
+				if (is_static_ja_nop(insn))
+					emit_nops(&prog, 5);
+				else
+					EMIT1_off32(0xE9, jmp_offset);
 			} else {
 				pr_err("jmp gen bug %llx\n", jmp_offset);
 				return -EFAULT;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c874f354c290..aca5ed065731 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1412,6 +1412,16 @@ struct bpf_stack_build_id {
 	};
 };
 
+/* Flags for JA insn, passed in SRC_REG */
+enum {
+	BPF_STATIC_BRANCH_JA  = 1 << 0,
+	BPF_STATIC_BRANCH_NOP = 1 << 1,
+};
+
+#define BPF_STATIC_BRANCH_MASK (BPF_STATIC_BRANCH_JA | \
+				BPF_STATIC_BRANCH_NOP)
+
+
 #define BPF_OBJ_NAME_LEN 16U
 
 union bpf_attr {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 270dc0a26d03..003b54fbc6d9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15630,14 +15630,24 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 		else
 			off = insn->imm;
 
-		/* unconditional jump with single edge */
-		ret = push_insn(t, t + off + 1, FALLTHROUGH, env);
-		if (ret)
-			return ret;
+		if (insn->src_reg & BPF_STATIC_BRANCH_JA) {
+			/* static branch - jump with two edges */
+			mark_prune_point(env, t);
+
+			ret = push_insn(t, t + 1, FALLTHROUGH, env);
+			if (ret)
+				return ret;
 
-		mark_prune_point(env, t + off + 1);
-		mark_jmp_point(env, t + off + 1);
+			ret = push_insn(t, t + off + 1, BRANCH, env);
+		} else {
+			/* unconditional jump with single edge */
+			ret = push_insn(t, t + off + 1, FALLTHROUGH, env);
+			if (ret)
+				return ret;
 
+			mark_prune_point(env, t + off + 1);
+			mark_jmp_point(env, t + off + 1);
+		}
 		return ret;
 
 	default:
@@ -17607,8 +17617,11 @@ static int do_check(struct bpf_verifier_env *env)
 
 				mark_reg_scratched(env, BPF_REG_0);
 			} else if (opcode == BPF_JA) {
+				struct bpf_verifier_state *other_branch;
+				u32 jmp_offset;
+
 				if (BPF_SRC(insn->code) != BPF_K ||
-				    insn->src_reg != BPF_REG_0 ||
+				    (insn->src_reg & ~BPF_STATIC_BRANCH_MASK) ||
 				    insn->dst_reg != BPF_REG_0 ||
 				    (class == BPF_JMP && insn->imm != 0) ||
 				    (class == BPF_JMP32 && insn->off != 0)) {
@@ -17617,9 +17630,21 @@ static int do_check(struct bpf_verifier_env *env)
 				}
 
 				if (class == BPF_JMP)
-					env->insn_idx += insn->off + 1;
+					jmp_offset = insn->off + 1;
 				else
-					env->insn_idx += insn->imm + 1;
+					jmp_offset = insn->imm + 1;
+
+				/* Staic branch can either jump to +off or +0 */
+				if (insn->src_reg & BPF_STATIC_BRANCH_JA) {
+					other_branch = push_stack(env, env->insn_idx + jmp_offset,
+							env->insn_idx, false);
+					if (!other_branch)
+						return -EFAULT;
+
+					jmp_offset = 1;
+				}
+
+				env->insn_idx += jmp_offset;
 				continue;
 
 			} else if (opcode == BPF_EXIT) {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index c874f354c290..aca5ed065731 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1412,6 +1412,16 @@ struct bpf_stack_build_id {
 	};
 };
 
+/* Flags for JA insn, passed in SRC_REG */
+enum {
+	BPF_STATIC_BRANCH_JA  = 1 << 0,
+	BPF_STATIC_BRANCH_NOP = 1 << 1,
+};
+
+#define BPF_STATIC_BRANCH_MASK (BPF_STATIC_BRANCH_JA | \
+				BPF_STATIC_BRANCH_NOP)
+
+
 #define BPF_OBJ_NAME_LEN 16U
 
 union bpf_attr {
-- 
2.34.1


