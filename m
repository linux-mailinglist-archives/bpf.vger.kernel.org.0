Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B315AA46B
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 02:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbiIBAby (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 20:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiIBAbw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 20:31:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25369E116
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 17:31:51 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28208mYd004507
        for <bpf@vger.kernel.org>; Thu, 1 Sep 2022 17:31:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Muzc1e88EKSwizpphKB9Hb2GOcNnzkCcmG5jgqAwA48=;
 b=UIcLVTICfylsX4uSp06HX7ENx4Xtp//Ex0uk1v0OTJR3K4D7Hrb/GqneVS3m/0FWb9Ba
 RQDv3ZPRlhk8x9OAZD0NIyfcUPVPjfPndUQfw8YrGpaA8t+occgjnD1fQtb4iQn7Qian
 2cKnkwlL0y5pepEc2SN5TMrOeLCpFEM/HqA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jav4fcycn-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 01 Sep 2022 17:31:51 -0700
Received: from twshared10425.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 17:31:49 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id E75B58C47D07; Thu,  1 Sep 2022 17:29:37 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, <kernel-team@fb.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH v2 bpf-next 17/17] selftest/bpf: Add test for bpf_getsockopt()
Date:   Thu, 1 Sep 2022 17:29:37 -0700
Message-ID: <20220902002937.2896904-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220902002750.2887415-1-kafai@fb.com>
References: <20220902002750.2887415-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: knckYPsYtVJl12BwiME9TT88zUEXkrSx
X-Proofpoint-ORIG-GUID: knckYPsYtVJl12BwiME9TT88zUEXkrSx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch removes the __bpf_getsockopt() which directly
reads the sk by using PTR_TO_BTF_ID.  Instead, the test now directly
uses the kernel bpf helper bpf_getsockopt() which supports all
the required optname now.

TCP_SAVE[D]_SYN and TCP_MAXSEG are not tested in a loop for all
the hooks and sock_ops's cb.  TCP_SAVE[D]_SYN only works
in passive connection.  TCP_MAXSEG only works when
it is setsockopt before the connection is established and
the getsockopt return value can only be tested after
the connection is established.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/setget_sockopt.c      | 148 +++++-------------
 2 files changed, 43 insertions(+), 106 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/=
testing/selftests/bpf/progs/bpf_tracing_net.h
index 5ebc6dabef84..adb087aecc9e 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
+++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
@@ -38,6 +38,7 @@
 #define TCP_USER_TIMEOUT	18
 #define TCP_NOTSENT_LOWAT	25
 #define TCP_SAVE_SYN		27
+#define TCP_SAVED_SYN		28
 #define TCP_CA_NAME_MAX		16
 #define TCP_NAGLE_OFF		1
=20
diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools/t=
esting/selftests/bpf/progs/setget_sockopt.c
index 79debf3c2f44..9523333b8905 100644
--- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
@@ -52,7 +52,6 @@ static const struct sockopt_test sol_socket_tests[] =3D=
 {
=20
 static const struct sockopt_test sol_tcp_tests[] =3D {
 	{ .opt =3D TCP_NODELAY, .flip =3D 1, },
-	{ .opt =3D TCP_MAXSEG, .new =3D 1314, .expected =3D 1314, },
 	{ .opt =3D TCP_KEEPIDLE, .new =3D 123, .expected =3D 123, .restore =3D =
321, },
 	{ .opt =3D TCP_KEEPINTVL, .new =3D 123, .expected =3D 123, .restore =3D=
 321, },
 	{ .opt =3D TCP_KEEPCNT, .new =3D 123, .expected =3D 123, .restore =3D 1=
24, },
@@ -62,7 +61,6 @@ static const struct sockopt_test sol_tcp_tests[] =3D {
 	{ .opt =3D TCP_THIN_LINEAR_TIMEOUTS, .flip =3D 1, },
 	{ .opt =3D TCP_USER_TIMEOUT, .new =3D 123400, .expected =3D 123400, },
 	{ .opt =3D TCP_NOTSENT_LOWAT, .new =3D 1314, .expected =3D 1314, },
-	{ .opt =3D TCP_SAVE_SYN, .new =3D 1, .expected =3D 1, },
 	{ .opt =3D 0, },
 };
=20
@@ -82,102 +80,6 @@ struct loop_ctx {
 	struct sock *sk;
 };
=20
-static int __bpf_getsockopt(void *ctx, struct sock *sk,
-			    int level, int opt, int *optval,
-			    int optlen)
-{
-	if (level =3D=3D SOL_SOCKET) {
-		switch (opt) {
-		case SO_REUSEADDR:
-			*optval =3D !!BPF_CORE_READ_BITFIELD(sk, sk_reuse);
-			break;
-		case SO_KEEPALIVE:
-			*optval =3D !!(sk->sk_flags & (1UL << 3));
-			break;
-		case SO_RCVLOWAT:
-			*optval =3D sk->sk_rcvlowat;
-			break;
-		case SO_MAX_PACING_RATE:
-			*optval =3D sk->sk_max_pacing_rate;
-			break;
-		default:
-			return bpf_getsockopt(ctx, level, opt, optval, optlen);
-		}
-		return 0;
-	}
-
-	if (level =3D=3D IPPROTO_TCP) {
-		struct tcp_sock *tp =3D bpf_skc_to_tcp_sock(sk);
-
-		if (!tp)
-			return -1;
-
-		switch (opt) {
-		case TCP_NODELAY:
-			*optval =3D !!(BPF_CORE_READ_BITFIELD(tp, nonagle) & TCP_NAGLE_OFF);
-			break;
-		case TCP_MAXSEG:
-			*optval =3D tp->rx_opt.user_mss;
-			break;
-		case TCP_KEEPIDLE:
-			*optval =3D tp->keepalive_time / CONFIG_HZ;
-			break;
-		case TCP_SYNCNT:
-			*optval =3D tp->inet_conn.icsk_syn_retries;
-			break;
-		case TCP_KEEPINTVL:
-			*optval =3D tp->keepalive_intvl / CONFIG_HZ;
-			break;
-		case TCP_KEEPCNT:
-			*optval =3D tp->keepalive_probes;
-			break;
-		case TCP_WINDOW_CLAMP:
-			*optval =3D tp->window_clamp;
-			break;
-		case TCP_THIN_LINEAR_TIMEOUTS:
-			*optval =3D !!BPF_CORE_READ_BITFIELD(tp, thin_lto);
-			break;
-		case TCP_USER_TIMEOUT:
-			*optval =3D tp->inet_conn.icsk_user_timeout;
-			break;
-		case TCP_NOTSENT_LOWAT:
-			*optval =3D tp->notsent_lowat;
-			break;
-		case TCP_SAVE_SYN:
-			*optval =3D BPF_CORE_READ_BITFIELD(tp, save_syn);
-			break;
-		default:
-			return bpf_getsockopt(ctx, level, opt, optval, optlen);
-		}
-		return 0;
-	}
-
-	if (level =3D=3D IPPROTO_IPV6) {
-		switch (opt) {
-		case IPV6_AUTOFLOWLABEL: {
-			__u16 proto =3D sk->sk_protocol;
-			struct inet_sock *inet_sk;
-
-			if (proto =3D=3D IPPROTO_TCP)
-				inet_sk =3D (struct inet_sock *)bpf_skc_to_tcp_sock(sk);
-			else
-				inet_sk =3D (struct inet_sock *)bpf_skc_to_udp6_sock(sk);
-
-			if (!inet_sk)
-				return -1;
-
-			*optval =3D !!inet_sk->pinet6->autoflowlabel;
-			break;
-		}
-		default:
-			return bpf_getsockopt(ctx, level, opt, optval, optlen);
-		}
-		return 0;
-	}
-
-	return bpf_getsockopt(ctx, level, opt, optval, optlen);
-}
-
 static int bpf_test_sockopt_flip(void *ctx, struct sock *sk,
 				 const struct sockopt_test *t,
 				 int level)
@@ -186,7 +88,7 @@ static int bpf_test_sockopt_flip(void *ctx, struct soc=
k *sk,
=20
 	opt =3D t->opt;
=20
-	if (__bpf_getsockopt(ctx, sk, level, opt, &old, sizeof(old)))
+	if (bpf_getsockopt(ctx, level, opt, &old, sizeof(old)))
 		return 1;
 	/* kernel initialized txrehash to 255 */
 	if (level =3D=3D SOL_SOCKET && opt =3D=3D SO_TXREHASH && old !=3D 0 && =
old !=3D 1)
@@ -195,7 +97,7 @@ static int bpf_test_sockopt_flip(void *ctx, struct soc=
k *sk,
 	new =3D !old;
 	if (bpf_setsockopt(ctx, level, opt, &new, sizeof(new)))
 		return 1;
-	if (__bpf_getsockopt(ctx, sk, level, opt, &tmp, sizeof(tmp)) ||
+	if (bpf_getsockopt(ctx, level, opt, &tmp, sizeof(tmp)) ||
 	    tmp !=3D new)
 		return 1;
=20
@@ -218,13 +120,13 @@ static int bpf_test_sockopt_int(void *ctx, struct s=
ock *sk,
 	else
 		expected =3D t->expected;
=20
-	if (__bpf_getsockopt(ctx, sk, level, opt, &old, sizeof(old)) ||
+	if (bpf_getsockopt(ctx, level, opt, &old, sizeof(old)) ||
 	    old =3D=3D new)
 		return 1;
=20
 	if (bpf_setsockopt(ctx, level, opt, &new, sizeof(new)))
 		return 1;
-	if (__bpf_getsockopt(ctx, sk, level, opt, &tmp, sizeof(tmp)) ||
+	if (bpf_getsockopt(ctx, level, opt, &tmp, sizeof(tmp)) ||
 	    tmp !=3D expected)
 		return 1;
=20
@@ -410,6 +312,34 @@ static int binddev_test(void *ctx)
 	return 0;
 }
=20
+static int test_tcp_maxseg(void *ctx, struct sock *sk)
+{
+	int val =3D 1314, tmp;
+
+	if (sk->sk_state !=3D TCP_ESTABLISHED)
+		return bpf_setsockopt(ctx, IPPROTO_TCP, TCP_MAXSEG,
+				      &val, sizeof(val));
+
+	if (bpf_getsockopt(ctx, IPPROTO_TCP, TCP_MAXSEG, &tmp, sizeof(tmp)) ||
+	    tmp > val)
+		return -1;
+
+	return 0;
+}
+
+static int test_tcp_saved_syn(void *ctx, struct sock *sk)
+{
+	__u8 saved_syn[20];
+	int one =3D 1;
+
+	if (sk->sk_state =3D=3D TCP_LISTEN)
+		return bpf_setsockopt(ctx, IPPROTO_TCP, TCP_SAVE_SYN,
+				      &one, sizeof(one));
+
+	return bpf_getsockopt(ctx, IPPROTO_TCP, TCP_SAVED_SYN,
+			      saved_syn, sizeof(saved_syn));
+}
+
 SEC("lsm_cgroup/socket_post_create")
 int BPF_PROG(socket_post_create, struct socket *sock, int family,
 	     int type, int protocol, int kern)
@@ -440,16 +370,22 @@ int skops_sockopt(struct bpf_sock_ops *skops)
=20
 	switch (skops->op) {
 	case BPF_SOCK_OPS_TCP_LISTEN_CB:
-		nr_listen +=3D !bpf_test_sockopt(skops, sk);
+		nr_listen +=3D !(bpf_test_sockopt(skops, sk) ||
+			       test_tcp_maxseg(skops, sk) ||
+			       test_tcp_saved_syn(skops, sk));
 		break;
 	case BPF_SOCK_OPS_TCP_CONNECT_CB:
-		nr_connect +=3D !bpf_test_sockopt(skops, sk);
+		nr_connect +=3D !(bpf_test_sockopt(skops, sk) ||
+				test_tcp_maxseg(skops, sk));
 		break;
 	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
-		nr_active +=3D !bpf_test_sockopt(skops, sk);
+		nr_active +=3D !(bpf_test_sockopt(skops, sk) ||
+			       test_tcp_maxseg(skops, sk));
 		break;
 	case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB:
-		nr_passive +=3D !bpf_test_sockopt(skops, sk);
+		nr_passive +=3D !(bpf_test_sockopt(skops, sk) ||
+				test_tcp_maxseg(skops, sk) ||
+				test_tcp_saved_syn(skops, sk));
 		break;
 	}
=20
--=20
2.30.2

