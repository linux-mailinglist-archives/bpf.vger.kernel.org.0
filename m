Return-Path: <bpf+bounces-76312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A776CADE43
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 18:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B4E0306900C
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 17:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E0C31AAA0;
	Mon,  8 Dec 2025 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="klZgncRV"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569412FD1AA;
	Mon,  8 Dec 2025 17:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765214215; cv=none; b=B+7s4SG8hrYNuOrMeGd0M1psb2RIkLTwRDeq0wsnasmrBBaNDOGiHat/PcWcvDYn8upe6SZZcv2BTKOGfkM1Nn+aSDu5f0MjA25s6MV99gX70pLuolrOC34bc0DXXnBr7E1GZy9OBRk1Dxd067Xghq1ObDxSQIaLo9hp1FBf8aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765214215; c=relaxed/simple;
	bh=CBYWwPhaY1iwxtdGtRPdLf/cFhA6gKPwDozmMEtO9LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CEzN1DRztb6GmDRkqapqylKFX6WMkt4RUTtMEyzPcwTuoM6S6GJBVMym12x4/rHCX8jE2YWgs9hiuXE0x3BfH67EUUss1rngseEG3/LUnq2kti4xjyXeutv/V/Zlixy4ycOhm1K4NRMPCZsEMad/nxb7TOAbqPbWPxWDALrnnOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=klZgncRV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B87K4vH001965;
	Mon, 8 Dec 2025 17:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Is9hvdz9V94jWQl43
	gXIUwWjgv44GN5G0NJA7+epizk=; b=klZgncRVXj9spoDCb2KODK0ejOROtRrm5
	mVMxjAi/3/1lus51L06Kx7jBB1KJFzLAUxk2nCnbhPjFv8bmytCuEL6FbOzxZKbP
	7KJX6PqjL1pvb2i9YhXS/HMyqhx4uKkxsSEFJ4wQzRphsMyf9qsGJvsnGaq99kad
	4cApCzzfrereWOXY8f0mk9ALmIjLK10NZfmnidvOum7zvMp/Pe/4pZcvNliVzRXx
	EPboPiI4GulHIy4DIo+j0sAGz1SyvyegHYkHyqgBmn69NCnnDiPVKQ04GTCcbWXh
	q0TfPDbDtlYHWt7anIpCihAkcHZaKhLYl8EgUP7RQ9Ct5en1sxlrw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wvgqdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:13 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B8HGCHb004236;
	Mon, 8 Dec 2025 17:16:12 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wvgqd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8F47OS008405;
	Mon, 8 Dec 2025 17:16:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avytmpsqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:11 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B8HG7wR27328868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Dec 2025 17:16:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA5F920040;
	Mon,  8 Dec 2025 17:16:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 757E820043;
	Mon,  8 Dec 2025 17:16:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Dec 2025 17:16:07 +0000 (GMT)
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
Subject: [RFC PATCH v3 15/17] unwind_user: Introduce FP/RA location unknown
Date: Mon,  8 Dec 2025 18:15:57 +0100
Message-ID: <20251208171559.2029709-16-jremus@linux.ibm.com>
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
X-Proofpoint-GUID: uNlXY5QNiGGwz6lt_J9TG8FZ6ylYs_sN
X-Proofpoint-ORIG-GUID: RDMOrruizynQciRhfQY1yw-Zlgd8LGo7
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=693707dd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=LKvs_beuj216T3CeZrYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfX8Gm1LXFBCruJ
 YimzGLrqbDhnqsHkQ1AXY8xmda323ieBvm2yyq0/lVmOOmk4hVBxWnGOIcM3YVspMakAT3OO6vD
 N+Nv5sxtwWyBuQII1uDp8igsOSBu9lOV4Y7VT8q2RI0WDZ5FMFgegOrpROeB39aWHOZFeMyQfaZ
 AADfPssA1HqiNlYXEihkcqm4Fl95uORjRwoLo+2h9kH9wPRmCddq1Yk7l5gm4Cr7j4vfB9xS26+
 jdEdx7d/mBcbqMkK3M6UspzNN4rM0NrIVfrMDLhCoZDaE2dHac+yBPKp0ReDQZ7Kk1dY1uAnQFy
 YnP2/tu1k08WG08vboUPcfuD5rvZJt6P+ST/xkCS8do5vs92GdqrCBf9dRZLVkeit5B3LkTF4Fa
 QJlpVfFYFYsHDgQHG5r/BD6OlGK4Ug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000

Add support for an unwind user method to specify that the FP/RA location
is unknown.  For the frame pointer (FP) set the FP value to zero, so
that subsequent unwind next frame that rely on FP fail.  For the return
address (RA) treat as error.

This enables to implement support for unwinding of user space using back
chain on s390 with a subsequent commit, which can only unwind SP and RA,
but not FP.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in RFC v3:
    - New patch.  Prerequirement to implement unwind user fp using back
      chain on s390.

 include/linux/unwind_user_types.h | 1 +
 kernel/unwind/user.c              | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index 4f78999a0750..f44035b98f7c 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -28,6 +28,7 @@ struct unwind_stacktrace {
 };
 
 enum unwind_user_loc {
+	UNWIND_USER_LOC_UNKNOWN,
 	UNWIND_USER_LOC_RETAIN,
 	UNWIND_USER_LOC_STACK,
 	UNWIND_USER_LOC_REG,
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 45f82ed28fcb..7d06bdbc7f0d 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -93,6 +93,10 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 		if (!state->topmost || unwind_user_get_reg(&fp, frame->fp.regnum))
 			return -EINVAL;
 		break;
+	case UNWIND_USER_LOC_UNKNOWN:
+		/* FP cannot be unwound. Not an error. Set to zero. */
+		fp = 0;
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		return -EINVAL;
-- 
2.51.0


