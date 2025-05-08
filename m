Return-Path: <bpf+bounces-57750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4D0AAF8D8
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 13:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E551C0498A
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 11:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EECA221F17;
	Thu,  8 May 2025 11:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VJfSX/YP"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899471DF725
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 11:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746704311; cv=none; b=hscQ/1lrz8Qy3q2YRPUZdqLQD8LUqL8M9lwJGiMChzJLOnFrZVlghdAb31fOF/QYiGfTCH8Hbhm0MtNXPLL4poaHOIvhdCGf5KgBTigBOUknJyrNwOYF6eb//bzYy+TqDj3CQ+UaiOK/cXPPHO+1U7/lerwyRpfB2Qels4QwHtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746704311; c=relaxed/simple;
	bh=19TL11NO/2sEtg203MMKgo3J88vPxFlZ1Ivg1PdIV+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DfDSPyme0+lS+bajOdps5sPGmOaVdff4WhQ90Ma8gBZp9BiB8+9ddtC9TWG04h2pL4UUFwGsilm35drS/3vDbdfVnhcQ4sI/WIKYvsz9WVFEX/CtTrHLvyV9Lt7VpNl8N3/J572J/aGsw5Rip31qVGZXPlhqgFaoQi8iw8gTokM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VJfSX/YP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548A46Jn025959;
	Thu, 8 May 2025 11:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=3FSqj5QOyX6FWX1wHIKr7doi4Aqu9kwtuSG/tSVZ2
	so=; b=VJfSX/YP4oHXTuaAmjs7chFHDZ2bRB2kQ9LWWJg4jpqAclFShVB/Sw49X
	tpUyo3cHOjRDuZrgdgPD4sL8iEm9dQrXKxDzCyX8/x+ecig4E5lGMtNMvRYttc+6
	E1umleqtEUfGsQnbgKoML5OEwpYuwVYf+rfvPJtAVA6sChMN9dHXnfgETVR+DUah
	UWx0drh224a1U+vnc6z10NQKFvZ74UFFQMEYX8gFgbK1t/NxwdPHieAXs8Zyu1x7
	0F/mzfRe3cYaDNfIohZNt7FbG/BYgZDASyWeAw7MJTMRpT9F3wgFhAVJz+9M5qKm
	blqo81wsV9ZUpeFuPM8RhuSnZz0ug==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46gthk8cmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 11:38:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5489dcPE002826;
	Thu, 8 May 2025 11:38:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dxfp5j4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 11:38:12 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 548Bc8iv19726854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 May 2025 11:38:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 307B120043;
	Thu,  8 May 2025 11:38:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A47BA20040;
	Thu,  8 May 2025 11:38:07 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.57.16])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 May 2025 11:38:07 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] selftests/bpf: Fix "expression result unused" warnings
Date: Thu,  8 May 2025 13:37:53 +0200
Message-ID: <20250508113804.304665-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDA5NiBTYWx0ZWRfX+nhia6S09sD/ H8qMHH14SK9IV2UYtcS9TfoAC7rzmfHDHGpIkjmQmZKJbrer+/1pelZ9i4sj9EOmoZ+woD8f4wu C5c8npUCTzHwnTL+f3YSLdEM3A0QoL9i6lNB1m9PwQxrIa2kXWKKy64KAKtadEmEKWrDoKhvjrQ
 h5ipTuDvY8o2mo4u/ziDgPJN+CTK+FIxGtrLT7AwXWMFoDw9BBSFjPxJUqHLflAYW4oDEtloC8h DlbXRS+dndjMAFL8F4F8JpHBEz1QX9G50A6jyfGQIq4wtHaIWeOK9xnvIHMmP6X82NPWGPkcM06 77p1ULBuqGaSycbMfnJCnoyaF2QuYKLAOtf7G25TWjsf/gJ79PP7wVPaIn8PTttzmN9iSci+/7q
 MwhMtoZDtQIZnfs2z48jlShKt0IetamMtOcDQmaOjKhJSV5hC250av3ZBdkOdHxScNsiI3OR
X-Proofpoint-ORIG-GUID: 7a141tOpUygzenM6_alaiJLQP15WQP2y
X-Authority-Analysis: v=2.4 cv=PvCTbxM3 c=1 sm=1 tr=0 ts=681c97a5 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=2Xb9xcaRKYm663Z5mW4A:9
X-Proofpoint-GUID: 7a141tOpUygzenM6_alaiJLQP15WQP2y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_04,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 clxscore=1015 mlxlogscore=837 bulkscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080096

clang-21 complains about unused expressions in a few progs.
Fix by explicitly casting the respective expressions to void.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h | 4 ++--
 tools/testing/selftests/bpf/progs/linked_list_fail.c    | 7 +++----
 2 files changed, 5 insertions(+), 6 deletions(-)

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
diff --git a/tools/testing/selftests/bpf/progs/linked_list_fail.c b/tools/testing/selftests/bpf/progs/linked_list_fail.c
index 6438982b928b..e451726f2ab4 100644
--- a/tools/testing/selftests/bpf/progs/linked_list_fail.c
+++ b/tools/testing/selftests/bpf/progs/linked_list_fail.c
@@ -219,15 +219,14 @@ int obj_type_id_oor(void *ctx)
 SEC("?tc")
 int obj_new_no_composite(void *ctx)
 {
-	bpf_obj_new_impl(bpf_core_type_id_local(int), (void *)42);
+	(void)bpf_obj_new_impl(bpf_core_type_id_local(int), (void *)42);
 	return 0;
 }
 
 SEC("?tc")
 int obj_new_no_struct(void *ctx)
 {
-
-	bpf_obj_new(union { int data; unsigned udata; });
+	(void)bpf_obj_new(union { int data; unsigned udata; });
 	return 0;
 }
 
@@ -252,7 +251,7 @@ int new_null_ret(void *ctx)
 SEC("?tc")
 int obj_new_acq(void *ctx)
 {
-	bpf_obj_new(struct foo);
+	(void)bpf_obj_new(struct foo);
 	return 0;
 }
 
-- 
2.49.0


