Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C583F4A92FE
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 05:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356923AbiBDEUd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 23:20:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64452 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356926AbiBDEUc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Feb 2022 23:20:32 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21437v6a030414;
        Fri, 4 Feb 2022 04:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=G1u+zkhIcUzNm2RfvwqjkGquCDFstiKEFk83F8NbMmA=;
 b=Z0VeSWxBtuKJCQt8NKJV464zmXt50qi3TF1p3I7DQtisDH/5wAYmuDYPFpuDtm0sTMfb
 fRbp71ITTZ9llGDvHGnWXTplyxXNKYabA8Ce38iHZzvqmQgZVHMl9C8cCW9o7YVWKkj5
 P19+pqjb/sOrpJDxped1DpIqdJlDkuQrULd+sz/CVjJv2C7seexvfihDlFU6+OEmHtvB
 LmoDMrLXx7ZCcUdPlCZ4s7F2xkH66fUKEzsQKX+XdBPt3bGCeKMi8NSm0c9QaZuZdGWg
 mLR7xbOrWeekOCYRozHKQew28ilViXg/FOJIYvkTGu5aIgA1NYwJtlH7CR3KfB9Ijh/F wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0qx0vqxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 04:20:09 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 214408Ev025538;
        Fri, 4 Feb 2022 04:20:09 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0qx0vqx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 04:20:09 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2144BV4o011749;
        Fri, 4 Feb 2022 04:20:07 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3e0r109503-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 04:20:07 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2144K4mf37945808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Feb 2022 04:20:04 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28DCDA404D;
        Fri,  4 Feb 2022 04:20:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C197A4040;
        Fri,  4 Feb 2022 04:20:03 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Feb 2022 04:20:03 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 06/10] selftests/bpf: Use PT_REGS_SYSCALL in bpf_syscall_macro
Date:   Fri,  4 Feb 2022 05:19:51 +0100
Message-Id: <20220204041955.1958263-7-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204041955.1958263-1-iii@linux.ibm.com>
References: <20220204041955.1958263-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yjJUzohGzkh3ZMLkMOVMiM6aFRL_Fpbo
X-Proofpoint-ORIG-GUID: 8VJpve8fWGP8fHhRSrpHuyWYVydaVey8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_01,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 phishscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040019
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ensure that PT_REGS_SYSCALL works correctly.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/bpf_syscall_macro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
index f5c6ef2ff6d1..826cc6e433de 100644
--- a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
+++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
@@ -33,7 +33,7 @@ int BPF_KPROBE(handle_sys_prctl)
 	if (pid != filter_pid)
 		return 0;
 
-	real_regs = (struct pt_regs *)PT_REGS_PARM1(ctx);
+	real_regs = PT_REGS_SYSCALL(ctx);
 
 	/* test for PT_REGS_PARM */
 
-- 
2.34.1

