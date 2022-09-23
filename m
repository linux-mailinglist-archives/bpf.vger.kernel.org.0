Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C895E8608
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 00:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiIWWsK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 18:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiIWWsJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 18:48:09 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CFDAF0DC
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 15:48:08 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 28NM8wPe021099
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 15:48:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=N7DaUqXLRK9CHN/e3+UHlB9NxAW8df9FBbJug88H3+Q=;
 b=lM2tmRj6RbHZuKs5lugFBrUyMc9paopQ/vfeAWRLg9NjJBd6ncOla0a3fPP+/ITZF9ZW
 AsisNeAuPCDdwVoou02u0Jmy2r13zhkU1O9CnMHOamKofvCpPn5efErCdDmn3/2qDMf4
 O8lvmcAERwv4/fI/txFPZSKJh47Sr/3V5Oc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3jshcst26d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 15:48:07 -0700
Received: from twshared25017.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 15:48:05 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id CB1E99A406E9; Fri, 23 Sep 2022 15:45:18 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 4/5] bpf: tcp: Stop bpf_setsockopt(TCP_CONGESTION) in init ops to recur itself
Date:   Fri, 23 Sep 2022 15:45:18 -0700
Message-ID: <20220923224518.2353383-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220923224453.2351753-1-kafai@fb.com>
References: <20220923224453.2351753-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: CEFX9f_Q6j32dNVDVIcqeuOvUzM0RSuN
X-Proofpoint-GUID: CEFX9f_Q6j32dNVDVIcqeuOvUzM0RSuN
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

When a bad bpf prog '.init' calls
bpf_setsockopt(TCP_CONGESTION, "itself"), it will trigger this loop:

.init =3D> bpf_setsockopt(tcp_cc) =3D> .init =3D> bpf_setsockopt(tcp_cc) =
...
... =3D> .init =3D> bpf_setsockopt(tcp_cc).

It was prevented by the prog->active counter before but the prog->active
detection cannot be used in struct_ops as explained in the earlier
patch of the set.

In this patch, the second bpf_setsockopt(tcp_cc) is not allowed
in order to break the loop.  This is done by using a bit of
an existing 1 byte hole in tcp_sock to check if there is
on-going bpf_setsockopt(TCP_CONGESTION) in this tcp_sock.

Note that this essentially limits only the first '.init' can
call bpf_setsockopt(TCP_CONGESTION) to pick a fallback cc (eg. peer
does not support ECN) and the second '.init' cannot fallback to
another cc.  This applies even the second
bpf_setsockopt(TCP_CONGESTION) will not cause a loop.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/tcp.h |  6 ++++++
 net/core/filter.c   | 28 +++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index a9fbe22732c3..3bdf687e2fb3 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -388,6 +388,12 @@ struct tcp_sock {
 	u8	bpf_sock_ops_cb_flags;  /* Control calling BPF programs
 					 * values defined in uapi/linux/tcp.h
 					 */
+	u8	bpf_chg_cc_inprogress:1; /* In the middle of
+					  * bpf_setsockopt(TCP_CONGESTION),
+					  * it is to avoid the bpf_tcp_cc->init()
+					  * to recur itself by calling
+					  * bpf_setsockopt(TCP_CONGESTION, "itself").
+					  */
 #define BPF_SOCK_OPS_TEST_FLAG(TP, ARG) (TP->bpf_sock_ops_cb_flags & ARG=
)
 #else
 #define BPF_SOCK_OPS_TEST_FLAG(TP, ARG) 0
diff --git a/net/core/filter.c b/net/core/filter.c
index 96f2f7a65e65..ac4c45c02da5 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5105,6 +5105,9 @@ static int bpf_sol_tcp_setsockopt(struct sock *sk, =
int optname,
 static int sol_tcp_sockopt_congestion(struct sock *sk, char *optval,
 				      int *optlen, bool getopt)
 {
+	struct tcp_sock *tp;
+	int ret;
+
 	if (*optlen < 2)
 		return -EINVAL;
=20
@@ -5125,8 +5128,31 @@ static int sol_tcp_sockopt_congestion(struct sock =
*sk, char *optval,
 	if (*optlen >=3D sizeof("cdg") - 1 && !strncmp("cdg", optval, *optlen))
 		return -ENOTSUPP;
=20
-	return do_tcp_setsockopt(sk, SOL_TCP, TCP_CONGESTION,
+	/* It stops this looping
+	 *
+	 * .init =3D> bpf_setsockopt(tcp_cc) =3D> .init =3D>
+	 * bpf_setsockopt(tcp_cc)" =3D> .init =3D> ....
+	 *
+	 * The second bpf_setsockopt(tcp_cc) is not allowed
+	 * in order to break the loop when both .init
+	 * are the same bpf prog.
+	 *
+	 * This applies even the second bpf_setsockopt(tcp_cc)
+	 * does not cause a loop.  This limits only the first
+	 * '.init' can call bpf_setsockopt(TCP_CONGESTION) to
+	 * pick a fallback cc (eg. peer does not support ECN)
+	 * and the second '.init' cannot fallback to
+	 * another.
+	 */
+	tp =3D tcp_sk(sk);
+	if (tp->bpf_chg_cc_inprogress)
+		return -EBUSY;
+
+	tp->bpf_chg_cc_inprogress =3D 1;
+	ret =3D do_tcp_setsockopt(sk, SOL_TCP, TCP_CONGESTION,
 				KERNEL_SOCKPTR(optval), *optlen);
+	tp->bpf_chg_cc_inprogress =3D 0;
+	return ret;
 }
=20
 static int sol_tcp_sockopt(struct sock *sk, int optname,
--=20
2.30.2

