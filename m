Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46BE23E5050
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 02:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbhHJAR5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 20:17:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57940 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236124AbhHJAR4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 9 Aug 2021 20:17:56 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 17A0D1pU012610
        for <bpf@vger.kernel.org>; Mon, 9 Aug 2021 17:17:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=WtyLkZn7i/eLfXS8/FLa7u0rPdNbli2nCleZ2TUQUN4=;
 b=WNuxIPSYQkiQC2c0LCgoCXnDbNasTog8MXAu6CVw5I65dFBbr7hqp0q5uEd2UipkeBzT
 ktl62I1xSgQnTxH62aXAYr29T43+M9GbtRH7LHY9udU+z7n33WQ2dfaQjGI0ghicq0CP
 9/YyA+y/5q+XeintA/4p6B/6ZRtVVCa+8to= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3abbsqry8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 17:17:35 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 17:17:34 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 42DC21E2CB70; Mon,  9 Aug 2021 17:17:25 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <sunyucong@gmail.com>,
        Yucong Sun <fallentree@fb.com>
Subject: [PATCH v2 bpf-next 5/5] Record all failed tests and output after the summary line.
Date:   Mon, 9 Aug 2021 17:16:25 -0700
Message-ID: <20210810001625.1140255-6-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210810001625.1140255-1-fallentree@fb.com>
References: <20210810001625.1140255-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: h4YYVPn-r1MdOV_pUzokWpASRnCyAa0V
X-Proofpoint-ORIG-GUID: h4YYVPn-r1MdOV_pUzokWpASRnCyAa0V
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_09:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 mlxlogscore=885 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108100000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch records all failed tests and subtests during the run, output
them after the summary line, making it easier to identify failed tests
in the long output.

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

