Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1625969CA
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 08:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiHQGrG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 02:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbiHQGrF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 02:47:05 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C71A5EDC5
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 23:47:04 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27H0QReA017858
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 23:47:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=APAhwg9LK0IYA3HatFKwc1KnwMhuer+fjtfMjTlcRqg=;
 b=mBgvGHiFDNBQJzdHhXkCsQtW0+RXXKm0uCpG8zPp/fnr4Jdg6Jj9uL1mKM93K/MG70nZ
 OwiQpWrUVnNS8SOZcPa5JFKYBTyU2nLzMwutAHLSer99hM5nrZ2OxLI8ODxQmW/mh7vl
 HhXTxZAdHzFJ4nJZUFy6YwcECRc+IKvRRVg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j0nsjh9g0-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 23:47:04 -0700
Received: from twshared16418.24.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 16 Aug 2022 23:47:02 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 82059825DC2C; Tue, 16 Aug 2022 23:17:23 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 03/15] bpf: net: Consider has_current_bpf_ctx() when testing capable() in sk_setsockopt()
Date:   Tue, 16 Aug 2022 23:17:23 -0700
Message-ID: <20220817061723.4175820-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220817061704.4174272-1-kafai@fb.com>
References: <20220817061704.4174272-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: nmxWF2iNDm04pmMPNVt05Djgzjm9z5QQ
X-Proofpoint-ORIG-GUID: nmxWF2iNDm04pmMPNVt05Djgzjm9z5QQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_04,2022-08-16_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When bpf program calling bpf_setsockopt(SOL_SOCKET),
it could be run in softirq and doesn't make sense to do the capable
check.  There was a similar situation in bpf_setsockopt(TCP_CONGESTION).
In commit 8d650cdedaab ("tcp: fix tcp_set_congestion_control() use from b=
pf hook"),
tcp_set_congestion_control(..., cap_net_admin) was added to skip
the cap check for bpf prog.

This patch adds sockopt_ns_capable() and sockopt_capable() for
the sk_setsockopt() to use.  They will consider the
has_current_bpf_ctx() before doing the ns_capable() and capable() test.
They are in EXPORT_SYMBOL for the ipv6 module to use in a latter patch.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Reviewed-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 include/net/sock.h |  2 ++
 net/core/sock.c    | 38 +++++++++++++++++++++++++-------------
 2 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index b2ff230860c6..72b78c2b6f83 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1723,6 +1723,8 @@ static inline void unlock_sock_fast(struct sock *sk=
, bool slow)
=20
 void sockopt_lock_sock(struct sock *sk);
 void sockopt_release_sock(struct sock *sk);
+bool sockopt_ns_capable(struct user_namespace *ns, int cap);
+bool sockopt_capable(int cap);
=20
 /* Used by processes to "lock" a socket state, so that
  * interrupts and bottom half handlers won't change it
diff --git a/net/core/sock.c b/net/core/sock.c
index d3683228376f..7ea46e4700fd 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1060,6 +1060,18 @@ void sockopt_release_sock(struct sock *sk)
 }
 EXPORT_SYMBOL(sockopt_release_sock);
=20
+bool sockopt_ns_capable(struct user_namespace *ns, int cap)
+{
+	return has_current_bpf_ctx() || ns_capable(ns, cap);
+}
+EXPORT_SYMBOL(sockopt_ns_capable);
+
+bool sockopt_capable(int cap)
+{
+	return has_current_bpf_ctx() || capable(cap);
+}
+EXPORT_SYMBOL(sockopt_capable);
+
 /*
  *	This is meant for all protocols to use and covers goings on
  *	at the socket level. Everything here is generic.
@@ -1095,7 +1107,7 @@ static int sk_setsockopt(struct sock *sk, int level=
, int optname,
=20
 	switch (optname) {
 	case SO_DEBUG:
-		if (val && !capable(CAP_NET_ADMIN))
+		if (val && !sockopt_capable(CAP_NET_ADMIN))
 			ret =3D -EACCES;
 		else
 			sock_valbool_flag(sk, SOCK_DBG, valbool);
@@ -1139,7 +1151,7 @@ static int sk_setsockopt(struct sock *sk, int level=
, int optname,
 		break;
=20
 	case SO_SNDBUFFORCE:
-		if (!capable(CAP_NET_ADMIN)) {
+		if (!sockopt_capable(CAP_NET_ADMIN)) {
 			ret =3D -EPERM;
 			break;
 		}
@@ -1161,7 +1173,7 @@ static int sk_setsockopt(struct sock *sk, int level=
, int optname,
 		break;
=20
 	case SO_RCVBUFFORCE:
-		if (!capable(CAP_NET_ADMIN)) {
+		if (!sockopt_capable(CAP_NET_ADMIN)) {
 			ret =3D -EPERM;
 			break;
 		}
@@ -1188,8 +1200,8 @@ static int sk_setsockopt(struct sock *sk, int level=
, int optname,
=20
 	case SO_PRIORITY:
 		if ((val >=3D 0 && val <=3D 6) ||
-		    ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) ||
-		    ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
+		    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) ||
+		    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
 			sk->sk_priority =3D val;
 		else
 			ret =3D -EPERM;
@@ -1334,8 +1346,8 @@ static int sk_setsockopt(struct sock *sk, int level=
, int optname,
 			clear_bit(SOCK_PASSSEC, &sock->flags);
 		break;
 	case SO_MARK:
-		if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &&
-		    !ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
+		if (!sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &&
+		    !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
 			ret =3D -EPERM;
 			break;
 		}
@@ -1343,8 +1355,8 @@ static int sk_setsockopt(struct sock *sk, int level=
, int optname,
 		__sock_set_mark(sk, val);
 		break;
 	case SO_RCVMARK:
-		if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &&
-		    !ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
+		if (!sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &&
+		    !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
 			ret =3D -EPERM;
 			break;
 		}
@@ -1378,7 +1390,7 @@ static int sk_setsockopt(struct sock *sk, int level=
, int optname,
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	case SO_BUSY_POLL:
 		/* allow unprivileged users to decrease the value */
-		if ((val > sk->sk_ll_usec) && !capable(CAP_NET_ADMIN))
+		if ((val > sk->sk_ll_usec) && !sockopt_capable(CAP_NET_ADMIN))
 			ret =3D -EPERM;
 		else {
 			if (val < 0)
@@ -1388,13 +1400,13 @@ static int sk_setsockopt(struct sock *sk, int lev=
el, int optname,
 		}
 		break;
 	case SO_PREFER_BUSY_POLL:
-		if (valbool && !capable(CAP_NET_ADMIN))
+		if (valbool && !sockopt_capable(CAP_NET_ADMIN))
 			ret =3D -EPERM;
 		else
 			WRITE_ONCE(sk->sk_prefer_busy_poll, valbool);
 		break;
 	case SO_BUSY_POLL_BUDGET:
-		if (val > READ_ONCE(sk->sk_busy_poll_budget) && !capable(CAP_NET_ADMIN=
)) {
+		if (val > READ_ONCE(sk->sk_busy_poll_budget) && !sockopt_capable(CAP_N=
ET_ADMIN)) {
 			ret =3D -EPERM;
 		} else {
 			if (val < 0 || val > U16_MAX)
@@ -1465,7 +1477,7 @@ static int sk_setsockopt(struct sock *sk, int level=
, int optname,
 		 * scheduler has enough safe guards.
 		 */
 		if (sk_txtime.clockid !=3D CLOCK_MONOTONIC &&
-		    !ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
+		    !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
 			ret =3D -EPERM;
 			break;
 		}
--=20
2.30.2

