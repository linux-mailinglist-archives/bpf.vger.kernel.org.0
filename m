Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849055A03F4
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 00:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiHXW3A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 18:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiHXW27 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 18:28:59 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3557F10E
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:28:58 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OMHCoS027529
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:28:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Yli7hqW+I2WP3rdeDHrvshcEVezbyRn8c9RWiTp26mM=;
 b=pk19dbGVTPjHzulPWjwziZj2cVnB9mncJVxzIRH76Wh2jzhskJgFQSnBVYEZmT9eEVWK
 tLPjLSj/w1QTm/+trUX0htecC9n1jETrXGTGw5OtjWyeUXj9j5VDV0jkF42quqXuFOGH
 B12/8mQeFDYzrbqFmenOXnS/vmFM6oSF3Ik= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j5aay71t5-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:28:56 -0700
Received: from twshared14818.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 15:28:55 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 46FEA871C8A4; Wed, 24 Aug 2022 15:26:07 -0700 (PDT)
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
Subject: [PATCH bpf-next 01/17] net: Change sock_getsockopt() to take the sk ptr instead of the sock ptr
Date:   Wed, 24 Aug 2022 15:26:07 -0700
Message-ID: <20220824222607.1917331-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220824222601.1916776-1-kafai@fb.com>
References: <20220824222601.1916776-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: UNSirCGC9_ZrkTHiY93lkmEW34RvdXP3
X-Proofpoint-GUID: UNSirCGC9_ZrkTHiY93lkmEW34RvdXP3
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

A latter patch refactors bpf_getsockopt(SOL_SOCKET) with the
sock_getsockopt() to avoid code duplication and code
drift between the two duplicates.

The current sock_getsockopt() takes sock ptr as the argument.
The very first thing of this function is to get back the sk ptr
by 'sk =3D sock->sk'.

bpf_getsockopt() could be called when the sk does not have
the sock ptr created.  Meaning sk->sk_socket is NULL.  For example,
when a passive tcp connection has just been established but has yet
been accept()-ed.  Thus, it cannot use the sock_getsockopt(sk->sk_socket)
or else it will pass a NULL ptr.

This patch moves all sock_getsockopt implementation to the newly
added sk_getsockopt().  The new sk_getsockopt() takes a sk ptr
and immediately gets the sock ptr by 'sock =3D sk->sk_socket'

The existing sock_getsockopt(sock) is changed to call
sk_getsockopt(sock->sk).  All existing callers have both sock->sk
and sk->sk_socket pointer.

The latter patch will make bpf_getsockopt(SOL_SOCKET) call
sk_getsockopt(sk) directly.  The bpf_getsockopt(SOL_SOCKET) does
not use the optnames that require sk->sk_socket, so it will
be safe.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 net/core/sock.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 2a6f84702eb9..21bc4bf6b485 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1580,10 +1580,10 @@ static int groups_to_user(gid_t __user *dst, cons=
t struct group_info *src)
 	return 0;
 }
=20
-int sock_getsockopt(struct socket *sock, int level, int optname,
-		    char __user *optval, int __user *optlen)
+static int sk_getsockopt(struct sock *sk, int level, int optname,
+			 char __user *optval, int __user *optlen)
 {
-	struct sock *sk =3D sock->sk;
+	struct socket *sock =3D sk->sk_socket;
=20
 	union {
 		int val;
@@ -1947,6 +1947,12 @@ int sock_getsockopt(struct socket *sock, int level=
, int optname,
 	return 0;
 }
=20
+int sock_getsockopt(struct socket *sock, int level, int optname,
+		    char __user *optval, int __user *optlen)
+{
+	return sk_getsockopt(sock->sk, level, optname, optval, optlen);
+}
+
 /*
  * Initialize an sk_lock.
  *
--=20
2.30.2

