Return-Path: <bpf+bounces-71739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 621A9BFC9F3
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 16:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B7AE3356546
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 14:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952BB34C820;
	Wed, 22 Oct 2025 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oLJt0Qp3"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D04924728F;
	Wed, 22 Oct 2025 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144278; cv=none; b=U5pmhsSN5iM0rQ/arNkby1NQooX+EBgIgRy/uzOEo3zAUVCeCgwyeANnsPb7HcW1fuTi1/S1sMaGYuPiR4wWDEsIV/HAYL78X9sgOaBYF8HZZJNsBHA/8+9zyjCRC9YsHCGNP8s5Q4wbAmoxxWfHpDSXgjLayVoQBeRy8wLCkfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144278; c=relaxed/simple;
	bh=Y+SGpyAPAYT0m7UznzUW14rvp/2bqE0v+ziqL0oWck8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8HENy+9J22Jmdon4yMPLpMbVcTbBTuCx9Ai9r7iHoQqqCQbpndZqH9o1llSmDf412L+POma9jQYAZnv+msFxb4TW9MxLreB+ktXkPN22cJRG/OXrcnwvWqFK1/mehKDm22II9XCAc5BWeNdG5QVJgcRcUkKoygw340OERIaVE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oLJt0Qp3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M6U5qS028877;
	Wed, 22 Oct 2025 14:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gZDgkDOOw5nbm5xw1
	iPAGkFIssnW+cMSNoi3V1QctE8=; b=oLJt0Qp3vZoTjiG2gUUkuatI7j1wxAvCM
	6PQTRkS51wuo4V2STXW3QysG6Or7JQQuaO4RG9mJa8LfBPCd33t6j5dk0DuIEWKA
	PwBgN4h1sDLUNTRug+pktKMyF++j2Y7BWYDll2oJrSWsZj00ouC+mMIFkyrRO3Rz
	C8gXm30gQv4ZNMMtFfnvvSAvpA3HhIUYjsHm7eWMC6mxyHWW4auhQ2Nct3SLPLDn
	xWqKQjqXqv68VsMMUUz0smGBpsuMB/j2W99HDh1wHA5duERv4hdE+N2jXgFJhqxD
	zV5XylIHUTMvUqC8OyK97YSm0RlVSpS5TYbiH4ZGhtHgEfNuAvsGg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326w91q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 14:43:34 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59MEe2NL003565;
	Wed, 22 Oct 2025 14:43:34 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326w91k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 14:43:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MBbKpi002306;
	Wed, 22 Oct 2025 14:43:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejgnrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 14:43:32 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MEhTWL38142220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 14:43:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35F1B20040;
	Wed, 22 Oct 2025 14:43:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C490E2004E;
	Wed, 22 Oct 2025 14:43:28 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 14:43:28 +0000 (GMT)
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
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH v11 02/15] fixup! unwind_user/x86: Enable frame pointer unwinding on x86
Date: Wed, 22 Oct 2025 16:43:13 +0200
Message-ID: <20251022144326.4082059-3-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251022144326.4082059-1-jremus@linux.ibm.com>
References: <20251022144326.4082059-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68f8ed96 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=VnNF1IyMAAAA:8 a=EodaETWhB019NyyF3gAA:9 a=1CNFftbPRP8L7MoqJWF3:22
 a=DXsff8QfwkrTrK3sU8N1:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=bWyr8ysk75zN3GCy5bjg:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX0e7M9HHbi/Ac
 yXgYqV9qImq8zuLhOKbEd6GeVocaYzVK0ttCaML7f7/nYKSTj2VS3+z2r741Qq4G5SlxtyfxH69
 EIs3SyY/qbBwS+trucji5GaZ07jDw0Cp6bokiejvVD/nDWPZpi+6afYIIg9uapbEotJqNhXDYhK
 u9i7e5LiYzJ/JHpfi8pkCPfD0qf19fKgcZBO3qIRYjdaVIMnOIXfYQUvrn/eIQNGsSrZ5F0sBtE
 kGmt2EVdZYk0zmqyEQJ3hkyHLpR/LNExWpAS1mghNZNAy9uYkx48GDFCZK9X7bfhYIEpG+/iYiU
 hVYwrH7p6FShUybStFvhxuCnxug3NE7IJs3jnjPICh29j+ssoWZVArQg0S4twocd1V6eY+ifXij
 feL79YbOmhQE1prvqTpxmlZThzFqBg==
X-Proofpoint-GUID: NmoAHBvx6InKILozZL_2rsdLN-CEPWYt
X-Proofpoint-ORIG-GUID: ZxbIuIINCOGS6XvhKI4LBspJ5bo8Ej8P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    This fixup adjusts patch "[PATCH 12/12] unwind_user/x86: Enable frame
    pointer unwinding on x86" [1] to my preceding fixup, which limits the
    down-/upscaling by word size to unwind user (compat) fp.
    
    [1]: https://lore.kernel.org/lkml/20250924080119.613695709@infradead.org/

 arch/x86/include/asm/unwind_user.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index e649b8fea2aa..5e0755ea3086 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -2,10 +2,10 @@
 #ifndef _ASM_X86_UNWIND_USER_H
 #define _ASM_X86_UNWIND_USER_H
 
-#define ARCH_INIT_USER_FP_FRAME				\
-	.cfa_off	=  2,				\
-	.ra_off		= -1,				\
-	.fp_off		= -2,				\
+#define ARCH_INIT_USER_FP_FRAME(ws)			\
+	.cfa_off	=  2*(ws),			\
+	.ra_off		= -1*(ws),			\
+	.fp_off		= -2*(ws),			\
 	.use_fp		= true,
 
 #endif /* _ASM_X86_UNWIND_USER_H */
-- 
2.48.1


