Return-Path: <bpf+bounces-76301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A168CADE28
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 18:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3372E3093CDD
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 17:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5762FC03F;
	Mon,  8 Dec 2025 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GbLBvCqH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424172FBE02;
	Mon,  8 Dec 2025 17:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765214195; cv=none; b=tUMOG85zphaQd/fK4HS96bHHOUvRrEO7pZqZdz+2w44z2aW6a+SU76o9Od2p6gg68UepKgtkVaVy1yALlReow4Un6jV5/YXpsfF+IB1Zgxm1LHxh4pqwPKsJdS4XeEUynqP6PS2n+XdkiDz/V93/b3ZtUMgRXrQnUPqx+gZvBAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765214195; c=relaxed/simple;
	bh=2b/4Jci+vOAtbEpjAcKcZIeHV/tFcGaQRN/CGJKQBFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNvxYwdjkzRE+2R3VayQg5ZUGTaNQVaGkWOM20tOTwbteMnR+okscbI0GlQEfzRkKPs/vno230PTsc91hm2AatViaDYuUYgjKnLyVyrH/HStuNkEvutHsnDzkqocdTeWMXoX4Xj9USWJ44jKlB2JE7LYU3Mxg9dz55qngkda6xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GbLBvCqH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B87xQ1S021763;
	Mon, 8 Dec 2025 17:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=e77aNzRcpfOdIx39c
	Kj7p6jnEbZCyc7Rf/QZ4cCnaZk=; b=GbLBvCqHgl5UQM0Z6v2wk4QXypO3CTCmM
	3wL1gvBU6A0vNyHIiRroreTz5tJVZH4JR5yxomGhDaWE7tOYQ34Bj699SJ6kth0N
	9rgVj3vfXwIv2xMfpZpfLppgCpQss3tH4RKL0WVFVey/r//w2BAg1nN/AX6npZ0V
	2WRIjm1Hf39N+mS3ccsj562ZJtI5yRNEbG2cf5xuzvx4rnpQ0B/eFIBi5SwLVHBv
	FjMmkTNJHuASCEGb83/18vJ7DZA1F5frgbbQ/XXtanUESwaeWhCFT4+0ps8VtsXD
	W+vx/voGtgJ6RBJqCH5tRo5Yg8tyP/ggg/l+iw+NSrNhdVR/EwJGQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc7brwf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:09 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B8HAajH003291;
	Mon, 8 Dec 2025 17:16:09 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc7brwey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8FY7lT012812;
	Mon, 8 Dec 2025 17:16:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aw0ajpp2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:07 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B8HG3t953281064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Dec 2025 17:16:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA27B20043;
	Mon,  8 Dec 2025 17:16:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 521392004D;
	Mon,  8 Dec 2025 17:16:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Dec 2025 17:16:03 +0000 (GMT)
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
Subject: [RFC PATCH v3 04/17] x86/unwind_user: Simplify unwind_user_word_size()
Date: Mon,  8 Dec 2025 18:15:46 +0100
Message-ID: <20251208171559.2029709-5-jremus@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: dViJuWBa4d1oueGWivO_K4JyBK6FHeeJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX4JhSPTgN0SMw
 FS2cMaJjmFXcqNg8/Bjhq2Xj+fnw/H0ShvHQsMNkS63oOoSZ3cn4HoZ8hxUDdqQrL4Uo4JnlslB
 SAIeKBpEICaKs4s5s8pTDFzhDC4pETZoDcHLVYIf7PgmKO0y3i3t2zntoYgaiJ6ObzXPakVg2sz
 ef2W4N8GhGnJwXItin7Qs6RlC5Pa2S9YuTevEiywsRNl7vBBUO6Mu5GBODIcdx/90uFD2VRsvsV
 i1oHhN49BQPn836U5hvHSeSHHaSxZt3w0qmNRqtX2vfDA7gaAjHvX5YrOp2xwAhUXfuxXbAd8M+
 AELEv5SW1rtdiNkM+TaHK54yhfyNKzxooVWobjBsHgPSeHTha+lbCeysBfwJN+Lcyag0wCiIhMu
 Gas4ynI6K9CrlcwNHf3Yg8POyTBvug==
X-Proofpoint-GUID: dKedLVKxgRZQI5PdQzGh_haMCrt-FvFD
X-Authority-Analysis: v=2.4 cv=FpwIPmrq c=1 sm=1 tr=0 ts=693707d9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z4Rwk6OoAAAA:8 a=VnNF1IyMAAAA:8
 a=UXUCOGqRO3hiuQW2F5cA:9 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020

Get rid of superfluous ifdef and return explicit word size depending on
32-bit or 64-bit mode.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 arch/x86/include/asm/unwind_user.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index 4d699e4954ed..2dfb5ef11e36 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -12,11 +12,7 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
 	/* We can't unwind VM86 stacks */
 	if (regs->flags & X86_VM_MASK)
 		return 0;
-#ifdef CONFIG_X86_64
-	if (!user_64bit_mode(regs))
-		return sizeof(int);
-#endif
-	return sizeof(long);
+	return user_64bit_mode(regs) ? 8 : 4;
 }
 
 #endif /* CONFIG_UNWIND_USER */
-- 
2.51.0


