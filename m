Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE91A221877
	for <lists+bpf@lfdr.de>; Thu, 16 Jul 2020 01:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgGOXfd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jul 2020 19:35:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8124 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726770AbgGOXfd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Jul 2020 19:35:33 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06FNWS1x078659;
        Wed, 15 Jul 2020 19:35:21 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32a45awau3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 19:35:21 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06FNJnOs014446;
        Wed, 15 Jul 2020 23:35:18 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 327527w34g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 23:35:18 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06FNXwU953805244
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 23:33:59 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD45BA4060;
        Wed, 15 Jul 2020 23:33:58 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 423A4A4066;
        Wed, 15 Jul 2020 23:33:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.186.215])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 Jul 2020 23:33:58 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH v2 2/4] s390/kernel: expand the exception table logic to allow new handling options
Date:   Thu, 16 Jul 2020 01:32:59 +0200
Message-Id: <20200715233301.933201-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200715233301.933201-1-iii@linux.ibm.com>
References: <20200715233301.933201-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_12:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150171
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a s390 port of commit 548acf19234d ("x86/mm: Expand the
exception table logic to allow new handling options"), which is needed
for implementing BPF_PROBE_MEM on s390.

The new handler field is made 64-bit in order to allow pointing from
dynamically allocated entries to handlers in kernel text. Unlike on x86,
NULL is used instead of ex_handler_default. This is because exception
tables are used by boot/text_dma.S, and it would be a pain to preserve
ex_handler_default.

The new infrastructure is ignored in early_pgm_check_handler, since
there is no pt_regs.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/include/asm/extable.h | 50 +++++++++++++++++++++++++++++----
 arch/s390/include/asm/linkage.h |  3 +-
 arch/s390/kernel/kprobes.c      |  4 +--
 arch/s390/kernel/traps.c        |  7 ++---
 arch/s390/mm/fault.c            |  4 +--
 scripts/sorttable.c             | 25 +++++++++++++++++
 6 files changed, 76 insertions(+), 17 deletions(-)

diff --git a/arch/s390/include/asm/extable.h b/arch/s390/include/asm/extable.h
index ae27f756b409..8f0c60f2fe3a 100644
--- a/arch/s390/include/asm/extable.h
+++ b/arch/s390/include/asm/extable.h
@@ -1,12 +1,20 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __S390_EXTABLE_H
 #define __S390_EXTABLE_H
+
+#include <asm/ptrace.h>
+#include <linux/compiler.h>
+
 /*
- * The exception table consists of pairs of addresses: the first is the
- * address of an instruction that is allowed to fault, and the second is
- * the address at which the program should continue.  No registers are
- * modified, so it is entirely up to the continuation code to figure out
- * what to do.
+ * The exception table consists of three addresses:
+ *
+ * - Address of an instruction that is allowed to fault.
+ * - Address at which the program should continue.
+ * - Optional address of handler that takes pt_regs * argument and runs in
+ *   interrupt context.
+ *
+ * No registers are modified, so it is entirely up to the continuation code
+ * to figure out what to do.
  *
  * All the routines below use bits of fixup code that are out of line
  * with the main instruction path.  This means when everything is well,
@@ -17,6 +25,7 @@
 struct exception_table_entry
 {
 	int insn, fixup;
+	long handler;
 };
 
 extern struct exception_table_entry *__start_dma_ex_table;
@@ -29,6 +38,37 @@ static inline unsigned long extable_fixup(const struct exception_table_entry *x)
 	return (unsigned long)&x->fixup + x->fixup;
 }
 
+typedef bool (*ex_handler_t)(const struct exception_table_entry *,
+			     struct pt_regs *);
+
+static inline ex_handler_t
+ex_fixup_handler(const struct exception_table_entry *x)
+{
+	return (ex_handler_t)((unsigned long)&x->handler + x->handler);
+}
+
+static inline bool ex_handle(const struct exception_table_entry *x,
+			     struct pt_regs *regs)
+{
+	ex_handler_t handler = ex_fixup_handler(x);
+
+	if (unlikely(handler))
+		return handler(x, regs);
+	regs->psw.addr = extable_fixup(x);
+	return true;
+}
+
 #define ARCH_HAS_RELATIVE_EXTABLE
 
+static inline void swap_ex_entry_fixup(struct exception_table_entry *a,
+				       struct exception_table_entry *b,
+				       struct exception_table_entry tmp,
+				       int delta)
+{
+	a->fixup = b->fixup + delta;
+	b->fixup = tmp.fixup - delta;
+	a->handler = b->handler + delta;
+	b->handler = tmp.handler - delta;
+}
+
 #endif
diff --git a/arch/s390/include/asm/linkage.h b/arch/s390/include/asm/linkage.h
index 1b52c07b5642..83ff5a35d522 100644
--- a/arch/s390/include/asm/linkage.h
+++ b/arch/s390/include/asm/linkage.h
@@ -14,9 +14,10 @@
 
 #define __EX_TABLE(_section, _fault, _target)				\
 	stringify_in_c(.section	_section,"a";)				\
-	stringify_in_c(.align	4;)					\
+	stringify_in_c(.align	8;)					\
 	stringify_in_c(.long	(_fault) - .;)				\
 	stringify_in_c(.long	(_target) - .;)				\
+	stringify_in_c(.quad	0 - .;)					\
 	stringify_in_c(.previous)
 
 #define EX_TABLE(_fault, _target)					\
diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index 548d0ea9808d..d2a71d872638 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -523,10 +523,8 @@ static int kprobe_trap_handler(struct pt_regs *regs, int trapnr)
 		 * zero, try to fix up.
 		 */
 		entry = s390_search_extables(regs->psw.addr);
-		if (entry) {
-			regs->psw.addr = extable_fixup(entry);
+		if (entry && ex_handle(entry, regs))
 			return 1;
-		}
 
 		/*
 		 * fixup_exception() could not handle it,
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index ff9cc4c3290e..8d1e8a1a97df 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -50,11 +50,8 @@ void do_report_trap(struct pt_regs *regs, int si_signo, int si_code, char *str)
         } else {
                 const struct exception_table_entry *fixup;
 		fixup = s390_search_extables(regs->psw.addr);
-                if (fixup)
-			regs->psw.addr = extable_fixup(fixup);
-		else {
+		if (!fixup || !ex_handle(fixup, regs))
 			die(regs, str);
-		}
         }
 }
 
@@ -251,7 +248,7 @@ void monitor_event_exception(struct pt_regs *regs)
 	case BUG_TRAP_TYPE_NONE:
 		fixup = s390_search_extables(regs->psw.addr);
 		if (fixup)
-			regs->psw.addr = extable_fixup(fixup);
+			ex_handle(fixup, regs);
 		break;
 	case BUG_TRAP_TYPE_WARN:
 		break;
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index d53c2e2ea1fd..c4c6cafef3f4 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -255,10 +255,8 @@ static noinline void do_no_context(struct pt_regs *regs)
 
 	/* Are we prepared to handle this kernel fault?  */
 	fixup = s390_search_extables(regs->psw.addr);
-	if (fixup) {
-		regs->psw.addr = extable_fixup(fixup);
+	if (fixup && ex_handle(fixup, regs))
 		return;
-	}
 
 	/*
 	 * Oops. The kernel tried to access some bad page. We'll have to
diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index ec6b5e81eba1..a4b8415ba71c 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -255,6 +255,29 @@ static void x86_sort_relative_table(char *extab_image, int image_size)
 	}
 }
 
+static void s390_sort_relative_table(char *extab_image, int image_size)
+{
+	int i;
+
+	for (i = 0; i < image_size; i += 16) {
+		char *loc = extab_image + i;
+
+		w(r((uint32_t *)loc) + i, (uint32_t *)loc);
+		w(r((uint32_t *)(loc + 4)) + (i + 4), (uint32_t *)(loc + 4));
+		w8(r8((uint64_t *)(loc + 8)) + (i + 8), (uint64_t *)(loc + 8));
+	}
+
+	qsort(extab_image, image_size / 16, 16, compare_relative_table);
+
+	for (i = 0; i < image_size; i += 16) {
+		char *loc = extab_image + i;
+
+		w(r((uint32_t *)loc) - i, (uint32_t *)loc);
+		w(r((uint32_t *)(loc + 4)) - (i + 4), (uint32_t *)(loc + 4));
+		w8(r8((uint64_t *)(loc + 8)) - (i + 8), (uint64_t *)(loc + 8));
+	}
+}
+
 static int do_file(char const *const fname, void *addr)
 {
 	int rc = -1;
@@ -297,6 +320,8 @@ static int do_file(char const *const fname, void *addr)
 		custom_sort = x86_sort_relative_table;
 		break;
 	case EM_S390:
+		custom_sort = s390_sort_relative_table;
+		break;
 	case EM_AARCH64:
 	case EM_PARISC:
 	case EM_PPC:
-- 
2.25.4

