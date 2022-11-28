Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1417363B1CD
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 20:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbiK1TDR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 28 Nov 2022 14:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbiK1TDO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 14:03:14 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6EC286DD
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 11:03:14 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ASI0kC3000383
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 11:03:13 -0800
Received: from maileast.thefacebook.com ([163.114.130.8])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m4xqaahtn-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 11:03:13 -0800
Received: from twshared15216.17.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 11:03:11 -0800
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 5F2BE10980404; Mon, 28 Nov 2022 11:03:05 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <x86@kernel.org>,
        <peterz@infradead.org>, <hch@lst.de>, <rick.p.edgecombe@intel.com>,
        <rppt@kernel.org>, <mcgrof@kernel.org>, Song Liu <song@kernel.org>
Subject: [PATCH bpf-next v5 6/6] x86: use register_text_tail_vm
Date:   Mon, 28 Nov 2022 11:02:45 -0800
Message-ID: <20221128190245.2337461-7-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221128190245.2337461-1-song@kernel.org>
References: <20221128190245.2337461-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: CxB5JrxzCM_IJU50WoJsWsc6NiQxadTQ
X-Proofpoint-GUID: CxB5JrxzCM_IJU50WoJsWsc6NiQxadTQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_17,2022-11-28_02,2022-06-22_01
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

Also update Documentation/x86/x86_64/mm.rst to show execmem can be mapped
to kernel text addresses.

Signed-off-by: Song Liu <song@kernel.org>
---
 Documentation/x86/x86_64/mm.rst         | 4 ++--
 arch/x86/include/asm/pgtable_64_types.h | 1 +
 arch/x86/mm/init_64.c                   | 4 +++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/x86/x86_64/mm.rst b/Documentation/x86/x86_64/mm.rst
index 9798676bb0bf..6ee95e5fa7e9 100644
--- a/Documentation/x86/x86_64/mm.rst
+++ b/Documentation/x86/x86_64/mm.rst
@@ -62,7 +62,7 @@ Complete virtual memory map with 4-level page tables
    ffffff8000000000 | -512    GB | ffffffeeffffffff |  444 GB | ... unused hole
    ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region mapping space
    ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | ... unused hole
-   ffffffff80000000 |   -2    GB | ffffffff9fffffff |  512 MB | kernel text mapping, mapped to physical address 0
+   ffffffff80000000 |   -2    GB | ffffffff9fffffff |  512 MB | kernel text mapping and execmem, mapped to physical address 0
    ffffffff80000000 |-2048    MB |                  |         |
    ffffffffa0000000 |-1536    MB | fffffffffeffffff | 1520 MB | module mapping space
    ffffffffff000000 |  -16    MB |                  |         |
@@ -121,7 +121,7 @@ Complete virtual memory map with 5-level page tables
    ffffff8000000000 | -512    GB | ffffffeeffffffff |  444 GB | ... unused hole
    ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region mapping space
    ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | ... unused hole
-   ffffffff80000000 |   -2    GB | ffffffff9fffffff |  512 MB | kernel text mapping, mapped to physical address 0
+   ffffffff80000000 |   -2    GB | ffffffff9fffffff |  512 MB | kernel text mapping and execmem, mapped to physical address 0
    ffffffff80000000 |-2048    MB |                  |         |
    ffffffffa0000000 |-1536    MB | fffffffffeffffff | 1520 MB | module mapping space
    ffffffffff000000 |  -16    MB |                  |         |
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
-- 
2.30.2

