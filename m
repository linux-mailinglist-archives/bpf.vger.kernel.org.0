Return-Path: <bpf+bounces-55881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6EEA88843
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 18:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38A051899602
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 16:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDEA27FD66;
	Mon, 14 Apr 2025 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBf7wUrX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958202820CE
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647303; cv=none; b=BWA95/0li/9JFa1yMc2KPSJc+zWKKxDrS8S/aI3qYDNhL6RIR+JGP04EeTprY31V8KHxbxmJdEA89i1g8xmjBINNuSHbb+UOQRAnoLwoeSf7z7I4EdL+Z8b5zc93A32xu8hRnKKvb6YFnXupp2or2dx4G8puqSTGdJv6FjUjevs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647303; c=relaxed/simple;
	bh=Fakd8E6hdqYi9tcLwHZWfOI4zjzjypm5Gw+5gE76nxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icoWMhCezhl/v5/XT7GtB6dkrArA5raY5sBvZjgN4vvz+0WXtzbfYWWu7tpU8oTuWTh803oOVI+hVGvgZBXoNcAC/gfjxHu9POPvVJgRsQv+IPhba+QTd3E/yFBK1/gsGjtcszdVGDK8OCOLSCh/x15MA61EbEfw/DSYuIkMSvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBf7wUrX; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-38f2f391864so2546745f8f.3
        for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 09:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744647299; x=1745252099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdeln5z98wGmOquGNGMVXeyam+S+fxRqhxcGae2eHeM=;
        b=nBf7wUrXPvvNrR7tLoNt9L3waZvsPrqy4u1tYgqiYfn8Yg/XbHXA8+tuymZKWiRLFz
         5MF2BjIslXKqVLAlGb49JP43z55BWA9QSUsA1BOG9VQVvpJPCyysgdVLX3T2Uv+L0tvb
         hOx/9l098JbVc7tF5T4mpMCHQPU0y8pkVQYlQcyveQ9falWkf8jG2xdOrXKtjCIRLN+0
         ZVMuSJTQwZ8DhqJN3azq9zT1lB/epGPsO0hHHPSZ6W9QYxFrpwRFD2Xb9wH68O/VbnlT
         IWA8Lh1awDgVVynvY05JPpOVZpiBEOei4MrqNWFJ1f7ssC/45/Sg1PU3LdHQeQw55DJ5
         HUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744647299; x=1745252099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdeln5z98wGmOquGNGMVXeyam+S+fxRqhxcGae2eHeM=;
        b=ZmaUa3tmfR4de5Rkh9Bl5my9SI0QHt0x8SfkCewMh2Itzm5jlMXlK8wnNv/UkNdrDR
         oahlIqgbtOtZgL4kuiTxyqtLXeXbNqLOBy97stmiNuQqivV0857OHgC2tIm7Bt6wyOxn
         GmVNk7jRPYb+RvSceZXYrLFsu4KigF2gk0uMX89WZ49LMw0DufDVJj99siCwL2rsDZY1
         gN+vt4TN90GifN8VW7e8JUCS1yxj/o3I4zOcrMq76ECZMVhw4HnZNSSOMqqKyGL6TdOa
         u4B4YTGX17Np+rQM2/D5Z7RHRRMIU0ADZmqxqS26FvBNNNfWPPPNgTBhqTPsIjYdDB5D
         K1MA==
X-Gm-Message-State: AOJu0YzpeJZbJBUeLZUbMS/KWRcBK6S04J6OMe4GZSfwd5qacQlrm1t8
	BDFn7f0MuA0LncBN1u6XkytvLTusZ9/DXxFviEhnJzGqkZ3+CX8TCCXPqqyxHxw=
X-Gm-Gg: ASbGnctwQfzA6sZwxmmA05QzNeNUIHA4WVWunRHgIsVxIkZB+xO6WdmuyYux8xuscGj
	iT2ULDLpvEzKjXkPK0bPpaHXZ5uQW17smVRBLj4cezUZNDaCvZX7tFfLEVYttbVihTTBdGcUL3b
	eIdaykvPS5GhophIzCCETD1dFFx75YJZvpeKMWqTh3FwusXlQkDb2OiADx4BUNxkGmSaEWJvQiU
	4t2Y24DjfU60Kb5dr48LAhOKPszuLdJefdGUM8cniQbEAJo72xjL5QfjYn1iQJqu/aIKAoquhc/
	8F0d23dFb8XkX5kT4bDWjCKu+ZPP7hY=
X-Google-Smtp-Source: AGHT+IF0znboNtgIPkjE8vnnDMPZv1kpON9v91qbP1FdsNk9hLu4nEw16ysamNa7BCe4KDcYEZYe7w==
X-Received: by 2002:a05:6000:1787:b0:39c:2665:2bfc with SMTP id ffacd0b85a97d-39eaaed2ba0mr11107867f8f.52.1744647298947;
        Mon, 14 Apr 2025 09:14:58 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:72::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae978018sm11297389f8f.49.2025.04.14.09.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:14:58 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next/net v1 11/13] bpf: Report arena faults to BPF stderr
Date: Mon, 14 Apr 2025 09:14:41 -0700
Message-ID: <20250414161443.1146103-12-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250414161443.1146103-1-memxor@gmail.com>
References: <20250414161443.1146103-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3611; h=from:subject; bh=Fakd8E6hdqYi9tcLwHZWfOI4zjzjypm5Gw+5gE76nxA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn/TOKspt2ceV4dB3/czBnYNGNj+yxfnHL7jov9B54 NAK50qKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ/0zigAKCRBM4MiGSL8RyslVD/ 93ILHMpAd6Ax04/cFNlAj433Kdn1UjVGv2RBStM7xilrm/Zv9ZzqGdqTyLuDVSUnK3mZTvOVzPTPBW u/VzByD0RkGMxVyNauEOXFgOkKUgAbQlZaRdf69AY7A2DAGYvoMwSpYnevXSUZErwTQaUQA4cyiAhL SLXNuPaXKzsbmdy0JYNo4E4Dy46rjpat1bro/X0wBGM0nh64DcNK466TZ7ToeL6wB5GKF5RVWs2kCp aiUKq1UqpPGjcT++LfljnctoNO0OSfhIo/YzgSD3I3JQSh40HXnCDuK7LkE5DjY82RlunCDo1dyPL+ ev3cyPtdRqyYVQZoR9IpA2PLXQeJCzpZrPpHv1pU5+vVqtDJoxLE7kGxc4hPGgJlGKVEe6z/q4LKbz X4WPN0wFE4w0Upi3l8fcYLBov19b4snket8O4PNGy62POv2GqirIvM+R47CZ9HvrckQzJcJSnnxhrG 5xocDYIJgi+0E2UMHJD3ceOr1lmVGWs4iJtw+nk8w+JgVIc46UYyDX0KbU/ZxxZKXQxlE8QO41dXul stgTDPwbbw3MqMEI3QBpA529HlcxIpnBqzAGoLAGdOFV/lYhD3BFQ2PB8tzMy+x1XKYcqGS2DgY+4o NaZqjtEehfqaC9RF++gpymO63ksJZ9H3y4HeLpvxcws2/m0pMauRq7L9B9rA==
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
index 9e5fe2ba858f..434a6eae4621 100644
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
index cf057327798c..9fae22dde926 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3593,6 +3593,7 @@ __printf(2, 3)
 int bpf_prog_stderr_printk(struct bpf_prog *prog, const char *fmt, ...);
 struct bpf_prog *bpf_prog_find_from_stack(void);
 void bpf_prog_stderr_dump_stack(struct bpf_prog *prog);
+void bpf_prog_report_arena_violation(bool write, unsigned long addr);
 
 #ifdef CONFIG_BPF_LSM
 void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype);
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 0d56cea71602..593a93195cdc 100644
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
+	if (atomic_long_fetch_add(1, &prog->aux->error_count) >= BPF_PROG_ERROR_COUNT_MAX)
+		return;
+	bpf_prog_stderr_printk(prog, "ERROR: Arena %s access at unmapped address 0x%lx\n",
+			       write ? "WRITE" : "READ", addr);
+	bpf_prog_stderr_dump_stack(prog);
+}
-- 
2.47.1


