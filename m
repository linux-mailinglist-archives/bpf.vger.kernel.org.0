Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4213B67A0F4
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 19:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbjAXSNG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 13:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjAXSNF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 13:13:05 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21971B564
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 10:13:04 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OEDmn7001514
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 10:13:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=irGLxsGKrKc8VmLqXro7DVPSrJDPEM2LrfMN2G5mdPU=;
 b=A2uIKLUbrG1Q/LKwtTJ5v1AHv/FWlBTkSKJ3gnT3wRc6VM0KGjmex1E+qS2A/jP/K8Kr
 40wQ5kWJ890CDFy9oyIK690IQo/5mFYtCgbMPCg5VdCSYP3+bT5fuJk6NTDOtpakqweL
 gDYg+0hcZHB3H1SkhMhR4t4ivpju6WNvydxHy1ebk4Oe1qLRyq/BlUhUVAIwBeflBliW
 WouavzA3p7NpIlcR6Q+PMWv2SL6Eek+PVBbGrG4wDRAYcvax+XX18g3Z2va5Ys01eEMI
 O/QxfdhDN9MbD2bAGboJp//qmzxvL9/aiBhUvSmcbM8zK2AqST6tDmBoaIRrAAX2pn7x nQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n8g8aehkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 10:13:04 -0800
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 24 Jan 2023 10:13:03 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 76C4A3645D8D; Tue, 24 Jan 2023 10:12:50 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Calls bpf_setsockopt() on a ktls enabled socket.
Date:   Tue, 24 Jan 2023 10:12:20 -0800
Message-ID: <20230124181220.2871611-3-kuifeng@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230124181220.2871611-1-kuifeng@meta.com>
References: <20230124181220.2871611-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Off7EqXUH9ksU7QK-Kp1rnthsnfFLZ7-
X-Proofpoint-ORIG-GUID: Off7EqXUH9ksU7QK-Kp1rnthsnfFLZ7-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-24_13,2023-01-24_01,2022-06-22_01
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
 .../selftests/bpf/prog_tests/setget_sockopt.c | 70 +++++++++++++++++++
 .../selftests/bpf/progs/setget_sockopt.c      |  8 +++
 2 files changed, 78 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c b/to=
ols/testing/selftests/bpf/prog_tests/setget_sockopt.c
index 018611e6b248..7bf3736b7286 100644
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
@@ -83,6 +84,73 @@ static void test_udp(int family)
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
@@ -118,6 +186,8 @@ void test_setget_sockopt(void)
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
index 9523333b8905..027d95755f9f 100644
--- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
@@ -6,6 +6,8 @@
 #include <bpf/bpf_core_read.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
+#define BPF_PROG_TEST_TCP_HDR_OPTIONS
+#include "test_tcp_hdr_options.h"
=20
 #ifndef ARRAY_SIZE
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
@@ -22,6 +24,7 @@ int nr_active;
 int nr_connect;
 int nr_binddev;
 int nr_socket_post_create;
+int nr_fin_wait1;
=20
 struct sockopt_test {
 	int opt;
@@ -386,6 +389,11 @@ int skops_sockopt(struct bpf_sock_ops *skops)
 		nr_passive +=3D !(bpf_test_sockopt(skops, sk) ||
 				test_tcp_maxseg(skops, sk) ||
 				test_tcp_saved_syn(skops, sk));
+		set_hdr_cb_flags(skops, BPF_SOCK_OPS_STATE_CB_FLAG);
+		break;
+	case BPF_SOCK_OPS_STATE_CB:
+		if (skops->args[1] =3D=3D BPF_TCP_CLOSE_WAIT)
+			nr_fin_wait1 +=3D !bpf_test_sockopt(skops, sk);
 		break;
 	}
=20
--=20
2.30.2

