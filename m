Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D0F477C4B
	for <lists+bpf@lfdr.de>; Thu, 16 Dec 2021 20:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240843AbhLPTQd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 14:16:33 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43938 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236663AbhLPTQd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Dec 2021 14:16:33 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BGHaY2h013165
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 11:16:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=QW+kKEporWo1JVYWxK0aSW7YSKHZeJx4tAUIa6PZjxU=;
 b=ZmX1lZiWPhI5SHmokukrIETGJq26kqLoBVBpV0L1hMKth3l4bzmhzKIcOmSU9o9ravKu
 OIscA48U09gxT6exVEzqEheOBZqLfiHLwywaCnx2j72vjPau6T1kfHdUUSUByTA6zCZ3
 +Z0x25n0cePpp9EvNQgArs5BjMpqB3TQX3M= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3cyyrr575n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 11:16:33 -0800
Received: from twshared7460.02.ash7.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 11:16:32 -0800
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 638E63FED855; Thu, 16 Dec 2021 11:16:30 -0800 (PST)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf] bpf: selftests: Fix racing issue in btf_skc_cls_ingress test
Date:   Thu, 16 Dec 2021 11:16:30 -0800
Message-ID: <20211216191630.466151-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: VS6dYnDhZEzW56CxpRuPsvai-4KFL7w0
X-Proofpoint-ORIG-GUID: VS6dYnDhZEzW56CxpRuPsvai-4KFL7w0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_07,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 impostorscore=0 mlxscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 adultscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160106
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The libbpf CI reported occasional failure in btf_skc_cls_ingress:

test_syncookie:FAIL:Unexpected syncookie states gen_cookie:80326634 recv_=
cookie:0
bpf prog error at line 97

"error at line 97" means the bpf prog cannot find the listening socket
when the final ack is received.  It then skipped processing
the syncookie in the final ack which then led to "recv_cookie:0".

The problem is the userspace program did not do accept() and went ahead
to close(listen_fd) before the kernel (and the bpf prog) had
a chance to process the final ack.

The fix is to add accept() call so that the userspace
will wait for the kernel to finish processing the final
ack first before close()-ing everything.

Fixes: 9a856cae2217 ("bpf: selftest: Add test_btf_skc_cls_ingress")
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 .../bpf/prog_tests/btf_skc_cls_ingress.c         | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c=
 b/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
index 762f6a9da8b5..664ffc0364f4 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
@@ -90,7 +90,7 @@ static void print_err_line(void)
=20
 static void test_conn(void)
 {
-	int listen_fd =3D -1, cli_fd =3D -1, err;
+	int listen_fd =3D -1, cli_fd =3D -1, srv_fd =3D -1, err;
 	socklen_t addrlen =3D sizeof(srv_sa6);
 	int srv_port;
=20
@@ -112,6 +112,10 @@ static void test_conn(void)
 	if (CHECK_FAIL(cli_fd =3D=3D -1))
 		goto done;
=20
+	srv_fd =3D accept(listen_fd, NULL, NULL);
+	if (CHECK_FAIL(srv_fd =3D=3D -1))
+		goto done;
+
 	if (CHECK(skel->bss->listen_tp_sport !=3D srv_port ||
 		  skel->bss->req_sk_sport !=3D srv_port,
 		  "Unexpected sk src port",
@@ -134,11 +138,13 @@ static void test_conn(void)
 		close(listen_fd);
 	if (cli_fd !=3D -1)
 		close(cli_fd);
+	if (srv_fd !=3D -1)
+		close(srv_fd);
 }
=20
 static void test_syncookie(void)
 {
-	int listen_fd =3D -1, cli_fd =3D -1, err;
+	int listen_fd =3D -1, cli_fd =3D -1, srv_fd =3D -1, err;
 	socklen_t addrlen =3D sizeof(srv_sa6);
 	int srv_port;
=20
@@ -161,6 +167,10 @@ static void test_syncookie(void)
 	if (CHECK_FAIL(cli_fd =3D=3D -1))
 		goto done;
=20
+	srv_fd =3D accept(listen_fd, NULL, NULL);
+	if (CHECK_FAIL(srv_fd =3D=3D -1))
+		goto done;
+
 	if (CHECK(skel->bss->listen_tp_sport !=3D srv_port,
 		  "Unexpected tp src port",
 		  "listen_tp_sport:%u expected:%u\n",
@@ -188,6 +198,8 @@ static void test_syncookie(void)
 		close(listen_fd);
 	if (cli_fd !=3D -1)
 		close(cli_fd);
+	if (srv_fd !=3D -1)
+		close(srv_fd);
 }
=20
 struct test {
--=20
2.30.2

