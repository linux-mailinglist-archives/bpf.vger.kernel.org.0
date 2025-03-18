Return-Path: <bpf+bounces-54316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E35A6766A
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 15:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D3816F582
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 14:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC3B20E32B;
	Tue, 18 Mar 2025 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="MWjlwcJE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052BA20CCFB
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308197; cv=none; b=Z/Ch2+N8XIhLiC/TcDWgu1QrZUs9yy8cspxbhJaRz8QRHC/vNnCqbajkP5RkhD4L06+iriltUeXTPDdpOTwrNATKpQUehOdua83A7Xxa/gt3atSYJI29QOfvBb/YUIUmLhhGo1HZC2I1z3h/7i43o+w0WrWD9h5nu24iiM7GSN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308197; c=relaxed/simple;
	bh=YTk8cmNwLt9BXcSx7rLGpMI0X5tLpVzeMW01kmmHMkw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IJMNcox1oUJhloXHn4B5ipPj8rMbOA9etlvKfTXO0VCy3V1LSDetiWi/e5nO7zikiIEUOntis9r+ntcvGo+HO7gkJf0k8pFsVVocKwFWRGGGAhjcrTDXSWKNfrOYjxIgF3/1DIwz2IOEOqNXCY+SIx5VfvUi4ckKpe3yCaHUp6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=MWjlwcJE; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-399676b7c41so1412185f8f.3
        for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 07:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1742308190; x=1742912990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HyEbH1w6A9VIpcgZdoHugiV2nHQoH/REc15nWJRp/Ho=;
        b=MWjlwcJEIZORB1ce7tEdW6wKNQFo/PYtNsYvO6EGSI3g8hNqVNA3eqv8aV9Agt3AEV
         BSpTH5AwY4D/AwHhEvAcH6Vi/nS5aQTMGfq4NdUdLsc4fnybBCR6D/hc14p1UkItS3ST
         jK6zjE3vhXSVHQDblluQMMl6XEWTRNoBHyjddyzDxDIQm61/CwI37aOB0M+9/7wtipDx
         Snt1mS9vkzJ8hcmJMU56iIwVInATTwYfZv+qyUBF23LqPpbYeNzTaHINtOLCRGMAFu3w
         WtwSg5/0Oy20IL3qO3laduSgufi5ij2QG7cZSuQTJqF2E0Gc707rLsMYpz+yfZ1s63oN
         czZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308190; x=1742912990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HyEbH1w6A9VIpcgZdoHugiV2nHQoH/REc15nWJRp/Ho=;
        b=rMuGmXHjORA6CUKDBRl4l2O7xw/XQ7+a3ofsi20dqTzGN9jXls6A1Mf2vFgbiEIn30
         DptNbChsIGH9rLuBCAfiuF8tGIDTi4Olpi/KKrj2gYMhCGJ61fGF8BIRo5JMlA00RdcQ
         VNtBH8baRSuzdxsmgQeAlLKd69DhbDUghBzoICx0t6oIqOTj/wXkhZCEKAL3+G6osGDR
         G28h27cC08haMJpe4dLD6g34F+aYD5S7ydZqWomSASxGgYcUCCi+wK52+UD2Xg8kIZic
         s+PDLLT8jb0ySYTWjm09FkdvFa2ZkQaTxxR9DrtJh8AUJWpnsIa1c2NV6wcyh3fRHkn8
         D1cA==
X-Gm-Message-State: AOJu0YwIhIswFB7oWRbaR9ggiSFcVS9HuFr62kH5eLn46lT8wU4ES0OI
	rJMb0WkYEZ87ckJ9Y6B0lwqfRh6DtUPp7Lval/6ieo/TCc2VQbK743HLQ0fFtJVH5uStRFe7SM3
	R
X-Gm-Gg: ASbGnct6rmbVzTyOLmYRdoqQjK3Ir9s3tz0iiVOo4DFzQETfxFc02F6QUsBlNB98+hI
	iB5sba9dHZ0W57dfSgi+v/SwsXQl6YtQ/9K+cJFhcpXh35QPyRKVMQXEqk69k6bFouvPfp1jmv5
	lXW796MVbKzOT/cGDyJ3yJ0LOSbt7+R6ZUjzlKCH8wOE2Td07CvfWIIC5rPVxQkSFJy10fpx/Ee
	DZThS5kyg7vYrsK47OuT0BamIW6V1NU1xP+IsbNi2lTHkjWCQZBoKZV03GfoTC/sCENX+0dGJSQ
	vwkDoBf8rt58mgZ2L4T5gyMxBG0bxGMAF5W4agZXGNKXbbyIfl8Ng8E2lw==
X-Google-Smtp-Source: AGHT+IEBc2DXszWUK7Wx6L8YOfJbIGv1CsNj3ZZTNfgAU6t0FxewgwqAdY2eyE+E+QH5Gg+cfLT4EA==
X-Received: by 2002:a05:6000:4027:b0:38d:d7a4:d447 with SMTP id ffacd0b85a97d-3971f9e4866mr18141561f8f.34.1742308189947;
        Tue, 18 Mar 2025 07:29:49 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdd0sm18348071f8f.77.2025.03.18.07.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:29:49 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [RFC PATCH bpf-next 04/14] bpf: add support for an extended JA instruction
Date: Tue, 18 Mar 2025 14:33:08 +0000
Message-Id: <20250318143318.656785-5-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318143318.656785-1-aspsk@isovalent.com>
References: <20250318143318.656785-1-aspsk@isovalent.com>
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
instructions will be added:

	asm volatile goto ("nop_or_gotol %l[label]" :::: label);

will generate the BPF_STATIC_BRANCH_JA|BPF_STATIC_BRANCH_NOP instuction and

	asm volatile goto ("gotol_or_nop %l[label]" :::: label);

will generate a BPF_STATIC_BRANCH_JA instruction, without an extra bit set.
The reason for adding two instructions is that both are required to implement
static keys functionality for BPF, namely, to distinguish between likely and
unlikely branches.

The verifier logic is extended to check both possible paths: jump and nop.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 arch/x86/net/bpf_jit_comp.c    | 19 +++++++++++++--
 include/uapi/linux/bpf.h       | 10 ++++++++
 kernel/bpf/verifier.c          | 43 +++++++++++++++++++++++++++-------
 tools/include/uapi/linux/bpf.h | 10 ++++++++
 4 files changed, 71 insertions(+), 11 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d3491cc0898b..5856ac1aab80 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1482,6 +1482,15 @@ static void emit_priv_frame_ptr(u8 **pprog, void __percpu *priv_frame_ptr)
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
 
 #define __LOAD_TCC_PTR(off)			\
@@ -2519,9 +2528,15 @@ st:			if (is_imm8(insn->off))
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
index b8e588ed6406..57e0fd636a27 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1462,6 +1462,16 @@ struct bpf_stack_build_id {
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
index 6554f7aea0d8..0860ef57d5af 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17374,14 +17374,24 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 		else
 			off = insn->imm;
 
-		/* unconditional jump with single edge */
-		ret = push_insn(t, t + off + 1, FALLTHROUGH, env);
-		if (ret)
-			return ret;
+		if (insn->src_reg & BPF_STATIC_BRANCH_JA) {
+			/* static branch - jump with two edges */
+			mark_prune_point(env, t);
 
-		mark_prune_point(env, t + off + 1);
-		mark_jmp_point(env, t + off + 1);
+			ret = push_insn(t, t + 1, FALLTHROUGH, env);
+			if (ret)
+				return ret;
+
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
@@ -19414,8 +19424,11 @@ static int do_check(struct bpf_verifier_env *env)
 
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
@@ -19424,9 +19437,21 @@ static int do_check(struct bpf_verifier_env *env)
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
index b8e588ed6406..57e0fd636a27 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1462,6 +1462,16 @@ struct bpf_stack_build_id {
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


