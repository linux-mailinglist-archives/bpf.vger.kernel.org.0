Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F425A0401
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 00:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiHXWaP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 18:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiHXWaM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 18:30:12 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BFB65E3
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:30:11 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27OMHADD017364
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:30:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ljvMWrzzLSqnmcx7WebdAv+iiWnbhFFu5LRs9tGJuko=;
 b=ihFjfhiqtCx2zEMjl8WQc+fQphXBMziU1SpFQAj/oRjgEnb8irbal7e6guey1OUXbZze
 kWifn7G4yBw5vEQxPFsd1O8Ebm/FOLIdsL6UyvSizeSx1FEvzQdvlP6aP2e/zpdo9I5f
 KBCumdPDLCSg6dXlaLxu/5haSKBjcyikvcE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3j4x1yvje9-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:30:10 -0700
Received: from twshared32421.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 15:30:09 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 57A33871CA14; Wed, 24 Aug 2022 15:27:30 -0700 (PDT)
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
Subject: [PATCH bpf-next 14/17] bpf: Change bpf_getsockopt(SOL_TCP) to reuse do_tcp_getsockopt()
Date:   Wed, 24 Aug 2022 15:27:30 -0700
Message-ID: <20220824222730.1923992-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220824222601.1916776-1-kafai@fb.com>
References: <20220824222601.1916776-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: svg4Ct1Dp-CQFlJf4aRZoS_TwSejxGs2
X-Proofpoint-ORIG-GUID: svg4Ct1Dp-CQFlJf4aRZoS_TwSejxGs2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_14,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch changes bpf_getsockopt(SOL_TCP) to reuse
do_tcp_getsockopt().  It removes the duplicated code from
bpf_getsockopt(SOL_TCP).

Before this patch, there were some optnames available to
bpf_setsockopt(SOL_TCP) but missing in bpf_getsockopt(SOL_TCP).
For example, TCP_NODELAY, TCP_MAXSEG, TCP_KEEPIDLE, TCP_KEEPINTVL,
and a few more.  It surprises users from time to time.  This patch
automatically closes this gap without duplicating more code.

bpf_getsockopt(TCP_SAVED_SYN) does not free the saved_syn,
so it stays in sol_tcp_sockopt().

For string name value like TCP_CONGESTION, bpf expects it
is always null terminated, so sol_tcp_sockopt() decrements
optlen by one before calling do_tcp_getsockopt() and
the 'if (optlen < saved_optlen) memset(..,0,..);'
in __bpf_getsockopt() will always do a null termination.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 include/net/tcp.h |  2 ++
 net/core/filter.c | 70 ++++++++++++++++++++++++++---------------------
 net/ipv4/tcp.c    |  4 +--
 3 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index c03a50c72f40..735e957f7f4b 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -402,6 +402,8 @@ void tcp_init_sock(struct sock *sk);
 void tcp_init_transfer(struct sock *sk, int bpf_op, struct sk_buff *skb)=
;
 __poll_t tcp_poll(struct file *file, struct socket *sock,
 		      struct poll_table_struct *wait);
+int do_tcp_getsockopt(struct sock *sk, int level,
+		      int optname, sockptr_t optval, sockptr_t optlen);
 int tcp_getsockopt(struct sock *sk, int level, int optname,
 		   char __user *optval, int __user *optlen);
 bool tcp_bpf_bypass_getsockopt(int level, int optname);
diff --git a/net/core/filter.c b/net/core/filter.c
index 68b52243b306..cdbbcec46e8b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5096,8 +5096,9 @@ static int bpf_sol_tcp_setsockopt(struct sock *sk, =
int optname,
 	return 0;
 }
=20
-static int sol_tcp_setsockopt(struct sock *sk, int optname,
-			      char *optval, int optlen)
+static int sol_tcp_sockopt(struct sock *sk, int optname,
+			   char *optval, int *optlen,
+			   bool getopt)
 {
 	if (sk->sk_prot->setsockopt !=3D tcp_setsockopt)
 		return -EINVAL;
@@ -5114,17 +5115,47 @@ static int sol_tcp_setsockopt(struct sock *sk, in=
t optname,
 	case TCP_USER_TIMEOUT:
 	case TCP_NOTSENT_LOWAT:
 	case TCP_SAVE_SYN:
-		if (optlen !=3D sizeof(int))
+		if (*optlen !=3D sizeof(int))
 			return -EINVAL;
 		break;
 	case TCP_CONGESTION:
+		if (*optlen < 2)
+			return -EINVAL;
+		break;
+	case TCP_SAVED_SYN:
+		if (*optlen < 1)
+			return -EINVAL;
 		break;
 	default:
-		return bpf_sol_tcp_setsockopt(sk, optname, optval, optlen);
+		if (getopt)
+			return -EINVAL;
+		return bpf_sol_tcp_setsockopt(sk, optname, optval, *optlen);
+	}
+
+	if (getopt) {
+		if (optname =3D=3D TCP_SAVED_SYN) {
+			struct tcp_sock *tp =3D tcp_sk(sk);
+
+			if (!tp->saved_syn ||
+			    *optlen > tcp_saved_syn_len(tp->saved_syn))
+				return -EINVAL;
+			memcpy(optval, tp->saved_syn->data, *optlen);
+			return 0;
+		}
+
+		if (optname =3D=3D TCP_CONGESTION) {
+			if (!inet_csk(sk)->icsk_ca_ops)
+				return -EINVAL;
+			(*optlen)--;
+		}
+
+		return do_tcp_getsockopt(sk, SOL_TCP, optname,
+					 KERNEL_SOCKPTR(optval),
+					 KERNEL_SOCKPTR(optlen));
 	}
=20
 	return do_tcp_setsockopt(sk, SOL_TCP, optname,
-				 KERNEL_SOCKPTR(optval), optlen);
+				 KERNEL_SOCKPTR(optval), *optlen);
 }
=20
 static int sol_ip_setsockopt(struct sock *sk, int optname,
@@ -5179,7 +5210,7 @@ static int __bpf_setsockopt(struct sock *sk, int le=
vel, int optname,
 	else if (IS_ENABLED(CONFIG_IPV6) && level =3D=3D SOL_IPV6)
 		return sol_ipv6_setsockopt(sk, optname, optval, optlen);
 	else if (IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_TCP)
-		return sol_tcp_setsockopt(sk, optname, optval, optlen);
+		return sol_tcp_sockopt(sk, optname, optval, &optlen, false);
=20
 	return -EINVAL;
 }
@@ -5202,31 +5233,8 @@ static int __bpf_getsockopt(struct sock *sk, int l=
evel, int optname,
=20
 	if (level =3D=3D SOL_SOCKET) {
 		err =3D sol_socket_sockopt(sk, optname, optval, &optlen, true);
-	} else if (IS_ENABLED(CONFIG_INET) &&
-		   level =3D=3D SOL_TCP && sk->sk_prot->getsockopt =3D=3D tcp_getsocko=
pt) {
-		struct inet_connection_sock *icsk;
-		struct tcp_sock *tp;
-
-		switch (optname) {
-		case TCP_CONGESTION:
-			icsk =3D inet_csk(sk);
-
-			if (!icsk->icsk_ca_ops || optlen <=3D 1)
-				goto err_clear;
-			strncpy(optval, icsk->icsk_ca_ops->name, optlen);
-			optval[optlen - 1] =3D 0;
-			break;
-		case TCP_SAVED_SYN:
-			tp =3D tcp_sk(sk);
-
-			if (optlen <=3D 0 || !tp->saved_syn ||
-			    optlen > tcp_saved_syn_len(tp->saved_syn))
-				goto err_clear;
-			memcpy(optval, tp->saved_syn->data, optlen);
-			break;
-		default:
-			goto err_clear;
-		}
+	} else if (IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_TCP) {
+		err =3D sol_tcp_sockopt(sk, optname, optval, &optlen, true);
 	} else if (IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_IP) {
 		struct inet_sock *inet =3D inet_sk(sk);
=20
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index ab8118225797..a47cb5662be6 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4043,8 +4043,8 @@ struct sk_buff *tcp_get_timestamping_opt_stats(cons=
t struct sock *sk,
 	return stats;
 }
=20
-static int do_tcp_getsockopt(struct sock *sk, int level,
-			     int optname, sockptr_t optval, sockptr_t optlen)
+int do_tcp_getsockopt(struct sock *sk, int level,
+		      int optname, sockptr_t optval, sockptr_t optlen)
 {
 	struct inet_connection_sock *icsk =3D inet_csk(sk);
 	struct tcp_sock *tp =3D tcp_sk(sk);
--=20
2.30.2

