Return-Path: <bpf+bounces-62943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AADBEB008F2
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 18:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F371CA24EC
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 16:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D17E2F1FE8;
	Thu, 10 Jul 2025 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JZLheqKM"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63ED2F1994;
	Thu, 10 Jul 2025 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165359; cv=none; b=iWRwqSbbYILJeHyklBtsNmi+/YMGD0XA+gwkL3KVazA0cJEEGBa7vATaMTEhj85j5Oacp9yLSZH+W4ifI2G0Gisesfb8Pi/RSL70/HbSlLgWyFUk9F++G+1qV2otOUlrHiOJ1n2/CRrEeepfLxet6J+oUjxz1219gv0YYYYB/us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165359; c=relaxed/simple;
	bh=KYs1ceJENroDnUDxMw8CSyDdmDwONMFDpRkG9gCVQU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4oZQGFdRIBk3QVhUEtMk189fDnfz72kE6FmLzX5OkV4joUGpjWysPO8iM661a8d5KRqub+MPEdLVgLwNeDm9h9KpyenHC1FB2a6uKMuWMM35zWrqrhWVQeqslvxGEh3YCqCbG2vlsM4EKlqsn6gaYyL1ryVcsnotdRJ0MU9l1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JZLheqKM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AD5iuA028946;
	Thu, 10 Jul 2025 16:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KrkxlXID0uInFpjQ8
	IQoc2pW64e8vi2BEAPTzF7Znlc=; b=JZLheqKMirWKx0B+sLwiyxFeg0EzUa8TI
	DI0FQ7WSflnSOC3HAhHPZJB/yvWng6zNcFhchW6y4LKUuEOQjhyxTABOoNU4SJ+C
	CwqFADXo4FU7n2zIpGJVyvv5C5Zr5NL5Qkgdins/w9WZ3XinxqEQYAX4nSYMkpWX
	ACXmWdW/By5qgQLOMWLitVZnNVFrDIrNKcKir2hIXRpQ9ao4U7i+zsdMtr1vDjMF
	OOVd1S5QtA5KQutybO44I6f98MG2sSRhAerHXxzU+MbYwsHe185YDzQkNmWmPUjo
	jW8kO50vhV1YET/NPORePZXzt1U+zsAcmEzLCRv4uLoLKgSBwMvsw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ptjrd3bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56AF4hNf013616;
	Thu, 10 Jul 2025 16:35:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qgkm6bc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:32 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56AGZSJI12714314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:35:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 670A02004B;
	Thu, 10 Jul 2025 16:35:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27DFE20063;
	Thu, 10 Jul 2025 16:35:28 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Jul 2025 16:35:28 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
        Sam James <sam@gentoo.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [RFC PATCH v1 15/16] PREREQ: x86/vdso: Enable sframe generation in VDSO
Date: Thu, 10 Jul 2025 18:35:21 +0200
Message-ID: <20250710163522.3195293-16-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250710163522.3195293-1-jremus@linux.ibm.com>
References: <20250710163522.3195293-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=GL8IEvNK c=1 sm=1 tr=0 ts=686febd5 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=6um0ROA3cFbXW2b5GMEA:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: JRIN3E5Xi3FJ8BYjaneJzGrh9Og3E1E1
X-Proofpoint-GUID: JRIN3E5Xi3FJ8BYjaneJzGrh9Og3E1E1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzOSBTYWx0ZWRfXx90kOBlahgzh kaZOzdwX14SVgAmiIXxfeMUzpeMQ+s+hI7Mz0zZ3dQvL5DC9wgf2rJ+B5fGRBKhOsPCiVAjYskv WDj478bPA8OBYV3Q4jI8KMzC5f5MH2A6JtycY2zdZzBD/9LfHErPJN8E6HM82TOgS9TlfwL6yc3
 YZXkphRQmyQpdeGQUBt2PrkuzRmrAEkFl2uABwbHAf+1pUtjMewKugLTPpFRgRkdFuL10B0USbd F639aoSPt1jCdpDwfrKhA3qoLyUiIbMF6TWJ2IAznqDFSg99JaKGubopdE4l+Di92LL7pVio6O3 4Hyq1HPW3EVrJvp8lXevWnV3wa+zV2eMuoMMXAWc2KG7hnB7T1htjT0O9ebrvFWl6doFNsTtj4r
 CloP3ms6jUBp/dA6l+H+eUi7HPQU6/EkNRNECwe3PL3625bfDN2fpSTGwXLLU1AyBFLdBEjD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100139

From: Josh Poimboeuf <jpoimboe@kernel.org>

Enable sframe generation in the VDSO library so kernel and user space
can unwind through it.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---

Notes (jremus):
    Link: https://lore.kernel.org/all/20250425024023.173709192@goodmis.org/
    
    This is a prerequisite for patch "s390/vdso: Enable SFrame generation in
    vDSO" to actually generate SFrame in vDSO, as it introduces config
    option CONFIG_AS_SFRAME.

 arch/Kconfig                          |  3 +++
 arch/x86/entry/vdso/Makefile          | 10 +++++++---
 arch/x86/entry/vdso/vdso-layout.lds.S |  3 +++
 arch/x86/include/asm/dwarf2.h         |  5 ++++-
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 4fe16ad6f053..1c3daccd9072 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -435,6 +435,9 @@ config HAVE_HARDLOCKUP_DETECTOR_ARCH
 	  It uses the same command line parameters, and sysctl interface,
 	  as the generic hardlockup detectors.
 
+config AS_SFRAME
+	def_bool $(as-instr,.cfi_sections .sframe\n.cfi_startproc\n.cfi_endproc)
+
 config UNWIND_USER
 	bool
 
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 54d3e9774d62..2dc0e0ca19a7 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -47,13 +47,17 @@ quiet_cmd_vdso2c = VDSO2C  $@
 $(obj)/vdso-image-%.c: $(obj)/vdso%.so.dbg $(obj)/vdso%.so $(obj)/vdso2c FORCE
 	$(call if_changed,vdso2c)
 
+ifeq ($(CONFIG_AS_SFRAME),y)
+  SFRAME_CFLAGS := -Wa,-gsframe
+endif
+
 #
 # Don't omit frame pointers for ease of userspace debugging, but do
 # optimize sibling calls.
 #
 CFL := $(PROFILING) -mcmodel=small -fPIC -O2 -fasynchronous-unwind-tables -m64 \
        $(filter -g%,$(KBUILD_CFLAGS)) -fno-stack-protector \
-       -fno-omit-frame-pointer -foptimize-sibling-calls \
+       -fno-omit-frame-pointer $(SFRAME_CFLAGS) -foptimize-sibling-calls \
        -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
 
 ifdef CONFIG_MITIGATION_RETPOLINE
@@ -63,7 +67,7 @@ endif
 endif
 
 $(vobjs): KBUILD_CFLAGS := $(filter-out $(PADDING_CFLAGS) $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
-$(vobjs): KBUILD_AFLAGS += -DBUILD_VDSO
+$(vobjs): KBUILD_AFLAGS += -DBUILD_VDSO $(SFRAME_CFLAGS)
 
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
@@ -104,7 +108,7 @@ $(obj)/%-x32.o: $(obj)/%.o FORCE
 
 targets += vdsox32.lds $(vobjx32s-y)
 
-$(obj)/%.so: OBJCOPYFLAGS := -S --remove-section __ex_table
+$(obj)/%.so: OBJCOPYFLAGS := -g --remove-section __ex_table
 $(obj)/%.so: $(obj)/%.so.dbg FORCE
 	$(call if_changed,objcopy)
 
diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index ec1ac191a057..c57cfddfc37d 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -59,6 +59,7 @@ SECTIONS
 	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
 	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
 
+	.sframe		: { *(.sframe) }		:text	:sframe
 
 	/*
 	 * Text is well-separated from actual data: there's plenty of
@@ -87,6 +88,7 @@ SECTIONS
  * Very old versions of ld do not recognize this name token; use the constant.
  */
 #define PT_GNU_EH_FRAME	0x6474e550
+#define PT_GNU_SFRAME	0x6474e554
 
 /*
  * We must supply the ELF program headers explicitly to get just one
@@ -98,4 +100,5 @@ PHDRS
 	dynamic		PT_DYNAMIC	FLAGS(4);		/* PF_R */
 	note		PT_NOTE		FLAGS(4);		/* PF_R */
 	eh_frame_hdr	PT_GNU_EH_FRAME;
+	sframe		PT_GNU_SFRAME;
 }
diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
index 65d958ef1178..ce294e6c9017 100644
--- a/arch/x86/include/asm/dwarf2.h
+++ b/arch/x86/include/asm/dwarf2.h
@@ -12,8 +12,11 @@
 	 * For the vDSO, emit both runtime unwind information and debug
 	 * symbols for the .dbg file.
 	 */
-
+#if defined(__x86_64__) && defined(CONFIG_AS_SFRAME)
+	.cfi_sections .eh_frame, .debug_frame, .sframe
+#else
 	.cfi_sections .eh_frame, .debug_frame
+#endif
 
 #define CFI_STARTPROC		.cfi_startproc
 #define CFI_ENDPROC		.cfi_endproc
-- 
2.48.1


