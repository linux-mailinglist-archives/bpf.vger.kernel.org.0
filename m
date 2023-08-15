Return-Path: <bpf+bounces-7821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8854577CF00
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 17:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9FF31C20D18
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 15:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEC3154BB;
	Tue, 15 Aug 2023 15:21:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A7D1549C
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 15:21:13 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFC41991
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 08:21:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RQFN20mn6z4f3nb2
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 23:21:06 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP3 (Coremail) with SMTP id _Ch0CgDH68Pgl9tk7KrwAg--.42348S5;
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
Subject: [PATCH bpf-next 3/7] bpf, arm64: Support sign-extension mov instructions
Date: Tue, 15 Aug 2023 11:41:54 -0400
Message-Id: <20230815154158.717901-4-xukuohai@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgDH68Pgl9tk7KrwAg--.42348S5
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy3XryDuw43JF15WF17KFg_yoW8AF1xpw
	45CrZayw4kW3W7ZF93tFsrXr1Ykw4vgr4DKF1Yg3yrtF4jqry8WF1Sk3y3CrZ8GrW5G3yr
	WFy2yrn3Ca4DXwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Xu Kuohai <xukuohai@huawei.com>

Add jit support for BPF sign-extension mov instructions with
arm64 SXTB/SXTH/SXTW instructions.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/arm64/net/bpf_jit.h      |  5 +++++
 arch/arm64/net/bpf_jit_comp.c | 15 ++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index 086ffbad0eb5..949810a0c48c 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -192,6 +192,11 @@
 #define A64_UXTH(sf, Rd, Rn) A64_UBFM(sf, Rd, Rn, 0, 15)
 #define A64_UXTW(sf, Rd, Rn) A64_UBFM(sf, Rd, Rn, 0, 31)
 
+/* Sign extend */
+#define A64_SXTB(sf, Rd, Rn) A64_SBFM(sf, Rd, Rn, 0, 7)
+#define A64_SXTH(sf, Rd, Rn) A64_SBFM(sf, Rd, Rn, 0, 15)
+#define A64_SXTW(sf, Rd, Rn) A64_SBFM(sf, Rd, Rn, 0, 31)
+
 /* Move wide (immediate) */
 #define A64_MOVEW(sf, Rd, imm16, shift, type) \
 	aarch64_insn_gen_movewide(Rd, imm16, shift, \
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 22f1b0d5fb3c..9b796e74ef42 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -786,7 +786,20 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	/* dst = src */
 	case BPF_ALU | BPF_MOV | BPF_X:
 	case BPF_ALU64 | BPF_MOV | BPF_X:
-		emit(A64_MOV(is64, dst, src), ctx);
+		switch (insn->off) {
+		case 0:
+			emit(A64_MOV(is64, dst, src), ctx);
+			break;
+		case 8:
+			emit(A64_SXTB(is64, dst, src), ctx);
+			break;
+		case 16:
+			emit(A64_SXTH(is64, dst, src), ctx);
+			break;
+		case 32:
+			emit(A64_SXTW(is64, dst, src), ctx);
+			break;
+		}
 		break;
 	/* dst = dst OP src */
 	case BPF_ALU | BPF_ADD | BPF_X:
-- 
2.30.2


