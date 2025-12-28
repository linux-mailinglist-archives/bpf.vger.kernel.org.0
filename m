Return-Path: <bpf+bounces-77462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C64CE54FC
	for <lists+bpf@lfdr.de>; Sun, 28 Dec 2025 18:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDEDB300ACFE
	for <lists+bpf@lfdr.de>; Sun, 28 Dec 2025 17:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DA4215F7D;
	Sun, 28 Dec 2025 17:38:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailer.gwdg.de (mailer.gwdg.de [134.76.10.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7329C1E0E14
	for <bpf@vger.kernel.org>; Sun, 28 Dec 2025 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766943499; cv=none; b=XeCeJ09J+/dUp7zP6gkLR0DOtOszDqAHn0k2L+aabpa3Axflf6LzqqToEeL7pQaNvZ6jtmjSpkqKfVTcDVt2sF6TAS+E7aVan4FM5QcZm8r9aOqoLT6duhaVOg0BsV8Az2f3CCW9lPVocfuTEE3HDo8ibARCzwLtOeajSvhFWmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766943499; c=relaxed/simple;
	bh=6mH4ktmDvRjIL4qMfoxfTGo2EDtTCw6N+eXDEucFxRY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aAMUidbdK4XKtDtxhnqo8hXDNJLiE+NpQnjPf7tl4aNDzhlGTqIAjQi52YNdnryRgC+01c0WyK8tddfehEPLyKjNxa6XFH5F/Qyh+JzSPeJGmtmDi/NQ38RyRv8yI868jaCkfNYAi6oFZK9dKTiEnjFJCKJBPMmsBJEvmAGtLTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cispa.de; spf=pass smtp.mailfrom=cispa.de; arc=none smtp.client-ip=134.76.10.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Received: from mbx19-sub-05.um.gwdg.de ([10.108.142.70] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(GWDG Mailer)
	(envelope-from <lukas.gerlach@cispa.de>)
	id 1vZuiU-000VmZ-2e;
	Sun, 28 Dec 2025 18:38:06 +0100
Received: from Mac (10.250.9.200) by MBX19-SUB-05.um.gwdg.de (10.108.142.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.35; Sun, 28 Dec
 2025 18:38:05 +0100
From: Lukas Gerlach <lukas.gerlach@cispa.de>
To: <bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC: <bjorn@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<luke.r.nels@gmail.com>, <xi.wang@gmail.com>, <palmer@dabbelt.com>,
	<luis.gerhorst@fau.de>, <daniel.weber@cispa.de>, <marton.bognar@kuleuven.be>,
	<jo.vanbulck@kuleuven.be>, <michael.schwarz@cispa.de>, Lukas Gerlach
	<lukas.gerlach@cispa.de>
Subject: [PATCH] riscv, bpf: Emit fence.i for BPF_NOSPEC
Date: Sun, 28 Dec 2025 18:37:53 +0100
Message-ID: <20251228173753.56767-1-lukas.gerlach@cispa.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mbx19-gwd-01.um.gwdg.de (10.108.142.50) To
 MBX19-SUB-05.um.gwdg.de (10.108.142.70)
X-Spam-Level: -
X-Virus-Scanned: (clean) by clamav

The BPF verifier inserts BPF_NOSPEC instructions to create speculation
barriers. However, the RISC-V BPF JIT emits nothing for this
instruction, leaving programs vulnerable to speculative execution
attacks.

Originally, BPF_NOSPEC was used only for Spectre v4 mitigation, programs
containing potential Spectre v1 gadgets were rejected by the verifier.
With the VeriFence changes, the verifier now accepts these
programs and inserts BPF_NOSPEC barriers for Spectre v1 mitigation as
well. On RISC-V, this means programs that were previously rejected are
now accepted but left unprotected against both v1 and v4 attacks.

RISC-V lacks a dedicated speculation barrier instruction.
This patch uses the fence.i instruction as a stopgap solution.
However an alternative and safer approach would be to reject vulnerable bpf
programs again.

Fixes: f5e81d111750 ("bpf: Introduce BPF nospec instruction for mitigating Spectre v4")
Fixes: 5fcf896efe28 ("Merge branch 'bpf-mitigate-spectre-v1-using-barriers'")
Signed-off-by: Lukas Gerlach <lukas.gerlach@cispa.de>
---
 arch/riscv/net/bpf_jit.h        | 10 ++++++++++
 arch/riscv/net/bpf_jit_comp32.c |  6 +++++-
 arch/riscv/net/bpf_jit_comp64.c |  6 +++++-
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index 632ced07bca4..e70b3bc19206 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -619,6 +619,16 @@ static inline void emit_fence_rw_rw(struct rv_jit_context *ctx)
 	emit(rv_fence(0x3, 0x3), ctx);
 }
 
+static inline u32 rv_fence_i(void)
+{
+	return rv_i_insn(0, 0, 1, 0, 0x0f);
+}
+
+static inline void emit_fence_i(struct rv_jit_context *ctx)
+{
+	emit(rv_fence_i(), ctx);
+}
+
 static inline u32 rv_nop(void)
 {
 	return rv_i_insn(0, 0, 0, 0, 0x13);
diff --git a/arch/riscv/net/bpf_jit_comp32.c b/arch/riscv/net/bpf_jit_comp32.c
index 592dd86fbf81..d9a6f55a7e8e 100644
--- a/arch/riscv/net/bpf_jit_comp32.c
+++ b/arch/riscv/net/bpf_jit_comp32.c
@@ -1248,8 +1248,12 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			return -1;
 		break;
 
-	/* speculation barrier */
+	/*
+	 * Speculation barrier using fence.i for pipeline serialization.
+	 * RISC-V lacks a dedicated speculation barrier instruction.
+	 */
 	case BPF_ST | BPF_NOSPEC:
+		emit_fence_i(ctx);
 		break;
 
 	case BPF_ST | BPF_MEM | BPF_B:
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 45cbc7c6fe49..fabafbebde0c 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1864,8 +1864,12 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		break;
 	}
 
-	/* speculation barrier */
+	/*
+	 * Speculation barrier using fence.i for pipeline serialization.
+	 * RISC-V lacks a dedicated speculation barrier instruction.
+	 */
 	case BPF_ST | BPF_NOSPEC:
+		emit_fence_i(ctx);
 		break;
 
 	/* ST: *(size *)(dst + off) = imm */
-- 
2.51.0


