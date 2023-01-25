Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47B067BEC8
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 22:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbjAYVkA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 16:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236823AbjAYVjy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 16:39:54 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D967212F32
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 13:39:46 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PKLdoo018448;
        Wed, 25 Jan 2023 21:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0u+BnyBJK2qRJhNlHyQreFL29EgKxssp0valZO/SyCc=;
 b=i6pVoDgDOQ1lRw0t8WqXqyhlWfOIT2kMkPW1yaCx5WImzC0B8ZIwqi5AoFYMkYViE+hf
 GQZj86FWS12SAJdnL+VuOTrk9/knFcAPEg9vvjVXwznQg3l1ETkF85QC9GE0ZwTAUdWf
 XlpVDU0qfogsDaaxtA/SzYd1idw6OFwdE3C4BXc9+zQSZx9f/1U5/M8wjgQJsX27xYs7
 keX0a8Pxyus757+QwPMjXErT/NXvIcK83101zqwct5i24VbnQNnDaVTUI/TTvfUkKhAZ
 qmYWF2nhYGyUdge4x1um5LTO3RyiLmtYfxMYTIDcobPoLPVX0b8u5GpAigf1qjmAIQ5z Hg== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nb6c2awef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:39:34 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PEQXLI031243;
        Wed, 25 Jan 2023 21:39:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3n87p6c285-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:39:32 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PLdSV532571746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 21:39:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB97F20043;
        Wed, 25 Jan 2023 21:39:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9922320040;
        Wed, 25 Jan 2023 21:39:28 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.209.149])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 21:39:28 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 17/24] libbpf: Read usdt arg spec with bpf_probe_read_kernel()
Date:   Wed, 25 Jan 2023 22:38:10 +0100
Message-Id: <20230125213817.1424447-18-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125213817.1424447-1-iii@linux.ibm.com>
References: <20230125213817.1424447-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GjeeFwA_YxnAHnUkeM5lKuMlPNXsRpXz
X-Proofpoint-ORIG-GUID: GjeeFwA_YxnAHnUkeM5lKuMlPNXsRpXz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 phishscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301250193
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Loading programs that use bpf_usdt_arg() on s390x fails with:

    ; switch (arg_spec->arg_type) {
    139: (61) r1 = *(u32 *)(r2 +8)
    R2 unbounded memory access, make sure to bounds check any such access

The bound checks seem to be already in place in the C code, and maybe
it's even possible to add extra bogus checks to placate LLVM or the
verifier. Take a simpler approach and just use a helper.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/usdt.bpf.h | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
index fdfd235e52c4..ddfa2521ab67 100644
--- a/tools/lib/bpf/usdt.bpf.h
+++ b/tools/lib/bpf/usdt.bpf.h
@@ -116,7 +116,7 @@ __weak __hidden
 int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
 {
 	struct __bpf_usdt_spec *spec;
-	struct __bpf_usdt_arg_spec *arg_spec;
+	struct __bpf_usdt_arg_spec arg_spec;
 	unsigned long val;
 	int err, spec_id;
 
@@ -133,21 +133,24 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
 	if (arg_num >= BPF_USDT_MAX_ARG_CNT || arg_num >= spec->arg_cnt)
 		return -ENOENT;
 
-	arg_spec = &spec->args[arg_num];
-	switch (arg_spec->arg_type) {
+	err = bpf_probe_read_kernel(&arg_spec, sizeof(arg_spec), &spec->args[arg_num]);
+	if (err)
+		return err;
+
+	switch (arg_spec.arg_type) {
 	case BPF_USDT_ARG_CONST:
 		/* Arg is just a constant ("-4@$-9" in USDT arg spec).
-		 * value is recorded in arg_spec->val_off directly.
+		 * value is recorded in arg_spec.val_off directly.
 		 */
-		val = arg_spec->val_off;
+		val = arg_spec.val_off;
 		break;
 	case BPF_USDT_ARG_REG:
 		/* Arg is in a register (e.g, "8@%rax" in USDT arg spec),
 		 * so we read the contents of that register directly from
 		 * struct pt_regs. To keep things simple user-space parts
-		 * record offsetof(struct pt_regs, <regname>) in arg_spec->reg_off.
+		 * record offsetof(struct pt_regs, <regname>) in arg_spec.reg_off.
 		 */
-		err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
+		err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec.reg_off);
 		if (err)
 			return err;
 		break;
@@ -155,18 +158,18 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
 		/* Arg is in memory addressed by register, plus some offset
 		 * (e.g., "-4@-1204(%rbp)" in USDT arg spec). Register is
 		 * identified like with BPF_USDT_ARG_REG case, and the offset
-		 * is in arg_spec->val_off. We first fetch register contents
+		 * is in arg_spec.val_off. We first fetch register contents
 		 * from pt_regs, then do another user-space probe read to
 		 * fetch argument value itself.
 		 */
-		err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
+		err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec.reg_off);
 		if (err)
 			return err;
-		err = bpf_probe_read_user(&val, sizeof(val), (void *)val + arg_spec->val_off);
+		err = bpf_probe_read_user(&val, sizeof(val), (void *)val + arg_spec.val_off);
 		if (err)
 			return err;
 #if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
-		val >>= arg_spec->arg_bitshift;
+		val >>= arg_spec.arg_bitshift;
 #endif
 		break;
 	default:
@@ -177,11 +180,11 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
 	 * necessary upper arg_bitshift bits, with sign extension if argument
 	 * is signed
 	 */
-	val <<= arg_spec->arg_bitshift;
-	if (arg_spec->arg_signed)
-		val = ((long)val) >> arg_spec->arg_bitshift;
+	val <<= arg_spec.arg_bitshift;
+	if (arg_spec.arg_signed)
+		val = ((long)val) >> arg_spec.arg_bitshift;
 	else
-		val = val >> arg_spec->arg_bitshift;
+		val = val >> arg_spec.arg_bitshift;
 	*res = val;
 	return 0;
 }
-- 
2.39.1

