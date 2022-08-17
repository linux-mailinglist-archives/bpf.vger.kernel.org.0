Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EC45969DD
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 08:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiHQGxJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 02:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiHQGxH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 02:53:07 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C82246
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 23:53:06 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27H0WrHM028921
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 23:53:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=biZpN7ohszoJ3Mskcxzy0Zt3nSobeX/bnUTitHKAEds=;
 b=jiCoyL43QgYQeugBHnzIJSAAAV/9qVhNnv1YlvDAA5bcQ0wko42nSP18MwTyWxYaz5+f
 0UVhr9f5TRAsO3Q+SpD/IO3smSFO3h8FbJvKOD5UHy6V9HABW4lDOFFnQHt/kfZRPd1s
 JO1Sme7vt23nJxtk+OwDymBLvYqeoRtszEU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3j0nvjha3t-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 23:53:05 -0700
Received: from twshared16418.24.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 16 Aug 2022 23:53:02 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id B509B825DCA4; Tue, 16 Aug 2022 23:17:44 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 06/15] bpf: net: Change do_ipv6_setsockopt() to use the sockopt's lock_sock() and capable()
Date:   Tue, 16 Aug 2022 23:17:44 -0700
Message-ID: <20220817061744.4176893-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220817061704.4174272-1-kafai@fb.com>
References: <20220817061704.4174272-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: XwhxsVY2Y1DgN1h-m5AXTVTeUVjxmcms
X-Proofpoint-ORIG-GUID: XwhxsVY2Y1DgN1h-m5AXTVTeUVjxmcms
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

Similar to the earlier patch that avoids sk_setsockopt() from
taking sk lock and doing capable test when called by bpf.  This patch
changes do_ipv6_setsockopt() to use the sockopt_{lock,release}_sock()
and sockopt_[ns_]capable().

Reviewed-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 net/ipv6/ipv6_sockglue.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 222f6bf220ba..d23de48ff612 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -327,7 +327,7 @@ static int ipv6_set_opt_hdr(struct sock *sk, int optn=
ame, sockptr_t optval,
 	int err;
=20
 	/* hop-by-hop / destination options are privileged option */
-	if (optname !=3D IPV6_RTHDR && !ns_capable(net->user_ns, CAP_NET_RAW))
+	if (optname !=3D IPV6_RTHDR && !sockopt_ns_capable(net->user_ns, CAP_NE=
T_RAW))
 		return -EPERM;
=20
 	/* remove any sticky options header with a zero option
@@ -417,7 +417,7 @@ static int do_ipv6_setsockopt(struct sock *sk, int le=
vel, int optname,
=20
 	if (needs_rtnl)
 		rtnl_lock();
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
=20
 	switch (optname) {
=20
@@ -634,8 +634,8 @@ static int do_ipv6_setsockopt(struct sock *sk, int le=
vel, int optname,
 		break;
=20
 	case IPV6_TRANSPARENT:
-		if (valbool && !ns_capable(net->user_ns, CAP_NET_RAW) &&
-		    !ns_capable(net->user_ns, CAP_NET_ADMIN)) {
+		if (valbool && !sockopt_ns_capable(net->user_ns, CAP_NET_RAW) &&
+		    !sockopt_ns_capable(net->user_ns, CAP_NET_ADMIN)) {
 			retv =3D -EPERM;
 			break;
 		}
@@ -946,7 +946,7 @@ static int do_ipv6_setsockopt(struct sock *sk, int le=
vel, int optname,
 	case IPV6_IPSEC_POLICY:
 	case IPV6_XFRM_POLICY:
 		retv =3D -EPERM;
-		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+		if (!sockopt_ns_capable(net->user_ns, CAP_NET_ADMIN))
 			break;
 		retv =3D xfrm_user_policy(sk, optname, optval, optlen);
 		break;
@@ -994,14 +994,14 @@ static int do_ipv6_setsockopt(struct sock *sk, int =
level, int optname,
 		break;
 	}
=20
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	if (needs_rtnl)
 		rtnl_unlock();
=20
 	return retv;
=20
 e_inval:
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	if (needs_rtnl)
 		rtnl_unlock();
 	return -EINVAL;
--=20
2.30.2

