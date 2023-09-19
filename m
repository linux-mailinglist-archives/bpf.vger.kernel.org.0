Return-Path: <bpf+bounces-10374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B90867A5F42
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 12:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E954281001
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 10:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4021B3D3BC;
	Tue, 19 Sep 2023 10:14:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87F72E64C
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 10:14:26 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79621A5
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 03:14:01 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38J9clER000314;
	Tue, 19 Sep 2023 10:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=YOuhYAZkGg4mC1IPqEBp87lW9rqVjqnlh8/7OuXtfS0=;
 b=fwG5GvwXTwmlpR+xrvH8OfdhyIsxbvjnbiRqqOaOwdcWBnWFcs+UibmwJPpg8AdynG5Z
 opxuQkyz63KTdHQPJYLkR1VWxuz6f0oT3gQ2AhXmc9rxVYRUjs7/9JpfzAs6cv72TQR0
 6dkKmjRxjKGDkYlpTzOVASCOF/DVO6qMzUPTWyaKh5mOfLpPY5etfa/shHXX2tb75NGf
 7xP1zzi0o+3kzjtG4axREkUoaqkRmKqKETnEyPUysjKmd3MeaMX2TVPOcaLpJaNOv7h7
 p1h8XnkTi6ugScSXW2ZFPeVl+P6LcNP4JRyWImrWnItiSBM25G3NhwW2HLk6Db0q+NiI oQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t77n33jcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Sep 2023 10:13:49 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38J9JI39018185;
	Tue, 19 Sep 2023 10:13:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5ppskp8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Sep 2023 10:13:47 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38JADjv624052226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Sep 2023 10:13:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E741520069;
	Tue, 19 Sep 2023 10:13:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F9582004F;
	Tue, 19 Sep 2023 10:13:44 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.67.55])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Sep 2023 10:13:44 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 03/10] selftests/bpf: Add big-endian support to the ldsx test
Date: Tue, 19 Sep 2023 12:09:05 +0200
Message-ID: <20230919101336.2223655-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230919101336.2223655-1-iii@linux.ibm.com>
References: <20230919101336.2223655-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gg6EXRSJD8RSh0sSu1Tt3jh1NquWrpFM
X-Proofpoint-ORIG-GUID: gg6EXRSJD8RSh0sSu1Tt3jh1NquWrpFM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_04,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare the ldsx test to run on big-endian systems by adding the
necessary endianness checks around narrow memory accesses.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../selftests/bpf/progs/test_ldsx_insn.c      |   6 +-
 .../selftests/bpf/progs/verifier_ldsx.c       | 146 ++++++++++--------
 2 files changed, 90 insertions(+), 62 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_ldsx_insn.c b/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
index 67c14ba1e87b..3709e5eb7dd0 100644
--- a/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
+++ b/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
@@ -104,7 +104,11 @@ int _tc(volatile struct __sk_buff *skb)
 		      "%[tmp_mark] = r1"
 		      : [tmp_mark]"=r"(tmp_mark)
 		      : [ctx]"r"(skb),
-			[off_mark]"i"(offsetof(struct __sk_buff, mark))
+			[off_mark]"i"(offsetof(struct __sk_buff, mark)
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+			+ sizeof(skb->mark) - 1
+#endif
+			)
 		      : "r1");
 #else
 	tmp_mark = (char)skb->mark;
diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
index 1e1bc379c44f..97d35bc1c943 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
@@ -13,12 +13,16 @@ __description("LDSX, S8")
 __success __success_unpriv __retval(-2)
 __naked void ldsx_s8(void)
 {
-	asm volatile ("					\
-	r1 = 0x3fe;					\
-	*(u64 *)(r10 - 8) = r1;				\
-	r0 = *(s8 *)(r10 - 8);				\
-	exit;						\
-"	::: __clobber_all);
+	asm volatile (
+	"r1 = 0x3fe;"
+	"*(u64 *)(r10 - 8) = r1;"
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	"r0 = *(s8 *)(r10 - 8);"
+#else
+	"r0 = *(s8 *)(r10 - 1);"
+#endif
+	"exit;"
+	::: __clobber_all);
 }
 
 SEC("socket")
@@ -26,12 +30,16 @@ __description("LDSX, S16")
 __success __success_unpriv __retval(-2)
 __naked void ldsx_s16(void)
 {
-	asm volatile ("					\
-	r1 = 0x3fffe;					\
-	*(u64 *)(r10 - 8) = r1;				\
-	r0 = *(s16 *)(r10 - 8);				\
-	exit;						\
-"	::: __clobber_all);
+	asm volatile (
+	"r1 = 0x3fffe;"
+	"*(u64 *)(r10 - 8) = r1;"
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	"r0 = *(s16 *)(r10 - 8);"
+#else
+	"r0 = *(s16 *)(r10 - 2);"
+#endif
+	"exit;"
+	::: __clobber_all);
 }
 
 SEC("socket")
@@ -39,13 +47,17 @@ __description("LDSX, S32")
 __success __success_unpriv __retval(-1)
 __naked void ldsx_s32(void)
 {
-	asm volatile ("					\
-	r1 = 0xfffffffe;				\
-	*(u64 *)(r10 - 8) = r1;				\
-	r0 = *(s32 *)(r10 - 8);				\
-	r0 >>= 1;					\
-	exit;						\
-"	::: __clobber_all);
+	asm volatile (
+	"r1 = 0xfffffffe;"
+	"*(u64 *)(r10 - 8) = r1;"
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	"r0 = *(s32 *)(r10 - 8);"
+#else
+	"r0 = *(s32 *)(r10 - 4);"
+#endif
+	"r0 >>= 1;"
+	"exit;"
+	::: __clobber_all);
 }
 
 SEC("socket")
@@ -54,20 +66,24 @@ __log_level(2) __success __retval(1)
 __msg("R1_w=scalar(smin=-128,smax=127)")
 __naked void ldsx_s8_range_priv(void)
 {
-	asm volatile ("					\
-	call %[bpf_get_prandom_u32];			\
-	*(u64 *)(r10 - 8) = r0;				\
-	r1 = *(s8 *)(r10 - 8);				\
-	/* r1 with s8 range */				\
-	if r1 s> 0x7f goto l0_%=;			\
-	if r1 s< -0x80 goto l0_%=;			\
-	r0 = 1;						\
-l1_%=:							\
-	exit;						\
-l0_%=:							\
-	r0 = 2;						\
-	goto l1_%=;					\
-"	:
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"*(u64 *)(r10 - 8) = r0;"
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	"r1 = *(s8 *)(r10 - 8);"
+#else
+	"r1 = *(s8 *)(r10 - 1);"
+#endif
+	/* r1 with s8 range */
+	"if r1 s> 0x7f goto l0_%=;"
+	"if r1 s< -0x80 goto l0_%=;"
+	"r0 = 1;"
+"l1_%=:"
+	"exit;"
+"l0_%=:"
+	"r0 = 2;"
+	"goto l1_%=;"
+	:
 	: __imm(bpf_get_prandom_u32)
 	: __clobber_all);
 }
@@ -77,20 +93,24 @@ __description("LDSX, S16 range checking")
 __success __success_unpriv __retval(1)
 __naked void ldsx_s16_range(void)
 {
-	asm volatile ("					\
-	call %[bpf_get_prandom_u32];			\
-	*(u64 *)(r10 - 8) = r0;				\
-	r1 = *(s16 *)(r10 - 8);				\
-	/* r1 with s16 range */				\
-	if r1 s> 0x7fff goto l0_%=;			\
-	if r1 s< -0x8000 goto l0_%=;			\
-	r0 = 1;						\
-l1_%=:							\
-	exit;						\
-l0_%=:							\
-	r0 = 2;						\
-	goto l1_%=;					\
-"	:
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"*(u64 *)(r10 - 8) = r0;"
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	"r1 = *(s16 *)(r10 - 8);"
+#else
+	"r1 = *(s16 *)(r10 - 2);"
+#endif
+	/* r1 with s16 range */
+	"if r1 s> 0x7fff goto l0_%=;"
+	"if r1 s< -0x8000 goto l0_%=;"
+	"r0 = 1;"
+"l1_%=:"
+	"exit;"
+"l0_%=:"
+	"r0 = 2;"
+	"goto l1_%=;"
+	:
 	: __imm(bpf_get_prandom_u32)
 	: __clobber_all);
 }
@@ -100,20 +120,24 @@ __description("LDSX, S32 range checking")
 __success __success_unpriv __retval(1)
 __naked void ldsx_s32_range(void)
 {
-	asm volatile ("					\
-	call %[bpf_get_prandom_u32];			\
-	*(u64 *)(r10 - 8) = r0;				\
-	r1 = *(s32 *)(r10 - 8);				\
-	/* r1 with s16 range */				\
-	if r1 s> 0x7fffFFFF goto l0_%=;			\
-	if r1 s< -0x80000000 goto l0_%=;		\
-	r0 = 1;						\
-l1_%=:							\
-	exit;						\
-l0_%=:							\
-	r0 = 2;						\
-	goto l1_%=;					\
-"	:
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"*(u64 *)(r10 - 8) = r0;"
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	"r1 = *(s32 *)(r10 - 8);"
+#else
+	"r1 = *(s32 *)(r10 - 4);"
+#endif
+	/* r1 with s16 range */
+	"if r1 s> 0x7fffFFFF goto l0_%=;"
+	"if r1 s< -0x80000000 goto l0_%=;"
+	"r0 = 1;"
+"l1_%=:"
+	"exit;"
+"l0_%=:"
+	"r0 = 2;"
+	"goto l1_%=;"
+	:
 	: __imm(bpf_get_prandom_u32)
 	: __clobber_all);
 }
-- 
2.41.0


