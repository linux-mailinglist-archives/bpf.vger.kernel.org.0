Return-Path: <bpf+bounces-62949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F78FB008FD
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 18:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C161D17E59F
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 16:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7872248B3;
	Thu, 10 Jul 2025 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oactIFl0"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54432F3638;
	Thu, 10 Jul 2025 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165377; cv=none; b=XYCVOs6t1Oz6olS43VQb3KV0p1wwcD3bwN3219Nx4tTYNFKRKJT7rwBO7eqo+InL9rN+iH+HkvgVXXg6unk2e6bayx/wvHdoG2tzvW6NNwkSchedp6LnJD1Xz9GB3uRrOJNx8J9RqY9+GmDFVm03awew7cr0NjNHACUMGo/5nT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165377; c=relaxed/simple;
	bh=UAfYvcgiWHiEJ2gXy4pbjpo8hgDaubvexbeOgsWvoLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwj7D7D8tBb/tpFJr3uX9oOSigtDkjjyNvyMRNELYHfXFZacasSOrqdO5Ee6Qj25D3dnCQmKwr9WyU8oTtBRdBxW4W9bYmQFXuMy839PdiUW/75BKtO9XPvFzY4tKujwsNIlV8PJU8rKhQ1ug4PHIGaMeN/TQ78TWctfpLDTLfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oactIFl0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AEfUbp000348;
	Thu, 10 Jul 2025 16:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BGFsyTN5Rs0FfQXqr
	x7kt0aBQ1EuAK8UL32ZCDucfW0=; b=oactIFl0OxUPj5L8mthME5b+suG/zfGMS
	dKBr1q8zQlR4aMspRTWRuhDCoVI4HRDQODQgZuZNqAbGupj/A4MJmGtlDfOvk5ES
	s5ouZu/iUruOLA6xVkJp9v+BY2OQICD0Bw/EkXhPxKqPs0vtzOskI0Njlro46qCR
	z1r6ufudiI47m9HKV142/3NtV8/JyTkXK4cLi+RX7mm++c6hnWzGTTweTn7N1zsE
	krsBpapRe3SU0eCcxLlHPsxoNr7EWlz3t4dtYpyB9+fCVNRzvQ8lJytQARpXPdy+
	0T/rtttdzcbJJfQckByaWRKdRHrU1igjFSSjMJFSDDBuWeXG8lPVQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puk4e419-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56AF9mAD003362;
	Thu, 10 Jul 2025 16:35:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfvmpen6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:29 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56AGZPOV58458490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:35:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66CE02004B;
	Thu, 10 Jul 2025 16:35:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C04B20040;
	Thu, 10 Jul 2025 16:35:25 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Jul 2025 16:35:25 +0000 (GMT)
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
        Sam James <sam@gentoo.org>
Subject: [RFC PATCH v1 04/16] s390/vdso: Enable SFrame generation in vDSO
Date: Thu, 10 Jul 2025 18:35:10 +0200
Message-ID: <20250710163522.3195293-5-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzOSBTYWx0ZWRfX7+ZiYKLNBkWK /SwqOv6+jZohcevzklBjB4YbMuneJCDLbV9pJGo/HMvBxv7NHon120dRPPsKjTHYL2PPeQJP77+ P83V/FLwuW3f9ucGGetBVfI57Yvx6pxCpE8y4tiCnFsYt2AUPDE1RNPjlyi2aYE1SJp14fsJcNt
 af0Jg1EJesto/JL/pLe94C1ST8vy2CphohnxSr3fvFJguG4sfSj80JIgCgliUnQWJ2voH0n7Nq1 7fmaVXZM0MN8oLhbEUdmMcFz/og3tbUBO3xJqn+88KqaTpogMi2yY28giTFqBaDfggHEsTYFFC7 NMxrcio36id4/YtHj9yYC3UjxW38OsDgws1+yDwijZNRmL7FribPze+mvLW2/Mhv7VKRauDX61I
 ben1vzAfyaP510scfVl4bKykZ3qTBQr+YhxHvNtPwsdAIKKblTcogojwXogzjWp8AYbt55zZ
X-Authority-Analysis: v=2.4 cv=XYeJzJ55 c=1 sm=1 tr=0 ts=686febd2 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=VnNF1IyMAAAA:8 a=M6Dy1fKG3ZVxTaNKAucA:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: ZcfnYn22iBecuFvuwfMNbOsEVD3NtGee
X-Proofpoint-GUID: ZcfnYn22iBecuFvuwfMNbOsEVD3NtGee
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 mlxlogscore=677 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100139

This replicates Josh's commit TODO ("x86/vdso: Enable sframe generation
in VDSO") for s390.

Enable SFrame generation in the vDSO library so kernel and user space
can unwind through it.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Link to latest x86 patch:
    https://lore.kernel.org/all/20250425024023.173709192@goodmis.org/

 arch/s390/include/asm/dwarf.h        | 4 ++++
 arch/s390/kernel/vdso64/Makefile     | 7 ++++++-
 arch/s390/kernel/vdso64/vdso64.lds.S | 5 +++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/dwarf.h b/arch/s390/include/asm/dwarf.h
index 5052ee6a40f7..aeb54e716d5a 100644
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
index d8f0df742809..e96156b9c4df 100644
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
index e4f6551ae898..7acecb0d9b7e 100644
--- a/arch/s390/kernel/vdso64/vdso64.lds.S
+++ b/arch/s390/kernel/vdso64/vdso64.lds.S
@@ -50,6 +50,9 @@ SECTIONS
 
 	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
 	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
+
+	.sframe		: { *(.sframe) }		:text	:sframe
+
 	.gcc_except_table : { *(.gcc_except_table .gcc_except_table.*) }
 
 	.rela.dyn ALIGN(8) : { *(.rela.dyn) }
@@ -114,6 +117,7 @@ SECTIONS
  * Very old versions of ld do not recognize this name token; use the constant.
  */
 #define PT_GNU_EH_FRAME	0x6474e550
+#define PT_GNU_SFRAME	0x6474e554
 
 /*
  * We must supply the ELF program headers explicitly to get just one
@@ -125,6 +129,7 @@ PHDRS
 	dynamic		PT_DYNAMIC FLAGS(4);		/* PF_R */
 	note		PT_NOTE FLAGS(4);		/* PF_R */
 	eh_frame_hdr	PT_GNU_EH_FRAME;
+	sframe		PT_GNU_SFRAME;
 }
 
 /*
-- 
2.48.1


