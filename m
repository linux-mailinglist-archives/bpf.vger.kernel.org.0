Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66055A03FC
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 00:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiHXWaB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 18:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiHXW37 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 18:29:59 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67CD1124
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:29:57 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OMHFuO016147
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:29:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=rDOpcJXy3F4kYKJ7FXMiswdtqoc1X1OO686nd1hbtF4=;
 b=BC5EA3c/033T3cnrfT/wsqk9fI+vo5ps9AZf+tmG1X3so1ftyfd60YO2uZ5eoSxWmPLV
 Dlttx29fDRDZf/pXxmQqfn8s9tt1x5QR0KoEUxIrhO46i7teIA6zquwnpjSoQovL0UkS
 GFbpcOfUK4uOKSfsonibeESivUUKYbM2hY8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j5ab0q1kr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:29:56 -0700
Received: from twshared14818.18.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 15:29:55 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id A0DDA871CA25; Wed, 24 Aug 2022 15:27:36 -0700 (PDT)
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
Subject: [PATCH bpf-next 15/17] bpf: Change bpf_getsockopt(SOL_IP) to reuse do_ip_getsockopt()
Date:   Wed, 24 Aug 2022 15:27:36 -0700
Message-ID: <20220824222736.1924405-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220824222601.1916776-1-kafai@fb.com>
References: <20220824222601.1916776-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: w7jHwu4AUDGIWbQCNJ6zbkHghxJI1oDP
X-Proofpoint-GUID: w7jHwu4AUDGIWbQCNJ6zbkHghxJI1oDP
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

This patch changes bpf_getsockopt(SOL_IP) to reuse
do_ip_getsockopt() and remove the duplicated code.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
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
index cdbbcec46e8b..266948960b49 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5158,23 +5158,29 @@ static int sol_tcp_sockopt(struct sock *sk, int o=
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
@@ -5206,7 +5212,7 @@ static int __bpf_setsockopt(struct sock *sk, int le=
vel, int optname,
 	if (level =3D=3D SOL_SOCKET)
 		return sol_socket_sockopt(sk, optname, optval, &optlen, false);
 	else if (IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_IP)
-		return sol_ip_setsockopt(sk, optname, optval, optlen);
+		return sol_ip_sockopt(sk, optname, optval, &optlen, false);
 	else if (IS_ENABLED(CONFIG_IPV6) && level =3D=3D SOL_IPV6)
 		return sol_ipv6_setsockopt(sk, optname, optval, optlen);
 	else if (IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_TCP)
@@ -5236,19 +5242,7 @@ static int __bpf_getsockopt(struct sock *sk, int l=
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

