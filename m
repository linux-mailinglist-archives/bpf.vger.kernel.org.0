Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFBB4F8813
	for <lists+bpf@lfdr.de>; Thu,  7 Apr 2022 21:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiDGT2t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Apr 2022 15:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiDGT2s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Apr 2022 15:28:48 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE98286A6C
        for <bpf@vger.kernel.org>; Thu,  7 Apr 2022 12:26:38 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 237IBDBk024615
        for <bpf@vger.kernel.org>; Thu, 7 Apr 2022 12:26:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=2npb6w9pLqHe8jLCqjFBryFIEuhlwR1ZQ+gPXKdT4jE=;
 b=cEwDMAWBCIgReoFLYXNCjctxUlZG3aA1PwTcZCSugjFBxxGnfr2s4gmTGr8tQrwEKfvH
 C2IfH0tcRSlFSjfViFSF48AA0adYovmqyFRosz9NLj1qjFgWms7Jg+ExBCianTYaaPBZ
 88+SRwTgniLr1YPeGRFuYV/ewl/OmCqAGlw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3f9bb3kvxh-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 07 Apr 2022 12:26:37 -0700
Received: from twshared39027.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 12:26:35 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 9ED38200EE91; Thu,  7 Apr 2022 12:26:27 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v3 5/5] selftest/bpf: The test cses of BPF cookie for fentry/fexit/fmod_ret.
Date:   Thu, 7 Apr 2022 12:25:52 -0700
Message-ID: <20220407192552.2343076-6-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220407192552.2343076-1-kuifeng@fb.com>
References: <20220407192552.2343076-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Gwkqn6qIfbDrf3Fu_iW4xF2IW7uq1VYm
X-Proofpoint-GUID: Gwkqn6qIfbDrf3Fu_iW4xF2IW7uq1VYm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-07_04,2022-04-07_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make sure BPF cookies are correct for fentry/fexit/fmod_ret.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 .../selftests/bpf/prog_tests/bpf_cookie.c     | 52 +++++++++++++++++++
 .../selftests/bpf/progs/test_bpf_cookie.c     | 24 +++++++++
 2 files changed, 76 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/=
testing/selftests/bpf/prog_tests/bpf_cookie.c
index 0612e79a9281..16385f0c4031 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -237,6 +237,56 @@ static void pe_subtest(struct test_bpf_cookie *skel)
 	bpf_link__destroy(link);
 }
=20
+static void tracing_subtest(struct test_bpf_cookie *skel)
+{
+	__u64 cookie;
+	int prog_fd;
+	int fentry_fd =3D -1, fexit_fd =3D -1, fmod_ret_fd =3D -1;
+
+	LIBBPF_OPTS(bpf_test_run_opts, opts, .repeat =3D 1);
+	LIBBPF_OPTS(bpf_link_create_opts, link_opts);
+
+	skel->bss->fentry_res =3D 0;
+	skel->bss->fexit_res =3D 0;
+
+	cookie =3D 0x100000;
+	prog_fd =3D bpf_program__fd(skel->progs.fentry_test1);
+	link_opts.tracing.bpf_cookie =3D cookie;
+	fentry_fd =3D bpf_link_create(prog_fd, 0, BPF_TRACE_FENTRY, &link_opts)=
;
+
+	cookie =3D 0x200000;
+	prog_fd =3D bpf_program__fd(skel->progs.fexit_test1);
+	link_opts.tracing.bpf_cookie =3D cookie;
+	fexit_fd =3D bpf_link_create(prog_fd, 0, BPF_TRACE_FEXIT, &link_opts);
+	if (!ASSERT_GE(fexit_fd, 0, "fexit.open"))
+		goto cleanup;
+
+	cookie =3D 0x300000;
+	prog_fd =3D bpf_program__fd(skel->progs.fmod_ret_test);
+	link_opts.tracing.bpf_cookie =3D cookie;
+	fmod_ret_fd =3D bpf_link_create(prog_fd, 0, BPF_MODIFY_RETURN, &link_op=
ts);
+	if (!ASSERT_GE(fmod_ret_fd, 0, "fmod_ret.opoen"))
+		goto cleanup;
+
+	prog_fd =3D bpf_program__fd(skel->progs.fentry_test1);
+	bpf_prog_test_run_opts(prog_fd, &opts);
+
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
@@ -255,6 +305,8 @@ void test_bpf_cookie(void)
 		tp_subtest(skel);
 	if (test__start_subtest("perf_event"))
 		pe_subtest(skel);
+	if (test__start_subtest("trampoline"))
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

