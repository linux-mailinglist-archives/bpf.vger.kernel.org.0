Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC775426F94
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 19:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhJHRdl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 13:33:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:21928 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237468AbhJHRdl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 8 Oct 2021 13:33:41 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 198HLEZN006666
        for <bpf@vger.kernel.org>; Fri, 8 Oct 2021 10:31:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=MtxRV8zxbngpGluKNzQ48hpqYGWgWoqnWTzJVBQVygk=;
 b=h0tyysJVXU0JgJ2/4KQ35DY6Ik6T11Cpqar3w95BtNz8XJFyn/tuYOT1nMYs3qh4e5kx
 9qx4Op745vSi7SufxK8kLqSY8loQep6gWvvjB4+Hc6iEvpNDZIhOlR4oy0fZ5ZqROChj
 stJEMNYnzz/65v2yjuRz1PEmKKH2fa2D4GI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bjtac02k2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 10:31:45 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 8 Oct 2021 10:31:41 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 021AF4ECB82F; Fri,  8 Oct 2021 10:31:40 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <sunyucong@gmail.com>
Subject: [PATCH bpf-next] selftest/bpf: fix btf_dump test under new clang
Date:   Fri, 8 Oct 2021 10:31:39 -0700
Message-ID: <20211008173139.1457407-1-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: Z4lMc14Qtp0rCJLwy75NxGSVqK-SHs3l
X-Proofpoint-GUID: Z4lMc14Qtp0rCJLwy75NxGSVqK-SHs3l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-08_05,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 mlxlogscore=515 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110080097
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yucong Sun <sunyucong@gmail.com>

New clang version changed type name in dwarf from "long int" to "long",
this is causing btf_dump tests to fail.

Signed-off-by: Yucong Sun <sunyucong@gmail.com>
---
 .../selftests/bpf/progs/btf_dump_test_case_bitfields.c | 10 +++++-----
 .../selftests/bpf/progs/btf_dump_test_case_packing.c   |  4 ++--
 .../selftests/bpf/progs/btf_dump_test_case_padding.c   |  2 +-
 .../selftests/bpf/progs/btf_dump_test_case_syntax.c    |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_bitfiel=
ds.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_bitfields.c
index 8f44767a75fa..e5560a656030 100644
--- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_bitfields.c
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_bitfields.c
@@ -11,7 +11,7 @@
 /*
  *struct bitfields_only_mixed_types {
  *	int a: 3;
- *	long int b: 2;
+ *	long b: 2;
  *	_Bool c: 1;
  *	enum {
  *		A =3D 0,
@@ -27,7 +27,7 @@
=20
 struct bitfields_only_mixed_types {
 	int a: 3;
-	long int b: 2;
+	long b: 2;
 	bool c: 1; /* it's really a _Bool type */
 	enum {
 		A, /* A =3D 0, dumper is very explicit */
@@ -44,8 +44,8 @@ struct bitfields_only_mixed_types {
  *	char: 4;
  *	int a: 4;
  *	short b;
- *	long int c;
- *	long int d: 8;
+ *	long c;
+ *	long d: 8;
  *	int e;
  *	int f;
  *};
@@ -71,7 +71,7 @@ struct bitfield_mixed_with_others {
  *struct bitfield_flushed {
  *	int a: 4;
  *	long: 60;
- *	long int b: 16;
+ *	long b: 16;
  *};
  *
  */
diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_packing=
.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_packing.c
index 1cef3bec1dc7..e304b6204bd9 100644
--- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_packing.c
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_packing.c
@@ -29,7 +29,7 @@ struct non_packed_fields {
 struct nested_packed {
 	char: 4;
 	int a: 4;
-	long int b;
+	long b;
 	struct {
 		char c;
 		int d;
@@ -44,7 +44,7 @@ union union_is_never_packed {
=20
 union union_does_not_need_packing {
 	struct {
-		long int a;
+		long a;
 		int b;
 	} __attribute__((packed));
 	int c;
diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding=
.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
index 35c512818a56..f2661c8d2d90 100644
--- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
@@ -9,7 +9,7 @@
 /* ----- START-EXPECTED-OUTPUT ----- */
 struct padded_implicitly {
 	int a;
-	long int b;
+	long b;
 	char c;
 };
=20
diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.=
c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
index 8aaa24a00322..1c7105fcae3c 100644
--- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
@@ -189,7 +189,7 @@ struct struct_with_embedded_stuff {
 			const char *d;
 		} e;
 		union {
-			volatile long int f;
+			volatile long f;
 			void * restrict g;
 		};
 	};
--=20
2.30.2

