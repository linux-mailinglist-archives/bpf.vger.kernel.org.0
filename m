Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E1167F2BA
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjA1AH5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjA1AHr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:07:47 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACDF87364
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 16:07:38 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RNka24030622;
        Sat, 28 Jan 2023 00:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wte91ah/ySaLEvyiNZJ1+ouxlfe9epTohVsN+gvJIBQ=;
 b=p0CN0P+IJL/8H2Lrz3X8P5n5zoRDC+YAc8CZtAmTRIrMcWx3lSh/ghlJYcdTRbTWXhba
 hsnW6+VB5RslesQRI7ck6TM1qZpvEG8Y/i8tVuXpRDMdBFnmEnHLxcHlB943mpsL9iX6
 M0FirYGyreWEE99g4gNAIv/Q+EYmHEwnskXH7pSgG4kZyXz8sFyGXmwMoD4Dg2VOaIfR
 rkQ0DUMMMv8gW3NEmfXud3hEZrksDcTcrwGIOtKrIFMf75ih4ZPEssnqdSnoWq+N0WUf
 EKoo1M4sGwTUNdB4Pl6eMnsyVUQ+DT7rsoWIEypAq17jN/6LCm0MCYAB8M57FdKc49HU eA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncm3teccq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:25 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30RLiA2u010363;
        Sat, 28 Jan 2023 00:07:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3n87afdvaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:23 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30S07KJn52888016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Jan 2023 00:07:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BCE92004B;
        Sat, 28 Jan 2023 00:07:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 999DB20040;
        Sat, 28 Jan 2023 00:07:19 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.11.57])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 28 Jan 2023 00:07:19 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 22/31] libbpf: Fix unbounded memory access in bpf_usdt_arg()
Date:   Sat, 28 Jan 2023 01:06:41 +0100
Message-Id: <20230128000650.1516334-23-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128000650.1516334-1-iii@linux.ibm.com>
References: <20230128000650.1516334-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9oHgrp4819khjZ4upZvYRJlqUwF0wnZv
X-Proofpoint-ORIG-GUID: 9oHgrp4819khjZ4upZvYRJlqUwF0wnZv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_14,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 impostorscore=0 mlxlogscore=872 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270216
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Loading programs that use bpf_usdt_arg() on s390x fails with:

    ; if (arg_num >= BPF_USDT_MAX_ARG_CNT || arg_num >= spec->arg_cnt)
    128: (79) r1 = *(u64 *)(r10 -24)      ; frame1: R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0
    129: (25) if r1 > 0xb goto pc+83      ; frame1: R1_w=scalar(umax=11,var_off=(0x0; 0xf))
    ...
    ; arg_spec = &spec->args[arg_num];
    135: (79) r1 = *(u64 *)(r10 -24)      ; frame1: R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0
    ...
    ; switch (arg_spec->arg_type) {
    139: (61) r1 = *(u32 *)(r2 +8)
    R2 unbounded memory access, make sure to bounds check any such access

The reason is that, even though the C code enforces that
arg_num < BPF_USDT_MAX_ARG_CNT, the verifier cannot propagate this
constraint to the arg_spec assignment yet. Help it by forcing r1 back
to stack after comparison.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/usdt.bpf.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
index fdfd235e52c4..0bd4c135acc2 100644
--- a/tools/lib/bpf/usdt.bpf.h
+++ b/tools/lib/bpf/usdt.bpf.h
@@ -130,7 +130,10 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
 	if (!spec)
 		return -ESRCH;
 
-	if (arg_num >= BPF_USDT_MAX_ARG_CNT || arg_num >= spec->arg_cnt)
+	if (arg_num >= BPF_USDT_MAX_ARG_CNT)
+		return -ENOENT;
+	barrier_var(arg_num);
+	if (arg_num >= spec->arg_cnt)
 		return -ENOENT;
 
 	arg_spec = &spec->args[arg_num];
-- 
2.39.1

