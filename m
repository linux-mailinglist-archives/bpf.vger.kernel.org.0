Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58845969DB
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 08:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiHQGxF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 02:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiHQGxE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 02:53:04 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B1474E0D
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 23:53:04 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27H0J8tx007698
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 23:53:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=b9+a8J4nTZQThAx5/Ev65A2t+7Y1GdHEU2hKfWkpFnk=;
 b=AY9h0JGMST3I7nylTlD00dBCDpAV1LiTvQFTCo+cMW1NI0uCyTA0RqOQz2wNucEVVFve
 ZsgkC36D0F+6B/GQQaWdvwiP5L5mQEG8IbeDnspb7JYbtocZWi1VNftEMRgJKZMht7on
 Ti+L6FgxbFcYr4/sNgXDLCp9JOR0Viha67Q= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j0np59cad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 23:53:03 -0700
Received: from twshared14818.18.frc3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 16 Aug 2022 23:53:02 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id CBE07825DDCF; Tue, 16 Aug 2022 23:18:26 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 12/15] bpf: Change bpf_setsockopt(SOL_IP) to reuse do_ip_setsockopt()
Date:   Tue, 16 Aug 2022 23:18:26 -0700
Message-ID: <20220817061826.4180990-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220817061704.4174272-1-kafai@fb.com>
References: <20220817061704.4174272-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: l0sYvHiQ4Cxu00wMG4LREiGF48Kzov_v
X-Proofpoint-ORIG-GUID: l0sYvHiQ4Cxu00wMG4LREiGF48Kzov_v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_04,2022-08-16_02,2022-06-22_01
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

After the prep work in the previous patches,
this patch removes the dup code from bpf_setsockopt(SOL_IP)
and reuses the implementation in do_ip_setsockopt().

The existing optname white-list is refactored into a new
function sol_ip_setsockopt().

NOTE,
the current bpf_setsockopt(IP_TOS) is quite different from the
the do_ip_setsockopt(IP_TOS).  For example, it does not take
the INET_ECN_MASK into the account for tcp and also does not adjust
sk->sk_priority.  It looks like the current bpf_setsockopt(IP_TOS)
was referencing the IPV6_TCLASS implementation instead of IP_TOS.
This patch tries to rectify that by using the do_ip_setsockopt(IP_TOS).
While this is a behavior change,  the do_ip_setsockopt(IP_TOS) behavior
is arguably what the user is expecting.  At least, the INET_ECN_MASK bits
should be masked out for tcp.

Reviewed-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 include/net/ip.h       |  2 ++
 net/core/filter.c      | 40 ++++++++++++++++++++--------------------
 net/ipv4/ip_sockglue.c |  4 ++--
 3 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 1c979fd1904c..34fa5b0f0a0e 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -743,6 +743,8 @@ void ip_cmsg_recv_offset(struct msghdr *msg, struct s=
ock *sk,
 int ip_cmsg_send(struct sock *sk, struct msghdr *msg,
 		 struct ipcm_cookie *ipc, bool allow_ipv6);
 DECLARE_STATIC_KEY_FALSE(ip4_min_ttl);
+int do_ip_setsockopt(struct sock *sk, int level, int optname, sockptr_t =
optval,
+		     unsigned int optlen);
 int ip_setsockopt(struct sock *sk, int level, int optname, sockptr_t opt=
val,
 		  unsigned int optlen);
 int ip_getsockopt(struct sock *sk, int level, int optname, char __user *=
optval,
diff --git a/net/core/filter.c b/net/core/filter.c
index 66877605bb78..4d1b42b8f4a8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5114,6 +5114,25 @@ static int sol_tcp_setsockopt(struct sock *sk, int=
 optname,
 				 KERNEL_SOCKPTR(optval), optlen);
 }
=20
+static int sol_ip_setsockopt(struct sock *sk, int optname,
+			     char *optval, int optlen)
+{
+	if (sk->sk_family !=3D AF_INET)
+		return -EINVAL;
+
+	switch (optname) {
+	case IP_TOS:
+		if (optlen !=3D sizeof(int))
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return do_ip_setsockopt(sk, SOL_IP, optname,
+				KERNEL_SOCKPTR(optval), optlen);
+}
+
 static int __bpf_setsockopt(struct sock *sk, int level, int optname,
 			    char *optval, int optlen)
 {
@@ -5125,26 +5144,7 @@ static int __bpf_setsockopt(struct sock *sk, int l=
evel, int optname,
 	if (level =3D=3D SOL_SOCKET) {
 		return sol_socket_setsockopt(sk, optname, optval, optlen);
 	} else if (IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_IP) {
-		if (optlen !=3D sizeof(int) || sk->sk_family !=3D AF_INET)
-			return -EINVAL;
-
-		val =3D *((int *)optval);
-		/* Only some options are supported */
-		switch (optname) {
-		case IP_TOS:
-			if (val < -1 || val > 0xff) {
-				ret =3D -EINVAL;
-			} else {
-				struct inet_sock *inet =3D inet_sk(sk);
-
-				if (val =3D=3D -1)
-					val =3D 0;
-				inet->tos =3D val;
-			}
-			break;
-		default:
-			ret =3D -EINVAL;
-		}
+		return sol_ip_setsockopt(sk, optname, optval, optlen);
 	} else if (IS_ENABLED(CONFIG_IPV6) && level =3D=3D SOL_IPV6) {
 		if (optlen !=3D sizeof(int) || sk->sk_family !=3D AF_INET6)
 			return -EINVAL;
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index a3c496580e6b..751fa69cb557 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -888,8 +888,8 @@ static int compat_ip_mcast_join_leave(struct sock *sk=
, int optname,
=20
 DEFINE_STATIC_KEY_FALSE(ip4_min_ttl);
=20
-static int do_ip_setsockopt(struct sock *sk, int level, int optname,
-		sockptr_t optval, unsigned int optlen)
+int do_ip_setsockopt(struct sock *sk, int level, int optname,
+		     sockptr_t optval, unsigned int optlen)
 {
 	struct inet_sock *inet =3D inet_sk(sk);
 	struct net *net =3D sock_net(sk);
--=20
2.30.2

