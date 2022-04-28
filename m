Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07091513ED2
	for <lists+bpf@lfdr.de>; Fri, 29 Apr 2022 01:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353087AbiD1XDO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 19:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353115AbiD1XDM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 19:03:12 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26A3C1CBE
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 15:59:55 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 23SLRsw0004423
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 15:59:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=HOBL022biVjWRW/6RDlSCvkDDv4J7Gd6v4Els1PMOYo=;
 b=GumGezX6Q3tq2JHBWo6ge3lSo2FZemnVqUzpeKAUh2AbP4SG1K4jYDCkwa62EjJPFnPz
 YFBsVfl1JZst15HSUWyKpWw685dqpcJkOX9vk4yxEYwRaQtqAGXxBxEH6a1X/2zM12sl
 YmB6SwT/KtBLh+U6+1ttgY7dbgv1oOXwASU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3fr2mc0ne6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 15:59:54 -0700
Received: from twshared13345.18.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 15:59:53 -0700
Received: by devvm4897.frc0.facebook.com (Postfix, from userid 537053)
        id E92FB6591D7F; Thu, 28 Apr 2022 15:59:46 -0700 (PDT)
From:   Mykola Lysenko <mykolal@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Mykola Lysenko <mykolal@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: fix two memory leaks in prog_tests
Date:   Thu, 28 Apr 2022 15:57:44 -0700
Message-ID: <20220428225744.1961643-1-mykolal@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: T4IH2hpBD6KPLrzrW6FKZq6hDiqUAZYd
X-Proofpoint-GUID: T4IH2hpBD6KPLrzrW6FKZq6hDiqUAZYd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-28_05,2022-04-28_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix log_fp memory leak in dispatch_thread_read_log.
Remove obsolete log_fp clean-up code in dispatch_thread.

Also, release memory of subtest_selector. This can be
reproduced with -n 2/1 parameters.

Signed-off-by: Mykola Lysenko <mykolal@fb.com>
---
 tools/testing/selftests/bpf/test_progs.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index 22fe283710fa..a07da648af3b 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -77,10 +77,12 @@ static void stdio_restore_cleanup(void)
=20
 	if (env.subtest_state) {
 		fclose(env.subtest_state->stdout);
+		env.subtest_state->stdout =3D NULL;
 		stdout =3D env.test_state->stdout;
 		stderr =3D env.test_state->stdout;
 	} else {
 		fclose(env.test_state->stdout);
+		env.test_state->stdout =3D NULL;
 	}
 #endif
 }
@@ -1077,6 +1079,7 @@ static int read_prog_test_msg(int sock_fd, struct m=
sg *msg, enum msg_type type)
 static int dispatch_thread_read_log(int sock_fd, char **log_buf, size_t =
*log_cnt)
 {
 	FILE *log_fp =3D NULL;
+	int result =3D 0;
=20
 	log_fp =3D open_memstream(log_buf, log_cnt);
 	if (!log_fp)
@@ -1085,16 +1088,20 @@ static int dispatch_thread_read_log(int sock_fd, =
char **log_buf, size_t *log_cnt
 	while (true) {
 		struct msg msg;
=20
-		if (read_prog_test_msg(sock_fd, &msg, MSG_TEST_LOG))
-			return 1;
+		if (read_prog_test_msg(sock_fd, &msg, MSG_TEST_LOG)) {
+			result =3D 1;
+			goto out;
+		}
=20
 		fprintf(log_fp, "%s", msg.test_log.log_buf);
 		if (msg.test_log.is_last)
 			break;
 	}
+
+out:
 	fclose(log_fp);
 	log_fp =3D NULL;
-	return 0;
+	return result;
 }
=20
 static int dispatch_thread_send_subtests(int sock_fd, struct test_state =
*state)
@@ -1132,7 +1139,6 @@ static void *dispatch_thread(void *ctx)
 {
 	struct dispatch_data *data =3D ctx;
 	int sock_fd;
-	FILE *log_fp =3D NULL;
=20
 	sock_fd =3D data->sock_fd;
=20
@@ -1214,8 +1220,6 @@ static void *dispatch_thread(void *ctx)
 	if (env.debug)
 		fprintf(stderr, "[%d]: Protocol/IO error: %s.\n", data->worker_id, str=
error(errno));
=20
-	if (log_fp)
-		fclose(log_fp);
 done:
 	{
 		struct msg msg_exit;
@@ -1685,6 +1689,7 @@ int main(int argc, char **argv)
 		unload_bpf_testmod();
=20
 	free_test_selector(&env.test_selector);
+	free_test_selector(&env.subtest_selector);
 	free_test_states();
=20
 	if (env.succ_cnt + env.fail_cnt + env.skip_cnt =3D=3D 0)
--=20
2.30.2

