Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB433EE5D9
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 06:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbhHQEsO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Aug 2021 00:48:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59010 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231285AbhHQEsN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 17 Aug 2021 00:48:13 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17H4isCJ023708
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 21:47:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=T1RfjzphPc4MrY7X7bEvKN9M3unnVbQ77EFxwXpA4Zw=;
 b=GYAV+Y0MfKJ1jOQBc4jyaG/XYmS6zSs6reOmBLhySItr7JRCDaPIj2Av9aksbTOx8MKI
 YWymS24LGkv6zzAZ0uRMIsrVEk5++SSA/jitmeGponXRt7mzK+sMi/AHKu0Ia6KRI+ZX
 +crnyJBGtWsgc78uJVqP+Bq0kUXHF+6DcZc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3afj4d6ycw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 21:47:40 -0700
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 21:47:39 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id ED5E822A241A; Mon, 16 Aug 2021 21:47:36 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <andrii@kernel.org>
CC:     <sunyucong@gmail.com>, <bpf@vger.kernel.org>,
        Yucong Sun <fallentree@fb.com>
Subject: [PATCH v5 bpf-next 2/4] selftests/bpf: correctly display subtest skip status
Date:   Mon, 16 Aug 2021 21:47:30 -0700
Message-ID: <20210817044732.3263066-3-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210817044732.3263066-1-fallentree@fb.com>
References: <20210817044732.3263066-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 9VsKtI92KdzQdk45b6b7IfKjH0NYQ1Bf
X-Proofpoint-ORIG-GUID: 9VsKtI92KdzQdk45b6b7IfKjH0NYQ1Bf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-17_01:2021-08-16,2021-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108170029
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In skip_account(), test->skip_cnt is set to 0 at the end, this makes next=
 print
statement never display SKIP status for the subtest. This patch moves the
accounting logic after the print statement, fixing the issue.

This patch also added SKIP status display for normal tests.

Signed-off-by: Yucong Sun <fallentree@fb.com>
---
 tools/testing/selftests/bpf/test_progs.c | 25 ++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index 532af3353edf..f0fbead40883 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -148,18 +148,18 @@ void test__end_subtest()
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
@@ -786,17 +786,18 @@ int main(int argc, char **argv)
 			test__end_subtest();
=20
 		test->tested =3D true;
-		if (test->error_cnt)
-			env.fail_cnt++;
-		else
-			env.succ_cnt++;
-		skip_account();
=20
 		dump_test_log(test, test->error_cnt);
=20
 		fprintf(env.stdout, "#%d %s:%s\n",
 			test->test_num, test->test_name,
-			test->error_cnt ? "FAIL" : "OK");
+			test->error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
+
+		if (test->error_cnt)
+			env.fail_cnt++;
+		else
+			env.succ_cnt++;
+		skip_account();
=20
 		reset_affinity();
 		restore_netns();
--=20
2.30.2

