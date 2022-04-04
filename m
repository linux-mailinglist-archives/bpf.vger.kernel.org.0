Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C53B4F1FF9
	for <lists+bpf@lfdr.de>; Tue,  5 Apr 2022 01:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbiDDXNZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Apr 2022 19:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245285AbiDDXLv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 19:11:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D2A118
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 15:50:46 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234LJFXb002467;
        Mon, 4 Apr 2022 22:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=TcmjyYpcXBw2o7IfIH2/99JeMsyDdlUW5KynVbaONB8=;
 b=FYN+qKlGHPqfXpgGYNmlv5N6b3DmL1wIXX8tf5h9rv5b8p8LFHbZfuuWV0ZU4YQJwVqI
 lVM54MmnanLrdB1KmK9+bKjhK74U2ximWX+Xas4+RyzlhHTIRQQF64X2O/n1P9Clhn6d
 xTg8tMuXIofrYW9zXTe9ZmqSXZ0pXOv9glZOQtQr5d/ZJINUF/1VibFpkVrJX/DsZquF
 vX/iQs4aMxpNL6h417DhQu9Zgq3mazao0zFugut90gzSiRlq5v2Vm7jkvL9UQttanTnh
 vV22TwkXO3OyFnsTVQ/oJG9Wpexh24juqNxNSazj3xPmyiV9C1fCRhZS/1BoTd2n6cc1 Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f6yv6kf8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 22:50:32 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 234MfQgg005973;
        Mon, 4 Apr 2022 22:50:31 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f6yv6kf81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 22:50:31 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 234MhB8H026610;
        Mon, 4 Apr 2022 22:50:29 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3f6e48knf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 22:50:29 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 234MoQCV45416816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Apr 2022 22:50:26 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FE2EA405B;
        Mon,  4 Apr 2022 22:50:26 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0E0BA4054;
        Mon,  4 Apr 2022 22:50:25 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.171.47.144])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Apr 2022 22:50:25 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2] libbpf: Support Debian in resolve_full_path()
Date:   Tue,  5 Apr 2022 00:50:20 +0200
Message-Id: <20220404225020.51029-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 93Jc7F4XZKKohbG7K_1fk3kGKcdmyhmL
X-Proofpoint-GUID: WK576O39iqvdvmajA0xQDGetM5prh3tr
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_09,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040124
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
v1: https://lore.kernel.org/bpf/20220404102908.14688-1-iii@linux.ibm.com/
v1 -> v2: Use a single return value (Andrii), get rid of nested #ifs,
          simplify some of the conditions.

 tools/lib/bpf/libbpf.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6d2be53e4ba9..648dc8717e8d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10707,15 +10707,54 @@ static long elf_find_func_offset(const char *binary_path, const char *name)
 	return ret;
 }
 
+static const char *arch_specific_lib_paths(void)
+{
+	/*
+	 * Based on https://packages.debian.org/sid/libc6.
+	 *
+	 * Assume that the traced program is built for the same architecture
+	 * as libbpf, which should cover the vast majority of cases.
+	 */
+#if defined(__x86_64__)
+	return "/lib/x86_64-linux-gnu";
+#elif defined(__i386__)
+	return "/lib/i386-linux-gnu";
+#elif defined(__s390x__)
+	return "/lib/s390x-linux-gnu";
+#elif defined(__s390__)
+	return "/lib/s390-linux-gnu";
+#elif defined(__arm__) && defined(__SOFTFP__)
+	return "/lib/arm-linux-gnueabi";
+#elif defined(__arm__) && !defined(__SOFTFP__)
+	return "/lib/arm-linux-gnueabihf";
+#elif defined(__aarch64__)
+	return "/lib/aarch64-linux-gnu";
+#elif defined(__mips__) && defined(__MIPSEL__) && _MIPS_SZLONG == 64
+	return "/lib/mips64el-linux-gnuabi64";
+#elif defined(__mips__) && defined(__MIPSEL__) && _MIPS_SZLONG == 32
+	return "/lib/mipsel-linux-gnu";
+#elif defined(__powerpc64__) && __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	return "/lib/powerpc64le-linux-gnu";
+#elif defined(__sparc__) && defined(__arch64__)
+	return "/lib/sparc64-linux-gnu";
+#elif defined(__riscv) && __riscv_xlen == 64
+	return "/lib/riscv64-linux-gnu";
+#else
+	return NULL;
+#endif
+}
+
 /* Get full path to program/shared library. */
 static int resolve_full_path(const char *file, char *result, size_t result_sz)
 {
-	const char *search_paths[2];
+	const char *search_paths[3];
 	int i;
 
+	memset(search_paths, 0, sizeof(search_paths));
 	if (strstr(file, ".so")) {
 		search_paths[0] = getenv("LD_LIBRARY_PATH");
 		search_paths[1] = "/usr/lib64:/usr/lib";
+		search_paths[2] = arch_specific_lib_paths();
 	} else {
 		search_paths[0] = getenv("PATH");
 		search_paths[1] = "/usr/bin:/usr/sbin";
-- 
2.35.1

