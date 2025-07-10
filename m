Return-Path: <bpf+bounces-62936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECF4B008E3
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 18:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934DD188FBBA
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 16:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F712EFDB2;
	Thu, 10 Jul 2025 16:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nvBJayk6"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0AF27467F;
	Thu, 10 Jul 2025 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165353; cv=none; b=BylLYRPz3H69ByYwH6mYPfoxvwVBecqpEkJdyrjJ+pR+TjI99ZVKE8DVIK9e1tGjL9ZA80ZPuSpTBavq+9vbPiYXf8kplElL5vn3ENnIx4nojpPMhrtvbRjJ5Bpgx2vxpZDUFZ2UH3DX+oTEtaOIPk0Ol+5bsdO7+z/z6mQrZEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165353; c=relaxed/simple;
	bh=YV0VSTJJjV0h9e42aBPXGTMpvmHUVB+yyBLnSmUVBvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxlnbkC75mDjkBPCbKeXScNvvMNO0962Rq61G/sLwy244dwSqdTJ1wyYMdzPpaAvZeFfZxzGbP6aZizfzg9c3DylZ3zQ4EMwg6racYKj4KXpqLvrnY/yLA89YhQvTznZPg7wEQBfwNByrSO6HSmSFgOy0o5EQFamw2V8NOk8k8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nvBJayk6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ACALZE008445;
	Thu, 10 Jul 2025 16:35:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fZXRz+KqG+SX1i5fb
	oP0I5c38GMmIS1nFUAT1eqLBQs=; b=nvBJayk6mzjB3EIU5Ok82j59OhGBqiSl6
	PuzNeNQvqf6TvsOBgRD1tXr2C0ybSb/BhKj0yEnH0lfWY7W2FpT4iVol8E1fcIzy
	Tdve2rFBh3reg+cx57eC1t0aRx5vHCsW/Vqph3BJ3/MQha12E7udc0sGx2i+zxfr
	ZkMB8ryFfANHCAq0kJitOcDI9GDWKB3N4pLLxvLNryIbOGLNXTarNBE3qLEoav9C
	cfVtnVwL/LC+EA79tz4Wl5zLf7Wl5iPo4igbQN+aibuVHUXspS7soTyr0eTeEMzd
	r7Z6fO/FC+UhIy+CEQmwuPoYX1oJ1StOM9V5GtecPjjgUOvfk/M9Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47svb26ata-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56AFkiMN024330;
	Thu, 10 Jul 2025 16:35:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qh32p8ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56AGZOhI53215676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:35:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D78F20043;
	Thu, 10 Jul 2025 16:35:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FF6E2004D;
	Thu, 10 Jul 2025 16:35:24 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Jul 2025 16:35:24 +0000 (GMT)
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
Subject: [RFC PATCH v1 01/16] fixup! unwind_user: Add frame pointer support
Date: Thu, 10 Jul 2025 18:35:07 +0200
Message-ID: <20250710163522.3195293-2-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzOSBTYWx0ZWRfX+3pElTM+YwPF mGcaPMLwi0geM6lWsra2Z6IHpDwdGBh4K0I1q8PESiP+RKE+3RJOLhN60cCJODBlnILond0o2so da/w4bB50b44/Nd8GPx6uWcR8jJY7YcU3MLkw4/8PwPujM/MGY9D2dvTWCyj709IEwgt6O2mscp
 qX7xgJWT2uvYz8azzYVx3BmS++BU1X7PGTeCqJ9XQbHfhdDTpXVRVgOdn0T8/ijxL77CpOCDn4O UfqjDVy0cnxeQhtzNZreHz/1WZWeWVjwInJfaRN1niyuBWTmYzffkE15nbk+8Fs+yK+/T2P0gz8 /L5u4d0tk5eC5B/XA7u4YjkDEjjXFH+G+0O8PeL9ksxEZUNh1EYmoT3YvY9SeuS/0K/I0nTtxst
 7WBa08o1/bZYDPfKYVAJm1XEZ02TWjGv20nXe7kocfgW4DkzQQv5s3+2bpBjomoYX2N+eFMk
X-Authority-Analysis: v=2.4 cv=Y774sgeN c=1 sm=1 tr=0 ts=686febd1 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=Wb1JkmetP80A:10 a=u97DrBQfMCEPXbZYdeQA:9
X-Proofpoint-ORIG-GUID: k_938dfeGE6hVkIM4mdgE6QD-cW4mW5t
X-Proofpoint-GUID: k_938dfeGE6hVkIM4mdgE6QD-cW4mW5t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100139

---
 kernel/unwind/user.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 6e7ca9f1293a..d0181c636c6b 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -74,6 +74,7 @@ static int unwind_user_next(struct unwind_user_state *state)
 		goto done;
 	}
 
+	/* Get the Canonical Frame Address (CFA) */
 	if (frame->use_fp) {
 		if (state->fp < state->sp)
 			goto done;
@@ -81,11 +82,9 @@ static int unwind_user_next(struct unwind_user_state *state)
 	} else {
 		cfa = state->sp;
 	}
-
-	/* Get the Canonical Frame Address (CFA) */
 	cfa += frame->cfa_off;
 
-	/* stack going in wrong direction? */
+	/* Make sure that stack is not going in wrong direction */
 	if (cfa <= state->sp)
 		goto done;
 
@@ -94,10 +93,11 @@ static int unwind_user_next(struct unwind_user_state *state)
 	if ((cfa + frame->ra_off) & ((1 << shift) - 1))
 		goto done;
 
-	/* Find the Return Address (RA) */
+	/* Get the Return Address (RA) */
 	if (unwind_get_user_long(ra, cfa + frame->ra_off, state))
 		goto done;
 
+	/* Get the Frame Pointer (FP) */
 	if (frame->fp_off && unwind_get_user_long(fp, cfa + frame->fp_off, state))
 		goto done;
 
-- 
2.48.1


