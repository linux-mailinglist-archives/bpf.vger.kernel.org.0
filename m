Return-Path: <bpf+bounces-19534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D26B082D9C8
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 14:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA401F21B60
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 13:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D403B1755B;
	Mon, 15 Jan 2024 13:12:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B50F171C2;
	Mon, 15 Jan 2024 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TDCGZ2G0nz4f3jqc;
	Mon, 15 Jan 2024 21:12:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 684F41A0B62;
	Mon, 15 Jan 2024 21:12:08 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgBnu20iL6VlSeWtAw--.15591S7;
	Mon, 15 Jan 2024 21:12:08 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Conor Dooley <conor@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH RESEND bpf-next v3 5/6] riscv, bpf: Optimize sign-extention mov insns with Zbb support
Date: Mon, 15 Jan 2024 13:12:34 +0000
Message-Id: <20240115131235.2914289-6-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115131235.2914289-1-pulehui@huaweicloud.com>
References: <20240115131235.2914289-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnu20iL6VlSeWtAw--.15591S7
X-Coremail-Antispam: 1UD129KBjvJXoW7KryDur1xJF48AF18JFy5Arb_yoW8CF1kpF
	WUGrn3CrWvqF1fKF9xtF47Wr15GF4vvF17KF47K398ta1Iqr4DGw1Fkw12yF98GFy8W3Wr
	WFWjkry3C3Wvva7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUl
	2NtUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

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


