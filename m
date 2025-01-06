Return-Path: <bpf+bounces-47942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCDAA02223
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 10:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53FA4161BAF
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 09:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9866A1D90A7;
	Mon,  6 Jan 2025 09:50:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DBD1E505;
	Mon,  6 Jan 2025 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736157006; cv=none; b=gPa/MrpsspdUFn4Ij8dsb3r7J+FW4xJzTwVjjxX09JV6uSiCnlM+43+0x2Vtb2Oe8CNVDojmDnvin9CQAtGjrntfqe2fJbBsCfrknB+e4Ew+mcy8nT2ymEUhNATvDzHvvEQvvdsaXtG9BPZNVzSwOre6gvv3U03tQaPRcZOkkbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736157006; c=relaxed/simple;
	bh=DkgJcUWyberuxHGqmouxPHFIIH4Z6zBKnmyHloZFw0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WmQ7lhRzF/lG6+g8Sro2Nmf9BhiyWteJhWYnZBtZA35f2UPyJhJISkFM8bp8qqcW7IGVGYrgIhl37zpq1fGQ+XlSes/eaY70LYGjNFtFAPsrGZOzPXQ6RjKsDrMWGckDHCnTLtrh24Z0U3Rkul65CXmR2D6na7DZZiBEMPPHKFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YRT7g0l2Rz9sPd;
	Mon,  6 Jan 2025 10:16:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dDjDGN6MZU9u; Mon,  6 Jan 2025 10:16:15 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YRT7f6qCVz9rvV;
	Mon,  6 Jan 2025 10:16:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D732E8B76D;
	Mon,  6 Jan 2025 10:16:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 2HSn831M5OvB; Mon,  6 Jan 2025 10:16:14 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1D51F8B763;
	Mon,  6 Jan 2025 10:16:14 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Johan Almbladh <johan.almbladh@anyfinetworks.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next] bpf/tests: Add 32 bits only mong conditional jump tests
Date: Mon,  6 Jan 2025 10:15:31 +0100
Message-ID: <609f87a2d84e032c8d9ccb9ba7aebef893698f1e.1736154762.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736154934; l=4010; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=DkgJcUWyberuxHGqmouxPHFIIH4Z6zBKnmyHloZFw0k=; b=gJs5rhn13O0JKoCv9H40lq8DVGjMEfY+sJh9iUdWtrNx7HdwuM5HvSwKfJWEdbzfa8LKvP/Tw hXctyYAop7FBBEXtubxoYdWy7C4H+nKZwk0t9tDU9+4A8AZWcnOhyDL
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Commit f1517eb790f9 ("bpf/tests: Expand branch conversion JIT test")
introduced "Long conditional jump tests" but due to those tests making
use of 64 bits DIV and MOD, they don't get jited on powerpc/32,
leading to the Long conditional jump test being skiped for unrelated
reason.

Add 4 new tests that are restricted to 32 bits ALU so that the jump
tests can also be performed on platforms that do no support 64 bits
operations.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 lib/test_bpf.c | 64 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 6 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 2eed1ad958e9..af0041df2b72 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -478,7 +478,7 @@ static int __bpf_ld_imm64(struct bpf_insn insns[2], u8 reg, s64 imm64)
  * to overflow the field size of the native instruction, triggering
  * a branch conversion mechanism in some JITs.
  */
-static int __bpf_fill_max_jmp(struct bpf_test *self, int jmp, int imm)
+static int __bpf_fill_max_jmp(struct bpf_test *self, int jmp, int imm, bool alu32)
 {
 	struct bpf_insn *insns;
 	int len = S16_MAX + 5;
@@ -501,7 +501,7 @@ static int __bpf_fill_max_jmp(struct bpf_test *self, int jmp, int imm)
 		};
 		int op = ops[(i >> 1) % ARRAY_SIZE(ops)];
 
-		if (i & 1)
+		if ((i & 1) || alu32)
 			insns[i++] = BPF_ALU32_REG(op, R0, R1);
 		else
 			insns[i++] = BPF_ALU64_REG(op, R0, R1);
@@ -516,27 +516,47 @@ static int __bpf_fill_max_jmp(struct bpf_test *self, int jmp, int imm)
 }
 
 /* Branch taken by runtime decision */
+static int bpf_fill_max_jmp_taken_32(struct bpf_test *self)
+{
+	return __bpf_fill_max_jmp(self, BPF_JEQ, 1, true);
+}
+
 static int bpf_fill_max_jmp_taken(struct bpf_test *self)
 {
-	return __bpf_fill_max_jmp(self, BPF_JEQ, 1);
+	return __bpf_fill_max_jmp(self, BPF_JEQ, 1, false);
 }
 
 /* Branch not taken by runtime decision */
+static int bpf_fill_max_jmp_not_taken_32(struct bpf_test *self)
+{
+	return __bpf_fill_max_jmp(self, BPF_JEQ, 0, true);
+}
+
 static int bpf_fill_max_jmp_not_taken(struct bpf_test *self)
 {
-	return __bpf_fill_max_jmp(self, BPF_JEQ, 0);
+	return __bpf_fill_max_jmp(self, BPF_JEQ, 0, false);
 }
 
 /* Branch always taken, known at JIT time */
+static int bpf_fill_max_jmp_always_taken_32(struct bpf_test *self)
+{
+	return __bpf_fill_max_jmp(self, BPF_JGE, 0, true);
+}
+
 static int bpf_fill_max_jmp_always_taken(struct bpf_test *self)
 {
-	return __bpf_fill_max_jmp(self, BPF_JGE, 0);
+	return __bpf_fill_max_jmp(self, BPF_JGE, 0, false);
 }
 
 /* Branch never taken, known at JIT time */
+static int bpf_fill_max_jmp_never_taken_32(struct bpf_test *self)
+{
+	return __bpf_fill_max_jmp(self, BPF_JLT, 0, true);
+}
+
 static int bpf_fill_max_jmp_never_taken(struct bpf_test *self)
 {
-	return __bpf_fill_max_jmp(self, BPF_JLT, 0);
+	return __bpf_fill_max_jmp(self, BPF_JLT, 0, false);
 }
 
 /* ALU result computation used in tests */
@@ -14233,6 +14253,38 @@ static struct bpf_test tests[] = {
 		{ { 0, 0 } },
 	},
 	/* Conditional branch conversions */
+	{
+		"Long conditional jump: taken at runtime (32 bits)",
+		{ },
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 1 } },
+		.fill_helper = bpf_fill_max_jmp_taken_32,
+	},
+	{
+		"Long conditional jump: not taken at runtime (32 bits)",
+		{ },
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 2 } },
+		.fill_helper = bpf_fill_max_jmp_not_taken_32,
+	},
+	{
+		"Long conditional jump: always taken, known at JIT time (32 bits)",
+		{ },
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 1 } },
+		.fill_helper = bpf_fill_max_jmp_always_taken_32,
+	},
+	{
+		"Long conditional jump: never taken, known at JIT time (32 bits)",
+		{ },
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 2 } },
+		.fill_helper = bpf_fill_max_jmp_never_taken_32,
+	},
 	{
 		"Long conditional jump: taken at runtime",
 		{ },
-- 
2.47.0


