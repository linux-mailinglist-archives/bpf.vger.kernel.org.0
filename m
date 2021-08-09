Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9476C3E500D
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 01:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbhHIXh1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 19:37:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:31282 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237017AbhHIXh0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 9 Aug 2021 19:37:26 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179NZbdQ014597
        for <bpf@vger.kernel.org>; Mon, 9 Aug 2021 16:37:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=mJf4HXvAQBOkj1nldbfRYpqoF6qvSH2SIpXRhHs0dpE=;
 b=q21yb6fLWr8Lcn4WlPqi5luFq245KR8PPKI1nX2d5hT6a3d49srApkUL1c8CCFF3jTh/
 L52Vg3+bI8tKXokx92AdB2yQYVDAA39J7Czv8bYfcS7U8DnZACGh0NKhRqgxAP+KQd5C
 xAuSXpYrDmJgqGDZ84dBbY78ihrWzS40Yno= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3a9qvnv02r-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 16:37:04 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 16:37:01 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id A756D1E27900; Mon,  9 Aug 2021 16:36:55 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <sunyucong@gmail.com>,
        Yucong Sun <fallentree@fb.com>
Subject: [PATCH bpf-next 3/5] Correctly display subtest skip status
Date:   Mon, 9 Aug 2021 16:36:31 -0700
Message-ID: <20210809233633.973638-3-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809233633.973638-1-fallentree@fb.com>
References: <20210809233633.973638-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 1SYrCyrCkCjX7Ac2RTp7hF2b4nFMeMZI
X-Proofpoint-ORIG-GUID: 1SYrCyrCkCjX7Ac2RTp7hF2b4nFMeMZI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_09:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxlogscore=827 priorityscore=1501
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108090166
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In skip_account(), test->skip_cnt is set to 0 at the end, this makes next=
 print statment never display SKIP status for the subtest. This patch mov=
es the accounting logic after the print statement, fixing the issue.
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

