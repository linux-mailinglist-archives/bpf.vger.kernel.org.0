Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E6B6E2758
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 17:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjDNPtp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Apr 2023 11:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDNPtl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 11:49:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8923DB763
        for <bpf@vger.kernel.org>; Fri, 14 Apr 2023 08:49:19 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EEsWGG031581;
        Fri, 14 Apr 2023 15:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=DVq8KK5lx6f3BIFBQXrTqg1S0np9HZyURc9GV4GgRog=;
 b=GwVeWDPyhHvq4auL6wF6C+i1Laf+3bzxONxfMuOxWO/7jSnh++ZtSehraium3u7JgN+6
 yK3fkOluMmmdePyhyBjDN2iAjw0ktPAcHxKpnbF4XFqTx7as8axwAZPSgUj7fXAC83vJ
 HAl2Ul/uD5U3tR1kMfqSNKwu5i/1UU4C2KwBYKO27z7EFnuGRG/tNKty/gXKEPGa1NMl
 uhHJoPfIjRGntJevsHF1/4n/mn9FohBn7MiDSiwk3TnS0v/M2sp52DDKShoCzPt3xI5P
 GtFjsfxiXCrMw7c8I3cxOHQP7Jn+xaJC77FmErOxDXkvXAmzg9V8nEf7rBQlgLBYtZ8y Jw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3py90m2agr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 15:48:02 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33E0bfPQ031496;
        Fri, 14 Apr 2023 15:48:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3pu0m1bsyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 15:48:00 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33EFlu3M16974388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 15:47:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0C4E20043;
        Fri, 14 Apr 2023 15:47:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44FA620040;
        Fri, 14 Apr 2023 15:47:56 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.89.218])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 14 Apr 2023 15:47:56 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH bpf] s390/bpf: Fix bpf_arch_text_poke() with new_addr == NULL
Date:   Fri, 14 Apr 2023 17:47:55 +0200
Message-Id: <20230414154755.184502-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hlVDnS4kCD8r5zGsANDOW2QX9WJG1pwA
X-Proofpoint-GUID: hlVDnS4kCD8r5zGsANDOW2QX9WJG1pwA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_08,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140137
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thomas Richter reported a crash in linux-next with a backtrace similar
to the following one:

	 [<0000000000000000>] 0x0
	([<000000000031a182>] bpf_trace_run4+0xc2/0x218)
	 [<00000000001d59f4>] __bpf_trace_sched_switch+0x1c/0x28
	 [<0000000000c44a3a>] __schedule+0x43a/0x890
	 [<0000000000c44ef8>] schedule+0x68/0x110
	 [<0000000000c4e5ca>] do_nanosleep+0xa2/0x168
	 [<000000000026e7fe>] hrtimer_nanosleep+0xf6/0x1c0
	 [<000000000026eb6e>] __s390x_sys_nanosleep+0xb6/0xf0
	 [<0000000000c3b81c>] __do_syscall+0x1e4/0x208
	 [<0000000000c50510>] system_call+0x70/0x98
	Last Breaking-Event-Address:
	 [<000003ff7fda1814>] bpf_prog_65e887c70a835bbf_on_switch+0x1a4/0x1f0

The problem is that bpf_arch_text_poke() with new_addr == NULL is
susceptible to the following race condition:

	T1                 T2
        -----------------  -------------------
	plt.target = NULL
	                   entry: brcl 0xf,plt
	entry.mask = 0
	                   lgrl %r1,plt.target
	                   br %r1

Fix by setting PLT target to the instruction following `brcl 0xf,plt`
instead of 0. This way T2 will simply resume the execution of the eBPF
program, which is the desired effect of passing new_addr == NULL.

Fixes: f1d5df84cd8c ("s390/bpf: Implement bpf_arch_text_poke()")
Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 7102e4b674a0..f95d7e401b96 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -539,7 +539,7 @@ static void bpf_jit_plt(void *plt, void *ret, void *target)
 {
 	memcpy(plt, bpf_plt, BPF_PLT_SIZE);
 	*(void **)((char *)plt + (bpf_plt_ret - bpf_plt)) = ret;
-	*(void **)((char *)plt + (bpf_plt_target - bpf_plt)) = target;
+	*(void **)((char *)plt + (bpf_plt_target - bpf_plt)) = target ?: ret;
 }
 
 /*
@@ -2015,7 +2015,9 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 	} __packed insn;
 	char expected_plt[BPF_PLT_SIZE];
 	char current_plt[BPF_PLT_SIZE];
+	char new_plt[BPF_PLT_SIZE];
 	char *plt;
+	char *ret;
 	int err;
 
 	/* Verify the branch to be patched. */
@@ -2037,12 +2039,15 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 		err = copy_from_kernel_nofault(current_plt, plt, BPF_PLT_SIZE);
 		if (err < 0)
 			return err;
-		bpf_jit_plt(expected_plt, (char *)ip + 6, old_addr);
+		ret = (char *)ip + 6;
+		bpf_jit_plt(expected_plt, ret, old_addr);
 		if (memcmp(current_plt, expected_plt, BPF_PLT_SIZE))
 			return -EINVAL;
 		/* Adjust the call address. */
+		bpf_jit_plt(new_plt, ret, new_addr);
 		s390_kernel_write(plt + (bpf_plt_target - bpf_plt),
-				  &new_addr, sizeof(void *));
+				  new_plt + (bpf_plt_target - bpf_plt),
+				  sizeof(void *));
 	}
 
 	/* Adjust the mask of the branch. */
-- 
2.39.2

