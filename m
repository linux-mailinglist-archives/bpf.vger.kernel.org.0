Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BDB67F2B5
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjA1AHv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbjA1AHn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:07:43 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9208B05C
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 16:07:34 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30S00wUG030156;
        Sat, 28 Jan 2023 00:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=X6f/wlmFkENOuQG3GEYGo84Jk40JRrhBKHDJLOsZGZ0=;
 b=BdSd91dzDNdZLQWhgr3ZVBAkhBr0Gigrkl2XAZlJcUrRioWjOJmt+UgngOle9razGtrA
 q6Je/n+ufj+fzIxECmZkjvIghKTHDQKi3Q6F0ixbdrx+K4rS+Njlcysrc7j++5XY8vV0
 pkTaHvYi2y8Y4uu83eA52gQ1eBxR3A/rh/rJ65f2/1Nyh5y72ePhu2OC8gyg7rlXtSXZ
 7roHj3mOAU2g2Eq8xrAtoOs6Elg1DThxY+b9X50stBO/MfyIzPYEeFR8TVhSrSyhUa3L
 nrCLo5n72x3baKZiqjyyaTCOG4Usp2Vz/oM3bks6MvEyUhIYggutkAcTms5vSgwBSLdS pA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncrsx03f5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:21 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30RKAMgw027572;
        Sat, 28 Jan 2023 00:07:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6g5jn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:19 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30S07GGa36897046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Jan 2023 00:07:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5952120043;
        Sat, 28 Jan 2023 00:07:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D947820040;
        Sat, 28 Jan 2023 00:07:15 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.11.57])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 28 Jan 2023 00:07:15 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 18/31] selftests/bpf: Fix sk_assign on s390x
Date:   Sat, 28 Jan 2023 01:06:37 +0100
Message-Id: <20230128000650.1516334-19-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128000650.1516334-1-iii@linux.ibm.com>
References: <20230128000650.1516334-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5rKbdP0PqBDnbtMzuXX9pdol7Z8KXKld
X-Proofpoint-ORIG-GUID: 5rKbdP0PqBDnbtMzuXX9pdol7Z8KXKld
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_14,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301270216
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

sk_assign is failing on an s390x machine running Debian "bookworm" for
2 reasons: legacy server_map definition and uninitialized addrlen in
recvfrom() call.

Fix by upgrading the server_map definition and dropping addrlen
(recvfrom() allows NULL values for src_addr and addrlen).

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../selftests/bpf/prog_tests/sk_assign.c      |  5 +---
 .../selftests/bpf/progs/test_sk_assign.c      | 24 +++++--------------
 2 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
index 3e190ed63976..ba99dce1db0d 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
@@ -129,15 +129,12 @@ get_port(int fd)
 static ssize_t
 rcv_msg(int srv_client, int type)
 {
-	struct sockaddr_storage ss;
 	char buf[BUFSIZ];
-	socklen_t slen;
 
 	if (type == SOCK_STREAM)
 		return read(srv_client, &buf, sizeof(buf));
 	else
-		return recvfrom(srv_client, &buf, sizeof(buf), 0,
-				(struct sockaddr *)&ss, &slen);
+		return recvfrom(srv_client, &buf, sizeof(buf), 0, NULL, NULL);
 }
 
 static int
diff --git a/tools/testing/selftests/bpf/progs/test_sk_assign.c b/tools/testing/selftests/bpf/progs/test_sk_assign.c
index 98c6493d9b91..13ba4dd2d19f 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_assign.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_assign.c
@@ -16,25 +16,13 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
-/* Pin map under /sys/fs/bpf/tc/globals/<map name> */
-#define PIN_GLOBAL_NS 2
-
-/* Must match struct bpf_elf_map layout from iproute2 */
 struct {
-	__u32 type;
-	__u32 size_key;
-	__u32 size_value;
-	__u32 max_elem;
-	__u32 flags;
-	__u32 id;
-	__u32 pinning;
-} server_map SEC("maps") = {
-	.type = BPF_MAP_TYPE_SOCKMAP,
-	.size_key = sizeof(int),
-	.size_value  = sizeof(__u64),
-	.max_elem = 1,
-	.pinning = PIN_GLOBAL_NS,
-};
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__type(key, int);
+	__type(value, __u64);
+	__uint(pinning, LIBBPF_PIN_BY_NAME);
+	__uint(max_entries, 1);
+} server_map SEC(".maps");
 
 char _license[] SEC("license") = "GPL";
 
-- 
2.39.1

