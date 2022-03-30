Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A03B4EB7B0
	for <lists+bpf@lfdr.de>; Wed, 30 Mar 2022 03:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbiC3BQ7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Mar 2022 21:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbiC3BQ7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Mar 2022 21:16:59 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43082493C7
        for <bpf@vger.kernel.org>; Tue, 29 Mar 2022 18:15:14 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22U0cZon024350
        for <bpf@vger.kernel.org>; Tue, 29 Mar 2022 18:15:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=zZ9D7rA/k7wwAdbQAGOQIbuCWLu4nfYue4dwk2B1RCU=;
 b=KfXTLxHT/JTpbECXYeK02Iot8e1DEQtWlinBDRcxkm0UAFXqAiYs2atOdWMPN/CrT5YZ
 sYqCTzfPxVCooqAHTVlLzVJ9Z592mZW0nDaeLsXQiujhLYDUzEDVvx5RfU2jbS3WoHkq
 cLOID/VaBL4rNOTy2FUytVN9HqedAkcqpdU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f3tak7ag2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 29 Mar 2022 18:15:14 -0700
Received: from twshared27284.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 18:15:13 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id C19FE2BD3EF7; Tue, 29 Mar 2022 18:15:02 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf 2/2] bpf: selftests: Test fentry tracing a struct_ops program
Date:   Tue, 29 Mar 2022 18:15:02 -0700
Message-ID: <20220330011502.2985292-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220330011456.2984509-1-kafai@fb.com>
References: <20220330011456.2984509-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ChdMURn8VhC_HYxdcwCkwH8uWBq1lXP2
X-Proofpoint-ORIG-GUID: ChdMURn8VhC_HYxdcwCkwH8uWBq1lXP2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-29_10,2022-03-29_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch tests attaching an fentry prog to a struct_ops prog.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 .../selftests/bpf/prog_tests/dummy_st_ops.c   | 23 +++++++++++++++++++
 .../selftests/bpf/progs/trace_dummy_st_ops.c  | 21 +++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/trace_dummy_st_ops.=
c

diff --git a/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c b/tool=
s/testing/selftests/bpf/prog_tests/dummy_st_ops.c
index 5aa52cc31dc2..c11832657d2b 100644
--- a/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
+++ b/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2021. Huawei Technologies Co., Ltd */
 #include <test_progs.h>
 #include "dummy_st_ops.skel.h"
+#include "trace_dummy_st_ops.skel.h"
=20
 /* Need to keep consistent with definition in include/linux/bpf.h */
 struct bpf_dummy_ops_state {
@@ -56,6 +57,7 @@ static void test_dummy_init_ptr_arg(void)
 		.ctx_in =3D args,
 		.ctx_size_in =3D sizeof(args),
 	);
+	struct trace_dummy_st_ops *trace_skel;
 	struct dummy_st_ops *skel;
 	int fd, err;
=20
@@ -64,12 +66,33 @@ static void test_dummy_init_ptr_arg(void)
 		return;
=20
 	fd =3D bpf_program__fd(skel->progs.test_1);
+
+	trace_skel =3D trace_dummy_st_ops__open();
+	if (!ASSERT_OK_PTR(trace_skel, "trace_dummy_st_ops__open"))
+		goto done;
+
+	err =3D bpf_program__set_attach_target(trace_skel->progs.fentry_test_1,
+					     fd, "test_1");
+	if (!ASSERT_OK(err, "set_attach_target(fentry_test_1)"))
+		goto done;
+
+	err =3D trace_dummy_st_ops__load(trace_skel);
+	if (!ASSERT_OK(err, "load(trace_skel)"))
+		goto done;
+
+	err =3D trace_dummy_st_ops__attach(trace_skel);
+	if (!ASSERT_OK(err, "attach(trace_skel)"))
+		goto done;
+
 	err =3D bpf_prog_test_run_opts(fd, &attr);
 	ASSERT_OK(err, "test_run");
 	ASSERT_EQ(in_state.val, 0x5a, "test_ptr_ret");
 	ASSERT_EQ(attr.retval, exp_retval, "test_ret");
+	ASSERT_EQ(trace_skel->bss->val, exp_retval, "fentry_val");
=20
+done:
 	dummy_st_ops__destroy(skel);
+	trace_dummy_st_ops__destroy(trace_skel);
 }
=20
 static void test_dummy_multiple_args(void)
diff --git a/tools/testing/selftests/bpf/progs/trace_dummy_st_ops.c b/too=
ls/testing/selftests/bpf/progs/trace_dummy_st_ops.c
new file mode 100644
index 000000000000..00a4be9d3074
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/trace_dummy_st_ops.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+int val =3D 0;
+
+SEC("fentry/test_1")
+int BPF_PROG(fentry_test_1, __u64 *st_ops_ctx)
+{
+	__u64 state;
+
+	/* Read the traced st_ops arg1 which is a pointer */
+	bpf_probe_read_kernel(&state, sizeof(__u64), (void *)st_ops_ctx);
+	/* Read state->val */
+	bpf_probe_read_kernel(&val, sizeof(__u32), (void *)state);
+
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.30.2

