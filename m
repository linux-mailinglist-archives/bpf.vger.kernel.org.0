Return-Path: <bpf+bounces-76158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F7ACA8916
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 18:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B4483026226
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 17:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312CE350A07;
	Fri,  5 Dec 2025 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="skrD2u9q"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AD534EF17;
	Fri,  5 Dec 2025 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954942; cv=none; b=jUGaDlVQyFjQuP41RR8RvZUKhy2jFjC/EKV7eauLy3cjeGPKVRsHU7d/srx+qJ/xrGxxWahsCi1ipYl5/MOP15S+eNRiWw47xd2LslTYSUpRAknPGLhXHE96ZyjB2BSCD/INVzGiBT/ge2f2221NebcbBjkHq/ZzDn/KDgivKbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954942; c=relaxed/simple;
	bh=p68FIoQo9rVwaiDJGwEyYg2Lz3jb4QhHYIY++aIx2F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dx65dA7TXgwKoP9aGNtY+rp17vwKroo+p8aspUSodBlLgR6Ru03CH+hWWsUNmwIrrFognk2pnlTbBtXxo9IDrLSgCzOwkG9WCEyHU+HiBfbjJgoZdbTvyHlMz/Xh+Re6bV3a9A9t4y6vtFREK1nEvCrX/VA1FZGNHvsOHtEf8nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=skrD2u9q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5APLlY002616;
	Fri, 5 Dec 2025 17:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WKEhc0G/ZxtbDpXxD
	ai3PIhO6YPs7nOrhP98G6G1AL8=; b=skrD2u9qZqRJQLCz3y2xm1lyFvJ6KxeNC
	9F7SztGNyTdyWYM0hC+sCPdui0hlg14OytxSQIqYyQ61fC9/cgSTsUObYlWJKjp4
	9Vfc8rnxXLhy0z8vUPTRdeRXL/aKYhJvHYQyFYz6RqtXpC87IiUviTsQQTdHPl/d
	KYr5XH0CMuqFkP0cUf0y8yXJ7jnMW0uohm1IbtSOrZpm2Li3RhIqyzizefT7l1E/
	VL+/UJQlC7NHMnY1uuXMcBtKKN1PBuoZD4c3G40gJNaGBGicRiVG9NX28UohJBTa
	9eSuY3+GYIbgk5ivcNCT1DE8vLliIMdOfsz62CV1jpNd8dbtYYB5A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrh7ey3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:58 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B5HER9D019391;
	Fri, 5 Dec 2025 17:14:57 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrh7ey3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5Fi89t021859;
	Fri, 5 Dec 2025 17:14:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4at8c6qj4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:55 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B5HEquN39322058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Dec 2025 17:14:52 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7BB32004B;
	Fri,  5 Dec 2025 17:14:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5E502004F;
	Fri,  5 Dec 2025 17:14:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Dec 2025 17:14:51 +0000 (GMT)
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
Subject: [RFC PATCH v2 11/15] unwind_user/sframe: Enable archs with encoded SFrame CFA offsets
Date: Fri,  5 Dec 2025 18:14:42 +0100
Message-ID: <20251205171446.2814872-12-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=dK+rWeZb c=1 sm=1 tr=0 ts=69331312 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=Og4hOgGxDI197znzLmcA:9
X-Proofpoint-GUID: RMRN7OWk_9MJjrE7cvf-IghfKu4EUnjs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX8e5OEzpFdqo4
 dWPGEpHWigiCCgflh72YgXiQlzkiOEkzmCQTIc8Y1QSdIZH+G3IwJbJNeOl2XcS3g/DKHI7yl1f
 Nc5qJLNjT/lHweNoQip2b++RKBx95tilPe2PWZcCH8b+Tsa8jhqlq7c3JmMUarYgizvYBVBqCv4
 TwKMZb8MqQiMGWMXZvwGJpTV8wJOPFLuVBD1yQm5fdzpMgRpYkSLdab1EOVxsYQvalQU1bfCR9M
 eHOQ6eKmI2c5X3yLl7pinqzg/QH6PCjw2k+3HO3SExJCM+mt7JGFKhszEHyFoWEjICJpjB5tq6i
 goCilaBSIHP8QDsvlxxG9G5Bj9OomRalOKjxipl18O6osy6cyEcfD7qYACcF7R+jKtb6qNIZrJI
 hyu9UfhXWgh0XQqGuMwJiZTlOJebGQ==
X-Proofpoint-ORIG-GUID: qLY2n_RsK3nXmW4HSI7Ir3EJHqpPCDgK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_06,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020

Enable architectures, such as s390, which store SFrame CFA offset values
encoded, to e.g. make (better) use of unsigned 8-bit SFrame offsets.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in RFC v2:
    - Rename generic_sframe_cfa_offset_decode() to
      sframe_cfa_offset_decode(). (Josh)

 include/asm-generic/unwind_user_sframe.h | 8 ++++++++
 kernel/unwind/sframe.c                   | 1 +
 2 files changed, 9 insertions(+)

diff --git a/include/asm-generic/unwind_user_sframe.h b/include/asm-generic/unwind_user_sframe.h
index 163961ca5252..80ae9bfaa88d 100644
--- a/include/asm-generic/unwind_user_sframe.h
+++ b/include/asm-generic/unwind_user_sframe.h
@@ -10,6 +10,14 @@
 #define SFRAME_SP_OFFSET 0
 #endif
 
+#ifndef sframe_cfa_offset_decode
+static inline s32 sframe_cfa_offset_decode(s32 offset)
+{
+	return offset;
+}
+#define sframe_cfa_offset_decode sframe_cfa_offset_decode
+#endif
+
 #ifndef sframe_init_reginfo
 static inline void
 sframe_init_reginfo(struct unwind_user_reginfo *reginfo, s32 offset)
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 45cd7380ac38..92f770fc21f6 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -226,6 +226,7 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 
 	UNSAFE_GET_USER_INC(cfa_off, cur, offset_size, Efault);
 	offset_count--;
+	cfa_off = sframe_cfa_offset_decode(cfa_off);
 
 	ra_off = sec->ra_off;
 	if (!ra_off && offset_count) {
-- 
2.51.0


