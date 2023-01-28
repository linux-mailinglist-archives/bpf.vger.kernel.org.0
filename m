Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8E667F2AA
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjA1AHi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjA1AH3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:07:29 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6486288CFD
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 16:07:27 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RNrtAv022151;
        Sat, 28 Jan 2023 00:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=OPT9+/tNaV+41/FENhsMahSQ5OPDcGoJIWC+6R5FJhA=;
 b=jyMZkFIZOy+DmfYbv2C1Y/JRFd3MellN3aYyMea9DAqnJnZBebV8efj9HuarWvj2MYdZ
 Msk05aaVe5rlfgStidyLBjQlqWW6VcZHJ+MsdltjfXTETd56zCJOfdFb5obX3SGAqoOp
 HejH4D5banY1j0fcRJAHU92pWm/2GwPksehlQr46cSQJO3faF/WOoDM+xGpxlBO3VTgE
 QY1uSmRS/6nHXu0QU/siUo7gdOcxf2abNJhu/tdxJy0JIJWblyv47BQCw5lwLCKZ08NM
 Qz0a9fcwXpaIyGOh/C/MK6KkslXm/JlyB/j1WRjivz2E+BaEjHfQuRHJ28j2S1Nj65FH HQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncrpf09sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:14 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30RFB1Zk031975;
        Sat, 28 Jan 2023 00:07:11 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3n87p65tdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:11 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30S077aV39190992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Jan 2023 00:07:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CF8420043;
        Sat, 28 Jan 2023 00:07:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB7C520040;
        Sat, 28 Jan 2023 00:07:06 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.11.57])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 28 Jan 2023 00:07:06 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 09/31] selftests/bpf: Fix verify_pkcs7_sig on s390x
Date:   Sat, 28 Jan 2023 01:06:28 +0100
Message-Id: <20230128000650.1516334-10-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128000650.1516334-1-iii@linux.ibm.com>
References: <20230128000650.1516334-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fIKJI4Bloy1jAyIoFHcjHwVTuviM88nc
X-Proofpoint-GUID: fIKJI4Bloy1jAyIoFHcjHwVTuviM88nc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_14,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270220
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
 .../selftests/bpf/prog_tests/verify_pkcs7_sig.c      |  3 +++
 .../selftests/bpf/progs/test_verify_pkcs7_sig.c      | 12 ++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c b/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
index 579d6ee83ce0..dd7f2bc70048 100644
--- a/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
+++ b/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
@@ -61,6 +61,9 @@ static bool kfunc_not_supported;
 static int libbpf_print_cb(enum libbpf_print_level level, const char *fmt,
 			   va_list args)
 {
+	if (level == LIBBPF_WARN)
+		vprintf(fmt, args);
+
 	if (strcmp(fmt, "libbpf: extern (func ksym) '%s': not found in kernel or module BTFs\n"))
 		return 0;
 
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

