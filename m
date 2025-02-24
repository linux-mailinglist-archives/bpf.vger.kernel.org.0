Return-Path: <bpf+bounces-52354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF298A42290
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 15:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D905441438
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 14:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B70248874;
	Mon, 24 Feb 2025 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4wNfpv+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBB5158858;
	Mon, 24 Feb 2025 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405840; cv=none; b=TdQlprNRkKKro1c9sW365akZeliG+BHhSfky7C/AfVO6pb6koYQE0jm6ttwS5ImaZuesRAPCLG1jcpdwQy9vuzLobTlFntZ0B/x0fsxDa5319KKm8MTUlrd/p6q24NvZreL2zG/luuWy8CE/LCqA0Gy0U875nyS9kPsAmbLJxy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405840; c=relaxed/simple;
	bh=7sclEyut+IWCsV/dgLzSESLGACLKNCIjwTjTpfPd//E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvqJ8a6u8OcBJH1WvyJUuEUz4E/4qIEHp8EjAfGFxBiN1GjOw+G/QaRJgZNA2ncIZ6PZn5IEouXWi30/gAZPSRhwqCv/UVjYPh+mKM+X+Gd7zR27OuJRtAFk3afgjnQLFXl7Zp/B9tCf9mzx32lfP82SgiXwJwR85lpOjxKMiHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4wNfpv+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068FBC4CED6;
	Mon, 24 Feb 2025 14:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405840;
	bh=7sclEyut+IWCsV/dgLzSESLGACLKNCIjwTjTpfPd//E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X4wNfpv+acHMvw67GB1CbgA+xYBwAr6sv9KPjylORPa6O6qb2bOWgklq8NNzG/agM
	 VPdYE/QAnXQjC1z4qIEuU69qjouAsVfLlO4+WZ/ZEup1ac60qq8o6i/eU0Q/3hzEQN
	 xVSzVPyP9OeiQuWbdVXkACvuY/bH2NrV/BVARBxC4OjNismyKWgFqfWshO9GOqIVG5
	 97aVJNoFPU4x+frrarfYEZNUiksPCg9wOAp7Cxpo3WIMM+DhoRg3DhJsjcjurSiybk
	 sQh9c8qF6gOnF1K0wV4qOS/sWb5umIrf0+i4GMlDcQlI1T9PfbN89VeWD0jA/HBiha
	 9YE9uV7Q5HlVQ==
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
Subject: [PATCH RFCv2 11/18] uprobes/x86: Add support to emulate nop5 instruction
Date: Mon, 24 Feb 2025 15:01:43 +0100
Message-ID: <20250224140151.667679-12-jolsa@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224140151.667679-1-jolsa@kernel.org>
References: <20250224140151.667679-1-jolsa@kernel.org>
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
index 8d4eb8133221..e8aebbda83bc 100644
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
@@ -927,6 +932,11 @@ void arch_uprobe_clear_state(struct mm_struct *mm)
 		node = next;
 	}
 }
+
+static bool emulate_nop5_insn(struct arch_uprobe *auprobe)
+{
+	return is_nop5_insn((uprobe_opcode_t *) &auprobe->insn);
+}
 #else /* 32-bit: */
 /*
  * No RIP-relative addressing on 32-bit
@@ -940,6 +950,10 @@ static void riprel_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 {
 }
+static bool emulate_nop5_insn(struct arch_uprobe *auprobe)
+{
+	return false;
+}
 #endif /* CONFIG_X86_64 */
 
 struct uprobe_xol_ops {
@@ -1171,6 +1185,8 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 		break;
 
 	case 0x0f:
+		if (emulate_nop5_insn(auprobe))
+			goto setup;
 		if (insn->opcode.nbytes != 2)
 			return -ENOSYS;
 		/*
-- 
2.48.1


