Return-Path: <bpf+bounces-76162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 088A6CA897F
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 18:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C75D03026880
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 17:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6752350A11;
	Fri,  5 Dec 2025 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YZpw/alu"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE30934FF6F;
	Fri,  5 Dec 2025 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954945; cv=none; b=O0wyNWbArgrkQfqcZmIaC6EpDQ1mSLTU2XQVyVvuAzYrq3w7ca0SWoTi8n87r0gKsGxFLxnIEzfmRStlIR6UHCXAprYhESl/cjzo8AUDCIHzH++hk7Enp3MAJNU18ypORuMuaEVfKglcBJacwVKWlq0a2q4UdSzisQlBGzhb/p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954945; c=relaxed/simple;
	bh=EpVPiNSvNCIlBsoRFqWSixIr1ltDc1FtGXz6ucCai4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSaj0lWBmZJElpxhUfbiSW5WSMx2WSN/kkN3h9HcbDJq7ilI51SToxE+dBu2LalsVqSZJ4E/9FT5RFhlBWuSGktFfE4nkMn825RekQl8Yz1QSaiCZfBoXPPyyTwGVanIE4Uvo6g7GoWU5GoeaJInDuJWFQsZJ/2OeCfo6X1h/+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YZpw/alu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5FHjet027523;
	Fri, 5 Dec 2025 17:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/8a31K4Sd6aU33so4
	PMuO/2Yjkyh5Fe6LtDEMdSPIt8=; b=YZpw/aluxMHToNB5bTrOt3KvWBdsCLinm
	POInPKg4y7MoezHNM+/FLzG1eozEIdqWaVosUoRGK6pwylGW9iWaayFmrRCVwGTi
	2dSMcjIRTllCmoiLSoVBs2Kka8MPxGhwEpdaqkz0CrmjHNc0QaU9u3UalCQkIGUU
	c37SfyiAihtTFSd8D92ssCCzoishD856iXvEVGfdCvg72wyPtwdUs0bVFOoQVWdf
	WJBw7HhJ4SpIzYcXNYeEMs0M+QSEVMDcajDInoJfCHrrg2lPGPvrBnEjTxQv+5Wu
	WE3KvfHzTdOT6oOt4RKkKeEXvzJaE5W8NNKeQcWP7CUsFgSG/azAA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrja6v9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:57 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B5H7s4s019258;
	Fri, 5 Dec 2025 17:14:56 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrja6v9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5EkMV0019069;
	Fri, 5 Dec 2025 17:14:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arbhyeee1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:55 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B5HEp4x26214780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Dec 2025 17:14:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51C462005A;
	Fri,  5 Dec 2025 17:14:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09DEF2004E;
	Fri,  5 Dec 2025 17:14:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Dec 2025 17:14:50 +0000 (GMT)
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
Subject: [RFC PATCH v2 09/15] unwind_user: Enable archs that pass RA in a register
Date: Fri,  5 Dec 2025 18:14:40 +0100
Message-ID: <20251205171446.2814872-10-jremus@linux.ibm.com>
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
X-Proofpoint-GUID: 9qRHTvcCAPbtXjbEQLgo5bVv-5kMUubc
X-Proofpoint-ORIG-GUID: U2GWtFQuv6ABtv9_Fn_8oY7ag7CFbmVy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX/rgkUDUii6EV
 jzyF93REMD+9SlEZX9I7ug5mP1ZRYTeLEWsImp6Rz8Txjdmvv0cFrFY+ezt5MkVPvqeqwbI/R1/
 26dl0/zqR+Fya0gdE4jbj6kKOd2XS1M2TiSprY1TMw+scOnHvJHQDhLLp4aJ9PrijzELPHRZq/r
 hj8wdWFF59Y73FSNIf7yzFOnQyG0udl/FUipWJHNyc8HqRS4XiMtbT4mWqi2JXkC6fdtt13jbhS
 FXM0cUpM65vjQYgWcrGWFSHAwnXSjNcNfeX004gOQV6LjqYWTgSKW5+CwXkPkLmmE/zRBug4g10
 7ceAJbVYuo6tGDwnvI7LiPGcpBeHvEQPwXb5k0nE0RXqUCCc7KNRKvLiX7tcWu9ivsfSoHEj6Sj
 P4dhl5BH1X+gi0Ieo39TXIVg/AzMLA==
X-Authority-Analysis: v=2.4 cv=dYGNHHXe c=1 sm=1 tr=0 ts=69331311 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=BZmVhOMqpLk0IJKryeUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_06,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020

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


