Return-Path: <bpf+bounces-42439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A890D9A44D7
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 19:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF6E71C23C47
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 17:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE8920403B;
	Fri, 18 Oct 2024 17:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="govUo/QW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1722022D6;
	Fri, 18 Oct 2024 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273034; cv=none; b=cCkll7YE8oMAb78tDVLxIbrxaQVXa0xfrbNFBqGROp8zUZawFKWWsKxNFNN9BOXYw7BqLYHMaqbOelPJP676Z/kOcnJvnaYiXUojCdhCHGSHwOVF0bEbTfHZomfUWUTLf+1y6o5M0VPzIk4rub1ZVqxbZRvr027xvjvxVQk9QR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273034; c=relaxed/simple;
	bh=OHa/5zWi0vXq4rcvFOVZBvchbuev/e5QhlYi7bktsvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=doOHhNg73qd7qFPoYg4/fM2+XOarMA9sE763yU5F/eQfaDVflVZPthjQAEX67y8x63hbj333ExnKSXqVxbxLLzZvXpqDCC5hIYGtoC9d9S3vjksHW5xrMpGxChYnu9rKG1sXP341ltculagEYR3aN+9b/lNZaKh2I7gyh8wHMaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=govUo/QW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I9m5SF015438;
	Fri, 18 Oct 2024 17:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=oL9IMEzVW/uiWNE33
	1Qsj0y4/iuYLMGRaqR2BGXECGI=; b=govUo/QWtIxF90G2UJGKTLmlERhRafMVx
	IfjDkyVwkCQ1smfyqpYHgah1XY0mAbzqeQodBGwMtMqZCRoaQh2tbsjzbStVt5Mr
	lvdNicvd4QRrX7dbWf/nJVywpnhRpeqlUUCDF8VP9layYK3fgK6q4gxHGscMVC41
	SS6fUx3kANk1SPuBFLoM5orI2QSIUXRRX9b4MvXnNtf/GwbHqAtBGLdaK5ZE6/d+
	bJABKd3I7wLVjAPvpn2/S5go1kt+z7DlhUBtyvZeycpqxmM95s/eAicoONpcTC4H
	yB0Mw0KrhO/qt3QgdBXfA6E0y1m4pZ0Bp/kN1xBgAlZsXIV2o6y5w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42aqgracf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 17:36:47 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49IHakP3009380;
	Fri, 18 Oct 2024 17:36:46 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42aqgracf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 17:36:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49IH7CmD006674;
	Fri, 18 Oct 2024 17:36:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4283ese5ru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 17:36:45 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49IHaguB32244354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 17:36:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3881420043;
	Fri, 18 Oct 2024 17:36:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2198B20040;
	Fri, 18 Oct 2024 17:36:38 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.99.188])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Oct 2024 17:36:37 +0000 (GMT)
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
Subject: [PATCH v6 01/17] powerpc/trace: Account for -fpatchable-function-entry support by toolchain
Date: Fri, 18 Oct 2024 23:06:16 +0530
Message-ID: <20241018173632.277333-2-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241018173632.277333-1-hbathini@linux.ibm.com>
References: <20241018173632.277333-1-hbathini@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qreVLQ2fwO0r0YyIsFvzm78eaidVgshv
X-Proofpoint-GUID: 3IpwSKqhGPkW8erZ7fEpG8dlsULJrk7V
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410180111

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
2.47.0


