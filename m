Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553BA69FF54
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 00:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjBVXRC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 18:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjBVXRC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 18:17:02 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2152D3CE27
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 15:17:01 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MMX0xx031973;
        Wed, 22 Feb 2023 22:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=CwkEWmbi4B9ML3Bk2SV4w4ixhxIEZtc8vT7jkhoyP78=;
 b=iIpDr9yeX8C3+e3rHthwZmoYj8hdicwPKSB3g6zTcNfX9wAJG7VlGOUrTJu8qp8y6pZH
 kINwNOj/atIzkmc0SP2rZvwNH436M6D/M81iN3fxrkXZ1LbIif8nc9jBQrzzcDKsaK5s
 s46FYINpqiG3r4sIgW45cZ3FWomcXy4BdtlNo72bKiEY81xXCSdCpqKdTTtWQydugnZD
 aiAbuK2h3k0+tPqLnpf81ncRknZLVFqrF/Ww2pzpy0pYkScdMhkMF9QX3XmCf+11kYvA
 2YwseLtQavLJndZk4nsPFjlwAgDef5MtD2uzo+DYETGkxoZlp9WfjZTOaj8HH7bACYkE 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwuxpg2wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:29 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31MMY5Zw003257;
        Wed, 22 Feb 2023 22:37:28 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwuxpg2vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:28 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31MKuOA4018070;
        Wed, 22 Feb 2023 22:37:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3ntpa64gdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:26 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31MMbN1J49545532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 22:37:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 208AF2004E;
        Wed, 22 Feb 2023 22:37:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F38C20040;
        Wed, 22 Feb 2023 22:37:22 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.50.17])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Feb 2023 22:37:22 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH bpf-next v3 03/12] sparc: Update maximum errno
Date:   Wed, 22 Feb 2023 23:37:05 +0100
Message-Id: <20230222223714.80671-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230222223714.80671-1-iii@linux.ibm.com>
References: <20230222223714.80671-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mvXEMX2RvI_aXxedyEUvt2Q41X6ba1-d
X-Proofpoint-GUID: CjxvjxHcMpDddo9yZHVxFOA1tNvzR2vU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_10,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 mlxlogscore=595 suspectscore=0
 mlxscore=0 clxscore=1011 phishscore=0 priorityscore=1501 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220195
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When the bpf syscall returns -ENOTSUPP, the kernel does not set
psr/csr. glibc's syscall() then thinks everything is fine and skips
updating errno, causing all kinds of confusion in bpf selftests.

sparc decides whether to set psr/csr by comparing syscall return value
with ERESTART_RESTARTBLOCK, which is smaller than ENOTSUPP. Fix by
introducing EMAXERRNO (like mips) and comparing with that insead.

Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/sparc/include/asm/errno.h | 10 ++++++++++
 arch/sparc/kernel/entry.S      |  2 +-
 arch/sparc/kernel/process.c    |  6 +++---
 arch/sparc/kernel/syscalls.S   |  2 +-
 4 files changed, 15 insertions(+), 5 deletions(-)
 create mode 100644 arch/sparc/include/asm/errno.h

diff --git a/arch/sparc/include/asm/errno.h b/arch/sparc/include/asm/errno.h
new file mode 100644
index 000000000000..0e0a790b8ea8
--- /dev/null
+++ b/arch/sparc/include/asm/errno.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_SPARC_ERRNO_H
+#define _ASM_SPARC_ERRNO_H
+
+#include <uapi/asm/errno.h>
+
+/* The biggest error number defined here or in <linux/errno.h>. */
+#define EMAXERRNO	1133
+
+#endif /* _ASM_SPARC_ERRNO_H */
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index a269ad2fe6df..a24b46ad7b20 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -1004,7 +1004,7 @@ do_syscall:
 
 ret_sys_call:
 	ld	[%curptr + TI_FLAGS], %l5
-	cmp	%o0, -ERESTART_RESTARTBLOCK
+	cmp	%o0, -EMAXERRNO
 	ld	[%sp + STACKFRAME_SZ + PT_PSR], %g3
 	set	PSR_C, %g2
 	bgeu	1f
diff --git a/arch/sparc/kernel/process.c b/arch/sparc/kernel/process.c
index 0442ab00518d..582933d16f9f 100644
--- a/arch/sparc/kernel/process.c
+++ b/arch/sparc/kernel/process.c
@@ -32,7 +32,7 @@ asmlinkage long sparc_fork(struct pt_regs *regs)
 	 * the parent's %o1.  So detect that case and restore it
 	 * here.
 	 */
-	if ((unsigned long)ret >= -ERESTART_RESTARTBLOCK)
+	if ((unsigned long)ret >= -EMAXERRNO)
 		regs->u_regs[UREG_I1] = orig_i1;
 
 	return ret;
@@ -57,7 +57,7 @@ asmlinkage long sparc_vfork(struct pt_regs *regs)
 	 * the parent's %o1.  So detect that case and restore it
 	 * here.
 	 */
-	if ((unsigned long)ret >= -ERESTART_RESTARTBLOCK)
+	if ((unsigned long)ret >= -EMAXERRNO)
 		regs->u_regs[UREG_I1] = orig_i1;
 
 	return ret;
@@ -103,7 +103,7 @@ asmlinkage long sparc_clone(struct pt_regs *regs)
 	 * the parent's %o1.  So detect that case and restore it
 	 * here.
 	 */
-	if ((unsigned long)ret >= -ERESTART_RESTARTBLOCK)
+	if ((unsigned long)ret >= -EMAXERRNO)
 		regs->u_regs[UREG_I1] = orig_i1;
 
 	return ret;
diff --git a/arch/sparc/kernel/syscalls.S b/arch/sparc/kernel/syscalls.S
index 0e8ab0602c36..9064304f6a3a 100644
--- a/arch/sparc/kernel/syscalls.S
+++ b/arch/sparc/kernel/syscalls.S
@@ -262,7 +262,7 @@ ret_sys_call:
 	mov	%ulo(TSTATE_XCARRY | TSTATE_ICARRY), %g2
 	sllx	%g2, 32, %g2
 
-	cmp	%o0, -ERESTART_RESTARTBLOCK
+	cmp	%o0, -EMAXERRNO
 	bgeu,pn	%xcc, 1f
 	 andcc	%l0, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT|_TIF_SYSCALL_TRACEPOINT|_TIF_NOHZ), %g0
 	ldx	[%sp + PTREGS_OFF + PT_V9_TNPC], %l1 ! pc = npc
-- 
2.39.1

