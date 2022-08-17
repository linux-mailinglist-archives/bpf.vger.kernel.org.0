Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DAD5969F4
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 09:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbiHQG7J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 02:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbiHQG7F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 02:59:05 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292917548D
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 23:59:04 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27H0RqoK001573
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 23:59:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=6Sd3N0xsVvUYcQdf9po4PyUnPzjitym6YcyiBkA8sQU=;
 b=bekHfWQf7c0dDiwFJXfxfcayKrvp6ca1FCXxfDuqVBxYKvnpyLe5JA+Zq0d5bNbIJkbo
 +udaIL5qK0AgD9EAvuduy1aL2cjt/GU82VPgMQtjhq074HKVmPNHSxTIV8U9a+1IZJha
 qY4kesioWf+9BykMp4H2vb5JrDNgufb4JME= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j0nt9haw3-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 23:59:03 -0700
Received: from twshared22413.18.frc3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 16 Aug 2022 23:59:02 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 66366825DCED; Tue, 16 Aug 2022 23:17:58 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 08/15] bpf: Embed kernel CONFIG check into the if statement in bpf_setsockopt
Date:   Tue, 16 Aug 2022 23:17:58 -0700
Message-ID: <20220817061758.4178374-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220817061704.4174272-1-kafai@fb.com>
References: <20220817061704.4174272-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: wad4noaWsPJd4eDIHsgmox8dcjiA-Z8l
X-Proofpoint-ORIG-GUID: wad4noaWsPJd4eDIHsgmox8dcjiA-Z8l
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

This patch moves the "#ifdef CONFIG_XXX" check into the "if/else"
statement itself.  The change is done for the bpf_setsockopt()
function only.  It will make the latter patches easier to follow
without the surrounding ifdef macro.

Reviewed-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 net/core/filter.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index e8508aaafd27..a663d7b96bad 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5116,8 +5116,7 @@ static int __bpf_setsockopt(struct sock *sk, int le=
vel, int optname,
 		default:
 			ret =3D -EINVAL;
 		}
-#ifdef CONFIG_INET
-	} else if (level =3D=3D SOL_IP) {
+	} else if (IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_IP) {
 		if (optlen !=3D sizeof(int) || sk->sk_family !=3D AF_INET)
 			return -EINVAL;
=20
@@ -5138,8 +5137,7 @@ static int __bpf_setsockopt(struct sock *sk, int le=
vel, int optname,
 		default:
 			ret =3D -EINVAL;
 		}
-#if IS_ENABLED(CONFIG_IPV6)
-	} else if (level =3D=3D SOL_IPV6) {
+	} else if (IS_ENABLED(CONFIG_IPV6) && level =3D=3D SOL_IPV6) {
 		if (optlen !=3D sizeof(int) || sk->sk_family !=3D AF_INET6)
 			return -EINVAL;
=20
@@ -5160,8 +5158,7 @@ static int __bpf_setsockopt(struct sock *sk, int le=
vel, int optname,
 		default:
 			ret =3D -EINVAL;
 		}
-#endif
-	} else if (level =3D=3D SOL_TCP &&
+	} else if (IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_TCP &&
 		   sk->sk_prot->setsockopt =3D=3D tcp_setsockopt) {
 		if (optname =3D=3D TCP_CONGESTION) {
 			char name[TCP_CA_NAME_MAX];
@@ -5253,7 +5250,6 @@ static int __bpf_setsockopt(struct sock *sk, int le=
vel, int optname,
 				ret =3D -EINVAL;
 			}
 		}
-#endif
 	} else {
 		ret =3D -EINVAL;
 	}
--=20
2.30.2

