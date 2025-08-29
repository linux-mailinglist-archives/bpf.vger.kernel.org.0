Return-Path: <bpf+bounces-66925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D1BB3B145
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 05:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20DB3981024
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 03:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1083B221FDC;
	Fri, 29 Aug 2025 03:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FSwbHdSa"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0188933985
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 03:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436440; cv=none; b=vDGRn27Zp9a+Lpm8qfPDK9opOz65fklLNOG0QbcdciKAwqaCTvkU4vo2QzDeI7C4QGmZggbb3ebfEVcmS2XWdWy4z+edaqCFAtOH8eukeVbBbGomNzOXZKIOSrLzJW5sy1ePR/9QXeSgbVuGVemP/SqdRoDEci4aF78zJL5C0pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436440; c=relaxed/simple;
	bh=MmLmOsl4lfphpAGCyqk9r7vWs08p8MdSiG2ioeEZ4ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VaT+YRf0fJ+g7o209gUxtJ1OIAdv/mPPduuvdMNYrHNpCI8sv4EToxwSh4WcCJpnM5PMNdWNKxG2hIqicHDLL6xrZ1JVDhl0zTLMiQJnwyHhVIiuCqezSPpXDbzar9zKn6u++1O4Snirf3BhF7S4M0wLTmisxI/II/yBa8bFD3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FSwbHdSa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SFY0Au012266;
	Fri, 29 Aug 2025 03:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xmovo/sjDdTyPsd40
	TiAzkkVIShb9Ief2m1yVlCQfJk=; b=FSwbHdSauooUZ/2X94OQSecBoZ82lIVgi
	6LTW+JIYxEpGmjeLKzeu1csHZyuPNPJzJt+sPeO3k281Fd5t5cmE13IvIwq/6kp9
	zLaqpVxh+61d2dOLLIEpYynQnXz/cQGxqLX4y+5mYaoVRXAVpzDapXfVN/ymcmk3
	919Ii0e3gGCX1uAgOGuTuP55OAQ+g1befOI+tSWVIhUxV8c7/pEw1popG9qLNrqI
	vnlVi1gjXWkmrUtBOk8/SUcDxaLIJuMZJ244HA8HFvobU4N9XGDptt2UUUaFQypd
	/bKOw+BS5uEj0c8PYV5ecY4TNUijzh0WrEe7+3JZDFGLW5lbvttVA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48tsv9akcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 03:00:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57T14X2b007443;
	Fri, 29 Aug 2025 03:00:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qqyur4ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 03:00:24 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57T30KnP51642654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 03:00:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BB462004E;
	Fri, 29 Aug 2025 03:00:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DD3420040;
	Fri, 29 Aug 2025 03:00:20 +0000 (GMT)
Received: from heavy.t-mobile.de (unknown [9.111.84.82])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 Aug 2025 03:00:19 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v4 1/1] selftests/bpf: Fix "expression result unused" warnings with icecc
Date: Fri, 29 Aug 2025 04:53:57 +0200
Message-ID: <20250829030017.102615-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829030017.102615-1-iii@linux.ibm.com>
References: <20250829030017.102615-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=GqtC+l1C c=1 sm=1 tr=0 ts=68b117c9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=bG-19ZxebuOe2GhUqGMA:9
X-Proofpoint-GUID: BzEVzOQjJZ7VyNMWMcA71D1rY6KR4w2h
X-Proofpoint-ORIG-GUID: BzEVzOQjJZ7VyNMWMcA71D1rY6KR4w2h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDEyNyBTYWx0ZWRfXyfaoy+G4vnBJ
 XZyDNwzgjAUDXBaEZs9zZd6zQOItDA9h3AfH0oRN2UjYjfTs6UQI6bPmZhMZNNt5Gjt9Kv96qoY
 zB3iWQhB49ka4BB9BrzOCo7gQtVn6Bb0C39WOJekzI8BGGBQO3aPkk2AjBPxo5naOjJx0Qa2RgU
 zoNzRiyDh2DyNk/zDfQYdCmYRwJJgbBnvaahgH8Nri/96eddYi/EenY+mMjiSJfvYIjGq/DPxir
 bcdPG2DWknP/9B3WAuZB8kZLN4DIQKPTLf/EMVKTIEYDWlLKx9DRosOaSeu2hjCnn47y8t4C5x8
 m2g08zjmnM5iW0Y2vP45IoaJSI1cH8ahsZ319if+6yBsF2k+MNPSAn0kdHqaZb31x3sirXQGpgh
 ly6nzbqJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508280127

icecc is a compiler wrapper that distributes compile jobs over a build
farm [1]. It works by sending toolchain binaries and preprocessed
source code to remote machines.

Unfortunately using it with BPF selftests causes build failures due to
a clang bug [2]. The problem is that clang suppresses the
-Wunused-value warning if the unused expression comes from a macro
expansion. Since icecc compiles preprocessed source code, this
information is not available. This leads to -Wunused-value false
positives.

obj_new_no_struct() and obj_new_acq() use the bpf_obj_new() macro and
discard the result. arena_spin_lock_slowpath() uses two macros that
produce values and ignores the results. Add (void) casts to explicitly
indicate that this is intentional and suppress the warning.

An alternative solution is to change the macros to not produce values.
This would work today for the arena_spin_lock_slowpath() issue, but in
the future there may appear users who need them. Another potential
solution is to replace these macros with functions. Unfortunately this
would not work, because these macros work with unknown types and
control flow.

[1] https://github.com/icecc/icecream
[2] https://github.com/llvm/llvm-project/issues/142614

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h | 4 ++--
 tools/testing/selftests/bpf/progs/linked_list_fail.c    | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

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
index 6438982b928b..ddd26d1a083f 100644
--- a/tools/testing/selftests/bpf/progs/linked_list_fail.c
+++ b/tools/testing/selftests/bpf/progs/linked_list_fail.c
@@ -226,8 +226,7 @@ int obj_new_no_composite(void *ctx)
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
2.51.0


