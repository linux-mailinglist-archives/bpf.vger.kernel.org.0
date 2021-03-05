Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA99C32F0C8
	for <lists+bpf@lfdr.de>; Fri,  5 Mar 2021 18:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhCERJc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Mar 2021 12:09:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231467AbhCERJJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Mar 2021 12:09:09 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 125H2ghV190164;
        Fri, 5 Mar 2021 12:08:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vOU9wInKEXYMRbalB+XrithlvgRCge9dPiVboM/TXjE=;
 b=cCj1aKJvSeXRwEaO5qZZf2XgKFNwuh06dkWYb/n6LOKjtMIyke/J8xSwxHSQBZZ6tdAf
 AjUcPd0dVE4DYR4ZooWlIixxGTdeGVdXgzBjTfYaGCgeLGvz+2uHHpPKnqol0hUV0uR8
 ymeAVp3R7NlAwzSKQ+7iWUEVAG7atK2akBg2xWNZaFuOAbO2/4JQqH0hIM7dX/ZJ0fwM
 3vfS44BOr+KMuTNHPFn1nt72XS0bZKXyPI41yWQkZNCZyHDfyu/pnh3MRXaQI2SeAUSQ
 UAJJPXrgmn447pnL8xDY7gvVDrMydlR8Nvhq4FfghoouK9JtQ37NAOUqhaszixNkh4ch Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 373rds0r7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 12:08:58 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 125H57Kt008787;
        Fri, 5 Mar 2021 12:08:57 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 373rds0r6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 12:08:57 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 125H7FsR013397;
        Fri, 5 Mar 2021 17:08:55 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 37150ct09d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 17:08:55 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 125H8bLY16187690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Mar 2021 17:08:37 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48A99A4055;
        Fri,  5 Mar 2021 17:08:52 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1F4FA404D;
        Fri,  5 Mar 2021 17:08:51 +0000 (GMT)
Received: from vm.lan (unknown [9.145.31.74])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  5 Mar 2021 17:08:51 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH bpf-next 1/2] selftests/bpf: Add BTF_KIND_FLOAT to test_core_reloc_size
Date:   Fri,  5 Mar 2021 18:08:43 +0100
Message-Id: <20210305170844.151594-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210305170844.151594-1-iii@linux.ibm.com>
References: <20210305170844.151594-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_10:2021-03-03,2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103050086
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
index 9a2850850121..3a2149c5863c 100644
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
+	float float_field;
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

