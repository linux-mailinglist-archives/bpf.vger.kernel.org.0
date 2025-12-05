Return-Path: <bpf+bounces-76156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3C8CA8898
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 18:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A532830164D9
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 17:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B30634F466;
	Fri,  5 Dec 2025 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G3hxER3X"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370A3346E75;
	Fri,  5 Dec 2025 17:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954936; cv=none; b=u17tew6zg7Mn0i6hQZIkqZ+0Cg77Dm5MkW0xCh7QvDTHOOSx5B9tM6PpywHQW2qi37k8gGFDczj2tiw5VST8KsjjRuCXDgBcXMo7BYoRbpc2ltLG3r5RMagpd/obyoGEsixDsP9TVSfNTlRFh0XdCVRnDtoFV0aYj0DZrdSKk6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954936; c=relaxed/simple;
	bh=06Jr8CXrnJ/jznLO5pfyGkCwQ+wJ2K+YghNV5NW6oLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/OJMRNhuVd81tqLsk51U+BV8J6Jjr7AaaM02xApk13F3gtD0r1CEmbZnlTjdxsOUoevoHKKzyY9IF9xKdQghGePVBdIg3mgtpAgNBfm5sdS2x7NvVnhinL2AxYuf0zWTSHOYrXHuyZlMcvu5ukM4SLOquQ9Vc55+eJtBg0p+yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G3hxER3X; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5BTO8v031345;
	Fri, 5 Dec 2025 17:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=l33Ta/FL4DYsJtSLL
	UG7m8ggvE9nAmSPbGGN3CmJWKg=; b=G3hxER3XPR+gFgpxkGHaLqVYU2n4kFP/E
	fQVUXwz+d364om4zkPv2W8MrIkVKWywAqZ+2u3TbRdiUQg109jGFoYJyL+XapsVH
	h7YeA8ma2Gi9Gp4uznPtzGfhjE92KVRWa/+xUrUCYWAJdATJsE3y2rDjKIh1VUXZ
	zQ/u+h9B+jbEZXareIgnLb68+lgxCeK1rHVbhvbU7LzUNMWJRaSGCR21n1MbHT7R
	o0Vbks4PDtF/semn+YMfUbuwq5Zea5mjJf2THHsl3AIV71TgiUEJn+zuhbwwSL8H
	H5CazufHoEwe+o/1dHR4f+y3ncEU9bAACl6YXchImERyv4VFUsBqA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8qeb4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:54 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B5HBdjp010497;
	Fri, 5 Dec 2025 17:14:54 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8qeb48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5H4dmt024120;
	Fri, 5 Dec 2025 17:14:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4arb5sxh4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:53 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B5HEnUh35586342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Dec 2025 17:14:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83DC220040;
	Fri,  5 Dec 2025 17:14:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42C5F2004E;
	Fri,  5 Dec 2025 17:14:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Dec 2025 17:14:49 +0000 (GMT)
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
Subject: [RFC PATCH v2 03/15] x86/unwind_user: Guard unwind_user_word_size() by UNWIND_USER
Date: Fri,  5 Dec 2025 18:14:34 +0100
Message-ID: <20251205171446.2814872-4-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwMCBTYWx0ZWRfX+CoUFGjSlwXk
 joFnVdTeWshW9rXTEihZccWMSOKu6s2xdgqILlHjs2xHoWfcthKv20EWzi2Zs0p4xikoJrP/FOl
 rF5QeZvmJLVIns/se7KOu3OwyV4S2jstDj8NwhZurQo72Vq/QQdmLsCwZlFhEZjvSwksNCOItH6
 uXTg3oWFHns7HpF4iSyv5J6onmhtxVLmbMMFIhp9bdjwPzfizrXV0mZpQ8/fBwPpP4dNvNEjkh2
 ojRB7TzjgiA5MaL9WperSFtK4jHqNBEajWMIN8bxvyrm3UKi+wGV+bXdd4SSUSQMsy/jABe+4Dg
 VzqWQ7CyAdZKS4J4wrmYJTl6WvKLW0ARz9Mvc2Z3dGwrsEO1fdsW58ICUd47aFD9RgztnDgoMHs
 8EGHKUusFtJCbq03r5ey1nX5D/Nppw==
X-Authority-Analysis: v=2.4 cv=dIerWeZb c=1 sm=1 tr=0 ts=6933130e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=eSOB7Jb69V3AKTYxoYUA:9
X-Proofpoint-ORIG-GUID: MdVGY6p8Cx-v6qCVRq06Rfklfz750NMV
X-Proofpoint-GUID: flsZe3_SW_hY4i2rhaHsPf0MRkxS-ute
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_06,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290000

The unwind user framework in general requires an architecture-specific
implementation of unwind_user_word_size() to be present for any unwind
method, whether that is fp or a future other method, such as potentially
sframe.

Guard unwind_user_word_size() by the availability of the UNWIND_USER
framework instead of the specific HAVE_UNWIND_USER_FP method.

This facilitates to selectively disable HAVE_UNWIND_USER_FP on x86
(e.g. for test purposes) once a new unwind method is added to unwind
user.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in v3:
    - Move includes into more common UNWIND_USER guard at the top of the
      source.  asm/ptrace.h is required for struct pt_regs.

 arch/x86/include/asm/unwind_user.h | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index a528eee80dd6..4d699e4954ed 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -2,11 +2,27 @@
 #ifndef _ASM_X86_UNWIND_USER_H
 #define _ASM_X86_UNWIND_USER_H
 
-#ifdef CONFIG_HAVE_UNWIND_USER_FP
+#ifdef CONFIG_UNWIND_USER
 
 #include <asm/ptrace.h>
 #include <asm/uprobes.h>
 
+static inline int unwind_user_word_size(struct pt_regs *regs)
+{
+	/* We can't unwind VM86 stacks */
+	if (regs->flags & X86_VM_MASK)
+		return 0;
+#ifdef CONFIG_X86_64
+	if (!user_64bit_mode(regs))
+		return sizeof(int);
+#endif
+	return sizeof(long);
+}
+
+#endif /* CONFIG_UNWIND_USER */
+
+#ifdef CONFIG_HAVE_UNWIND_USER_FP
+
 #define ARCH_INIT_USER_FP_FRAME(ws)			\
 	.cfa_off	=  2*(ws),			\
 	.ra_off		= -1*(ws),			\
@@ -21,18 +37,6 @@
 	.use_fp		= false,			\
 	.outermost	= false,
 
-static inline int unwind_user_word_size(struct pt_regs *regs)
-{
-	/* We can't unwind VM86 stacks */
-	if (regs->flags & X86_VM_MASK)
-		return 0;
-#ifdef CONFIG_X86_64
-	if (!user_64bit_mode(regs))
-		return sizeof(int);
-#endif
-	return sizeof(long);
-}
-
 static inline bool unwind_user_at_function_start(struct pt_regs *regs)
 {
 	return is_uprobe_at_func_entry(regs);
-- 
2.51.0


