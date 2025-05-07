Return-Path: <bpf+bounces-57680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 148D0AAE797
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 19:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A72D3ADF77
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 17:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF23F28C2BE;
	Wed,  7 May 2025 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+FfVD8G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B1528C5D8
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746638257; cv=none; b=NRCjwyCU9XTT1ErapbpzBnm/FPPlthYE2eFi0k+GYdJ9gnVrX165Uk0xq+lB9ltaQJt/MWTH4MzhhDtPY0YeIXW9vkhC+RgLuX3ZD2d4L04F2cyVpYVOrbDNzelKqITO5WOPNp1aDvG+Rcv7j3d0lyIdf/96kIkcE5Z574/7xZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746638257; c=relaxed/simple;
	bh=WdYRl8DIqfyDnOIUGG3aEUO/vTYFTHHocLQ/baxd168=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h++j2fJflZJj63/aLDUVBQ9UKsZSXMWmY+BFQOi40JB4r4NoLdMC1a3iBemlNCeraTzXYNwRn/OmbfmqKXdHI0W9IG1iD0IJ8Vm2znalYlKSNXpp9TJiw3fW3C4LBn91OCrf09K9CIdgFYJexXiWgVlfNYQXNsp6xyn5W50nSb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+FfVD8G; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso1279935e9.0
        for <bpf@vger.kernel.org>; Wed, 07 May 2025 10:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746638253; x=1747243053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Su62mPNqdYawurBaOcZUZb9reJ7ExkjfPlY64q7DT58=;
        b=P+FfVD8GNzlvo2ds/X6WNMPuL+A/GRmzlpQu+bz28Pn3qbWvHF1Y9dP/4IHYE9yqTE
         NUpF2cusEMAT4H+u55M3O0o+JUKeUbG99hlqBrCmULq+xuZlDqlgjejVBSr67W1yjb2D
         9FosCa82XrudQWS7ilcp+HRlLSAIuFjjKQMNtxRnGs5RSql+2kNwCvoku84YC9axZnB1
         NRaKjIsoeDnK9drxG0nQU+sRr2RUXz0nqmyEyCK7stedcOphjFgKrilpAohGExJv8xy8
         jnhZ9bi52x7daaP27nJ7a4J5UxMkSkPMZBoIRWbWaGPHjN398ay2Ka34wKQjiV2BEUIH
         HZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746638253; x=1747243053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Su62mPNqdYawurBaOcZUZb9reJ7ExkjfPlY64q7DT58=;
        b=HQ1iIEq5hiAl6SP29NP3ZDVIVX3qoxyInNw77OWhZyhr+RxooYOPvPzZnLqjGKKXkj
         rEIey9c4DFG1UXIYY/XZFXmojyiTUd/3K5eDKrS3JVbCnid0Y+TAQDd9358R/Awa1r5+
         8mu5QiHvnuXpyysJ+EtkEekkyp/RoELUckZD/yCDhVPNoabGdgYVr12Xhi+rLmt5rW+K
         nrNdf1Ea2Hn85wFAB33uvPyJT3PwHLIsqmMSNWjA8TIREKR2HWlXMa4Y4EhkoUQXQ28d
         oPiILZqrkwyCB115OGQPiHhebwkT5KOviP+9L/qkJHO4OUHPbctP7wQS8HCo1HnThQUD
         XLdw==
X-Gm-Message-State: AOJu0Yy7CEC7u+VpSW8UxtqBnz66NrXRMeq9tORWrBB2DBC7wmxp4FLF
	ynf9OsRT11fRrTzsFsqJNtdnkFEZI6AxcqRpJZHcq2dZnKGiP4+qp0msYNxct2E=
X-Gm-Gg: ASbGncthQCpWl9j46fwkU7KFZhpGSMkjSjK/cL/qTkinssxKeoA+srWvIvSLP8iz1N4
	xlwP+HC5jAlnuLuu4QqTqoLOy0ovKdZyxrr3JY07hPIfrTCyML1CkpQyxop/8dzmFS+NIrrj5Aa
	KeiLCXVZruAlIAO6MXXDcC+QrA8gfjfAqI8aRcBzuKrZfeybwiN0X1UqR17UmOhghDtyUfVlIgN
	MptZAU+QLwIXvvFehriVZ3kdznlq2ORntXcg0BRKetC2d529pLUDI05ycernrvjtNGY5rh1OytM
	4o6ip8iyenY1SSyvBr/krayPlEZcIg==
X-Google-Smtp-Source: AGHT+IHL0DA8B3PFrsWhZXOkHO8MuIjDsFMsLoo6ZTcrkgcUzFaaOYzbK8qfF5PK/npzIaR4YsoewQ==
X-Received: by 2002:a05:600c:1c09:b0:442:cd12:c68a with SMTP id 5b1f17b1804b1-442d02c7e74mr4076465e9.1.1746638253391;
        Wed, 07 May 2025 10:17:33 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:3::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd3aecb0sm7549345e9.28.2025.05.07.10.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 10:17:32 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 08/11] bpf: Report arena faults to BPF stderr
Date: Wed,  7 May 2025 10:17:17 -0700
Message-ID: <20250507171720.1958296-9-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250507171720.1958296-1-memxor@gmail.com>
References: <20250507171720.1958296-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3603; h=from:subject; bh=WdYRl8DIqfyDnOIUGG3aEUO/vTYFTHHocLQ/baxd168=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoG5WKYjTMcZB8Hrr6/k4XHj5fRi5DW5bJyFgOYrNW y5+RKmmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaBuVigAKCRBM4MiGSL8Ryq+0D/ 9k7ueEOE1BSuosc/7byt3qKUz8n+pbZPVN2R9cSmuaQBsnsxr/p4PSaIsomGqTPL+1vH8j2T6wjiMY FMq9mCrEHV/lgDQHKE+1hs/fBSTlIBkzx6F5MCENzCatCdp9QJB16RpZUxyPkngEoibicc0OUPuAOm Xh2L95hw95msAFNh0hxGZ11vJRzvNzTIAlyPibOX77I/Zwk9l2cCSAba0R4QowVFtc3FMkmrYHJxV0 4NDWZgDgXCChP3sYCH2wmEStLuRnOE7wNggmXv8lOc77mrUrSb3BasKU5b7jsxseMoySCDBKKegaxl 6/D7bmWFL3FuiHVKbryY5a10HrMrLxJto0XlYH9rd414MRCktSOPokXnIztI5vykJH4jkdLXx0Xy0Y 7Rj1hvCWSW12lk1iWrPo7jstbc61XdoZyEoRo9zBJLRZB9TOlplc0eBML15MyQwpixrQPr6cMmqs6Y I7QXVtTbSzIYr4MFmQiQmzeftpGNBKZiJBafm+MCw3tM6Ah4naMyGtzTtikIrWbgmIrCFzkxGr+wVR kt2zwMZFcu7wgN9o9LP8K57ZZKPyKVqkBzgH1YwSaGu5zsh4Dv92wwo4ahmyUmQWe2HzoHOivIjdS0 4WjsV8eSA1LlsGZXHV2Y/Y27tkXeiorfMyOpHPBtw9AaHqC/GkMSngFtZxew==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Begin reporting arena page faults and the faulting address to BPF
program's stderr, for now limited to x86, but arm64 support should
be easy to add.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 21 ++++++++++++++++++---
 include/linux/bpf.h         |  1 +
 kernel/bpf/arena.c          | 14 ++++++++++++++
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 17693ee6bb1a..dbb0feeec701 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1384,15 +1384,27 @@ static int emit_atomic_ld_st_index(u8 **pprog, u32 atomic_op, u32 size,
 }
 
 #define DONT_CLEAR 1
+#define ARENA_FAULT (1 << 8)
 
 bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
 {
-	u32 reg = x->fixup >> 8;
+	u32 arena_reg = (x->fixup >> 8) & 0xff;
+	bool is_arena = !!arena_reg;
+	u32 reg = x->fixup >> 16;
+	unsigned long addr;
+
+	/* Read here, if src_reg is dst_reg for load, we'll write 0 to it. */
+	if (is_arena)
+		addr = *(unsigned long *)((void *)regs + arena_reg);
 
 	/* jump over faulting load and clear dest register */
 	if (reg != DONT_CLEAR)
 		*(unsigned long *)((void *)regs + reg) = 0;
 	regs->ip += x->fixup & 0xff;
+
+	if (is_arena)
+		bpf_prog_report_arena_violation(reg == DONT_CLEAR, addr);
+
 	return true;
 }
 
@@ -2043,7 +2055,10 @@ st:			if (is_imm8(insn->off))
 				ex->data = EX_TYPE_BPF;
 
 				ex->fixup = (prog - start_of_ldx) |
-					((BPF_CLASS(insn->code) == BPF_LDX ? reg2pt_regs[dst_reg] : DONT_CLEAR) << 8);
+					((BPF_CLASS(insn->code) == BPF_LDX ? reg2pt_regs[dst_reg] : DONT_CLEAR) << 16)
+					| ((BPF_CLASS(insn->code) == BPF_LDX ? reg2pt_regs[src_reg] : reg2pt_regs[dst_reg])<< 8);
+				/* Ensure src_reg offset fits in 1 byte. */
+				BUILD_BUG_ON(sizeof(struct pt_regs) > U8_MAX);
 			}
 			break;
 
@@ -2161,7 +2176,7 @@ st:			if (is_imm8(insn->off))
 				 * End result: x86 insn "mov rbx, qword ptr [rax+0x14]"
 				 * of 4 bytes will be ignored and rbx will be zero inited.
 				 */
-				ex->fixup = (prog - start_of_ldx) | (reg2pt_regs[dst_reg] << 8);
+				ex->fixup = (prog - start_of_ldx) | (reg2pt_regs[dst_reg] << 16);
 			}
 			break;
 
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index daf95333be78..9e086ca16028 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3604,6 +3604,7 @@ int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
 int bpf_stream_stage_dump_stack(struct bpf_stream_stage *ss);
 
 bool bpf_prog_stream_error_limit(struct bpf_prog *prog);
+void bpf_prog_report_arena_violation(bool write, unsigned long addr);
 
 #define bpf_stream_printk(...) bpf_stream_stage_printk(&__ss, __VA_ARGS__)
 #define bpf_stream_dump_stack() bpf_stream_stage_dump_stack(&__ss)
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 0d56cea71602..d4baa98de7d8 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -590,3 +590,17 @@ static int __init kfunc_init(void)
 	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &common_kfunc_set);
 }
 late_initcall(kfunc_init);
+
+void bpf_prog_report_arena_violation(bool write, unsigned long addr)
+{
+	struct bpf_prog *prog;
+
+	prog = bpf_prog_find_from_stack();
+	if (!prog)
+		return;
+	bpf_stream_stage(prog, BPF_STDERR, ({
+		bpf_stream_printk("ERROR: Arena %s access at unmapped address 0x%lx\n",
+				  write ? "WRITE" : "READ", addr);
+		bpf_stream_dump_stack();
+	}));
+}
-- 
2.47.1


