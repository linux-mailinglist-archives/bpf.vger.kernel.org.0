Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1590E5969FA
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 09:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbiHQG7K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 02:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238408AbiHQG7F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 02:59:05 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD8E786CB
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 23:59:04 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27H0RqoM001573
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 23:59:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=B0vNEoQIJSp/abWi0itBMd8TCeNRav/Bbth0BGd2aFE=;
 b=jzjI/HeQI673FuvMsr3Fk/u05nYHHanTJNTA5H2sc1zrS6W/x/8Lx0D5riOaveuTHJY+
 GaRti5OPYzrDir5mXPIZT2SMFwH1yu45yF3jQ4m+kBgf8XyEsHsmJZISR02k5gXfNkOt
 ZzVMagA/qrL4V1/t2aX8+JrroOz203mEVfs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j0nt9haw3-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 23:59:04 -0700
Received: from twshared30313.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 16 Aug 2022 23:59:03 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 5CC9A825DC66; Tue, 16 Aug 2022 23:17:37 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 05/15] bpf: net: Change do_ip_setsockopt() to use the sockopt's lock_sock() and capable()
Date:   Tue, 16 Aug 2022 23:17:37 -0700
Message-ID: <20220817061737.4176402-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220817061704.4174272-1-kafai@fb.com>
References: <20220817061704.4174272-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: KHYQzEAz1txswqrYQ-qDADGEo4s5noYP
X-Proofpoint-ORIG-GUID: KHYQzEAz1txswqrYQ-qDADGEo4s5noYP
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
changes do_ip_setsockopt() to use the sockopt_{lock,release}_sock()
and sockopt_[ns_]capable().

Reviewed-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 net/ipv4/ip_sockglue.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index a8a323ecbb54..a3c496580e6b 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -944,7 +944,7 @@ static int do_ip_setsockopt(struct sock *sk, int leve=
l, int optname,
 	err =3D 0;
 	if (needs_rtnl)
 		rtnl_lock();
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
=20
 	switch (optname) {
 	case IP_OPTIONS:
@@ -1333,14 +1333,14 @@ static int do_ip_setsockopt(struct sock *sk, int =
level, int optname,
 	case IP_IPSEC_POLICY:
 	case IP_XFRM_POLICY:
 		err =3D -EPERM;
-		if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
+		if (!sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
 			break;
 		err =3D xfrm_user_policy(sk, optname, optval, optlen);
 		break;
=20
 	case IP_TRANSPARENT:
-		if (!!val && !ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &&
-		    !ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
+		if (!!val && !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &=
&
+		    !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
 			err =3D -EPERM;
 			break;
 		}
@@ -1368,13 +1368,13 @@ static int do_ip_setsockopt(struct sock *sk, int =
level, int optname,
 		err =3D -ENOPROTOOPT;
 		break;
 	}
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	if (needs_rtnl)
 		rtnl_unlock();
 	return err;
=20
 e_inval:
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	if (needs_rtnl)
 		rtnl_unlock();
 	return -EINVAL;
--=20
2.30.2

