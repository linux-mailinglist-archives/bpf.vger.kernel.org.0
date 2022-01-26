Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB2649D4B4
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 22:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiAZVsb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 16:48:31 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9080 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232749AbiAZVsb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 Jan 2022 16:48:31 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20QL20g2014011
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 13:48:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=nIWjqKa2lI4YV777ccTsgkjQeX8Z0g0p0BrOJIqKguc=;
 b=rIA9ri8YLvUQhRDfBtD1fQ3H8zXYjU53iRgthMiVXKPuVGsxsw1zfuwyplDZUcJ8epCa
 VShmJqVtAjXE6rTRFxjtmAwKoSs6TDVu27cX08/u3XnXbb70BPOzmNzVphYw3NHxPCH/
 lL9RU8S7suYE7KUhpXCr/95CHG7TsKdUki8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dtvbex1da-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 13:48:31 -0800
Received: from twshared29821.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 26 Jan 2022 13:48:27 -0800
Received: by devvm1744.ftw0.facebook.com (Postfix, from userid 460691)
        id 29EA52C9AA2F; Wed, 26 Jan 2022 13:48:16 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next 5/5] bpf: Implement bpf_get_attach_cookie() for tracing programs.
Date:   Wed, 26 Jan 2022 13:48:09 -0800
Message-ID: <20220126214809.3868787-6-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126214809.3868787-1-kuifeng@fb.com>
References: <20220126214809.3868787-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 32e0w5qQeC3z7EDK8d4dKr4ccXac1R6d
X-Proofpoint-ORIG-GUID: 32e0w5qQeC3z7EDK8d4dKr4ccXac1R6d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_08,2022-01-26_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201260126
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Implement bpf_get_attach_cookie() for fentry, fexit, and fmod_ret
tracing programs.  The cookie is from the bpf_prog from the program ID
of the current BPF program.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 kernel/trace/bpf_trace.c                      | 22 +++++++
 .../selftests/bpf/prog_tests/bpf_cookie.c     | 57 +++++++++++++++++++
 .../selftests/bpf/progs/test_bpf_cookie.c     | 24 ++++++++
 3 files changed, 103 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index bf2c9d11ad05..7b1f4c8a10de 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1084,6 +1084,26 @@ static const struct bpf_func_proto bpf_get_attach_=
cookie_proto_pe =3D {
 	.arg1_type	=3D ARG_PTR_TO_CTX,
 };
=20
+BPF_CALL_1(bpf_get_attach_cookie_tracing, void *, ctx)
+{
+	const struct bpf_prog *prog;
+	int off =3D get_trampo_var_off(ctx, BPF_TRAMP_F_PROG_ID);
+
+	if (off < 0)
+		return 0;
+
+	prog =3D (const struct bpf_prog *)((u64 *)ctx)[-off];
+
+	return prog->aux->cookie;
+}
+
+static const struct bpf_func_proto bpf_get_attach_cookie_proto_tracing =3D=
 {
+	.func		=3D bpf_get_attach_cookie_tracing,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_CTX,
+};
+
 BPF_CALL_3(bpf_get_branch_snapshot, void *, buf, u32, size, u64, flags)
 {
 #ifndef CONFIG_X86
@@ -1706,6 +1726,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, c=
onst struct bpf_prog *prog)
 		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_ret_proto : NULL;
 	case BPF_FUNC_get_func_arg_cnt:
 		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_cnt_proto : N=
ULL;
+	case BPF_FUNC_get_attach_cookie:
+		return bpf_prog_has_trampoline(prog) ? &bpf_get_attach_cookie_proto_tr=
acing : NULL;
 	default:
 		fn =3D raw_tp_prog_func_proto(func_id, prog);
 		if (!fn && prog->expected_attach_type =3D=3D BPF_TRACE_ITER)
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/=
testing/selftests/bpf/prog_tests/bpf_cookie.c
index 5eea3c3a40fe..41a73c0a3a8e 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -231,6 +231,61 @@ static void pe_subtest(struct test_bpf_cookie *skel)
 	bpf_link__destroy(link);
 }
=20
+static void tracing_subtest(struct test_bpf_cookie *skel)
+{
+	__u64 cookie;
+	__u32 duration =3D 0, retval;
+	int prog_fd;
+	int fentry_fd =3D -1, fexit_fd =3D -1, fmod_ret_fd =3D -1;
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
+	prog_fd =3D bpf_program__fd(skel->progs.fentry_test1);
+	bpf_prog_test_run(prog_fd, 1, NULL, 0,
+			  NULL, NULL, &retval, &duration);
+
+	prog_fd =3D bpf_program__fd(skel->progs.fmod_ret_test);
+	bpf_prog_test_run(prog_fd, 1, NULL, 0,
+			  NULL, NULL, &retval, &duration);
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
@@ -249,6 +304,8 @@ void test_bpf_cookie(void)
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

