Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3250D6140A3
	for <lists+bpf@lfdr.de>; Mon, 31 Oct 2022 23:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiJaW0L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 31 Oct 2022 18:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJaW0J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Oct 2022 18:26:09 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1196514082
        for <bpf@vger.kernel.org>; Mon, 31 Oct 2022 15:26:09 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VMPIaJ004159
        for <bpf@vger.kernel.org>; Mon, 31 Oct 2022 15:26:08 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kjn3hs0xn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 31 Oct 2022 15:26:08 -0700
Received: from twshared16963.27.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 15:26:06 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id EE8A8F0CC5CC; Mon, 31 Oct 2022 15:25:56 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <x86@kernel.org>,
        <peterz@infradead.org>, <hch@lst.de>, <rick.p.edgecombe@intel.com>,
        <dave.hansen@intel.com>, <mcgrof@kernel.org>,
        Song Liu <song@kernel.org>
Subject: [PATCH bpf-next v1 RESEND 5/5] x86: use register_text_tail_vm
Date:   Mon, 31 Oct 2022 15:25:41 -0700
Message-ID: <20221031222541.1773452-6-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221031222541.1773452-1-song@kernel.org>
References: <20221031222541.1773452-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: OwlWyYD24gRKnoNDlROqcK3kzVLOzMO0
X-Proofpoint-ORIG-GUID: OwlWyYD24gRKnoNDlROqcK3kzVLOzMO0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_21,2022-10-31_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allocate 2MB pages up to round_up(_etext, 2MB), and register memory
[round_up(_etext, 4kb), round_up(_etext, 2MB)] with register_text_tail_vm
so that we can use this part of memory for dynamic kernel text (BPF
programs, etc.).

Here is an example:

[root@eth50-1 ~]# grep _etext /proc/kallsyms
ffffffff82202a08 T _etext

[root@eth50-1 ~]# grep bpf_prog_ /proc/kallsyms  | tail -n 3
ffffffff8220f920 t bpf_prog_cc61a5364ac11d93_handle__sched_wakeup       [bpf]
ffffffff8220fa28 t bpf_prog_cc61a5364ac11d93_handle__sched_wakeup_new   [bpf]
ffffffff8220fad4 t bpf_prog_3bf73fa16f5e3d92_handle__sched_switch       [bpf]

[root@eth50-1 ~]#  grep 0xffffffff82200000 /sys/kernel/debug/page_tables/kernel
0xffffffff82200000-0xffffffff82400000     2M     ro   PSE         x  pmd

ffffffff82200000-ffffffff82400000 is a 2MB page, serving kernel text, and
bpf programs.

Signed-off-by: Song Liu <song@kernel.org>
---
 arch/x86/include/asm/pgtable_64_types.h | 1 +
 arch/x86/mm/init_64.c                   | 4 +++-
 include/linux/vmalloc.h                 | 4 ++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 04f36063ad54..c0f9cceb109a 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -101,6 +101,7 @@ extern unsigned int ptrs_per_p4d;
 #define PUD_MASK	(~(PUD_SIZE - 1))
 #define PGDIR_SIZE	(_AC(1, UL) << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE - 1))
+#define PMD_ALIGN(x)	(((unsigned long)(x) + (PMD_SIZE - 1)) & PMD_MASK)
 
 /*
  * See Documentation/x86/x86_64/mm.rst for a description of the memory map.
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 3f040c6e5d13..5b42fc0c6099 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1373,7 +1373,7 @@ void mark_rodata_ro(void)
 	unsigned long start = PFN_ALIGN(_text);
 	unsigned long rodata_start = PFN_ALIGN(__start_rodata);
 	unsigned long end = (unsigned long)__end_rodata_hpage_align;
-	unsigned long text_end = PFN_ALIGN(_etext);
+	unsigned long text_end = PMD_ALIGN(_etext);
 	unsigned long rodata_end = PFN_ALIGN(__end_rodata);
 	unsigned long all_end;
 
@@ -1414,6 +1414,8 @@ void mark_rodata_ro(void)
 				(void *)rodata_end, (void *)_sdata);
 
 	debug_checkwx();
+	register_text_tail_vm(PFN_ALIGN((unsigned long)_etext),
+			      PMD_ALIGN((unsigned long)_etext));
 }
 
 int kern_addr_valid(unsigned long addr)
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 9b2042313c12..7365cf9c4e7f 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -132,11 +132,15 @@ extern void vm_unmap_aliases(void);
 #ifdef CONFIG_MMU
 extern void __init vmalloc_init(void);
 extern unsigned long vmalloc_nr_pages(void);
+void register_text_tail_vm(unsigned long start, unsigned long end);
 #else
 static inline void vmalloc_init(void)
 {
 }
 static inline unsigned long vmalloc_nr_pages(void) { return 0; }
+void register_text_tail_vm(unsigned long start, unsigned long end)
+{
+}
 #endif
 
 extern void *vmalloc(unsigned long size) __alloc_size(1);
-- 
2.30.2

