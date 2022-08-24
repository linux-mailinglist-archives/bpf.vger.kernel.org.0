Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A59D5A0400
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 00:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiHXWaN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 18:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiHXWaM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 18:30:12 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62A865C2
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:30:10 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27OMHADB017364
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:30:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=7ypEhdvInI8vBdbht12x7g14MPR4o3Ooue6kh2vYWWo=;
 b=AuyKw9xaVoFmgByDBCKpq6Xii/lG10KfkoOCNW7nrzyr8k34P2Cb5m3kx0isPauvvqhe
 b4ByhnInqci0mH7m9Bp8FktL+chUE+gS2MyAzHN+bHj7ETUY6M7v1YLNF08YeKyrRwGY
 bHjcGKJKgJPv4KtMCk10WeV2KaNkVbchFsA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3j4x1yvje9-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:30:10 -0700
Received: from twshared32421.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 15:30:08 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id C9729871C989; Wed, 24 Aug 2022 15:26:58 -0700 (PDT)
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
Subject: [PATCH bpf-next 09/17] net: Add a len argument to compat_ipv6_get_msfilter()
Date:   Wed, 24 Aug 2022 15:26:58 -0700
Message-ID: <20220824222658.1921440-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220824222601.1916776-1-kafai@fb.com>
References: <20220824222601.1916776-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: LvLx3ShXXKuF3PPaDCevsizjK7H5-sRX
X-Proofpoint-ORIG-GUID: LvLx3ShXXKuF3PPaDCevsizjK7H5-sRX
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

Pass the len to the compat_ipv6_get_msfilter() instead of
compat_ipv6_get_msfilter() getting it again from optlen.
Its counter part ipv6_get_msfilter() is also taking the
len from do_ipv6_getsockopt().

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
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

