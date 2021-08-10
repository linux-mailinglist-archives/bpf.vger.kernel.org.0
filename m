Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA013E504E
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 02:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbhHJAR4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 20:17:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62626 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236124AbhHJARz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 9 Aug 2021 20:17:55 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17A0DrWd027181
        for <bpf@vger.kernel.org>; Mon, 9 Aug 2021 17:17:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=WZ3VN32/Y5TVisYde9Xm0GuNFBpxMSph6z5teIZnSfk=;
 b=m94RmmzAju04sYakkPgq5aRzkWcBz9ZgcEWV91MRqRD8XcI7vg8ieDeT1oDg7fLEjihI
 3g8WYtj0Rr1d+Pk/6hyF5qfVW0y1qfM2rAcTRX7BfQepMttqZlBrk2PBt67k1vadOBvk
 BS3UXRhcBaO/FzGT2yZnK3Ox2OzdrV6b/+A= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3abdp30awf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 17:17:34 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 17:17:34 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 395261E2CB6C; Mon,  9 Aug 2021 17:17:25 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <sunyucong@gmail.com>,
        Yucong Sun <fallentree@fb.com>
Subject: [PATCH v2 bpf-next 3/5] Correctly display subtest skip status
Date:   Mon, 9 Aug 2021 17:16:23 -0700
Message-ID: <20210810001625.1140255-4-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210810001625.1140255-1-fallentree@fb.com>
References: <20210810001625.1140255-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: ceP_gLwLh-jA7QuoZj72P8bPstnFzFzC
X-Proofpoint-ORIG-GUID: ceP_gLwLh-jA7QuoZj72P8bPstnFzFzC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_09:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 bulkscore=0
 mlxlogscore=850 phishscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108100000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In skip_account(), test->skip_cnt is set to 0 at the end, this makes
next print statement never display SKIP status for the subtest. This
patch moves the accounting logic after the print statement, fixing the
issue.

Signed-off-by: Yucong Sun <fallentree@fb.com>
---
 tools/testing/selftests/bpf/test_progs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index c5bffd2e78ae..82d012671552 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -238,18 +238,18 @@ void test__end_subtest()
 	struct prog_test_def *test =3D env.test;
 	int sub_error_cnt =3D test->error_cnt - test->old_error_cnt;
=20
-	if (sub_error_cnt)
-		env.fail_cnt++;
-	else if (test->skip_cnt =3D=3D 0)
-		env.sub_succ_cnt++;
-	skip_account();
-
 	dump_test_log(test, sub_error_cnt);
=20
 	fprintf(env.stdout, "#%d/%d %s:%s\n",
 	       test->test_num, test->subtest_num, test->subtest_name,
 	       sub_error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
=20
+	if (sub_error_cnt)
+		env.fail_cnt++;
+	else if (test->skip_cnt =3D=3D 0)
+		env.sub_succ_cnt++;
+	skip_account();
+
 	free(test->subtest_name);
 	test->subtest_name =3D NULL;
 }
--=20
2.30.2

