Return-Path: <bpf+bounces-9488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 913EA7987D0
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 15:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE3D281AAF
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 13:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27AD5694;
	Fri,  8 Sep 2023 13:28:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBC353B9
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 13:28:17 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1C31BF6
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 06:28:13 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388D1iwH018194;
	Fri, 8 Sep 2023 13:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fI44C9skaMuMgh+MdxQZgtp0H/3OugomwMmIxnbdI2M=;
 b=p3fheJjcHlBUMjKiWud+ZjL7LkV7U8sk5jR2oyx0NztzJLQJ5O9psAf9CjLOtfYvtWeP
 UYPYuvBzpVseG8H7VldU7qeEPsHgAIZU1mLsH6Fgd2vTv+1NO4pXMgNC5zSr3O+MQewD
 C6c8gijeiMzvxEMfoVG92gZZyFXK7yCJqe5zq8GUPALu9yVsPPxXMLSC2KZbXVogNNdB
 0/OczsKaI+a0dLgVToUavCsFIWKjHpTpWKf3+wHDEdD0yIyHSyRgcJLwZqeiaTB8qBY4
 keSco6Zjmoz+yg6SMISIYqCv5Lbda1Bxg7iEuJWgoXSO+ZsPlz41qIe2jgWWteZyMosa rA== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t044vsa2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Sep 2023 13:27:49 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 388BXN1p012261;
	Fri, 8 Sep 2023 13:27:48 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svhkkkhcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Sep 2023 13:27:48 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 388DRlWI42270986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Sep 2023 13:27:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E55E12004B;
	Fri,  8 Sep 2023 13:27:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B883920040;
	Fri,  8 Sep 2023 13:27:44 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.29.230])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Sep 2023 13:27:44 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Song Liu <songliubraving@fb.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 1/5] powerpc/bpf: implement bpf_arch_text_copy
Date: Fri,  8 Sep 2023 18:57:36 +0530
Message-ID: <20230908132740.718103-2-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908132740.718103-1-hbathini@linux.ibm.com>
References: <20230908132740.718103-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FfyXDLd91BvrXBzk7U5-v2IZiPLZ7YrK
X-Proofpoint-ORIG-GUID: FfyXDLd91BvrXBzk7U5-v2IZiPLZ7YrK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_09,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

bpf_arch_text_copy is used to dump JITed binary to RX page, allowing
multiple BPF programs to share the same page. Use patch_instruction()
to implement it.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c | 41 ++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 37043dfc1add..4f896222c579 100644
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
@@ -23,6 +26,28 @@ static void bpf_jit_fill_ill_insns(void *area, unsigned int size)
 	memset32(area, BREAKPOINT_INSTRUCTION, size / 4);
 }
 
+/*
+ * Patch 'len' bytes of instructions from opcode to addr, one instruction
+ * at a time. Returns addr on success. ERR_PTR(-EINVAL), otherwise.
+ */
+static void *bpf_patch_instructions(void *addr, void *opcode, size_t len, bool fill_insn)
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
+		if (!fill_insn)
+			opcode = opcode + ilen;
+	}
+
+	return addr;
+}
+
 int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr)
 {
 	if (!exit_addr || is_offset_in_branch_range(exit_addr - (ctx->idx * 4))) {
@@ -274,3 +299,17 @@ int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, int pass, struct code
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
+	ret = bpf_patch_instructions(dst, src, len, false);
+	mutex_unlock(&text_mutex);
+
+	return ret;
+}
-- 
2.41.0


