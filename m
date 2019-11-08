Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73C1FF40A1
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2019 07:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbfKHGlV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 8 Nov 2019 01:41:21 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43330 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727620AbfKHGlS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 8 Nov 2019 01:41:18 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA86eNWl029102
        for <bpf@vger.kernel.org>; Thu, 7 Nov 2019 22:41:17 -0800
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2w41un9ryk-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2019 22:41:17 -0800
Received: from 2401:db00:2120:81ca:face:0:31:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 7 Nov 2019 22:41:15 -0800
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 1B2AA760F61; Thu,  7 Nov 2019 22:41:14 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <x86@kernel.org>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 bpf-next 17/18] selftests/bpf: Extend test_pkt_access test
Date:   Thu, 7 Nov 2019 22:40:38 -0800
Message-ID: <20191108064039.2041889-18-ast@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108064039.2041889-1-ast@kernel.org>
References: <20191108064039.2041889-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-08_01:2019-11-07,2019-11-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 bulkscore=0
 mlxscore=0 spamscore=0 suspectscore=1 impostorscore=0 mlxlogscore=848
 lowpriorityscore=0 clxscore=1034 malwarescore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911080065
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The test_pkt_access.o is used by multiple tests. Fix its section name so that
program type can be automatically detected by libbpf and make it call other
subprograms with skb argument.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/test_pkt_access.c     | 38 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_pkt_access.c b/tools/testing/selftests/bpf/progs/test_pkt_access.c
index 7cf42d14103f..3a7b4b607ed3 100644
--- a/tools/testing/selftests/bpf/progs/test_pkt_access.c
+++ b/tools/testing/selftests/bpf/progs/test_pkt_access.c
@@ -17,8 +17,38 @@
 #define barrier() __asm__ __volatile__("": : :"memory")
 int _version SEC("version") = 1;
 
-SEC("test1")
-int process(struct __sk_buff *skb)
+/* llvm will optimize both subprograms into exactly the same BPF assembly
+ *
+ * Disassembly of section .text:
+ *
+ * 0000000000000000 test_pkt_access_subprog1:
+ * ; 	return skb->len * 2;
+ *        0:	61 10 00 00 00 00 00 00	r0 = *(u32 *)(r1 + 0)
+ *        1:	64 00 00 00 01 00 00 00	w0 <<= 1
+ *        2:	95 00 00 00 00 00 00 00	exit
+ *
+ * 0000000000000018 test_pkt_access_subprog2:
+ * ; 	return skb->len * val;
+ *        3:	61 10 00 00 00 00 00 00	r0 = *(u32 *)(r1 + 0)
+ *        4:	64 00 00 00 01 00 00 00	w0 <<= 1
+ *        5:	95 00 00 00 00 00 00 00	exit
+ *
+ * Which makes it an interesting test for BTF-enabled verifier.
+ */
+static __attribute__ ((noinline))
+int test_pkt_access_subprog1(volatile struct __sk_buff *skb)
+{
+	return skb->len * 2;
+}
+
+static __attribute__ ((noinline))
+int test_pkt_access_subprog2(int val, volatile struct __sk_buff *skb)
+{
+	return skb->len * val;
+}
+
+SEC("classifier/test_pkt_access")
+int test_pkt_access(struct __sk_buff *skb)
 {
 	void *data_end = (void *)(long)skb->data_end;
 	void *data = (void *)(long)skb->data;
@@ -48,6 +78,10 @@ int process(struct __sk_buff *skb)
 		tcp = (struct tcphdr *)((void *)(ip6h) + ihl_len);
 	}
 
+	if (test_pkt_access_subprog1(skb) != skb->len * 2)
+		return TC_ACT_SHOT;
+	if (test_pkt_access_subprog2(2, skb) != skb->len * 2)
+		return TC_ACT_SHOT;
 	if (tcp) {
 		if (((void *)(tcp) + 20) > data_end || proto != 6)
 			return TC_ACT_SHOT;
-- 
2.23.0

