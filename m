Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18635A03FE
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 00:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiHXWaD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 18:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiHXWaC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 18:30:02 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313CF1118
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:30:01 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OMH8g7015292
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:30:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=MOiyv+Yj+VxWzgzN87uZnLNi5soXOxwamfj8C0/tG2k=;
 b=O21punF3cIjiZHf1PijnOdvURq/dsGQyXjolqSNsq2uSWYA2ufL9OacWahMLcgr57tAb
 1yeCJcOGiHzjO0Hi5GhXwYqTgcnrw7VoUJ6E95wZBz771TVxx5pkFmR9iXSCWzoExuEY
 +dWkEqDZWY12xAM13Q8i1QRC7c3SDPWdZbo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j5u570px2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:30:00 -0700
Received: from twshared20276.35.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 15:29:57 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id EC394871CA63; Wed, 24 Aug 2022 15:27:42 -0700 (PDT)
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
Subject: [PATCH bpf-next 16/17] bpf: Change bpf_getsockopt(SOL_IPV6) to reuse do_ipv6_getsockopt()
Date:   Wed, 24 Aug 2022 15:27:42 -0700
Message-ID: <20220824222742.1924860-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220824222601.1916776-1-kafai@fb.com>
References: <20220824222601.1916776-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 1icBgarWEpzFZJcvJ2DxrBlvuQqQqgEc
X-Proofpoint-ORIG-GUID: 1icBgarWEpzFZJcvJ2DxrBlvuQqQqgEc
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

This patch changes bpf_getsockopt(SOL_IPV6) to reuse
do_ipv6_getsockopt().  It removes the duplicated code from
bpf_getsockopt(SOL_IPV6).

This also makes bpf_getsockopt(SOL_IPV6) supporting the same
set of optnames as in bpf_setsockopt(SOL_IPV6).  In particular,
this adds IPV6_AUTOFLOWLABEL support to bpf_getsockopt(SOL_IPV6).

ipv6 could be compiled as a module.  Like how other code solved it
with stubs in ipv6_stubs.h, this patch adds the do_ipv6_getsockopt
to the ipv6_bpf_stub.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 include/net/ipv6.h       |  2 ++
 include/net/ipv6_stubs.h |  2 ++
 net/core/filter.c        | 55 ++++++++++++++++++----------------------
 net/ipv6/af_inet6.c      |  1 +
 net/ipv6/ipv6_sockglue.c |  4 +--
 5 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index a4f24573ed7a..d664ba5812d8 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1160,6 +1160,8 @@ int do_ipv6_setsockopt(struct sock *sk, int level, =
int optname, sockptr_t optval
 		       unsigned int optlen);
 int ipv6_setsockopt(struct sock *sk, int level, int optname, sockptr_t o=
ptval,
 		    unsigned int optlen);
+int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
+		       sockptr_t optval, sockptr_t optlen);
 int ipv6_getsockopt(struct sock *sk, int level, int optname,
 		    char __user *optval, int __user *optlen);
=20
diff --git a/include/net/ipv6_stubs.h b/include/net/ipv6_stubs.h
index 8692698b01cf..c48186bf4737 100644
--- a/include/net/ipv6_stubs.h
+++ b/include/net/ipv6_stubs.h
@@ -83,6 +83,8 @@ struct ipv6_bpf_stub {
 				     struct sk_buff *skb);
 	int (*ipv6_setsockopt)(struct sock *sk, int level, int optname,
 			       sockptr_t optval, unsigned int optlen);
+	int (*ipv6_getsockopt)(struct sock *sk, int level, int optname,
+			       sockptr_t optval, sockptr_t optlen);
 };
 extern const struct ipv6_bpf_stub *ipv6_bpf_stub __read_mostly;
=20
diff --git a/net/core/filter.c b/net/core/filter.c
index 266948960b49..2a4b241387b7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5183,8 +5183,9 @@ static int sol_ip_sockopt(struct sock *sk, int optn=
ame,
 				KERNEL_SOCKPTR(optval), *optlen);
 }
=20
-static int sol_ipv6_setsockopt(struct sock *sk, int optname,
-			       char *optval, int optlen)
+static int sol_ipv6_sockopt(struct sock *sk, int optname,
+			    char *optval, int *optlen,
+			    bool getopt)
 {
 	if (sk->sk_family !=3D AF_INET6)
 		return -EINVAL;
@@ -5192,15 +5193,20 @@ static int sol_ipv6_setsockopt(struct sock *sk, i=
nt optname,
 	switch (optname) {
 	case IPV6_TCLASS:
 	case IPV6_AUTOFLOWLABEL:
-		if (optlen !=3D sizeof(int))
+		if (*optlen !=3D sizeof(int))
 			return -EINVAL;
 		break;
 	default:
 		return -EINVAL;
 	}
=20
+	if (getopt)
+		return ipv6_bpf_stub->ipv6_getsockopt(sk, SOL_IPV6, optname,
+						      KERNEL_SOCKPTR(optval),
+						      KERNEL_SOCKPTR(optlen));
+
 	return ipv6_bpf_stub->ipv6_setsockopt(sk, SOL_IPV6, optname,
-					      KERNEL_SOCKPTR(optval), optlen);
+					      KERNEL_SOCKPTR(optval), *optlen);
 }
=20
 static int __bpf_setsockopt(struct sock *sk, int level, int optname,
@@ -5214,7 +5220,7 @@ static int __bpf_setsockopt(struct sock *sk, int le=
vel, int optname,
 	else if (IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_IP)
 		return sol_ip_sockopt(sk, optname, optval, &optlen, false);
 	else if (IS_ENABLED(CONFIG_IPV6) && level =3D=3D SOL_IPV6)
-		return sol_ipv6_setsockopt(sk, optname, optval, optlen);
+		return sol_ipv6_sockopt(sk, optname, optval, &optlen, false);
 	else if (IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_TCP)
 		return sol_tcp_sockopt(sk, optname, optval, &optlen, false);
=20
@@ -5232,43 +5238,30 @@ static int _bpf_setsockopt(struct sock *sk, int l=
evel, int optname,
 static int __bpf_getsockopt(struct sock *sk, int level, int optname,
 			    char *optval, int optlen)
 {
-	int err =3D 0, saved_optlen =3D optlen;
+	int err, saved_optlen =3D optlen;
=20
-	if (!sk_fullsock(sk))
-		goto err_clear;
+	if (!sk_fullsock(sk)) {
+		err =3D -EINVAL;
+		goto done;
+	}
=20
-	if (level =3D=3D SOL_SOCKET) {
+	if (level =3D=3D SOL_SOCKET)
 		err =3D sol_socket_sockopt(sk, optname, optval, &optlen, true);
-	} else if (IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_TCP) {
+	else if (IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_TCP)
 		err =3D sol_tcp_sockopt(sk, optname, optval, &optlen, true);
-	} else if (IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_IP) {
+	else if (IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_IP)
 		err =3D sol_ip_sockopt(sk, optname, optval, &optlen, true);
-	} else if (IS_ENABLED(CONFIG_IPV6) && level =3D=3D SOL_IPV6) {
-		struct ipv6_pinfo *np =3D inet6_sk(sk);
-
-		if (optlen !=3D sizeof(int) || sk->sk_family !=3D AF_INET6)
-			goto err_clear;
-
-		/* Only some options are supported */
-		switch (optname) {
-		case IPV6_TCLASS:
-			*((int *)optval) =3D (int)np->tclass;
-			break;
-		default:
-			goto err_clear;
-		}
-	} else {
-		goto err_clear;
-	}
+	else if (IS_ENABLED(CONFIG_IPV6) && level =3D=3D SOL_IPV6)
+		err =3D sol_ipv6_sockopt(sk, optname, optval, &optlen, true);
+	else
+		err =3D -EINVAL;
=20
+done:
 	if (err)
 		optlen =3D 0;
 	if (optlen < saved_optlen)
 		memset(optval + optlen, 0, saved_optlen - optlen);
 	return err;
-err_clear:
-	memset(optval, 0, optlen);
-	return -EINVAL;
 }
=20
 static int _bpf_getsockopt(struct sock *sk, int level, int optname,
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index cadc97852787..19732b5dce23 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -1058,6 +1058,7 @@ static const struct ipv6_bpf_stub ipv6_bpf_stub_imp=
l =3D {
 	.inet6_bind =3D __inet6_bind,
 	.udp6_lib_lookup =3D __udp6_lib_lookup,
 	.ipv6_setsockopt =3D do_ipv6_setsockopt,
+	.ipv6_getsockopt =3D do_ipv6_getsockopt,
 };
=20
 static int __init inet6_init(void)
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index d9887e3a6077..1193f5a5247d 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -1131,8 +1131,8 @@ static int compat_ipv6_get_msfilter(struct sock *sk=
, sockptr_t optval,
 	return 0;
 }
=20
-static int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
-			      sockptr_t optval, sockptr_t optlen)
+int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
+		       sockptr_t optval, sockptr_t optlen)
 {
 	struct ipv6_pinfo *np =3D inet6_sk(sk);
 	int len;
--=20
2.30.2

