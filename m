Return-Path: <bpf+bounces-574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7413703ED9
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 22:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8641C20BFD
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 20:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086DD1953B;
	Mon, 15 May 2023 20:48:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37441FBE
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 20:48:52 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CD17EDA
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 13:48:51 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 34FJxbSo024885
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 13:48:50 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3qj67vf50n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 13:48:50 -0700
Received: from twshared14017.04.prn6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 13:48:49 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 8617A30BC618F; Mon, 15 May 2023 13:48:34 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Stanislav Fomichev
	<sdf@google.com>
Subject: [PATCH bpf-next] selftests/bpf: improve netcnt test robustness
Date: Mon, 15 May 2023 13:48:33 -0700
Message-ID: <20230515204833.2832000-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: muR37uHgASTT0v7ArGV2Gb_P4cyOImUy
X-Proofpoint-GUID: muR37uHgASTT0v7ArGV2Gb_P4cyOImUy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_19,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Change netcnt to demand at least 10K packets, as we frequently see some
stray packet arriving during the test in BPF CI. It seems more important
to make sure we haven't lost any packet than enforcing exact number of
packets.

Cc: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/netcnt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/netcnt.c b/tools/test=
ing/selftests/bpf/prog_tests/netcnt.c
index d3915c58d0e1..c3333edd029f 100644
--- a/tools/testing/selftests/bpf/prog_tests/netcnt.c
+++ b/tools/testing/selftests/bpf/prog_tests/netcnt.c
@@ -67,12 +67,12 @@ void serial_test_netcnt(void)
 	}
=20
 	/* No packets should be lost */
-	ASSERT_EQ(packets, 10000, "packets");
+	ASSERT_GE(packets, 10000, "packets");
=20
 	/* Let's check that bytes counter matches the number of packets
 	 * multiplied by the size of ipv6 ICMP packet.
 	 */
-	ASSERT_EQ(bytes, packets * 104, "bytes");
+	ASSERT_GE(bytes, packets * 104, "bytes");
=20
 err:
 	if (cg_fd !=3D -1)
--=20
2.34.1


