Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FD04F131E
	for <lists+bpf@lfdr.de>; Mon,  4 Apr 2022 12:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357864AbiDDKb0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Apr 2022 06:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357885AbiDDKb0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 06:31:26 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293CB1EAF3
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 03:29:30 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234AHFT0022505;
        Mon, 4 Apr 2022 10:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=fGvEa8ak58eS/RdSqg7JZDiecsbpNAeeN4NE6pNV9/s=;
 b=qrXpJ9BM10fu5rc6oJmfUzZRC/iLxlYOMBHLS0WukdeXr+ktdX211/+NERpmMvrE95VB
 TjLHA7UpMrMjtiwZPF5OCDqq19d2JzlhpRImP0qHFC+4+FSK2Ol3im7p4Bpb8NAVMjpe
 33C5dE8Ti/bRHX8fbYyAfwiQ7ZZY2+4nieXUDXm2yMkve+v5JzniOMd2Rj41eBbFUXKS
 GDom9dxNg3J9szphzUAB5f+QnZ3z2rAHynuCmtx6TVwZFBPTCBi1n6bQIte5EucTkCcD
 x14R580JkfhP+ei+5oZ97o3qUuHQUJoS9Fo9maQ65kAH961kplLlvBRAzCf4CZyyK5Kz sA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f7xsmr86r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 10:29:16 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 234AOH7T013316;
        Mon, 4 Apr 2022 10:29:16 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f7xsmr864-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 10:29:16 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 234AD9HQ023108;
        Mon, 4 Apr 2022 10:29:14 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3f6drhjurd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 10:29:14 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 234AGxLM45089100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Apr 2022 10:16:59 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AF824C046;
        Mon,  4 Apr 2022 10:29:10 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1277E4C058;
        Mon,  4 Apr 2022 10:29:10 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.171.47.144])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Apr 2022 10:29:09 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] libbpf: Support Debian in resolve_full_path()
Date:   Mon,  4 Apr 2022 12:29:08 +0200
Message-Id: <20220404102908.14688-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ul4laqvva2Iriozl_GgavOzqls0QwAKf
X-Proofpoint-GUID: bIFhILp_WQUo7jiNLJ1dWKIwSyZGq076
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_03,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

attach_probe selftest fails on Debian-based distros with `failed to
resolve full path for 'libc.so.6'`. The reason is that these distros
embraced multiarch to the point where even for the "main" architecture
they store libc in /lib/<triple>.

This is configured in /etc/ld.so.conf and in theory it's possible to
replicate the loader's parsing and processing logic in libbpf, however
a much simpler solution is to just enumerate the known library paths.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/libbpf.c | 54 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6d2be53e4ba9..4f616b11564f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10707,21 +10707,61 @@ static long elf_find_func_offset(const char *binary_path, const char *name)
 	return ret;
 }
 
+static void add_debian_library_paths(const char **search_paths, int *n)
+{
+	/*
+	 * Based on https://packages.debian.org/sid/libc6.
+	 *
+	 * Assume that the traced program is built for the same architecture
+	 * as libbpf, which should cover the vast majority of cases.
+	 */
+#if defined(__x86_64__)
+	search_paths[(*n)++] = "/lib/x86_64-linux-gnu";
+#elif defined(__i386__)
+	search_paths[(*n)++] = "/lib/i386-linux-gnu";
+#elif defined(__s390x__)
+	search_paths[(*n)++] = "/lib/s390x-linux-gnu";
+#elif defined(__s390__)
+	search_paths[(*n)++] = "/lib/s390-linux-gnu";
+#elif defined(__arm__)
+#if defined(__SOFTFP__)
+	search_paths[(*n)++] = "/lib/arm-linux-gnueabi";
+#else
+	search_paths[(*n)++] = "/lib/arm-linux-gnueabihf";
+#endif /* defined(__SOFTFP__) */
+#elif defined(__aarch64__)
+	search_paths[(*n)++] = "/lib/aarch64-linux-gnu";
+#elif defined(__mips__) && (__BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__)
+#if _MIPS_SZLONG == 64
+	search_paths[(*n)++] = "/lib/mips64el-linux-gnuabi64";
+#elif _MIPS_SZLONG == 32
+	search_paths[(*n)++] = "/lib/mipsel-linux-gnu";
+#endif
+#elif defined(__powerpc__) && (__BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__)
+	search_paths[(*n)++] = "/lib/powerpc64le-linux-gnu";
+#elif defined(__sparc__)
+	search_paths[(*n)++] = "/lib/sparc64-linux-gnu";
+#elif defined(__riscv) && __riscv_xlen == 64
+	search_paths[(*n)++] = "/lib/riscv64-linux-gnu";
+#endif
+}
+
 /* Get full path to program/shared library. */
 static int resolve_full_path(const char *file, char *result, size_t result_sz)
 {
-	const char *search_paths[2];
-	int i;
+	const char *search_paths[3];
+	int i, n = 0;
 
 	if (strstr(file, ".so")) {
-		search_paths[0] = getenv("LD_LIBRARY_PATH");
-		search_paths[1] = "/usr/lib64:/usr/lib";
+		search_paths[n++] = getenv("LD_LIBRARY_PATH");
+		search_paths[n++] = "/usr/lib64:/usr/lib";
+		add_debian_library_paths(search_paths, &n);
 	} else {
-		search_paths[0] = getenv("PATH");
-		search_paths[1] = "/usr/bin:/usr/sbin";
+		search_paths[n++] = getenv("PATH");
+		search_paths[n++] = "/usr/bin:/usr/sbin";
 	}
 
-	for (i = 0; i < ARRAY_SIZE(search_paths); i++) {
+	for (i = 0; i < n; i++) {
 		const char *s;
 
 		if (!search_paths[i])
-- 
2.35.1

