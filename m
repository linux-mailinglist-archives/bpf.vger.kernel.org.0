Return-Path: <bpf+bounces-39956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901399798F9
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 23:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1467B22BC1
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 21:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5051494B0;
	Sun, 15 Sep 2024 20:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cbwNXHG3"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05737A15A;
	Sun, 15 Sep 2024 20:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726433885; cv=none; b=e76L3apogLIuGlFW3bOqh5iWoBzmsu7kmfJEeJnKqb/j/Y5EU/IjFViBKEfmo+rpIlmUtuqAsVytQN940FjXiDgP0xnVt1HS4mu40SNS8WV/GlOtoITlwr3EAbyuiwi9yI0NYwbZFgp+wZoibp7AJzW48ztKMTfuUrJtGgIaHSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726433885; c=relaxed/simple;
	bh=naOabv/u4ELoz9PvxINelPShW0wR0eKSvYEcD+kfboE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RmYY6+AcC0qzFn9iEik5zmgz/l9PsQDQvNVJoHJqcLOeUM9rRhnG6jGwsw4+jB+sSeNOwfPyRDW2EakjXuwZxJO1cM3VFOe+SDl5nuHiT7sA2cio0QR4y07y4Xbsd1SDuvTgHxlKkHeZdIByx7BR49aGC/QfW/C+tu1xrTTYVuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cbwNXHG3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48FKmcfB000823;
	Sun, 15 Sep 2024 20:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=AxsJpLHo8dECO
	zs4gUkT1Yc+imfdAslCddi/zcVEccY=; b=cbwNXHG3VsQovSVT8iwdGR5jLwUEX
	5D0Kc5u64rL7NZUhuSGf86x2DFczE9Wr5XtKH3btkGtNGKsxVP8seu62WqsFPDSx
	F3nlPkeHp0YqAHN3CSslGrk4gags+6N4VHemKBgZ1wqNe0nD95/Ey/Mygc8kIzsg
	2f8R2niQ9yH0Un6GB+2qOcuXl/OSCB7RdVTxy1GbHZ+e9M/zmKfAazuyncXP1N+a
	Lf0KYNfkCiON76wbPtQJgqQeOQkJcPOzABz9+rmJuZYE7+wRp6cwfoEBwLfsw94y
	Iyxy33a7oskVqhGBI/4WxKGrQmqYe15B8gL9G5pITixAV/pogt8AoogXQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3ucxerc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Sep 2024 20:57:41 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48FKveXD015811;
	Sun, 15 Sep 2024 20:57:40 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3ucxera-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Sep 2024 20:57:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48FHCX6e001871;
	Sun, 15 Sep 2024 20:57:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41nqh3bc0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Sep 2024 20:57:39 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48FKva3r55443764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Sep 2024 20:57:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09C6620049;
	Sun, 15 Sep 2024 20:57:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A332120040;
	Sun, 15 Sep 2024 20:57:32 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.68.55])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 15 Sep 2024 20:57:32 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: "Naveen N. Rao" <naveen@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Vishal Chourasia <vishalc@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v5 10/17] powerpc/ftrace: Add a postlink script to validate function tracer
Date: Mon, 16 Sep 2024 02:26:41 +0530
Message-ID: <20240915205648.830121-11-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240915205648.830121-1-hbathini@linux.ibm.com>
References: <20240915205648.830121-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0kGxEAevJzIpxHJsWu9dk5-6WLrJnEbo
X-Proofpoint-ORIG-GUID: 1rTmZJ8O7kfiC1XaFKXsp6vOPrMqkH7l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-15_12,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409150159

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
---
 arch/powerpc/Kconfig               |  2 +-
 arch/powerpc/Makefile.postlink     |  8 +++++
 arch/powerpc/tools/ftrace_check.sh | 50 ++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100755 arch/powerpc/tools/ftrace_check.sh

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1f9d23b276b5..de18f3baff66 100644
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
index 000000000000..f4310e736f1b
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
+	cut -d' ' -f1 | tr '[[:lower:]]' '[[:upper:]]')
+ftrace_caller_addr=$($nm "$vmlinux" | grep -e " T ftrace_caller$" | \
+	cut -d' ' -f1 | tr '[[:lower:]]' '[[:upper:]]')
+ftrace_tramp_addr=$($nm "$vmlinux" | grep -e " T ftrace_tramp_text$" | \
+	cut -d' ' -f1 | tr '[[:lower:]]' '[[:upper:]]')
+
+ftrace_caller_offset=$(echo "ibase=16;$ftrace_caller_addr - $stext_addr" | bc)
+ftrace_tramp_offset=$(echo "ibase=16;$ftrace_tramp_addr - $ftrace_caller_addr" | bc)
+sz_32m=$(printf "%d" 0x2000000)
+sz_64m=$(printf "%d" 0x4000000)
+
+# ftrace_caller - _stext < 32M
+if [ $ftrace_caller_offset -ge $sz_32m ]; then
+	echo "ERROR: ftrace_caller (0x$ftrace_caller_addr) is beyond 32MiB of _stext" 1>&2
+	echo "ERROR: consider disabling CONFIG_FUNCTION_TRACER, or reducing the size \
+		of kernel text" 1>&2
+	exit 1
+fi
+
+# ftrace_tramp_text - ftrace_caller < 64M
+if [ $ftrace_tramp_offset -ge $sz_64m ]; then
+	echo "ERROR: kernel text extends beyond 64MiB from ftrace_caller" 1>&2
+	echo "ERROR: consider disabling CONFIG_FUNCTION_TRACER, or reducing the size \
+		of kernel text" 1>&2
+	exit 1
+fi
-- 
2.46.0


