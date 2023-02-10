Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C47691533
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 01:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjBJANK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 19:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjBJANI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 19:13:08 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF675EA0A
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 16:13:06 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319NmfX1015474;
        Fri, 10 Feb 2023 00:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zkwKmj/jc8+NbTxLZY8iY9Mf3+Z25OFdx7Xu0pkhO70=;
 b=KjLj7LvTq0tYbNgNpO2rmNqzhPd16ugQbLqbuPRX5Ssy0OfBUzf5yL4UM/eSJ+Wv5w9l
 qxBrV2hlfqme/baYiBFtYv/CNvy5t+qmjg9GJddjHyo4vHlufr7yiI32Hc03mR+xO/mM
 giFD08ZcygRPcmopC2WdpHpWljQQ3C681IQYLeXvrouibvtm4VaBlPObcmbjGyZb12gz
 XuCCELq32uks7zkyS15XxIekEv01XAMT9TzikovH+EI07cpr05b+/HoDDPTwhOvKUD7r
 O1bZDvL+eoQ0vYAMXI22geT2YHsDaMOeopTve8dsn3lRIbDIcKUfvdmCB0otFOTR6HPN vA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnau4gvkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 00:12:53 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 319Dk428017584;
        Fri, 10 Feb 2023 00:12:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3nhemfmvcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 00:12:50 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31A0Cl8u22348328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 00:12:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1753A2004E;
        Fri, 10 Feb 2023 00:12:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 861082004B;
        Fri, 10 Feb 2023 00:12:46 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.171.74.186])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Feb 2023 00:12:46 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 16/16] selftests/bpf: Add MSan annotations
Date:   Fri, 10 Feb 2023 01:12:10 +0100
Message-Id: <20230210001210.395194-17-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210001210.395194-1-iii@linux.ibm.com>
References: <20230210001210.395194-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: um40w2HD2M0e_JYT4SfE1Qdummih8mvi
X-Proofpoint-GUID: um40w2HD2M0e_JYT4SfE1Qdummih8mvi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_16,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090217
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

eBPF selftests produce a few false positives with MSan. 3 of them have
to do with sending uninitalized data via a socket. Another one is
PERF_EVENT_IOC_QUERY_BPF, which is not known to MSan. Silence all of
them using libbpf_mark_mem_written().

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c      | 3 +++
 tools/testing/selftests/bpf/prog_tests/send_signal.c     | 2 ++
 tools/testing/selftests/bpf/prog_tests/tp_attach_query.c | 4 ++++
 tools/testing/selftests/bpf/prog_tests/xdp_bonding.c     | 3 +++
 4 files changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index e980188d4124..c75a3357cd06 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -4,6 +4,7 @@
 #include <linux/err.h>
 #include <netinet/tcp.h>
 #include <test_progs.h>
+#include <bpf/libbpf_internal.h>
 #include "network_helpers.h"
 #include "bpf_dctcp.skel.h"
 #include "bpf_cubic.skel.h"
@@ -39,6 +40,8 @@ static void *server(void *arg)
 	ssize_t nr_sent = 0, bytes = 0;
 	char batch[1500];
 
+	libbpf_mark_mem_written(batch, sizeof(batch));
+
 	fd = accept(lfd, NULL, NULL);
 	while (fd == -1) {
 		if (errno == EINTR)
diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
index d63a20fbed33..11e91fc7a67f 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <bpf/libbpf_internal.h>
 #include <sys/time.h>
 #include <sys/resource.h>
 #include "test_send_signal_kern.skel.h"
@@ -58,6 +59,7 @@ static void test_send_signal_common(struct perf_event_attr *attr,
 		ASSERT_OK(setpriority(PRIO_PROCESS, 0, -20), "setpriority");
 
 		/* notify parent signal handler is installed */
+		libbpf_mark_mem_written(buf, 1);
 		ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
 
 		/* make sure parent enabled bpf program to send_signal */
diff --git a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
index 770fcc3bb1ba..727898e905fe 100644
--- a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
+++ b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <bpf/libbpf_internal.h>
 
 void serial_test_tp_attach_query(void)
 {
@@ -66,6 +67,7 @@ void serial_test_tp_attach_query(void)
 		if (i == 0) {
 			/* check NULL prog array query */
 			query->ids_len = num_progs;
+			libbpf_mark_var_written(query->prog_cnt);
 			err = ioctl(pmu_fd[i], PERF_EVENT_IOC_QUERY_BPF, query);
 			if (CHECK(err || query->prog_cnt != 0,
 				  "perf_event_ioc_query_bpf",
@@ -115,6 +117,8 @@ void serial_test_tp_attach_query(void)
 			  "err %d errno %d query->prog_cnt %u\n",
 			  err, errno, query->prog_cnt))
 			goto cleanup3;
+		libbpf_mark_mem_written(query->ids,
+					query->ids_len * sizeof(__u32));
 		for (j = 0; j < i + 1; j++)
 			if (CHECK(saved_prog_ids[j] != query->ids[j],
 				  "perf_event_ioc_query_bpf",
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
index 5e3a26b15ec6..e6334f254675 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
@@ -14,6 +14,7 @@
 #include <net/if.h>
 #include <linux/if_link.h>
 #include "test_progs.h"
+#include "bpf/libbpf_internal.h"
 #include "network_helpers.h"
 #include <linux/if_bonding.h>
 #include <linux/limits.h>
@@ -224,6 +225,8 @@ static int send_udp_packets(int vary_dst_ip)
 	int i, s = -1;
 	int ifindex;
 
+	libbpf_mark_mem_written(buf, sizeof(buf));
+
 	s = socket(AF_PACKET, SOCK_RAW, IPPROTO_RAW);
 	if (!ASSERT_GE(s, 0, "socket"))
 		goto err;
-- 
2.39.1

