Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0A367BEC2
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 22:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbjAYVjz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 16:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236878AbjAYVjv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 16:39:51 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642B22F783
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 13:39:43 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PKLgl2030687;
        Wed, 25 Jan 2023 21:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=n1RzRJHW8EU2+z/I+3e1QrTdAJKXSfBJ7H9uFvtAa14=;
 b=CxOuyqVsaMBbsnSLVnmr3CWE4g/wMvPmPm2Up1NFsrw4opa+wtdD5zzB/Tq+TuyERrKN
 y/o09iLrx0JztEv1OoHatwsrqvoBuPhbNsgY7sHWKjUnHeNYw7RXrAswzytv65P21pmV
 aPF+g7aN43MDT5kbj8XUpNNbHSSYKaloqfHxgjJDovw1l1Q+x1BIK2eC6RTp8SQrehUb
 QygFG/8h+f5+IUHtdLZzBCiS0c4m4czukQw9DLbDdt65A28SZs9yQAay42uUdkK1kJ8U
 GL6OFzmW5XKyLc9lQTN1cPCKk8dgPa/Q/BbVWc70nRPeAmVjcNMKhHoB1zVKhm8vrBjo pA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nacg21nyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:39:30 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PH3jSn014941;
        Wed, 25 Jan 2023 21:39:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n87afdkx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:39:28 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PLdOHr52232534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 21:39:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA0332004B;
        Wed, 25 Jan 2023 21:39:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8751220040;
        Wed, 25 Jan 2023 21:39:24 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.209.149])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 21:39:24 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 13/24] selftests/bpf: Add a sign-extension test for kfuncs
Date:   Wed, 25 Jan 2023 22:38:06 +0100
Message-Id: <20230125213817.1424447-14-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125213817.1424447-1-iii@linux.ibm.com>
References: <20230125213817.1424447-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uunGKBPytJEm-2zQCg2x0q6hWivEfup7
X-Proofpoint-GUID: uunGKBPytJEm-2zQCg2x0q6hWivEfup7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=992
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

s390x ABI requires the caller to zero- or sign-extend the arguments.
eBPF already deals with zero-extension (by definition of its ABI), but
not with sign-extension.

Add a test to cover that potentially problematic area.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 net/bpf/test_run.c                             |  9 +++++++++
 .../selftests/bpf/prog_tests/kfunc_call.c      |  1 +
 .../selftests/bpf/progs/kfunc_call_test.c      | 18 ++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 8da0d73b368e..7dbefa4fd2eb 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -550,6 +550,14 @@ struct sock * noinline bpf_kfunc_call_test3(struct sock *sk)
 	return sk;
 }
 
+long noinline bpf_kfunc_call_test4(signed char a, short b, int c, long d)
+{
+	/* Provoke the compiler to assume that the caller has sign-extended a,
+	 * b and c on platforms where this is required (e.g. s390x).
+	 */
+	return (long)a + (long)b + (long)c + d;
+}
+
 struct prog_test_member1 {
 	int a;
 };
@@ -746,6 +754,7 @@ BTF_SET8_START(test_sk_check_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test2)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test3)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test4)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_acquire, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_kfunc_call_memb_acquire, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_release, KF_RELEASE)
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
index 5af1ee8f0e6e..bb4cd82a788a 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
@@ -72,6 +72,7 @@ static struct kfunc_test_params kfunc_tests[] = {
 	/* success cases */
 	TC_TEST(kfunc_call_test1, 12),
 	TC_TEST(kfunc_call_test2, 3),
+	TC_TEST(kfunc_call_test4, -1234),
 	TC_TEST(kfunc_call_test_ref_btf_id, 0),
 	TC_TEST(kfunc_call_test_get_mem, 42),
 	SYSCALL_TEST(kfunc_syscall_test, 0),
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test.c b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
index f636e50be259..d91c58d06d38 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_test.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
@@ -3,6 +3,7 @@
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 
+extern long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
 extern int bpf_kfunc_call_test2(struct sock *sk, __u32 a, __u32 b) __ksym;
 extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
 				  __u32 c, __u64 d) __ksym;
@@ -17,6 +18,23 @@ extern void bpf_kfunc_call_test_mem_len_fail2(__u64 *mem, int len) __ksym;
 extern int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size) __ksym;
 extern int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
 
+SEC("tc")
+int kfunc_call_test4(struct __sk_buff *skb)
+{
+	struct bpf_sock *sk = skb->sk;
+	long tmp;
+
+	if (!sk)
+		return -1;
+
+	sk = bpf_sk_fullsock(sk);
+	if (!sk)
+		return -1;
+
+	tmp = bpf_kfunc_call_test4(-3, -30, -200, -1000);
+	return (tmp >> 32) + tmp;
+}
+
 SEC("tc")
 int kfunc_call_test2(struct __sk_buff *skb)
 {
-- 
2.39.1

