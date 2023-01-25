Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE2867BEC4
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 22:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236828AbjAYVj4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 16:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236393AbjAYVjx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 16:39:53 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288254ABFD
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 13:39:46 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PKLcIP004478;
        Wed, 25 Jan 2023 21:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9UNJqll6DAQUDjRw/kCGZdHluHj+n7gsroR8cEgieQw=;
 b=jLvbdqThLKJLopWqQDtlKLAXIKwNgiTjsNB0Uw/zaNGgOCqRDqLBncmCXiJjcM1eNHX2
 5A6QiDNQQCPv+Mm4MV1/FEJWCm1ktbnxJKxU2sadRax5S1oYPgFr/3yjBMzzkbEjJ572
 NsQqyeHW/njOUr8V/Ym6IHz8Z0U7Hq+TYxcos8cyG2RzYbX/qkB4WdliQnKcbSDW/w2L
 Z9R58LCZJlI5bJ9cDC6A/dPa3ah2bNtW2m1hG0doX1/ApcBwH8hoXPu/gyOgPA+5LnuF
 q/XcSxcOWRMG3OnDzp3Ds9eBH1iak3MFHKwHV8Wrg2o/HnsvWa7CIG0M4cLf9BUoJ4ZJ Jw== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nb8yu5tq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:39:33 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PEZBQF015305;
        Wed, 25 Jan 2023 21:39:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3n87p6c0wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:39:31 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PLdSgc46989650
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 21:39:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CE682004F;
        Wed, 25 Jan 2023 21:39:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C48F82004B;
        Wed, 25 Jan 2023 21:39:27 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.209.149])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 21:39:27 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 16/24] selftests/bpf: Fix vmlinux test on s390x
Date:   Wed, 25 Jan 2023 22:38:09 +0100
Message-Id: <20230125213817.1424447-17-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125213817.1424447-1-iii@linux.ibm.com>
References: <20230125213817.1424447-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BEwd13yuDKan6GmB_Zm9wSEJZ34ZQ5LP
X-Proofpoint-ORIG-GUID: BEwd13yuDKan6GmB_Zm9wSEJZ34ZQ5LP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250193
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

