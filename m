Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E1C45B0AD
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 01:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbhKXA1E convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 23 Nov 2021 19:27:04 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57716 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233523AbhKXA1D (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Nov 2021 19:27:03 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ANMf4o3010318
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 16:23:54 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3ch0wxcgv3-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 16:23:54 -0800
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 16:23:50 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id EEC5DA666ACF; Tue, 23 Nov 2021 16:23:47 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 10/13] selftests/bpf: fix misaligned memory access in queue_stack_map test
Date:   Tue, 23 Nov 2021 16:23:22 -0800
Message-ID: <20211124002325.1737739-11-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124002325.1737739-1-andrii@kernel.org>
References: <20211124002325.1737739-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: dpLBuyJSzU0non8VOZBzArJ78Fh6FRG8
X-Proofpoint-ORIG-GUID: dpLBuyJSzU0non8VOZBzArJ78Fh6FRG8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_08,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111240000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Copy over iphdr into a local variable before accessing its fields.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/queue_stack_map.c       | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
index 8ccba3ab70ee..b9822f914eeb 100644
--- a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
@@ -14,7 +14,7 @@ static void test_queue_stack_map_by_type(int type)
 	int i, err, prog_fd, map_in_fd, map_out_fd;
 	char file[32], buf[128];
 	struct bpf_object *obj;
-	struct iphdr *iph = (void *)buf + sizeof(struct ethhdr);
+	struct iphdr iph;
 
 	/* Fill test values to be used */
 	for (i = 0; i < MAP_SIZE; i++)
@@ -60,15 +60,17 @@ static void test_queue_stack_map_by_type(int type)
 
 		err = bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
 					buf, &size, &retval, &duration);
-		if (err || retval || size != sizeof(pkt_v4) ||
-		    iph->daddr != val)
+		if (err || retval || size != sizeof(pkt_v4))
+			break;
+		memcpy(&iph, buf + sizeof(struct ethhdr), sizeof(iph));
+		if (iph.daddr != val)
 			break;
 	}
 
-	CHECK(err || retval || size != sizeof(pkt_v4) || iph->daddr != val,
+	CHECK(err || retval || size != sizeof(pkt_v4) || iph.daddr != val,
 	      "bpf_map_pop_elem",
 	      "err %d errno %d retval %d size %d iph->daddr %u\n",
-	      err, errno, retval, size, iph->daddr);
+	      err, errno, retval, size, iph.daddr);
 
 	/* Queue is empty, program should return TC_ACT_SHOT */
 	err = bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
-- 
2.30.2

