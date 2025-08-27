Return-Path: <bpf+bounces-66659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8191B3834E
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 15:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9D968779E
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 13:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A0B308F1B;
	Wed, 27 Aug 2025 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BmUTKvRU"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CC12820C6
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 13:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299944; cv=none; b=YY92WnSUTH9mQFIaSWXjsVusorUwrCn5LXgms1EMxbe4axhL+KUrhXwkgIkTqCgwd1l7tS/caqvqUQ57gvN6TQBjNVfs2+kIR3nD1gfhW0LoF8ozm9OSrnLdRKKXGjIBBs+eWEcoyzN+911rHsHMHEI1R6QU7jsr/NSh0XUYWUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299944; c=relaxed/simple;
	bh=lhU0DJb9wuc9a3JzmG8B7gN/cWJDZloDEqTj2HEPsaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyndnGWFkU8GWLfuCeUR3ycgZIEyqGBNCTsonBQX9qjibA0csAS+HzY61gDzBbcpHIQfcDFvhaZEgjfaTff6gQu/BBaiZDHmLty86fwMHcJEnlDPGE+AcesfK7Cdv8V1mqGAepUdxelUK2NOfGSuTE7wBqB1m3NgXMf3fxeGSQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BmUTKvRU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R3Vfj5030401;
	Wed, 27 Aug 2025 13:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ElOzcbJv06TtinuCY
	qUUVwQpoNV7KcmudA63u/RI09U=; b=BmUTKvRUGTZff4PZCgQhLhj/Aj6LWURCp
	mGRTVipkx7pkSzMMzi/lBSvw8Q3JKlTCpamXMMDOg8c+xWoRigTmQwpOGwETjDex
	Ig6y9MzacNWvDhp8FCu4clgAq02LOrBn3jXOmdrDHsSxQZCdJUmbKHwRnYJGNdtQ
	5FCqkkknRo7qblQkDC0MZm3tV6WN4symBjRR4YgjISjQRS7XcX7/VF/+B2voYCb+
	uKwMukBqMfImDU7GHT+XvQlXxoxo180a+lNY6kxOtX30thPRQfdln79h7IvI52Q0
	Q97ltkdK51nue9FjXTiq+zvYM0HPVbPlj3hHCz2HL90jgp4dr25+w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48s7rvy4sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 13:05:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57R93SJR017993;
	Wed, 27 Aug 2025 13:05:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qtp3fr16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 13:05:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57RD5Nwj60948848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 13:05:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE66420043;
	Wed, 27 Aug 2025 13:05:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8370D20040;
	Wed, 27 Aug 2025 13:05:22 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.21.94])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Aug 2025 13:05:22 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Fix "expression result unused" warnings with icecc
Date: Wed, 27 Aug 2025 14:56:22 +0200
Message-ID: <20250827130519.411700-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827130519.411700-1-iii@linux.ibm.com>
References: <20250827130519.411700-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ApHWG3Z2glilHgqQa22U0wQGAwbCxUAD
X-Authority-Analysis: v=2.4 cv=fbCty1QF c=1 sm=1 tr=0 ts=68af0297 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=U3bVoonNbeMQq_PQ-eoA:9
X-Proofpoint-GUID: ApHWG3Z2glilHgqQa22U0wQGAwbCxUAD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDA1NSBTYWx0ZWRfX7yRNqpHezWEk
 Xhr7cdgeOxgQ2TQE6TiGDdxU108puxabEKsq8H/hJKWnBUyeKlLkwc3Kr5GUf4P9q6oDlBhGe2o
 tCZmpFNpI47LsbVOqJadK0mM3uPLSbOAthR7EPtPrILevg+FsJ23pFDh7aA0/6oST4m2x9rTS26
 ajKKj/BNfhe18ZjEf4QvVimzSQv+Yv0lhg8oY8Y5ZO9TPNMecLvJbMoEaN7RqHKATqxWzr8jUcI
 N0hU7SqwD24+DBy1VN7MWCYlpsvuV0FcGs8244FFzkIzQ+q6Bsmsrs7JBeQaaBFJl6ICe4mysW5
 uWWu/Hlw1LKTqEOPRuv60zNGGDijKZWR5Zdqw0zpA4E8Ot0j5ZkRI0QYVbcSyq4fQqyR0xB+EaZ
 WTxmXYF4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_03,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508260055

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


