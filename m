Return-Path: <bpf+bounces-75066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A99C6EF1D
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 14:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA1844FD793
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 13:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7CC35C195;
	Wed, 19 Nov 2025 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SelcCS2Q"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD85359718;
	Wed, 19 Nov 2025 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763558679; cv=none; b=WuTWJXRe+G9TQ5tiUjPcOwVgcPaD2G/Cei1HIwM4SV6w59WWXpy/psBLcBfA888Cp9UeSSOU6+xBIUhDQnuxUDGE5OsYfoYVrEQV2St6VVoj9UCSlF6mcTagUM6CDpSQavdeo7SsiAA5jESC6HSrTnzj8pMsWsFOHFRQ4tPG1Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763558679; c=relaxed/simple;
	bh=apZVgnomkEKWMSLke0CJxFF7X6gXXfBnrgG8aI7U76I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVsnD8G7IDpDR6ewFqD9cCvblKFeNKaKguPf5Y4EpCcByQyI4J9HlZEvTvZ9D0SN+/2rimEeXi5+rpnvn/Uy8kSef8wZgr6F8+L7p8VfPOmO+r2bFskhQTd2N8BV3GWNM63PQxHHPww2ZmkFK2rJ/EVBJVbHwQ9kpPQDjwGf2c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SelcCS2Q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ8vQ9F007244;
	Wed, 19 Nov 2025 13:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nNJgzz0krS2ConCdQ
	K9UJQ5jnwsblOsZmcy5cf7ngeM=; b=SelcCS2QXtcy4T2YXRxklaNzxBG+FUbUX
	EzSOHCmCMJEPR7FPpMSrlz83nG8KrOIi0dwLoWwZcZr/47B5EYE44b+WMYSjR24N
	sl5OByx9FPbUHiLRGnKeJdlzwMeTXIDq3sdflz/Yi757w+1iweR3A20baiqMEQ9j
	2Ufapug5MPU3bmwokh85PGFjHBuEIO2FLZZsk/k7RIJpCB7Ya/1yMVgK5f6waorM
	2IZmW+Aoy7lhMOGvDKLqnrnvNd6xmDDYLIGrlpLVZ3fqOIf+gA89BFgzTS/xBYFp
	+9Z5AWPh7V8Moh2cBUjJwbZmTAlaVEMUwa69D+Ro7iwNRzks+i3+Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmsqtsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 13:23:35 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AJCsBP2015019;
	Wed, 19 Nov 2025 13:23:35 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmsqtsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 13:23:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJBBSND010411;
	Wed, 19 Nov 2025 13:23:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af3us8y4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 13:23:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AJDNUSq42860902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 13:23:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 234A020040;
	Wed, 19 Nov 2025 13:23:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99C812004B;
	Wed, 19 Nov 2025 13:23:29 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Nov 2025 13:23:29 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
        Steven Rostedt <rostedt@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
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
        Dylan Hatch <dylanbhatch@google.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH v12 07/13] unwind_user: Stop when reaching an outermost frame
Date: Wed, 19 Nov 2025 14:23:17 +0100
Message-ID: <20251119132323.1281768-8-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251119132323.1281768-1-jremus@linux.ibm.com>
References: <20251119132323.1281768-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qcKsCRgGdXJn90olzyaL8xuhTfECMnlM
X-Authority-Analysis: v=2.4 cv=Rv3I7SmK c=1 sm=1 tr=0 ts=691dc4d7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=7d_E57ReAAAA:8
 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=mDV3o1hIAAAA:8 a=yMhMjlubAAAA:8
 a=VnNF1IyMAAAA:8 a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8 a=7mOBRU54AAAA:8
 a=v_yGwNk4s_hqRJXMsLcA:9 a=jhqOcbufqs7Y1TYCrUUU:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=wa9RWnbW_A1YIeRBVszw:22
X-Proofpoint-GUID: XXj1-gbW4yNC1v_pD8J7P3UNYUWbpfnq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfXz3zsTnOl+jB+
 zCBFf+kNqKNjJX+xmlRzDaagdx2nQnia82+m3KR++R393gmQHhoIPVwKmDPl6hBE2zdiPySQ98E
 GzKbFSWVxv697GqXy4oQDZzwte54Eve9317fBBVll+NGDS0ZUqpb5LWfvVqEtATrnLf2zaSead0
 Jo1Hci0DOdiAA495vUtskLQqfp23MfHxeFu5Vl00354+SQTU+/6yngA+9L2iQedcMpUVE5hYeHS
 tiaHYYewxfU6JRnYtg5vdjc9vrYcEPRVf90X2DgifD7rzznfJlo11/ao4sqN4UAxH6vFdTiRSEL
 gujHEEonJma30KSzAdy2NXyP0o4s5669uHgmhDFoEYynabsYB5I9dUN+s6IQzKfTPntmfU+JvE2
 SPzWzcP4XqVO/5X3+tW/VKlkyX96dA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

Add an indication for an outermost frame to the unwind user frame
structure and stop unwinding when reaching an outermost frame.

This will be used by unwind user sframe, as SFrame may represent an
undefined return address as indication for an outermost frame.

Cc: Steven Rostedt <rostedt@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Indu Bhagat <indu.bhagat@oracle.com>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Jens Remus <jremus@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Sam James <sam@gentoo.org>
Cc: Kees Cook <kees@kernel.org>
Cc: "Carlos O'Donell" <codonell@redhat.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in v12:
    - Adjust to Peter's tip perf/core commit ae25884ad749 ("unwind_user/x86:
      Teach FP unwind about start of function").
    
    Changes in v11:
    - New patch.

 arch/x86/include/asm/unwind_user.h | 6 ++++--
 include/linux/unwind_user_types.h  | 1 +
 kernel/unwind/user.c               | 6 ++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index 12064284bc4e..f9a1c460150d 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -11,13 +11,15 @@
 	.cfa_off	=  2*(ws),			\
 	.ra_off		= -1*(ws),			\
 	.fp_off		= -2*(ws),			\
-	.use_fp		= true,
+	.use_fp		= true,				\
+	.outermost	= false,
 
 #define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)		\
 	.cfa_off	=  1*(ws),			\
 	.ra_off		= -1*(ws),			\
 	.fp_off		= 0,				\
-	.use_fp		= false,
+	.use_fp		= false,			\
+	.outermost	= false,
 
 static inline int unwind_user_word_size(struct pt_regs *regs)
 {
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index 43e4b160883f..616cc5ee4586 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -32,6 +32,7 @@ struct unwind_user_frame {
 	s32 ra_off;
 	s32 fp_off;
 	bool use_fp;
+	bool outermost;
 };
 
 struct unwind_user_state {
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 7644ab9f6a61..d053295b1f7e 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -32,6 +32,12 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 {
 	unsigned long cfa, fp, ra;
 
+	/* Stop unwinding when reaching an outermost frame. */
+	if (frame->outermost) {
+		state->done = true;
+		return 0;
+	}
+
 	if (frame->use_fp) {
 		if (state->fp < state->sp)
 			return -EINVAL;
-- 
2.48.1


