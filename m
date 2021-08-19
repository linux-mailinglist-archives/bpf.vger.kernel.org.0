Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A433F1DEF
	for <lists+bpf@lfdr.de>; Thu, 19 Aug 2021 18:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbhHSQgv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Aug 2021 12:36:51 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1538 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229521AbhHSQgu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Aug 2021 12:36:50 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 17JGZRsf001189
        for <bpf@vger.kernel.org>; Thu, 19 Aug 2021 09:36:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=uoCRjhumlmXtDtAxRExahkY6b0MFTVamoeAoLrKtljs=;
 b=VJBCC+CQXxKla8pimRdoDBbGZc17EUBdy0PbvbdrnIt057x2kaV8MNoXWRrO+IZfpbsp
 Od5NQXRloX8tuExRNapE4IiInPepw92Xuxbox9e8DRms9PU8n+2WAD8N4ORmwEVq6sQ5
 tnxFx7UN+qDHqtHVa+hAq6AUgJzM5YM7RgU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3ahme42j31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 19 Aug 2021 09:36:14 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 19 Aug 2021 09:36:12 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 6B82625EE0DC; Thu, 19 Aug 2021 09:36:10 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <andrii@kernel.org>
CC:     <sunyucong@gmail.com>, <bpf@vger.kernel.org>,
        Yucong Sun <fallentree@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: adding delay in socketmap_listen to reduce flakyness
Date:   Thu, 19 Aug 2021 09:36:09 -0700
Message-ID: <20210819163609.2583758-1-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: fZmB4_dlKFlemwWubpuXfSxZH1hq9Uy2
X-Proofpoint-GUID: fZmB4_dlKFlemwWubpuXfSxZH1hq9Uy2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-19_06:2021-08-17,2021-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=785
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108190097
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds a 1ms delay to reduce flakyness of the test.

Signed-off-by: Yucong Sun <fallentree@fb.com>
---
 .../selftests/bpf/prog_tests/sockmap_listen.c        | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/to=
ols/testing/selftests/bpf/prog_tests/sockmap_listen.c
index afa14fb66f08..6a5df28f9a3d 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1603,8 +1603,10 @@ static void unix_redir_to_connected(int sotype, in=
t sock_mapfd,
 again:
 	n =3D read(mode =3D=3D REDIR_INGRESS ? p0 : c0, &b, 1);
 	if (n < 0) {
-		if (errno =3D=3D EAGAIN && retries--)
+		if (errno =3D=3D EAGAIN && retries--) {
+			usleep(1000);
 			goto again;
+		}
 		FAIL_ERRNO("%s: read", log_prefix);
 	}
 	if (n =3D=3D 0)
@@ -1776,8 +1778,10 @@ static void udp_redir_to_connected(int family, int=
 sock_mapfd, int verd_mapfd,
 again:
 	n =3D read(mode =3D=3D REDIR_INGRESS ? p0 : c0, &b, 1);
 	if (n < 0) {
-		if (errno =3D=3D EAGAIN && retries--)
+		if (errno =3D=3D EAGAIN && retries--) {
+			usleep(1000);
 			goto again;
+		}
 		FAIL_ERRNO("%s: read", log_prefix);
 	}
 	if (n =3D=3D 0)
@@ -1869,8 +1873,10 @@ static void inet_unix_redir_to_connected(int famil=
y, int type, int sock_mapfd,
 again:
 	n =3D read(mode =3D=3D REDIR_INGRESS ? p0 : c0, &b, 1);
 	if (n < 0) {
-		if (errno =3D=3D EAGAIN && retries--)
+		if (errno =3D=3D EAGAIN && retries--) {
+			usleep(1000);
 			goto again;
+		}
 		FAIL_ERRNO("%s: read", log_prefix);
 	}
 	if (n =3D=3D 0)
--=20
2.30.2

