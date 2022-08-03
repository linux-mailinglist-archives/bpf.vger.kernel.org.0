Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F55589382
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 22:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238757AbiHCUtc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 16:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238752AbiHCUtb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 16:49:31 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F1B5C964
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 13:49:27 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 273KnOIA017912
        for <bpf@vger.kernel.org>; Wed, 3 Aug 2022 13:49:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=yRFLwGqk94NaXr4KoX+QqXm4ZYNDFsmpZbu64kueqZ4=;
 b=cqarsKINgjWukgAmJkohWwwGOFJjln4mBM3wf/208f1p1MQTiS8KGaW4DB4Fqvf+Cbwy
 Xxl3BKtX3zHeoZ4My9XtQTUwYffUhMqHSI24S9Nzp19vvPA6c3sHW66FP59Z05oY2wej
 CQweViPCEMPqHZHh7sB2eeW2r47x2kxJSGA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hq4b7u51x-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 03 Aug 2022 13:49:27 -0700
Received: from twshared20276.35.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 13:49:25 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 7E1D67A3F777; Wed,  3 Aug 2022 13:46:39 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 06/15] bpf: net: Change do_ipv6_setsockopt() to use the sockopt's lock_sock() and capable()
Date:   Wed, 3 Aug 2022 13:46:39 -0700
Message-ID: <20220803204639.3078356-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220803204601.3075863-1-kafai@fb.com>
References: <20220803204601.3075863-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VqM7e1Zg1xWeV4QRDnM1cBYpV1lvVH-J
X-Proofpoint-GUID: VqM7e1Zg1xWeV4QRDnM1cBYpV1lvVH-J
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
changes do_ipv6_setsockopt() to use the sockopt_{lock,release}_sock()
and sockopt_[ns_]capable().

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

