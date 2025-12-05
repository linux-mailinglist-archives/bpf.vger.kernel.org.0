Return-Path: <bpf+bounces-76163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 78085CA89C9
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 18:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0FD43028553
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 17:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0F534FF5E;
	Fri,  5 Dec 2025 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L9xY8cik"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09132586C8;
	Fri,  5 Dec 2025 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954947; cv=none; b=ZC7OExJehzgRl9ebLClMw7rBI2Yty5tIXrPpqupDgZn39CwTGWwpIIZdcKGXWjPYmvX6kGHMpdl4XbQGpDxUcPEBUUCbgPht3GCwVAf05zXpHkgQJLqjruF2YjTHQUEyDFg48D0ij4KO4K+JySFeRNq5Eq39uX+qrTnzozlrd48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954947; c=relaxed/simple;
	bh=uTTzdrUeqQbjvXCuDlyz0FReyMWGuAsohw0+59rIUb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHgpyElKZuEdj4eLLYOIMa6KO8zha4sw9qZ5xDXSxe9fFXBow9BnbrEiOHtbeeCGQKoCNHJAoBjVTenSlQyma0Slihg9RGwLDJ+QbKwJeSGEpzLFArXRWf0sqKHF5eUiUjL0OxuANiDOLrNh2hQxs5tGkTJlfmXwEkZ83wzT7VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L9xY8cik; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5GW9h6008240;
	Fri, 5 Dec 2025 17:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QbfSqQzLjksgns1mI
	C3zXh+jcYNMEleD5cIrau6YfF0=; b=L9xY8cikd86K5+/GRgHS2HUKhGAexYG5a
	pbxey+B302vTeoFgmp1IK3mFHQ4IAvfWyJK+FRJ5MfFLYyILmlUnjBIH6TKCZJXv
	TLahE0K7GKah0Uo1tlEU8h369wcJCmhYjhH7z0KAgQLSjhk8bZLYG91SS9fXp9Sm
	asv8cIRfUsXDVC/lhCqKTX58HYhBnv7CK0zMoRaxH7pRa8Z7sudJPzVsDh0hjSsE
	rJAEJfnvc2htjVm/Umg3k4rdBWaUpKuGk4dWW3/DBs+tv+D5bv5U9CR0xiSk7K/O
	PT3h6DWTRU/s07cDhWb0tUm774KUr2LOSRLxy4UrVSHrQ4zvCFLyA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbgq43b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:56 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B5HBWWu012503;
	Fri, 5 Dec 2025 17:14:55 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbgq435-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5G2Wbi029392;
	Fri, 5 Dec 2025 17:14:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardv1x353-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:54 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B5HEole56230194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Dec 2025 17:14:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A6E32004E;
	Fri,  5 Dec 2025 17:14:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24AB020063;
	Fri,  5 Dec 2025 17:14:50 +0000 (GMT)
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
Subject: [RFC PATCH v2 06/15] s390/vdso: Keep function symbols in vDSO
Date: Fri,  5 Dec 2025 18:14:37 +0100
Message-ID: <20251205171446.2814872-7-jremus@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: rbC8D40I834cE8LCNvIl0TcXcM7u1qgW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAxNiBTYWx0ZWRfX0JrIZUXQ+e1a
 TKYGVFY0yJzn+ZFIGLPnP5Gn5xRL0qOjVfoOi56Z011d5yekavFTVfOTR9jvFIQFp1mFl36zvIK
 jokT8uhkE5eTU7/JYrpL2YTYJKZ5DMhzkNgy5yIuzbP13GtXeRuialGj1IDUE3kTlr9HVSxLkmt
 6aJovOwQ9FuLES4glfBTA8B2yABUUSZ8ltgtEvN7vwESszi+rHSh/PFDFOwZSeePeE1GPNJo659
 bLXWEC9rVATDaGurhCmqj9e1/5wkuvBHmAFs1AHv5d48TRrUEf8s8dNsqA9+7Vqp/F5Mn8knn2b
 tgYjl+mDle6aV+9daJBR7W+Fqczz5A4412g4TPs+qlegiLUg2TZ5tSuSiOJp8ZT2feh1pvnP1a7
 ZtNRO0w9KetX8/grQkj74mjdeCVmow==
X-Authority-Analysis: v=2.4 cv=UO7Q3Sfy c=1 sm=1 tr=0 ts=69331310 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8
 a=VnNF1IyMAAAA:8 a=BBANP_1BnTx_iyBG_wsA:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-GUID: -pY_xVkp3jvLOrp7z4Vh2HR3elIvWtnH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_06,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290016

Keep all function symbols in the vDSO .symtab for stack trace purposes.
This enables a stack tracer, such as perf, to lookup these function
symbols in addition to those already exported in vDSO .dynsym.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in RFC v2:
    - Use objcopy flag "-g" instead of "-S" with the cumbersome filter
      "-w -K "__arch_*" -K "__cvdso_*" -K "__s390_vdso_*" to keep the
      function symbols, as Josh did in "x86/vdso: Enable sframe
      generation in VDSO":
      https://lore.kernel.org/all/20250425024023.173709192@goodmis.org/
    - Reword commit message.
    
    Note that unlike Josh I did not squash this into the subsequent patch
    "s390/vdso: Enable SFrame generation in vDSO", as this change is
    unrelated to enabling the use of SFrame.  perf report/script do also
    benefit from this change when using perf record --call-graph dwarf.
    
    Note that this change does not cause the vDSO build-id to change.
    perf record may therefore not dump an updated copy of the vDSO to
    ~/.debug/[vdso]/<build-id>/vdso, so that perf report/script may
    use a stale copy without .symtab.  Resolve by deleting ~/.debug/.

 arch/s390/kernel/vdso64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
index d8f0df742809..8e78dc3ba025 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -53,7 +53,7 @@ $(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) $(obj-cvdso64) FORCE
 	$(call if_changed,vdso_and_check)
 
 # strip rule for the .so file
-$(obj)/%.so: OBJCOPYFLAGS := -S
+$(obj)/%.so: OBJCOPYFLAGS := -g
 $(obj)/%.so: $(obj)/%.so.dbg FORCE
 	$(call if_changed,objcopy)
 
-- 
2.51.0


