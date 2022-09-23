Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707EA5E860A
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 00:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbiIWWsP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 18:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiIWWsO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 18:48:14 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8845E313
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 15:48:13 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NM91RH001199
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 15:48:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=tWjdpDfLvXhmiu5oXo73H9zGE0MjJCKQaEepAtyFAJw=;
 b=BYa3leb0QQEQh8rt80uX5bndVBvrtXNlKPn1jucvjL+8IIGwrrPhb9tWgaKUXghUDxKy
 At6lS5HrQ0ETH9JeDRz9KzmYiT177H6wNc1Uc+ChCdUR1BnJH5SdeccFaXdSHL/asaZN
 ZurU/QCcQRLMiSr0LBfkLAPg04hOwBcej9Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jsf8t37bf-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 15:48:12 -0700
Received: from twshared3307.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 15:48:10 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id B8C7F9A406C7; Fri, 23 Sep 2022 15:45:05 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 2/5] bpf: Move the "cdg" tcp-cc check to the common sol_tcp_sockopt()
Date:   Fri, 23 Sep 2022 15:45:05 -0700
Message-ID: <20220923224505.2352542-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220923224453.2351753-1-kafai@fb.com>
References: <20220923224453.2351753-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: rjgJF77gO0XdaPQx5HelcibJDBVdWfAs
X-Proofpoint-GUID: rjgJF77gO0XdaPQx5HelcibJDBVdWfAs
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

The check on the tcp-cc, "cdg", is done in the bpf_sk_setsockopt which is
used by the bpf_tcp_ca, bpf_lsm, cg_sockopt, and tcp_iter hooks.
However, it is not done for cg sock_ddr, cg sockops, and some of
the bpf_lsm_cgroup hooks.

The tcp-cc "cdg" should have very limited usage.  This patch is to
move the "cdg" check to the common sol_tcp_sockopt() so that all
hooks have a consistent behavior.   The motivation to make
this check consistent now is because the latter patch will
refactor the bpf_setsockopt(TCP_CONGESTION) into another function,
so it is better to take this chance to refactor this piece
also.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 net/core/filter.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 2fd9449026aa..f4cea3ff994a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5127,6 +5127,13 @@ static int sol_tcp_sockopt(struct sock *sk, int op=
tname,
 	case TCP_CONGESTION:
 		if (*optlen < 2)
 			return -EINVAL;
+		/* "cdg" is the only cc that alloc a ptr
+		 * in inet_csk_ca area.  The bpf-tcp-cc may
+		 * overwrite this ptr after switching to cdg.
+		 */
+		if (!getopt && *optlen >=3D sizeof("cdg") - 1 &&
+		    !strncmp("cdg", optval, *optlen))
+			return -ENOTSUPP;
 		break;
 	case TCP_SAVED_SYN:
 		if (*optlen < 1)
@@ -5285,12 +5292,6 @@ static int _bpf_getsockopt(struct sock *sk, int le=
vel, int optname,
 BPF_CALL_5(bpf_sk_setsockopt, struct sock *, sk, int, level,
 	   int, optname, char *, optval, int, optlen)
 {
-	if (level =3D=3D SOL_TCP && optname =3D=3D TCP_CONGESTION) {
-		if (optlen >=3D sizeof("cdg") - 1 &&
-		    !strncmp("cdg", optval, optlen))
-			return -ENOTSUPP;
-	}
-
 	return _bpf_setsockopt(sk, level, optname, optval, optlen);
 }
=20
--=20
2.30.2

