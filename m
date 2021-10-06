Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922A7424650
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 20:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhJFS6W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 14:58:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:2776 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238725AbhJFS6W (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 14:58:22 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196Gf9mk017204
        for <bpf@vger.kernel.org>; Wed, 6 Oct 2021 11:56:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=cleiZcba85tKnICHY4bWJl6iBjUMIZH9dmnhh3/A5Cw=;
 b=Bm0kMVPeassI5+1I1qCuBP07vkKCCVZF4k8HowECH6K9OjJBpyOV90jia155wnmGJh4N
 ZsV9w02DlDr8QNUrbCG9+ltX10GPz/fjj+u3NwG3wV/mal9bLa5TZvBXUXrWuze1M3nu
 atKOgntcNLE1yxYx1RD3A2aMaPQtBYkVKV4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bhfhj97kk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 11:56:29 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 6 Oct 2021 11:56:27 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 4562A4BDB5C1; Wed,  6 Oct 2021 11:56:20 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <sunyucong@gmail.com>
Subject: [PATCH bpf-next v6 11/14] selftests/bpf: adding random delay for send_signal test
Date:   Wed, 6 Oct 2021 11:56:16 -0700
Message-ID: <20211006185619.364369-12-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006185619.364369-1-fallentree@fb.com>
References: <20211006185619.364369-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: q8yGr8T1NAwmf3Uv7M5pcp5z8cAzmX_a
X-Proofpoint-GUID: q8yGr8T1NAwmf3Uv7M5pcp5z8cAzmX_a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=665 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yucong Sun <sunyucong@gmail.com>

This patch adds random delay on waiting for the signal to arrive,
making the test more robust.

Signed-off-by: Yucong Sun <sunyucong@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/send_signal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools=
/testing/selftests/bpf/prog_tests/send_signal.c
index 776916b61c40..6200256243f2 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -19,6 +19,7 @@ static void test_send_signal_common(struct perf_event_a=
ttr *attr,
 	int err =3D -1, pmu_fd =3D -1;
 	char buf[256];
 	pid_t pid;
+	int attempts =3D 100;
=20
 	if (!ASSERT_OK(pipe(pipe_c2p), "pipe_c2p"))
 		return;
@@ -63,7 +64,10 @@ static void test_send_signal_common(struct perf_event_=
attr *attr,
 		ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
=20
 		/* wait a little for signal handler */
-		sleep(1);
+		while (attempts > 0 && !sigusr1_received) {
+			attempts--;
+			usleep(500 + rand() % 500);
+		}
=20
 		buf[0] =3D sigusr1_received ? '2' : '0';
 		ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
--=20
2.30.2

