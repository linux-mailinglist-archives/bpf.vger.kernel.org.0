Return-Path: <bpf+bounces-9315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6416793598
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 08:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E6D1C209CA
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 06:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3BCA54;
	Wed,  6 Sep 2023 06:49:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63B2362
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 06:49:57 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594CBCFA;
	Tue,  5 Sep 2023 23:49:56 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3866fZu1012110;
	Wed, 6 Sep 2023 06:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=hpQKNfo6U16AwKtZqIESlBlwyqrKWSYpNKNB15nKW+8=;
 b=Gvd0G9e5MJiP3pNMOTbMY3r3cTW8cBTX1aeKkrNleEkVuMn33P5AIEXFPC3mhTxXAeTu
 J1IY+Sd4Cq6nsf8ljntTISL/BusDeOpxYi/HRg6FnRcLCiDtGs5L8Wq3r8EQuJn4cCPQ
 smv0H4ff9P5JDsX+9fJYlhvxH9nWOCnWS6lzrO/Ey0G+Ok63mRzvK3x1vZJWY4x3SJWP
 R/c3qyDOk8gbnBmW/xLIIcQLcCODOlMhsOe52hT8jWRAujBX9WY4PxCQVLrYpOGTtY9U
 /OTcQftNAhgpw146HLxAjYuW9QHStWyUx1+VAqsVeF+ib0gPtg0tmjR2afVKknKwaioA Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxmcjr6bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Sep 2023 06:49:16 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3866frXm013184;
	Wed, 6 Sep 2023 06:49:15 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxmcjr6bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Sep 2023 06:49:15 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38659Njk011124;
	Wed, 6 Sep 2023 06:49:14 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svj31rage-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Sep 2023 06:49:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3866nCK561341968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Sep 2023 06:49:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD2372004E;
	Wed,  6 Sep 2023 06:49:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F97120040;
	Wed,  6 Sep 2023 06:49:12 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 Sep 2023 06:49:12 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt
 <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann
 <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark
 Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 4/9] fprobe: rethook: Use ftrace_regs in fprobe exit
 handler and rethook
References: <169280372795.282662.9784422934484459769.stgit@devnote2>
	<169280377434.282662.7610009313268953247.stgit@devnote2>
	<20230904224038.4420a76ea15931aa40179697@kernel.org>
	<yt9d5y4pozrl.fsf@linux.ibm.com>
	<20230905223633.23cd4e6e8407c45b934be477@kernel.org>
Date: Wed, 06 Sep 2023 08:49:11 +0200
In-Reply-To: <20230905223633.23cd4e6e8407c45b934be477@kernel.org> (Masami
	Hiramatsu's message of "Tue, 5 Sep 2023 22:36:33 +0900")
Message-ID: <yt9dzg1zokyg.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VfqUkRXvjBIDEgigSlkozvmCeU6UomUF
X-Proofpoint-GUID: Pni8IGuwgJSKY-NuHenskpMz5GGOBf-A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0 mlxlogscore=869
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060054
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Masami,

Masami Hiramatsu (Google) <mhiramat@kernel.org> writes:

> Thus, we need to ensure that the ftrace_regs which is saved in the ftrace
> *without* FTRACE_WITH_REGS flags, can be used for hooking the function
> return. I saw;
>
> void arch_rethook_prepare(struct rethook_node *rh, struct pt_regs *regs, bool mcount)
> {
>         rh->ret_addr = regs->gprs[14];
>         rh->frame = regs->gprs[15];
>
>         /* Replace the return addr with trampoline addr */
>         regs->gprs[14] = (unsigned long)&arch_rethook_trampoline;
> }
>
> gprs[15] is a stack pointer, so it is saved in ftrace_regs too, but what about
> gprs[14]? (I guess it is a link register)
> We need to read the gprs[14] and ensure that is restored to gpr14 when the
> ftrace is exit even without FTRACE_WITH_REGS flag.
>
> IOW, it is ftrace save regs/restore regs code issue. I need to check how the
> function_graph implements it.

gpr2-gpr14 are always saved in ftrace_caller/ftrace_regs_caller(),
regardless of the FTRACE_WITH_REGS flags. The only difference is that
without the FTRACE_WITH_REGS flag the program status word (psw) is not
saved because collecting that is a rather expensive operation.

I used the following commands to test rethook (is that the correct
testcase?)

#!/bin/bash
cd /sys/kernel/tracing

echo 'r:icmp_rcv icmp_rcv' >kprobe_events
echo 1 >events/kprobes/icmp_rcv/enable
ping -c 1 127.0.0.1
cat trace

which gave me:

ping-686     [001] ..s1.    96.890817: icmp_rcv: (ip_protocol_deliver_rcu+0x42/0x218 <- icmp_rcv)

I applied the following patch on top of your patches to make it compile,
and rethook still seems to work:

commit dab51b0a5b885660630433ac89f8e64a2de0eb86
Author: Sven Schnelle <svens@linux.ibm.com>
Date:   Wed Sep 6 08:06:23 2023 +0200

    rethook wip
    
    Signed-off-by: Sven Schnelle <svens@linux.ibm.com>

diff --git a/arch/s390/kernel/rethook.c b/arch/s390/kernel/rethook.c
index af10e6bdd34e..4e86c0a1a064 100644
--- a/arch/s390/kernel/rethook.c
+++ b/arch/s390/kernel/rethook.c
@@ -3,8 +3,9 @@
 #include <linux/kprobes.h>
 #include "rethook.h"
 
-void arch_rethook_prepare(struct rethook_node *rh, struct pt_regs *regs, bool mcount)
+void arch_rethook_prepare(struct rethook_node *rh, struct ftrace_regs *fregs, bool mcount)
 {
+	struct pt_regs *regs = (struct pt_regs *)fregs;
 	rh->ret_addr = regs->gprs[14];
 	rh->frame = regs->gprs[15];
 
@@ -13,10 +14,11 @@ void arch_rethook_prepare(struct rethook_node *rh, struct pt_regs *regs, bool mc
 }
 NOKPROBE_SYMBOL(arch_rethook_prepare);
 
-void arch_rethook_fixup_return(struct pt_regs *regs,
+void arch_rethook_fixup_return(struct ftrace_regs *fregs,
 			       unsigned long correct_ret_addr)
 {
 	/* Replace fake return address with real one. */
+	struct pt_regs *regs = (struct pt_regs *)fregs;
 	regs->gprs[14] = correct_ret_addr;
 }
 NOKPROBE_SYMBOL(arch_rethook_fixup_return);
@@ -24,9 +26,9 @@ NOKPROBE_SYMBOL(arch_rethook_fixup_return);
 /*
  * Called from arch_rethook_trampoline
  */
-unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs)
+unsigned long arch_rethook_trampoline_callback(struct ftrace_regs *fregs)
 {
-	return rethook_trampoline_handler(regs, regs->gprs[15]);
+	return rethook_trampoline_handler(fregs, fregs->regs.gprs[15]);
 }
 NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
 
diff --git a/arch/s390/kernel/rethook.h b/arch/s390/kernel/rethook.h
index 32f069eed3f3..0fe62424fc78 100644
--- a/arch/s390/kernel/rethook.h
+++ b/arch/s390/kernel/rethook.h
@@ -2,6 +2,6 @@
 #ifndef __S390_RETHOOK_H
 #define __S390_RETHOOK_H
 
-unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs);
+unsigned long arch_rethook_trampoline_callback(struct ftrace_regs *fregs);
 
 #endif


