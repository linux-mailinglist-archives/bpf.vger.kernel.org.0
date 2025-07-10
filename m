Return-Path: <bpf+bounces-62935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C0BB008DF
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 18:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B664B16BE7B
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 16:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7972EFDA2;
	Thu, 10 Jul 2025 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YLHh1Chu"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2D1271441;
	Thu, 10 Jul 2025 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165353; cv=none; b=m8srOcf273jIrgth3nZVIdTTg3mlXzHs1XzeA47oer4QMxwAtB1YQ8Sny+2W2bUhDGEWEBSatYcQgl0mr8Ml+S5tIx1w8MvjPCm7rKwmhoqu58HP2FVr8z8Vmo57YQ04b9NM6ysnKzvpCbGNhKz4faxTQG1oXkKQjIPPufqHrQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165353; c=relaxed/simple;
	bh=WeMe4aAFoj8CCDszqd7zTqOwo34LjyucoBCk9E/sNAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDRxU1NGvmDP3sLvkoto9T/Ki/F0EnptVq8RqoG3AcenY4CyL05fsNBJ3+r6vHntoDlOAmsl7w35AEjLtvawwq1o8yc+zloZdomB7vZrhT1rAudwKgU/h2YewDIghg5x5XxkCb+etkZuzfmEM1/hK+V4mTSFTEIxWEWoOCFURg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YLHh1Chu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ACJJav010221;
	Thu, 10 Jul 2025 16:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=a2QnHXfSjqiJcYDdg
	SLbDeTmwAq43ZDRI3vvdFCTwp8=; b=YLHh1ChufYeacNR0LblxBCU/PThYOBH8u
	imhtso02uTaZA8Mpeh9k355DJe76tMqMTgwcAUDLEtCsVsJ4rEECUXzo5UVkF3E3
	RC741d2bALqf5232cXqw2hefs7FAJy/DxpG/ieMUC8hHcT2KyX61NICNFujYwcLG
	PQMvfBwsuYEDX0olG4rUgwmSyTKa3W91EhlmmKPxiYzBTmRmIHbk4xw+54Le8EM+
	kiZDlnkVHEN3H+1IYc0ccZ0RaBe6cSeSFGFimprTO4bulr/Bg0kX0O/JqlS7Bjcs
	H/E0Ej3IG8m9NDvT3ZJZRA7WFYLwOZqbG+nJET6umdjS2FPhvaVvw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47svb26ate-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56AEdWPo003123;
	Thu, 10 Jul 2025 16:35:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfvmpenb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56AGZQSN13304230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:35:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B65020040;
	Thu, 10 Jul 2025 16:35:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9F5E2004E;
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
Subject: [RFC PATCH v1 07/16] unwind_user: Enable archs that do not necessarily save RA
Date: Thu, 10 Jul 2025 18:35:13 +0200
Message-ID: <20250710163522.3195293-8-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzOSBTYWx0ZWRfX1fZS5HfnoCKn covDhxdqgyesad77GoNAbsLf1DclPuRfgEHTX/rMgCd3FMzzYBKqlAItLiFmtU/50q3h9UgiK30 E8SWutf3k4txyxRNer1l38dJLamaB0kiKnddvJiQE0/Z1fgZDD0llZ8cpuOE/FykWh852HFIYH3
 3aGHC2LXmEKlUQz4o7Es5KITLWz4g5qVhKmq3ArnY3WmrYpYtsiGmDvio6ckhxAoumjHrQHtYl5 HVn9NfFYtI65vvfAfSP0/U0ZHu56xqrg8JhEAruTvDS9VU11EazxLQOjRViFXLRqgxAOY1bcnRF IC+g46pN2iJzoU6VtFegUeZgfGdjsApzcI0ku4z0tteKAvIG5YHjy4qriOJ4YSZgnSWJfOpjDgE
 mbf0pRFujsE9YXRmngshM5O9Ah85Z6XQxIygK24AR3w3E09vWByl6DtSLVexzos2SLmz81kH
X-Authority-Analysis: v=2.4 cv=Y774sgeN c=1 sm=1 tr=0 ts=686febd3 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=-JoFLTHXnnuQBJsBKZgA:9
X-Proofpoint-ORIG-GUID: FzkgWJBakICnhs7gazxtaS3x9RVSQtcu
X-Proofpoint-GUID: FzkgWJBakICnhs7gazxtaS3x9RVSQtcu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100139

Not all architectures have the return address (RA) in user space saved
on the stack on function entry, as x86-64 does due to its CALL
instruction pushing the RA onto the stack.  Architectures/ABIs, such as
s390, also do not necessarily enforce to save the RA in user space on
the stack in the function prologue or even at all, for instance in leaf
functions.

Treat a RA offset from CFA of zero as indication that the RA is not
saved on the stack.  In that case obtain the RA from the RA register.
Allow the SP to be unchanged in the topmost frame, for architectures
where SP at function entry == SP at call site.

Note that treating a RA offset from CFA of zero as indication that
the RA is not saved on the stack additionally allows for architectures,
such as s390, where the frame pointer (FP) may be saved without the RA
being saved as well.  Provided that such architectures represent this
in SFrame by encoding the "missing" RA offset using a padding RA offset
with a value of zero.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 arch/Kconfig                      |  5 +++++
 include/linux/ptrace.h            |  8 ++++++++
 include/linux/sframe.h            |  4 ++--
 include/linux/unwind_user_types.h |  1 +
 kernel/unwind/sframe.c            | 21 +++++++++++---------
 kernel/unwind/user.c              | 32 ++++++++++++++++++++++---------
 6 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 86eec85cb898..367eaf7e62e0 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -450,6 +450,11 @@ config HAVE_UNWIND_USER_SFRAME
 	bool
 	select UNWIND_USER
 
+config HAVE_USER_RA_REG
+	bool
+	help
+	  The arch passes the return address (RA) in user space in a register.
+
 config SFRAME_VALIDATION
 	bool "Enable .sframe section debugging"
 	depends on HAVE_UNWIND_USER_SFRAME
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 90507d4afcd6..a245c8586673 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -397,6 +397,14 @@ static inline void user_single_step_report(struct pt_regs *regs)
 #define exception_ip(x) instruction_pointer(x)
 #endif
 
+#ifndef user_return_address
+static inline unsigned long user_return_address(const struct pt_regs *regs)
+{
+	WARN_ON_ONCE(1);
+	return 0;
+}
+#endif
+
 extern int task_current_syscall(struct task_struct *target, struct syscall_info *info);
 
 extern void sigaction_compat_abi(struct k_sigaction *act, struct k_sigaction *oact);
diff --git a/include/linux/sframe.h b/include/linux/sframe.h
index b79c5ec09229..e3c6414f1a17 100644
--- a/include/linux/sframe.h
+++ b/include/linux/sframe.h
@@ -33,7 +33,7 @@ extern void sframe_free_mm(struct mm_struct *mm);
 extern int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
 			      unsigned long text_start, unsigned long text_end);
 extern int sframe_remove_section(unsigned long sframe_addr);
-extern int sframe_find(unsigned long ip, struct unwind_user_frame *frame);
+extern int sframe_find(unsigned long ip, struct unwind_user_frame *frame, bool topmost);
 
 static inline bool current_has_sframe(void)
 {
@@ -52,7 +52,7 @@ static inline int sframe_add_section(unsigned long sframe_start, unsigned long s
 	return -ENOSYS;
 }
 static inline int sframe_remove_section(unsigned long sframe_addr) { return -ENOSYS; }
-static inline int sframe_find(unsigned long ip, struct unwind_user_frame *frame) { return -ENOSYS; }
+static inline int sframe_find(unsigned long ip, struct unwind_user_frame *frame, bool topmost) { return -ENOSYS; }
 static inline bool current_has_sframe(void) { return false; }
 
 #endif /* CONFIG_HAVE_UNWIND_USER_SFRAME */
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index 8050a3237a03..adef01698bb3 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -35,6 +35,7 @@ struct unwind_user_state {
 	unsigned long fp;
 	struct arch_unwind_user_state arch;
 	enum unwind_user_type type;
+	bool topmost;
 	bool done;
 };
 
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index acbf791e713b..5bfaf06e6cd2 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -222,12 +222,8 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 	offset_count--;
 
 	ra_off = sec->ra_off;
-	if (!ra_off) {
-		if (!offset_count--) {
-			dbg_sec_uaccess("zero offset_count, can't find ra_off\n");
-			return -EFAULT;
-		}
-
+	if (!ra_off && offset_count) {
+		offset_count--;
 		UNSAFE_GET_USER_INC(ra_off, cur, offset_size, Efault);
 	}
 
@@ -257,7 +253,8 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 
 static __always_inline int __find_fre(struct sframe_section *sec,
 				      struct sframe_fde *fde, unsigned long ip,
-				      struct unwind_user_frame *frame)
+				      struct unwind_user_frame *frame,
+				      bool topmost)
 {
 	unsigned char fde_type = SFRAME_FUNC_FDE_TYPE(fde->info);
 	struct sframe_fre *fre, *prev_fre = NULL;
@@ -310,6 +307,12 @@ static __always_inline int __find_fre(struct sframe_section *sec,
 		return -EINVAL;
 	fre = prev_fre;
 
+	if ((!IS_ENABLED(CONFIG_HAVE_USER_RA_REG) || !topmost) && !fre->ra_off) {
+		dbg_sec_uaccess("fde addr 0x%x: zero ra_off\n",
+				fde->start_addr);
+		return -EINVAL;
+	}
+
 	frame->cfa_off = fre->cfa_off;
 	frame->ra_off  = fre->ra_off;
 	frame->fp_off  = fre->fp_off;
@@ -319,7 +322,7 @@ static __always_inline int __find_fre(struct sframe_section *sec,
 	return 0;
 }
 
-int sframe_find(unsigned long ip, struct unwind_user_frame *frame)
+int sframe_find(unsigned long ip, struct unwind_user_frame *frame, bool topmost)
 {
 	struct mm_struct *mm = current->mm;
 	struct sframe_section *sec;
@@ -343,7 +346,7 @@ int sframe_find(unsigned long ip, struct unwind_user_frame *frame)
 	if (ret)
 		goto end;
 
-	ret = __find_fre(sec, &fde, ip, frame);
+	ret = __find_fre(sec, &fde, ip, frame, topmost);
 end:
 	user_read_access_end();
 
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 45c8c6932ba6..03a6da36192f 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -3,6 +3,7 @@
 * Generic interfaces for unwinding user space
 */
 #include <linux/kernel.h>
+#include <linux/ptrace.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/unwind_user.h>
@@ -53,6 +54,7 @@ static int unwind_user_next(struct unwind_user_state *state)
 	struct unwind_user_frame *frame;
 	struct unwind_user_frame _frame;
 	unsigned long cfa = 0, sp, fp, ra = 0;
+	bool topmost = state->topmost;
 	unsigned int shift;
 
 	if (state->done)
@@ -63,7 +65,7 @@ static int unwind_user_next(struct unwind_user_state *state)
 	} else if (sframe_state(state)) {
 		/* sframe expects the frame to be local storage */
 		frame = &_frame;
-		if (sframe_find(state->ip, frame)) {
+		if (sframe_find(state->ip, frame, topmost)) {
 			if (!IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
 				goto done;
 			frame = &fp_frame;
@@ -86,18 +88,28 @@ static int unwind_user_next(struct unwind_user_state *state)
 
 	/* Get the Stack Pointer (SP) */
 	sp = cfa + frame->sp_val_off;
-	/* Make sure that stack is not going in wrong direction */
-	if (sp <= state->sp)
+	/*
+	 * Make sure that stack is not going in wrong direction.  Allow SP
+	 * to be unchanged for the topmost frame, by subtracting topmost,
+	 * which is either 0 or 1.
+	 */
+	if (sp <= state->sp - topmost)
 		goto done;
 
-	/* Make sure that the address is word aligned */
-	shift = sizeof(long) == 4 || compat_fp_state(state) ? 2 : 3;
-	if ((cfa + frame->ra_off) & ((1 << shift) - 1))
-		goto done;
 
 	/* Get the Return Address (RA) */
-	if (unwind_get_user_long(ra, cfa + frame->ra_off, state))
-		goto done;
+	if (frame->ra_off) {
+		/* Make sure that the address is word aligned */
+		shift = sizeof(long) == 4 || compat_fp_state(state) ? 2 : 3;
+		if ((cfa + frame->ra_off) & ((1 << shift) - 1))
+			goto done;
+		if (unwind_get_user_long(ra, cfa + frame->ra_off, state))
+			goto done;
+	} else {
+		if (!IS_ENABLED(CONFIG_HAVE_USER_RA_REG) || !topmost)
+			goto done;
+		ra = user_return_address(task_pt_regs(current));
+	}
 
 	/* Get the Frame Pointer (FP) */
 	if (frame->fp_off && unwind_get_user_long(fp, cfa + frame->fp_off, state))
@@ -110,6 +122,7 @@ static int unwind_user_next(struct unwind_user_state *state)
 
 	arch_unwind_user_next(state);
 
+	state->topmost = false;
 	return 0;
 
 done:
@@ -140,6 +153,7 @@ static int unwind_user_start(struct unwind_user_state *state)
 	state->ip = instruction_pointer(regs);
 	state->sp = user_stack_pointer(regs);
 	state->fp = frame_pointer(regs);
+	state->topmost = true;
 
 	arch_unwind_user_init(state, regs);
 
-- 
2.48.1


