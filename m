Return-Path: <bpf+bounces-19530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C499282D938
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 13:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31BDAB214AA
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 12:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8A8171AF;
	Mon, 15 Jan 2024 12:55:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B2F1754E;
	Mon, 15 Jan 2024 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TDBth5v6gzGq0L;
	Mon, 15 Jan 2024 20:54:52 +0800 (CST)
Received: from kwepemd100009.china.huawei.com (unknown [7.221.188.135])
	by mail.maildlp.com (Postfix) with ESMTPS id C5BBB1406AC;
	Mon, 15 Jan 2024 20:54:56 +0800 (CST)
Received: from ultra.huawei.com (10.90.53.71) by
 kwepemd100009.china.huawei.com (7.221.188.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Mon, 15 Jan 2024 20:53:58 +0800
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
Subject: [PATCH bpf-next v3 5/6] riscv, bpf: Optimize sign-extention mov insns with Zbb support
Date: Mon, 15 Jan 2024 12:54:26 +0000
Message-ID: <20240115125427.2914015-6-pulehui@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115125427.2914015-1-pulehui@huawei.com>
References: <20240115125427.2914015-1-pulehui@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100009.china.huawei.com (7.221.188.135)

Add 8-bit and 16-bit sign-extention wraper with Zbb support to optimize
sign-extension mov instructions.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
Acked-by: Björn Töpel <bjorn@kernel.org>
---
 arch/riscv/net/bpf_jit.h        | 22 ++++++++++++++++++++++
 arch/riscv/net/bpf_jit_comp64.c |  5 +++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index 51f6d214086f..b00c5c0591d2 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -1119,6 +1119,28 @@ static inline void emit_subw(u8 rd, u8 rs1, u8 rs2, struct rv_jit_context *ctx)
 		emit(rv_subw(rd, rs1, rs2), ctx);
 }
 
+static inline void emit_sextb(u8 rd, u8 rs, struct rv_jit_context *ctx)
+{
+	if (rvzbb_enabled()) {
+		emit(rvzbb_sextb(rd, rs), ctx);
+		return;
+	}
+
+	emit_slli(rd, rs, 56, ctx);
+	emit_srai(rd, rd, 56, ctx);
+}
+
+static inline void emit_sexth(u8 rd, u8 rs, struct rv_jit_context *ctx)
+{
+	if (rvzbb_enabled()) {
+		emit(rvzbb_sexth(rd, rs), ctx);
+		return;
+	}
+
+	emit_slli(rd, rs, 48, ctx);
+	emit_srai(rd, rd, 48, ctx);
+}
+
 static inline void emit_sextw(u8 rd, u8 rs, struct rv_jit_context *ctx)
 {
 	emit_addiw(rd, rs, 0, ctx);
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index d90784674677..18bbf8122eb3 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1073,9 +1073,10 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_mv(rd, rs, ctx);
 			break;
 		case 8:
+			emit_sextb(rd, rs, ctx);
+			break;
 		case 16:
-			emit_slli(RV_REG_T1, rs, 64 - insn->off, ctx);
-			emit_srai(rd, RV_REG_T1, 64 - insn->off, ctx);
+			emit_sexth(rd, rs, ctx);
 			break;
 		case 32:
 			emit_sextw(rd, rs, ctx);
-- 
2.34.1


