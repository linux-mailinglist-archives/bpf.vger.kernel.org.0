Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349A458937F
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 22:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238755AbiHCUtV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 16:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238751AbiHCUtU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 16:49:20 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CE05C95C
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 13:49:19 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 273JhO0T032110
        for <bpf@vger.kernel.org>; Wed, 3 Aug 2022 13:49:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=irPemIS8khOKJfzIOv+jj6pgXo9a6s84I7Qf+nMKSdo=;
 b=VNDrI8+Hn8KswlUhTC0dgsCGgXEe1vbVGd1eB4VTX+Uh5xjROXENKLHtQdLaxFhRjOZX
 BiLeC3X++OYjzWArXdyx+3eFalIl3amJGQ+zE2aYb9YNavmKku8YUR+gGZd/7SFf2HM+
 seHlm0wWxORXJ8zMCseEv7URgfZ2BKKCGVQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hq51d2vdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 03 Aug 2022 13:49:18 -0700
Received: from twshared7570.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 13:49:17 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id CF6FA7A3F74E; Wed,  3 Aug 2022 13:46:26 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 04/15] bpf: net: Change do_tcp_setsockopt() to use the sockopt's lock_sock() and capable()
Date:   Wed, 3 Aug 2022 13:46:26 -0700
Message-ID: <20220803204626.3078012-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220803204601.3075863-1-kafai@fb.com>
References: <20220803204601.3075863-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: NGBjOtC2YVqmJEZW0ivRP0X2qFpQbwFA
X-Proofpoint-ORIG-GUID: NGBjOtC2YVqmJEZW0ivRP0X2qFpQbwFA
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

