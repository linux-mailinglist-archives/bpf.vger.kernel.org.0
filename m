Return-Path: <bpf+bounces-66658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09154B3834D
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 15:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2E6687412
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 13:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B6F303CAE;
	Wed, 27 Aug 2025 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HgSqo80Q"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137EB28F1
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299943; cv=none; b=NCW8ZlSCRmG2W6jyqrZW4DdkI0d+62dvR9KdqNAGuKSpR9GsMz3ehV01E8LPKZCw/V99Mscn80Yylz/tvtI8PeX7qlrVTmTlI52j3EkhQqI4uW+SHF92n9gPkmzdWBVwMrh3BsLwoszqSijXIPGKZ388yFJ26+mSx5cHyzxeKxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299943; c=relaxed/simple;
	bh=fNxZ4H0/3L230UvW45kvp0q7Qzs5rgt1ugyMFxPqQGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YF73LyR92sDZtKLHFO5WFPY6bJEeEjsEytz0TOKOwSC1lrqEiIE18XC8BowsA5iQ4gpnG11+xigGer9P+XZk34PB7p/sGozL9w9FaRO31MvE1yw5jjtnr3/GelJhrFxC3MFj1twWOXOsTfI/OvniwQyqkcptCCG1uk49xTnf+a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HgSqo80Q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R9D2fL004346;
	Wed, 27 Aug 2025 13:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bN3nu59iNszVxzsrB
	i3nPL5hpoIlj4OniLRhD3sx8PI=; b=HgSqo80QbMZIQHgTFdheerSCkEi/WXGw6
	FuhaGiyARKahr2EFPLHWBRF8EO/k+Pq/vxkLQldoilsAzlV/k4ZCGHSCuJlF9gLt
	dLoCeysMDsE4jRnfkHlXwyRbb7L//tIXJck4Gl/KSPos+FVWv6JggXf/R1hRf188
	b1CCVVNVU1X44aHR+YzzZ/9U+aOK2+JxlsmHblis5Ud0wsA2fLPaOFnPHRNlj2r7
	0tb46np95/MmNcH0DMenURWBwJOXEPM7nxYPdZWy8tlhS15f7RaAf2mimysqn/i+
	HSLflHowQ8QuU29uoMWX++wTCaBaBSrslRPNt1uYtzEcyHdEtpLfA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q42j434f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 13:05:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57RBxIKr030357;
	Wed, 27 Aug 2025 13:05:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48qsfmr06p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 13:05:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57RD5MTq29360660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 13:05:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F3C220043;
	Wed, 27 Aug 2025 13:05:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02AE020040;
	Wed, 27 Aug 2025 13:05:22 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.21.94])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Aug 2025 13:05:21 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 1/2] selftests/bpf: Annotate bpf_obj_new_impl() with __must_check
Date: Wed, 27 Aug 2025 14:56:21 +0200
Message-ID: <20250827130519.411700-2-iii@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxMCBTYWx0ZWRfX/2VaLtye5nms
 myatQ5V6DeDrnqmZoA+ZWBjFBZ9Ae8TvJ0Ty5+piLx6yJRG2p1dQzAPBfsxWfAw/RlGUL4Nn3QV
 Gf8lVFUA2UUoLvJZ1OWBdCwP/ygmGQoNcjcOK3JZe7l+WXU3Uq4A2rzgflIJHCjCt8QpU8Np3jx
 Kfc6dEGvuKmzbH3Sm7HkzvClGlXGMyukKeBABF8iV3iE2FeV/j9bvi21yKU0MiTt0kAVwZEvjgT
 i0gK3FShntAPGqVIDqDx6lwj+E5UUQLAbhmgHWC1M7jNHarSM20Rqmug0YoZucML7t2k3y/+/zo
 WpC2+roLD8+3OqSC/XuV5HSynzaNsmTA4lzTU3o5awKUB0NjO8nekNZ0eQc1LSdCfkau3x2FCLE
 LcrWr7R0
X-Proofpoint-ORIG-GUID: kndYnmrqNBRTOER-cxIguMItMDnJtLY_
X-Proofpoint-GUID: kndYnmrqNBRTOER-cxIguMItMDnJtLY_
X-Authority-Analysis: v=2.4 cv=evffzppX c=1 sm=1 tr=0 ts=68af0297 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=y4fOKvO5TH5DvNK41ToA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_03,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230010

The verifier requires that pointers returned by bpf_obj_new_impl() are
either dropped or stored in a map. Therefore programs that do not use
its return values will fail to load. Make the compiler point out these
issues. Adjust selftests that check that the verifier does indeed spot
these bugs.

Link: https://lore.kernel.org/bpf/CAADnVQL6Q+QRv3_JwEd26biwGpFYcwD_=BjBJWLAtpgOP9CKRw@mail.gmail.com/
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/bpf_helpers.h                          | 4 ++++
 tools/testing/selftests/bpf/bpf_experimental.h       | 2 +-
 tools/testing/selftests/bpf/progs/linked_list_fail.c | 8 ++++----
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 80c028540656..e1496a328e3f 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -69,6 +69,10 @@
  */
 #define __hidden __attribute__((visibility("hidden")))
 
+#ifndef __must_check
+#define __must_check __attribute__((__warn_unused_result__))
+#endif
+
 /* When utilizing vmlinux.h with BPF CO-RE, user BPF programs can't include
  * any system-level headers (such as stddef.h, linux/version.h, etc), and
  * commonly-used macros like NULL and KERNEL_VERSION aren't available through
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index da7e230f2781..e5ef4792da42 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -20,7 +20,7 @@
  *	A pointer to an object of the type corresponding to the passed in
  *	'local_type_id', or NULL on failure.
  */
-extern void *bpf_obj_new_impl(__u64 local_type_id, void *meta) __ksym;
+extern __must_check void *bpf_obj_new_impl(__u64 local_type_id, void *meta) __ksym;
 
 /* Convenience macro to wrap over bpf_obj_new_impl */
 #define bpf_obj_new(type) ((type *)bpf_obj_new_impl(bpf_core_type_id_local(type), NULL))
diff --git a/tools/testing/selftests/bpf/progs/linked_list_fail.c b/tools/testing/selftests/bpf/progs/linked_list_fail.c
index 6438982b928b..84883f04d58b 100644
--- a/tools/testing/selftests/bpf/progs/linked_list_fail.c
+++ b/tools/testing/selftests/bpf/progs/linked_list_fail.c
@@ -212,14 +212,14 @@ int map_compat_raw_tp_w(void *ctx)
 SEC("?tc")
 int obj_type_id_oor(void *ctx)
 {
-	bpf_obj_new_impl(~0UL, NULL);
+	(void)bpf_obj_new_impl(~0UL, NULL);
 	return 0;
 }
 
 SEC("?tc")
 int obj_new_no_composite(void *ctx)
 {
-	bpf_obj_new_impl(bpf_core_type_id_local(int), (void *)42);
+	(void)bpf_obj_new_impl(bpf_core_type_id_local(int), (void *)42);
 	return 0;
 }
 
@@ -227,7 +227,7 @@ SEC("?tc")
 int obj_new_no_struct(void *ctx)
 {
 
-	bpf_obj_new(union { int data; unsigned udata; });
+	(void)bpf_obj_new(union { int data; unsigned udata; });
 	return 0;
 }
 
@@ -252,7 +252,7 @@ int new_null_ret(void *ctx)
 SEC("?tc")
 int obj_new_acq(void *ctx)
 {
-	bpf_obj_new(struct foo);
+	(void)bpf_obj_new(struct foo);
 	return 0;
 }
 
-- 
2.50.1


