Return-Path: <bpf+bounces-39948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283139798D2
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 22:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0DE8282900
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 20:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F15282499;
	Sun, 15 Sep 2024 20:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iH6LrJDD"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2ED8C13;
	Sun, 15 Sep 2024 20:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726433853; cv=none; b=OtxGz+HBUluCvxRQtlC+TTCByDerVNMZpeSnPCUF6IlEY/LYHguuxSpUC6QRiy+pMHpSE3LpC5GZvAB9gDQjZLe3ZQHylV1gIqrkVAj4uriNCp1HHUP8Dx+BrC9mVe8vPDLIvb2zFHpu/QoqT7r2cauoeuOeBPzQbDKIDA/s124=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726433853; c=relaxed/simple;
	bh=y2JP4qbXuCsmlj+l9jLxeaX9DW6KncNlTbgycQ2yGI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCiuJBLcWmdtXxDuNV+G8HuVuEC0prFpJSzjGBh2i6zmgTd5FDTALpXxAE+Ha2JqosmY8uKvk9t4VYhW/pjkIxugc85Gk9/NxoZe7/dIg9B9d+XwQV/Bzlq5LPC56llUu3Rk8dL/4x8iskB2E1eX2UU7+3p54TVRuIY1fQAFqHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iH6LrJDD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48F1LLB2011130;
	Sun, 15 Sep 2024 20:57:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:mime-version; s=pp1; bh=waWpz8xwhGVvJ
	uEu8/ny4anTG7Fjfqg3qieq+thmI5g=; b=iH6LrJDD+W8a1lW2v+GFUCIa5kCyJ
	sY6Etnp31G6kCBqO0ZY1Uc37dbr+yhin6n32vJQqEKLhotzG4E3VT3f3gkRzWmmB
	/zpgdJV1W/uzTrHglgYdDN2jxCD6Pe/G+S4i1cRCmcZwB17tEIbjd/3o9q7d70v4
	XNH+LWSob/+vRNM2nksKbxnmV6sSygL+s5hcRAdVHbNLBZtRYVAP9CovCNPU9rVz
	rNnbiWRx8Vrpa/CAU1UEXmKzU3QulQ8Lkj84ygCT4C3gI0LErJhfp676yXPvX9EW
	KO10meyNRiuYInAOBRkPl1MTP4k0xFtksItQ8bXWvpQFhnlISEEJACklw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3ucxeq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Sep 2024 20:57:03 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48FKv29W015279;
	Sun, 15 Sep 2024 20:57:02 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3ucxeq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Sep 2024 20:57:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48FIUIMt000620;
	Sun, 15 Sep 2024 20:57:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41nn70uw69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Sep 2024 20:57:01 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48FKuvGv52560220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Sep 2024 20:56:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83E5020049;
	Sun, 15 Sep 2024 20:56:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D929B20040;
	Sun, 15 Sep 2024 20:56:53 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.68.55])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 15 Sep 2024 20:56:53 +0000 (GMT)
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
Subject: [PATCH v5 01/17] powerpc/trace: Account for -fpatchable-function-entry support by toolchain
Date: Mon, 16 Sep 2024 02:26:32 +0530
Message-ID: <20240915205648.830121-2-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240915205648.830121-1-hbathini@linux.ibm.com>
References: <20240915205648.830121-1-hbathini@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aZ_GtpDHWh34DsMhabNGdOvIjwwslp4M
X-Proofpoint-ORIG-GUID: letKLsOlqst6X8tT7gc5OKXepEksA447
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-15_12,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409150159

From: Naveen N Rao <naveen@kernel.org>

So far, we have relied on the fact that gcc supports both
-mprofile-kernel, as well as -fpatchable-function-entry, and clang
supports neither. Our Makefile only checks for CONFIG_MPROFILE_KERNEL to
decide which files to build. Clang has a feature request out [*] to
implement -fpatchable-function-entry, and is unlikely to support
-mprofile-kernel.

Update our Makefile checks so that we pick up the correct files to build
once clang picks up support for -fpatchable-function-entry.

[*] https://github.com/llvm/llvm-project/issues/57031

Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 arch/powerpc/kernel/trace/Makefile | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/trace/Makefile b/arch/powerpc/kernel/trace/Makefile
index 125f4ca588b9..d6c3885453bd 100644
--- a/arch/powerpc/kernel/trace/Makefile
+++ b/arch/powerpc/kernel/trace/Makefile
@@ -9,12 +9,15 @@ CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_ftrace_64_pg.o = $(CC_FLAGS_FTRACE)
 endif
 
-obj32-$(CONFIG_FUNCTION_TRACER)		+= ftrace.o ftrace_entry.o
-ifdef CONFIG_MPROFILE_KERNEL
-obj64-$(CONFIG_FUNCTION_TRACER)		+= ftrace.o ftrace_entry.o
+ifdef CONFIG_FUNCTION_TRACER
+obj32-y					+= ftrace.o ftrace_entry.o
+ifeq ($(CONFIG_MPROFILE_KERNEL)$(CONFIG_ARCH_USING_PATCHABLE_FUNCTION_ENTRY),)
+obj64-y					+= ftrace_64_pg.o ftrace_64_pg_entry.o
 else
-obj64-$(CONFIG_FUNCTION_TRACER)		+= ftrace_64_pg.o ftrace_64_pg_entry.o
+obj64-y					+= ftrace.o ftrace_entry.o
+endif
 endif
+
 obj-$(CONFIG_TRACING)			+= trace_clock.o
 
 obj-$(CONFIG_PPC64)			+= $(obj64-y)
-- 
2.46.0


