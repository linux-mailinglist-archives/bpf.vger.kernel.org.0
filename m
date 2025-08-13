Return-Path: <bpf+bounces-65514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0ACB2493D
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 14:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890C4567D43
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 12:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0680302CA9;
	Wed, 13 Aug 2025 12:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EE50HfW2"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B4F2FF15F
	for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755087041; cv=none; b=kuRLR5P6+kF06z90k1X41iJif7TH5j1UReUPvEH6SWfIK21Yxb2/Gjq0+6rPuBQEPtV6/Lp1uGmXEF8DAajI9IMFbzHAtuBANm++8p3Xf5zh8R+3tcr8oFjuC8CVvnjnDvNFyUtMJgd+pNjL9jMgZ0KgDpz1hLKouKAvk75dVSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755087041; c=relaxed/simple;
	bh=5VMqsMLb/NZMyzBfEG5QUzv9CKJU3ruXSZGmVh+RJ70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnt02y/FfFRMMwvqdS9zTyHScch+UrndF6Cm1yO93eLZLv+KG+MgMloyK+r5XjuAOiMsla+TpxURy9Wt0zYHua11AFB4C5KQeAO+1HjwsHte2IYv9qECmfDq7iG1KXk8A6YoWxSsSaSXWdZK/alV+Wkq0mHbxWkuT/0lVTC6X7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EE50HfW2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DAmmgi017120;
	Wed, 13 Aug 2025 12:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KrPkkTeDLYx5yYbTd
	iHcXpwUcPATkiIPZDAIvM9Gn3w=; b=EE50HfW2zDzTGSYMEzwU59o2bzP1fEv64
	T03COoFEBmx02HEkHe9lzU4l/8XiH5+KSmZKmR1UG2gXkGIlGyCxkg74c3g+htVO
	d9+vFo1vVwRDwD12Na0MuNH5IdBxlLowugnCBIoKDF+0cE36sstfUqteeDC1Ap8w
	CeqagQa465Y5UaJ4XPXlkxsNVY+blclasq+wRi8O+/DwhlauyXHvNj4/9GQLW7YN
	YAl733pRQUdG87n38EnFj9YsLxGWZ2ie17LtOI3+MAx+a1J0q6lHceYED6EVpXsT
	PTrUJjh2sB5qSzDckCUE4wVUAf4twrIRJYvzo5//KBGBqbLovhsEg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrp42bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 12:10:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57DC1iCW020649;
	Wed, 13 Aug 2025 12:10:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ehnpy518-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 12:10:25 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57DCALD647120666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 12:10:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 695C720040;
	Wed, 13 Aug 2025 12:10:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F397020043;
	Wed, 13 Aug 2025 12:10:20 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.48.128])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Aug 2025 12:10:20 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: Clobber a lot of registers in tailcall_bpf2bpf_hierarchy tests
Date: Wed, 13 Aug 2025 14:06:31 +0200
Message-ID: <20250813121016.163375-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813121016.163375-1-iii@linux.ibm.com>
References: <20250813121016.163375-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIxOSBTYWx0ZWRfX/OVvSe0Gq5jY
 H5wm0p+0Vs812nFC3ukWbUu8Gq3+U2dfS4en7XzK8qRPoJISzeUauwMUdI8PgCa6bzd4U4a8aW2
 l3Jh9Cww0ObvAarFE3Ijop+Ct0d5Qs9CBlVavj3sk884QXzVqrc68qlBesIj4bI20oAbfcpWWY/
 RLE8St1NkZVwln+6ZypTNA0wToZXDrWzYQ6V1uxQE0wGynmlHfOJR9yhFleD95BANYSRrf1zbsD
 gcwYZoxaS7v1/tvRB5C+lwDiO6aqUY6Fhhx1E0V8jsrgvxUNgabHJO2xnH0BuBvs1VRsPvwutkm
 grB6XzulMRfX498LPCGw8gqDAC0BM8QOkYYB9J54Fj7ZSbxEsjBECL9waloJ/kVzQSRvIguV3Ni
 QiHM4HC5
X-Authority-Analysis: v=2.4 cv=GrpC+l1C c=1 sm=1 tr=0 ts=689c80b2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=2tKzcRxnJs9P0dnzzyQA:9
X-Proofpoint-GUID: HXBLR68T_Z5lR6ML_5zdV-fsK-qIi7jD
X-Proofpoint-ORIG-GUID: HXBLR68T_Z5lR6ML_5zdV-fsK-qIi7jD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120219

Clobbering a lot of registers and stack slots helps exposing tail call
counter overwrite bugs in JITs.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../selftests/bpf/progs/bpf_test_utils.h       | 18 ++++++++++++++++++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy1.c    |  3 +++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy2.c    |  3 +++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy3.c    |  3 +++
 .../progs/tailcall_bpf2bpf_hierarchy_fentry.c  |  3 +++
 5 files changed, 30 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_test_utils.h

diff --git a/tools/testing/selftests/bpf/progs/bpf_test_utils.h b/tools/testing/selftests/bpf/progs/bpf_test_utils.h
new file mode 100644
index 000000000000..f4e67b492dd2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_test_utils.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BPF_TEST_UTILS_H__
+#define __BPF_TEST_UTILS_H__
+
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/* Clobber as many native registers and stack slots as possible. */
+static __always_inline void clobber_regs_stack(void)
+{
+	char tmp_str[] = "123456789";
+	unsigned long tmp;
+
+	bpf_strtoul(tmp_str, sizeof(tmp_str), 0, &tmp);
+	__sink(tmp);
+}
+
+#endif
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
index 327ca395e860..d556b19413d7 100644
--- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
@@ -2,6 +2,7 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_legacy.h"
+#include "bpf_test_utils.h"
 
 struct {
 	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
@@ -24,6 +25,8 @@ int entry(struct __sk_buff *skb)
 {
 	int ret = 1;
 
+	clobber_regs_stack();
+
 	count++;
 	subprog_tail(skb);
 	subprog_tail(skb);
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
index 72fd0d577506..ae94c9c70ab7 100644
--- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
@@ -2,6 +2,7 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
+#include "bpf_test_utils.h"
 
 int classifier_0(struct __sk_buff *skb);
 int classifier_1(struct __sk_buff *skb);
@@ -60,6 +61,8 @@ int tailcall_bpf2bpf_hierarchy_2(struct __sk_buff *skb)
 {
 	int ret = 0;
 
+	clobber_regs_stack();
+
 	subprog_tail0(skb);
 	subprog_tail1(skb);
 
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
index a7fb91cb05b7..56b6b0099840 100644
--- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
@@ -2,6 +2,7 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
+#include "bpf_test_utils.h"
 
 int classifier_0(struct __sk_buff *skb);
 
@@ -53,6 +54,8 @@ int tailcall_bpf2bpf_hierarchy_3(struct __sk_buff *skb)
 {
 	int ret = 0;
 
+	clobber_regs_stack();
+
 	bpf_tail_call_static(skb, &jmp_table0, 0);
 
 	__sink(ret);
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_fentry.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_fentry.c
index c87f9ca982d3..5261395713cd 100644
--- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_fentry.c
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_fentry.c
@@ -4,6 +4,7 @@
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
+#include "bpf_test_utils.h"
 
 struct {
 	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
@@ -24,6 +25,8 @@ int subprog_tail(void *ctx)
 SEC("fentry/dummy")
 int BPF_PROG(fentry, struct sk_buff *skb)
 {
+	clobber_regs_stack();
+
 	count++;
 	subprog_tail(ctx);
 	subprog_tail(ctx);
-- 
2.50.1


