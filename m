Return-Path: <bpf+bounces-57755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE0EAAFB3C
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 15:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A523B15C9
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 13:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086AC22B8C1;
	Thu,  8 May 2025 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MzRIm/hu"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7852229B2C;
	Thu,  8 May 2025 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746710593; cv=none; b=BKpjDDIDDCsCkIFg+CqBE8D0D0z4+zr/WF5z3AQ66dtmSs6n+KQs7kGe3Mc4Hb4H6Kt3fkAgUKje/4LM4qM863YiLi0bfjkmm3tiZojoCHaVgv2yllPVk2CguS5C2vECTDmnOfhmBy49VoXuEjjBYmSmNS2sy2CuAYaz03A616w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746710593; c=relaxed/simple;
	bh=CJkALDrWQFDbMEghbvKQWoCFnXYSdLaRqQy4Wv9/aj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oR6HwrxzC+iVJVoCnRFifoV+JX0+EPixin9/u8BqTWd81eJv01EULsQXpuLxAGwrkODiSWTeJumHFPOlp6WXUg9duJboD5wa1TmeTgsGQNisv7a62U/rR3/s7/RQvyXJKmDPJXxBSffpdUnWHMT5BU37Hdnb2pLeyEt7EkLvHY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MzRIm/hu; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548D2GSW029754;
	Thu, 8 May 2025 13:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=/PNVW
	o5veP4d62jBWwK/eAdNfg7/xOcImr/JnJu+Uao=; b=MzRIm/huWjIwXX95JFY3t
	weiz1MdafN5l5HrWKcQyEp5tlb3g6iBGaBEWLuMa2ZSJE4T6mdhz8N3OtG4/jr9d
	Rb3keCb5V0nhIm3ILxTEPYf7qhFS2FhROtjubcj8lvgl2IDO3fF21H8LbcqXr+Rm
	9z3WU9FVl5esHu+AcuCjgmhrPL+sIQht+xk+AkCPOUqQJ05pEqZE1oR/l7pKVzzt
	zm1iuPoVnWAFnhl27+1p2DnhOXSeGh4/Vh3vClUDkoAcHQDD7VRs2htY1Vx/FzSV
	OB0eeqHLu2gfBO4VkfD2LYcPgtNvLE7mZ9/6Y7TUR1JuUsfX1G1pZ0pqMB+1Xp9w
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46gw4x01ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 May 2025 13:22:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 548BscaJ035362;
	Thu, 8 May 2025 13:22:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kcedsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 May 2025 13:22:54 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 548DMgbD024112;
	Thu, 8 May 2025 13:22:53 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-49-250.vpn.oracle.com [10.154.49.250])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 46d9kcedkj-4;
	Thu, 08 May 2025 13:22:53 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
        tony.ambardar@gmail.com, alexis.lothore@bootlin.com
Cc: eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        bpf@vger.kernel.org, dwarves@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 3/3] selftests/bpf: add 0-length struct testing to tracing_struct tests
Date: Thu,  8 May 2025 14:22:37 +0100
Message-ID: <20250508132237.1817317-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250508132237.1817317-1-alan.maguire@oracle.com>
References: <20250508132237.1817317-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_04,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505080112
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDExMiBTYWx0ZWRfXw2JXPhf6Hn8s 6roc/RGUIeProT47ZMxYjFBYRMi95+bDuI0nfHA+673LL3JgOoOU5xo2XD93v3BLAorR/vhWPxk fxe3tazUnKSEu2cfxCAMLdY1/C1GRu9EZUo95wVJk1Fqx7rETONp3qNy8YB4YW9ZEfLDWbZXegM
 hoTJCtY13NemCDEhVvUXbT+JegVkNP9B7IJHCkxX423YvE+1/6BUY5Cd/VJd3SsFrCCfUbxMf5z OKZx8Ic2oeotRGlDdbMxHKCHtftMhrSaVtPK8m7kxgLN0BE30zqJuTYPmQWNmbWLbkPuwSfAn2Q MJbz6Ui6TYBG1ZWq7QV+MJtcmGktdTjXqRs/8ie0kflyh8ONLPbwNtYQ3F8eV1wzZPLAQoUCEYU
 NSKKHkglx5P8saV6glVg11WX4gEYWCQw/5nnp7TUVVFOfZikBd2cLra8du533KyD11MzLXux
X-Proofpoint-GUID: j_dn7mNtIV7sfvej7X3amcXAmIdBzatl
X-Proofpoint-ORIG-GUID: j_dn7mNtIV7sfvej7X3amcXAmIdBzatl
X-Authority-Analysis: v=2.4 cv=Aqru3P9P c=1 sm=1 tr=0 ts=681cb02f cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=98mhb7PIPdgGne7j3xkA:9

If a 0-length struct is passed as a parameter this throws off
assumptions that register N in calling convention will match parameter
N.  With [1], such function representations will correctly be emitted
in BTF because the register/param mismatch is not a result of an
optimization we cannot infer from the code alone.

Test that BPF_PROG2() macro can handle this situation by having
a function with a 0-length struct as first arg and verify that we
see expected 2nd, 3rd arg values.

[1] https://lore.kernel.org/dwarves/20250502070318.1561924-1-tony.ambardar@gmail.com/

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/tracing_struct.c        |  2 ++
 tools/testing/selftests/bpf/progs/tracing_struct.c   | 11 +++++++++++
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 12 ++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
index 19e68d4b3532..5b7e80fb8ccc 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
@@ -56,6 +56,8 @@ static void test_struct_args(void)
 
 	ASSERT_EQ(skel->bss->t6, 1, "t6 ret");
 
+	ASSERT_EQ(skel->bss->t7, 34, "t7 a + c");
+
 destroy_skel:
 	tracing_struct__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/tracing_struct.c b/tools/testing/selftests/bpf/progs/tracing_struct.c
index c435a3a8328a..5d181be11a96 100644
--- a/tools/testing/selftests/bpf/progs/tracing_struct.c
+++ b/tools/testing/selftests/bpf/progs/tracing_struct.c
@@ -18,6 +18,9 @@ struct bpf_testmod_struct_arg_3 {
 	int b[];
 };
 
+struct bpf_testmod_struct_arg_6 {
+};
+
 long t1_a_a, t1_a_b, t1_b, t1_c, t1_ret, t1_nregs;
 __u64 t1_reg0, t1_reg1, t1_reg2, t1_reg3;
 long t2_a, t2_b_a, t2_b_b, t2_c, t2_ret;
@@ -25,6 +28,7 @@ long t3_a, t3_b, t3_c_a, t3_c_b, t3_ret;
 long t4_a_a, t4_b, t4_c, t4_d, t4_e_a, t4_e_b, t4_ret;
 long t5_ret;
 int t6;
+int t7;
 
 SEC("fentry/bpf_testmod_test_struct_arg_1")
 int BPF_PROG2(test_struct_arg_1, struct bpf_testmod_struct_arg_2, a, int, b, int, c)
@@ -130,4 +134,11 @@ int BPF_PROG2(test_struct_arg_11, struct bpf_testmod_struct_arg_3 *, a)
 	return 0;
 }
 
+SEC("fentry/bpf_testmod_test_struct_arg_10")
+int BPF_PROG2(test_struct_arg_12, struct bpf_testmod_struct_arg_6, h, u64, a, short, c)
+{
+	t7 = a + c;
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 2e54b95ad898..4a766e5ee9bc 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -62,6 +62,9 @@ struct bpf_testmod_struct_arg_5 {
 	long d;
 };
 
+struct bpf_testmod_struct_arg_6 {
+};
+
 __bpf_hook_start();
 
 noinline int
@@ -128,6 +131,13 @@ bpf_testmod_test_struct_arg_9(u64 a, void *b, short c, int d, void *e, char f,
 	return bpf_testmod_test_struct_arg_result;
 }
 
+noinline int
+bpf_testmod_test_struct_arg_10(struct bpf_testmod_struct_arg_6 h, u64 a, short c)
+{
+	bpf_testmod_test_struct_arg_result = a + c;
+	return bpf_testmod_test_struct_arg_result;
+}
+
 noinline int
 bpf_testmod_test_arg_ptr_to_struct(struct bpf_testmod_struct_arg_1 *a) {
 	bpf_testmod_test_struct_arg_result = a->a;
@@ -398,6 +408,7 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 	struct bpf_testmod_struct_arg_3 *struct_arg3;
 	struct bpf_testmod_struct_arg_4 struct_arg4 = {21, 22};
 	struct bpf_testmod_struct_arg_5 struct_arg5 = {23, 24, 25, 26};
+	struct bpf_testmod_struct_arg_6 struct_arg6 = {};
 	int i = 1;
 
 	while (bpf_testmod_return_ptr(i))
@@ -414,6 +425,7 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 					    (void *)20, struct_arg4, 23);
 	(void)bpf_testmod_test_struct_arg_9(16, (void *)17, 18, 19, (void *)20,
 					    21, 22, struct_arg5, 27);
+	(void)bpf_testmod_test_struct_arg_10(struct_arg6, 16, 18);
 
 	(void)bpf_testmod_test_arg_ptr_to_struct(&struct_arg1_2);
 
-- 
2.39.3


