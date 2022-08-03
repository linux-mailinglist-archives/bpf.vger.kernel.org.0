Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31912589381
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 22:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238486AbiHCUt3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 16:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238750AbiHCUt1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 16:49:27 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AE15C962
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 13:49:25 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 273EnGok001345
        for <bpf@vger.kernel.org>; Wed, 3 Aug 2022 13:49:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=mC+JAYl/FxMi5DwqUDHryY0tLe8yuBp32PcYiqeuywg=;
 b=qaxEcnh3Bh9BheprE0SmaOlxEL+Oi5fvHWgrqfmOF1TzLFUVz/yAr7w6uocL3gEFI2RA
 peZOwYtvNDRs2h2BvNIl5WxV8jnX/RzRkI+11lt3SZgcleYS7hYZyupLs8Y5QemzIKCW
 2MIO8Ug92jfrWUsE4N/PGZnf0zbw0KzV9F8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3hqbqx7cs7-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 03 Aug 2022 13:49:25 -0700
Received: from twshared16418.24.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 13:49:22 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 87BB97A3F73D; Wed,  3 Aug 2022 13:46:20 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 03/15] bpf: net: Consider in_bpf() when testing capable() in sk_setsockopt()
Date:   Wed, 3 Aug 2022 13:46:20 -0700
Message-ID: <20220803204620.3077641-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220803204601.3075863-1-kafai@fb.com>
References: <20220803204601.3075863-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: QI9Dt6hpAfmUeSHeW016t-AO5krsTVqy
X-Proofpoint-GUID: QI9Dt6hpAfmUeSHeW016t-AO5krsTVqy
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

When bpf program calling bpf_setsockopt(SOL_SOCKET),
it could be run in softirq and doesn't make sense to do the capable
check.  There was a similar situation in bpf_setsockopt(TCP_CONGESTION).
In commit 8d650cdedaab ("tcp: fix tcp_set_congestion_control() use from b=
pf hook"),
tcp_set_congestion_control(..., cap_net_admin) was added to skip
the cap check for bpf prog.

This patch adds sockopt_ns_capable() and sockopt_capable() for
the sk_setsockopt() to use.  They will consider the in_bpf()
before doing the ns_capable() and capable() test.  They are in
EXPORT_SYMBOL for the ipv6 module to use in a latter patch.

Suggested-by: Stanislav Fomichev <sdf@google.com>
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
index 82759540ae2c..2d88c06c27b7 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1056,6 +1056,18 @@ void sockopt_release_sock(struct sock *sk)
 }
 EXPORT_SYMBOL(sockopt_release_sock);
=20
+bool sockopt_ns_capable(struct user_namespace *ns, int cap)
+{
+	return in_bpf() || ns_capable(ns, cap);
+}
+EXPORT_SYMBOL(sockopt_ns_capable);
+
+bool sockopt_capable(int cap)
+{
+	return in_bpf() || capable(cap);
+}
+EXPORT_SYMBOL(sockopt_capable);
+
 /*
  *	This is meant for all protocols to use and covers goings on
  *	at the socket level. Everything here is generic.
@@ -1091,7 +1103,7 @@ static int sk_setsockopt(struct sock *sk, int level=
, int optname,
=20
 	switch (optname) {
 	case SO_DEBUG:
-		if (val && !capable(CAP_NET_ADMIN))
+		if (val && !sockopt_capable(CAP_NET_ADMIN))
 			ret =3D -EACCES;
 		else
 			sock_valbool_flag(sk, SOCK_DBG, valbool);
@@ -1135,7 +1147,7 @@ static int sk_setsockopt(struct sock *sk, int level=
, int optname,
 		break;
=20
 	case SO_SNDBUFFORCE:
-		if (!capable(CAP_NET_ADMIN)) {
+		if (!sockopt_capable(CAP_NET_ADMIN)) {
 			ret =3D -EPERM;
 			break;
 		}
@@ -1157,7 +1169,7 @@ static int sk_setsockopt(struct sock *sk, int level=
, int optname,
 		break;
=20
 	case SO_RCVBUFFORCE:
-		if (!capable(CAP_NET_ADMIN)) {
+		if (!sockopt_capable(CAP_NET_ADMIN)) {
 			ret =3D -EPERM;
 			break;
 		}
@@ -1184,8 +1196,8 @@ static int sk_setsockopt(struct sock *sk, int level=
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
@@ -1330,8 +1342,8 @@ static int sk_setsockopt(struct sock *sk, int level=
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
@@ -1339,8 +1351,8 @@ static int sk_setsockopt(struct sock *sk, int level=
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
@@ -1374,7 +1386,7 @@ static int sk_setsockopt(struct sock *sk, int level=
, int optname,
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	case SO_BUSY_POLL:
 		/* allow unprivileged users to decrease the value */
-		if ((val > sk->sk_ll_usec) && !capable(CAP_NET_ADMIN))
+		if ((val > sk->sk_ll_usec) && !sockopt_capable(CAP_NET_ADMIN))
 			ret =3D -EPERM;
 		else {
 			if (val < 0)
@@ -1384,13 +1396,13 @@ static int sk_setsockopt(struct sock *sk, int lev=
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
@@ -1461,7 +1473,7 @@ static int sk_setsockopt(struct sock *sk, int level=
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

