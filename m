Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC375AA478
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 02:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbiIBAcH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 20:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiIBAcG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 20:32:06 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9739E12E
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 17:32:05 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 28208oLn019782
        for <bpf@vger.kernel.org>; Thu, 1 Sep 2022 17:32:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=vbW2X5/pBMDAdUcv4OUW/CWebw3qEhiQoQrYjJFeR0o=;
 b=R34mXqjKW9/yl70aPhmrOsv6ReFd90TfOLlwtwG3VR2NWlbn33h8lBfgLBEvOKkxxvpC
 G4NnU74AI29e5Z+RgdK2QknJrKJDVdhzkBI86JxOzTDjiEM5yW58JHcm7vv4HMypzxMy
 5Zf2RcpNW1d0rkZx14ZKLhYfd7so58FMg1Q= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3jam3vf6h8-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 01 Sep 2022 17:32:04 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub204.TheFacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 17:32:00 -0700
Received: from twshared29104.24.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 17:32:00 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id B44138C47B62; Thu,  1 Sep 2022 17:28:40 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 08/17] net: Remove unused flags argument from do_ipv6_getsockopt
Date:   Thu, 1 Sep 2022 17:28:40 -0700
Message-ID: <20220902002840.2891763-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220902002750.2887415-1-kafai@fb.com>
References: <20220902002750.2887415-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: nEoPvISsetckNF77pAWGZEmtbg_nGMB8
X-Proofpoint-ORIG-GUID: nEoPvISsetckNF77pAWGZEmtbg_nGMB8
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

The 'unsigned int flags' argument is always 0, so it can be removed.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 net/ipv6/ipv6_sockglue.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index a4535bdbd310..2894271c2c08 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -1133,7 +1133,7 @@ static int compat_ipv6_get_msfilter(struct sock *sk=
, void __user *optval,
 }
=20
 static int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
-		    char __user *optval, int __user *optlen, unsigned int flags)
+		    char __user *optval, int __user *optlen)
 {
 	struct ipv6_pinfo *np =3D inet6_sk(sk);
 	int len;
@@ -1168,7 +1168,7 @@ static int do_ipv6_getsockopt(struct sock *sk, int =
level, int optname,
=20
 		msg.msg_control_user =3D optval;
 		msg.msg_controllen =3D len;
-		msg.msg_flags =3D flags;
+		msg.msg_flags =3D 0;
 		msg.msg_control_is_user =3D true;
=20
 		lock_sock(sk);
@@ -1492,7 +1492,7 @@ int ipv6_getsockopt(struct sock *sk, int level, int=
 optname,
 	if (level !=3D SOL_IPV6)
 		return -ENOPROTOOPT;
=20
-	err =3D do_ipv6_getsockopt(sk, level, optname, optval, optlen, 0);
+	err =3D do_ipv6_getsockopt(sk, level, optname, optval, optlen);
 #ifdef CONFIG_NETFILTER
 	/* we need to exclude all possible ENOPROTOOPTs except default case */
 	if (err =3D=3D -ENOPROTOOPT && optname !=3D IPV6_2292PKTOPTIONS) {
--=20
2.30.2

