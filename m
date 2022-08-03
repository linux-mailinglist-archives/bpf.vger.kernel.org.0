Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7BE589391
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 22:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238780AbiHCUuk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 16:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238808AbiHCUug (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 16:50:36 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F9525E2
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 13:50:16 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 273EqWrC018001
        for <bpf@vger.kernel.org>; Wed, 3 Aug 2022 13:50:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=u/ykZrX+A34eoUkuoWSKF5glpuZhxUXsUdm7O7yHv2g=;
 b=NaMaDkxyxLlh0n+Z6iU4MWSMrpmTHasEmsrxzSmMdZYmeI5zkCGk601aop1l50IOey9f
 2Y6gbDE0f7xSaeJ0xQh2J8fOtWKBHe1Y/77naNW4rikMVihXzeOrwVWon8/HTD23WORq
 /eVKaQIceCJQuZLE1AF06A4dg/Mm6GbYHlQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hq4b7u56u-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 03 Aug 2022 13:50:15 -0700
Received: from twshared30313.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 13:50:14 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 042757A3F811; Wed,  3 Aug 2022 13:47:10 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, <kernel-team@fb.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH v2 bpf-next 11/15] bpf: Change bpf_setsockopt(SOL_TCP) to reuse do_tcp_setsockopt()
Date:   Wed, 3 Aug 2022 13:47:10 -0700
Message-ID: <20220803204710.3081262-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220803204601.3075863-1-kafai@fb.com>
References: <20220803204601.3075863-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: wrye9iqlmj90WVrsPvRquqefDzOGIiIF
X-Proofpoint-GUID: wrye9iqlmj90WVrsPvRquqefDzOGIiIF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_06,2022-08-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After the prep work in the previous patches,
this patch removes all the dup code from bpf_setsockopt(SOL_TCP)
and reuses the do_tcp_setsockopt().

The existing optname white-list is refactored into a new
function sol_tcp_setsockopt().  The sol_tcp_setsockopt()
also calls the bpf_sol_tcp_setsockopt() to handle
the TCP_BPF_XXX specific optnames.

bpf_setsockopt(TCP_SAVE_SYN) now also allows a value 2 to
save the eth header also and it comes for free from
do_tcp_setsockopt().

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 include/net/tcp.h |  2 +
 net/core/filter.c | 97 +++++++++++++++--------------------------------
 net/ipv4/tcp.c    |  4 +-
 3 files changed, 34 insertions(+), 69 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index d10962b9f0d0..c03a50c72f40 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -405,6 +405,8 @@ __poll_t tcp_poll(struct file *file, struct socket *s=
ock,
 int tcp_getsockopt(struct sock *sk, int level, int optname,
 		   char __user *optval, int __user *optlen);
 bool tcp_bpf_bypass_getsockopt(int level, int optname);
+int do_tcp_setsockopt(struct sock *sk, int level, int optname,
+		      sockptr_t optval, unsigned int optlen);
 int tcp_setsockopt(struct sock *sk, int level, int optname, sockptr_t op=
tval,
 		   unsigned int optlen);
 void tcp_set_keepalive(struct sock *sk, int val);
diff --git a/net/core/filter.c b/net/core/filter.c
index 200e79a1fbfd..0c5361b8906d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5095,6 +5095,34 @@ static int bpf_sol_tcp_setsockopt(struct sock *sk,=
 int optname,
 	return 0;
 }
=20
+static int sol_tcp_setsockopt(struct sock *sk, int optname,
+			      char *optval, int optlen)
+{
+	if (sk->sk_prot->setsockopt !=3D tcp_setsockopt)
+		return -EINVAL;
+
+	switch (optname) {
+	case TCP_KEEPIDLE:
+	case TCP_KEEPINTVL:
+	case TCP_KEEPCNT:
+	case TCP_SYNCNT:
+	case TCP_WINDOW_CLAMP:
+	case TCP_USER_TIMEOUT:
+	case TCP_NOTSENT_LOWAT:
+	case TCP_SAVE_SYN:
+		if (optlen !=3D sizeof(int))
+			return -EINVAL;
+		break;
+	case TCP_CONGESTION:
+		break;
+	default:
+		return bpf_sol_tcp_setsockopt(sk, optname, optval, optlen);
+	}
+
+	return do_tcp_setsockopt(sk, SOL_TCP, optname,
+				 KERNEL_SOCKPTR(optval), optlen);
+}
+
 static int __bpf_setsockopt(struct sock *sk, int level, int optname,
 			    char *optval, int optlen)
 {
@@ -5147,73 +5175,8 @@ static int __bpf_setsockopt(struct sock *sk, int l=
evel, int optname,
 		default:
 			ret =3D -EINVAL;
 		}
-	} else if (IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_TCP &&
-		   sk->sk_prot->setsockopt =3D=3D tcp_setsockopt) {
-		if (optname >=3D TCP_BPF_IW)
-			return bpf_sol_tcp_setsockopt(sk, optname,
-						      optval, optlen);
-
-		if (optname =3D=3D TCP_CONGESTION) {
-			char name[TCP_CA_NAME_MAX];
-
-			strncpy(name, optval, min_t(long, optlen,
-						    TCP_CA_NAME_MAX-1));
-			name[TCP_CA_NAME_MAX-1] =3D 0;
-			ret =3D tcp_set_congestion_control(sk, name, false, true);
-		} else {
-			struct inet_connection_sock *icsk =3D inet_csk(sk);
-			struct tcp_sock *tp =3D tcp_sk(sk);
-
-			if (optlen !=3D sizeof(int))
-				return -EINVAL;
-
-			val =3D *((int *)optval);
-			/* Only some options are supported */
-			switch (optname) {
-			case TCP_SAVE_SYN:
-				if (val < 0 || val > 1)
-					ret =3D -EINVAL;
-				else
-					tp->save_syn =3D val;
-				break;
-			case TCP_KEEPIDLE:
-				ret =3D tcp_sock_set_keepidle_locked(sk, val);
-				break;
-			case TCP_KEEPINTVL:
-				if (val < 1 || val > MAX_TCP_KEEPINTVL)
-					ret =3D -EINVAL;
-				else
-					tp->keepalive_intvl =3D val * HZ;
-				break;
-			case TCP_KEEPCNT:
-				if (val < 1 || val > MAX_TCP_KEEPCNT)
-					ret =3D -EINVAL;
-				else
-					tp->keepalive_probes =3D val;
-				break;
-			case TCP_SYNCNT:
-				if (val < 1 || val > MAX_TCP_SYNCNT)
-					ret =3D -EINVAL;
-				else
-					icsk->icsk_syn_retries =3D val;
-				break;
-			case TCP_USER_TIMEOUT:
-				if (val < 0)
-					ret =3D -EINVAL;
-				else
-					icsk->icsk_user_timeout =3D val;
-				break;
-			case TCP_NOTSENT_LOWAT:
-				tp->notsent_lowat =3D val;
-				sk->sk_write_space(sk);
-				break;
-			case TCP_WINDOW_CLAMP:
-				ret =3D tcp_set_window_clamp(sk, val);
-				break;
-			default:
-				ret =3D -EINVAL;
-			}
-		}
+	} else if (IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_TCP) {
+		return sol_tcp_setsockopt(sk, optname, optval, optlen);
 	} else {
 		ret =3D -EINVAL;
 	}
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index cfed84b1883f..a6986f201f92 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3479,8 +3479,8 @@ int tcp_set_window_clamp(struct sock *sk, int val)
 /*
  *	Socket option code for TCP.
  */
-static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
-		sockptr_t optval, unsigned int optlen)
+int do_tcp_setsockopt(struct sock *sk, int level, int optname,
+		      sockptr_t optval, unsigned int optlen)
 {
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	struct inet_connection_sock *icsk =3D inet_csk(sk);
--=20
2.30.2

