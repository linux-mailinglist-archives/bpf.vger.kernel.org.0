Return-Path: <bpf+bounces-1947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05364724A1D
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 19:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDE9F280EA8
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 17:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0531ED5E;
	Tue,  6 Jun 2023 17:22:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FFA19915
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 17:22:32 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA562170B
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 10:22:28 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356HLcxe030805
	for <bpf@vger.kernel.org>; Tue, 6 Jun 2023 10:22:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=KEP3xDDRVx4URAo3aW8UXEAQunkaS1pof8Mgv+4yS8s=;
 b=asXyQA7JqBzQLtrriC65ljQcmhfqNaHVHtnD+LESoOrDm4R3a3DhfO3Ti9O2keMA8jAR
 rnPLZFTB/ZreCv2HQR4qlHgORU9GygCLiN71eHnEghl4LJykSq3MXnmZwfL0wdUmpx4t
 m7EvK9zYzMCybW+700D75n1rpTvNE/tYQr4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r1fxt4ab6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 06 Jun 2023 10:22:28 -0700
Received: from twshared34049.08.ash9.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 10:22:13 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 14CE020DF84C6; Tue,  6 Jun 2023 10:22:02 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai
 Lau <martin.lau@kernel.org>
Subject: [PATCH bpf] selftests/bpf: Fix sockopt_sk selftest
Date: Tue, 6 Jun 2023 10:22:02 -0700
Message-ID: <20230606172202.1606249-1-yhs@fb.com>
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
X-Proofpoint-GUID: OIUbu8MgmDvRPv_WjGsWFeRVlguPImxz
X-Proofpoint-ORIG-GUID: OIUbu8MgmDvRPv_WjGsWFeRVlguPImxz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_12,2023-06-06_02,2023-05-22_02
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit f4e4534850a9 ("net/netlink: fix NETLINK_LIST_MEMBERSHIPS length re=
port")
fixed NETLINK_LIST_MEMBERSHIPS length report which caused
selftest sockopt_sk failure. The failure log looks like

  test_sockopt_sk:PASS:join_cgroup /sockopt_sk 0 nsec
  run_test:PASS:skel_load 0 nsec
  run_test:PASS:setsockopt_link 0 nsec
  run_test:PASS:getsockopt_link 0 nsec
  getsetsockopt:FAIL:Unexpected NETLINK_LIST_MEMBERSHIPS value unexpected=
 Unexpected NETLINK_LIST_MEMBERSHIPS value: actual 8 !=3D expected 4
  run_test:PASS:getsetsockopt 0 nsec
  #201     sockopt_sk:FAIL

In net/netlink/af_netlink.c, function netlink_getsockopt(), for NETLINK_L=
IST_MEMBERSHIPS,
nlk->ngroups equals to 36. Before Commit f4e4534850a9, the optlen is calc=
ulated as
  ALIGN(nlk->ngroups / 8, sizeof(u32)) =3D 4
After that commit, the optlen is
  ALIGN(BITS_TO_BYTES(nlk->ngroups), sizeof(u32)) =3D 8

Fix the test by setting the expected optlen to be 8.

Fixes: f4e4534850a9 ("net/netlink: fix NETLINK_LIST_MEMBERSHIPS length re=
port")
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/sockopt_sk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/=
testing/selftests/bpf/prog_tests/sockopt_sk.c
index 4512dd808c33..05d0e07da394 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
@@ -209,7 +209,7 @@ static int getsetsockopt(void)
 			err, errno);
 		goto err;
 	}
-	ASSERT_EQ(optlen, 4, "Unexpected NETLINK_LIST_MEMBERSHIPS value");
+	ASSERT_EQ(optlen, 8, "Unexpected NETLINK_LIST_MEMBERSHIPS value");
=20
 	free(big_buf);
 	close(fd);
--=20
2.34.1


