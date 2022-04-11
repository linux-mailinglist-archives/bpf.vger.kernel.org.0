Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630A44FC389
	for <lists+bpf@lfdr.de>; Mon, 11 Apr 2022 19:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348929AbiDKRiG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Apr 2022 13:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349000AbiDKRhx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Apr 2022 13:37:53 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF6F15A14
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 10:35:39 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23BGcsSc012925
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 10:35:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=d/+hMNB1GQCEQs3o7omLO3LEy+yONy22to4JQeC5Csw=;
 b=motjFHjp/z/kRBhrzEOPftnfqKcU53fSGaFabLy/ncl8+B5/ID+dSquqfM498Q/qWMvc
 2T5e5QcDn4C5Pb7/Xa3E+fnzGQUo8GgCqjzldNWuX95rpCy8XH5rJYo/vaRUPtc0YlCC
 YqyXeqtlfxfJiWx7co8vQ1fy+z+RaD2PWpI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fb7nwjsjb-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 10:35:38 -0700
Received: from twshared10896.25.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 11 Apr 2022 10:35:36 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 5650D225EE2F; Mon, 11 Apr 2022 10:35:12 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v4 5/5] selftest/bpf: The test cses of BPF cookie for fentry/fexit/fmod_ret.
Date:   Mon, 11 Apr 2022 10:34:29 -0700
Message-ID: <20220411173429.4139609-6-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411173429.4139609-1-kuifeng@fb.com>
References: <20220411173429.4139609-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: LpId99a1OK3YwBPvRg_bvIijhXGaKR7K
X-Proofpoint-ORIG-GUID: LpId99a1OK3YwBPvRg_bvIijhXGaKR7K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-11_07,2022-04-11_01,2022-02-23_01
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

