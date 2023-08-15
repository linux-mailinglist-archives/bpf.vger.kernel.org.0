Return-Path: <bpf+bounces-7824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 937EE77CF05
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 17:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E579281552
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 15:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B745156E3;
	Tue, 15 Aug 2023 15:21:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F187114AAA
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 15:21:15 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B89A1987
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 08:21:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RQFN22N2gz4f3vt9
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 23:21:06 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP3 (Coremail) with SMTP id _Ch0CgDH68Pgl9tk7KrwAg--.42348S8;
	Tue, 15 Aug 2023 23:21:07 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Yonghong Song <yhs@fb.com>,
	Zi Shen Lim <zlim.lnx@gmail.com>
Subject: [PATCH bpf-next 6/7] bpf, arm64: Support signed div/mod instructions
Date: Tue, 15 Aug 2023 11:41:57 -0400
Message-Id: <20230815154158.717901-7-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230815154158.717901-1-xukuohai@huaweicloud.com>
References: <20230815154158.717901-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDH68Pgl9tk7KrwAg--.42348S8
X-Coremail-Antispam: 1UD129KBjvJXoWxWw47XF17GFy8uFWxCF47CFg_yoW5Gr1rpr
	1fWrWSyw4jqr17JFyrCFnrWayakws5Xr1UtFyYq3yrtr4Yq34UWF1fKay5CrsxXFy5WFZ5
	WFy2yrZ7Ca4DJrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Xu Kuohai <xukuohai@huawei.com>

Add jit for signed div/mod instructions.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/arm64/net/bpf_jit.h      |  1 +
 arch/arm64/net/bpf_jit_comp.c | 20 ++++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index 949810a0c48c..23b1b34db088 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -234,6 +234,7 @@
 #define A64_DATA2(sf, Rd, Rn, Rm, type) aarch64_insn_gen_data2(Rd, Rn, Rm, \
 	A64_VARIANT(sf), AARCH64_INSN_DATA2_##type)
 #define A64_UDIV(sf, Rd, Rn, Rm) A64_DATA2(sf, Rd, Rn, Rm, UDIV)
+#define A64_SDIV(sf, Rd, Rn, Rm) A64_DATA2(sf, Rd, Rn, Rm, SDIV)
 #define A64_LSLV(sf, Rd, Rn, Rm) A64_DATA2(sf, Rd, Rn, Rm, LSLV)
 #define A64_LSRV(sf, Rd, Rn, Rm) A64_DATA2(sf, Rd, Rn, Rm, LSRV)
 #define A64_ASRV(sf, Rd, Rn, Rm) A64_DATA2(sf, Rd, Rn, Rm, ASRV)
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 924b8ef2e46a..150d1c6543f7 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -828,11 +828,17 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 		break;
 	case BPF_ALU | BPF_DIV | BPF_X:
 	case BPF_ALU64 | BPF_DIV | BPF_X:
-		emit(A64_UDIV(is64, dst, dst, src), ctx);
+		if (!off)
+			emit(A64_UDIV(is64, dst, dst, src), ctx);
+		else
+			emit(A64_SDIV(is64, dst, dst, src), ctx);
 		break;
 	case BPF_ALU | BPF_MOD | BPF_X:
 	case BPF_ALU64 | BPF_MOD | BPF_X:
-		emit(A64_UDIV(is64, tmp, dst, src), ctx);
+		if (!off)
+			emit(A64_UDIV(is64, tmp, dst, src), ctx);
+		else
+			emit(A64_SDIV(is64, tmp, dst, src), ctx);
 		emit(A64_MSUB(is64, dst, dst, tmp, src), ctx);
 		break;
 	case BPF_ALU | BPF_LSH | BPF_X:
@@ -959,12 +965,18 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	case BPF_ALU | BPF_DIV | BPF_K:
 	case BPF_ALU64 | BPF_DIV | BPF_K:
 		emit_a64_mov_i(is64, tmp, imm, ctx);
-		emit(A64_UDIV(is64, dst, dst, tmp), ctx);
+		if (!off)
+			emit(A64_UDIV(is64, dst, dst, tmp), ctx);
+		else
+			emit(A64_SDIV(is64, dst, dst, tmp), ctx);
 		break;
 	case BPF_ALU | BPF_MOD | BPF_K:
 	case BPF_ALU64 | BPF_MOD | BPF_K:
 		emit_a64_mov_i(is64, tmp2, imm, ctx);
-		emit(A64_UDIV(is64, tmp, dst, tmp2), ctx);
+		if (!off)
+			emit(A64_UDIV(is64, tmp, dst, tmp2), ctx);
+		else
+			emit(A64_SDIV(is64, tmp, dst, tmp2), ctx);
 		emit(A64_MSUB(is64, dst, dst, tmp, tmp2), ctx);
 		break;
 	case BPF_ALU | BPF_LSH | BPF_K:
-- 
2.30.2


