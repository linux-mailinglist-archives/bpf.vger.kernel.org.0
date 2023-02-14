Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC676970A0
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 23:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBNWUI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 17:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjBNWUI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 17:20:08 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D090FB
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:20:06 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EGsGkr002470
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:20:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=9A29MS7ibyRcmxp0j3ms/aE0/zyiiR+NBIu7cPq8jdE=;
 b=AJpoy5g8TZITMRYWMabrqZtFHAELoXptGz8WtZL7QHRAOsf/U1iwd1efpL7BVPM7FPvI
 F/e+qhxQ8dWiP3VJZfiNdZCBZVAJgG2lhDlI4yMYJJKe3YftI4IYEvfRU4B857ho3mQb
 hMeStAGhZH6EEVRUbCCjE1z5nzzKaMFkTldrF+1gpvcKvDyvxjoy3aeO5JXd5w07kMWG
 UhiVDsVK7gNAKrfvznvpfaKqzoGfw9zvjT8VCguaov13Y5XaJUOiQ5BiW/sX+ys7GEfT
 F6mQCC30AXD6+kdJbmfLrPhh1BYjWV6iepaCj7LW31MFFBHmIR5oxFxfGd82jJ06wXbL 1g== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nrc3b3a89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:20:06 -0800
Received: from twshared26225.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 14 Feb 2023 14:20:05 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 2709F51430AE; Tue, 14 Feb 2023 14:17:23 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next 7/7] selftests/bpf: Test switching TCP Congestion Control algorithms.
Date:   Tue, 14 Feb 2023 14:17:18 -0800
Message-ID: <20230214221718.503964-8-kuifeng@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230214221718.503964-1-kuifeng@meta.com>
References: <20230214221718.503964-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XolOfgoZmjan9D_4uqfvBrBzDyiLpK74
X-Proofpoint-GUID: XolOfgoZmjan9D_4uqfvBrBzDyiLpK74
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Create a pair of sockets that utilize the congestion control algorithm
under a particular name. Then switch up this congestion control
algorithm to another implementation and check whether newly created
connections using the same cc name now run the new implementation.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 48 ++++++++++++
 .../selftests/bpf/progs/tcp_ca_update.c       | 75 +++++++++++++++++++
 2 files changed, 123 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_update.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/=
testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index e980188d4124..89477e4c9a24 100644
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
@@ -381,6 +382,51 @@ static void test_unsupp_cong_op(void)
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
+	skel =3D tcp_ca_update__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	err =3D bpf_map__set_map_flags(skel->maps.ca_update_1,
+				     bpf_map__map_flags(skel->maps.ca_update_1) | BPF_F_LINK);
+	if (!ASSERT_OK(err, "set_map_flags_1"))
+		return;
+
+	err =3D bpf_map__set_map_flags(skel->maps.ca_update_2,
+				     bpf_map__map_flags(skel->maps.ca_update_2) | BPF_F_LINK);
+	if (!ASSERT_OK(err, "set_map_flags_2"))
+		return;
+
+	err =3D tcp_ca_update__load(skel);
+	if (!ASSERT_OK(err, "load")) {
+		tcp_ca_update__destroy(skel);
+		return;
+	}
+
+	link =3D bpf_map__attach_struct_ops(skel->maps.ca_update_1);
+	ASSERT_OK_PTR(link, "attach_struct_ops");
+
+	do_test("tcp_ca_update", NULL);
+	saved_ca1_cnt =3D skel->bss->ca1_cnt;
+	ASSERT_GT(saved_ca1_cnt, 0, "ca1_ca1_cnt");
+
+	err =3D bpf_link__update_struct_ops(link, skel->maps.ca_update_2);
+	ASSERT_OK(err, "update_struct_ops");
+
+	do_test("tcp_ca_update", NULL);
+	ASSERT_EQ(skel->bss->ca1_cnt, saved_ca1_cnt, "ca2_ca1_cnt");
+	ASSERT_GT(skel->bss->ca2_cnt, 0, "ca2_ca2_cnt");
+
+	bpf_link__destroy(link);
+	tcp_ca_update__destroy(skel);
+}
+
 void test_bpf_tcp_ca(void)
 {
 	if (test__start_subtest("dctcp"))
@@ -399,4 +445,6 @@ void test_bpf_tcp_ca(void)
 		test_incompl_cong_ops();
 	if (test__start_subtest("unsupp_cong_op"))
 		test_unsupp_cong_op();
+	if (test__start_subtest("update_ca"))
+		test_update_ca();
 }
diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_update.c b/tools/te=
sting/selftests/bpf/progs/tcp_ca_update.c
new file mode 100644
index 000000000000..cf51fe54ac01
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tcp_ca_update.c
@@ -0,0 +1,75 @@
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
+#define USEC_PER_SEC 1000000UL
+
+#define min(a, b) ((a) < (b) ? (a) : (b))
+
+static inline struct tcp_sock *tcp_sk(const struct sock *sk)
+{
+	return (struct tcp_sock *)sk;
+}
+
+SEC("struct_ops/ca_update_init")
+void BPF_PROG(ca_update_init, struct sock *sk)
+{
+#ifdef ENABLE_ATOMICS_TESTS
+	__sync_bool_compare_and_swap(&sk->sk_pacing_status, SK_PACING_NONE,
+				     SK_PACING_NEEDED);
+#else
+	sk->sk_pacing_status =3D SK_PACING_NEEDED;
+#endif
+}
+
+SEC("struct_ops/ca_update_1_cong_control")
+void BPF_PROG(ca_update_1_cong_control, struct sock *sk,
+	      const struct rate_sample *rs)
+{
+	ca1_cnt++;
+}
+
+SEC("struct_ops/ca_update_2_cong_control")
+void BPF_PROG(ca_update_2_cong_control, struct sock *sk,
+	      const struct rate_sample *rs)
+{
+	ca2_cnt++;
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
+SEC(".struct_ops")
+struct tcp_congestion_ops ca_update_1 =3D {
+	.init =3D (void *)ca_update_init,
+	.cong_control =3D (void *)ca_update_1_cong_control,
+	.ssthresh =3D (void *)ca_update_ssthresh,
+	.undo_cwnd =3D (void *)ca_update_undo_cwnd,
+	.name =3D "tcp_ca_update",
+};
+
+SEC(".struct_ops")
+struct tcp_congestion_ops ca_update_2 =3D {
+	.init =3D (void *)ca_update_init,
+	.cong_control =3D (void *)ca_update_2_cong_control,
+	.ssthresh =3D (void *)ca_update_ssthresh,
+	.undo_cwnd =3D (void *)ca_update_undo_cwnd,
+	.name =3D "tcp_ca_update",
+};
--=20
2.30.2

