Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E091E5A03FF
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 00:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiHXWaN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 18:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiHXWaL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 18:30:11 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD96665BA
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:30:10 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OMHCIX000736
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:30:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=LZaMBJp6tZiLBIERz14EIzV49qBBjobqi5z/Uo7Tgss=;
 b=ROBCeClMmc/Y0EzJODsnlZ2LUgaL7rBk/j0tIqKgQBYoKynaKq5/EIsVLQMCsBkasPK8
 GFuI3OLd5QmUS470nSYQjGdaOGZmj2e9VqvFoEhnG4BozlfPCHK0NrnqCEEK600G5mZB
 4RLCdenpO0gY2ZFWo8ra9tfXx/tvvwc7NaM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j5bejxn7g-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:30:10 -0700
Received: from twshared14818.18.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 15:30:07 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id B5289871C9C4; Wed, 24 Aug 2022 15:27:17 -0700 (PDT)
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
Subject: [PATCH bpf-next 12/17] bpf: Embed kernel CONFIG check into the if statement in bpf_getsockopt
Date:   Wed, 24 Aug 2022 15:27:17 -0700
Message-ID: <20220824222717.1922961-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220824222601.1916776-1-kafai@fb.com>
References: <20220824222601.1916776-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: wL7PYitdwHlMiUFg601yTA6LsO8F2Zif
X-Proofpoint-GUID: wL7PYitdwHlMiUFg601yTA6LsO8F2Zif
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

This patch moves the "#ifdef CONFIG_XXX" check into the "if/else"
statement itself.  The change is done for the bpf_getsockopt()
function only.  It will make the latter patches easier to follow
without the surrounding ifdef macro.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 net/core/filter.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 8e7fc71160cd..347c38da1e0c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5218,8 +5218,8 @@ static int __bpf_getsockopt(struct sock *sk, int le=
vel, int optname,
 		default:
 			goto err_clear;
 		}
-#ifdef CONFIG_INET
-	} else if (level =3D=3D SOL_TCP && sk->sk_prot->getsockopt =3D=3D tcp_g=
etsockopt) {
+	} else if (IS_ENABLED(CONFIG_INET) &&
+		   level =3D=3D SOL_TCP && sk->sk_prot->getsockopt =3D=3D tcp_getsocko=
pt) {
 		struct inet_connection_sock *icsk;
 		struct tcp_sock *tp;
=20
@@ -5243,7 +5243,7 @@ static int __bpf_getsockopt(struct sock *sk, int le=
vel, int optname,
 		default:
 			goto err_clear;
 		}
-	} else if (level =3D=3D SOL_IP) {
+	} else if (IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_IP) {
 		struct inet_sock *inet =3D inet_sk(sk);
=20
 		if (optlen !=3D sizeof(int) || sk->sk_family !=3D AF_INET)
@@ -5257,8 +5257,7 @@ static int __bpf_getsockopt(struct sock *sk, int le=
vel, int optname,
 		default:
 			goto err_clear;
 		}
-#if IS_ENABLED(CONFIG_IPV6)
-	} else if (level =3D=3D SOL_IPV6) {
+	} else if (IS_ENABLED(CONFIG_IPV6) && level =3D=3D SOL_IPV6) {
 		struct ipv6_pinfo *np =3D inet6_sk(sk);
=20
 		if (optlen !=3D sizeof(int) || sk->sk_family !=3D AF_INET6)
@@ -5272,8 +5271,6 @@ static int __bpf_getsockopt(struct sock *sk, int le=
vel, int optname,
 		default:
 			goto err_clear;
 		}
-#endif
-#endif
 	} else {
 		goto err_clear;
 	}
--=20
2.30.2

