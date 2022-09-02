Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8C65AA46A
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 02:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbiIBAcE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 20:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIBAcD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 20:32:03 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619E49E6BD
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 17:32:02 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28208tRT017605
        for <bpf@vger.kernel.org>; Thu, 1 Sep 2022 17:32:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ubMBUX8zss4NFtHbIxg8rk9oCU+2HUAv/TcKok6fBHg=;
 b=mnUqGvLSqWGlQTl4944YpK72N58wrTd4yD5Jpo3zSrl1xqe3YSQZlDgEgn2iI/Dr15qb
 Li1iXXw55c6RidE4XhMH2lHXHB+s+pgGRw3wie5jTfoJi5Z0QQt1QDv3+iDBh0CxfmgY
 /yjscGKYPiQtRzNweAzit8a4AHAG5XxXSbs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jaab3324e-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 01 Sep 2022 17:32:01 -0700
Received: from twshared10425.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 17:32:00 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 2C0988C47BAF; Thu,  1 Sep 2022 17:29:06 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 12/17] bpf: Embed kernel CONFIG check into the if statement in bpf_getsockopt
Date:   Thu, 1 Sep 2022 17:29:06 -0700
Message-ID: <20220902002906.2893572-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220902002750.2887415-1-kafai@fb.com>
References: <20220902002750.2887415-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: v4lyw1fVKK8u6DvMirB5wzBxn5JPEi7L
X-Proofpoint-ORIG-GUID: v4lyw1fVKK8u6DvMirB5wzBxn5JPEi7L
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

This patch moves the "#ifdef CONFIG_XXX" check into the "if/else"
statement itself.  The change is done for the bpf_getsockopt()
function only.  It will make the latter patches easier to follow
without the surrounding ifdef macro.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
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

