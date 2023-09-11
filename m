Return-Path: <bpf+bounces-9622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 246AB79A52A
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 09:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06BD41C2042E
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 07:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB7A5380;
	Mon, 11 Sep 2023 07:56:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10355259B
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 07:56:40 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0CC10EB;
	Mon, 11 Sep 2023 00:56:05 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38B7Znx3031186;
	Mon, 11 Sep 2023 07:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=GpzhKR8/McdkmCqDKQeMo96YI3yK4SubpAdN6QgN3yE=;
 b=seVq5hwUUW756yIS6ayprp87KpRdxWhOA8u/4EbhCqv3etqFIWLb72T1MsQef3yZisGE
 sdEg4AVHA4cAwMbNMyN/gzrMfmeEct1R/otMToks4WePIBxNcpY5Gz27enfggUXYDY+d
 +1iWipcUN3NtpaXw8XuOuGnDfx+EUhor4tcaIHD0qxO11vJsF4zcv0DuUeHTTPuaTSbS
 qhEBsbn9myxS8JRYV4ZBjDuB3KLhLNBq+N2kCiseC3dE47VWsIQ2wALpW3d8thN5rF4p
 PIwAU21d/UbWW1XBTSS3Vz4QBlup99tJI1KXVfAxIF3sg03KyhYnhBEvbFBpy9DziZZM UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t1x9v0xj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Sep 2023 07:55:13 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38B7ZnIR031228;
	Mon, 11 Sep 2023 07:55:12 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t1x9v0xh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Sep 2023 07:55:12 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38B6AnIu002410;
	Mon, 11 Sep 2023 07:55:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t158jrgmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Sep 2023 07:55:11 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38B7t9VD42074770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Sep 2023 07:55:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9822B20043;
	Mon, 11 Sep 2023 07:55:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52F9E20040;
	Mon, 11 Sep 2023 07:55:09 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 11 Sep 2023 07:55:09 +0000 (GMT)
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
	<yt9dzg1zokyg.fsf@linux.ibm.com>
	<20230909232435.dfa15f93f1c5eef5b229a7d2@kernel.org>
Date: Mon, 11 Sep 2023 09:55:09 +0200
In-Reply-To: <20230909232435.dfa15f93f1c5eef5b229a7d2@kernel.org> (Masami
	Hiramatsu's message of "Sat, 9 Sep 2023 23:24:35 +0900")
Message-ID: <yt9dy1hdi1pe.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yyI6V9BZkA0dSeZO6Ywsa0RSSWhaV24I
X-Proofpoint-ORIG-GUID: gCtHZox0o0JrZ6J1B9AdkpN-ajnHheY0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_04,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=646
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309110068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Masami Hiramatsu (Google) <mhiramat@kernel.org> writes:

>> > IOW, it is ftrace save regs/restore regs code issue. I need to check how the
>> > function_graph implements it.
>> 
>> gpr2-gpr14 are always saved in ftrace_caller/ftrace_regs_caller(),
>> regardless of the FTRACE_WITH_REGS flags. The only difference is that
>> without the FTRACE_WITH_REGS flag the program status word (psw) is not
>> saved because collecting that is a rather expensive operation.
>
> Thanks for checking that! So s390 will recover those saved registers
> even if FTRACE_WITH_REGS flag is not set? (I wonder what is the requirement
> of the ftrace_regs when returning from ftrace_call() without
> FTRACE_WITH_REGS?)

Yes, it will recover these in all cases.

>> 
>> I used the following commands to test rethook (is that the correct
>> testcase?)
>> 
>> #!/bin/bash
>> cd /sys/kernel/tracing
>> 
>> echo 'r:icmp_rcv icmp_rcv' >kprobe_events
>> echo 1 >events/kprobes/icmp_rcv/enable
>> ping -c 1 127.0.0.1
>> cat trace
>
> No, the kprobe will path pt_regs to rethook.
> Cna you run
>
> echo "f:icmp_rcv%return icmp_rcv" >> dynamic_events

Ah, ok. Seems to work as well:

  ping-481     [001] ..s2.    53.918480: icmp_rcv: (ip_protocol_deliver_rcu+0x42/0x218 <- icmp_rcv)
  ping-481     [001] ..s2.    53.918491: icmp_rcv: (ip_protocol_deliver_rcu+0x42/0x218 <- icmp_rcv)

