Return-Path: <bpf+bounces-62944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BBDB008EF
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 18:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2951F4A0E51
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 16:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B932F271F;
	Thu, 10 Jul 2025 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MdOEuyXR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4002F002D;
	Thu, 10 Jul 2025 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165362; cv=none; b=VhPd7K3uKLgRzxsGvcb2R+zfrLfKaJHZU2AcCjvt4S+JnQ0l1bqHP7gq2cVGbMW2XdvfO9kdHKpvCBhUnFZBLoB9Umq1DWSzEywu1SgsaM0v9ZwJFZ6m4H6HS315DzzbLjOiY1fasoQGy2QTFy6uPMVFF8JUsieW5b0iARwY71E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165362; c=relaxed/simple;
	bh=enTOsuCqjALpapvYJ9I7QkN0U6oAXy2MiVcKV5e8ivY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2gUi0DT6jQ04u2g00pkY0PCU8zE0Ao8R7Rq3TvdNo0Bjb68gR5CyhR/RV4cpnFSxz0ERkDc2RXlE7XCU+p9zx1abaB1IacLyM2P/MIB6dxs3zvZK6DPUPvxu790eNrbQ+7GA7pSii+nnLnVSGwwdgAGpq2/6qdcyIbnsB6rIJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MdOEuyXR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AB7Aks023830;
	Thu, 10 Jul 2025 16:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mWM+yaAd4FMlrFJ91
	xRDMXfu+Sdz7jbSI0RwWQTtlr0=; b=MdOEuyXRp9KX/yA2bWS0zkivYONWTZPEC
	xw3hlK3JA1bR/CgI1XvQXQPOxUpTZGN2O2gdr6mco2pcK5pfUQm0tCE08101z6C5
	5SF1AJcPhmYxTBgwHoI6Ol4ILRVcpwccp/ABNclRtzKN37Qk8IMbax0THuQCjCmJ
	CatK9/19MeoaBWl5ZerlfC0+0b7+QDgOzE4TCWqCweNvuAGTAbslIGxw+3TGujWb
	HVYSs9R6rPt3945e7SCH50zh/WnvNVTd+007cbpGsAzN5vy2sVSdg+SHxUeIJ9Vi
	FgD4Uq47ztH0UcNJ+aOUxkwDWHRW2bIR7bpwbZyC+CbH0gaYehKpw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ptjrd3bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56AEGXmY025623;
	Thu, 10 Jul 2025 16:35:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfcpek07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:31 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56AGZRR135062190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:35:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9003120043;
	Thu, 10 Jul 2025 16:35:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 529102004B;
	Thu, 10 Jul 2025 16:35:27 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Jul 2025 16:35:27 +0000 (GMT)
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
Subject: [RFC PATCH v1 12/16] unwind_user/backchain: Introduce back chain user space unwinding
Date: Thu, 10 Jul 2025 18:35:18 +0200
Message-ID: <20250710163522.3195293-13-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=GL8IEvNK c=1 sm=1 tr=0 ts=686febd4 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=lmyv6DA6xqyH8GGdWh0A:9
X-Proofpoint-ORIG-GUID: ndzDO_VFZBLUlab7uuKnHmlevyGHUr6q
X-Proofpoint-GUID: ndzDO_VFZBLUlab7uuKnHmlevyGHUr6q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzOSBTYWx0ZWRfX79q1kXPe/vot zFjaFFocjr8DJBMJ52xxFHDOPbuU4oBNL9C5lrxtXW35UfVy9kdJunJqPVM190eWPBfxMk6mEez c/LpmIYe4thdQRR+jgIBYtRgYqbIYr5TShe1XAV9itjO7Pgvbxei9r/EVe/xLsQIlqq+JzUD6Fc
 UkqywUS/GH7NgAicncOKZavvGdWZsPXu8ywRWE5elZr+mJxi6SUvGa1As8VC9hqTbKeZDB0gyLf IqMFXv42XkEGsYl+/OtPmep6GJcRaqXCn6/PGwkmWb6NBASAVWs7pNH4rWjtgABzlheH8aqOgWG oBFANsSjJwKzXcYPJhKjsZFxV042aCYS/dMINfShlIBxL5gTatOC1JqEufH+DLhMGGI7pbUDZi9
 Dh2Il8jUJFl03EUbuOMJWFimGdT+FIJ5HemFUk0s2R8QScftgsFN1v4lK0dXo4XwiEMC3BCV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100139

Add support for unwinding of user space using back chain to the
unwind user interface.  Use it as secondary fallback for unwinding
using SFrame, if that fails and the primary fallback using frame
pointer is not available.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 arch/Kconfig                          |  6 ++++++
 include/linux/unwind_user_backchain.h | 17 +++++++++++++++++
 include/linux/unwind_user_types.h     |  1 +
 kernel/unwind/Makefile                |  1 +
 kernel/unwind/user.c                  | 24 +++++++++++++++++++++---
 kernel/unwind/user_backchain.c        | 13 +++++++++++++
 6 files changed, 59 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/unwind_user_backchain.h
 create mode 100644 kernel/unwind/user_backchain.c

diff --git a/arch/Kconfig b/arch/Kconfig
index 9e28dffe42cb..4fe16ad6f053 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -438,6 +438,12 @@ config HAVE_HARDLOCKUP_DETECTOR_ARCH
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
index 000000000000..daae74c97c54
--- /dev/null
+++ b/include/linux/unwind_user_backchain.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_UNWIND_USER_BACKCHAIN_H
+#define _LINUX_UNWIND_USER_BACKCHAIN_H
+
+struct unwind_user_state;
+
+#ifdef CONFIG_HAVE_UNWIND_USER_BACKCHAIN
+
+extern int unwind_user_backchain_next(struct unwind_user_state *state);
+
+#else /* !CONFIG_HAVE_UNWIND_USER_BACKCHAIN */
+
+static inline int unwind_user_backchain_next(struct unwind_user_state *state) { return -EINVAL; }
+
+#endif /* !CONFIG_HAVE_UNWIND_USER_BACKCHAIN */
+
+#endif /* _LINUX_UNWIND_USER_BACKCHAIN_H */
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index 57fd16e314cf..41b1bc082cb1 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -14,6 +14,7 @@ enum unwind_user_type {
 	UNWIND_USER_TYPE_FP,
 	UNWIND_USER_TYPE_COMPAT_FP,
 	UNWIND_USER_TYPE_SFRAME,
+	UNWIND_USER_TYPE_BACKCHAIN,
 };
 
 struct unwind_stacktrace {
diff --git a/kernel/unwind/Makefile b/kernel/unwind/Makefile
index 146038165865..38cef261abcb 100644
--- a/kernel/unwind/Makefile
+++ b/kernel/unwind/Makefile
@@ -1,2 +1,3 @@
  obj-$(CONFIG_UNWIND_USER)		+= user.o deferred.o
+ obj-$(CONFIG_HAVE_UNWIND_USER_BACKCHAIN)	+= user_backchain.o
  obj-$(CONFIG_HAVE_UNWIND_USER_SFRAME)	+= sframe.o
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index ee00d39d2a8e..3c3f75bc146b 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -7,6 +7,7 @@
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/unwind_user.h>
+#include <linux/unwind_user_backchain.h>
 #include <linux/uaccess.h>
 #include <linux/sframe.h>
 
@@ -39,6 +40,12 @@ static inline bool sframe_state(struct unwind_user_state *state)
 	       state->type == UNWIND_USER_TYPE_SFRAME;
 }
 
+static inline bool backchain_state(struct unwind_user_state *state)
+{
+	return IS_ENABLED(CONFIG_HAVE_UNWIND_USER_BACKCHAIN) &&
+	       state->type == UNWIND_USER_TYPE_BACKCHAIN;
+}
+
 #define unwind_get_user_long(to, from, state)				\
 ({									\
 	int __ret;							\
@@ -66,12 +73,20 @@ static int unwind_user_next(struct unwind_user_state *state)
 		/* sframe expects the frame to be local storage */
 		frame = &_frame;
 		if (sframe_find(state->ip, frame, topmost)) {
-			if (!IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
-				goto done;
-			frame = &fp_frame;
+			if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP)) {
+				frame = &fp_frame;
+			} else if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_BACKCHAIN)) {
+				if (unwind_user_backchain_next(state))
+					goto done;
+				goto done_backchain;
+			}
 		}
 	} else if (fp_state(state)) {
 		frame = &fp_frame;
+	} else if (backchain_state(state)) {
+		if (unwind_user_backchain_next(state))
+			goto done;
+		goto done_backchain;
 	} else {
 		goto done;
 	}
@@ -153,6 +168,7 @@ static int unwind_user_next(struct unwind_user_state *state)
 
 	arch_unwind_user_next(state);
 
+done_backchain:
 	state->topmost = false;
 	return 0;
 
@@ -178,6 +194,8 @@ static int unwind_user_start(struct unwind_user_state *state)
 		state->type = UNWIND_USER_TYPE_SFRAME;
 	else if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
 		state->type = UNWIND_USER_TYPE_FP;
+	else if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_BACKCHAIN))
+		state->type = UNWIND_USER_TYPE_BACKCHAIN;
 	else
 		state->type = UNWIND_USER_TYPE_NONE;
 
diff --git a/kernel/unwind/user_backchain.c b/kernel/unwind/user_backchain.c
new file mode 100644
index 000000000000..5b60a3d4f34f
--- /dev/null
+++ b/kernel/unwind/user_backchain.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt)	"backchain: " fmt
+
+#include <linux/sched.h>
+#include <linux/unwind_user.h>
+#include <linux/unwind_user_backchain.h>
+#include <asm/unwind_user_backchain.h>
+
+int unwind_user_backchain_next(struct unwind_user_state *state)
+{
+	return arch_unwind_user_backchain_next(state);
+}
-- 
2.48.1


