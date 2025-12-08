Return-Path: <bpf+bounces-76304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C31C1CADEC1
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 18:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99024305F65B
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 17:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DF4314D38;
	Mon,  8 Dec 2025 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y/9om1dH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9883131352F;
	Mon,  8 Dec 2025 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765214201; cv=none; b=pcBocBQfNAZGtoW95me6k7cKO3iKZErMQg3XLKUQdhqfElIAD2NjehKSGU6vVAbcPMUGCablSDjgcWLjet+ni1Kg/1i5liSykx00GInz6qk9fkm64q3laotWKqqZEXwdCHuLcLIu8bRLh2uyOR8r5XMC8GJAN8M3n2h1q05E4EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765214201; c=relaxed/simple;
	bh=vLEhnj0MnCVRnj7evIOY+Rc9ZySnab5v4buMSoJ2Faw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOab/Sz2/L2BVPRmDsymZVWvHgTs9WrJixrPLkvgh+SXNitmqso6CAwXZOe5Fd2RPlPGikXuKcx2ceXvb65FUYJ4Fs8RXI0HaIGyoylY9GM3j4l1UOLEPRNPWK+DL0EgvXnY21u9YfiVO1Z+dKtyqczZhkBPJUv+y2RDSIhROQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y/9om1dH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B882Bpk005499;
	Mon, 8 Dec 2025 17:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WYnGAj471FGyqUSMT
	rvQ4NfweJpV1tdUDWT4qKBKhhU=; b=Y/9om1dHIddnG8ack4dWvsiwTmBErYlCX
	/RK5myVD+GnteIPq87s21YBk+chTe/WI4wMeh9pRcsFyMTVyDpWbpWY5UbWt14Rl
	ZuX3rJ2iQ0IG3XTL5ady8tgoZn/eGr2Wc7ya3nhNAdNPC5PUGGRyDLPmT0GJoa8E
	i7eWPQIpAo+EUM9F6owe6ATholnvkzYDVLMHmFard+699zW4qZUA10YXqw4vARkb
	FlZk9tg3FTcwyyIuo2bsSlS7TJ/oCOqL1lnsGDYi47KmsgDpWu2ASLflVDpH9ySI
	6pa3OZjP3igzXnX4ASucRzE67pLAS6R9sak1A9seSF/ujYrskE0cg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wvgqcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:08 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B8HG7N1004190;
	Mon, 8 Dec 2025 17:16:07 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wvgqct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8F8nc5008391;
	Mon, 8 Dec 2025 17:16:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avytmpsqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:06 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B8HG3eB37290440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Dec 2025 17:16:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E24D720043;
	Mon,  8 Dec 2025 17:16:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DA4D2005A;
	Mon,  8 Dec 2025 17:16:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Dec 2025 17:16:02 +0000 (GMT)
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
Subject: [RFC PATCH v3 02/17] unwind_user/fp: Use dummies instead of ifdef
Date: Mon,  8 Dec 2025 18:15:44 +0100
Message-ID: <20251208171559.2029709-3-jremus@linux.ibm.com>
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
X-Proofpoint-GUID: f3gH4bKxUzS9Pwz9hMzHAGi1psWY5JJ5
X-Proofpoint-ORIG-GUID: dNrD6h2fz8VwR_OVDxlgbcuH_YvPbsdy
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=693707d8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=pRS0VBzutSDFB64YrXgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfX1oDoCmta2Fup
 rOoxG8uZTjNFO5brjg9d/uOkSDP/JJfNAnY+w4/cBLdT769pc2ZqvjqKg/SW80QGeQQKQBpXyI8
 k/B9ZGg+lnHgLGqI9aJQOs1kRrnuPHJm4NVBdDeq8XcfBL0wqb8IW2tDGQWxwCDSduH4l1V5PQu
 i6IP5zEJ7ZUs1GRuuU7Khj22bFEUpVKpt+CgtIViIrQ22k3upI7Dhjhd+TNaT1yHArOn/9pFFEE
 PcaaPQa9FZ+1Zy8VINee6WOfKso72ZfakiRCknS4yF3LkSjiYcnT4oxO9TzH0zzp3XlwxGeDtrn
 s/AHffQdXHqIRuX13LZItnUM/GLxnPb+15L05Vm0SgbuXKDopZjLs6xIiHNRqXOBLNflHajmtpO
 x7ne/10n3pbI8IgF5gD5+VLn7ZLITw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000

This simplifies the code.   unwind_user_next_fp() does not need to
return -EINVAL if config option HAVE_UNWIND_USER_FP is disabled, as
unwind_user_start() will then not select this unwind method and
unwind_user_next() will therefore not call it.

Provide (1) a dummy definition of ARCH_INIT_USER_FP_FRAME, if the unwind
user method HAVE_UNWIND_USER_FP is not enabled, (2) a common fallback
definition of unwind_user_at_function_start() which returns false, and
(3) a common dummy definition of ARCH_INIT_USER_FP_ENTRY_FRAME.

Note that enabling the config option HAVE_UNWIND_USER_FP without
defining ARCH_INIT_USER_FP_FRAME triggers a compile error, which is
helpful when implementing support for this unwind user method in an
architecture.  Enabling the config option when providing an arch-
specific unwind_user_at_function_start() definition makes it necessary
to also provide an arch-specific ARCH_INIT_USER_FP_ENTRY_FRAME
definition.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 arch/x86/include/asm/unwind_user.h |  1 +
 include/linux/unwind_user.h        | 18 ++++++++++++++++--
 kernel/unwind/user.c               |  4 ----
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index f9a1c460150d..a528eee80dd6 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -37,6 +37,7 @@ static inline bool unwind_user_at_function_start(struct pt_regs *regs)
 {
 	return is_uprobe_at_func_entry(regs);
 }
+#define unwind_user_at_function_start unwind_user_at_function_start
 
 #endif /* CONFIG_HAVE_UNWIND_USER_FP */
 
diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
index 7f7282516bf5..64618618febd 100644
--- a/include/linux/unwind_user.h
+++ b/include/linux/unwind_user.h
@@ -5,8 +5,22 @@
 #include <linux/unwind_user_types.h>
 #include <asm/unwind_user.h>
 
-#ifndef ARCH_INIT_USER_FP_FRAME
- #define ARCH_INIT_USER_FP_FRAME
+#ifndef CONFIG_HAVE_UNWIND_USER_FP
+
+#define ARCH_INIT_USER_FP_FRAME(ws)
+
+#endif
+
+#ifndef ARCH_INIT_USER_FP_ENTRY_FRAME
+#define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)
+#endif
+
+#ifndef unwind_user_at_function_start
+static inline bool unwind_user_at_function_start(struct pt_regs *regs)
+{
+	return false;
+}
+#define unwind_user_at_function_start unwind_user_at_function_start
 #endif
 
 int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries);
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index f81c36ab2861..fdb1001e3750 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -74,7 +74,6 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 
 static int unwind_user_next_fp(struct unwind_user_state *state)
 {
-#ifdef CONFIG_HAVE_UNWIND_USER_FP
 	struct pt_regs *regs = task_pt_regs(current);
 
 	if (state->topmost && unwind_user_at_function_start(regs)) {
@@ -88,9 +87,6 @@ static int unwind_user_next_fp(struct unwind_user_state *state)
 		ARCH_INIT_USER_FP_FRAME(state->ws)
 	};
 	return unwind_user_next_common(state, &fp_frame);
-#else
-	return -EINVAL;
-#endif
 }
 
 static int unwind_user_next_sframe(struct unwind_user_state *state)
-- 
2.51.0


