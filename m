Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0324FE663
	for <lists+bpf@lfdr.de>; Tue, 12 Apr 2022 18:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352143AbiDLQ7B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 12:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbiDLQ7B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 12:59:01 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA085F4DA
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 09:56:42 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23CDFrXS009136
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 09:56:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=d/+hMNB1GQCEQs3o7omLO3LEy+yONy22to4JQeC5Csw=;
 b=JHif5iJ+Wb/zZHMmCnUQpyuseKnidDF315Y0O+FvUcIH6nTKmwT4QAuYMB0YhqghTv6L
 g6bIxYE1Ddn6tcE2cT1PA8h5LWeNSgbiRrOpWyw07XEns47QIMowH9qQqHxWJ7oWef/H
 PCP+Csi2c98YPvJYXnQZAXXc3icVMCrDUNE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fda5fhh5t-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 09:56:41 -0700
Received: from twshared19572.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 12 Apr 2022 09:56:40 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 6BCA42309167; Tue, 12 Apr 2022 09:56:25 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v5 5/5] selftest/bpf: The test cses of BPF cookie for fentry/fexit/fmod_ret.
Date:   Tue, 12 Apr 2022 09:55:55 -0700
Message-ID: <20220412165555.4146407-6-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220412165555.4146407-1-kuifeng@fb.com>
References: <20220412165555.4146407-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 21zMITDtwivZzDbvXfX_mIMKqvngjYEU
X-Proofpoint-ORIG-GUID: 21zMITDtwivZzDbvXfX_mIMKqvngjYEU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-12_06,2022-04-12_02,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
 .../selftests/bpf/prog_tests/bpf_cookie.c     | 52 +++++++++++++++++++
 .../selftests/bpf/progs/test_bpf_cookie.c     | 24 +++++++++
 2 files changed, 76 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/=
testing/selftests/bpf/prog_tests/bpf_cookie.c
index 923a6139b2d8..7f05056c66d4 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -410,6 +410,56 @@ static void pe_subtest(struct test_bpf_cookie *skel)
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
@@ -432,6 +482,8 @@ void test_bpf_cookie(void)
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
index 0e2222968918..c37bc6ad0b70 100644
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

