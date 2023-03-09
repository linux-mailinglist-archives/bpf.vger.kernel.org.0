Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CF96B2C7D
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 19:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjCISBE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 13:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjCISBD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 13:01:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788A8FCBC3
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 10:01:02 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329Hk8HW012120;
        Thu, 9 Mar 2023 18:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=oYstEwbrjMOiKlnjhPsH7HLzwBXOrjhMno/W1pcdHhc=;
 b=ChIKg9fDaVsZ2V52dkutFM8XC7KQyJxPQFk46L0qafysiDkj49IV/7z9dsevnV8IUJNv
 eTS50Q99/byp2eE+RUu07fGfYtszgu8nUHVVmZmjQCm8co0fDjhOvi/CZNRfIVDXIeYi
 2cEFHSv6xcIdQTG5LOKLygE9DG1Cua2PNv6Uot1xPWGqeSYtnufU5/beIXL3ig60Tb+k
 9fmCglnMkW+tr2FbDo7GVV9JT97i4HKt9SdjJp3CHb5uWqEBsjCQLnZNXJlz6kfbsELB
 oTiY42Fd6Z2NQHSLkqn8P6td2mfXSCtkCLgcOi0dgRNCJ/yQy5Y3Nnfha6/93x+TUpN7 Nw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6ry4m2h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 18:00:39 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 329DAG2A002754;
        Thu, 9 Mar 2023 18:00:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3p6g0pj18c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 18:00:36 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 329I0XmA55968178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Mar 2023 18:00:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBD6320063;
        Thu,  9 Mar 2023 18:00:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA40920043;
        Thu,  9 Mar 2023 18:00:31 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.13.46])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  9 Mar 2023 18:00:31 +0000 (GMT)
From:   Hari Bathini <hbathini@linux.ibm.com>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v2 1/4] powerpc/code-patching: introduce patch_instructions()
Date:   Thu,  9 Mar 2023 23:30:25 +0530
Message-Id: <20230309180028.180200-2-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309180028.180200-1-hbathini@linux.ibm.com>
References: <20230309180028.180200-1-hbathini@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DxeAld_WjHvpvtcrqomeoxoI8o1mKXFh
X-Proofpoint-ORIG-GUID: DxeAld_WjHvpvtcrqomeoxoI8o1mKXFh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_09,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 spamscore=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090141
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

patch_instruction() entails setting up pte, patching the instruction,
clearing the pte and flushing the tlb. If multiple instructions need
to be patched, every instruction would have to go through the above
drill unnecessarily. Instead, introduce function patch_instructions()
that patches multiple instructions at one go while setting up the pte,
clearing the pte and flushing the tlb only once per page range of
instructions. Observed ~5X improvement in speed of execution using
patch_instructions() over patch_instructions(), when more instructions
are to be patched.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/include/asm/code-patching.h |   1 +
 arch/powerpc/lib/code-patching.c         | 151 ++++++++++++++++-------
 2 files changed, 106 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index 3f881548fb61..059fc4fe700e 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -74,6 +74,7 @@ int create_cond_branch(ppc_inst_t *instr, const u32 *addr,
 int patch_branch(u32 *addr, unsigned long target, int flags);
 int patch_instruction(u32 *addr, ppc_inst_t instr);
 int raw_patch_instruction(u32 *addr, ppc_inst_t instr);
+int patch_instructions(u32 *addr, u32 *code, bool fill_inst, size_t len);
 
 static inline unsigned long patch_site_addr(s32 *site)
 {
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index b00112d7ad46..33857b9b53de 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -278,77 +278,117 @@ static void unmap_patch_area(unsigned long addr)
 	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
 }
 
-static int __do_patch_instruction_mm(u32 *addr, ppc_inst_t instr)
+static int __do_patch_instructions_mm(u32 *addr, u32 *code, bool fill_inst, size_t len)
 {
-	int err;
-	u32 *patch_addr;
-	unsigned long text_poke_addr;
-	pte_t *pte;
-	unsigned long pfn = get_patch_pfn(addr);
-	struct mm_struct *patching_mm;
-	struct mm_struct *orig_mm;
+	struct mm_struct *patching_mm, *orig_mm;
+	unsigned long text_poke_addr, pfn;
+	u32 *patch_addr, *end, *pend;
+	ppc_inst_t instr;
 	spinlock_t *ptl;
+	int ilen, err;
+	pte_t *pte;
 
 	patching_mm = __this_cpu_read(cpu_patching_context.mm);
 	text_poke_addr = __this_cpu_read(cpu_patching_context.addr);
-	patch_addr = (u32 *)(text_poke_addr + offset_in_page(addr));
 
 	pte = get_locked_pte(patching_mm, text_poke_addr, &ptl);
 	if (!pte)
 		return -ENOMEM;
 
-	__set_pte_at(patching_mm, text_poke_addr, pte, pfn_pte(pfn, PAGE_KERNEL), 0);
+	end = (void *)addr + len;
+	do {
+		pfn = get_patch_pfn(addr);
+		__set_pte_at(patching_mm, text_poke_addr, pte, pfn_pte(pfn, PAGE_KERNEL), 0);
 
-	/* order PTE update before use, also serves as the hwsync */
-	asm volatile("ptesync": : :"memory");
-
-	/* order context switch after arbitrary prior code */
-	isync();
-
-	orig_mm = start_using_temp_mm(patching_mm);
-
-	err = __patch_instruction(addr, instr, patch_addr);
+		/* order PTE update before use, also serves as the hwsync */
+		asm volatile("ptesync": : :"memory");
 
-	/* hwsync performed by __patch_instruction (sync) if successful */
-	if (err)
-		mb();  /* sync */
+		/* order context switch after arbitrary prior code */
+		isync();
+
+		orig_mm = start_using_temp_mm(patching_mm);
+
+		patch_addr = (u32 *)(text_poke_addr + offset_in_page(addr));
+		pend = (void *)addr + PAGE_SIZE - offset_in_page(addr);
+		if (end < pend)
+			pend = end;
+
+		while (addr < pend) {
+			instr = ppc_inst_read(code);
+			ilen = ppc_inst_len(instr);
+			err = __patch_instruction(addr, instr, patch_addr);
+			/* hwsync performed by __patch_instruction (sync) if successful */
+			if (err) {
+				mb();  /* sync */
+				break;
+			}
+
+			patch_addr = (void *)patch_addr + ilen;
+			addr = (void *)addr + ilen;
+			if (!fill_inst)
+				code = (void *)code + ilen;
+		}
 
-	/* context synchronisation performed by __patch_instruction (isync or exception) */
-	stop_using_temp_mm(patching_mm, orig_mm);
+		/* context synchronisation performed by __patch_instruction (isync or exception) */
+		stop_using_temp_mm(patching_mm, orig_mm);
 
-	pte_clear(patching_mm, text_poke_addr, pte);
-	/*
-	 * ptesync to order PTE update before TLB invalidation done
-	 * by radix__local_flush_tlb_page_psize (in _tlbiel_va)
-	 */
-	local_flush_tlb_page_psize(patching_mm, text_poke_addr, mmu_virtual_psize);
+		pte_clear(patching_mm, text_poke_addr, pte);
+		/*
+		 * ptesync to order PTE update before TLB invalidation done
+		 * by radix__local_flush_tlb_page_psize (in _tlbiel_va)
+		 */
+		local_flush_tlb_page_psize(patching_mm, text_poke_addr, mmu_virtual_psize);
+		if (err)
+			break;
+	} while (addr < end);
 
 	pte_unmap_unlock(pte, ptl);
 
 	return err;
 }
 
-static int __do_patch_instruction(u32 *addr, ppc_inst_t instr)
+static int __do_patch_instructions(u32 *addr, u32 *code, bool fill_inst, size_t len)
 {
-	int err;
-	u32 *patch_addr;
-	unsigned long text_poke_addr;
+	unsigned long text_poke_addr, pfn;
+	u32 *patch_addr, *end, *pend;
+	ppc_inst_t instr;
+	int ilen, err;
 	pte_t *pte;
-	unsigned long pfn = get_patch_pfn(addr);
 
 	text_poke_addr = (unsigned long)__this_cpu_read(cpu_patching_context.addr) & PAGE_MASK;
-	patch_addr = (u32 *)(text_poke_addr + offset_in_page(addr));
-
 	pte = __this_cpu_read(cpu_patching_context.pte);
-	__set_pte_at(&init_mm, text_poke_addr, pte, pfn_pte(pfn, PAGE_KERNEL), 0);
-	/* See ptesync comment in radix__set_pte_at() */
-	if (radix_enabled())
-		asm volatile("ptesync": : :"memory");
 
-	err = __patch_instruction(addr, instr, patch_addr);
+	end = (void *)addr + len;
+	do {
+		pfn = get_patch_pfn(addr);
+		__set_pte_at(&init_mm, text_poke_addr, pte, pfn_pte(pfn, PAGE_KERNEL), 0);
+		/* See ptesync comment in radix__set_pte_at() */
+		if (radix_enabled())
+			asm volatile("ptesync": : :"memory");
+
+		patch_addr = (u32 *)(text_poke_addr + offset_in_page(addr));
+		pend = (void *)addr + PAGE_SIZE - offset_in_page(addr);
+		if (end < pend)
+			pend = end;
+
+		while (addr < pend) {
+			instr = ppc_inst_read(code);
+			ilen = ppc_inst_len(instr);
+			err = __patch_instruction(addr, instr, patch_addr);
+			if (err)
+				break;
+
+			patch_addr = (void *)patch_addr + ilen;
+			addr = (void *)addr + ilen;
+			if (!fill_inst)
+				code = (void *)code + ilen;
+		}
 
-	pte_clear(&init_mm, text_poke_addr, pte);
-	flush_tlb_kernel_range(text_poke_addr, text_poke_addr + PAGE_SIZE);
+		pte_clear(&init_mm, text_poke_addr, pte);
+		flush_tlb_kernel_range(text_poke_addr, text_poke_addr + PAGE_SIZE);
+		if (err)
+			break;
+	} while (addr < end);
 
 	return err;
 }
@@ -369,15 +409,34 @@ int patch_instruction(u32 *addr, ppc_inst_t instr)
 
 	local_irq_save(flags);
 	if (mm_patch_enabled())
-		err = __do_patch_instruction_mm(addr, instr);
+		err = __do_patch_instructions_mm(addr, (u32 *)&instr, false, ppc_inst_len(instr));
 	else
-		err = __do_patch_instruction(addr, instr);
+		err = __do_patch_instructions(addr, (u32 *)&instr, false, ppc_inst_len(instr));
 	local_irq_restore(flags);
 
 	return err;
 }
 NOKPROBE_SYMBOL(patch_instruction);
 
+/*
+ * Patch 'addr' with 'len' bytes of instructions from 'code'.
+ */
+int patch_instructions(u32 *addr, u32 *code, bool fill_inst, size_t len)
+{
+	unsigned long flags;
+	int err;
+
+	local_irq_save(flags);
+	if (mm_patch_enabled())
+		err = __do_patch_instructions_mm(addr, code, fill_inst, len);
+	else
+		err = __do_patch_instructions(addr, code, fill_inst, len);
+	local_irq_restore(flags);
+
+	return err;
+}
+NOKPROBE_SYMBOL(patch_instructions);
+
 int patch_branch(u32 *addr, unsigned long target, int flags)
 {
 	ppc_inst_t instr;
-- 
2.39.2

