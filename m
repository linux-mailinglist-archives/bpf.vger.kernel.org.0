Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C39C45B0AE
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 01:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbhKXA1F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 23 Nov 2021 19:27:05 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29584 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233523AbhKXA1F (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Nov 2021 19:27:05 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ANMf6JS004999
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 16:23:56 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3ch3jak6t0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 16:23:56 -0800
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 16:23:54 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 135F2A666AEF; Tue, 23 Nov 2021 16:23:52 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 12/13] selftests/bpf: fix misaligned memory accesses in xdp_bonding test
Date:   Tue, 23 Nov 2021 16:23:24 -0800
Message-ID: <20211124002325.1737739-13-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124002325.1737739-1-andrii@kernel.org>
References: <20211124002325.1737739-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: TZzeBVgYlGdiE0J38AC_6in9i6QdWxko
X-Proofpoint-GUID: TZzeBVgYlGdiE0J38AC_6in9i6QdWxko
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_08,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 spamscore=0 clxscore=1034 malwarescore=0 suspectscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111240000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Construct packet buffer explicitly for each packet to avoid unaligned
memory accesses.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/xdp_bonding.c    | 36 ++++++++++---------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
index faa22b84f2ee..5e3a26b15ec6 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
@@ -218,9 +218,9 @@ static int send_udp_packets(int vary_dst_ip)
 		.h_dest = BOND2_MAC,
 		.h_proto = htons(ETH_P_IP),
 	};
-	uint8_t buf[128] = {};
-	struct iphdr *iph = (struct iphdr *)(buf + sizeof(eh));
-	struct udphdr *uh = (struct udphdr *)(buf + sizeof(eh) + sizeof(*iph));
+	struct iphdr iph = {};
+	struct udphdr uh = {};
+	uint8_t buf[128];
 	int i, s = -1;
 	int ifindex;
 
@@ -232,17 +232,16 @@ static int send_udp_packets(int vary_dst_ip)
 	if (!ASSERT_GT(ifindex, 0, "get bond1 ifindex"))
 		goto err;
 
-	memcpy(buf, &eh, sizeof(eh));
-	iph->ihl = 5;
-	iph->version = 4;
-	iph->tos = 16;
-	iph->id = 1;
-	iph->ttl = 64;
-	iph->protocol = IPPROTO_UDP;
-	iph->saddr = 1;
-	iph->daddr = 2;
-	iph->tot_len = htons(sizeof(buf) - ETH_HLEN);
-	iph->check = 0;
+	iph.ihl = 5;
+	iph.version = 4;
+	iph.tos = 16;
+	iph.id = 1;
+	iph.ttl = 64;
+	iph.protocol = IPPROTO_UDP;
+	iph.saddr = 1;
+	iph.daddr = 2;
+	iph.tot_len = htons(sizeof(buf) - ETH_HLEN);
+	iph.check = 0;
 
 	for (i = 1; i <= NPACKETS; i++) {
 		int n;
@@ -253,10 +252,15 @@ static int send_udp_packets(int vary_dst_ip)
 		};
 
 		/* vary the UDP destination port for even distribution with roundrobin/xor modes */
-		uh->dest++;
+		uh.dest++;
 
 		if (vary_dst_ip)
-			iph->daddr++;
+			iph.daddr++;
+
+		/* construct a packet */
+		memcpy(buf, &eh, sizeof(eh));
+		memcpy(buf + sizeof(eh), &iph, sizeof(iph));
+		memcpy(buf + sizeof(eh) + sizeof(iph), &uh, sizeof(uh));
 
 		n = sendto(s, buf, sizeof(buf), 0, (struct sockaddr *)&saddr_ll, sizeof(saddr_ll));
 		if (!ASSERT_EQ(n, sizeof(buf), "sendto"))
-- 
2.30.2

