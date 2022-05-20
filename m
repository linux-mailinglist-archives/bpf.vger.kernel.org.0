Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BA652E4E0
	for <lists+bpf@lfdr.de>; Fri, 20 May 2022 08:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241053AbiETGNr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 May 2022 02:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244622AbiETGNp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 02:13:45 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D3314C74F
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 23:13:45 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K3SaoN009597
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 23:13:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=m4+5lTMXcGHsAjjfr6bWFevXVvkNQPfbXKD1jtcCSPI=;
 b=HaHHx6ZGWQAZ06KNUWy4/QNLP4wj4W3Cog20MSmATxiTzc6X50BJM2FsyroxoW4tqG7y
 zNIA3V683uEr9pGT8JZ7V0xVvXwoWB2jL08zR8+5G6hBP/O3S/DKSy2is1VUcsiDryYD
 u1AibfaRcpEyrvn/Q+p7snVZkDyzQfiTEqw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g63418hv3-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 23:13:44 -0700
Received: from twshared11660.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 19 May 2022 23:13:42 -0700
Received: by devvm4897.frc0.facebook.com (Postfix, from userid 537053)
        id 88B1F7218CF3; Thu, 19 May 2022 23:13:39 -0700 (PDT)
From:   Mykola Lysenko <mykolal@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>
CC:     Mykola Lysenko <mykolal@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: remove filtered subtests from output
Date:   Thu, 19 May 2022 23:13:03 -0700
Message-ID: <20220520061303.4004808-1-mykolal@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: vNHDzXe5LC79Jx7YhYdsAuYALAA2evCQ
X-Proofpoint-ORIG-GUID: vNHDzXe5LC79Jx7YhYdsAuYALAA2evCQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_02,2022-05-19_03,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently filtered subtests show up in the output as skipped.

Before:
$ sudo ./test_progs -t log_fixup/missing_map
 #94 /1     log_fixup/bad_core_relo_trunc_none:SKIP
 #94 /2     log_fixup/bad_core_relo_trunc_partial:SKIP
 #94 /3     log_fixup/bad_core_relo_trunc_full:SKIP
 #94 /4     log_fixup/bad_core_relo_subprog:SKIP
 #94 /5     log_fixup/missing_map:OK
 #94        log_fixup:OK
Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

After:
$ sudo ./test_progs -t log_fixup/missing_map
 #94 /5     log_fixup/missing_map:OK
 #94        log_fixup:OK
Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Mykola Lysenko <mykolal@fb.com>
---
 tools/testing/selftests/bpf/test_progs.c | 8 ++++++--
 tools/testing/selftests/bpf/test_progs.h | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index a07da648af3b..ecf69fce036e 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -265,6 +265,7 @@ static void dump_test_log(const struct prog_test_def =
*test,
 	int i;
 	struct subtest_state *subtest_state;
 	bool subtest_failed;
+	bool subtest_filtered;
 	bool print_subtest;
=20
 	/* we do not print anything in the worker thread */
@@ -283,9 +284,10 @@ static void dump_test_log(const struct prog_test_def=
 *test,
 	for (i =3D 0; i < test_state->subtest_num; i++) {
 		subtest_state =3D &test_state->subtest_states[i];
 		subtest_failed =3D subtest_state->error_cnt;
+		subtest_filtered =3D subtest_state->filtered;
 		print_subtest =3D verbose() || force_log || subtest_failed;
=20
-		if (skip_ok_subtests && !subtest_failed)
+		if ((skip_ok_subtests && !subtest_failed) || subtest_filtered)
 			continue;
=20
 		if (subtest_state->log_cnt && print_subtest) {
@@ -417,7 +419,7 @@ bool test__start_subtest(const char *subtest_name)
 				state->subtest_num,
 				test->test_name,
 				subtest_name)) {
-		subtest_state->skipped =3D true;
+		subtest_state->filtered =3D true;
 		return false;
 	}
=20
@@ -1123,6 +1125,7 @@ static int dispatch_thread_send_subtests(int sock_f=
d, struct test_state *state)
 		subtest_state->name =3D strdup(msg.subtest_done.name);
 		subtest_state->error_cnt =3D msg.subtest_done.error_cnt;
 		subtest_state->skipped =3D msg.subtest_done.skipped;
+		subtest_state->filtered =3D msg.subtest_done.filtered;
=20
 		/* collect all logs */
 		if (msg.subtest_done.have_log)
@@ -1418,6 +1421,7 @@ static int worker_main_send_subtests(int sock, stru=
ct test_state *state)
=20
 		msg.subtest_done.error_cnt =3D subtest_state->error_cnt;
 		msg.subtest_done.skipped =3D subtest_state->skipped;
+		msg.subtest_done.filtered =3D subtest_state->filtered;
 		msg.subtest_done.have_log =3D false;
=20
 		if (verbose() || state->force_log || subtest_state->error_cnt) {
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/sel=
ftests/bpf/test_progs.h
index dd1b91d7985a..5fe1365c2bb1 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -70,6 +70,7 @@ struct subtest_state {
 	char *log_buf;
 	int error_cnt;
 	bool skipped;
+	bool filtered;
=20
 	FILE *stdout;
 };
@@ -156,6 +157,7 @@ struct msg {
 			char name[MAX_SUBTEST_NAME + 1];
 			int error_cnt;
 			bool skipped;
+			bool filtered;
 			bool have_log;
 		} subtest_done;
 	};
--=20
2.30.2

