Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0CA5A03FD
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 00:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiHXWaB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 18:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiHXWaA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 18:30:00 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0B11121
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:30:00 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OMHFxC000887
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:29:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=kkAQnBXEyU+LWOLUnCjyKgqsMydHl991e1cOqpr4Afk=;
 b=MWTvFbID8e3+QJAtjBQhr1MmHTnFLBnQyStg6Fy4IHq9DSKxaVNkOnH/WS2bAGBCUf6r
 Z+hGTJmdZ5dGP3s6X4kwDjGJL7ZjOV0sY/YmCa9ogD0fwlBI3ZLb49StjV/CHPqHARQu
 b/fmA3Oyweo2GAN8i46XSQXWlIY/Rvr+FD8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j5bejxn6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:29:59 -0700
Received: from twshared29104.24.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 15:29:58 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 0E575871C9DD; Wed, 24 Aug 2022 15:27:24 -0700 (PDT)
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
Subject: [PATCH bpf-next 13/17] bpf: Change bpf_getsockopt(SOL_SOCKET) to reuse sk_getsockopt()
Date:   Wed, 24 Aug 2022 15:27:24 -0700
Message-ID: <20220824222724.1923532-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220824222601.1916776-1-kafai@fb.com>
References: <20220824222601.1916776-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: AYb9ojFyX8l7DRLbZNEbsdXH98bGuJi2
X-Proofpoint-GUID: AYb9ojFyX8l7DRLbZNEbsdXH98bGuJi2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_13,2022-08-22_02,2022-06-22_01
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

This patch changes bpf_getsockopt(SOL_SOCKET) to reuse
sk_getsockopt().  It removes all duplicated code from
bpf_getsockopt(SOL_SOCKET).

Before this patch, there were some optnames available to
bpf_setsockopt(SOL_SOCKET) but missing in bpf_getsockopt(SOL_SOCKET).
It surprises users from time to time.  For example, SO_REUSEADDR,
SO_KEEPALIVE, SO_RCVLOWAT, and SO_MAX_PACING_RATE.  This patch
automatically closes this gap without duplicating more code.
The only exception is SO_BINDTODEVICE because it needs to acquire a
blocking lock.  Thus, SO_BINDTODEVICE is not supported.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 include/net/sock.h |  2 ++
 net/core/filter.c  | 57 +++++++++++++++++++---------------------------
 net/core/sock.c    |  4 ++--
 3 files changed, 27 insertions(+), 36 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index ee44b424d952..ea7965524133 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1833,6 +1833,8 @@ int sk_setsockopt(struct sock *sk, int level, int o=
ptname,
 int sock_setsockopt(struct socket *sock, int level, int op,
 		    sockptr_t optval, unsigned int optlen);
=20
+int sk_getsockopt(struct sock *sk, int level, int optname,
+		  sockptr_t optval, sockptr_t optlen);
 int sock_getsockopt(struct socket *sock, int level, int op,
 		    char __user *optval, int __user *optlen);
 int sock_gettstamp(struct socket *sock, void __user *userstamp,
diff --git a/net/core/filter.c b/net/core/filter.c
index 347c38da1e0c..68b52243b306 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5013,8 +5013,9 @@ static const struct bpf_func_proto bpf_get_socket_u=
id_proto =3D {
 	.arg1_type      =3D ARG_PTR_TO_CTX,
 };
=20
-static int sol_socket_setsockopt(struct sock *sk, int optname,
-				 char *optval, int optlen)
+static int sol_socket_sockopt(struct sock *sk, int optname,
+			      char *optval, int *optlen,
+			      bool getopt)
 {
 	switch (optname) {
 	case SO_REUSEADDR:
@@ -5028,7 +5029,7 @@ static int sol_socket_setsockopt(struct sock *sk, i=
nt optname,
 	case SO_MAX_PACING_RATE:
 	case SO_BINDTOIFINDEX:
 	case SO_TXREHASH:
-		if (optlen !=3D sizeof(int))
+		if (*optlen !=3D sizeof(int))
 			return -EINVAL;
 		break;
 	case SO_BINDTODEVICE:
@@ -5037,8 +5038,16 @@ static int sol_socket_setsockopt(struct sock *sk, =
int optname,
 		return -EINVAL;
 	}
=20
+	if (getopt) {
+		if (optname =3D=3D SO_BINDTODEVICE)
+			return -EINVAL;
+		return sk_getsockopt(sk, SOL_SOCKET, optname,
+				     KERNEL_SOCKPTR(optval),
+				     KERNEL_SOCKPTR(optlen));
+	}
+
 	return sk_setsockopt(sk, SOL_SOCKET, optname,
-			     KERNEL_SOCKPTR(optval), optlen);
+			     KERNEL_SOCKPTR(optval), *optlen);
 }
=20
 static int bpf_sol_tcp_setsockopt(struct sock *sk, int optname,
@@ -5164,7 +5173,7 @@ static int __bpf_setsockopt(struct sock *sk, int le=
vel, int optname,
 		return -EINVAL;
=20
 	if (level =3D=3D SOL_SOCKET)
-		return sol_socket_setsockopt(sk, optname, optval, optlen);
+		return sol_socket_sockopt(sk, optname, optval, &optlen, false);
 	else if (IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_IP)
 		return sol_ip_setsockopt(sk, optname, optval, optlen);
 	else if (IS_ENABLED(CONFIG_IPV6) && level =3D=3D SOL_IPV6)
@@ -5186,38 +5195,13 @@ static int _bpf_setsockopt(struct sock *sk, int l=
evel, int optname,
 static int __bpf_getsockopt(struct sock *sk, int level, int optname,
 			    char *optval, int optlen)
 {
+	int err =3D 0, saved_optlen =3D optlen;
+
 	if (!sk_fullsock(sk))
 		goto err_clear;
=20
 	if (level =3D=3D SOL_SOCKET) {
-		if (optlen !=3D sizeof(int))
-			goto err_clear;
-
-		switch (optname) {
-		case SO_RCVBUF:
-			*((int *)optval) =3D sk->sk_rcvbuf;
-			break;
-		case SO_SNDBUF:
-			*((int *)optval) =3D sk->sk_sndbuf;
-			break;
-		case SO_MARK:
-			*((int *)optval) =3D sk->sk_mark;
-			break;
-		case SO_PRIORITY:
-			*((int *)optval) =3D sk->sk_priority;
-			break;
-		case SO_BINDTOIFINDEX:
-			*((int *)optval) =3D sk->sk_bound_dev_if;
-			break;
-		case SO_REUSEPORT:
-			*((int *)optval) =3D sk->sk_reuseport;
-			break;
-		case SO_TXREHASH:
-			*((int *)optval) =3D sk->sk_txrehash;
-			break;
-		default:
-			goto err_clear;
-		}
+		err =3D sol_socket_sockopt(sk, optname, optval, &optlen, true);
 	} else if (IS_ENABLED(CONFIG_INET) &&
 		   level =3D=3D SOL_TCP && sk->sk_prot->getsockopt =3D=3D tcp_getsocko=
pt) {
 		struct inet_connection_sock *icsk;
@@ -5274,7 +5258,12 @@ static int __bpf_getsockopt(struct sock *sk, int l=
evel, int optname,
 	} else {
 		goto err_clear;
 	}
-	return 0;
+
+	if (err)
+		optlen =3D 0;
+	if (optlen < saved_optlen)
+		memset(optval + optlen, 0, saved_optlen - optlen);
+	return err;
 err_clear:
 	memset(optval, 0, optlen);
 	return -EINVAL;
diff --git a/net/core/sock.c b/net/core/sock.c
index 7fa30fd4b37f..68e4662eb2eb 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1583,8 +1583,8 @@ static int groups_to_user(sockptr_t dst, const stru=
ct group_info *src)
 	return 0;
 }
=20
-static int sk_getsockopt(struct sock *sk, int level, int optname,
-			 sockptr_t optval, sockptr_t optlen)
+int sk_getsockopt(struct sock *sk, int level, int optname,
+		  sockptr_t optval, sockptr_t optlen)
 {
 	struct socket *sock =3D sk->sk_socket;
=20
--=20
2.30.2

