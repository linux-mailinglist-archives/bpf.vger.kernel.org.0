Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6E1331BF7
	for <lists+bpf@lfdr.de>; Tue,  9 Mar 2021 01:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbhCIA5n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Mar 2021 19:57:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37906 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229730AbhCIA5K (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Mar 2021 19:57:10 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1290Xi5e038376;
        Mon, 8 Mar 2021 19:56:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=NFDagCaGWJieaLSTWKv2A62REc73J7lvYPqrP0iY/Lw=;
 b=BGqPgYcsuI2jP4920ovZY4CfggnrNl2a9q1ntg4zQIM3RRLAcKwAYq3q7Gno1B1HN+ro
 Ih86nYwsY1wRfwWFJNlQLEVnyiOpkEmLS95PwtWVazbx+UDiBDl53ThKPy+jUS9aQ0vN
 r41mJ6h+wmxL/FpB9zCJCJRnZt/Ud5F5W4xLhkYnJKl/16E/kXlUg5HrneeoLqybeAgm
 s2Sqse8IEFCT+OT8WNeCwW1oqBT1/mm8/llEuYd8lUGBNlYjVSJlGrRoLsFRjOCmoaRg
 r5Ili26pSr8iEut/kfowN/5pwSC1fKbkVpWqWWgQsWozcpIQNFn/G0EzdH28BXxYX6gM uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 375whm1p23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 19:56:57 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1290Y2NQ039299;
        Mon, 8 Mar 2021 19:56:57 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 375whm1p1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 19:56:57 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1290rh3T002234;
        Tue, 9 Mar 2021 00:56:55 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3741c896a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 00:56:54 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1290upCR29753806
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Mar 2021 00:56:52 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1E44AE04D;
        Tue,  9 Mar 2021 00:56:51 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 673CFAE045;
        Tue,  9 Mar 2021 00:56:51 +0000 (GMT)
Received: from vm.lan (unknown [9.145.31.74])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Mar 2021 00:56:51 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH v2 bpf-next 1/2] selftests/bpf: Add BTF_KIND_FLOAT to test_core_reloc_size
Date:   Tue,  9 Mar 2021 01:56:48 +0100
Message-Id: <20210309005649.162480-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309005649.162480-1-iii@linux.ibm.com>
References: <20210309005649.162480-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-08_22:2021-03-08,2021-03-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103090000
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Verify that bpf_core_field_size() is working correctly with floats.
Also document the required clang version.

Suggested-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/README.rst                   | 9 +++++++++
 tools/testing/selftests/bpf/prog_tests/core_reloc.c      | 1 +
 tools/testing/selftests/bpf/progs/core_reloc_types.h     | 5 +++++
 tools/testing/selftests/bpf/progs/test_core_reloc_size.c | 3 +++
 4 files changed, 18 insertions(+)

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
index dbc8f6cc5c67..3464161c8eea 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -170,3 +170,12 @@ failures:
 .. _2: https://reviews.llvm.org/D85174
 .. _3: https://reviews.llvm.org/D83878
 .. _4: https://reviews.llvm.org/D83242
+
+Floating-point tests and Clang version
+======================================
+
+Certain selftests, e.g. core_reloc, require support for the floating-point
+types, which was introduced in `Clang 13`__. The older Clang versions will
+either crash when compiling these tests, or generate an incorrect BTF.
+
+__  https://reviews.llvm.org/D83289
diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index 06eb956ff7bb..d94dcead72e6 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -266,6 +266,7 @@ static int duration = 0;
 		.arr_elem_sz = sizeof(((type *)0)->arr_field[0]),	\
 		.ptr_sz = 8, /* always 8-byte pointer for BPF */	\
 		.enum_sz = sizeof(((type *)0)->enum_field),		\
+		.float_sz = sizeof(((type *)0)->float_field),		\
 	}
 
 #define SIZE_CASE(name) {						\
diff --git a/tools/testing/selftests/bpf/progs/core_reloc_types.h b/tools/testing/selftests/bpf/progs/core_reloc_types.h
index 9a2850850121..9982eb969048 100644
--- a/tools/testing/selftests/bpf/progs/core_reloc_types.h
+++ b/tools/testing/selftests/bpf/progs/core_reloc_types.h
@@ -807,6 +807,7 @@ struct core_reloc_size_output {
 	int arr_elem_sz;
 	int ptr_sz;
 	int enum_sz;
+	int float_sz;
 };
 
 struct core_reloc_size {
@@ -816,6 +817,7 @@ struct core_reloc_size {
 	int arr_field[4];
 	void *ptr_field;
 	enum { VALUE = 123 } enum_field;
+	float float_field;
 };
 
 struct core_reloc_size___diff_sz {
@@ -825,6 +827,7 @@ struct core_reloc_size___diff_sz {
 	char arr_field[10];
 	void *ptr_field;
 	enum { OTHER_VALUE = 0xFFFFFFFFFFFFFFFF } enum_field;
+	double float_field;
 };
 
 /* Error case of two candidates with the fields (int_field) at the same
@@ -839,6 +842,7 @@ struct core_reloc_size___err_ambiguous1 {
 	int arr_field[4];
 	void *ptr_field;
 	enum { VALUE___1 = 123 } enum_field;
+	float float_field;
 };
 
 struct core_reloc_size___err_ambiguous2 {
@@ -850,6 +854,7 @@ struct core_reloc_size___err_ambiguous2 {
 	int arr_field[4];
 	void *ptr_field;
 	enum { VALUE___2 = 123 } enum_field;
+	float float_field;
 };
 
 /*
diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_size.c b/tools/testing/selftests/bpf/progs/test_core_reloc_size.c
index d7fb6cfc7891..7b2d576aeea1 100644
--- a/tools/testing/selftests/bpf/progs/test_core_reloc_size.c
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_size.c
@@ -21,6 +21,7 @@ struct core_reloc_size_output {
 	int arr_elem_sz;
 	int ptr_sz;
 	int enum_sz;
+	int float_sz;
 };
 
 struct core_reloc_size {
@@ -30,6 +31,7 @@ struct core_reloc_size {
 	int arr_field[4];
 	void *ptr_field;
 	enum { VALUE = 123 } enum_field;
+	float float_field;
 };
 
 SEC("raw_tracepoint/sys_enter")
@@ -45,6 +47,7 @@ int test_core_size(void *ctx)
 	out->arr_elem_sz = bpf_core_field_size(in->arr_field[0]);
 	out->ptr_sz = bpf_core_field_size(in->ptr_field);
 	out->enum_sz = bpf_core_field_size(in->enum_field);
+	out->float_sz = bpf_core_field_size(in->float_field);
 
 	return 0;
 }
-- 
2.29.2

