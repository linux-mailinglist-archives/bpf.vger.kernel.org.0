Return-Path: <bpf+bounces-11969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C707C606C
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 00:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7AD41C20A6E
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 22:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C98125CD;
	Wed, 11 Oct 2023 22:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872F738F
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 22:38:43 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7298698
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:38:42 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BLJuBx010605
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:38:41 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tnu0mn9ke-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:38:41 -0700
Received: from twshared15247.17.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 11 Oct 2023 15:37:38 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 6C68F3995128D; Wed, 11 Oct 2023 15:37:34 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 2/5] selftests/bpf: improve missed_kprobe_recursion test robustness
Date: Wed, 11 Oct 2023 15:37:25 -0700
Message-ID: <20231011223728.3188086-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011223728.3188086-1-andrii@kernel.org>
References: <20231011223728.3188086-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: LSCTy4uy8dLYtlqdUluDYh10XjvnxHjd
X-Proofpoint-ORIG-GUID: LSCTy4uy8dLYtlqdUluDYh10XjvnxHjd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_18,2023-10-11_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Given missed_kprobe_recursion is non-serial and uses common testing
kfuncs to count number of recursion misses it's possible that some other
parallel test can trigger extraneous recursion misses. So we can't
expect exactly 1 miss. Relax conditions and expect at least one.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/missed.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/missed.c b/tools/test=
ing/selftests/bpf/prog_tests/missed.c
index 24ade11f5c05..70d90c43537c 100644
--- a/tools/testing/selftests/bpf/prog_tests/missed.c
+++ b/tools/testing/selftests/bpf/prog_tests/missed.c
@@ -81,10 +81,10 @@ static void test_missed_kprobe_recursion(void)
 	ASSERT_EQ(topts.retval, 0, "test_run");
=20
 	ASSERT_EQ(get_missed_count(bpf_program__fd(skel->progs.test1)), 0, "tes=
t1_recursion_misses");
-	ASSERT_EQ(get_missed_count(bpf_program__fd(skel->progs.test2)), 1, "tes=
t2_recursion_misses");
-	ASSERT_EQ(get_missed_count(bpf_program__fd(skel->progs.test3)), 1, "tes=
t3_recursion_misses");
-	ASSERT_EQ(get_missed_count(bpf_program__fd(skel->progs.test4)), 1, "tes=
t4_recursion_misses");
-	ASSERT_EQ(get_missed_count(bpf_program__fd(skel->progs.test5)), 1, "tes=
t5_recursion_misses");
+	ASSERT_GE(get_missed_count(bpf_program__fd(skel->progs.test2)), 1, "tes=
t2_recursion_misses");
+	ASSERT_GE(get_missed_count(bpf_program__fd(skel->progs.test3)), 1, "tes=
t3_recursion_misses");
+	ASSERT_GE(get_missed_count(bpf_program__fd(skel->progs.test4)), 1, "tes=
t4_recursion_misses");
+	ASSERT_GE(get_missed_count(bpf_program__fd(skel->progs.test5)), 1, "tes=
t5_recursion_misses");
=20
 cleanup:
 	missed_kprobe_recursion__destroy(skel);
--=20
2.34.1


