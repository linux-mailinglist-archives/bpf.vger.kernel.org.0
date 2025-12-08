Return-Path: <bpf+bounces-76313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBD9CADE49
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 18:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CF9B306BD4E
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 17:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF4031AAA5;
	Mon,  8 Dec 2025 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sb8xK7PE"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716F7274643;
	Mon,  8 Dec 2025 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765214217; cv=none; b=tjbehpnGab5tgbmFcAcobSPv4epP0bvSLuCSWjED6Cza4fbrvGhpRnWF3Lltkdw7Py4DMeRYiwaNLf9E0mHRwgKjOfV785NXy5EwccOgGkCzL+u5E+YgW7x42Lna0q8OAyDPTUJyDSvSCYoIIq7IVEGTzACnyFsGN2uzfiznBRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765214217; c=relaxed/simple;
	bh=Ig76xTemWnBp5V9wcafXhVnewT4GyeDWXCD4NFeuEEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYoXP0K9jX2/DDxZ4rnW9TgkFTp2p2PBemmEkVeQ2TtehhT7iOyXIMciPnpg5xsas54sNMUbECPvwKWserLI9PUA0YkMv0lgSYDLRiMKLfkwJukOVnuhJnxBWebGgJi6lPoEnTMXzb8dY9D6lQb5Ev3ao0pGwvZTP4RvpoXDD3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sb8xK7PE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8DY0gf014495;
	Mon, 8 Dec 2025 17:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XDw2tSBsdhyOzenUT
	DEc+daDW0YtX3pVwUrUg8mkf/0=; b=Sb8xK7PEF7wtPxNXuCWeQBXR79NS3R2TD
	b8KkH1SYSZMFkk9ihuyaxUkzSqBSOtbISXqkfAQePzH3qIlWuC+hsSwhcrKDVNMf
	tutxsC7l8qqohdQpMYhN34KUK7c840a1mZJxCgt1NQs6nYYQhXQ9l0JJ/BBRvKUO
	FDXkohCF4lHJDAbE7z2qq7GRMk0f+02fTN6ErLD4+knXRB3rdTtOjAek/76OhQqM
	L1i4tDghqnG+LpJ8N1Ia6Ee/lMO5pUosaAI6K/o18tIL5AJ6f9UXvnNsMMCnwQHs
	o+ZnVTLHUljc1MgLM+gB3P8gy9y9J1xru4o1CStI/nbabrgaVZkww==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc538dmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:10 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B8HG94O026302;
	Mon, 8 Dec 2025 17:16:10 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc538dmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8EPJHZ030452;
	Mon, 8 Dec 2025 17:16:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4avxtrxxs7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:08 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B8HG5XZ24314486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Dec 2025 17:16:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B33C20043;
	Mon,  8 Dec 2025 17:16:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA6F52004D;
	Mon,  8 Dec 2025 17:16:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Dec 2025 17:16:04 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
        "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>,
        Dylan Hatch <dylanbhatch@google.com>
Subject: [RFC PATCH v3 08/17] s390/vdso: Enable SFrame generation in vDSO
Date: Mon,  8 Dec 2025 18:15:50 +0100
Message-ID: <20251208171559.2029709-9-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251208171559.2029709-1-jremus@linux.ibm.com>
References: <20251208171559.2029709-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX0dLDgmwqv5fS
 YsMcHt+8bojwggFr03PzXDfRsrzQdiUIhhX5Z6UwjlkEVxCRAzaa68TVkoGJRzsAznWRyv3LpN5
 6U4CRcy1yQwQOlQeM7rJbc8+1tOD6ibEVoQZ/CcgwAc/FvXcS5SCsJs/qHuUDi1TfVIc/8RfOT3
 LmzBMJGyieup00AMO/ZxsXlg6SoxfDrNCEmvaP64Ru8xgUvfY0KSxsR2C3zmuWmoj0nwOgpFP8i
 MSZ0Vw5KQiVzvd5nEd/KhFR9x44yjn1otWQnD7LPhqWzHYHMS5KG7C9t4Drds/rh83xCiN/4upD
 8Lg6pSZJ2EOrWHIVbNyHxiJlxL9UaVlJyPofhgrQGx7ts7A0Kyx1W+AI/iN7U/X3QQj0Kf49VKv
 mhDiIH2UMicT3mnmXjQUIqAUsV8r1Q==
X-Authority-Analysis: v=2.4 cv=S/DUAYsP c=1 sm=1 tr=0 ts=693707da cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8
 a=VnNF1IyMAAAA:8 a=dAJiN8YmCtcRjYQ6G8MA:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: zweHWsrF6Dru09rXtEtp9m74b0LQbiE3
X-Proofpoint-GUID: z-xVEMQKP681mfiWoo96vjf3j-uVaQio
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020

This replicates Josh's x86 patch "x86/vdso: Enable sframe generation
in VDSO" [1] for s390.

Test whether the assembler supports generating SFrame stack trace
information.  Note that it is insufficient to test whether the assembler
supports option --gsframe, as GNU assembler supports that regardless
of whether it is actually capable of generating SFrame stack trace
information for the architecture.

If so enable SFrame stack trace information generation in the vDSO
library so kernel and user space can unwind through it.

[1]: x86/vdso: Enable sframe generation in VDSO,
     https://lore.kernel.org/all/20250425024023.173709192@goodmis.org/

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in RFC v2:
    - Introduce config option AS_SFRAME instead of requiring Josh's x86
      patch as pre-requisite.
    - Reword commit message.
    
    Link to Josh's latest x86 patch:
    https://lore.kernel.org/all/20250425024023.173709192@goodmis.org/

 arch/Kconfig                         | 3 +++
 arch/s390/include/asm/dwarf.h        | 4 ++++
 arch/s390/kernel/vdso64/Makefile     | 7 ++++++-
 arch/s390/kernel/vdso64/vdso64.lds.S | 9 +++++++++
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 06c4f909398c..7fa89d70b244 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -482,6 +482,9 @@ config HAVE_HARDLOCKUP_DETECTOR_ARCH
 	  It uses the same command line parameters, and sysctl interface,
 	  as the generic hardlockup detectors.
 
+config AS_SFRAME
+	def_bool $(as-instr,.cfi_sections .sframe\n.cfi_startproc\n.cfi_endproc)
+
 config UNWIND_USER
 	bool
 
diff --git a/arch/s390/include/asm/dwarf.h b/arch/s390/include/asm/dwarf.h
index 6bcf37256feb..2f148b15fd7d 100644
--- a/arch/s390/include/asm/dwarf.h
+++ b/arch/s390/include/asm/dwarf.h
@@ -16,7 +16,11 @@
 	 * symbols for the .dbg file.
 	 */
 
+#ifdef CONFIG_AS_SFRAME
+	.cfi_sections .eh_frame, .debug_frame, .sframe
+#else
 	.cfi_sections .eh_frame, .debug_frame
+#endif
 
 #define CFI_STARTPROC		.cfi_startproc
 #define CFI_ENDPROC		.cfi_endproc
diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
index 8e78dc3ba025..f597f3b863d7 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -20,7 +20,11 @@ targets := $(obj-vdso64) $(obj-cvdso64) vdso64.so vdso64.so.dbg
 obj-vdso64 := $(addprefix $(obj)/, $(obj-vdso64))
 obj-cvdso64 := $(addprefix $(obj)/, $(obj-cvdso64))
 
-KBUILD_AFLAGS += -DBUILD_VDSO
+ifeq ($(CONFIG_AS_SFRAME),y)
+	SFRAME_CFLAGS := -Wa,--gsframe
+endif
+
+KBUILD_AFLAGS += -DBUILD_VDSO $(SFRAME_CFLAGS)
 KBUILD_CFLAGS += -DBUILD_VDSO -DDISABLE_BRANCH_PROFILING
 
 KBUILD_AFLAGS_64 := $(filter-out -m64,$(KBUILD_AFLAGS))
@@ -32,6 +36,7 @@ KBUILD_CFLAGS_64 := $(filter-out -mno-pic-data-is-text-relative,$(KBUILD_CFLAGS_
 KBUILD_CFLAGS_64 := $(filter-out -munaligned-symbols,$(KBUILD_CFLAGS_64))
 KBUILD_CFLAGS_64 := $(filter-out -fno-asynchronous-unwind-tables,$(KBUILD_CFLAGS_64))
 KBUILD_CFLAGS_64 += -m64 -fPIC -fno-common -fno-builtin -fasynchronous-unwind-tables
+KBUILD_CFLAGS_64 += $(SFRAME_CFLAGS)
 ldflags-y := -shared -soname=linux-vdso64.so.1 \
 	     --hash-style=both --build-id=sha1 -T
 
diff --git a/arch/s390/kernel/vdso64/vdso64.lds.S b/arch/s390/kernel/vdso64/vdso64.lds.S
index e4f6551ae898..0205d84369ca 100644
--- a/arch/s390/kernel/vdso64/vdso64.lds.S
+++ b/arch/s390/kernel/vdso64/vdso64.lds.S
@@ -50,6 +50,11 @@ SECTIONS
 
 	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
 	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
+
+#ifdef CONFIG_AS_SFRAME
+	.sframe		: { *(.sframe) }		:text	:sframe
+#endif
+
 	.gcc_except_table : { *(.gcc_except_table .gcc_except_table.*) }
 
 	.rela.dyn ALIGN(8) : { *(.rela.dyn) }
@@ -114,6 +119,7 @@ SECTIONS
  * Very old versions of ld do not recognize this name token; use the constant.
  */
 #define PT_GNU_EH_FRAME	0x6474e550
+#define PT_GNU_SFRAME	0x6474e554
 
 /*
  * We must supply the ELF program headers explicitly to get just one
@@ -125,6 +131,9 @@ PHDRS
 	dynamic		PT_DYNAMIC FLAGS(4);		/* PF_R */
 	note		PT_NOTE FLAGS(4);		/* PF_R */
 	eh_frame_hdr	PT_GNU_EH_FRAME;
+#ifdef CONFIG_AS_SFRAME
+	sframe		PT_GNU_SFRAME;
+#endif
 }
 
 /*
-- 
2.51.0


