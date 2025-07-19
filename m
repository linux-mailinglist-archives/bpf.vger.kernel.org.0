Return-Path: <bpf+bounces-63791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC4FB0AEF2
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 11:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0EE189BC68
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 09:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911C7238C25;
	Sat, 19 Jul 2025 09:14:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7A12E3716;
	Sat, 19 Jul 2025 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752916468; cv=none; b=Xi6lbELpNXiBzQHxKk2NbypK2TLScMjny/dxkBYbN9mrEDI879X58690rgIMECAtQGiGfAYFgYAVwhU3zVTvhR1r1jaAJWzD2vltnr2Su0kOpJT5MHwJViOKqPZDKoU7gnm1rg1RUwBetCgkfz/pXbPgMlqWUcMr1anSBpodmcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752916468; c=relaxed/simple;
	bh=5Fa/WW1ZbE0RN2WrBeuodLM45z2z8OcFRyY4lp6O6vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R5gECB8C/MzQZew5/m3UCzR+fTc4qbvf1U4Ew+yqn2epkTaLQTuqxbzUPI/YGHGpPr4dSh28wDvb6WK1UWyPaA3OqlhO4r0CYU2ej6idPY9b010iqdxKv7gpj1gkjsMGJRJzLqILVSUm8Wzpgjd/j1j9La7s/SMmAg7CNi5xLlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bkgw124v9zYQvFN;
	Sat, 19 Jul 2025 17:14:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 09E121A10A8;
	Sat, 19 Jul 2025 17:14:24 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgCHURLuYXtopCAYAw--.54295S7;
	Sat, 19 Jul 2025 17:14:23 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
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
	Jiri Olsa <jolsa@kernel.org>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next 05/10] riscv, bpf: Add rv_ext_enabled macro for runtime detection extentsion
Date: Sat, 19 Jul 2025 09:17:25 +0000
Message-Id: <20250719091730.2660197-6-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250719091730.2660197-1-pulehui@huaweicloud.com>
References: <20250719091730.2660197-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHURLuYXtopCAYAw--.54295S7
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4UJFyUWryUtF4kGFy7GFg_yoW5ZFykpF
	WDCr4S93s7tFyrKFWqyr13Jr1rAr4vqr17Grn2g3yDGayfZr1DG3Z3AF1jyFy5Zry8ZFyf
	AFW3GF1fuw4jk37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI-eODUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Add rv_ext_enabled macro to check whether the runtime detection
extension is enabled.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit.h | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index e7b032dfd17f..0964df48c25e 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -13,21 +13,15 @@
 #include <linux/filter.h>
 #include <asm/cacheflush.h>
 
+/* verify runtime detection extension status */
+#define rv_ext_enabled(ext) \
+	(IS_ENABLED(CONFIG_RISCV_ISA_##ext) && riscv_has_extension_likely(RISCV_ISA_EXT_##ext))
+
 static inline bool rvc_enabled(void)
 {
 	return IS_ENABLED(CONFIG_RISCV_ISA_C);
 }
 
-static inline bool rvzba_enabled(void)
-{
-	return IS_ENABLED(CONFIG_RISCV_ISA_ZBA) && riscv_has_extension_likely(RISCV_ISA_EXT_ZBA);
-}
-
-static inline bool rvzbb_enabled(void)
-{
-	return IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && riscv_has_extension_likely(RISCV_ISA_EXT_ZBB);
-}
-
 enum {
 	RV_REG_ZERO =	0,	/* The constant value 0 */
 	RV_REG_RA =	1,	/* Return address */
@@ -1123,7 +1117,7 @@ static inline void emit_sw(u8 rs1, s32 off, u8 rs2, struct rv_jit_context *ctx)
 
 static inline void emit_sh2add(u8 rd, u8 rs1, u8 rs2, struct rv_jit_context *ctx)
 {
-	if (rvzba_enabled()) {
+	if (rv_ext_enabled(ZBA)) {
 		emit(rvzba_sh2add(rd, rs1, rs2), ctx);
 		return;
 	}
@@ -1134,7 +1128,7 @@ static inline void emit_sh2add(u8 rd, u8 rs1, u8 rs2, struct rv_jit_context *ctx
 
 static inline void emit_sh3add(u8 rd, u8 rs1, u8 rs2, struct rv_jit_context *ctx)
 {
-	if (rvzba_enabled()) {
+	if (rv_ext_enabled(ZBA)) {
 		emit(rvzba_sh3add(rd, rs1, rs2), ctx);
 		return;
 	}
@@ -1184,7 +1178,7 @@ static inline void emit_subw(u8 rd, u8 rs1, u8 rs2, struct rv_jit_context *ctx)
 
 static inline void emit_sextb(u8 rd, u8 rs, struct rv_jit_context *ctx)
 {
-	if (rvzbb_enabled()) {
+	if (rv_ext_enabled(ZBB)) {
 		emit(rvzbb_sextb(rd, rs), ctx);
 		return;
 	}
@@ -1195,7 +1189,7 @@ static inline void emit_sextb(u8 rd, u8 rs, struct rv_jit_context *ctx)
 
 static inline void emit_sexth(u8 rd, u8 rs, struct rv_jit_context *ctx)
 {
-	if (rvzbb_enabled()) {
+	if (rv_ext_enabled(ZBB)) {
 		emit(rvzbb_sexth(rd, rs), ctx);
 		return;
 	}
@@ -1211,7 +1205,7 @@ static inline void emit_sextw(u8 rd, u8 rs, struct rv_jit_context *ctx)
 
 static inline void emit_zexth(u8 rd, u8 rs, struct rv_jit_context *ctx)
 {
-	if (rvzbb_enabled()) {
+	if (rv_ext_enabled(ZBB)) {
 		emit(rvzbb_zexth(rd, rs), ctx);
 		return;
 	}
@@ -1222,7 +1216,7 @@ static inline void emit_zexth(u8 rd, u8 rs, struct rv_jit_context *ctx)
 
 static inline void emit_zextw(u8 rd, u8 rs, struct rv_jit_context *ctx)
 {
-	if (rvzba_enabled()) {
+	if (rv_ext_enabled(ZBA)) {
 		emit(rvzba_zextw(rd, rs), ctx);
 		return;
 	}
@@ -1233,7 +1227,7 @@ static inline void emit_zextw(u8 rd, u8 rs, struct rv_jit_context *ctx)
 
 static inline void emit_bswap(u8 rd, s32 imm, struct rv_jit_context *ctx)
 {
-	if (rvzbb_enabled()) {
+	if (rv_ext_enabled(ZBB)) {
 		int bits = 64 - imm;
 
 		emit(rvzbb_rev8(rd, rd), ctx);
-- 
2.34.1


