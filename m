Return-Path: <bpf+bounces-9491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BF17987D5
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 15:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B91271C20BFB
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 13:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293B063BE;
	Fri,  8 Sep 2023 13:28:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A4963AB
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 13:28:25 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C29C1FC6
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 06:28:19 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388DMGwx004926;
	Fri, 8 Sep 2023 13:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UZEd8+YCglfM3/F3LtFpJaUhBqLI+b8upZY92+tzIpg=;
 b=tW9sDS8FwsjORjdx21wRqQfbG/cU6m6inz+ctBricmzchuTxnwLpxB1wQVdSyMVHv9lQ
 2NBruN6J4iQd3UAf7A2pnODrlVNaBqatcZ9Biv+FNS/9xXsBts7sem2yaJgl8ceI6Zk3
 DPFXfDMfbb9WBic93NzHgn4/CQxYnfWhMJX7um7TYLi1UsYVi4sptBbyy+ZfgvcatRn4
 v6ovcsZhJMHCgetQFr/vnKMg+kDjakvNtL3vKS9hwQj8+iOZS2P+LXNABV9Aob/I6esk
 WxU8acCeru/KLy4nbtTS3doUKiupgh2KaNatTa2Z5eFFPHIrqWBeFqwZZ4HAKO4gWLkp KA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t04ehg3ry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Sep 2023 13:27:58 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 388DKq3j021422;
	Fri, 8 Sep 2023 13:27:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svfs042xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Sep 2023 13:27:57 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 388DRsis42795642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Sep 2023 13:27:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C41EF20049;
	Fri,  8 Sep 2023 13:27:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8305420040;
	Fri,  8 Sep 2023 13:27:52 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.29.230])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Sep 2023 13:27:52 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Song Liu <songliubraving@fb.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 4/5] powerpc/code-patching: introduce patch_instructions()
Date: Fri,  8 Sep 2023 18:57:39 +0530
Message-ID: <20230908132740.718103-5-hbathini@linux.ibm.com>
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
X-Proofpoint-GUID: BQprlj5R5aQ83-MoxQASemevksduR0Tu
X-Proofpoint-ORIG-GUID: BQprlj5R5aQ83-MoxQASemevksduR0Tu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_09,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 mlxlogscore=687
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

patch_instruction() entails setting up pte, patching the instruction,
clearing the pte and flushing the tlb. If multiple instructions need
to be patched, every instruction would have to go through the above
drill unnecessarily. Instead, introduce function patch_instructions()
that sets up the pte, clears the pte and flushes the tlb only once per
page range of instructions to be patched. This adds a slight overhead
to patch_instruction() call while improving the patching time for
scenarios where more than one instruction needs to be patched.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/include/asm/code-patching.h |  1 +
 arch/powerpc/lib/code-patching.c         | 94 ++++++++++++++++++++----
 2 files changed, 80 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index 3f881548fb61..4f5f0c091586 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -74,6 +74,7 @@ int create_cond_branch(ppc_inst_t *instr, const u32 *addr,
 int patch_branch(u32 *addr, unsigned long target, int flags);
 int patch_instruction(u32 *addr, ppc_inst_t instr);
 int raw_patch_instruction(u32 *addr, ppc_inst_t instr);
+int patch_instructions(void *addr, void *code, size_t len, bool fill_insn);
 
 static inline unsigned long patch_site_addr(s32 *site)
 {
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index b00112d7ad46..60d446e16b42 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -278,20 +278,25 @@ static void unmap_patch_area(unsigned long addr)
 	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
 }
 
-static int __do_patch_instruction_mm(u32 *addr, ppc_inst_t instr)
+/*
+ * A page is mapped and instructions that fit the page are patched.
+ * Assumes 'len' to be (PAGE_SIZE - offset_in_page(addr)) or below.
+ */
+static int __do_patch_instructions_mm(u32 *addr, void *code, size_t len, bool fill_insn)
 {
-	int err;
-	u32 *patch_addr;
 	unsigned long text_poke_addr;
 	pte_t *pte;
 	unsigned long pfn = get_patch_pfn(addr);
 	struct mm_struct *patching_mm;
 	struct mm_struct *orig_mm;
+	ppc_inst_t instr;
+	void *patch_addr;
 	spinlock_t *ptl;
+	int ilen, err;
 
 	patching_mm = __this_cpu_read(cpu_patching_context.mm);
 	text_poke_addr = __this_cpu_read(cpu_patching_context.addr);
-	patch_addr = (u32 *)(text_poke_addr + offset_in_page(addr));
+	patch_addr = (void *)(text_poke_addr + offset_in_page(addr));
 
 	pte = get_locked_pte(patching_mm, text_poke_addr, &ptl);
 	if (!pte)
@@ -307,11 +312,22 @@ static int __do_patch_instruction_mm(u32 *addr, ppc_inst_t instr)
 
 	orig_mm = start_using_temp_mm(patching_mm);
 
-	err = __patch_instruction(addr, instr, patch_addr);
+	while (len > 0) {
+		instr = ppc_inst_read(code);
+		ilen = ppc_inst_len(instr);
+		err = __patch_instruction(addr, instr, patch_addr);
+		/* hwsync performed by __patch_instruction (sync) if successful */
+		if (err) {
+			mb();  /* sync */
+			break;
+		}
 
-	/* hwsync performed by __patch_instruction (sync) if successful */
-	if (err)
-		mb();  /* sync */
+		len -= ilen;
+		patch_addr = patch_addr + ilen;
+		addr = (void *)addr + ilen;
+		if (!fill_insn)
+			code = code + ilen;
+	}
 
 	/* context synchronisation performed by __patch_instruction (isync or exception) */
 	stop_using_temp_mm(patching_mm, orig_mm);
@@ -328,16 +344,21 @@ static int __do_patch_instruction_mm(u32 *addr, ppc_inst_t instr)
 	return err;
 }
 
-static int __do_patch_instruction(u32 *addr, ppc_inst_t instr)
+/*
+ * A page is mapped and instructions that fit the page are patched.
+ * Assumes 'len' to be (PAGE_SIZE - offset_in_page(addr)) or below.
+ */
+static int __do_patch_instructions(u32 *addr, void *code, size_t len, bool fill_insn)
 {
-	int err;
-	u32 *patch_addr;
 	unsigned long text_poke_addr;
 	pte_t *pte;
 	unsigned long pfn = get_patch_pfn(addr);
+	void *patch_addr;
+	ppc_inst_t instr;
+	int ilen, err;
 
 	text_poke_addr = (unsigned long)__this_cpu_read(cpu_patching_context.addr) & PAGE_MASK;
-	patch_addr = (u32 *)(text_poke_addr + offset_in_page(addr));
+	patch_addr = (void *)(text_poke_addr + offset_in_page(addr));
 
 	pte = __this_cpu_read(cpu_patching_context.pte);
 	__set_pte_at(&init_mm, text_poke_addr, pte, pfn_pte(pfn, PAGE_KERNEL), 0);
@@ -345,7 +366,19 @@ static int __do_patch_instruction(u32 *addr, ppc_inst_t instr)
 	if (radix_enabled())
 		asm volatile("ptesync": : :"memory");
 
-	err = __patch_instruction(addr, instr, patch_addr);
+	while (len > 0) {
+		instr = ppc_inst_read(code);
+		ilen = ppc_inst_len(instr);
+		err = __patch_instruction(addr, instr, patch_addr);
+		if (err)
+			break;
+
+		len -= ilen;
+		patch_addr = patch_addr + ilen;
+		addr = (void *)addr + ilen;
+		if (!fill_insn)
+			code = code + ilen;
+	}
 
 	pte_clear(&init_mm, text_poke_addr, pte);
 	flush_tlb_kernel_range(text_poke_addr, text_poke_addr + PAGE_SIZE);
@@ -369,15 +402,46 @@ int patch_instruction(u32 *addr, ppc_inst_t instr)
 
 	local_irq_save(flags);
 	if (mm_patch_enabled())
-		err = __do_patch_instruction_mm(addr, instr);
+		err = __do_patch_instructions_mm(addr, &instr, ppc_inst_len(instr), false);
 	else
-		err = __do_patch_instruction(addr, instr);
+		err = __do_patch_instructions(addr, &instr, ppc_inst_len(instr), false);
 	local_irq_restore(flags);
 
 	return err;
 }
 NOKPROBE_SYMBOL(patch_instruction);
 
+/*
+ * Patch 'addr' with 'len' bytes of instructions from 'code'.
+ */
+int patch_instructions(void *addr, void *code, size_t len, bool fill_insn)
+{
+	unsigned long flags;
+	size_t plen;
+	int err;
+
+	while (len > 0) {
+		plen = min_t(size_t, PAGE_SIZE - offset_in_page(addr), len);
+
+		local_irq_save(flags);
+		if (mm_patch_enabled())
+			err = __do_patch_instructions_mm(addr, code, plen, fill_insn);
+		else
+			err = __do_patch_instructions(addr, code, plen, fill_insn);
+		local_irq_restore(flags);
+		if (err)
+			break;
+
+		len -= plen;
+		addr = addr + plen;
+		if (!fill_insn)
+			code = code + plen;
+	}
+
+	return err;
+}
+NOKPROBE_SYMBOL(patch_instructions);
+
 int patch_branch(u32 *addr, unsigned long target, int flags)
 {
 	ppc_inst_t instr;
-- 
2.41.0


