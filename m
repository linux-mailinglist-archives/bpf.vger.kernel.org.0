Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3C567BEBF
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 22:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbjAYVjx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 16:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbjAYVjs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 16:39:48 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E043148A3A
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 13:39:39 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PKLhJi030707;
        Wed, 25 Jan 2023 21:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Vbx3tO08DKMkPyVUYNCow3klkUxuhkvxszSpJeCP29o=;
 b=rgEOI1mQrvo/KdJC6Np3tXTBJgCG7WPXhGcF8UqJBCM9zrAb1dJ0dp94Qr+KJQpcp5m2
 7/rxmEuaOYfmqsjgrBZN6v1rmppRYTfCgA0/YyhDkyDkxrCJVNO7pwhjmdmHlYB0uknV
 Dr+VyoQga/vKzuMmtpaQ0BoMyMiLaA64rL0thzwzu+3w9LNFQgB3kHsu5XTCNqUYG2QO
 v2+F7uJVBcqdAXeVMCwdZECFji4MyX8CWBZdLRIxyeMLaFKVgoiUeRF3vQ1B+nqGXSLo
 HnPl1nllrdea6gqjODIXjKA3HpOSuwzrqjFfV/bwnaRVTtE5OnBiezGzMt6vo6O6sklN Mw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nacg21nws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:39:27 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PAhePB027489;
        Wed, 25 Jan 2023 21:39:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6dmpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:39:25 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PLdHqm52232532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 21:39:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA06220040;
        Wed, 25 Jan 2023 21:39:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85D512004B;
        Wed, 25 Jan 2023 21:39:17 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.209.149])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 21:39:17 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 08/24] selftests/bpf: Fix verify_pkcs7_sig on s390x
Date:   Wed, 25 Jan 2023 22:38:01 +0100
Message-Id: <20230125213817.1424447-9-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125213817.1424447-1-iii@linux.ibm.com>
References: <20230125213817.1424447-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HJsxU2nTFQf_srKQbgwd9fEee49KafsJ
X-Proofpoint-GUID: HJsxU2nTFQf_srKQbgwd9fEee49KafsJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250193
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use bpf_probe_read_kernel() instead of bpf_probe_read(), which is not
defined on all architectures.

While at it, improve the error handling: do not hide the verifier log,
and check the return values of bpf_probe_read_kernel() and
bpf_copy_from_user().

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../selftests/bpf/prog_tests/verify_pkcs7_sig.c      |  9 +++++++++
 .../selftests/bpf/progs/test_verify_pkcs7_sig.c      | 12 ++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c b/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
index 579d6ee83ce0..75c256f79f85 100644
--- a/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
+++ b/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
@@ -56,11 +56,17 @@ struct data {
 	__u32 sig_len;
 };
 
+static char libbpf_log[8192];
 static bool kfunc_not_supported;
 
 static int libbpf_print_cb(enum libbpf_print_level level, const char *fmt,
 			   va_list args)
 {
+	size_t log_len = strlen(libbpf_log);
+
+	vsnprintf(libbpf_log + log_len, sizeof(libbpf_log) - log_len,
+		  fmt, args);
+
 	if (strcmp(fmt, "libbpf: extern (func ksym) '%s': not found in kernel or module BTFs\n"))
 		return 0;
 
@@ -277,6 +283,7 @@ void test_verify_pkcs7_sig(void)
 	if (!ASSERT_OK_PTR(skel, "test_verify_pkcs7_sig__open"))
 		goto close_prog;
 
+	libbpf_log[0] = 0;
 	old_print_cb = libbpf_set_print(libbpf_print_cb);
 	ret = test_verify_pkcs7_sig__load(skel);
 	libbpf_set_print(old_print_cb);
@@ -289,6 +296,8 @@ void test_verify_pkcs7_sig(void)
 		goto close_prog;
 	}
 
+	printf("%s", libbpf_log);
+
 	if (!ASSERT_OK(ret, "test_verify_pkcs7_sig__load"))
 		goto close_prog;
 
diff --git a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
index ce419304ff1f..7748cc23de8a 100644
--- a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
+++ b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
@@ -59,10 +59,14 @@ int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size)
 	if (!data_val)
 		return 0;
 
-	bpf_probe_read(&value, sizeof(value), &attr->value);
-
-	bpf_copy_from_user(data_val, sizeof(struct data),
-			   (void *)(unsigned long)value);
+	ret = bpf_probe_read_kernel(&value, sizeof(value), &attr->value);
+	if (ret)
+		return ret;
+
+	ret = bpf_copy_from_user(data_val, sizeof(struct data),
+				 (void *)(unsigned long)value);
+	if (ret)
+		return ret;
 
 	if (data_val->data_len > sizeof(data_val->data))
 		return -EINVAL;
-- 
2.39.1

