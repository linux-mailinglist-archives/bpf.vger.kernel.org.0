Return-Path: <bpf+bounces-54451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2C4A6A535
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 12:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0817F883BBF
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 11:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD05E221D9C;
	Thu, 20 Mar 2025 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERe2JQHH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503CE21D3D2;
	Thu, 20 Mar 2025 11:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471040; cv=none; b=sda8zGN2DVMoIy2XDXN5T5C9co0X0O0WdEyAoyEH2icom0WVoqJM4d2kv5X+AYBILAZPnsJgCABu2OnVb55eY7HFZS5oSWg9XCkYlk9I9yFeEJniSajI2vA4R/F8wMZ3O2mEnri6D1O40uF/o9IAFyjO7dd0XXbM/a50YZWBLgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471040; c=relaxed/simple;
	bh=4aj2bBFJzCjQzuazdxB0n//R64oA/bqZDTXmWuoBJpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iudVDPJuGedizivhSs+A7qfNgTKrs5gJScxXjspqk0u+nJ2wHPgqfOw64O555wCU3madr0yfdrrGu+FKKpmUaL5Lhiyxuoh6V6RDLlMi9qvOnhEqAADMYVSuPKOb7Y40TQzhgXFfooCopaYP7CRnl7ZCEUStA4tlZ6c4DZNUFGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERe2JQHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4268C4CEDD;
	Thu, 20 Mar 2025 11:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742471038;
	bh=4aj2bBFJzCjQzuazdxB0n//R64oA/bqZDTXmWuoBJpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ERe2JQHH8XmDc5g0oJzuGntYGPDAMBx0gs/bGEsr5Dtu51qudPqG6TWBqS/MyfWU9
	 6vgKjQVpg/DT+4NDgyIxXgWBnNP/1zpiPKK/uaR46GDaGHXNgOjEMhEG82nMj995dI
	 NqEfbADeL4E7d0E4JWQ0kej0DO9664/91RX9QeTCPXkwrZURn124/DWzYC2IvM4h78
	 goOpYLh9XmT3vMck5/LpLVA/1ILFq9ixXVs/g6oX2su275HX/r2hgtKE51IWhdQ1Ue
	 +DsKDvMbTfjFq7s0WeNPmagsYb7ClwypI/1XBt8X4sM3NKNlJIS68s4xVIUeVdQnm/
	 jSwBq/DyCN0hQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PATCH RFCv3 10/23] uprobes/x86: Add support to emulate nop5 instruction
Date: Thu, 20 Mar 2025 12:41:45 +0100
Message-ID: <20250320114200.14377-11-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320114200.14377-1-jolsa@kernel.org>
References: <20250320114200.14377-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to emulate nop5 as the original uprobe instruction.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/uprobes.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 5ee2cce4c63e..1661e0ab2a3d 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -308,6 +308,11 @@ static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn, bool
 	return -ENOTSUPP;
 }
 
+static int is_nop5_insn(uprobe_opcode_t *insn)
+{
+	return !memcmp(insn, x86_nops[5], 5);
+}
+
 #ifdef CONFIG_X86_64
 
 asm (
@@ -865,6 +870,11 @@ void arch_uprobe_clear_state(struct mm_struct *mm)
 	hlist_for_each_entry_safe(tramp, n, &state->head_tramps, node)
 		destroy_uprobe_trampoline(tramp);
 }
+
+static bool emulate_nop5_insn(struct arch_uprobe *auprobe)
+{
+	return is_nop5_insn((uprobe_opcode_t *) &auprobe->insn);
+}
 #else /* 32-bit: */
 /*
  * No RIP-relative addressing on 32-bit
@@ -878,6 +888,10 @@ static void riprel_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 {
 }
+static bool emulate_nop5_insn(struct arch_uprobe *auprobe)
+{
+	return false;
+}
 #endif /* CONFIG_X86_64 */
 
 struct uprobe_xol_ops {
@@ -1109,6 +1123,8 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 		break;
 
 	case 0x0f:
+		if (emulate_nop5_insn(auprobe))
+			goto setup;
 		if (insn->opcode.nbytes != 2)
 			return -ENOSYS;
 		/*
-- 
2.49.0


