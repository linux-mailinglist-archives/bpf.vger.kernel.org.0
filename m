Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FD15A0402
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 00:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiHXWaP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 18:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiHXWaM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 18:30:12 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B23965CE
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:30:11 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27OMHD8d017597
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:30:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=cDCgSN3oz32r2R+y2R5p4fhYofSPiDaZ+hpU/dEuKwM=;
 b=o923cj4TyFI+Cl5GH+CwwiXaAF3m/7G7BkRa1L0sxteLmbuF207yl0AlsnXxt3HUQh6P
 qYAHWvoSBbWkEBF2bsLf/QTj/kFFf8fPeVfi2S5hAOFfhrgS9rAjsV2fLbSpprfVzQVf
 0ecKDZpfLrQUAtB6rw7kwxVYB5vz2PYcJQ4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3j4x1yvjdp-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:30:10 -0700
Received: from twshared20276.35.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 15:30:07 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 69DD9871C9B7; Wed, 24 Aug 2022 15:27:11 -0700 (PDT)
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
Subject: [PATCH bpf-next 11/17] bpf: net: Avoid do_ipv6_getsockopt() taking sk lock when called from bpf
Date:   Wed, 24 Aug 2022 15:27:11 -0700
Message-ID: <20220824222711.1922342-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220824222601.1916776-1-kafai@fb.com>
References: <20220824222601.1916776-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: onO4Kx_U4iYrDYaXQLwm5O6JmQK05pj1
X-Proofpoint-ORIG-GUID: onO4Kx_U4iYrDYaXQLwm5O6JmQK05pj1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_14,2022-08-22_02,2022-06-22_01
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

Similar to the earlier patch that changes sk_getsockopt() to
use sockopt_{lock,release}_sock() such that it can avoid taking the
lock when called from bpf.  This patch also changes do_ipv6_getsockopt()
to use sockopt_{lock,release}_sock() such that bpf_getsockopt(SOL_IPV6)
can reuse do_ipv6_getsockopt().

Although bpf_getsockopt(SOL_IPV6) currently does not support optname
that requires lock_sock(), using sockopt_{lock,release}_sock()
consistently across *_getsockopt() will make future optname addition
harder to miss the sockopt_{lock,release}_sock() usage. eg. when
adding new optname that requires a lock and the new optname is
needed in bpf_getsockopt() also.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 net/ipv6/ipv6_sockglue.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 4d9fadef2d3e..d9887e3a6077 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -1078,7 +1078,7 @@ static int ipv6_get_msfilter(struct sock *sk, sockp=
tr_t optval,
 	if (gsf.gf_group.ss_family !=3D AF_INET6)
 		return -EADDRNOTAVAIL;
 	num =3D gsf.gf_numsrc;
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	err =3D ip6_mc_msfget(sk, &gsf, optval, size0);
 	if (!err) {
 		if (num > gsf.gf_numsrc)
@@ -1088,7 +1088,7 @@ static int ipv6_get_msfilter(struct sock *sk, sockp=
tr_t optval,
 		    copy_to_sockptr(optval, &gsf, size0))
 			err =3D -EFAULT;
 	}
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	return err;
 }
=20
@@ -1114,9 +1114,9 @@ static int compat_ipv6_get_msfilter(struct sock *sk=
, sockptr_t optval,
 	if (gf.gf_group.ss_family !=3D AF_INET6)
 		return -EADDRNOTAVAIL;
=20
-	lock_sock(sk);
+	sockopt_lock_sock(sk);
 	err =3D ip6_mc_msfget(sk, &gf, optval, size0);
-	release_sock(sk);
+	sockopt_release_sock(sk);
 	if (err)
 		return err;
 	if (num > gf.gf_numsrc)
@@ -1175,11 +1175,11 @@ static int do_ipv6_getsockopt(struct sock *sk, in=
t level, int optname,
 		msg.msg_controllen =3D len;
 		msg.msg_flags =3D 0;
=20
-		lock_sock(sk);
+		sockopt_lock_sock(sk);
 		skb =3D np->pktoptions;
 		if (skb)
 			ip6_datagram_recv_ctl(sk, &msg, skb);
-		release_sock(sk);
+		sockopt_release_sock(sk);
 		if (!skb) {
 			if (np->rxopt.bits.rxinfo) {
 				struct in6_pktinfo src_info;
@@ -1268,11 +1268,11 @@ static int do_ipv6_getsockopt(struct sock *sk, in=
t level, int optname,
 	{
 		struct ipv6_txoptions *opt;
=20
-		lock_sock(sk);
+		sockopt_lock_sock(sk);
 		opt =3D rcu_dereference_protected(np->opt,
 						lockdep_sock_is_held(sk));
 		len =3D ipv6_getsockopt_sticky(sk, opt, optname, optval, len);
-		release_sock(sk);
+		sockopt_release_sock(sk);
 		/* check if ipv6_getsockopt_sticky() returns err code */
 		if (len < 0)
 			return len;
--=20
2.30.2

