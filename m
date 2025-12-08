Return-Path: <bpf+bounces-76299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F939CADE0D
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 18:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 215473087932
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 17:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E35241C8C;
	Mon,  8 Dec 2025 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FDz8dtA0"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C8E2FBE1F;
	Mon,  8 Dec 2025 17:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765214195; cv=none; b=fUr3gWVdVoo0g1gaMDreBMr2sIMhMnVVDDG3f6MGubitO8E95rC6lHcdCfnZl/JtZwXiQVp7INbUZu14UTwbYkdCX+j1I1vSA5sl0MR82rldQLAGB9DMWIyor/0uij6gFbdLLVnGY1mx+yRQWAUtEcSgmfJwOAYGqLa4Tbvm0VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765214195; c=relaxed/simple;
	bh=uTTzdrUeqQbjvXCuDlyz0FReyMWGuAsohw0+59rIUb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UlkFILmdxlD1w9l2NcEiSNL4NAunP6G310gGcjBKf8hvIyXYruRqNfSs+oroq3fvLg/Vo45jpwZSvD7X+rMTXrTkXwI1IWpVfRquRR2eEUIMTJfD+t/hVuuWMPHQe1cDwIyD1N64sVTiqX/G+leb5R88e0fppmtIn1oxCkVzz04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FDz8dtA0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8E0o2Y002119;
	Mon, 8 Dec 2025 17:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QbfSqQzLjksgns1mI
	C3zXh+jcYNMEleD5cIrau6YfF0=; b=FDz8dtA0BN0/rDKW/Vh3OLNC876ASti2y
	MSUKbS303cPL5zK4/4nTLCtpHKOpwmaSdLT2dqvkwzKdS1rU6mMuSLUflKSQQo5+
	9pdW8JwSzbD3e0/4a+QCSQr/uG7BnyqpENnFygf/IGCfLhYxwOHMajbTzg122a/n
	GL1GNsyiI41mxnV0y09cTD11D/Etya5GApuE7sB7WHPLMbmN1IzcVp8ujkwTLAnl
	Px/Unm2pUbLiH0Pm7IaicNUVBF1HvyvFxmYAAShox61D6pRe8GkTZ0KRVZ48QpQo
	dPhU7es2X1u+hVtj89PDm0K+1FshU7jSnVDP042f7ALnP2nAHusaQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0jrwub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:10 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B8HEsQO010555;
	Mon, 8 Dec 2025 17:16:09 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0jrwu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8FM7LP002053;
	Mon, 8 Dec 2025 17:16:08 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw11j6kft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:08 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B8HG46D61800936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Dec 2025 17:16:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4C3E20043;
	Mon,  8 Dec 2025 17:16:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 701AA2004B;
	Mon,  8 Dec 2025 17:16:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Dec 2025 17:16:04 +0000 (GMT)
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
Subject: [RFC PATCH v3 07/17] s390/vdso: Keep function symbols in vDSO
Date: Mon,  8 Dec 2025 18:15:49 +0100
Message-ID: <20251208171559.2029709-8-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Cf8FJbrl c=1 sm=1 tr=0 ts=693707da cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8
 a=VnNF1IyMAAAA:8 a=BBANP_1BnTx_iyBG_wsA:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: vLPqcrQscSkDY9e1Mog764oDW8gjZ4i_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAxNiBTYWx0ZWRfXzLK+xb/V26Dw
 TZAZ3kaklWT13mgtPi1rVszOyOjiD4xhZwGVbU7jS3yJlmNo303vvuVZ6HuipPUZqq9EAV6RULT
 us4XEtSzGIheY7IJF1/ExV1pHKQdqGxTi5R3iYjYDXqx/DNWgWGItLRrCMgOshNPAherbg8gAXk
 uKpcpNE2GpOd2SewMTAsE+IvH1ggL8yAe3mMyyV+puG3iWZjZT4URPDiyO1qKQjhDqqMc3IZ8Qm
 vHzWMUOjBjY802pNwacS9C0uxgroZhZtqWbuTTqXFqomHLhrp0TS9Gao+HKt3fYBSx9An3iLsCb
 E57piLkwAp3V5m7FiAVB8zG3aIZyz8W8pMAQMwupmue6YFmvuSeE3UDJbk+4xzvrxVr92x7qQn6
 IflTUhs43JE9rzQJWxKFc6eyeNIsEA==
X-Proofpoint-GUID: vtz-xCPANSABSIOiJan8fHpHJqLIOySS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512060016

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


