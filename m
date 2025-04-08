Return-Path: <bpf+bounces-55486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D435A81775
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 23:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C8F882FBC
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 21:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88919254872;
	Tue,  8 Apr 2025 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/KNCsgN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F6A2417D4;
	Tue,  8 Apr 2025 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744146799; cv=none; b=bRmQqIl3AsCShJ4qPtRwvBDJiodNXfZmnVe7QYWUVqlYxKhLt/BJ9MAOEQZQvXCR+agKhYr2xmZnL/wxTfvoHfrYEYxmsROg9zgZkCC72QQyBPAzpZETMEcs/c6yh5AB9NxHnhZBiHwUo+0ZFfMUtcE4qQSSVO71r1zmUcOFVZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744146799; c=relaxed/simple;
	bh=4XTGbVk3H1/JsZw2yQHbbPJty1TmOM+R+b0T4ZYIRxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QRB0NXb0rG8XwhA1IRcYNHdhVF2rLS0AtiejwR9/rHOFmyCQn586HLYyTvpfNNtqKNGJTEzzgBFMru0etk9Y1d9wgn4mz9cZVQUCpeoWQdNxJx5Ua/EKz6KYS5MPqyS5EBp3sAne9M/QB+NnJRYn4bLCr4ARwAJK/DA2M8peSjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/KNCsgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81952C4CEE5;
	Tue,  8 Apr 2025 21:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744146798;
	bh=4XTGbVk3H1/JsZw2yQHbbPJty1TmOM+R+b0T4ZYIRxk=;
	h=From:To:Cc:Subject:Date:From;
	b=J/KNCsgNDM2p+TlgPyOus1HIQuqdQ7KbF8LMEssSK015qYHBfbcl8CWKwXCh8dg9W
	 k5lzI/tNkoR8h2sbAxOA2KCF27KcGrEfZNj8UL4GPKvlD24MpKr22MxkZzsuvHEZZO
	 +GvjUsCHhdH/iNGf6YXuDiZaDcShro/bUz/W3E6Rbgw8W95dkE6dJd06dhz5KBepML
	 ONeaUPq7C/XtYhnBl+yJirRIcwNmzyRyBjQ+uqwmT9ussWiFun61WKMmTIC06bQh90
	 tRHj5zcXQxKQV3x+vdnocNgKgzDE3/AYBg1aiVMZtQeMZuA8zm9uCdJf4LYzQcZ8Kc
	 FpG8pXedhCz0w==
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
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH 1/2] uprobes/x86: Add support to emulate nop5 instruction
Date: Tue,  8 Apr 2025 23:13:09 +0200
Message-ID: <20250408211310.51491-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to emulate nop5 as the original uprobe instruction.

This change speeds up uprobe on top of nop5 and is a preparation for
usdt probe optimization, that will be done on top of nop5 instruction.

With this change the usdt probe on top of nop5 won't take the performance
hit compared to usdt probe on top of standard nop instruction.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/uprobes.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 9194695662b2..63cc68e19da6 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -608,6 +608,16 @@ static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 		*sr = utask->autask.saved_scratch_register;
 	}
 }
+
+static int is_nop5_insn(uprobe_opcode_t *insn)
+{
+	return !memcmp(insn, x86_nops[5], 5);
+}
+
+static bool emulate_nop5_insn(struct arch_uprobe *auprobe)
+{
+	return is_nop5_insn((uprobe_opcode_t *) &auprobe->insn);
+}
 #else /* 32-bit: */
 /*
  * No RIP-relative addressing on 32-bit
@@ -621,6 +631,10 @@ static void riprel_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 {
 }
+static bool emulate_nop5_insn(struct arch_uprobe *auprobe)
+{
+	return false;
+}
 #endif /* CONFIG_X86_64 */
 
 struct uprobe_xol_ops {
@@ -852,6 +866,8 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 		break;
 
 	case 0x0f:
+		if (emulate_nop5_insn(auprobe))
+			goto setup;
 		if (insn->opcode.nbytes != 2)
 			return -ENOSYS;
 		/*
-- 
2.49.0


