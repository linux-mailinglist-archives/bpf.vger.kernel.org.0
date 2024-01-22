Return-Path: <bpf+bounces-20019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 149CA836DD2
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 18:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83FA41F27D0A
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 17:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1F446425;
	Mon, 22 Jan 2024 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="WdTI04Yu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612444643F
	for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 16:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942519; cv=none; b=c37FSLPYKVwhgeivYKOAaE1fjBMrLJWjrb2at7KQTWZweEju33uc58WPQsh2BfsKvp/k2kjMk5g9kHjBmDbqAwTizlehzlxOkWzbM1QVP/AFKdg8Z+GfDDVat/q0j+2ONiyWYLYajAy9jZRTqYsFF7LY7H2CjoyOfHeiIC5ptc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942519; c=relaxed/simple;
	bh=imRUcU7anywtc8JxVDmEd9i931EMAccAiAa8nYaGmuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CjxJDlL3oS8p44NIfWpodPJc975VCgExyxEi9fiJePgT48AOPvfvuIPGa+Iuzl6FcmmS0o9Ztb0PkceO3unDI+ZmVk9oknWRS4n9sg8R7U6R/NLiWJy+CIfF5e7KXlMZVT7yNJeIbzVQK8ngTZtvYGuJbwdkRVVD/CA4KvmSD18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=WdTI04Yu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40eacb6067dso14974465e9.1
        for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 08:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1705942515; x=1706547315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ITUBw0oQXhtryiL3cOdwavmGTAiV8QJrLtx3cV7VWk=;
        b=WdTI04YuICsHf0UygH/ZNdmOFwyBFr17Ziyk5QarM6tXSOee5F+psPStnjO41cnl2A
         PNGja+GPC6Gn+3izLpKF6X7WEJB1d0kJSF/exWk7oe40Qbs/0vbMSYrngRkEycRgEZhX
         36KJ2qRsxLZetIUsFs9szRKrKOio0MlPCQ8ZrhWHBH0sLM7klqr3gqDmD5npz2gzOpCb
         dI4wurTlev7WuvG43GmFpMxDPv1RrgkiMFUpl4F/xepMFpQFmQi1Te+8QpLjhJN9zYiZ
         R66YtlBTBkaSKN8oUjXk/poFL3gLuDZTP9fbNujGHlOdq8WtEdTEZ67UamqB4HctBiiI
         QtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705942515; x=1706547315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ITUBw0oQXhtryiL3cOdwavmGTAiV8QJrLtx3cV7VWk=;
        b=lFDbUHNjROmzmDenWradNl1/Vw7l/5rXAkEsfZXJc8ZIo95r33aSX04Bqqq5CDcj6I
         Q/8tc8Lbtxfda90H5zgX46pNOLVv0UL85FrZ7MkWpVd6GXV5gaHZp8k318xVvzZH6jgt
         ey/shuA4cYSJH/No9aoum4Gbf05KaUDSYp0BHoNEk8YP7QD49E9FGYarNY+GXDrjePbe
         Gt55Ke3TEekUgQQydSCWOtvPWGXRaBOnvLJcWUJkAFkt/KJgq6M+WyuAd4x/D4HowGEG
         MOW7fr2tUT80EC4tN3ideoYv2plEmLZx1e87i8u42FyEd9woq1lYBfumLX8ekZZKn/lt
         A8oA==
X-Gm-Message-State: AOJu0Yy/abryNRbwrYxtDcTKxIyCMdXacmYkL9bVzBcc6j1A8opesF+Y
	O9st7ybW+Utp71XzzDDfMVtfA/A1Vo/Kajf58S7qXAtr6n1BmcvVAL2tCNHS/RA=
X-Google-Smtp-Source: AGHT+IFDq0LISazi+yyMW+T7RkB/OYIroAdVocoJd39ZD3GCp1ITVEHYpGiRH8TsQ0pErz7hJRq1vw==
X-Received: by 2002:a7b:cb16:0:b0:40e:4cfe:9144 with SMTP id u22-20020a7bcb16000000b0040e4cfe9144mr1351920wmj.256.1705942515617;
        Mon, 22 Jan 2024 08:55:15 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id i7-20020a5d6307000000b00337d71bb3c0sm10402466wru.46.2024.01.22.08.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 08:55:15 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [RFC PATCH bpf-next 4/5] bpf: add support for an extended JA instruction
Date: Mon, 22 Jan 2024 16:49:35 +0000
Message-Id: <20240122164936.810117-5-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122164936.810117-1-aspsk@isovalent.com>
References: <20240122164936.810117-1-aspsk@isovalent.com>
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
 arch/x86/net/bpf_jit_comp.c | 19 ++++++++++++++--
 include/uapi/linux/bpf.h    | 10 +++++++++
 kernel/bpf/verifier.c       | 43 +++++++++++++++++++++++++++++--------
 3 files changed, 61 insertions(+), 11 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 736aec2565b8..52b9de134ab3 100644
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
index 83dad9ea7a3b..43ad332ffbee 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1372,6 +1372,16 @@ struct bpf_stack_build_id {
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
index fad47044ccce..50d19755b8fb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15607,14 +15607,24 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
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
@@ -17584,8 +17594,11 @@ static int do_check(struct bpf_verifier_env *env)
 
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
@@ -17594,9 +17607,21 @@ static int do_check(struct bpf_verifier_env *env)
 				}
 
 				if (class == BPF_JMP)
-					env->insn_idx += insn->off + 1;
+					jmp_offset = insn->off + 1;
 				else
-					env->insn_idx += insn->imm + 1;
+					jmp_offset = insn->imm + 1;
+
+				/* Staic branch can either jump to +off or fall through */
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
-- 
2.34.1


