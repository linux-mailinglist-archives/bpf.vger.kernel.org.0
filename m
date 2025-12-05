Return-Path: <bpf+bounces-76149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CAACA8A53
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 18:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E4C0301F26D
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 17:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5518534D3AF;
	Fri,  5 Dec 2025 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IChS6yQl"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4723A34B421;
	Fri,  5 Dec 2025 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954931; cv=none; b=VXT7hxb+IhO3yF2piSB5Ek5dGbb7anFc+hxhHBe3AXiO9P37S6/uy4HvsGGZkEgvaRISd5UjJnj6VxI+G1tYc9r/3pg+xo/WOaefHknnGxCxlkQbQ3QRtr3Nmfh/rXNQ6QE/y9FYMSpn+/2FGBmN65rnt6lqhG9aw2yE5azSPUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954931; c=relaxed/simple;
	bh=/VJQUCllBAo6tp6f/f6h1Hk6REQ9vW1vQAVDzfgpAoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1dAqKXvobC6r0lWMs68TZA+mfoErB/g0MhcqvaMhY2StXKHkjQFYDXHqVqCNjDN3CBEJDVjsCWjfhbVukJPL6wJtgWarg7Q8W6MVtyIiyYzVgf4wxt+ZQEefUyDXJEhoVDplqLO3/UQBJ/Q3/9hf90+xndSekUO3bFzYPkdZbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IChS6yQl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5Cow1Z026058;
	Fri, 5 Dec 2025 17:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tey/Koe1GcsogZgDf
	jFfgSAa+ebExosUDctFg/uz4UE=; b=IChS6yQl2yoClr/IsAXI2sfvBXNCX4xpa
	OImj4cy8M6ACeRuR8S2c8iOTP8t/mr9X4U6+OosowzYyuA0aGVYNQWYtjKO6yJq5
	D6YtcHPil/xT4OBnrh2AXorPKM+igGWoAEnL4HBHWIa+J93RXQ27GikcemUFqSxq
	jFn6JuSK9ml48BY99/PId29v1wFzS4EucV4UB4I1hoaNPQgoMV7GM6+COANEkLae
	zbOfeCFn6bEpIxTsEmyg3ZEj/9AdSF8EXl8qRmNhXNzpy03K1YxqJmbuWcX4sHlh
	Mayk+wrnPbVO1URRPXotTqEPeB5iPbpyAfFPiPsK+wH1OUPLDvahA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrg5x3bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:58 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B5HA2th010239;
	Fri, 5 Dec 2025 17:14:57 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrg5x3bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5Ei63f019051;
	Fri, 5 Dec 2025 17:14:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arbhyeee4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:56 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B5HEqWR47644994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Dec 2025 17:14:53 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D20122004F;
	Fri,  5 Dec 2025 17:14:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D7F52004D;
	Fri,  5 Dec 2025 17:14:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Dec 2025 17:14:52 +0000 (GMT)
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
Subject: [RFC PATCH v2 14/15] unwind_user/backchain: Introduce back chain user space unwinding
Date: Fri,  5 Dec 2025 18:14:45 +0100
Message-ID: <20251205171446.2814872-15-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205171446.2814872-1-jremus@linux.ibm.com>
References: <20251205171446.2814872-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JaqfqyTfCNxe5xohRO4YaWy-3AnhamS8
X-Authority-Analysis: v=2.4 cv=Ir0Tsb/g c=1 sm=1 tr=0 ts=69331312 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=25eHwDaP0uuWkKgxUQEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX13Xq8lPYriId
 BH1uuecWESQQzPTrVMlLA6V2MyXUQLu56aHLK4YAlIIsdGu3/lL7Pk4mIbnefQlE97/8LkDqBBX
 oasqMjxGfYL83q9TgoBld3Z/mVZHmGnZ2ooiNNE02A2YdG1YRiO5G9hr+i/MQ7FDQCSya98cJbQ
 bx3zidYPv/M35MM8h/Mzg3k/I+OSssBOyu+O8y91+ws4ad/Deer2VPRFBMc16TFoS1UVGgDO7b2
 zEccVjyMxf3TCr3ZX5wKEXjBfd+JjR1abEKgdoJvRb7mXTrBa7KC18KlBAsfQyJTke4TOB0B9nr
 iXXfuptNHqRJJu3pqAvmrL/qnIuoO8DXIIi5NeCSDYi0mN0vPETMji+jyk2nAWBBmtkwqz7cAR0
 cnffLxWlQAe1dR+BWsc2DxFhUgeJ2g==
X-Proofpoint-GUID: qO5cVrGxnd_X6wR8EBS_oE09CUejmap_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_06,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290020

Add support for unwinding of user space using back chain to the
unwind user interface.  Use it as secondary fallback for unwinding
using SFrame, if that fails and the primary fallback using frame
pointer is not available.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in RFC v2:
    - Adjusted to latest unwind user enhancements.  Does hopefully no longer
      appear grafted on.

 arch/Kconfig                          |  6 ++++++
 include/linux/unwind_user_backchain.h | 20 ++++++++++++++++++++
 include/linux/unwind_user_types.h     |  2 ++
 kernel/unwind/user.c                  | 12 ++++++++++++
 4 files changed, 40 insertions(+)
 create mode 100644 include/linux/unwind_user_backchain.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 7fa89d70b244..37fb78a5e876 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -488,6 +488,12 @@ config AS_SFRAME
 config UNWIND_USER
 	bool
 
+config HAVE_UNWIND_USER_BACKCHAIN
+	bool
+	select UNWIND_USER
+	help
+	  The arch supports unwinding of user space using back chain.
+
 config HAVE_UNWIND_USER_FP
 	bool
 	select UNWIND_USER
diff --git a/include/linux/unwind_user_backchain.h b/include/linux/unwind_user_backchain.h
new file mode 100644
index 000000000000..e7a8e584b13f
--- /dev/null
+++ b/include/linux/unwind_user_backchain.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_UNWIND_USER_BACKCHAIN_H
+#define _LINUX_UNWIND_USER_BACKCHAIN_H
+
+struct unwind_user_state;
+
+#ifdef CONFIG_HAVE_UNWIND_USER_BACKCHAIN
+
+extern int arch_unwind_user_next_backchain(struct unwind_user_state *state);
+
+#else /* !CONFIG_HAVE_UNWIND_USER_BACKCHAIN */
+
+static inline int arch_unwind_user_next_backchain(struct unwind_user_state *state)
+{
+	return -EINVAL;
+}
+
+#endif /* !CONFIG_HAVE_UNWIND_USER_BACKCHAIN */
+
+#endif /* _LINUX_UNWIND_USER_BACKCHAIN_H */
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index 6efc12b6e831..b44502e90b7f 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -11,6 +11,7 @@
 enum unwind_user_type_bits {
 	UNWIND_USER_TYPE_SFRAME_BIT =		0,
 	UNWIND_USER_TYPE_FP_BIT =		1,
+	UNWIND_USER_TYPE_BACKCHAIN_BIT =	2,
 
 	NR_UNWIND_USER_TYPE_BITS,
 };
@@ -20,6 +21,7 @@ enum unwind_user_type {
 	UNWIND_USER_TYPE_NONE =			0,
 	UNWIND_USER_TYPE_SFRAME =		BIT(UNWIND_USER_TYPE_SFRAME_BIT),
 	UNWIND_USER_TYPE_FP =			BIT(UNWIND_USER_TYPE_FP_BIT),
+	UNWIND_USER_TYPE_BACKCHAIN =		BIT(UNWIND_USER_TYPE_BACKCHAIN_BIT),
 };
 
 struct unwind_stacktrace {
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 122045cb411f..5b4649bc91ba 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -6,6 +6,7 @@
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/unwind_user.h>
+#include <linux/unwind_user_backchain.h>
 #include <linux/uaccess.h>
 #include <linux/sframe.h>
 
@@ -105,6 +106,11 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 	return 0;
 }
 
+static int unwind_user_next_backchain(struct unwind_user_state *state)
+{
+	return arch_unwind_user_next_backchain(state);
+}
+
 static int unwind_user_next_fp(struct unwind_user_state *state)
 {
 	struct pt_regs *regs = task_pt_regs(current);
@@ -159,6 +165,10 @@ static int unwind_user_next(struct unwind_user_state *state)
 			if (!unwind_user_next_fp(state))
 				return 0;
 			continue;
+		case UNWIND_USER_TYPE_BACKCHAIN:
+			if (!unwind_user_next_backchain(state))
+				return 0;
+			continue;		/* Try next method. */
 		default:
 			WARN_ONCE(1, "Undefined unwind bit %d", bit);
 			break;
@@ -187,6 +197,8 @@ static int unwind_user_start(struct unwind_user_state *state)
 		state->available_types |= UNWIND_USER_TYPE_SFRAME;
 	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
 		state->available_types |= UNWIND_USER_TYPE_FP;
+	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_BACKCHAIN))
+		state->available_types |= UNWIND_USER_TYPE_BACKCHAIN;
 
 	state->ip = instruction_pointer(regs);
 	state->sp = user_stack_pointer(regs);
-- 
2.51.0


