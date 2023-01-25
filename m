Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD2967BC6A
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 21:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbjAYUQm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 15:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbjAYUQl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 15:16:41 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D5240F3
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 12:16:40 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PJ776k008569
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 12:16:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=hDl2mcymMTVyc+6Xq1+/ydbVu6CmXLgjtJpTXj/7teM=;
 b=lsREksAPInyengQs4cnZNk0+ZSnpjtvODEPIZd0GP7wEtadUb0ZwG3uimJXEpyBGwDP7
 Gi+WvZcfX5n0Jr5koQ7vcaHgJUlCJO8mswVovQtIIMM1FsQvoMkP0XuDV4v2HB7hkxKZ
 90i4YoGWD7ccwfbLS1JVjy1he1e7uokdzTdKpo+zxzOvV95uD0FwvomPmj3sn9cFgkkO
 gGs3gIEgteIYyrZyXsaqbW/QojJ0N0fV1suip9SgIkT22TTxQvR7me71TbBEdW/yxN0M
 6X+4gRpi14ygjHmG5cNzVmJFwZGCc76lvpO7rKYgAZUB6L6Ri4fhdJvc1t+MpaWLGdDK Wg== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3naks003p2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 12:16:40 -0800
Received: from twshared25383.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 25 Jan 2023 12:16:39 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 287E037B6C93; Wed, 25 Jan 2023 12:16:23 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Calls bpf_setsockopt() on a ktls enabled socket.
Date:   Wed, 25 Jan 2023 12:16:08 -0800
Message-ID: <20230125201608.908230-3-kuifeng@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230125201608.908230-1-kuifeng@meta.com>
References: <20230125201608.908230-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: mok996fvH2YRXmRlyo4jKv9wS3wEk0sL
X-Proofpoint-ORIG-GUID: mok996fvH2YRXmRlyo4jKv9wS3wEk0sL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ensures that whenever bpf_setsockopt() is called with the SOL_TCP
option on a ktls enabled socket, the call will be accepted by the
system. The provided test makes sure of this by performing an
examination when the server side socket is in the CLOSE_WAIT state. At
this stage, ktls is still enabled on the server socket and can be used
to test if bpf_setsockopt() works correctly with linux.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 .../selftests/bpf/prog_tests/setget_sockopt.c | 73 +++++++++++++++++++
 .../selftests/bpf/progs/setget_sockopt.c      |  8 ++
 2 files changed, 81 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c b/to=
ols/testing/selftests/bpf/prog_tests/setget_sockopt.c
index 018611e6b248..8591a3a780c9 100644
--- a/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
@@ -4,6 +4,7 @@
 #define _GNU_SOURCE
 #include <sched.h>
 #include <linux/socket.h>
+#include <linux/tls.h>
 #include <net/if.h>
=20
 #include "test_progs.h"
@@ -83,6 +84,76 @@ static void test_udp(int family)
 	ASSERT_EQ(bss->nr_binddev, 1, "nr_bind");
 }
=20
+static void test_ktls(int family)
+{
+	struct tls12_crypto_info_aes_gcm_128 aes128;
+	struct setget_sockopt__bss *bss =3D skel->bss;
+	int cfd =3D -1, sfd =3D -1, fd =3D -1, ret;
+
+	memset(bss, 0, sizeof(*bss));
+
+	sfd =3D start_server(family, SOCK_STREAM,
+			   family =3D=3D AF_INET6 ? addr6_str : addr4_str, 0, 0);
+	if (!ASSERT_GE(sfd, 0, "start_server"))
+		return;
+	fd =3D connect_to_fd(sfd, 0);
+	if (!ASSERT_GE(fd, 0, "connect_to_fd"))
+		goto err_out;
+
+	cfd =3D accept(sfd, NULL, 0);
+	if (!ASSERT_GE(cfd, 0, "accept"))
+		goto err_out;
+
+	close(sfd);
+	sfd =3D -1;
+
+	/* Setup KTLS */
+	ret =3D setsockopt(fd, IPPROTO_TCP, TCP_ULP, "tls", sizeof("tls"));
+	if (!ASSERT_OK(ret, "setsockopt"))
+		goto err_out;
+	ret =3D setsockopt(cfd, IPPROTO_TCP, TCP_ULP, "tls", sizeof("tls"));
+	if (!ASSERT_OK(ret, "setsockopt"))
+		goto err_out;
+
+	memset(&aes128, 0, sizeof(aes128));
+	aes128.info.version =3D TLS_1_2_VERSION;
+	aes128.info.cipher_type =3D TLS_CIPHER_AES_GCM_128;
+
+	ret =3D setsockopt(fd, SOL_TLS, TLS_TX, &aes128, sizeof(aes128));
+	if (!ASSERT_OK(ret, "setsockopt"))
+		goto err_out;
+
+	ret =3D setsockopt(cfd, SOL_TLS, TLS_RX, &aes128, sizeof(aes128));
+	if (!ASSERT_OK(ret, "setsockopt"))
+		goto err_out;
+
+	/* KTLS is enabled */
+
+	close(fd);
+	/* At this point, the cfd socket is at the CLOSE_WAIT state
+	 * and still run TLS protocol.  The test for
+	 * BPF_TCP_CLOSE_WAIT should be run at this point.
+	 */
+	char buf[1];
+	ret =3D read(cfd, buf, 1);
+	ASSERT_EQ(ret, 0, "read");
+	close(cfd);
+
+	ASSERT_EQ(bss->nr_listen, 1, "nr_listen");
+	ASSERT_EQ(bss->nr_connect, 1, "nr_connect");
+	ASSERT_EQ(bss->nr_active, 1, "nr_active");
+	ASSERT_EQ(bss->nr_passive, 1, "nr_passive");
+	ASSERT_EQ(bss->nr_socket_post_create, 2, "nr_socket_post_create");
+	ASSERT_EQ(bss->nr_binddev, 2, "nr_bind");
+	ASSERT_EQ(bss->nr_fin_wait1, 1, "nr_fin_wait1");
+	return;
+
+err_out:
+	close(fd);
+	close(cfd);
+	close(sfd);
+}
+
 void test_setget_sockopt(void)
 {
 	cg_fd =3D test__join_cgroup(CG_NAME);
@@ -118,6 +189,8 @@ void test_setget_sockopt(void)
 	test_tcp(AF_INET);
 	test_udp(AF_INET6);
 	test_udp(AF_INET);
+	test_ktls(AF_INET6);
+	test_ktls(AF_INET);
=20
 done:
 	setget_sockopt__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools/t=
esting/selftests/bpf/progs/setget_sockopt.c
index 9523333b8905..7a438600ae98 100644
--- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
@@ -22,6 +22,7 @@ int nr_active;
 int nr_connect;
 int nr_binddev;
 int nr_socket_post_create;
+int nr_fin_wait1;
=20
 struct sockopt_test {
 	int opt;
@@ -386,6 +387,13 @@ int skops_sockopt(struct bpf_sock_ops *skops)
 		nr_passive +=3D !(bpf_test_sockopt(skops, sk) ||
 				test_tcp_maxseg(skops, sk) ||
 				test_tcp_saved_syn(skops, sk));
+		bpf_sock_ops_cb_flags_set(skops,
+					  skops->bpf_sock_ops_cb_flags |
+					  BPF_SOCK_OPS_STATE_CB_FLAG);
+		break;
+	case BPF_SOCK_OPS_STATE_CB:
+		if (skops->args[1] =3D=3D BPF_TCP_CLOSE_WAIT)
+			nr_fin_wait1 +=3D !bpf_test_sockopt(skops, sk);
 		break;
 	}
=20
--=20
2.30.2

