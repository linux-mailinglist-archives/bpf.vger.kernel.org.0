Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B703F52E7
	for <lists+bpf@lfdr.de>; Mon, 23 Aug 2021 23:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbhHWVhX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Aug 2021 17:37:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55850 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232503AbhHWVhR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Aug 2021 17:37:17 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 17NLQTso019717
        for <bpf@vger.kernel.org>; Mon, 23 Aug 2021 14:36:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=XevacFUrBf4Xpy1G3C5BzqeUVQOKsIjOkqc5PhzDFEc=;
 b=H2v7r/WqXNGu07vnSAR3yB7nWnqbAgVoxkFMISOPMsa+4pYekt1i8l7nEcczso99Qfbi
 RKs8HRJ5dxaxfLMzokT9MRhOHtbaoQV43COFemHtSavDSIId7qoK5CIEVn8PKdzQ4hvw
 KIg7D2yRIb3yrK0hFRQAmvGlHwueerl9VVQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3amdru2jk1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 23 Aug 2021 14:36:33 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 23 Aug 2021 14:36:32 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id CF2E528CD0EB; Mon, 23 Aug 2021 14:36:29 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <andrii@kernel.org>
CC:     <sunyucong@gmail.com>, <bpf@vger.kernel.org>,
        Yucong Sun <fallentree@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: reduce flakyness in timer_mim
Date:   Mon, 23 Aug 2021 14:36:29 -0700
Message-ID: <20210823213629.3519641-1-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: Ky9tqlLuHBgfN6DNGMnaJBx-qBub4C-3
X-Proofpoint-ORIG-GUID: Ky9tqlLuHBgfN6DNGMnaJBx-qBub4C-3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-23_04:2021-08-23,2021-08-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 mlxlogscore=748 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108230146
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch extends wait time in timer_mim. As observed in slow CI environ=
ment,
it is possible to have interrupt/preemption long enough to cause the test=
 to
fail, almost 1 failure in 5 runs.

Signed-off-by: Yucong Sun <fallentree@fb.com>
---
 .../testing/selftests/bpf/prog_tests/timer_mim.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/timer_mim.c b/tools/t=
esting/selftests/bpf/prog_tests/timer_mim.c
index f5acbcbe33a4..ced8f6cf347c 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer_mim.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer_mim.c
@@ -23,8 +23,12 @@ static int timer_mim(struct timer_mim *timer_skel)
=20
 	/* check that timer_cb[12] are incrementing 'cnt' */
 	cnt1 =3D READ_ONCE(timer_skel->bss->cnt);
-	usleep(200); /* 100 times more than interval */
-	cnt2 =3D READ_ONCE(timer_skel->bss->cnt);
+	for (int i =3D 0; i < 100; i++) {
+		cnt2 =3D READ_ONCE(timer_skel->bss->cnt);
+		if (cnt2 !=3D cnt1)
+			break;
+		usleep(200); /* 100 times more than interval */
+	}
 	ASSERT_GT(cnt2, cnt1, "cnt");
=20
 	ASSERT_EQ(timer_skel->bss->err, 0, "err");
@@ -37,8 +41,12 @@ static int timer_mim(struct timer_mim *timer_skel)
=20
 	/* check that timer_cb[12] are no longer running */
 	cnt1 =3D READ_ONCE(timer_skel->bss->cnt);
-	usleep(200);
-	cnt2 =3D READ_ONCE(timer_skel->bss->cnt);
+	for (int i =3D 0; i < 100; i++) {
+		usleep(200); /* 100 times more than interval */
+		cnt2 =3D READ_ONCE(timer_skel->bss->cnt);
+		if (cnt2 =3D=3D cnt1)
+			break;
+	}
 	ASSERT_EQ(cnt2, cnt1, "cnt");
=20
 	return 0;
--=20
2.30.2

