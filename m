Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854C567F331
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjA1Adh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbjA1Adf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:33:35 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC0778AC7
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 16:33:34 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RNBpl4024195;
        Sat, 28 Jan 2023 00:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9UNJqll6DAQUDjRw/kCGZdHluHj+n7gsroR8cEgieQw=;
 b=CxRex5RkdM30SiGGpBp01DmyjJm76UB41Z6tBqpPrke7PNKHCdBK5SjoGYW4bF+2lgPj
 sMJZwai+rKdxvWi5HwbUY66gekFi+x/MYUgi3ZfZI6nfhmGjMa47IOYmvq8YylDuBVO+
 AXqCIAjI0r+oJZ9S7sDYk+T2nwuBX9nWoKRBLHw1Q/2v8f4KV+ff4JAOV8FhSo+hNZBx
 XQFHNhEeEpDiPb1uOappKGDLOYcLX2S0RwMJnqzQ5gb3tyU2u/ildfrxRFbvQEE1YpX4
 sUMbk3eGOjpKYuq1POjsG5mnodknXopAane4DS6Hr+ZnT3AFAHPa46di6kpU4y7qpnu8 tw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncr2nsc6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:33:19 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30RNUZqN015122;
        Sat, 28 Jan 2023 00:07:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3n87p6dug5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30S07FtN36045304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Jan 2023 00:07:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 788EE2004B;
        Sat, 28 Jan 2023 00:07:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC5E720040;
        Sat, 28 Jan 2023 00:07:14 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.11.57])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 28 Jan 2023 00:07:14 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 17/31] selftests/bpf: Fix vmlinux test on s390x
Date:   Sat, 28 Jan 2023 01:06:36 +0100
Message-Id: <20230128000650.1516334-18-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128000650.1516334-1-iii@linux.ibm.com>
References: <20230128000650.1516334-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LkJMu2MkwtT5cmKvdclkugq_Pki2_Een
X-Proofpoint-ORIG-GUID: LkJMu2MkwtT5cmKvdclkugq_Pki2_Een
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_15,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301280003
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use a syscall macro to access the nanosleep()'s first argument;
currently the code uses gprs[2] instead of orig_gpr2.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/test_vmlinux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_vmlinux.c b/tools/testing/selftests/bpf/progs/test_vmlinux.c
index e9dfa0313d1b..4b8e37f7fd06 100644
--- a/tools/testing/selftests/bpf/progs/test_vmlinux.c
+++ b/tools/testing/selftests/bpf/progs/test_vmlinux.c
@@ -42,7 +42,7 @@ int BPF_PROG(handle__raw_tp, struct pt_regs *regs, long id)
 	if (id != __NR_nanosleep)
 		return 0;
 
-	ts = (void *)PT_REGS_PARM1_CORE(regs);
+	ts = (void *)PT_REGS_PARM1_CORE_SYSCALL(regs);
 	if (bpf_probe_read_user(&tv_nsec, sizeof(ts->tv_nsec), &ts->tv_nsec) ||
 	    tv_nsec != MY_TV_NSEC)
 		return 0;
@@ -60,7 +60,7 @@ int BPF_PROG(handle__tp_btf, struct pt_regs *regs, long id)
 	if (id != __NR_nanosleep)
 		return 0;
 
-	ts = (void *)PT_REGS_PARM1_CORE(regs);
+	ts = (void *)PT_REGS_PARM1_CORE_SYSCALL(regs);
 	if (bpf_probe_read_user(&tv_nsec, sizeof(ts->tv_nsec), &ts->tv_nsec) ||
 	    tv_nsec != MY_TV_NSEC)
 		return 0;
-- 
2.39.1

