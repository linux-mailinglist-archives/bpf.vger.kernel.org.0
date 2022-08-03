Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80057589383
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 22:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238758AbiHCUtc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 16:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238756AbiHCUtb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 16:49:31 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE715C969
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 13:49:28 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 273F77f9013301
        for <bpf@vger.kernel.org>; Wed, 3 Aug 2022 13:49:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=wFguDFVefju9nXZfLjygUUYSjTZJSDSTl+ch5Kym9+s=;
 b=YEOFe77St0zr+HC8zzssXOhGgd+wmdq1AfFa3Np4LZDERre5Uzh/egA92A2YCBRlPGeg
 aVcmUMEqCMKqJW/S/anCuELM5QvmVLMZKxqQRqERRsXg2yR8qdnWGe5mRxQfNqCqWJOd
 NSlHY67fIQGeyQnGywAkQEvl9YMyLErsugc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hq2bq3quq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 03 Aug 2022 13:49:28 -0700
Received: from twshared22413.18.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 13:49:27 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 67CDD7A3F7CE; Wed,  3 Aug 2022 13:46:58 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 09/15] bpf: Change bpf_setsockopt(SOL_SOCKET) to reuse sk_setsockopt()
Date:   Wed, 3 Aug 2022 13:46:58 -0700
Message-ID: <20220803204658.3080795-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220803204601.3075863-1-kafai@fb.com>
References: <20220803204601.3075863-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: FpsvTmG7B46h3-bKFqpp-ugBDGvJgdmf
X-Proofpoint-GUID: FpsvTmG7B46h3-bKFqpp-ugBDGvJgdmf
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
this patch removes most of the dup code from bpf_setsockopt(SOL_SOCKET)
and reuses them from sk_setsockopt().

The only exception is SO_RCVLOWAT.  The bpf_setsockopt() does
not always have the sock ptr (sk->sk_socket) and sock->ops->set_rcvlowat
is needed in sk_setsockopt.  tcp_set_rcvlowat is the only
implementation for set_rcvlowat.  bpf_setsockopt() needs
one special handling for SO_RCVLOWAT for tcp_sock, so leave
SO_RCVLOWAT in bpf_setsockopt() for now.

The existing optname white-list is refactored into a new
function sol_socket_setsockopt().

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 include/net/sock.h |   2 +
 net/core/filter.c  | 130 +++++++++++++--------------------------------
 net/core/sock.c    |   4 +-
 3 files changed, 42 insertions(+), 94 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 72b78c2b6f83..b7e159f9d7bf 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1800,6 +1800,8 @@ void sock_pfree(struct sk_buff *skb);
 #define sock_edemux sock_efree
 #endif
=20
+int sk_setsockopt(struct sock *sk, int level, int optname,
+		  sockptr_t optval, unsigned int optlen);
 int sock_setsockopt(struct socket *sock, int level, int op,
 		    sockptr_t optval, unsigned int optlen);
=20
diff --git a/net/core/filter.c b/net/core/filter.c
index 01cb4a01b1c1..d1f9f8360f60 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5013,106 +5013,52 @@ static const struct bpf_func_proto bpf_get_socke=
t_uid_proto =3D {
 	.arg1_type      =3D ARG_PTR_TO_CTX,
 };
=20
+static int sol_socket_setsockopt(struct sock *sk, int optname,
+				 char *optval, int optlen)
+{
+	switch (optname) {
+	case SO_SNDBUF:
+	case SO_RCVBUF:
+	case SO_KEEPALIVE:
+	case SO_PRIORITY:
+	case SO_REUSEPORT:
+	case SO_RCVLOWAT:
+	case SO_MARK:
+	case SO_MAX_PACING_RATE:
+	case SO_BINDTOIFINDEX:
+	case SO_TXREHASH:
+		if (optlen !=3D sizeof(int))
+			return -EINVAL;
+		break;
+	case SO_BINDTODEVICE:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (optname =3D=3D SO_RCVLOWAT) {
+		int val =3D *(int *)optval;
+
+		if (val < 0)
+			val =3D INT_MAX;
+		WRITE_ONCE(sk->sk_rcvlowat, val ? : 1);
+		return 0;
+	}
+
+	return sk_setsockopt(sk, SOL_SOCKET, optname,
+			     KERNEL_SOCKPTR(optval), optlen);
+}
+
 static int __bpf_setsockopt(struct sock *sk, int level, int optname,
 			    char *optval, int optlen)
 {
-	char devname[IFNAMSIZ];
-	int val, valbool;
-	struct net *net;
-	int ifindex;
-	int ret =3D 0;
+	int val, ret =3D 0;
=20
 	if (!sk_fullsock(sk))
 		return -EINVAL;
=20
 	if (level =3D=3D SOL_SOCKET) {
-		if (optlen !=3D sizeof(int) && optname !=3D SO_BINDTODEVICE)
-			return -EINVAL;
-		val =3D *((int *)optval);
-		valbool =3D val ? 1 : 0;
-
-		/* Only some socketops are supported */
-		switch (optname) {
-		case SO_RCVBUF:
-			val =3D min_t(u32, val, sysctl_rmem_max);
-			val =3D min_t(int, val, INT_MAX / 2);
-			sk->sk_userlocks |=3D SOCK_RCVBUF_LOCK;
-			WRITE_ONCE(sk->sk_rcvbuf,
-				   max_t(int, val * 2, SOCK_MIN_RCVBUF));
-			break;
-		case SO_SNDBUF:
-			val =3D min_t(u32, val, sysctl_wmem_max);
-			val =3D min_t(int, val, INT_MAX / 2);
-			sk->sk_userlocks |=3D SOCK_SNDBUF_LOCK;
-			WRITE_ONCE(sk->sk_sndbuf,
-				   max_t(int, val * 2, SOCK_MIN_SNDBUF));
-			break;
-		case SO_MAX_PACING_RATE: /* 32bit version */
-			if (val !=3D ~0U)
-				cmpxchg(&sk->sk_pacing_status,
-					SK_PACING_NONE,
-					SK_PACING_NEEDED);
-			sk->sk_max_pacing_rate =3D (val =3D=3D ~0U) ?
-						 ~0UL : (unsigned int)val;
-			sk->sk_pacing_rate =3D min(sk->sk_pacing_rate,
-						 sk->sk_max_pacing_rate);
-			break;
-		case SO_PRIORITY:
-			sk->sk_priority =3D val;
-			break;
-		case SO_RCVLOWAT:
-			if (val < 0)
-				val =3D INT_MAX;
-			WRITE_ONCE(sk->sk_rcvlowat, val ? : 1);
-			break;
-		case SO_MARK:
-			if (sk->sk_mark !=3D val) {
-				sk->sk_mark =3D val;
-				sk_dst_reset(sk);
-			}
-			break;
-		case SO_BINDTODEVICE:
-			optlen =3D min_t(long, optlen, IFNAMSIZ - 1);
-			strncpy(devname, optval, optlen);
-			devname[optlen] =3D 0;
-
-			ifindex =3D 0;
-			if (devname[0] !=3D '\0') {
-				struct net_device *dev;
-
-				ret =3D -ENODEV;
-
-				net =3D sock_net(sk);
-				dev =3D dev_get_by_name(net, devname);
-				if (!dev)
-					break;
-				ifindex =3D dev->ifindex;
-				dev_put(dev);
-			}
-			fallthrough;
-		case SO_BINDTOIFINDEX:
-			if (optname =3D=3D SO_BINDTOIFINDEX)
-				ifindex =3D val;
-			ret =3D sock_bindtoindex(sk, ifindex, false);
-			break;
-		case SO_KEEPALIVE:
-			if (sk->sk_prot->keepalive)
-				sk->sk_prot->keepalive(sk, valbool);
-			sock_valbool_flag(sk, SOCK_KEEPOPEN, valbool);
-			break;
-		case SO_REUSEPORT:
-			sk->sk_reuseport =3D valbool;
-			break;
-		case SO_TXREHASH:
-			if (val < -1 || val > 1) {
-				ret =3D -EINVAL;
-				break;
-			}
-			sk->sk_txrehash =3D (u8)val;
-			break;
-		default:
-			ret =3D -EINVAL;
-		}
+		return sol_socket_setsockopt(sk, optname, optval, optlen);
 	} else if (IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_IP) {
 		if (optlen !=3D sizeof(int) || sk->sk_family !=3D AF_INET)
 			return -EINVAL;
diff --git a/net/core/sock.c b/net/core/sock.c
index 2d88c06c27b7..1ea320e09794 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1073,8 +1073,8 @@ EXPORT_SYMBOL(sockopt_capable);
  *	at the socket level. Everything here is generic.
  */
=20
-static int sk_setsockopt(struct sock *sk, int level, int optname,
-			 sockptr_t optval, unsigned int optlen)
+int sk_setsockopt(struct sock *sk, int level, int optname,
+		  sockptr_t optval, unsigned int optlen)
 {
 	struct so_timestamping timestamping;
 	struct socket *sock =3D sk->sk_socket;
--=20
2.30.2

