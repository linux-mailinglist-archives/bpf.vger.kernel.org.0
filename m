Return-Path: <bpf+bounces-42449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF60D9A4505
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 19:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24DC6B21D98
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 17:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A3120493F;
	Fri, 18 Oct 2024 17:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L6Xfqctd"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591482076DF;
	Fri, 18 Oct 2024 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273074; cv=none; b=jj1SoTGeL0qC69mi/3jLqvs0rJffDD+wCFyokTNnvGqaapSxT5M00BBE/Zb045s5fT6YWx/bwK6ltiMitqHyaQZAdEDexv8M0jycdig22d0RQ/mQJkYioO/WvggMMPDSNTiftbRPzqp0G74HvGgJaO7ROQwSRnBWUB/G8Df3/90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273074; c=relaxed/simple;
	bh=mzQaSKiFIvV1Ou/1SmtfbzngqaZMGo7HvE5vORtP2b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nA8SrhBHzv9nVgcq1n32B6qAdhdem801DK8z0jO/x6IcT/b18/+2SYX6vdJ4+PjyUA7oU0OlSuPBnfQedishwZ+kIhGppYASfXN+5vOaXWGyl4I454FgtewlO7geijTlxsdHLznjTNSKk3hZ3WESBKWrsgz6DbuxZUdybienO6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L6Xfqctd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ICZmv1023701;
	Fri, 18 Oct 2024 17:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JGYWfrPfzXzPdrdn1
	nMdFcY4hYimZxb7JncZtcrP9U4=; b=L6XfqctdAdQTQ5X3FHgkOm4NWoENrXw8u
	7kCWChAL5LHLeNoz+IeJCjlLoYNLsLgdMU6Ex4J4eR0M1Z6K4YFT7EFziLuxx1vu
	P3HDlxgwwJVlqFbOufrgMO2ebNgYMtIdzhGh/J1LNlv/7w8XSa+UHZTlh0ybQCpR
	wzrsKk73suHj4GKR/4qLEvEuRQ95/3kbwRDS0pOvCRHgUd8+eH2t8/jF31ct2sZj
	TZS9I1sGSo/OIlD0/XQidXxIBP5/n1YUyuv+2+BOrc4VDEWCvu2DwTVBmUuBKZZs
	zaPRDhyvuHLKLnB9SbnX/EI0dnn+XYyBvMogz9K3jvoFdyvU4/j3w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ar0ua92d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 17:37:27 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49IHbRgl019214;
	Fri, 18 Oct 2024 17:37:27 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ar0ua927-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 17:37:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49IHMVgR001982;
	Fri, 18 Oct 2024 17:37:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284en600t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 17:37:26 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49IHbM1852691360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 17:37:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5ACE820040;
	Fri, 18 Oct 2024 17:37:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5159620043;
	Fri, 18 Oct 2024 17:37:18 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.99.188])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Oct 2024 17:37:18 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, "Naveen N. Rao" <naveen@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Vishal Chourasia <vishalc@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Subject: [PATCH v6 10/17] powerpc/ftrace: Add a postlink script to validate function tracer
Date: Fri, 18 Oct 2024 23:06:25 +0530
Message-ID: <20241018173632.277333-11-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241018173632.277333-1-hbathini@linux.ibm.com>
References: <20241018173632.277333-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rbcGewJQCxkyPEldCazRbreCxL64LPWi
X-Proofpoint-ORIG-GUID: wFfpNO7IdFXcKyC-6o_aqKlHsqbWKkfj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180111

From: Naveen N Rao <naveen@kernel.org>

Function tracer on powerpc can only work with vmlinux having a .text
size of up to ~64MB due to powerpc branch instruction having a limited
relative branch range of 32MB. Today, this is only detected on kernel
boot when ftrace is init'ed. Add a post-link script to check the size of
.text so that we can detect this at build time, and break the build if
necessary.

We add a dependency on !COMPILE_TEST for CONFIG_HAVE_FUNCTION_TRACER so
that allyesconfig and other test builds can continue to work without
enabling ftrace.

Signed-off-by: Naveen N Rao <naveen@kernel.org>
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---

Changes in v6:
* Shellcheck warnings fixed for arch/powerpc/tools/ftrace_check.sh


 arch/powerpc/Kconfig               |  2 +-
 arch/powerpc/Makefile.postlink     |  8 +++++
 arch/powerpc/tools/ftrace_check.sh | 50 ++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100755 arch/powerpc/tools/ftrace_check.sh

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8094a01974cc..bd1ca813e71c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -243,7 +243,7 @@ config PPC
 	select HAVE_FUNCTION_DESCRIPTORS	if PPC64_ELF_ABI_V1
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FUNCTION_GRAPH_TRACER
-	select HAVE_FUNCTION_TRACER		if PPC64 || (PPC32 && CC_IS_GCC)
+	select HAVE_FUNCTION_TRACER		if !COMPILE_TEST && (PPC64 || (PPC32 && CC_IS_GCC))
 	select HAVE_GCC_PLUGINS			if GCC_VERSION >= 50200   # plugin support on gcc <= 5.1 is buggy on PPC
 	select HAVE_GENERIC_VDSO
 	select HAVE_HARDLOCKUP_DETECTOR_ARCH	if PPC_BOOK3S_64 && SMP
diff --git a/arch/powerpc/Makefile.postlink b/arch/powerpc/Makefile.postlink
index ae5a4256b03d..bb601be36173 100644
--- a/arch/powerpc/Makefile.postlink
+++ b/arch/powerpc/Makefile.postlink
@@ -24,6 +24,9 @@ else
 	$(CONFIG_SHELL) $(srctree)/arch/powerpc/tools/relocs_check.sh "$(OBJDUMP)" "$(NM)" "$@"
 endif
 
+quiet_cmd_ftrace_check = CHKFTRC $@
+      cmd_ftrace_check = $(CONFIG_SHELL) $(srctree)/arch/powerpc/tools/ftrace_check.sh "$(NM)" "$@"
+
 # `@true` prevents complaint when there is nothing to be done
 
 vmlinux: FORCE
@@ -34,6 +37,11 @@ endif
 ifdef CONFIG_RELOCATABLE
 	$(call if_changed,relocs_check)
 endif
+ifdef CONFIG_FUNCTION_TRACER
+ifndef CONFIG_PPC64_ELF_ABI_V1
+	$(call cmd,ftrace_check)
+endif
+endif
 
 clean:
 	rm -f .tmp_symbols.txt
diff --git a/arch/powerpc/tools/ftrace_check.sh b/arch/powerpc/tools/ftrace_check.sh
new file mode 100755
index 000000000000..405e7e306617
--- /dev/null
+++ b/arch/powerpc/tools/ftrace_check.sh
@@ -0,0 +1,50 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# This script checks vmlinux to ensure that all functions can call ftrace_caller() either directly,
+# or through the stub, ftrace_tramp_text, at the end of kernel text.
+
+# Error out if any command fails
+set -e
+
+# Allow for verbose output
+if [ "$V" = "1" ]; then
+	set -x
+fi
+
+if [ $# -lt 2 ]; then
+	echo "$0 [path to nm] [path to vmlinux]" 1>&2
+	exit 1
+fi
+
+# Have Kbuild supply the path to nm so we handle cross compilation.
+nm="$1"
+vmlinux="$2"
+
+stext_addr=$($nm "$vmlinux" | grep -e " [TA] _stext$" | \
+	cut -d' ' -f1 | tr '[:lower:]' '[:upper:]')
+ftrace_caller_addr=$($nm "$vmlinux" | grep -e " T ftrace_caller$" | \
+	cut -d' ' -f1 | tr '[:lower:]' '[:upper:]')
+ftrace_tramp_addr=$($nm "$vmlinux" | grep -e " T ftrace_tramp_text$" | \
+	cut -d' ' -f1 | tr '[:lower:]' '[:upper:]')
+
+ftrace_caller_offset=$(echo "ibase=16;$ftrace_caller_addr - $stext_addr" | bc)
+ftrace_tramp_offset=$(echo "ibase=16;$ftrace_tramp_addr - $ftrace_caller_addr" | bc)
+sz_32m=$(printf "%d" 0x2000000)
+sz_64m=$(printf "%d" 0x4000000)
+
+# ftrace_caller - _stext < 32M
+if [ "$ftrace_caller_offset" -ge "$sz_32m" ]; then
+	echo "ERROR: ftrace_caller (0x$ftrace_caller_addr) is beyond 32MiB of _stext" 1>&2
+	echo "ERROR: consider disabling CONFIG_FUNCTION_TRACER, or reducing the size \
+		of kernel text" 1>&2
+	exit 1
+fi
+
+# ftrace_tramp_text - ftrace_caller < 64M
+if [ "$ftrace_tramp_offset" -ge "$sz_64m" ]; then
+	echo "ERROR: kernel text extends beyond 64MiB from ftrace_caller" 1>&2
+	echo "ERROR: consider disabling CONFIG_FUNCTION_TRACER, or reducing the size \
+		of kernel text" 1>&2
+	exit 1
+fi
-- 
2.47.0


