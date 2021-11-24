Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D8D45B0B0
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 01:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbhKXA1K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 23 Nov 2021 19:27:10 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:13210 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233792AbhKXA1I (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Nov 2021 19:27:08 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ANMepmh031233
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 16:23:58 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3ch0wp4fnc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 16:23:58 -0800
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 16:23:56 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 29951A666AF3; Tue, 23 Nov 2021 16:23:54 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 13/13] selftests/bpf: fix misaligned accesses in xdp and xdp_bpf2bpf tests
Date:   Tue, 23 Nov 2021 16:23:25 -0800
Message-ID: <20211124002325.1737739-14-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124002325.1737739-1-andrii@kernel.org>
References: <20211124002325.1737739-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: xFNqqkNDuQVHIDlGFKsSbo7nX2RLDuIz
X-Proofpoint-GUID: xFNqqkNDuQVHIDlGFKsSbo7nX2RLDuIz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_08,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=917 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111240000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similar to previous patch, just copy over necessary struct into local
stack variable before checking its fields.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/xdp.c         | 11 ++++++-----
 tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c |  6 +++---
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp.c b/tools/testing/selftests/bpf/prog_tests/xdp.c
index 7a7ef9d4e151..ac65456b7ab8 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp.c
@@ -11,8 +11,8 @@ void test_xdp(void)
 	const char *file = "./test_xdp.o";
 	struct bpf_object *obj;
 	char buf[128];
-	struct ipv6hdr *iph6 = (void *)buf + sizeof(struct ethhdr);
-	struct iphdr *iph = (void *)buf + sizeof(struct ethhdr);
+	struct ipv6hdr iph6;
+	struct iphdr iph;
 	__u32 duration, retval, size;
 	int err, prog_fd, map_fd;
 
@@ -28,16 +28,17 @@ void test_xdp(void)
 
 	err = bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
 				buf, &size, &retval, &duration);
-
+	memcpy(&iph, buf + sizeof(struct ethhdr), sizeof(iph));
 	CHECK(err || retval != XDP_TX || size != 74 ||
-	      iph->protocol != IPPROTO_IPIP, "ipv4",
+	      iph.protocol != IPPROTO_IPIP, "ipv4",
 	      "err %d errno %d retval %d size %d\n",
 	      err, errno, retval, size);
 
 	err = bpf_prog_test_run(prog_fd, 1, &pkt_v6, sizeof(pkt_v6),
 				buf, &size, &retval, &duration);
+	memcpy(&iph6, buf + sizeof(struct ethhdr), sizeof(iph6));
 	CHECK(err || retval != XDP_TX || size != 114 ||
-	      iph6->nexthdr != IPPROTO_IPV6, "ipv6",
+	      iph6.nexthdr != IPPROTO_IPV6, "ipv6",
 	      "err %d errno %d retval %d size %d\n",
 	      err, errno, retval, size);
 out:
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
index f99386d1dc4c..c98a897ad692 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
@@ -42,7 +42,7 @@ void test_xdp_bpf2bpf(void)
 	char buf[128];
 	int err, pkt_fd, map_fd;
 	bool passed = false;
-	struct iphdr *iph = (void *)buf + sizeof(struct ethhdr);
+	struct iphdr iph;
 	struct iptnl_info value4 = {.family = AF_INET};
 	struct test_xdp *pkt_skel = NULL;
 	struct test_xdp_bpf2bpf *ftrace_skel = NULL;
@@ -93,9 +93,9 @@ void test_xdp_bpf2bpf(void)
 	/* Run test program */
 	err = bpf_prog_test_run(pkt_fd, 1, &pkt_v4, sizeof(pkt_v4),
 				buf, &size, &retval, &duration);
-
+	memcpy(&iph, buf + sizeof(struct ethhdr), sizeof(iph));
 	if (CHECK(err || retval != XDP_TX || size != 74 ||
-		  iph->protocol != IPPROTO_IPIP, "ipv4",
+		  iph.protocol != IPPROTO_IPIP, "ipv4",
 		  "err %d errno %d retval %d size %d\n",
 		  err, errno, retval, size))
 		goto out;
-- 
2.30.2

