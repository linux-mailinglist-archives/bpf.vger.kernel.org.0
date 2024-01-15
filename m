Return-Path: <bpf+bounces-19531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6BF82D93A
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 13:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64BB51C213D7
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 12:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DB0168A8;
	Mon, 15 Jan 2024 12:55:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598F116429;
	Mon, 15 Jan 2024 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TDBtM4kFTzsR5n;
	Mon, 15 Jan 2024 20:54:35 +0800 (CST)
Received: from kwepemd100009.china.huawei.com (unknown [7.221.188.135])
	by mail.maildlp.com (Postfix) with ESMTPS id D2B421400CD;
	Mon, 15 Jan 2024 20:55:11 +0800 (CST)
Received: from ultra.huawei.com (10.90.53.71) by
 kwepemd100009.china.huawei.com (7.221.188.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Mon, 15 Jan 2024 20:53:59 +0800
From: Pu Lehui <pulehui@huawei.com>
To: <bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<netdev@vger.kernel.org>
CC: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yhs@fb.com>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, Luke
 Nelson <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>, Pu Lehui
	<pulehui@huaweicloud.com>
Subject: [PATCH bpf-next v3 6/6] riscv, bpf: Optimize bswap insns with Zbb support
Date: Mon, 15 Jan 2024 12:54:27 +0000
Message-ID: <20240115125427.2914015-7-pulehui@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115125427.2914015-1-pulehui@huawei.com>
References: <20240115125427.2914015-1-pulehui@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100009.china.huawei.com (7.221.188.135)

Optimize bswap instructions by rev8 Zbb instruction conbined with srli
instruction. And Optimize 16-bit zero-extension with Zbb support.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit.h        | 69 +++++++++++++++++++++++++++++++++
 arch/riscv/net/bpf_jit_comp64.c | 50 +-----------------------
 2 files changed, 71 insertions(+), 48 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index b00c5c0591d2..8b35f12a4452 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -1146,12 +1146,81 @@ static inline void emit_sextw(u8 rd, u8 rs, struct rv_jit_context *ctx)
 	emit_addiw(rd, rs, 0, ctx);
 }
 
+static inline void emit_zexth(u8 rd, u8 rs, struct rv_jit_context *ctx)
+{
+	if (rvzbb_enabled()) {
+		emit(rvzbb_zexth(rd, rs), ctx);
+		return;
+	}
+
+	emit_slli(rd, rs, 48, ctx);
+	emit_srli(rd, rd, 48, ctx);
+}
+
 static inline void emit_zextw(u8 rd, u8 rs, struct rv_jit_context *ctx)
 {
 	emit_slli(rd, rs, 32, ctx);
 	emit_srli(rd, rd, 32, ctx);
 }
 
+static inline void emit_bswap(u8 rd, s32 imm, struct rv_jit_context *ctx)
+{
+	if (rvzbb_enabled()) {
+		int bits = 64 - imm;
+
+		emit(rvzbb_rev8(rd, rd), ctx);
+		if (bits)
+			emit_srli(rd, rd, bits, ctx);
+		return;
+	}
+
+	emit_li(RV_REG_T2, 0, ctx);
+
+	emit_andi(RV_REG_T1, rd, 0xff, ctx);
+	emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
+	emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
+	emit_srli(rd, rd, 8, ctx);
+	if (imm == 16)
+		goto out_be;
+
+	emit_andi(RV_REG_T1, rd, 0xff, ctx);
+	emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
+	emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
+	emit_srli(rd, rd, 8, ctx);
+
+	emit_andi(RV_REG_T1, rd, 0xff, ctx);
+	emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
+	emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
+	emit_srli(rd, rd, 8, ctx);
+	if (imm == 32)
+		goto out_be;
+
+	emit_andi(RV_REG_T1, rd, 0xff, ctx);
+	emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
+	emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
+	emit_srli(rd, rd, 8, ctx);
+
+	emit_andi(RV_REG_T1, rd, 0xff, ctx);
+	emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
+	emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
+	emit_srli(rd, rd, 8, ctx);
+
+	emit_andi(RV_REG_T1, rd, 0xff, ctx);
+	emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
+	emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
+	emit_srli(rd, rd, 8, ctx);
+
+	emit_andi(RV_REG_T1, rd, 0xff, ctx);
+	emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
+	emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
+	emit_srli(rd, rd, 8, ctx);
+out_be:
+	emit_andi(RV_REG_T1, rd, 0xff, ctx);
+	emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
+
+	emit_mv(rd, RV_REG_T2, ctx);
+}
+
 #endif /* __riscv_xlen == 64 */
 
 void bpf_jit_build_prologue(struct rv_jit_context *ctx);
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 18bbf8122eb3..e86e83649820 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1176,8 +1176,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_ALU | BPF_END | BPF_FROM_LE:
 		switch (imm) {
 		case 16:
-			emit_slli(rd, rd, 48, ctx);
-			emit_srli(rd, rd, 48, ctx);
+			emit_zexth(rd, rd, ctx);
 			break;
 		case 32:
 			if (!aux->verifier_zext)
@@ -1188,54 +1187,9 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			break;
 		}
 		break;
-
 	case BPF_ALU | BPF_END | BPF_FROM_BE:
 	case BPF_ALU64 | BPF_END | BPF_FROM_LE:
-		emit_li(RV_REG_T2, 0, ctx);
-
-		emit_andi(RV_REG_T1, rd, 0xff, ctx);
-		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
-		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
-		emit_srli(rd, rd, 8, ctx);
-		if (imm == 16)
-			goto out_be;
-
-		emit_andi(RV_REG_T1, rd, 0xff, ctx);
-		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
-		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
-		emit_srli(rd, rd, 8, ctx);
-
-		emit_andi(RV_REG_T1, rd, 0xff, ctx);
-		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
-		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
-		emit_srli(rd, rd, 8, ctx);
-		if (imm == 32)
-			goto out_be;
-
-		emit_andi(RV_REG_T1, rd, 0xff, ctx);
-		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
-		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
-		emit_srli(rd, rd, 8, ctx);
-
-		emit_andi(RV_REG_T1, rd, 0xff, ctx);
-		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
-		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
-		emit_srli(rd, rd, 8, ctx);
-
-		emit_andi(RV_REG_T1, rd, 0xff, ctx);
-		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
-		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
-		emit_srli(rd, rd, 8, ctx);
-
-		emit_andi(RV_REG_T1, rd, 0xff, ctx);
-		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
-		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
-		emit_srli(rd, rd, 8, ctx);
-out_be:
-		emit_andi(RV_REG_T1, rd, 0xff, ctx);
-		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
-
-		emit_mv(rd, RV_REG_T2, ctx);
+		emit_bswap(rd, imm, ctx);
 		break;
 
 	/* dst = imm */
-- 
2.34.1


