Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC7D59694D
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 08:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiHQGT7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 02:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbiHQGT7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 02:19:59 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2793967172
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 23:19:58 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27H0Rqmj001573
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 23:19:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=3p2HTvJo/KiB0bwCllk5DnuaCAIxYYmMk/pkI/2jg9o=;
 b=gUECw0zlpdc4RG19F5PyzAGpmTpDl90eBUoOnf/oDJzjUizQpmAViGfAD1gKQSAvzCO3
 m7/mTdQMWg07SRwdWIp7ODN7dgPOQ5xfPXKXSrGr9qclMgLtQmzl5NGh9Q5jtL+rRK5n
 U70yemN/YABBVnQsiDlukJH8QNdmejkVyLI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j0nt9h6y2-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 23:19:57 -0700
Received: from twshared7570.37.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 16 Aug 2022 23:19:56 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 4436E825DBF9; Tue, 16 Aug 2022 23:17:11 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 01/15] net: Add sk_setsockopt() to take the sk ptr instead of the sock ptr
Date:   Tue, 16 Aug 2022 23:17:11 -0700
Message-ID: <20220817061711.4175048-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220817061704.4174272-1-kafai@fb.com>
References: <20220817061704.4174272-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: dhdPRvIWAbSfdim9_Wk-Y2FE9Pqqxthz
X-Proofpoint-ORIG-GUID: dhdPRvIWAbSfdim9_Wk-Y2FE9Pqqxthz
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

A latter patch refactors bpf_setsockopt(SOL_SOCKET) with the
sock_setsockopt() to avoid code duplication and code
drift between the two duplicates.

The current sock_setsockopt() takes sock ptr as the argument.
The very first thing of this function is to get back the sk ptr
by 'sk =3D sock->sk'.

bpf_setsockopt() could be called when the sk does not have
the sock ptr created.  Meaning sk->sk_socket is NULL.  For example,
when a passive tcp connection has just been established but has yet
been accept()-ed.  Thus, it cannot use the sock_setsockopt(sk->sk_socket)
or else it will pass a NULL ptr.

This patch moves all sock_setsockopt implementation to the newly
added sk_setsockopt().  The new sk_setsockopt() takes a sk ptr
and immediately gets the sock ptr by 'sock =3D sk->sk_socket'

The existing sock_setsockopt(sock) is changed to call
sk_setsockopt(sock->sk).  All existing callers have both sock->sk
and sk->sk_socket pointer.

The latter patch will make bpf_setsockopt(SOL_SOCKET) call
sk_setsockopt(sk) directly.  The bpf_setsockopt(SOL_SOCKET) does
not use the optnames that require sk->sk_socket, so it will
be safe.

Reviewed-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 net/core/sock.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 4cb957d934a2..20269c37ab3b 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1041,12 +1041,12 @@ static int sock_reserve_memory(struct sock *sk, i=
nt bytes)
  *	at the socket level. Everything here is generic.
  */
=20
-int sock_setsockopt(struct socket *sock, int level, int optname,
-		    sockptr_t optval, unsigned int optlen)
+static int sk_setsockopt(struct sock *sk, int level, int optname,
+			 sockptr_t optval, unsigned int optlen)
 {
 	struct so_timestamping timestamping;
+	struct socket *sock =3D sk->sk_socket;
 	struct sock_txtime sk_txtime;
-	struct sock *sk =3D sock->sk;
 	int val;
 	int valbool;
 	struct linger ling;
@@ -1499,6 +1499,13 @@ int sock_setsockopt(struct socket *sock, int level=
, int optname,
 	release_sock(sk);
 	return ret;
 }
+
+int sock_setsockopt(struct socket *sock, int level, int optname,
+		    sockptr_t optval, unsigned int optlen)
+{
+	return sk_setsockopt(sock->sk, level, optname,
+			     optval, optlen);
+}
 EXPORT_SYMBOL(sock_setsockopt);
=20
 static const struct cred *sk_get_peer_cred(struct sock *sk)
--=20
2.30.2

