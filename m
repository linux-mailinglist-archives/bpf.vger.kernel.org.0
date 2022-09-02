Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467CC5AA473
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 02:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbiIBAcD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 20:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbiIBAcA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 20:32:00 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F309F18A
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 17:31:58 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28208uZT017761
        for <bpf@vger.kernel.org>; Thu, 1 Sep 2022 17:31:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=p+C0AWSPOc3+Lv4v1G2abkcpzDycozJ7ULfH/fWjG38=;
 b=Yq5YTU3N7XYnmzr73MJteCzuAbFq0w7XRswtEz4VFVorIHgZ1zlYtOWHlhW2nx7Ae1tD
 p/lblaVOjkObvIwHrSfBZQmgdGmVqwqUHY1wz/5QnqXrOIstlSLfvB7+fjlRJOXn7zAj
 I6zINqTx3Q4h2BBcDJkKaCLESu3+ZDRJQjo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jaab33243-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 01 Sep 2022 17:31:57 -0700
Received: from twshared30313.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 17:31:56 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 50BB98C47C77; Thu,  1 Sep 2022 17:29:25 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 15/17] bpf: Change bpf_getsockopt(SOL_IP) to reuse do_ip_getsockopt()
Date:   Thu, 1 Sep 2022 17:29:25 -0700
Message-ID: <20220902002925.2895416-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220902002750.2887415-1-kafai@fb.com>
References: <20220902002750.2887415-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: WSYDMvv1dscE6BolrXZcVoXpgByrYZIP
X-Proofpoint-ORIG-GUID: WSYDMvv1dscE6BolrXZcVoXpgByrYZIP
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

This patch changes bpf_getsockopt(SOL_IP) to reuse
do_ip_getsockopt() and remove the duplicated code.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/net/ip.h       |  2 ++
 net/core/filter.c      | 30 ++++++++++++------------------
 net/ipv4/ip_sockglue.c |  4 ++--
 3 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 34fa5b0f0a0e..038097c2a152 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -747,6 +747,8 @@ int do_ip_setsockopt(struct sock *sk, int level, int =
optname, sockptr_t optval,
 		     unsigned int optlen);
 int ip_setsockopt(struct sock *sk, int level, int optname, sockptr_t opt=
val,
 		  unsigned int optlen);
+int do_ip_getsockopt(struct sock *sk, int level, int optname,
+		     sockptr_t optval, sockptr_t optlen);
 int ip_getsockopt(struct sock *sk, int level, int optname, char __user *=
optval,
 		  int __user *optlen);
 int ip_ra_control(struct sock *sk, unsigned char on,
diff --git a/net/core/filter.c b/net/core/filter.c
index e427f40f0cee..a9d88fd0541e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5162,23 +5162,29 @@ static int sol_tcp_sockopt(struct sock *sk, int o=
ptname,
 				 KERNEL_SOCKPTR(optval), *optlen);
 }
=20
-static int sol_ip_setsockopt(struct sock *sk, int optname,
-			     char *optval, int optlen)
+static int sol_ip_sockopt(struct sock *sk, int optname,
+			  char *optval, int *optlen,
+			  bool getopt)
 {
 	if (sk->sk_family !=3D AF_INET)
 		return -EINVAL;
=20
 	switch (optname) {
 	case IP_TOS:
-		if (optlen !=3D sizeof(int))
+		if (*optlen !=3D sizeof(int))
 			return -EINVAL;
 		break;
 	default:
 		return -EINVAL;
 	}
=20
+	if (getopt)
+		return do_ip_getsockopt(sk, SOL_IP, optname,
+					KERNEL_SOCKPTR(optval),
+					KERNEL_SOCKPTR(optlen));
+
 	return do_ip_setsockopt(sk, SOL_IP, optname,
-				KERNEL_SOCKPTR(optval), optlen);
+				KERNEL_SOCKPTR(optval), *optlen);
 }
=20
 static int sol_ipv6_setsockopt(struct sock *sk, int optname,
@@ -5210,7 +5216,7 @@ static int __bpf_setsockopt(struct sock *sk, int le=
vel, int optname,
 	if (level =3D=3D SOL_SOCKET)
 		return sol_socket_sockopt(sk, optname, optval, &optlen, false);
 	else if (IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_IP)
-		return sol_ip_setsockopt(sk, optname, optval, optlen);
+		return sol_ip_sockopt(sk, optname, optval, &optlen, false);
 	else if (IS_ENABLED(CONFIG_IPV6) && level =3D=3D SOL_IPV6)
 		return sol_ipv6_setsockopt(sk, optname, optval, optlen);
 	else if (IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_TCP)
@@ -5240,19 +5246,7 @@ static int __bpf_getsockopt(struct sock *sk, int l=
evel, int optname,
 	} else if (IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_TCP) {
 		err =3D sol_tcp_sockopt(sk, optname, optval, &optlen, true);
 	} else if (IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_IP) {
-		struct inet_sock *inet =3D inet_sk(sk);
-
-		if (optlen !=3D sizeof(int) || sk->sk_family !=3D AF_INET)
-			goto err_clear;
-
-		/* Only some options are supported */
-		switch (optname) {
-		case IP_TOS:
-			*((int *)optval) =3D (int)inet->tos;
-			break;
-		default:
-			goto err_clear;
-		}
+		err =3D sol_ip_sockopt(sk, optname, optval, &optlen, true);
 	} else if (IS_ENABLED(CONFIG_IPV6) && level =3D=3D SOL_IPV6) {
 		struct ipv6_pinfo *np =3D inet6_sk(sk);
=20
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 5d134a75cad0..47830f3fea1b 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1524,8 +1524,8 @@ static int compat_ip_get_mcast_msfilter(struct sock=
 *sk, sockptr_t optval,
 	return 0;
 }
=20
-static int do_ip_getsockopt(struct sock *sk, int level, int optname,
-			    sockptr_t optval, sockptr_t optlen)
+int do_ip_getsockopt(struct sock *sk, int level, int optname,
+		     sockptr_t optval, sockptr_t optlen)
 {
 	struct inet_sock *inet =3D inet_sk(sk);
 	bool needs_rtnl =3D getsockopt_needs_rtnl(optname);
--=20
2.30.2

