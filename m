Return-Path: <bpf+bounces-16883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D7C8071FB
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 15:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1981C20EA8
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 14:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421CE3E48B;
	Wed,  6 Dec 2023 14:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="g9MkAjHV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ADAD5B
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 06:13:51 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c25973988so1174865e9.2
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 06:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1701872030; x=1702476830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=590AYwwkdIFO3Un7/IlMUBfx3bIXwzntV+/SAYwcPk0=;
        b=g9MkAjHVfUNCWxHUWz2NkIEHww+WQwaK8eKxgr150jvy2MqtY6Sz26hqYJxnPH8ND2
         HsGQYqALM8P8uejMQdEt7MGyOOk9VpYctMJMeV/f0wsFi5RQsoyE3YfvmxVtLcndjPFG
         +jZ8rEEObX3VDeEmkv+q1UlzLw8ERaDm40R2Ft7cU+8Bu0fr+NVrOVXbe+xUrs5kyjNB
         qhlY/0NcIXRMT91ARNaeSPSmFKNeHEJNqeFbU+cPjPFZ57beZpoynZSvh1iyKajC3p27
         nu8hV6ILdeTfNluzoLZEi9FN7tVxj0HDO1nSjLqWtLZgKHBB9iOnQuLJ98po4u5D10Jz
         643Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701872030; x=1702476830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=590AYwwkdIFO3Un7/IlMUBfx3bIXwzntV+/SAYwcPk0=;
        b=PdyO44Tt0YpDbgalFwjcbkSMmjjmHWxHpBTcKtjm8RXjbnVlj/2ct25WqMwTx9pDlV
         ofX9KLrMto0Ge1NBTMhhAmEpzszikUEk4KgSsoP/SrRz+/Ce+q8fkewlI1Q0BNz2NbX0
         sZtxTsvxPMKZboSiH2eGS6C8WRgcEcw8gk0NNGfD9GeuYaI/LAZxSlmtDRBg35FM1+Nh
         a2X/Cf0HxQQSlRnD72TQ10TMRjCv22yUBAu9ixcScan+EFADRFAoKB2EkJ1mwhAQ+crY
         WPsOM2jl9V0pD9mcwC2YH0rwpYDIEG753V6Se5U1G8JC7KH0d9M+GU/wQlz5asVx4d4s
         KT8g==
X-Gm-Message-State: AOJu0YzZUq2qGifM8H9oqmMtcRq0baITZFxLNVr5UHdL6KO1YMbZG5Hj
	iPRcZW/qbJ3149it/ROttdI//A==
X-Google-Smtp-Source: AGHT+IE2AIMbcsCNLZ9LjLV1XZRAySSpYawwzxPzgbjab1rrihrGDYNrY/Rfzdm+1I/ugvkwm+G1og==
X-Received: by 2002:a05:600c:4e89:b0:408:3707:b199 with SMTP id f9-20020a05600c4e8900b004083707b199mr624251wmq.3.1701872029830;
        Wed, 06 Dec 2023 06:13:49 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c311200b0040b42df75fcsm22140330wmo.39.2023.12.06.06.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 06:13:49 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next 5/7] bpf: x86: implement static keys support
Date: Wed,  6 Dec 2023 14:10:28 +0000
Message-Id: <20231206141030.1478753-6-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206141030.1478753-1-aspsk@isovalent.com>
References: <20231206141030.1478753-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement X86 JIT support for BPF Static Keys: while jiting code and
encountering a JA instruction the JIT compiler checks if there is a
corresponding static branch.  If there is, it saves a corresponding x86
address in the static branch structure.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 arch/x86/net/bpf_jit_comp.c | 72 +++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8c10d9abc239..4e8ed43bd03d 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -452,6 +452,32 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 	return __bpf_arch_text_poke(ip, t, old_addr, new_addr);
 }
 
+int bpf_arch_poke_static_branch(struct bpf_prog *prog,
+				struct bpf_static_branch *branch, bool on)
+{
+	static const u64 bpf_nop = BPF_JMP | BPF_JA;
+	const void *arch_op;
+	const void *bpf_op;
+	bool inverse;
+
+	if (!prog || !branch)
+		return -EINVAL;
+
+	inverse = !!(branch->flags & BPF_F_INVERSE_BRANCH);
+	if (on ^ inverse) {
+		bpf_op = branch->bpf_jmp;
+		arch_op = branch->arch_jmp;
+	} else {
+		bpf_op = &bpf_nop;
+		arch_op = branch->arch_nop;
+	}
+
+	text_poke_bp(branch->arch_addr, arch_op, branch->arch_len, NULL);
+	memcpy(&prog->insnsi[branch->bpf_offset / 8], bpf_op, 8);
+
+	return 0;
+}
+
 #define EMIT_LFENCE()	EMIT3(0x0F, 0xAE, 0xE8)
 
 static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
@@ -1008,6 +1034,32 @@ static void emit_nops(u8 **pprog, int len)
 	*pprog = prog;
 }
 
+static __always_inline void copy_nops(u8 *dst, int len)
+{
+	BUILD_BUG_ON(len != 2 && len != 5);
+	memcpy(dst, x86_nops[len], len);
+}
+
+static __always_inline void
+arch_init_static_branch(struct bpf_static_branch *branch,
+			int len, u32 jmp_offset, void *addr)
+{
+	BUILD_BUG_ON(len != 2 && len != 5);
+
+	if (len == 2) {
+		branch->arch_jmp[0] = 0xEB;
+		branch->arch_jmp[1] = jmp_offset;
+	} else {
+		branch->arch_jmp[0] = 0xE9;
+		memcpy(&branch->arch_jmp[1], &jmp_offset, 4);
+	}
+
+	copy_nops(branch->arch_nop, len);
+
+	branch->arch_len = len;
+	branch->arch_addr = addr;
+}
+
 /* emit the 3-byte VEX prefix
  *
  * r: same as rex.r, extra bit for ModRM reg field
@@ -1078,6 +1130,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 {
 	bool tail_call_reachable = bpf_prog->aux->tail_call_reachable;
 	struct bpf_insn *insn = bpf_prog->insnsi;
+	struct bpf_static_branch *branch = NULL;
 	bool callee_regs_used[4] = {};
 	int insn_cnt = bpf_prog->len;
 	bool tail_call_seen = false;
@@ -1928,6 +1981,16 @@ st:			if (is_imm8(insn->off))
 				break;
 			}
 emit_jmp:
+			if (bpf_prog->aux->static_branches_len > 0 && bpf_prog->aux->func_info) {
+				int off, idx;
+
+				idx = bpf_prog->aux->func_idx;
+				off = bpf_prog->aux->func_info[idx].insn_off + i - 1;
+				branch = bpf_static_branch_by_offset(bpf_prog, off * 8);
+			} else {
+				branch = bpf_static_branch_by_offset(bpf_prog, (i - 1) * 8);
+			}
+
 			if (is_imm8(jmp_offset)) {
 				if (jmp_padding) {
 					/* To avoid breaking jmp_offset, the extra bytes
@@ -1950,8 +2013,17 @@ st:			if (is_imm8(insn->off))
 					}
 					emit_nops(&prog, INSN_SZ_DIFF - 2);
 				}
+
+				if (branch)
+					arch_init_static_branch(branch, 2, jmp_offset,
+								image + addrs[i-1]);
+
 				EMIT2(0xEB, jmp_offset);
 			} else if (is_simm32(jmp_offset)) {
+				if (branch)
+					arch_init_static_branch(branch, 5, jmp_offset,
+								image + addrs[i-1]);
+
 				EMIT1_off32(0xE9, jmp_offset);
 			} else {
 				pr_err("jmp gen bug %llx\n", jmp_offset);
-- 
2.34.1


