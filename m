Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73ED55AA477
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 02:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbiIBAbu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 20:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbiIBAbq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 20:31:46 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8584054A
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 17:31:43 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28208o7F028343
        for <bpf@vger.kernel.org>; Thu, 1 Sep 2022 17:31:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=p/LundHZj1RUWWHQniNqfc3qDJLYMWph1tMN+59HhIw=;
 b=lBOxD/ffOMauJBlmWeRjc7g3yonR+e2hI3HzM326gUjQAHdlaRCRahmC9gvQKCG7Q4sG
 GXdL6MTRzdKngdJPx32pYMR0HkQdNZc30qf944Jd56r0aUy54/c8OH/SojUHIxBLOBOk
 4iGgXEHH2fc5I+aY8cQrYHVldA010lHkEoM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jaf2n0pnu-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 01 Sep 2022 17:31:43 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub104.TheFacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 17:31:41 -0700
Received: from twshared25017.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 17:31:40 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 055548C47B6E; Thu,  1 Sep 2022 17:28:47 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 09/17] net: Add a len argument to compat_ipv6_get_msfilter()
Date:   Thu, 1 Sep 2022 17:28:46 -0700
Message-ID: <20220902002846.2892091-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220902002750.2887415-1-kafai@fb.com>
References: <20220902002750.2887415-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 9YvmYoAvnThxlIJ8mU6igcsODRzX0Epx
X-Proofpoint-ORIG-GUID: 9YvmYoAvnThxlIJ8mU6igcsODRzX0Epx
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

Pass the len to the compat_ipv6_get_msfilter() instead of
compat_ipv6_get_msfilter() getting it again from optlen.
Its counter part ipv6_get_msfilter() is also taking the
len from do_ipv6_getsockopt().

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 net/ipv6/ipv6_sockglue.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 2894271c2c08..4ab284a4adf8 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -1093,17 +1093,15 @@ static int ipv6_get_msfilter(struct sock *sk, voi=
d __user *optval,
 }
=20
 static int compat_ipv6_get_msfilter(struct sock *sk, void __user *optval=
,
-		int __user *optlen)
+		int __user *optlen, int len)
 {
 	const int size0 =3D offsetof(struct compat_group_filter, gf_slist_flex)=
;
 	struct compat_group_filter __user *p =3D optval;
 	struct compat_group_filter gf32;
 	struct group_filter gf;
-	int len, err;
+	int err;
 	int num;
=20
-	if (get_user(len, optlen))
-		return -EFAULT;
 	if (len < size0)
 		return -EINVAL;
=20
@@ -1156,7 +1154,7 @@ static int do_ipv6_getsockopt(struct sock *sk, int =
level, int optname,
 		break;
 	case MCAST_MSFILTER:
 		if (in_compat_syscall())
-			return compat_ipv6_get_msfilter(sk, optval, optlen);
+			return compat_ipv6_get_msfilter(sk, optval, optlen, len);
 		return ipv6_get_msfilter(sk, optval, optlen, len);
 	case IPV6_2292PKTOPTIONS:
 	{
--=20
2.30.2

