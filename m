Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C8D58F2C6
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 21:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbiHJTKP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 15:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbiHJTKO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 15:10:14 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96289103
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 12:10:11 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27AGuRPw003159
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 12:10:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=irPemIS8khOKJfzIOv+jj6pgXo9a6s84I7Qf+nMKSdo=;
 b=o3P3QrICt1ulaM8Jq5kpTZ2ApgVWp8GY9CX/ltcHjTxf4QSm2egZScRyjIqJInFiKiZN
 xOZ0eNGYEwUP+Jb0D6/16qTIOwWdQJTtZB+8Sg6GC+5+D40Z48z9XvK8LFlP4wsOo/yZ
 ZMe8gJwfm0xas9uK0ZIDnLEK29ITSVzMkr0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hvdb6b2x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 12:10:11 -0700
Received: from twshared20276.35.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 10 Aug 2022 12:10:09 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 17EFF7E74F74; Wed, 10 Aug 2022 12:07:51 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 04/15] bpf: net: Change do_tcp_setsockopt() to use the sockopt's lock_sock() and capable()
Date:   Wed, 10 Aug 2022 12:07:51 -0700
Message-ID: <20220810190751.2696404-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220810190724.2692127-1-kafai@fb.com>
References: <20220810190724.2692127-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Mw6gMVuie22oP_y85SvXmMUKCiXtYp9h
X-Proofpoint-GUID: Mw6gMVuie22oP_y85SvXmMUKCiXtYp9h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_12,2022-08-10_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similar to the earlier patch that avoids sk_setsockopt() from
taking sk lock and doing capable test when called by bpf.  This patch
changes do_tcp_setsockopt() to use the sockopt_{lock,release}_sock()
and sockopt_[ns_]capable().

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 net/ipv4/tcp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 970e9a2cca4a..cfed84b1883f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3202,7 +3202,7 @@ EXPORT_SYMBOL(tcp_disconnect);
=20
 static inline bool tcp_can_repair_sock(const struct sock *sk)
 {
-	return ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN) &&
+	return sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN) &&
 		(sk->sk_state !=3D TCP_LISTEN);
 }
=20
@@ -3502,11 +3502,11 @@ static int do_tcp_setsockopt(struct sock *sk, int=
 level, int optname,
 			return -EFAULT;
 		name[val] =3D 0;
=20
-		lock_sock(sk);
+		sockopt_lock_sock(sk);
 		err =3D tcp_set_congestion_control(sk, name, true,
-						 ns_capable(sock_net(sk)->user_ns,
-							    CAP_NET_ADMIN));
-		release_sock(sk);
+						 sockopt_ns_capable(sock_net(sk)->user_ns,
+								    CAP_NET_ADMIN));
+		sockopt_release_sock(sk);
 		return err;
 	}
 	case TCP_ULP: {
@@ -3522,9 +3522,9 @@ static int do_tcp_setsockopt(struct sock *sk, int l=
evel, int optname,
 			return -EFAULT;
 		name[val] =3D 0;
=20
-		lock_sock(sk);
+		sockopt_lock_sock(sk);
 		err =3D tcp_set_ulp(sk, name);
-		release_sock(sk);
+		sockopt_release_sock(sk);
 		return err;
 	}
 	case TCP_FASTOPEN_KEY: {
@@ -3557,7 +3557,7 @@ static int do_tcp_setsockopt(struct sock *sk, int l=
evel, int optname,
 	if (copy_from_sockptr(&val, optval, sizeof(val)))
 		return -EFAULT;
=20
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
=20
 	switch (optname) {
 	case TCP_MAXSEG:
@@ -3779,7 +3779,7 @@ static int do_tcp_setsockopt(struct sock *sk, int l=
evel, int optname,
 		break;
 	}
=20
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	return err;
 }
=20
--=20
2.30.2

