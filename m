Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFC144ED40
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 20:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbhKLT3n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 14:29:43 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7594 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229810AbhKLT3m (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 12 Nov 2021 14:29:42 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ACItqX9025329
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 11:26:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=qrUiNveXt2dgUSQRVAh90JyUsOsXLRK1sshmlj1wQ9A=;
 b=rGAfhvGK2K5dS6vPk/j46JBumaGs+YkV7InF4e7JboMYcKWHTr+B4SIxv8It0Xh/Yj14
 kIfrW1MpL9rqOlXSV7mHnUlJEGWuaY6NrobqsvzrrO1ZMkq13n+mGQaFEKVtJWXUwc56
 nMZma9qIV41v0NOprsXEOyoSsDp2gcLdyZg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c9wysr78g-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 11:26:51 -0800
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 12 Nov 2021 11:25:44 -0800
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id C0FCA6C83837; Fri, 12 Nov 2021 11:25:39 -0800 (PST)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <fallentree@fb.com>,
        Yucong Sun <sunyucong@gmail.com>
Subject: [PATCH bpf-next 2/4] selftests/bpf: variable naming fix
Date:   Fri, 12 Nov 2021 11:25:33 -0800
Message-ID: <20211112192535.898352-3-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211112192535.898352-1-fallentree@fb.com>
References: <20211112192535.898352-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: bJJT6CLlCcIeFMf9y1Csta02NpjmO6ag
X-Proofpoint-ORIG-GUID: bJJT6CLlCcIeFMf9y1Csta02NpjmO6ag
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-12_05,2021-11-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=755 priorityscore=1501 bulkscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111120102
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yucong Sun <sunyucong@gmail.com>

Change log_fd to log_fp to reflect its type correctly.

Signed-off-by: Yucong Sun <sunyucong@gmail.com>
---
 tools/testing/selftests/bpf/test_progs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index d129ea5c9a48..926475aa10bb 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -939,7 +939,7 @@ static void *dispatch_thread(void *ctx)
 {
 	struct dispatch_data *data =3D ctx;
 	int sock_fd;
-	FILE *log_fd =3D NULL;
+	FILE *log_fp =3D NULL;
=20
 	sock_fd =3D data->sock_fd;
=20
@@ -1002,8 +1002,8 @@ static void *dispatch_thread(void *ctx)
=20
 			/* collect all logs */
 			if (msg_test_done.test_done.have_log) {
-				log_fd =3D open_memstream(&result->log_buf, &result->log_cnt);
-				if (!log_fd)
+				log_fp =3D open_memstream(&result->log_buf, &result->log_cnt);
+				if (!log_fp)
 					goto error;
=20
 				while (true) {
@@ -1014,12 +1014,12 @@ static void *dispatch_thread(void *ctx)
 					if (msg_log.type !=3D MSG_TEST_LOG)
 						goto error;
=20
-					fprintf(log_fd, "%s", msg_log.test_log.log_buf);
+					fprintf(log_fp, "%s", msg_log.test_log.log_buf);
 					if (msg_log.test_log.is_last)
 						break;
 				}
-				fclose(log_fd);
-				log_fd =3D NULL;
+				fclose(log_fp);
+				log_fp =3D NULL;
 			}
 			/* output log */
 			{
@@ -1045,8 +1045,8 @@ static void *dispatch_thread(void *ctx)
 	if (env.debug)
 		fprintf(stderr, "[%d]: Protocol/IO error: %s.\n", data->worker_id, str=
error(errno));
=20
-	if (log_fd)
-		fclose(log_fd);
+	if (log_fp)
+		fclose(log_fp);
 done:
 	{
 		struct msg msg_exit;
--=20
2.30.2

