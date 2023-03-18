Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F946BF808
	for <lists+bpf@lfdr.de>; Sat, 18 Mar 2023 06:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjCRFjF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 18 Mar 2023 01:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjCRFjE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 18 Mar 2023 01:39:04 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC785474D7
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 22:39:02 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32I3D4SP024703
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 22:39:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=cLGbrYiSP2GxYN6pv6+F/7L8SNzfXLZ0+yVDwT2Ok/w=;
 b=TcI2yP5w4/AylosloIZg2tFRB9y0l4te4McM+fDLhCz4bBJkLlteQaKpTMynKRueUO9b
 GD3ml77A7J2V/6lM8O91YqTiQubXFawnBaYQ3wuXwzPvnZKr8V5A+l34bf0j1nkXTDtd
 3tKNIlDc/xVa0l6CU00tza5aEN3bP4b8eNaK2kahKiUYM8X+1VuwUmVwySaNyRh/RcI9
 5kXCSL71Bntl6zlOwq69DcwG9a1yXSiiTZgCU1qE3I+4Ea11QDt9/kbc2/SYJsgFdvOu
 zXo6um0KPdZkuhUIicQcdvJJoiKU5z6Iv2+Z2Hk1YKB/gFt6Z3jRTE60NqPBxekfiuEZ xg== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pcsvvmb4f-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 22:39:01 -0700
Received: from twshared21709.17.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 17 Mar 2023 22:39:00 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id A292079EB04F; Fri, 17 Mar 2023 22:31:54 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>,
        <sdf@google.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v8 8/8] selftests/bpf: Test switching TCP Congestion Control algorithms.
Date:   Fri, 17 Mar 2023 22:31:44 -0700
Message-ID: <20230318053144.1180301-9-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230318053144.1180301-1-kuifeng@meta.com>
References: <20230318053144.1180301-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: HLZpnYnyy9FkoJDiPZIPcdyUZLoLYw_9
X-Proofpoint-ORIG-GUID: HLZpnYnyy9FkoJDiPZIPcdyUZLoLYw_9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-18_02,2023-03-16_02,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Create a pair of sockets that utilize the congestion control algorithm
under a particular name. Then switch up this congestion control
algorithm to another implementation and check whether newly created
connections using the same cc name now run the new implementation.

Also, try to update a link with a struct_ops that is without
BPF_F_LINK or with a wrong or different name.  These cases should fail
due to the violation of assumptions.  To update a bpf_link of a
struct_ops, it must be replaced with another struct_ops that is
identical in type and name and has the BPF_F_LINK flag.

The other test case is to create links from the same struct_ops more
than once.  It makes sure a struct_ops can be used repeatly.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 116 ++++++++++++++++++
 .../selftests/bpf/progs/tcp_ca_update.c       |  80 ++++++++++++
 2 files changed, 196 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_update.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/=
testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index e980188d4124..5f3602326bbc 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -8,6 +8,7 @@
 #include "bpf_dctcp.skel.h"
 #include "bpf_cubic.skel.h"
 #include "bpf_tcp_nogpl.skel.h"
+#include "tcp_ca_update.skel.h"
 #include "bpf_dctcp_release.skel.h"
 #include "tcp_ca_write_sk_pacing.skel.h"
 #include "tcp_ca_incompl_cong_ops.skel.h"
@@ -381,6 +382,113 @@ static void test_unsupp_cong_op(void)
 	libbpf_set_print(old_print_fn);
 }
=20
+static void test_update_ca(void)
+{
+	struct tcp_ca_update *skel;
+	struct bpf_link *link;
+	int saved_ca1_cnt;
+	int err;
+
+	skel =3D tcp_ca_update__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(skel->maps.ca_update_1);
+	ASSERT_OK_PTR(link, "attach_struct_ops");
+
+	do_test("tcp_ca_update", NULL);
+	saved_ca1_cnt =3D skel->bss->ca1_cnt;
+	ASSERT_GT(saved_ca1_cnt, 0, "ca1_ca1_cnt");
+
+	err =3D bpf_link__update_map(link, skel->maps.ca_update_2);
+	ASSERT_OK(err, "update_map");
+
+	do_test("tcp_ca_update", NULL);
+	ASSERT_EQ(skel->bss->ca1_cnt, saved_ca1_cnt, "ca2_ca1_cnt");
+	ASSERT_GT(skel->bss->ca2_cnt, 0, "ca2_ca2_cnt");
+
+	bpf_link__destroy(link);
+	tcp_ca_update__destroy(skel);
+}
+
+static void test_update_wrong(void)
+{
+	struct tcp_ca_update *skel;
+	struct bpf_link *link;
+	int saved_ca1_cnt;
+	int err;
+
+	skel =3D tcp_ca_update__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(skel->maps.ca_update_1);
+	ASSERT_OK_PTR(link, "attach_struct_ops");
+
+	do_test("tcp_ca_update", NULL);
+	saved_ca1_cnt =3D skel->bss->ca1_cnt;
+	ASSERT_GT(saved_ca1_cnt, 0, "ca1_ca1_cnt");
+
+	err =3D bpf_link__update_map(link, skel->maps.ca_wrong);
+	ASSERT_ERR(err, "update_map");
+
+	do_test("tcp_ca_update", NULL);
+	ASSERT_GT(skel->bss->ca1_cnt, saved_ca1_cnt, "ca2_ca1_cnt");
+
+	bpf_link__destroy(link);
+	tcp_ca_update__destroy(skel);
+}
+
+static void test_mixed_links(void)
+{
+	struct tcp_ca_update *skel;
+	struct bpf_link *link, *link_nl;
+	int err;
+
+	skel =3D tcp_ca_update__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	link_nl =3D bpf_map__attach_struct_ops(skel->maps.ca_no_link);
+	ASSERT_OK_PTR(link_nl, "attach_struct_ops_nl");
+
+	link =3D bpf_map__attach_struct_ops(skel->maps.ca_update_1);
+	ASSERT_OK_PTR(link, "attach_struct_ops");
+
+	do_test("tcp_ca_update", NULL);
+	ASSERT_GT(skel->bss->ca1_cnt, 0, "ca1_ca1_cnt");
+
+	err =3D bpf_link__update_map(link, skel->maps.ca_no_link);
+	ASSERT_ERR(err, "update_map");
+
+	bpf_link__destroy(link);
+	bpf_link__destroy(link_nl);
+	tcp_ca_update__destroy(skel);
+}
+
+static void test_multi_links(void)
+{
+	struct tcp_ca_update *skel;
+	struct bpf_link *link;
+
+	skel =3D tcp_ca_update__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(skel->maps.ca_update_1);
+	ASSERT_OK_PTR(link, "attach_struct_ops_1st");
+	bpf_link__destroy(link);
+
+	/* A map should be able to be used to create links multiple
+	 * times.
+	 */
+	link =3D bpf_map__attach_struct_ops(skel->maps.ca_update_1);
+	ASSERT_OK_PTR(link, "attach_struct_ops_2nd");
+	bpf_link__destroy(link);
+
+	tcp_ca_update__destroy(skel);
+}
+
 void test_bpf_tcp_ca(void)
 {
 	if (test__start_subtest("dctcp"))
@@ -399,4 +507,12 @@ void test_bpf_tcp_ca(void)
 		test_incompl_cong_ops();
 	if (test__start_subtest("unsupp_cong_op"))
 		test_unsupp_cong_op();
+	if (test__start_subtest("update_ca"))
+		test_update_ca();
+	if (test__start_subtest("update_wrong"))
+		test_update_wrong();
+	if (test__start_subtest("mixed_links"))
+		test_mixed_links();
+	if (test__start_subtest("multi_links"))
+		test_multi_links();
 }
diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_update.c b/tools/te=
sting/selftests/bpf/progs/tcp_ca_update.c
new file mode 100644
index 000000000000..b93a0ed33057
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tcp_ca_update.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+int ca1_cnt =3D 0;
+int ca2_cnt =3D 0;
+
+static inline struct tcp_sock *tcp_sk(const struct sock *sk)
+{
+	return (struct tcp_sock *)sk;
+}
+
+SEC("struct_ops/ca_update_1_init")
+void BPF_PROG(ca_update_1_init, struct sock *sk)
+{
+	ca1_cnt++;
+}
+
+SEC("struct_ops/ca_update_2_init")
+void BPF_PROG(ca_update_2_init, struct sock *sk)
+{
+	ca2_cnt++;
+}
+
+SEC("struct_ops/ca_update_cong_control")
+void BPF_PROG(ca_update_cong_control, struct sock *sk,
+	      const struct rate_sample *rs)
+{
+}
+
+SEC("struct_ops/ca_update_ssthresh")
+__u32 BPF_PROG(ca_update_ssthresh, struct sock *sk)
+{
+	return tcp_sk(sk)->snd_ssthresh;
+}
+
+SEC("struct_ops/ca_update_undo_cwnd")
+__u32 BPF_PROG(ca_update_undo_cwnd, struct sock *sk)
+{
+	return tcp_sk(sk)->snd_cwnd;
+}
+
+SEC(".struct_ops.link")
+struct tcp_congestion_ops ca_update_1 =3D {
+	.init =3D (void *)ca_update_1_init,
+	.cong_control =3D (void *)ca_update_cong_control,
+	.ssthresh =3D (void *)ca_update_ssthresh,
+	.undo_cwnd =3D (void *)ca_update_undo_cwnd,
+	.name =3D "tcp_ca_update",
+};
+
+SEC(".struct_ops.link")
+struct tcp_congestion_ops ca_update_2 =3D {
+	.init =3D (void *)ca_update_2_init,
+	.cong_control =3D (void *)ca_update_cong_control,
+	.ssthresh =3D (void *)ca_update_ssthresh,
+	.undo_cwnd =3D (void *)ca_update_undo_cwnd,
+	.name =3D "tcp_ca_update",
+};
+
+SEC(".struct_ops.link")
+struct tcp_congestion_ops ca_wrong =3D {
+	.cong_control =3D (void *)ca_update_cong_control,
+	.ssthresh =3D (void *)ca_update_ssthresh,
+	.undo_cwnd =3D (void *)ca_update_undo_cwnd,
+	.name =3D "tcp_ca_wrong",
+};
+
+SEC(".struct_ops")
+struct tcp_congestion_ops ca_no_link =3D {
+	.cong_control =3D (void *)ca_update_cong_control,
+	.ssthresh =3D (void *)ca_update_ssthresh,
+	.undo_cwnd =3D (void *)ca_update_undo_cwnd,
+	.name =3D "tcp_ca_no_link",
+};
--=20
2.34.1

