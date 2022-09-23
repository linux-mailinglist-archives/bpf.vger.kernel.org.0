Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80AF5E860B
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 00:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiIWWsQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 18:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiIWWsP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 18:48:15 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED6112757E
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 15:48:14 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NM91RN001199
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 15:48:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=DRHfaWUXUvuXuvFFgYURqEyVC/6Ya/fIP5ChI7vwJE8=;
 b=kmfmHzFN9LcVB4T1LPB6iU+UWrqbRpDUAm+KY3KoWCHo/gLheMNJz6kvFyVMlsLmz8YX
 oyiJNnk0b+KUAC9tI6BTxu+Fn6SW9Za4gH/EzPYH4X09BmWW7VOqKHAgXWbIXARmSmm4
 vupnFYUg1xmvvYhK09eGDXSjlf0IYk82GTE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jsf8t37bf-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 15:48:14 -0700
Received: from twshared10425.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 15:48:10 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 264E09A4070C; Fri, 23 Sep 2022 15:45:25 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 5/5] selftests/bpf: Check -EBUSY for the recurred bpf_setsockopt(TCP_CONGESTION)
Date:   Fri, 23 Sep 2022 15:45:25 -0700
Message-ID: <20220923224525.2353722-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220923224453.2351753-1-kafai@fb.com>
References: <20220923224453.2351753-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Vp417AWQRt1M2DrBgC9QkASdG17QESLm
X-Proofpoint-GUID: Vp417AWQRt1M2DrBgC9QkASdG17QESLm
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

This patch changes the bpf_dctcp test to ensure the recurred
bpf_setsockopt(TCP_CONGESTION) returns -EBUSY.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  4 +++
 tools/testing/selftests/bpf/progs/bpf_dctcp.c | 25 +++++++++++++------
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/=
testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 2959a52ced06..e980188d4124 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -290,6 +290,10 @@ static void test_dctcp_fallback(void)
 		goto done;
 	ASSERT_STREQ(dctcp_skel->bss->cc_res, "cubic", "cc_res");
 	ASSERT_EQ(dctcp_skel->bss->tcp_cdg_res, -ENOTSUPP, "tcp_cdg_res");
+	/* All setsockopt(TCP_CONGESTION) in the recurred
+	 * bpf_dctcp->init() should fail with -EBUSY.
+	 */
+	ASSERT_EQ(dctcp_skel->bss->ebusy_cnt, 3, "ebusy_cnt");
=20
 	err =3D getsockopt(srv_fd, SOL_TCP, TCP_CONGESTION, srv_cc, &cc_len);
 	if (!ASSERT_OK(err, "getsockopt(srv_fd, TCP_CONGESTION)"))
diff --git a/tools/testing/selftests/bpf/progs/bpf_dctcp.c b/tools/testin=
g/selftests/bpf/progs/bpf_dctcp.c
index 9573be6122be..460682759aed 100644
--- a/tools/testing/selftests/bpf/progs/bpf_dctcp.c
+++ b/tools/testing/selftests/bpf/progs/bpf_dctcp.c
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 #include <linux/stddef.h>
 #include <linux/tcp.h>
+#include <errno.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include "bpf_tcp_helpers.h"
@@ -23,6 +24,7 @@ const char tcp_cdg[] =3D "cdg";
 char cc_res[TCP_CA_NAME_MAX];
 int tcp_cdg_res =3D 0;
 int stg_result =3D 0;
+int ebusy_cnt =3D 0;
=20
 struct {
 	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
@@ -64,16 +66,23 @@ void BPF_PROG(dctcp_init, struct sock *sk)
=20
 	if (!(tp->ecn_flags & TCP_ECN_OK) && fallback[0]) {
 		/* Switch to fallback */
-		bpf_setsockopt(sk, SOL_TCP, TCP_CONGESTION,
-			       (void *)fallback, sizeof(fallback));
-		/* Switch back to myself which the bpf trampoline
-		 * stopped calling dctcp_init recursively.
+		if (bpf_setsockopt(sk, SOL_TCP, TCP_CONGESTION,
+				   (void *)fallback, sizeof(fallback)) =3D=3D -EBUSY)
+			ebusy_cnt++;
+
+		/* Switch back to myself and the recurred dctcp_init()
+		 * will get -EBUSY for all bpf_setsockopt(TCP_CONGESTION),
+		 * except the last "cdg" one.
 		 */
-		bpf_setsockopt(sk, SOL_TCP, TCP_CONGESTION,
-			       (void *)bpf_dctcp, sizeof(bpf_dctcp));
+		if (bpf_setsockopt(sk, SOL_TCP, TCP_CONGESTION,
+				   (void *)bpf_dctcp, sizeof(bpf_dctcp)) =3D=3D -EBUSY)
+			ebusy_cnt++;
+
 		/* Switch back to fallback */
-		bpf_setsockopt(sk, SOL_TCP, TCP_CONGESTION,
-			       (void *)fallback, sizeof(fallback));
+		if (bpf_setsockopt(sk, SOL_TCP, TCP_CONGESTION,
+				   (void *)fallback, sizeof(fallback)) =3D=3D -EBUSY)
+			ebusy_cnt++;
+
 		/* Expecting -ENOTSUPP for tcp_cdg_res */
 		tcp_cdg_res =3D bpf_setsockopt(sk, SOL_TCP, TCP_CONGESTION,
 					     (void *)tcp_cdg, sizeof(tcp_cdg));
--=20
2.30.2

