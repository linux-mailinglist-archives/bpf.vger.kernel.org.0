Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E7A5AA469
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 02:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbiIBAbF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 20:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbiIBAbC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 20:31:02 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1970598A6D
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 17:31:01 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28208ppQ028426
        for <bpf@vger.kernel.org>; Thu, 1 Sep 2022 17:31:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=lfd9SuMEDYZ11bXZLCYSjru25Vkdm0w/GY9xeZuj+yA=;
 b=fMMea1qqWGRbyBPdCYrTNmpfnyTlvxVtAAVltwRAv3LAtrWcNIxqkBB9KK/96KHNrp6d
 fgH9vEAswT1QPD4fmeaeBcW5y+OpSdR3/VRD5hILaUUxvEzzWF8++nLTYJ3Hhwrx4WVy
 OilrAfGdNovmJAnw0eV+1wkie3v4aL4C1Gw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jaf2n0pht-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 01 Sep 2022 17:31:01 -0700
Received: from twshared1781.23.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 17:30:54 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 6B02A8C47B4E; Thu,  1 Sep 2022 17:28:34 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, <kernel-team@fb.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH v2 bpf-next 07/17] bpf: net: Avoid do_ip_getsockopt() taking sk lock when called from bpf
Date:   Thu, 1 Sep 2022 17:28:34 -0700
Message-ID: <20220902002834.2891514-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220902002750.2887415-1-kafai@fb.com>
References: <20220902002750.2887415-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: hoaDdEUVV_STfaxmAMwf83dyxuLlEG8W
X-Proofpoint-ORIG-GUID: hoaDdEUVV_STfaxmAMwf83dyxuLlEG8W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

Similar to the earlier commit that changed sk_setsockopt() to
use sockopt_{lock,release}_sock() such that it can avoid taking
lock when called from bpf.  This patch also changes do_ip_getsockopt()
to use sockopt_{lock,release}_sock() such that a latter patch can
make bpf_getsockopt(SOL_IP) to reuse do_ip_getsockopt().

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 net/ipv4/ip_sockglue.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 5310def20e0c..5d134a75cad0 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1545,7 +1545,7 @@ static int do_ip_getsockopt(struct sock *sk, int le=
vel, int optname,
=20
 	if (needs_rtnl)
 		rtnl_lock();
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
=20
 	switch (optname) {
 	case IP_OPTIONS:
@@ -1561,7 +1561,7 @@ static int do_ip_getsockopt(struct sock *sk, int le=
vel, int optname,
 			memcpy(optbuf, &inet_opt->opt,
 			       sizeof(struct ip_options) +
 			       inet_opt->opt.optlen);
-		release_sock(sk);
+		sockopt_release_sock(sk);
=20
 		if (opt->optlen =3D=3D 0) {
 			len =3D 0;
@@ -1637,7 +1637,7 @@ static int do_ip_getsockopt(struct sock *sk, int le=
vel, int optname,
 			dst_release(dst);
 		}
 		if (!val) {
-			release_sock(sk);
+			sockopt_release_sock(sk);
 			return -ENOTCONN;
 		}
 		break;
@@ -1662,7 +1662,7 @@ static int do_ip_getsockopt(struct sock *sk, int le=
vel, int optname,
 		struct in_addr addr;
 		len =3D min_t(unsigned int, len, sizeof(struct in_addr));
 		addr.s_addr =3D inet->mc_addr;
-		release_sock(sk);
+		sockopt_release_sock(sk);
=20
 		if (copy_to_sockptr(optlen, &len, sizeof(int)))
 			return -EFAULT;
@@ -1699,7 +1699,7 @@ static int do_ip_getsockopt(struct sock *sk, int le=
vel, int optname,
 	{
 		struct msghdr msg;
=20
-		release_sock(sk);
+		sockopt_release_sock(sk);
=20
 		if (sk->sk_type !=3D SOCK_STREAM)
 			return -ENOPROTOOPT;
@@ -1743,10 +1743,10 @@ static int do_ip_getsockopt(struct sock *sk, int =
level, int optname,
 		val =3D inet->min_ttl;
 		break;
 	default:
-		release_sock(sk);
+		sockopt_release_sock(sk);
 		return -ENOPROTOOPT;
 	}
-	release_sock(sk);
+	sockopt_release_sock(sk);
=20
 	if (len < sizeof(int) && len > 0 && val >=3D 0 && val <=3D 255) {
 		unsigned char ucval =3D (unsigned char)val;
@@ -1765,7 +1765,7 @@ static int do_ip_getsockopt(struct sock *sk, int le=
vel, int optname,
 	return 0;
=20
 out:
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	if (needs_rtnl)
 		rtnl_unlock();
 	return err;
--=20
2.30.2

