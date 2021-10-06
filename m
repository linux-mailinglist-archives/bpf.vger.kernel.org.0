Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272DF42464E
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 20:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhJFS6V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 14:58:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47350 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232072AbhJFS6V (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 14:58:21 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196FAH48022993
        for <bpf@vger.kernel.org>; Wed, 6 Oct 2021 11:56:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=zPrWw2xZivq89yoR51qqNQeE54jS3dR/jheZwirA1sw=;
 b=PlSR+4OPqpNRdp0Aw9XzXR4R6cHvLzSZ3M4zeMp0QdXTO1B7lxzg77VooGZJ5apZxkJ5
 rnzSokwoArQjoUVVlyjKR4Hpb1CWf9uh2NQXRI1CrvAM1LPy7elxAopaaGKHfb49AcEL
 HWImp588mgcJ2ZQs3ntUG1OKIRt5nHm9J1k= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bhe6q9yj0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 11:56:28 -0700
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 6 Oct 2021 11:56:24 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 4E25D4BDB5C5; Wed,  6 Oct 2021 11:56:20 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <sunyucong@gmail.com>
Subject: [PATCH bpf-next v6 13/14] selftests/bpf: increase loop count for perf_branches
Date:   Wed, 6 Oct 2021 11:56:18 -0700
Message-ID: <20211006185619.364369-14-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006185619.364369-1-fallentree@fb.com>
References: <20211006185619.364369-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: -YhMKNzAshd-ab-0ZPnKSKZvBxOHOl7g
X-Proofpoint-GUID: -YhMKNzAshd-ab-0ZPnKSKZvBxOHOl7g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=820 adultscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yucong Sun <sunyucong@gmail.com>

This make this test more likely to succeed.

Signed-off-by: Yucong Sun <sunyucong@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/perf_branches.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/perf_branches.c b/too=
ls/testing/selftests/bpf/prog_tests/perf_branches.c
index 6b2e3dced619..d7e88b2c5f36 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_branches.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
@@ -16,7 +16,7 @@ static void check_good_sample(struct test_perf_branches=
 *skel)
 	int duration =3D 0;
=20
 	if (CHECK(!skel->bss->valid, "output not valid",
-		 "no valid sample from prog"))
+		 "no valid sample from prog\n"))
 		return;
=20
 	/*
@@ -46,7 +46,7 @@ static void check_bad_sample(struct test_perf_branches =
*skel)
 	int duration =3D 0;
=20
 	if (CHECK(!skel->bss->valid, "output not valid",
-		 "no valid sample from prog"))
+		 "no valid sample from prog\n"))
 		return;
=20
 	CHECK((required_size !=3D -EINVAL && required_size !=3D -ENOENT),
@@ -84,7 +84,7 @@ static void test_perf_branches_common(int perf_fd,
 	if (CHECK(err, "set_affinity", "cpu #0, err %d\n", err))
 		goto out_destroy;
 	/* spin the loop for a while (random high number) */
-	for (i =3D 0; i < 1000000; ++i)
+	for (i =3D 0; i < 100000000; ++i)
 		++j;
=20
 	test_perf_branches__detach(skel);
--=20
2.30.2

