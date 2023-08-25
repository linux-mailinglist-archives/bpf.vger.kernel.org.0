Return-Path: <bpf+bounces-8625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAF8788C4F
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 17:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E832F281870
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 15:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6412C10791;
	Fri, 25 Aug 2023 15:18:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8AACA60
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 15:18:47 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0382121
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 08:18:46 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PFA69m015318;
	Fri, 25 Aug 2023 15:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PMjr//xMHYo/Z0v5toc4Cy/Alu9NfkfcEXlHjLLC6G8=;
 b=B0ZD6Wz2RKV6ELsluJroZZnivMcEe6vap1tUQGPhWiN6TuGB/LoeaBsTAFJS+pTNHVjy
 XAV2fE8WIAHz0JLNYsKaeFx6+knTG6XxvN/QfY6jXP4z2Vwg6+pwhpQ7rInIlwI2X8b7
 ABQ9W9xJ51YGJr7Z/vEBB9sm5UUMOOXe6hUG14MEMs8CgRO9Qo1+q2UtpRUZENatQ4h6
 Z9SnH9LIHbrvvU6g6ThgPfQDn2p46b03/+AhQDsX888scOn5LOn5CimKbgu7LOtuyhT5
 WoC1OvMFWpgpTkCeNxW9hCtc/wIsPQOCy9aO+nvz3m5BEpnAmd25MnAFbrjlq3YCTDSz Yg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3spvrmbxqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Aug 2023 15:18:20 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37PDCInp004042;
	Fri, 25 Aug 2023 15:18:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sn21s0g0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Aug 2023 15:18:19 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37PFIHRs22086330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Aug 2023 15:18:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4465120043;
	Fri, 25 Aug 2023 15:18:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30AC820040;
	Fri, 25 Aug 2023 15:18:15 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.75.97])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Aug 2023 15:18:14 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Song Liu <songliubraving@fb.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 1/5] powerpc/bpf: implement bpf_arch_text_copy
Date: Fri, 25 Aug 2023 20:48:06 +0530
Message-ID: <20230825151810.164418-2-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825151810.164418-1-hbathini@linux.ibm.com>
References: <20230825151810.164418-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: b8Mh2RtNzn-eY5Pab_36vKt6MD3fgUCC
X-Proofpoint-ORIG-GUID: b8Mh2RtNzn-eY5Pab_36vKt6MD3fgUCC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_13,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0
 mlxlogscore=992 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250134
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

bpf_arch_text_copy is used to dump JITed binary to RX page, allowing
multiple BPF programs to share the same page. Use patch_instruction()
to implement it.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c | 40 ++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 37043dfc1add..170ebf8ac0f2 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -13,9 +13,12 @@
 #include <linux/netdevice.h>
 #include <linux/filter.h>
 #include <linux/if_vlan.h>
-#include <asm/kprobes.h>
+#include <linux/memory.h>
 #include <linux/bpf.h>
 
+#include <asm/kprobes.h>
+#include <asm/code-patching.h>
+
 #include "bpf_jit.h"
 
 static void bpf_jit_fill_ill_insns(void *area, unsigned int size)
@@ -23,6 +26,27 @@ static void bpf_jit_fill_ill_insns(void *area, unsigned int size)
 	memset32(area, BREAKPOINT_INSTRUCTION, size / 4);
 }
 
+/*
+ * Patch 'len' bytes of instructions from opcode to addr, one instruction
+ * at a time. Returns addr on success. ERR_PTR(-EINVAL), otherwise.
+ */
+static void *bpf_patch_instructions(void *addr, void *opcode, size_t len)
+{
+	while (len > 0) {
+		ppc_inst_t insn = ppc_inst_read(opcode);
+		int ilen = ppc_inst_len(insn);
+
+		if (patch_instruction(addr, insn))
+			return ERR_PTR(-EINVAL);
+
+		len -= ilen;
+		addr = addr + ilen;
+		opcode = opcode + ilen;
+	}
+
+	return addr;
+}
+
 int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr)
 {
 	if (!exit_addr || is_offset_in_branch_range(exit_addr - (ctx->idx * 4))) {
@@ -274,3 +298,17 @@ int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, int pass, struct code
 	ctx->exentry_idx++;
 	return 0;
 }
+
+void *bpf_arch_text_copy(void *dst, void *src, size_t len)
+{
+	void *ret;
+
+	if (WARN_ON_ONCE(core_kernel_text((unsigned long)dst)))
+		return ERR_PTR(-EINVAL);
+
+	mutex_lock(&text_mutex);
+	ret = bpf_patch_instructions(dst, src, len);
+	mutex_unlock(&text_mutex);
+
+	return ret;
+}
-- 
2.41.0


