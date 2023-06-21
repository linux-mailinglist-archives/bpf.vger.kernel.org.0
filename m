Return-Path: <bpf+bounces-3089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 545A4739327
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 01:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86CD31C20F9B
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 23:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1636E1DDC3;
	Wed, 21 Jun 2023 23:39:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9D61D2CF
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 23:39:12 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3521731
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 16:39:11 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LHcvse006275
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 16:39:11 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rbnr9hmwq-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 16:39:10 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 16:38:44 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 16:38:44 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id C8375333E8937; Wed, 21 Jun 2023 16:38:38 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>
CC: <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>, <cyphar@cyphar.com>,
        <luto@kernel.org>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v3 bpf-next 14/14] selftests/bpf: add BPF token-enabled BPF_PROG_LOAD tests
Date: Wed, 21 Jun 2023 16:38:09 -0700
Message-ID: <20230621233809.1941811-15-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621233809.1941811-1-andrii@kernel.org>
References: <20230621233809.1941811-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: fG_e4knRFLKuxjNvVd1EJ8zMp2WGr01W
X-Proofpoint-ORIG-GUID: fG_e4knRFLKuxjNvVd1EJ8zMp2WGr01W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_13,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a test validating that BPF token can be used to load privileged BPF
program using privileged BPF helpers through delegated BPF token created
by privileged process.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testi=
ng/selftests/bpf/prog_tests/token.c
index 113cd4786a70..415d49eacd4f 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -4,6 +4,7 @@
 #include <test_progs.h>
 #include <bpf/btf.h>
 #include "cap_helpers.h"
+#include <linux/filter.h>
=20
 static int drop_priv_caps(__u64 *old_caps)
 {
@@ -200,6 +201,69 @@ static void subtest_btf_token(void)
 		ASSERT_OK(restore_priv_caps(old_caps), "restore_caps");
 }
=20
+static void subtest_prog_token(void)
+{
+	LIBBPF_OPTS(bpf_token_create_opts, token_opts);
+	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts);
+	int token_fd =3D 0, prog_fd =3D 0, err;
+	__u64 old_caps =3D 0;
+	struct bpf_insn insns[] =3D {
+		/* bpf_jiffies64() requires CAP_BPF */
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
+		/* bpf_get_current_task() requires CAP_PERFMON */
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_current_task),
+		/* r0 =3D 0; exit; */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	size_t insn_cnt =3D ARRAY_SIZE(insns);
+
+	/* create BPF token allowing BPF_PROG_LOAD command */
+	token_opts.allowed_cmds =3D 1ULL << BPF_PROG_LOAD;
+	token_opts.allowed_prog_types =3D 1ULL << BPF_PROG_TYPE_XDP;
+	token_opts.allowed_attach_types =3D 1ULL << BPF_XDP;
+	err =3D bpf_token_create(-EBADF, TOKEN_PATH, &token_opts);
+	if (!ASSERT_OK(err, "token_create"))
+		return;
+
+	/* drop privileges to test token_fd passing */
+	if (!ASSERT_OK(drop_priv_caps(&old_caps), "drop_caps"))
+		goto cleanup;
+
+	token_fd =3D bpf_obj_get(TOKEN_PATH);
+	if (!ASSERT_GT(token_fd, 0, "token_get"))
+		goto cleanup;
+
+	/* validate we can successfully load BPF program with token; this
+	 * being XDP program (CAP_NET_ADMIN) using bpf_jiffies64() (CAP_BPF)
+	 * and bpf_get_current_task() (CAP_PERFMON) helpers validates we have
+	 * BPF token wired properly in a bunch of places in the kernel
+	 */
+	prog_opts.token_fd =3D token_fd;
+	prog_opts.expected_attach_type =3D BPF_XDP;
+	prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_XDP, "token_prog", "GPL",
+				insns, insn_cnt, &prog_opts);
+	if (!ASSERT_GT(prog_fd, 0, "prog_fd"))
+		goto cleanup;
+	close(prog_fd);
+
+	/* now validate that we *cannot* load BPF program without token */
+	prog_opts.token_fd =3D 0;
+	prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_XDP, "token_prog", "GPL",
+				insns, insn_cnt, &prog_opts);
+	if (!ASSERT_EQ(prog_fd, -EPERM, "prog_fd_eperm"))
+		goto cleanup;
+
+cleanup:
+	if (prog_fd > 0)
+		close(prog_fd);
+	if (token_fd)
+		close(token_fd);
+	unlink(TOKEN_PATH);
+	if (old_caps)
+		ASSERT_OK(restore_priv_caps(old_caps), "restore_caps");
+}
+
 void test_token(void)
 {
 	if (test__start_subtest("token_create"))
@@ -208,4 +272,6 @@ void test_token(void)
 		subtest_map_token();
 	if (test__start_subtest("btf_token"))
 		subtest_btf_token();
+	if (test__start_subtest("prog_token"))
+		subtest_prog_token();
 }
--=20
2.34.1


