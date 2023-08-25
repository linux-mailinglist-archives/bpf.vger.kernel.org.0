Return-Path: <bpf+bounces-8629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF5B788C56
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 17:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16491C21019
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 15:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4EC107B3;
	Fri, 25 Aug 2023 15:18:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557B81078D
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 15:18:52 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472332121
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 08:18:51 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PF26Qq029249;
	Fri, 25 Aug 2023 15:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hepVXRKFiRIv4IdaE1nHxJMdgayn+XmVr4DAvmp/X/A=;
 b=iHZFvnBrgcv2yBa9a049mozeOEMp5nwifNfjvKJGjszW+8ibowUl2DbiI98hJDtgr3xW
 9TXXE8j6saDhtZuewv1OczrcvISDzDV0PghCAMULExhbyhU10F8pfe9VP+prpAAeymqh
 2Apfhh7LgeCaCGXA49P3LLgzfQM0/JhTvpu4/c3SwVKk4phi8sLHN3hrIJJCQ3Iszwnl
 rIC3j/PmmazcaT1ZRP+GwPeywi/jacf3KLkqypoRMcEjXAv+rUpRIU6u7VW/tOvJr5sV
 F6ejF/ceVcr39/dMucdaJZOVFvwG3llWA70CiKQZgbbU5pgy2azv7VwH9kNe6QMn2vCv fg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3spxk48g0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Aug 2023 15:18:29 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37PDK5tR004050;
	Fri, 25 Aug 2023 15:18:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sn21s0g22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Aug 2023 15:18:28 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37PFIRFO46072528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Aug 2023 15:18:27 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0D1520043;
	Fri, 25 Aug 2023 15:18:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E526320040;
	Fri, 25 Aug 2023 15:18:24 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.75.97])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Aug 2023 15:18:24 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Song Liu <songliubraving@fb.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 5/5] powerpc/bpf: use patch_instructions()
Date: Fri, 25 Aug 2023 20:48:10 +0530
Message-ID: <20230825151810.164418-6-hbathini@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: zW0Gs0G3hAgvPHrma_6ZckW5s_A8oHh-
X-Proofpoint-GUID: zW0Gs0G3hAgvPHrma_6ZckW5s_A8oHh-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_13,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxscore=0 adultscore=0 spamscore=0 impostorscore=0 mlxlogscore=879
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250134
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use the newly introduced patch_instructions() that handles patching
multiple instructions with one call. This improves speed of exectution
for JIT'ing bpf programs.

Without this patch (on a POWER9 lpar):

  # time modprobe test_bpf
  real    2m59.681s
  user    0m0.000s
  sys     1m44.160s
  #

With this patch (on a POWER9 lpar):

  # time modprobe test_bpf
  real    0m5.013s
  user    0m0.000s
  sys     0m4.216s
  #

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index c60d7570e05d..1e5000d18321 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -26,28 +26,6 @@ static void bpf_jit_fill_ill_insns(void *area, unsigned int size)
 	memset32(area, BREAKPOINT_INSTRUCTION, size / 4);
 }
 
-/*
- * Patch 'len' bytes of instructions from opcode to addr, one instruction
- * at a time. Returns addr on success. ERR_PTR(-EINVAL), otherwise.
- */
-static void *bpf_patch_instructions(void *addr, void *opcode, size_t len, bool fill_insn)
-{
-	while (len > 0) {
-		ppc_inst_t insn = ppc_inst_read(opcode);
-		int ilen = ppc_inst_len(insn);
-
-		if (patch_instruction(addr, insn))
-			return ERR_PTR(-EINVAL);
-
-		len -= ilen;
-		addr = addr + ilen;
-		if (!fill_insn)
-			opcode = opcode + ilen;
-	}
-
-	return addr;
-}
-
 int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr)
 {
 	if (!exit_addr || is_offset_in_branch_range(exit_addr - (ctx->idx * 4))) {
@@ -330,16 +308,16 @@ int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, u32 *fimage, int pass
 
 void *bpf_arch_text_copy(void *dst, void *src, size_t len)
 {
-	void *ret;
+	int err;
 
 	if (WARN_ON_ONCE(core_kernel_text((unsigned long)dst)))
 		return ERR_PTR(-EINVAL);
 
 	mutex_lock(&text_mutex);
-	ret = bpf_patch_instructions(dst, src, len, false);
+	err = patch_instructions(dst, src, len, false);
 	mutex_unlock(&text_mutex);
 
-	return ret;
+	return err ? ERR_PTR(err) : dst;
 }
 
 int bpf_arch_text_invalidate(void *dst, size_t len)
@@ -351,7 +329,7 @@ int bpf_arch_text_invalidate(void *dst, size_t len)
 		return -EINVAL;
 
 	mutex_lock(&text_mutex);
-	ret = IS_ERR(bpf_patch_instructions(dst, &insn, len, true));
+	ret = patch_instructions(dst, &insn, len, true);
 	mutex_unlock(&text_mutex);
 
 	return ret;
-- 
2.41.0


