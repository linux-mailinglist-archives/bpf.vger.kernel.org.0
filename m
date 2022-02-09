Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA664AE6A3
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 03:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243253AbiBICjm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 21:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244821AbiBICSM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 21:18:12 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F57FC0613CC
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 18:18:11 -0800 (PST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2191sBcc016603;
        Wed, 9 Feb 2022 02:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=r/2W2KjDaElgmhFuGbKdO+t8FyFDkAa5S4OPlOx1hIE=;
 b=eBp8IDMq/AbcmkQJPNswgkWsSkZk30jNFpfy1wQSJ57waYk5Xu1PV0ry7zNWFUTHO16H
 D+HakXQsX27zYQtwNMXSeSr8NYLVSMT3PtBb+h0qMKvPKRq/ezqYt/HcJOiAS4IgdLyq
 qrFJYO5VatNEgvzkT9r5yaCmWlO1knnNprsZKA+nCjAwedfWMS6hWWW4ExVFpY7jNFfV
 LJGGCCxA8DfhqcK8dWu1ChD6N4R+GNf9NxzK8F5KQ9FoztA+oT5npz06ucySaLorqsrX
 jcxwa5IoOSSz96pFm4jMl86eYC6jo6jd8/DAb1qMgBEXWyZB2ZeXydqGpYe/OkiqQUz/ mQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e44bygcn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 02:17:57 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2191uS6V027083;
        Wed, 9 Feb 2022 02:17:57 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e44bygcme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 02:17:56 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2192CuEK001934;
        Wed, 9 Feb 2022 02:17:54 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3e1ggk2m4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 02:17:54 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2192Hptl39911712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Feb 2022 02:17:51 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43E38A4060;
        Wed,  9 Feb 2022 02:17:51 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3ECBA4054;
        Wed,  9 Feb 2022 02:17:50 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Feb 2022 02:17:50 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v5 03/10] selftests/bpf: Use PT_REGS_SYSCALL_REGS in bpf_syscall_macro
Date:   Wed,  9 Feb 2022 03:17:38 +0100
Message-Id: <20220209021745.2215452-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209021745.2215452-1-iii@linux.ibm.com>
References: <20220209021745.2215452-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HwBdlmVofUiM6a7PW_Ov18OPNNbz2zFM
X-Proofpoint-ORIG-GUID: xMxQEgx32iis3LBfgsQ6FvtkMchZlpWs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_08,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202090014
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ensure that PT_REGS_SYSCALL_REGS works correctly.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/bpf_syscall_macro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
index f5c6ef2ff6d1..e7c622cb6a39 100644
--- a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
+++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
@@ -33,7 +33,7 @@ int BPF_KPROBE(handle_sys_prctl)
 	if (pid != filter_pid)
 		return 0;
 
-	real_regs = (struct pt_regs *)PT_REGS_PARM1(ctx);
+	real_regs = PT_REGS_SYSCALL_REGS(ctx);
 
 	/* test for PT_REGS_PARM */
 
-- 
2.34.1

