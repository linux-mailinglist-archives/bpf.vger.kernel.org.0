Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4992253B07E
	for <lists+bpf@lfdr.de>; Thu,  2 Jun 2022 02:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbiFAXk5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jun 2022 19:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiFAXk4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jun 2022 19:40:56 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D36B21D3C8
        for <bpf@vger.kernel.org>; Wed,  1 Jun 2022 16:40:55 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 251NDxAm018757
        for <bpf@vger.kernel.org>; Wed, 1 Jun 2022 16:40:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=hcFB0HewA7WPH/OeywPf1gNL0nAuVMm9mbhN8BAH29c=;
 b=i8S42Bapnw+DpitXxAA0++AMy++PpC9iC1CwSlAyGcCqJwD6uaEFZRvFN+ejxdLJDilV
 F6iiiA3Fy1RsfszqCsVpS0+/1ZaujL59o+3wGtKvwAlvtezbPyTsRvqs6THmHGvv+lQu
 NSsAfroBvrMBMmgHN5Qz45QcDjRr4Hie4c4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gdbt6dhdj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 01 Jun 2022 16:40:54 -0700
Received: from twshared19572.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 1 Jun 2022 16:40:53 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 7EC45569C99A; Wed,  1 Jun 2022 16:40:50 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: Fix tc_redirect_dtime
Date:   Wed, 1 Jun 2022 16:40:50 -0700
Message-ID: <20220601234050.2572671-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GQQAsEQP0B563ljM2IJp4YRo7wPNferl
X-Proofpoint-GUID: GQQAsEQP0B563ljM2IJp4YRo7wPNferl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-01_09,2022-06-01_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

tc_redirect_dtime was reported flaky from time to time.  It
always fails at the udp test and complains about the bpf@tc-ingress
got a skb->tstamp when handling udp packet.  It is unexpected
because the skb->tstamp should have been cleared when crossing
different netns.

The most likely cause is that the skb is actually a tcp packet
from the earlier tcp test.  It could be the final TCP_FIN handling.

This patch tightens the skb->tstamp check in the bpf prog.  It ensures
the skb is the current testing traffic.  First, it checks that skb
matches the IPPROTO of the running test (i.e. tcp vs udp).
Second, it checks the server port (dst_ns_port).  The server
port is unique for each test (50000 + test_enum).

Also fixed a typo in test_udp_dtime(): s/P100/P101/

Fixes: c803475fd8dd ("bpf: selftests: test skb->tstamp in redirect_neigh"=
)
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 .../selftests/bpf/prog_tests/tc_redirect.c    |  8 +--
 .../selftests/bpf/progs/test_tc_dtime.c       | 53 ++++++++++++++++++-
 2 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools=
/testing/selftests/bpf/prog_tests/tc_redirect.c
index 958dae769c52..cb6a53b3e023 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -646,7 +646,7 @@ static void test_tcp_clear_dtime(struct test_tc_dtime=
 *skel)
 	__u32 *errs =3D skel->bss->errs[t];
=20
 	skel->bss->test =3D t;
-	test_inet_dtime(AF_INET6, SOCK_STREAM, IP6_DST, 0);
+	test_inet_dtime(AF_INET6, SOCK_STREAM, IP6_DST, 50000 + t);
=20
 	ASSERT_EQ(dtimes[INGRESS_FWDNS_P100], 0,
 		  dtime_cnt_str(t, INGRESS_FWDNS_P100));
@@ -683,7 +683,7 @@ static void test_tcp_dtime(struct test_tc_dtime *skel=
, int family, bool bpf_fwd)
 	errs =3D skel->bss->errs[t];
=20
 	skel->bss->test =3D t;
-	test_inet_dtime(family, SOCK_STREAM, addr, 0);
+	test_inet_dtime(family, SOCK_STREAM, addr, 50000 + t);
=20
 	/* fwdns_prio100 prog does not read delivery_time_type, so
 	 * kernel puts the (rcv) timetamp in __sk_buff->tstamp
@@ -715,13 +715,13 @@ static void test_udp_dtime(struct test_tc_dtime *sk=
el, int family, bool bpf_fwd)
 	errs =3D skel->bss->errs[t];
=20
 	skel->bss->test =3D t;
-	test_inet_dtime(family, SOCK_DGRAM, addr, 0);
+	test_inet_dtime(family, SOCK_DGRAM, addr, 50000 + t);
=20
 	ASSERT_EQ(dtimes[INGRESS_FWDNS_P100], 0,
 		  dtime_cnt_str(t, INGRESS_FWDNS_P100));
 	/* non mono delivery time is not forwarded */
 	ASSERT_EQ(dtimes[INGRESS_FWDNS_P101], 0,
-		  dtime_cnt_str(t, INGRESS_FWDNS_P100));
+		  dtime_cnt_str(t, INGRESS_FWDNS_P101));
 	for (i =3D EGRESS_FWDNS_P100; i < SET_DTIME; i++)
 		ASSERT_GT(dtimes[i], 0, dtime_cnt_str(t, i));
=20
diff --git a/tools/testing/selftests/bpf/progs/test_tc_dtime.c b/tools/te=
sting/selftests/bpf/progs/test_tc_dtime.c
index 06f300d06dbd..b596479a9ebe 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_dtime.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_dtime.c
@@ -11,6 +11,8 @@
 #include <linux/in.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
+#include <linux/tcp.h>
+#include <linux/udp.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 #include <sys/socket.h>
@@ -115,6 +117,19 @@ static bool bpf_fwd(void)
 	return test < TCP_IP4_RT_FWD;
 }
=20
+static __u8 get_proto(void)
+{
+	switch (test) {
+	case UDP_IP4:
+	case UDP_IP6:
+	case UDP_IP4_RT_FWD:
+	case UDP_IP6_RT_FWD:
+		return IPPROTO_UDP;
+	default:
+		return IPPROTO_TCP;
+	}
+}
+
 /* -1: parse error: TC_ACT_SHOT
  *  0: not testing traffic: TC_ACT_OK
  * >0: first byte is the inet_proto, second byte has the netns
@@ -122,11 +137,16 @@ static bool bpf_fwd(void)
  */
 static int skb_get_type(struct __sk_buff *skb)
 {
+	__u16 dst_ns_port =3D __bpf_htons(50000 + test);
 	void *data_end =3D ctx_ptr(skb->data_end);
 	void *data =3D ctx_ptr(skb->data);
 	__u8 inet_proto =3D 0, ns =3D 0;
 	struct ipv6hdr *ip6h;
+	__u16 sport, dport;
 	struct iphdr *iph;
+	struct tcphdr *th;
+	struct udphdr *uh;
+	void *trans;
=20
 	switch (skb->protocol) {
 	case __bpf_htons(ETH_P_IP):
@@ -138,6 +158,7 @@ static int skb_get_type(struct __sk_buff *skb)
 		else if (iph->saddr =3D=3D ip4_dst)
 			ns =3D DST_NS;
 		inet_proto =3D iph->protocol;
+		trans =3D iph + 1;
 		break;
 	case __bpf_htons(ETH_P_IPV6):
 		ip6h =3D data + sizeof(struct ethhdr);
@@ -148,15 +169,43 @@ static int skb_get_type(struct __sk_buff *skb)
 		else if (v6_equal(ip6h->saddr, (struct in6_addr)ip6_dst))
 			ns =3D DST_NS;
 		inet_proto =3D ip6h->nexthdr;
+		trans =3D ip6h + 1;
 		break;
 	default:
 		return 0;
 	}
=20
-	if ((inet_proto !=3D IPPROTO_TCP && inet_proto !=3D IPPROTO_UDP) || !ns=
)
+	/* skb is not from src_ns or dst_ns.
+	 * skb is not the testing IPPROTO.
+	 */
+	if (!ns || inet_proto !=3D get_proto())
 		return 0;
=20
-	return (ns << 8 | inet_proto);
+	switch (inet_proto) {
+	case IPPROTO_TCP:
+		th =3D trans;
+		if (th + 1 > data_end)
+			return -1;
+		sport =3D th->source;
+		dport =3D th->dest;
+		break;
+	case IPPROTO_UDP:
+		uh =3D trans;
+		if (uh + 1 > data_end)
+			return -1;
+		sport =3D uh->source;
+		dport =3D uh->dest;
+		break;
+	default:
+		return 0;
+	}
+
+	/* The skb is the testing traffic */
+	if ((ns =3D=3D SRC_NS && dport =3D=3D dst_ns_port) ||
+	    (ns =3D=3D DST_NS && sport =3D=3D dst_ns_port))
+		return (ns << 8 | inet_proto);
+
+	return 0;
 }
=20
 /* format: direction@iface@netns
--=20
2.30.2

