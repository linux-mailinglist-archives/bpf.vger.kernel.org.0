Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29250244015
	for <lists+bpf@lfdr.de>; Thu, 13 Aug 2020 22:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgHMUuS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Aug 2020 16:50:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:65122 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726522AbgHMUuQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Aug 2020 16:50:16 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07DKjfhi012685
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2020 13:50:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=xlKJFWlB+04ldRTWzzBPgR810/7GPQGv3npTM4pfkcs=;
 b=LjxJyn2tDKHhJyeZVcL+eoXNsD4uMnQiU0FyC8bktigqxST63qAnm2SH8spl3GkA/4fL
 4R9WN/Na7THAc+7AzjbNF9uWeTKh+BMwCXvGjyN28dhsM+ypp81cP/Am/22v+gs1QhM4
 Q8gp5r40zWOPKkDkJbG23kvPbEW54D09PTE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32wag38su2-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2020 13:50:15 -0700
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 13 Aug 2020 13:50:13 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 9A2392EC597F; Thu, 13 Aug 2020 13:50:10 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 bpf 9/9] selftests/bpf: make test_varlen work with 32-bit user-space arch
Date:   Thu, 13 Aug 2020 13:49:45 -0700
Message-ID: <20200813204945.1020225-10-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200813204945.1020225-1-andriin@fb.com>
References: <20200813204945.1020225-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-13_17:2020-08-13,2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=636 suspectscore=8 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008130148
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Despite bpftool generating data section memory layout that will work for
32-bit architectures on user-space side, BPF programs should be careful t=
o not
use ambiguous types like `long`, which have different size in 32-bit and
64-bit environments. Fix that in test by using __u64 explicitly, which is
a recommended approach anyway.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/varlen.c | 8 ++++----
 tools/testing/selftests/bpf/progs/test_varlen.c | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/varlen.c b/tools/test=
ing/selftests/bpf/prog_tests/varlen.c
index c75525eab02c..dd324b4933db 100644
--- a/tools/testing/selftests/bpf/prog_tests/varlen.c
+++ b/tools/testing/selftests/bpf/prog_tests/varlen.c
@@ -44,25 +44,25 @@ void test_varlen(void)
 	CHECK_VAL(bss->payload1_len2, size2);
 	CHECK_VAL(bss->total1, size1 + size2);
 	CHECK(memcmp(bss->payload1, exp_str, size1 + size2), "content_check",
-	      "doesn't match!");
+	      "doesn't match!\n");
=20
 	CHECK_VAL(data->payload2_len1, size1);
 	CHECK_VAL(data->payload2_len2, size2);
 	CHECK_VAL(data->total2, size1 + size2);
 	CHECK(memcmp(data->payload2, exp_str, size1 + size2), "content_check",
-	      "doesn't match!");
+	      "doesn't match!\n");
=20
 	CHECK_VAL(data->payload3_len1, size1);
 	CHECK_VAL(data->payload3_len2, size2);
 	CHECK_VAL(data->total3, size1 + size2);
 	CHECK(memcmp(data->payload3, exp_str, size1 + size2), "content_check",
-	      "doesn't match!");
+	      "doesn't match!\n");
=20
 	CHECK_VAL(data->payload4_len1, size1);
 	CHECK_VAL(data->payload4_len2, size2);
 	CHECK_VAL(data->total4, size1 + size2);
 	CHECK(memcmp(data->payload4, exp_str, size1 + size2), "content_check",
-	      "doesn't match!");
+	      "doesn't match!\n");
 cleanup:
 	test_varlen__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_varlen.c b/tools/test=
ing/selftests/bpf/progs/test_varlen.c
index cd4b72c55dfe..913acdffd90f 100644
--- a/tools/testing/selftests/bpf/progs/test_varlen.c
+++ b/tools/testing/selftests/bpf/progs/test_varlen.c
@@ -15,9 +15,9 @@ int test_pid =3D 0;
 bool capture =3D false;
=20
 /* .bss */
-long payload1_len1 =3D 0;
-long payload1_len2 =3D 0;
-long total1 =3D 0;
+__u64 payload1_len1 =3D 0;
+__u64 payload1_len2 =3D 0;
+__u64 total1 =3D 0;
 char payload1[MAX_LEN + MAX_LEN] =3D {};
=20
 /* .data */
--=20
2.24.1

