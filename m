Return-Path: <bpf+bounces-66706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8837B38A79
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 21:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6BC189A3C1
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 19:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EDD2EAB6D;
	Wed, 27 Aug 2025 19:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c7Ec+0Ap"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8C42EDD65
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 19:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756324192; cv=none; b=Bmg6xVoCcJi7K4MJedR6xjMydq4kQtT5h4AbJsIEPCie5gBRqbDQfd/Oz4manYPOkdj65+hKFnVh9dykmETosiBM1rwDCX+W4lkF1WdI9EPIhm6IlY4wCJ17oygRoBo+kscwjyIUb8TG1QOlrWMgsjIYfwpAJcki5m8HKHdzvoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756324192; c=relaxed/simple;
	bh=lhU0DJb9wuc9a3JzmG8B7gN/cWJDZloDEqTj2HEPsaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ey2onjQL3SuPXp/XZhp9nB4M7PHCvtqTfvBQJ2+XQ4y8a2F9+rta9hVADbGpQ/+8sJic60NxJ9z/8toFww6lTp5//ZFUuwPhp1L5ZasFSwB87jdQICqaeyxHePfynzXHf1LrJW+8DWTYXotL8ybokEkRiv2RZrG+yyXY56kChOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c7Ec+0Ap; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RAXOuT028958;
	Wed, 27 Aug 2025 19:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ElOzcbJv06TtinuCY
	qUUVwQpoNV7KcmudA63u/RI09U=; b=c7Ec+0ApDsu3n1jYn3Bxrz6UefOhfd0pW
	zA4tet97n+oyYxggdSeb8vGy7U4yR7wUzNugUKWyJat3KFsLGptC3QVaIf9uYOSr
	yWukR1Vng9XMl1yFAJE/4LQq/aAIkyjdx3lYw+2GGzZ6LCMs4ymZDKlWvP1KnIGH
	zfXra6NLmak46e+vZ+XfudrvsPjb+dNkv2ANQlhWJ3h0BAp9tDmy/K9zuNJ5Gb/w
	wLtBJVKl0kPAthMi/DI187R9XLHIlOrWwLC2dQGBZcoF8iCWz3E2SuqfV3vfQqBD
	2SejNQCeXB+5IOsY607x6lIV9RRsBL/EdUxGl/kh0tFaovahGMOGA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q975dbcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 19:49:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57RJmeld002543;
	Wed, 27 Aug 2025 19:49:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48qrypsk7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 19:49:36 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57RJnWRl52166954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 19:49:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E8AD2004B;
	Wed, 27 Aug 2025 19:49:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF01E20040;
	Wed, 27 Aug 2025 19:49:31 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.21.94])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Aug 2025 19:49:31 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Fix "expression result unused" warnings with icecc
Date: Wed, 27 Aug 2025 21:46:46 +0200
Message-ID: <20250827194929.416969-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827194929.416969-1-iii@linux.ibm.com>
References: <20250827194929.416969-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oH4PjvGx132IDamaCa5qHSdCw8TdYeMF
X-Proofpoint-ORIG-GUID: oH4PjvGx132IDamaCa5qHSdCw8TdYeMF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA3MSBTYWx0ZWRfX1ZEDFE8l4vZg
 wJ2zdcNglOpX4oTAMmTNQWp8aC2zhLzvwKqmaNhLXCnYI7DMVAgK8kAlhNyeedxkgGc+xzAsz4g
 rTR2EpZ21StDQ+b3jNQVWwSJc178B2yCLrtMYvIFsh6VmKxvkiSF210k3UAb5R4u5UiGesemx4a
 WjHUlCw8Qf3Q31YlwYac1PPxW2sSh6mO2oOtVr28MGx1fsryQEwOR+tepcdiQgy7b3zcPl4vvkW
 GwDLlSMuiHoj6aKYXba376nr1aDQm40NjeMhpdueBTXlIb5lT/54wP0Pmr++FXWx0M52kBGIvBF
 IWdlnd0/pmW3OvwnlPELdI5hMv1lEkU9/xe8QkEgD/LWhadoTClniL2aPsVq9xoO8mw4SlBYC2u
 qRM63BMR
X-Authority-Analysis: v=2.4 cv=RtDFLDmK c=1 sm=1 tr=0 ts=68af6152 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=U3bVoonNbeMQq_PQ-eoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230071

icecc is a compiler wrapper that distributes compile jobs over a build
farm [1]. It works by sending toolchain binaries and preprocessed
source code to remote machines.

Unfortunately using it with BPF selftests causes build failures due to
a clang bug [2]. The problem is that clang suppresses the
-Wunused-value warning if the unused expression comes from a macro
expansion. Since icecc compiles preprocessed source code, this
information is not available. This leads to -Wunused-value false
positives.

arena_spin_lock_slowpath() uses two macros that produce values and
ignores the results. Add (void) cast to explicitly indicate that this
is intentional and suppress the warning.

An alternative solution is to change the macros to not produce values.
This would work today, but in the future there may appear users who
need them. Another potential solution is to replace these macros with
functions. Unfortunately this would not work, because these macros
work with unknown types and control flow.

[1] https://github.com/icecc/icecream
[2] https://github.com/llvm/llvm-project/issues/142614

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h b/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
index d67466c1ff77..f90531cf3ee5 100644
--- a/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
+++ b/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
@@ -302,7 +302,7 @@ int arena_spin_lock_slowpath(arena_spinlock_t __arena __arg_arena *lock, u32 val
 	 * barriers.
 	 */
 	if (val & _Q_LOCKED_MASK)
-		smp_cond_load_acquire_label(&lock->locked, !VAL, release_err);
+		(void)smp_cond_load_acquire_label(&lock->locked, !VAL, release_err);
 
 	/*
 	 * take ownership and clear the pending bit.
@@ -380,7 +380,7 @@ int arena_spin_lock_slowpath(arena_spinlock_t __arena __arg_arena *lock, u32 val
 		/* Link @node into the waitqueue. */
 		WRITE_ONCE(prev->next, node);
 
-		arch_mcs_spin_lock_contended_label(&node->locked, release_node_err);
+		(void)arch_mcs_spin_lock_contended_label(&node->locked, release_node_err);
 
 		/*
 		 * While waiting for the MCS lock, the next pointer may have
-- 
2.50.1


