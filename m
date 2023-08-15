Return-Path: <bpf+bounces-7820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F0E77CEFE
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 17:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1E091C20C26
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 15:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811AE1548F;
	Tue, 15 Aug 2023 15:21:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493B514F8B
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 15:21:13 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2465F1986
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 08:21:10 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RQFN00HFsz4f4XWb
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 23:21:04 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP3 (Coremail) with SMTP id _Ch0CgDH68Pgl9tk7KrwAg--.42348S3;
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
Subject: [PATCH bpf-next 1/7] arm64: insn: Add encoders for LDRSB/LDRSH/LDRSW
Date: Tue, 15 Aug 2023 11:41:52 -0400
Message-Id: <20230815154158.717901-2-xukuohai@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgDH68Pgl9tk7KrwAg--.42348S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGFW7Jw4UCrWrXrW5tr1DKFg_yoWrCrW5pw
	n8Ar4rGr48WryrGasrtF18Jw45tF45tF4DK34UC3409w4UJFW7tw1jgF47ZF4DGr1YgFs8
	try8urnY9r15A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jesjbUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Xu Kuohai <xukuohai@huawei.com>

To support BPF sign-extend load instructions, add encoders for
LDRSB/LDRSH/LDRSW.

LDRSB/LDRSH/LDRSW (immediate) is encoded as follows:

     3     2 2   2   2                       1         0         0
     0     7 6   4   2                       0         5         0
  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
  | sz|1 1 1|0|0 1|opc|        imm12          |    Rn   |    Rt   |
  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

LDRSB/LDRSH/LDRSW (register) is encoded as follows:

     3     2 2   2   2 2         1     1 1   1         0         0
     0     7 6   4   2 1         6     3 2   0         5         0
  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
  | sz|1 1 1|0|0 0|opc|1|    Rm   | opt |S|1 0|    Rn   |    Rt   |
  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

where:

   - sz
     indicates whether 8-bit, 16-bit or 32-bit data is to be loaded

   - opc
     opc[1] (bit 23) is always 1 and opc[0] == 1 indicates regsize
     is 32-bit. Since BPF signed load instructions always exend the
     sign bit to bit 63 regardless of whether it loads an 8-bit,
     16-bit or 32-bit data. So only 64-bit register size is required.
     That is, it's sufficient to set field opc fixed to 0x2.

   - opt
     Indicates whether to sign extend the offset register Rm and the
     effective bits of Rm. We set opt to 0x7 (SXTX) since we'll use
     Rm as a sgined 64-bit value in BPF.

   - S
     Optional only when opt field is 0x3 (LSL)

In short, the above fields are encoded to the values listed below.

                   sz   opc  opt   S
LDRSB (immediate)  0x0  0x2  na    na
LDRSH (immediate)  0x1  0x2  na    na
LDRSW (immediate)  0x2  0x2  na    na
LDRSB (register)   0x0  0x2  0x7   0
LDRSH (register)   0x1  0x2  0x7   0
LDRSW (register)   0x2  0x2  0x7   0

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/arm64/include/asm/insn.h | 4 ++++
 arch/arm64/lib/insn.c         | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 139a88e4e852..db1aeacd4cd9 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -186,6 +186,8 @@ enum aarch64_insn_ldst_type {
 	AARCH64_INSN_LDST_LOAD_ACQ_EX,
 	AARCH64_INSN_LDST_STORE_EX,
 	AARCH64_INSN_LDST_STORE_REL_EX,
+	AARCH64_INSN_LDST_SIGNED_LOAD_IMM_OFFSET,
+	AARCH64_INSN_LDST_SIGNED_LOAD_REG_OFFSET,
 };
 
 enum aarch64_insn_adsb_type {
@@ -324,6 +326,7 @@ __AARCH64_INSN_FUNCS(prfm,	0x3FC00000, 0x39800000)
 __AARCH64_INSN_FUNCS(prfm_lit,	0xFF000000, 0xD8000000)
 __AARCH64_INSN_FUNCS(store_imm,	0x3FC00000, 0x39000000)
 __AARCH64_INSN_FUNCS(load_imm,	0x3FC00000, 0x39400000)
+__AARCH64_INSN_FUNCS(signed_load_imm, 0X3FC00000, 0x39800000)
 __AARCH64_INSN_FUNCS(store_pre,	0x3FE00C00, 0x38000C00)
 __AARCH64_INSN_FUNCS(load_pre,	0x3FE00C00, 0x38400C00)
 __AARCH64_INSN_FUNCS(store_post,	0x3FE00C00, 0x38000400)
@@ -337,6 +340,7 @@ __AARCH64_INSN_FUNCS(ldset,	0x3F20FC00, 0x38203000)
 __AARCH64_INSN_FUNCS(swp,	0x3F20FC00, 0x38208000)
 __AARCH64_INSN_FUNCS(cas,	0x3FA07C00, 0x08A07C00)
 __AARCH64_INSN_FUNCS(ldr_reg,	0x3FE0EC00, 0x38606800)
+__AARCH64_INSN_FUNCS(signed_ldr_reg, 0X3FE0FC00, 0x38A0E800)
 __AARCH64_INSN_FUNCS(ldr_imm,	0x3FC00000, 0x39400000)
 __AARCH64_INSN_FUNCS(ldr_lit,	0xBF000000, 0x18000000)
 __AARCH64_INSN_FUNCS(ldrsw_lit,	0xFF000000, 0x98000000)
diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index 924934cb85ee..a635ab83fee3 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -385,6 +385,9 @@ u32 aarch64_insn_gen_load_store_reg(enum aarch64_insn_register reg,
 	case AARCH64_INSN_LDST_LOAD_REG_OFFSET:
 		insn = aarch64_insn_get_ldr_reg_value();
 		break;
+	case AARCH64_INSN_LDST_SIGNED_LOAD_REG_OFFSET:
+		insn = aarch64_insn_get_signed_ldr_reg_value();
+		break;
 	case AARCH64_INSN_LDST_STORE_REG_OFFSET:
 		insn = aarch64_insn_get_str_reg_value();
 		break;
@@ -430,6 +433,9 @@ u32 aarch64_insn_gen_load_store_imm(enum aarch64_insn_register reg,
 	case AARCH64_INSN_LDST_LOAD_IMM_OFFSET:
 		insn = aarch64_insn_get_ldr_imm_value();
 		break;
+	case AARCH64_INSN_LDST_SIGNED_LOAD_IMM_OFFSET:
+		insn = aarch64_insn_get_signed_load_imm_value();
+		break;
 	case AARCH64_INSN_LDST_STORE_IMM_OFFSET:
 		insn = aarch64_insn_get_str_imm_value();
 		break;
-- 
2.30.2


