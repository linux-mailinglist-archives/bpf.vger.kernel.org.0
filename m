Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0CB3F7C6B
	for <lists+bpf@lfdr.de>; Wed, 25 Aug 2021 20:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240689AbhHYSsv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Aug 2021 14:48:51 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44126 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240322AbhHYSsu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 25 Aug 2021 14:48:50 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17PIhPbF018479
        for <bpf@vger.kernel.org>; Wed, 25 Aug 2021 11:48:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=BljyG5RYg2rqg821rjy3xBXWmHYNrHQfXLuS6Xolp2o=;
 b=NuybvQ1XrbQHR4ftCP2VpCUs4EBbvQqvJzMoQewsVBOQ1yvIqtotRT8zIgi1B/+ZvSDy
 9dbwL0GQF1mLr7nIxi5Zew5YT3WR5KJPlPPdCylsU1RrfS5ZcGbkvUlw4dnn8pkFcuST
 dbXv8ehehZJYUgO1FbrWnfpo6eaGSc6dwsg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3an6hd7m7k-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 25 Aug 2021 11:48:04 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 25 Aug 2021 11:48:02 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id BCD6F2A16F12; Wed, 25 Aug 2021 11:47:54 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <andrii@kernel.org>
CC:     <sunyucong@gmail.com>, <bpf@vger.kernel.org>,
        Yucong Sun <fallentree@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: reduce more flakyness in sockmap_listen
Date:   Wed, 25 Aug 2021 11:47:45 -0700
Message-ID: <20210825184745.2680830-1-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: jypCTktTZpjDBxvVdVESXJ8ae0txsA-Y
X-Proofpoint-ORIG-GUID: jypCTktTZpjDBxvVdVESXJ8ae0txsA-Y
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-25_07:2021-08-25,2021-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=945
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108250110
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds similar retry logic to more places where read() is used, =
to
reduce flakyness in slow CI environment.

Signed-off-by: Yucong Sun <fallentree@fb.com>
---
 .../selftests/bpf/prog_tests/sockmap_listen.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/to=
ols/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 6a5df28f9a3d..5c5979046523 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -949,6 +949,7 @@ static void redir_to_connected(int family, int sotype=
, int sock_mapfd,
 	int err, n;
 	u32 key;
 	char b;
+	int retries =3D 100;
=20
 	zero_verdict_count(verd_mapfd);
=20
@@ -1001,10 +1002,15 @@ static void redir_to_connected(int family, int so=
type, int sock_mapfd,
 		goto close_peer1;
 	if (pass !=3D 1)
 		FAIL("%s: want pass count 1, have %d", log_prefix, pass);
-
+again:
 	n =3D read(c0, &b, 1);
-	if (n < 0)
+	if (n < 0) {
+		if (errno =3D=3D EAGAIN && retries--) {
+			usleep(1000);
+			goto again;
+		}
 		FAIL_ERRNO("%s: read", log_prefix);
+	}
 	if (n =3D=3D 0)
 		FAIL("%s: incomplete read", log_prefix);
=20
@@ -1926,6 +1932,7 @@ static void unix_inet_redir_to_connected(int family=
, int type, int sock_mapfd,
 	int sfd[2];
 	u32 key;
 	char b;
+	int retries =3D 100;
=20
 	zero_verdict_count(verd_mapfd);
=20
@@ -1956,9 +1963,15 @@ static void unix_inet_redir_to_connected(int famil=
y, int type, int sock_mapfd,
 	if (pass !=3D 1)
 		FAIL("%s: want pass count 1, have %d", log_prefix, pass);
=20
+again:
 	n =3D read(mode =3D=3D REDIR_INGRESS ? p0 : c0, &b, 1);
-	if (n < 0)
+	if (n < 0) {
+		if (errno =3D=3D EAGAIN && retries--) {
+			usleep(1000);
+			goto again;
+		}
 		FAIL_ERRNO("%s: read", log_prefix);
+	}
 	if (n =3D=3D 0)
 		FAIL("%s: incomplete read", log_prefix);
=20
--=20
2.30.2

