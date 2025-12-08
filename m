Return-Path: <bpf+bounces-76297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC948CADE07
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 18:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E8FF307ECD3
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 17:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100CC2FC88B;
	Mon,  8 Dec 2025 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="id62Ntmd"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19542FC004;
	Mon,  8 Dec 2025 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765214194; cv=none; b=olBpf0fCEJKfPRFfWYR7Sdl3zWBLxMvLpCxEfPUv6rwjJeOAfMRFhOg+RSxgphSDGyoWv0/ZkVc2fRGd0xsEbP2DoRho1xPJZJp+fFWwDY1iOEZ1DTgBmHyaCJ02bck2JTWBGNnNvMhU7+7crGqGFJBLSUPrl5ZnHNfso59xrYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765214194; c=relaxed/simple;
	bh=0a+eKf1KW5ejSSq4eH6CMbHXPiDRaoGF3QvlZM1SXQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ne/hwSRKTgWHd/Hg/Xac0zW1exrxweknQ3G2dJa40/j9fsc40zaovV55gfhy8MH8HDDq8MnE+sWQv5iml7evogJnPdiKw92rINdSkZflwFLjdX2jeen0aNWe8Iccn2ic5ypnpJIxtGmA91J4iMfwcuAyMFzzr1UNV42Cyi4njg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=id62Ntmd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8DdfXK008835;
	Mon, 8 Dec 2025 17:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=g8Yq2CEK016UerPQC
	n8BIpK5q3lUk06mi10es+UamvM=; b=id62NtmdPodUliCP/sSD8qO1LmwUyUP40
	ItUjtwrukphS9rO1FFu9ya8Mh5wFog2t08QxCyUlK6df0raMlQ1R3PCnZsDvQ4Gu
	UrNQUhtVGYTjh/LlePd8nzqTOqnW+2z/hN+XF0kFiUiZw/zDUx69pjNEBWvQwEee
	oa10W7O8Sj2bo1WS9UYILzw2RdTYZaMNECrIrgioZMYwE3q0JgWa/t1fknHywUth
	vEYlGSNCGbVm/I/y2vn0yeRNVLNFq3iv6TGxnLzsUau8CLA2QRAb6zDsqgPT1eoE
	BpHxyb/cz9KUa6JD3YBgYBvRLSOYF7G9opMvCuWvjAMwMr7iZX83w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc7brwes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:08 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B8HG7DA015085;
	Mon, 8 Dec 2025 17:16:07 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc7brwek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8Fc5Ul002034;
	Mon, 8 Dec 2025 17:16:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw11j6kfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:06 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B8HG2KH38732188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Dec 2025 17:16:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A23A2004B;
	Mon,  8 Dec 2025 17:16:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 301F92004F;
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
Subject: [RFC PATCH v3 01/17] unwind_user: Enhance comments on get CFA, FP, and RA
Date: Mon,  8 Dec 2025 18:15:43 +0100
Message-ID: <20251208171559.2029709-2-jremus@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 836EzP7j02oR7Nn1hmOTKSxy9wcs7saz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX3XXjmNR4+8Ph
 IDipJwDTUdbT7aVp1ckxCemV6aDjbXz45iPjHAcvmPSYpWUY9VaHMC4I92ehKxTGWYPEeSE/Qaq
 lCNsbWb/rY4OzUg5JlMMbEj8hr1Ek5rjmS/ByJ3IsWpJKbtXV6XnyuMKi9W0ek3P2lufGH+D8sJ
 UAR6VIO9DKTvLL33I8vlqSjZMaQdZSLBCtGQ/WQDDIrt8SEg3eYCo9wbB0VjMHQAwHy2scaDf/w
 AOcYXlyJE1urrFt7d3tCOUnMqATI0TKWAWJ0xWEgTirrzyAfFaPgPd1upuC3SqtdFdqMbZDe+NG
 OFX/Fy/uqOQ0EgYEEqzG0vnlySoJDeLvcZYkuBEW+1M0ZWQ4qnTr8v6zoMm6JkaMgdrYC0pnpyK
 9vMo+CRtWBytI9Sb1JFEDSOn9PviSg==
X-Proofpoint-GUID: al5qWv5wnkZzAVSaNhISX0IU_hPEI2OG
X-Authority-Analysis: v=2.4 cv=FpwIPmrq c=1 sm=1 tr=0 ts=693707d8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=GRZQj7fo7pb9Qcd1f_cA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020

Move the comment "Get the Canonical Frame Address (CFA)" to the top
of the sequence of statements that actually get the CFA.  Reword the
comment "Find the Return Address (RA)" to "Get ...", as the statements
actually get the RA.  Add a respective comment to the statements that
get the FP.  This will be useful once future commits extend the logic
to get the RA and FP.

While at it align the comment on the "stack going in wrong direction"
check to the following one on the "address is word aligned" check.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 kernel/unwind/user.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index d053295b1f7e..f81c36ab2861 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -38,6 +38,7 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 		return 0;
 	}
 
+	/* Get the Canonical Frame Address (CFA) */
 	if (frame->use_fp) {
 		if (state->fp < state->sp)
 			return -EINVAL;
@@ -45,11 +46,9 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 	} else {
 		cfa = state->sp;
 	}
-
-	/* Get the Canonical Frame Address (CFA) */
 	cfa += frame->cfa_off;
 
-	/* stack going in wrong direction? */
+	/* Make sure that stack is not going in wrong direction */
 	if (cfa <= state->sp)
 		return -EINVAL;
 
@@ -57,10 +56,11 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 	if (cfa & (state->ws - 1))
 		return -EINVAL;
 
-	/* Find the Return Address (RA) */
+	/* Get the Return Address (RA) */
 	if (get_user_word(&ra, cfa, frame->ra_off, state->ws))
 		return -EINVAL;
 
+	/* Get the Frame Pointer (FP) */
 	if (frame->fp_off && get_user_word(&fp, cfa, frame->fp_off, state->ws))
 		return -EINVAL;
 
-- 
2.51.0


