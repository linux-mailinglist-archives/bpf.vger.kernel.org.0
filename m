Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EA84DA70E
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 01:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352843AbiCPAqD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 20:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiCPAqD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 20:46:03 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042D25DE55
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 17:44:49 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 22FNkbw8004130
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 17:44:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=5Mn/lyNAphq1lkKe0VRVi/Z2OossJay8MjSWl7Ej810=;
 b=KdXCWG5djq1uPwXDz6TNLmhjh+mC7pjaWthB7N66vNgmzGccZTfxn4iQWvJ6fYkwqPrm
 bWca3dbFaPux5DXnajVSLPZcg6LcX/UjmJeStRzflvAIVTkhbF6KENN+jgKzpT1Ylccu
 GmhQ/cVD3xAWwFSz75mvD36oVqv6m+addpU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3et99mm0q4-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 17:44:49 -0700
Received: from twshared22811.39.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 17:44:46 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 5AB651269EEA; Tue, 15 Mar 2022 17:44:41 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v2 4/4] selftest/bpf: The test cses of BPF cookie for fentry/fexit/fmod_ret.
Date:   Tue, 15 Mar 2022 17:42:31 -0700
Message-ID: <20220316004231.1103318-5-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220316004231.1103318-1-kuifeng@fb.com>
References: <20220316004231.1103318-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: U1aGH6k3G6SnpaksNb07I_k39Lj-ZtYR
X-Proofpoint-ORIG-GUID: U1aGH6k3G6SnpaksNb07I_k39Lj-ZtYR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_11,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make sure BPF cookies are correct for fentry/fexit/fmod_ret.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 .../selftests/bpf/prog_tests/bpf_cookie.c     | 61 +++++++++++++++++++
 .../selftests/bpf/progs/test_bpf_cookie.c     | 24 ++++++++
 2 files changed, 85 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/=
testing/selftests/bpf/prog_tests/bpf_cookie.c
index 0612e79a9281..6d06c5046e9c 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -237,6 +237,65 @@ static void pe_subtest(struct test_bpf_cookie *skel)
 	bpf_link__destroy(link);
 }
=20
+static void tracing_subtest(struct test_bpf_cookie *skel)
+{
+	__u64 cookie;
+	int prog_fd;
+	int fentry_fd =3D -1, fexit_fd =3D -1, fmod_ret_fd =3D -1;
+	struct bpf_test_run_opts opts;
+
+	skel->bss->fentry_res =3D 0;
+	skel->bss->fexit_res =3D 0;
+
+	cookie =3D 0x100000;
+	prog_fd =3D bpf_program__fd(skel->progs.fentry_test1);
+	if (!ASSERT_GE(prog_fd, 0, "fentry.prog_fd"))
+		return;
+	fentry_fd =3D bpf_raw_tracepoint_cookie_open(NULL, prog_fd, cookie);
+	if (!ASSERT_GE(fentry_fd, 0, "fentry.open"))
+		return;
+
+	cookie =3D 0x200000;
+	prog_fd =3D bpf_program__fd(skel->progs.fexit_test1);
+	if (!ASSERT_GE(prog_fd, 0, "fexit.prog_fd"))
+		goto cleanup;
+	fexit_fd =3D bpf_raw_tracepoint_cookie_open(NULL, prog_fd, cookie);
+	if (!ASSERT_GE(fexit_fd, 0, "fexit.open"))
+		goto cleanup;
+
+	cookie =3D 0x300000;
+	prog_fd =3D bpf_program__fd(skel->progs.fmod_ret_test);
+	if (!ASSERT_GE(prog_fd, 0, "fmod_ret.prog_fd"))
+		goto cleanup;
+	fmod_ret_fd =3D bpf_raw_tracepoint_cookie_open(NULL, prog_fd, cookie);
+	if (!ASSERT_GE(fmod_ret_fd, 0, "fmod_ret.opoen"))
+		goto cleanup;
+
+	bzero(&opts, sizeof(opts));
+	opts.sz =3D sizeof(opts);
+	opts.repeat =3D 1;
+	prog_fd =3D bpf_program__fd(skel->progs.fentry_test1);
+	bpf_prog_test_run_opts(prog_fd, &opts);
+
+	bzero(&opts, sizeof(opts));
+	opts.sz =3D sizeof(opts);
+	opts.repeat =3D 1;
+	prog_fd =3D bpf_program__fd(skel->progs.fmod_ret_test);
+	bpf_prog_test_run_opts(prog_fd, &opts);
+
+	ASSERT_EQ(skel->bss->fentry_res, 0x100000, "fentry_res");
+	ASSERT_EQ(skel->bss->fexit_res, 0x200000, "fexit_res");
+	ASSERT_EQ(skel->bss->fmod_ret_res, 0x300000, "fmod_ret_res");
+
+cleanup:
+	if (fentry_fd >=3D 0)
+		close(fentry_fd);
+	if (fexit_fd >=3D 0)
+		close(fexit_fd);
+	if (fmod_ret_fd >=3D 0)
+		close(fmod_ret_fd);
+}
+
 void test_bpf_cookie(void)
 {
 	struct test_bpf_cookie *skel;
@@ -255,6 +314,8 @@ void test_bpf_cookie(void)
 		tp_subtest(skel);
 	if (test__start_subtest("perf_event"))
 		pe_subtest(skel);
+	if (test__start_subtest("tracing"))
+		tracing_subtest(skel);
=20
 	test_bpf_cookie__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_cookie.c b/tools/=
testing/selftests/bpf/progs/test_bpf_cookie.c
index 2d3a7710e2ce..a9f83f46e7b7 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_cookie.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_cookie.c
@@ -14,6 +14,9 @@ int uprobe_res;
 int uretprobe_res;
 int tp_res;
 int pe_res;
+int fentry_res;
+int fexit_res;
+int fmod_ret_res;
=20
 static void update(void *ctx, int *res)
 {
@@ -82,4 +85,25 @@ int handle_pe(struct pt_regs *ctx)
 	return 0;
 }
=20
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(fentry_test1, int a)
+{
+	update(ctx, &fentry_res);
+	return 0;
+}
+
+SEC("fexit/bpf_fentry_test1")
+int BPF_PROG(fexit_test1, int a, int ret)
+{
+	update(ctx, &fexit_res);
+	return 0;
+}
+
+SEC("fmod_ret/bpf_modify_return_test")
+int BPF_PROG(fmod_ret_test, int _a, int *_b, int _ret)
+{
+	update(ctx, &fmod_ret_res);
+	return 1234;
+}
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.30.2

