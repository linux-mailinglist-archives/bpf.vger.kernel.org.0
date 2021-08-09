Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9979A3E500A
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 01:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbhHIXhX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 19:37:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42000 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234746AbhHIXhW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 9 Aug 2021 19:37:22 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179NYKCl024454
        for <bpf@vger.kernel.org>; Mon, 9 Aug 2021 16:37:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=1OL3r+uAeSJ2PqDyNQVAuQwvQEkbBS2nQq3HypXa/sI=;
 b=em6sEO6hllQB4j69eQie7Cf5ViU3X0ai9WPlLDfWLqrQWoYkRapdrNYJWZLvEsyFiR9R
 y4a2DhrUf6xyVj9cfpBihHcZu5LPAbXOb1JotaxiYZZn5FnVcKDOAjV6G022J94fYq+V
 ZrptGsXldwgR9Gjs7beXUuhnwupHzlKCo70= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3abaa11awk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 16:37:00 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 16:36:59 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id AFC421E27904; Mon,  9 Aug 2021 16:36:55 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <sunyucong@gmail.com>,
        Yucong Sun <fallentree@fb.com>
Subject: [PATCH bpf-next 5/5] Record all failed tests and output after the summary line.
Date:   Mon, 9 Aug 2021 16:36:33 -0700
Message-ID: <20210809233633.973638-5-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809233633.973638-1-fallentree@fb.com>
References: <20210809233633.973638-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 3IiQRB25Q03agrbCNsEDnsjEDVaTmbTK
X-Proofpoint-GUID: 3IiQRB25Q03agrbCNsEDnsjEDVaTmbTK
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_09:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxlogscore=893 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090166
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch records all failed tests and subtests during the run, output t=
hem after the summary line, making it easier to identify failed tests in =
the long output.

Signed-off-by: Yucong Sun <fallentree@fb.com>
---
 tools/testing/selftests/bpf/test_progs.c | 25 +++++++++++++++++++++++-
 tools/testing/selftests/bpf/test_progs.h |  2 ++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index 5cc808992b00..51a70031f07e 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -244,6 +244,11 @@ void test__end_subtest()
 	       test->test_num, test->subtest_num, test->subtest_name,
 	       sub_error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
=20
+	if (sub_error_cnt) {
+		fprintf(env.summary_errors, "#%d/%d %s: FAIL\n",
+			test->test_num, test->subtest_num, test->subtest_name);
+	}
+
 	if (sub_error_cnt)
 		env.fail_cnt++;
 	else if (test->skip_cnt =3D=3D 0)
@@ -816,6 +821,10 @@ int main(int argc, char **argv)
 		.sa_flags =3D SA_RESETHAND,
 	};
 	int err, i;
+	/* record errors to print after summary line */
+	char *summary_errors_buf;
+	size_t summary_errors_cnt;
+
=20
 	sigaction(SIGSEGV, &sigact, NULL);
=20
@@ -823,6 +832,9 @@ int main(int argc, char **argv)
 	if (err)
 		return err;
=20
+	env.summary_errors =3D open_memstream(
+		&summary_errors_buf, &summary_errors_cnt);
+
 	err =3D cd_flavor_subdir(argv[0]);
 	if (err)
 		return err;
@@ -891,6 +903,11 @@ int main(int argc, char **argv)
 			test->test_num, test->test_name,
 			test->error_cnt ? "FAIL" : "OK");
=20
+		if(test->error_cnt) {
+			fprintf(env.summary_errors, "#%d %s: FAIL\n",
+				test->test_num, test->test_name);
+		}
+
 		reset_affinity();
 		restore_netns();
 		if (test->need_cgroup_cleanup)
@@ -908,9 +925,14 @@ int main(int argc, char **argv)
 	if (env.list_test_names)
 		goto out;
=20
-	fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
+	fprintf(stdout, "\nSummary: %d/%d PASSED, %d SKIPPED, %d FAILED\n\n",
 		env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
=20
+	fclose(env.summary_errors);
+	if(env.fail_cnt) {
+		fprintf(stdout, "%s", summary_errors_buf);
+	}
+
 out:
 	free_str_set(&env.test_selector.blacklist);
 	free_str_set(&env.test_selector.whitelist);
@@ -919,6 +941,7 @@ int main(int argc, char **argv)
 	free_str_set(&env.subtest_selector.whitelist);
 	free(env.subtest_selector.num_set);
 	close(env.saved_netns_fd);
+	free(summary_errors_buf);
=20
 	if (env.succ_cnt + env.fail_cnt + env.skip_cnt =3D=3D 0)
 		return EXIT_NO_TEST;
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/sel=
ftests/bpf/test_progs.h
index c8c2bf878f67..63f4e534c6e5 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -82,6 +82,8 @@ struct test_env {
 	int skip_cnt; /* skipped tests */
=20
 	int saved_netns_fd;
+
+	FILE* summary_errors;
 };
=20
 extern struct test_env env;
--=20
2.30.2

