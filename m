Return-Path: <bpf+bounces-75067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 998B9C6EF29
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 14:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 31EB04F9954
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 13:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26363590DB;
	Wed, 19 Nov 2025 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W/AtQm/x"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD4C357A35;
	Wed, 19 Nov 2025 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763558686; cv=none; b=RNHlo7plCuPgE0Rx3rTV9fDsH6dLl6oDsqvRi1c1QH9qvCY9z9qcNp5lKVgu3pDmYSCE+/iMJYK5Osw+A0ZryKcHj/FyXTfAq+A8TsH6g9WDixy4NEG75KEAcSz+JE12Jk16EYirHkhqCbzmRPJO/d8yAx5THSy+zdiO9n+5ZeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763558686; c=relaxed/simple;
	bh=ehnEsNjmaYKTG1i91mxJzOnXQHV9gZJT+zymSbYX2mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLDjMmezcfIzl2fR/Asb64vbpHbn/Mi4Ek80vAhgOc8sg0cXOcZFfLAwkcKRGMOT6kNN6PxwHQGwCJZyK5vSjiXn5qPQoa4yyadgqKry0H2/4BjCbAlh7Py6yvBZ7V66c0qGD/3Twgbm20w3uVjmmu2lvdU8A8Ka6jMIMrqNr68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W/AtQm/x; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ7TxP3008569;
	Wed, 19 Nov 2025 13:23:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Gd/En7iwq+orOI78s
	SjalZO4v8cMG0z6lQUsGCndBks=; b=W/AtQm/x0CeSpobe3cfwe6l+l9KT/V52i
	FloyKYtQLBZ+ae0i4Q8xvhgKfEjpNzuRsXHFnvvE7eVyVd178HihVyIA5MRDXYxb
	eochtSOKwqNRCPa9X7l0o9PoSH0O0o6SPay5+Vcar78NXdufXeGUXQh+F2hn5kik
	x60oEpJ7T5Vr8FGM1aeXM+FqWxn5CAZdJZGLrUuNvxVUyPLCHP7UniSEcQK1lzlV
	51ZMGxv1GHu+pr2vvjBIRUU5KUi5MadESEpTAi/NSF9+DaxpWByIgoRxhs8wOwGO
	JiGbU18NvzqXI3FpNyxgPtBSbKLcdhIKlBVF12i/ZxAgqvJeMkcvg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk1gmsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 13:23:37 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AJD9gUG032442;
	Wed, 19 Nov 2025 13:23:36 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk1gms8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 13:23:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJBwIP9005133;
	Wed, 19 Nov 2025 13:23:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af5bk8sq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 13:23:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AJDNVCA56361466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 13:23:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CEFF20040;
	Wed, 19 Nov 2025 13:23:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0F622004B;
	Wed, 19 Nov 2025 13:23:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Nov 2025 13:23:30 +0000 (GMT)
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
        Vasily Gorbik <gor@linux.ibm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH v12 09/13] unwind_user/sframe/x86: Enable sframe unwinding on x86
Date: Wed, 19 Nov 2025 14:23:19 +0100
Message-ID: <20251119132323.1281768-10-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=C/nkCAP+ c=1 sm=1 tr=0 ts=691dc4d9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=7d_E57ReAAAA:8
 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=mDV3o1hIAAAA:8 a=yMhMjlubAAAA:8
 a=VnNF1IyMAAAA:8 a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8 a=7mOBRU54AAAA:8
 a=meVymXHHAAAA:8 a=XwrCaFRetDY-CReCfHAA:9 a=jhqOcbufqs7Y1TYCrUUU:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=HkZW87K1Qel5hWWM3VKY:22 a=wa9RWnbW_A1YIeRBVszw:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-GUID: qS4Y8TTqC9FtlbsrfX7khCjnOJDgSrcu
X-Proofpoint-ORIG-GUID: 7cQs6Ns7nh84AK2Fbbv6PR_KlobWW15j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX2tkfdADBxKKl
 b0raGE/GJ1PpXLhanJS18QlqQ3Jm6BL2uUe5aNe1jYa8Bh1OwOCrpG4hkR8ykDzJll7vj/i+l0r
 XgFcCxDIoQ6sYJPfO4dboUws9KSBhN4+7ocrDqw1EV+L3v3+KXUC+bp9iyrIkbSEMkXUjlVposz
 HMgrMbVGGEuVFbaB2H2mk/KX6lvxADNTHckHj4tic4/UOfGd40JAKwVtq5+6ON5HRAk7t+r67uf
 cRBhBlqQL5i8WkkysOFrDB7cRec5d9GL98Y0Jzyy+tyWPdwlyhA/XSs8rPivNyorqyGqHFNWmzt
 +G4ZLA30jLJQyYbtD8A2yUtE5m7XYzDCd3ivWt31OGUHgYlqdm5HAw8BmZLrYUyVENexdGZMGAL
 p7RLyOIy2o+dNWEO8LoMtD6DJUda0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

From: Josh Poimboeuf <jpoimboe@kernel.org>

The x86 SFrame V2 implementation works fairly well, starting with
binutils 2.45 with PC-relative SFrame FDE function start address
encoding (though some issues are getting fixed in later versions).
Enable it.

[ Jens Remus: Reword commit message for SFrame V2 PC-relative FDE
function start address encoding, starting with binutils 2.45. ]

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
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in v12:
    - Reword commit message for SFrame V2 PC-relative FDE function start
      address encoding, starting with binutils 2.45.

 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c4c21e8d0772..0e9a9c5ca0bc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -299,6 +299,7 @@ config X86
 	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_UNWIND_USER_FP		if X86_64
+	select HAVE_UNWIND_USER_SFRAME		if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
 	select VDSO_GETRANDOM			if X86_64
-- 
2.48.1


