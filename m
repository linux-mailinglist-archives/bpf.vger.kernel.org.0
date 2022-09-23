Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98A75E8609
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 00:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbiIWWsN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 18:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbiIWWsM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 18:48:12 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BFDAF4B5
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 15:48:11 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NM91RC001199
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 15:48:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=x4Cv6lbYHG9ROYs/8OMrPXB3vbyGKY23tmA4A9L+XXo=;
 b=FJ6Z/m0IQhmcPbeOqxtEK0xlSWD+ZXwmo3Uz77vbT2sEYLusTLZwwnIuTlT/XDe2JMpo
 MNzBNpwqh2lOdsHfL/WCnC73gyBvQL9LdoEocec7Nsy8zxnHX2zisaqVVtF8f21Zni5O
 Xe3y/get2ENzJCGWJLLMCeFAaI3kgpZr8SY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jsf8t37bf-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 15:48:10 -0700
Received: from twshared10425.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 15:48:09 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 264509A406DC; Fri, 23 Sep 2022 15:45:12 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 3/5] bpf: Refactor bpf_setsockopt(TCP_CONGESTION) handling into another function
Date:   Fri, 23 Sep 2022 15:45:12 -0700
Message-ID: <20220923224512.2353244-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220923224453.2351753-1-kafai@fb.com>
References: <20220923224453.2351753-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: l2CS743Usq68T4uMR4LXDIEFGTOnAFAx
X-Proofpoint-GUID: l2CS743Usq68T4uMR4LXDIEFGTOnAFAx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_10,2022-09-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch moves the bpf_setsockopt(TCP_CONGESTION) logic into
another function.  The next patch will add extra logic to avoid
recursion and this will make the latter patch easier to follow.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 net/core/filter.c | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index f4cea3ff994a..96f2f7a65e65 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5102,6 +5102,33 @@ static int bpf_sol_tcp_setsockopt(struct sock *sk,=
 int optname,
 	return 0;
 }
=20
+static int sol_tcp_sockopt_congestion(struct sock *sk, char *optval,
+				      int *optlen, bool getopt)
+{
+	if (*optlen < 2)
+		return -EINVAL;
+
+	if (getopt) {
+		if (!inet_csk(sk)->icsk_ca_ops)
+			return -EINVAL;
+		/* BPF expects NULL-terminated tcp-cc string */
+		optval[--(*optlen)] =3D '\0';
+		return do_tcp_getsockopt(sk, SOL_TCP, TCP_CONGESTION,
+					 KERNEL_SOCKPTR(optval),
+					 KERNEL_SOCKPTR(optlen));
+	}
+
+	/* "cdg" is the only cc that alloc a ptr
+	 * in inet_csk_ca area.  The bpf-tcp-cc may
+	 * overwrite this ptr after switching to cdg.
+	 */
+	if (*optlen >=3D sizeof("cdg") - 1 && !strncmp("cdg", optval, *optlen))
+		return -ENOTSUPP;
+
+	return do_tcp_setsockopt(sk, SOL_TCP, TCP_CONGESTION,
+				KERNEL_SOCKPTR(optval), *optlen);
+}
+
 static int sol_tcp_sockopt(struct sock *sk, int optname,
 			   char *optval, int *optlen,
 			   bool getopt)
@@ -5125,16 +5152,7 @@ static int sol_tcp_sockopt(struct sock *sk, int op=
tname,
 			return -EINVAL;
 		break;
 	case TCP_CONGESTION:
-		if (*optlen < 2)
-			return -EINVAL;
-		/* "cdg" is the only cc that alloc a ptr
-		 * in inet_csk_ca area.  The bpf-tcp-cc may
-		 * overwrite this ptr after switching to cdg.
-		 */
-		if (!getopt && *optlen >=3D sizeof("cdg") - 1 &&
-		    !strncmp("cdg", optval, *optlen))
-			return -ENOTSUPP;
-		break;
+		return sol_tcp_sockopt_congestion(sk, optval, optlen, getopt);
 	case TCP_SAVED_SYN:
 		if (*optlen < 1)
 			return -EINVAL;
@@ -5159,13 +5177,6 @@ static int sol_tcp_sockopt(struct sock *sk, int op=
tname,
 			return 0;
 		}
=20
-		if (optname =3D=3D TCP_CONGESTION) {
-			if (!inet_csk(sk)->icsk_ca_ops)
-				return -EINVAL;
-			/* BPF expects NULL-terminated tcp-cc string */
-			optval[--(*optlen)] =3D '\0';
-		}
-
 		return do_tcp_getsockopt(sk, SOL_TCP, optname,
 					 KERNEL_SOCKPTR(optval),
 					 KERNEL_SOCKPTR(optlen));
--=20
2.30.2

