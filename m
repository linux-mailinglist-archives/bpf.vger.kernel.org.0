Return-Path: <bpf+bounces-10355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED5D7A59B0
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 08:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD5E6281F94
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 06:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8909535895;
	Tue, 19 Sep 2023 06:04:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042FF180
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 06:04:05 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6F2FC
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 23:04:05 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IKG70u030429
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 23:04:05 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t60jdvcc5-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 23:04:04 -0700
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 18 Sep 2023 23:04:03 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
	id E45C12498508E; Mon, 18 Sep 2023 23:03:47 -0700 (PDT)
From: Song Liu <song@kernel.org>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <kernel-team@meta.com>, <iii@linux.ibm.com>,
        Song Liu
	<song@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf 2/2] selftests/bpf: Check bpf_cubic_acked() is called via struct_ops
Date: Mon, 18 Sep 2023 23:02:58 -0700
Message-ID: <20230919060258.3237176-3-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919060258.3237176-1-song@kernel.org>
References: <20230919060258.3237176-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6Cqas0_hEEdaXDvtnukUFJWRDhET9TZB
X-Proofpoint-GUID: 6Cqas0_hEEdaXDvtnukUFJWRDhET9TZB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_11,2023-09-18_01,2023-05-22_02
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Test bpf_tcp_ca (in test_progs) checks multiple tcp_congestion_ops.
However, there isn't a test that verifies functions in the
tcp_congestion_ops is actually called. Add a check to verify that
bpf_cubic_acked is actually called during the test.

Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Song Liu <song@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c | 2 ++
 tools/testing/selftests/bpf/progs/bpf_cubic.c       | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/=
testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index a53c254c6058..4aabeaa525d4 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -185,6 +185,8 @@ static void test_cubic(void)
=20
 	do_test("bpf_cubic", NULL);
=20
+	ASSERT_EQ(cubic_skel->bss->bpf_cubic_acked_called, 1, "pkts_acked calle=
d");
+
 	bpf_link__destroy(link);
 	bpf_cubic__destroy(cubic_skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_cubic.c b/tools/testin=
g/selftests/bpf/progs/bpf_cubic.c
index d9660e7200e2..c997e3e3d3fb 100644
--- a/tools/testing/selftests/bpf/progs/bpf_cubic.c
+++ b/tools/testing/selftests/bpf/progs/bpf_cubic.c
@@ -490,6 +490,8 @@ static __always_inline void hystart_update(struct soc=
k *sk, __u32 delay)
 	}
 }
=20
+int bpf_cubic_acked_called =3D 0;
+
 void BPF_STRUCT_OPS(bpf_cubic_acked, struct sock *sk,
 		    const struct ack_sample *sample)
 {
@@ -497,6 +499,7 @@ void BPF_STRUCT_OPS(bpf_cubic_acked, struct sock *sk,
 	struct bictcp *ca =3D inet_csk_ca(sk);
 	__u32 delay;
=20
+	bpf_cubic_acked_called =3D 1;
 	/* Some calls are for duplicates without timetamps */
 	if (sample->rtt_us < 0)
 		return;
--=20
2.34.1


