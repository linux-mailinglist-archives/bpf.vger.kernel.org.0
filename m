Return-Path: <bpf+bounces-62951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AEFB00901
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 18:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0F3C5C27A9
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 16:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA952F49E2;
	Thu, 10 Jul 2025 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BcxTlCG4"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76AA2F432C;
	Thu, 10 Jul 2025 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165381; cv=none; b=q9QSZR+yTWDPSWwnLdN1ThXRtIbvvI5EVIOTwpkpXWaQX0MR+rSQlzCq6CkvFtBErumijDoF0Ir+mgKHJ5RLb6ZfQmmAobgm3LjRVMyQqbW8+Fa/2xzwjEdzLBPjib6hzCMUG4Qx35a8g781Bsg49Mc7yBainkFUhxobYj/bBY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165381; c=relaxed/simple;
	bh=BSLmG/zva1ZbV3dNebNDMzo5CQbuvBqjOM0xaAdun00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsAp4hYXZ+JDh5YF3ZNUwv4FAySVNS8w6CbK3kRvpilM8/47paOD5n196927/7hRTz/Yp6rSLlnatoiM80zDCwm34K1hZ/uLUbBIptT/cg8IJt9KWtqHJCOcLwgYDKBNr/OGxV/X5kXH6pLpqJQ125TTspWsZTIOF1dFTLVZwcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BcxTlCG4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ABp2QD013115;
	Thu, 10 Jul 2025 16:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3QS8mQ0ldtZ+JHt4A
	wmOeYRF1jVUxSj14mdrcEB6qDw=; b=BcxTlCG4fIMKnhA2z7rvvUV8VetieOwdB
	CeIFr5qHJOBN+jYfkfHgLQtSRQenDgP5chx1eA5UV9CZAGr37Nl4W6JoMOPJpU1P
	ShVMGlI1/gSBpkfyjN3zf1QAGKhMNb/NPOVtlx5iH+R2hUpgNUTElzOHRnBZzWTc
	UabSfWW++n4DpG5bSvSsWe4+pCH0cIA49+CO4LZO4h9JsbpZAhkyXQUXjQ/QXWtA
	Uzbswq+PZyDnfbBeHqcYI7apfy6sTDaPDOtKn3YTIJ+qt3fs02g5CpQVA0Iks07m
	E2mVDtt9WhdLNYyZNXFLvBxlRz9Hn7ZDn3UUX5UZlJ+sdj9VEPWZQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47t3xdc560-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56AFOe6w013582;
	Thu, 10 Jul 2025 16:35:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qgkm6bbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:29 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56AGZPI558458492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:35:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5CBC20040;
	Thu, 10 Jul 2025 16:35:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AFDB2004E;
	Thu, 10 Jul 2025 16:35:25 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Jul 2025 16:35:25 +0000 (GMT)
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
Subject: [RFC PATCH v1 05/16] s390/vdso: Keep function symbols in vDSO
Date: Thu, 10 Jul 2025 18:35:11 +0200
Message-ID: <20250710163522.3195293-6-jremus@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: w_vmXR7S9YdXTkDzv2pYjcLu7v7plaOd
X-Authority-Analysis: v=2.4 cv=MLRgmNZl c=1 sm=1 tr=0 ts=686febd2 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=VnNF1IyMAAAA:8 a=Y8jfv7Xf8eAsT8039CcA:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-GUID: w_vmXR7S9YdXTkDzv2pYjcLu7v7plaOd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzOSBTYWx0ZWRfXxOKx7UHyHkId T4tAryGvOwhw/TbQwCgUNBSao0VwPmRjlSThv6EtRG7tQUtm0y94rqNGfehfXWsvcQ4lRUiLU/O z9oxjr2OxFaR7L/Ld5bmITYcCHLzpmH6NNgriERz+bnSfy+bL8EYAq1EWKYqMHdrKczgeOcwFYr
 0I31Yp+885CtihhhhMwtwoB0whdwRFBTJ2MlAgcDLZl3QdVzY57CbibUsivHZuEafQY3f0nqk7L +qStTMVRwV2ylbBgg7fiCRRjhkSTE3c4vsBpIHdINt2QwSM4l3w3LYOpCeeZlzoemilz8iGehUT 8ep+Zp9/m/W37up6t+akUqAjII4wwaA40UQ8nQPSumSt6ceYysuQVYzw100/H2OcCGrauhrqPQl
 /dVwy3JNVUwdGSsRblMpvPWTjV2TkEL4VsJkK924ZHRERNhRg6AueSC0ogpvzb1jantl0c2T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 mlxlogscore=862 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100139

Keep all function symbols in the vDSO .symtab for stack trace purposes.
This enables perf to lookup these function symbols in addition to those
already exported in vDSO .dynsym.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Alternatively use objcopy option -g instead of -S (and the -w -K
    filters), as Josh did in "x86/vdso: Enable sframe generation in VDSO":
    https://lore.kernel.org/all/20250425024023.173709192@goodmis.org/
    
    Note that this change does not cause the vDSO build-id to change.
    perf record may therefore not dump an updated copy of the vDSO to
    ~/.debug/[vdso]/<build-id>/vdso, so that perf script may use a
    stale copy without .symtab. Resolve by deleting ~/.debug/.

 arch/s390/kernel/vdso64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
index e96156b9c4df..067753352697 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -58,7 +58,7 @@ $(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) $(obj-cvdso64) FORCE
 	$(call if_changed,vdso_and_check)
 
 # strip rule for the .so file
-$(obj)/%.so: OBJCOPYFLAGS := -S
+$(obj)/%.so: OBJCOPYFLAGS := -S -w -K "__arch_*" -K "__cvdso_*" -K "__s390_vdso_*"
 $(obj)/%.so: $(obj)/%.so.dbg FORCE
 	$(call if_changed,objcopy)
 
-- 
2.48.1


