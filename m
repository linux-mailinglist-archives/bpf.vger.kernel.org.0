Return-Path: <bpf+bounces-76298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E4ACADDAC
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 18:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDAB630210C5
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 17:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214142FCBE3;
	Mon,  8 Dec 2025 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ca0ivyB8"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18DA2FBE1D;
	Mon,  8 Dec 2025 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765214194; cv=none; b=H3v0NZxkzoJoYzd84lLHqGKkbVqkRTvhMLCwY0vlhmpPW53auzKppGyxgcYlIC3mXln65bGnecL/Xkm8orM8kZwS/9dSUe/I9AYCmwQG8kDwDoPGv8xbt1xLKQ7mTmd/51bJNKv49frjdOy4vd24u1MNTvRZJTwBgjBrFx2VCLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765214194; c=relaxed/simple;
	bh=EpVPiNSvNCIlBsoRFqWSixIr1ltDc1FtGXz6ucCai4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsAq1uI3iNsfHjVtJWPbgpRKLM2Hm+tFCMibNXC2S0LDfvMLgwi3Y05Cx2rvNH06XhPcDBoZnHc8m4DuF2ISLS79d1DMygDUGPDnYA0SMNx+knQL337PNzJhaC6O8Ax6Kdk9Fi34V4oiITdBzfKsL4dWQg51ob35w3ULD1JXr3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ca0ivyB8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B88at0P029441;
	Mon, 8 Dec 2025 17:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/8a31K4Sd6aU33so4
	PMuO/2Yjkyh5Fe6LtDEMdSPIt8=; b=ca0ivyB8gslfCdsBZEwPvMnLJDiJ1e7Qp
	srEAU1NsnverifuaG3lh0vasZupnrRnASYvPHM0MFt9/KHwXbiKe5O9zBdthWMnU
	MJIaEvBbp/x8cHve+jNGHXjACwlV/YaDLOZLS/6bKLfa61EmIAJ6jQHK0pLQyMA4
	sUGZ/YrS9LX1p+Rez3SyreAjPtxyfTBxEcXT2NVMvY6mJYctatMOXNia6yNFf+T3
	RYhsJNUMZrBUaaoyynNK6zRhyh/1Yg9zlOxuyz2cy1BV3wSWYPG13271i+Qs/B4H
	pWLU3Sp13HegE/cYzz1M2MjxvyjeAMZec0EUSggF1SpVZWwxcsrlg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc7brwf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:11 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B8GsLah002043;
	Mon, 8 Dec 2025 17:16:11 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc7brwf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8GDCbu026836;
	Mon, 8 Dec 2025 17:16:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw1h0xfm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:09 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B8HG6wT15008008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Dec 2025 17:16:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF1EA2004B;
	Mon,  8 Dec 2025 17:16:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AB6E2004D;
	Mon,  8 Dec 2025 17:16:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Dec 2025 17:16:05 +0000 (GMT)
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
Subject: [RFC PATCH v3 10/17] unwind_user: Enable archs that pass RA in a register
Date: Mon,  8 Dec 2025 18:15:52 +0100
Message-ID: <20251208171559.2029709-11-jremus@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: O9HwdPajTK_A1hw_Q9L19ZavOkfEj80s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX1+BycBNc2L9J
 8XAG9eVZQPdcEx8EHQp8t9IENKpStZARb+YkTBTBTM6GmD0SZt54SUnuHP9ySDgwSNF3RiKVoID
 DICp3UhiEoYrwrZjqYrecfUkZnMs0o4u8Iv/yqIfhUxM0a+lTQ3+B70Y4aqtOjGI9QuGbKZ/a7N
 gUb8FlSMe8UXj2TjOh6IKTaGklMSMslltRvI2tp0TE7FwI6O2vn48bT+7EAeBw8UZH2uuHLV0NZ
 mmu1H+7FIxBXW9rWMtf7qWZsPZPWlLh8L5xanYT1r6I9gU/KgIFflfG3rERPL+v4euoOxon2DYd
 JvJDnu6SaRHT00/2VSLza5fKxHmO/iAWViVJZbTT+8bqR7ISN2JasGxI828F5utid/g0PJrMst3
 6A70N61iam8/e53CDdgOpJXH3zbLcg==
X-Proofpoint-GUID: PZsy677Q8MzObUMsX78b8Eass-BCDuwu
X-Authority-Analysis: v=2.4 cv=FpwIPmrq c=1 sm=1 tr=0 ts=693707db cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=BZmVhOMqpLk0IJKryeUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020

Not all architectures have the return address (RA) in user space saved
on the stack on function entry, such as x86-64 does due to its CALL
instruction pushing the RA onto the stack.  Architectures/ABIs, such as
s390, also do not necessarily enforce to save the RA in user space on
the stack in the function prologue or even at all, for instance in leaf
functions.

Treat a RA offset from CFA of zero as indication that the RA is not
saved (on the stack).  For the topmost frame treat it as indication that
the RA is in the link/RA register, such as on arm64 and s390, and obtain
it from there.  For non-topmost frames treat it as error, as the RA must
be saved.

Additionally allow the SP to be unchanged in the topmost frame, for
architectures where SP at function entry == SP at call site, such as
arm64 and s390.

Note that treating a RA offset from CFA of zero as indication that
the RA is not saved on the stack additionally allows for architectures,
such as s390, where the frame pointer (FP) may be saved without the RA
being saved as well.  Provided that such architectures represent this
in SFrame by encoding the "missing" RA offset using a padding RA offset
with a value of zero.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in v2:
    - Reword commit subject and message.
    - Rename config option USER_RA_REG to UNWIND_USER_RA_REG and reword
      help text to mention both link and return address register. (Josh)
    - Move dummy user_return_address() from linux/ptrace.h to
      linux/unwind_user.h, rename to unwind_user_get_ra_reg(),
      return -EINVAL, and guard by !CONFIG_HAVE_UNWIND_USER_RA_REG. (Josh)
    - Do not check for !IS_ENABLED(CONFIG_HAVE_USER_RA_REG), as the dummy
      implementation of user_return_address() returns -EINVAL.
    - Drop config option USER_RA_REG / UNWIND_USER_RA_REG, as it is of
      no value any longer.
    - Drop topmost checks from unwind user sframe, as they are already
      done by unwind user. (Josh)

 include/linux/unwind_user.h |  9 +++++++++
 kernel/unwind/sframe.c      |  6 ++----
 kernel/unwind/user.c        | 17 +++++++++++++----
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
index 64618618febd..bc2edae39955 100644
--- a/include/linux/unwind_user.h
+++ b/include/linux/unwind_user.h
@@ -23,6 +23,15 @@ static inline bool unwind_user_at_function_start(struct pt_regs *regs)
 #define unwind_user_at_function_start unwind_user_at_function_start
 #endif
 
+#ifndef unwind_user_get_ra_reg
+static inline int unwind_user_get_ra_reg(unsigned long *val)
+{
+	WARN_ON_ONCE(1);
+	return -EINVAL;
+}
+#define unwind_user_get_ra_reg unwind_user_get_ra_reg
+#endif
+
 int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries);
 
 #endif /* _LINUX_UNWIND_USER_H */
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 7952b041dd23..38b3577f5253 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -228,10 +228,8 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 	offset_count--;
 
 	ra_off = sec->ra_off;
-	if (!ra_off) {
-		if (!offset_count--)
-			return -EFAULT;
-
+	if (!ra_off && offset_count) {
+		offset_count--;
 		UNSAFE_GET_USER_INC(ra_off, cur, offset_size, Efault);
 	}
 
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 6c75a7411871..58e1549cd9f4 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -50,16 +50,25 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 
 	/* Get the Stack Pointer (SP) */
 	sp = cfa + frame->sp_off;
-	/* Make sure that stack is not going in wrong direction */
-	if (sp <= state->sp)
+	/*
+	 * Make sure that stack is not going in wrong direction.  Allow SP
+	 * to be unchanged for the topmost frame, by subtracting topmost,
+	 * which is either 0 or 1.
+	 */
+	if (sp <= state->sp - state->topmost)
 		return -EINVAL;
 	/* Make sure that the address is word aligned */
 	if (sp & (state->ws - 1))
 		return -EINVAL;
 
 	/* Get the Return Address (RA) */
-	if (get_user_word(&ra, cfa, frame->ra_off, state->ws))
-		return -EINVAL;
+	if (frame->ra_off) {
+		if (get_user_word(&ra, cfa, frame->ra_off, state->ws))
+			return -EINVAL;
+	} else {
+		if (!state->topmost || unwind_user_get_ra_reg(&ra))
+			return -EINVAL;
+	}
 
 	/* Get the Frame Pointer (FP) */
 	if (frame->fp_off && get_user_word(&fp, cfa, frame->fp_off, state->ws))
-- 
2.51.0


