Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39EE8F2762
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2019 06:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfKGFrz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 7 Nov 2019 00:47:55 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32828 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727079AbfKGFrz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 Nov 2019 00:47:55 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA75j9l3001044
        for <bpf@vger.kernel.org>; Wed, 6 Nov 2019 21:47:55 -0800
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2w41ue3fwa-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Nov 2019 21:47:54 -0800
Received: from 2401:db00:2120:80e1:face:0:29:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 6 Nov 2019 21:47:17 -0800
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id DAD45760BC0; Wed,  6 Nov 2019 21:47:14 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <x86@kernel.org>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 15/17] selftests/bpf: Extend test_pkt_access test
Date:   Wed, 6 Nov 2019 21:46:42 -0800
Message-ID: <20191107054644.1285697-16-ast@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191107054644.1285697-1-ast@kernel.org>
References: <20191107054644.1285697-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_09:2019-11-06,2019-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 clxscore=1034 malwarescore=0 mlxlogscore=839 suspectscore=1 adultscore=0
 mlxscore=0 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911070060
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The test_pkt_access.o is used by multiple tests. Fix its section name so that
program type can be automatically detected by libbpf and make it call another
subprogram with skb argument.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/progs/test_pkt_access.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_pkt_access.c b/tools/testing/selftests/bpf/progs/test_pkt_access.c
index 7cf42d14103f..9aaee1400c1e 100644
--- a/tools/testing/selftests/bpf/progs/test_pkt_access.c
+++ b/tools/testing/selftests/bpf/progs/test_pkt_access.c
@@ -17,8 +17,14 @@
 #define barrier() __asm__ __volatile__("": : :"memory")
 int _version SEC("version") = 1;
 
-SEC("test1")
-int process(struct __sk_buff *skb)
+static __attribute__ ((noinline))
+int test_pkt_access_subprog(volatile struct __sk_buff *skb)
+{
+	return skb->len * 2;
+}
+
+SEC("classifier/test_pkt_access")
+int test_pkt_access(struct __sk_buff *skb)
 {
 	void *data_end = (void *)(long)skb->data_end;
 	void *data = (void *)(long)skb->data;
@@ -48,6 +54,8 @@ int process(struct __sk_buff *skb)
 		tcp = (struct tcphdr *)((void *)(ip6h) + ihl_len);
 	}
 
+	if (test_pkt_access_subprog(skb) != skb->len * 2)
+		return TC_ACT_SHOT;
 	if (tcp) {
 		if (((void *)(tcp) + 20) > data_end || proto != 6)
 			return TC_ACT_SHOT;
-- 
2.23.0

