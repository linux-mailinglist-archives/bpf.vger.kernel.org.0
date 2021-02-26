Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB96D3268AE
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 21:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhBZUZF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 15:25:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29320 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230493AbhBZUYH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 15:24:07 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QK3263087452;
        Fri, 26 Feb 2021 15:23:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=OuPrNZusVWho52qWCk4ji8ZwH+lRegN6DzBhQ9zOyac=;
 b=kBRlPw8Nowyb0lQDq/GUxSUuuYA69FcWgz4jt902GfgimY/waHh/d9GdYEud3oLOurDJ
 5tg5cuCubChok+F0jqS3GukFlF98658Js5CF5VIxAbOJXy1bqwScJ6b/OASQTF+Ei/Qe
 KT+qpVfiYyosMhGHXKZ7ZOiwbFc8nE0QjHrPKdjpe1nVcsAoMwZ55dT1Dxc0dhwBH5CY
 RVNSyzd4tvmh+lRrKqb8+wN500NfeXbtNt2xyu1c+ykN2Z5uQ4ypByjqLAsX179kPjEF
 AzUllFSo5/KSsMPJZ/FlWfVDgyK3Xn4HoyLe//Fvmj+AZaWdOU0bwou1wJvSItUjhf8p xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36y3x800mf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 15:23:15 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11QKARDN112704;
        Fri, 26 Feb 2021 15:23:14 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36y3x800kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 15:23:14 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11QKMVaT023521;
        Fri, 26 Feb 2021 20:23:12 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 36y223g8mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 20:23:12 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11QKN9IP918140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 20:23:09 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FFF711C04A;
        Fri, 26 Feb 2021 20:23:09 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFBEC11C04C;
        Fri, 26 Feb 2021 20:23:08 +0000 (GMT)
Received: from vm.lan (unknown [9.145.151.190])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 26 Feb 2021 20:23:08 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v7 bpf-next 09/10] selftests/bpf: Add BTF_KIND_FLOAT to test_core_reloc_size
Date:   Fri, 26 Feb 2021 21:22:55 +0100
Message-Id: <20210226202256.116518-10-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210226202256.116518-1-iii@linux.ibm.com>
References: <20210226202256.116518-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_07:2021-02-26,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260143
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Verify that bpf_core_field_size() is working correctly with floats.

Suggested-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/prog_tests/core_reloc.c      | 1 +
 tools/testing/selftests/bpf/progs/core_reloc_types.h     | 5 +++++
 tools/testing/selftests/bpf/progs/test_core_reloc_size.c | 3 +++
 3 files changed, 9 insertions(+)

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

