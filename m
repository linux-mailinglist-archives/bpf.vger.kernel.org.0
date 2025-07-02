Return-Path: <bpf+bounces-62140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CB9AF5DA8
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 17:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03ED1C23991
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 15:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C225E2E7BAA;
	Wed,  2 Jul 2025 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JcaKcfzG"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26793196D8;
	Wed,  2 Jul 2025 15:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751471668; cv=none; b=ayTM8OpNqfHbHIOc7dTctKv5wULlR60LM6vIvZbw6mcQ0FvOcnUTVFEglK5zXGcO6+JoWzDB6288tHp8KpJO0izxGLcXsdK74ACTDwtQBwo7iGoU/AWszOt/0uO6o3b+TBzvLkpqG55E3SxhhaRGoCnwfmzdsep5UfGEReYZYIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751471668; c=relaxed/simple;
	bh=1F43+7fwHzAd9yWVEVAylcR0AdP9hhm3Sf59ofmBB58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bPfrqt/eZwY0mfUV5FcglScq2AbOfQcB4st54aqzIuRzI1v1kKadmLCx8s8XHGUIDrxomjfLQcC4qRFbTpDGibrCtU2Q3x1rbVMK7V3+1Cfu2Ri4r1tuOu1OmkAe5OlOj7rWBx4SYcm/9pXgTr0POhkZGjjfiCtIlO6vKCJJ8g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JcaKcfzG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562ESsmV014229;
	Wed, 2 Jul 2025 15:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LtTTnJ
	nGndDo0Uo8vt93cMjsCMckI6r3gJDGK3u+F90=; b=JcaKcfzGh/3gSovt2lTpqj
	6XsqPupj0l9CqN+wDXUTkecMFjp6/lqX93y47jJWblLwiapVh1CIfCToGimL7A8/
	sZR6fDJMmdlTfgtd+8ttLzEydPUUzmD09ccS1LNP1XDz1Cazjjify/uVztKqG78Q
	hcIXQ2ey4TR4TDABacjdiHsVljKUsknwGPCR/OUwoFmXNVJLDy19X1lorBPKOvmO
	aq2AbxVs9C2etk6VT8gYD2EAAKykjqhFs5ZCA/6pIwJOYhCp83ka906IvWm601KM
	3pV/+MWP4fbZx2yRHzpv8axHMb2Csff99ppmUpv9VQ92wP0AWlo+rldluAxlzTSQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84dejsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 15:53:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 562F7mZZ021354;
	Wed, 2 Jul 2025 15:53:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jwe3g0dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 15:53:11 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 562Fr7In43385296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Jul 2025 15:53:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FAB320043;
	Wed,  2 Jul 2025 15:53:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CB8D20040;
	Wed,  2 Jul 2025 15:53:07 +0000 (GMT)
Received: from [9.152.222.224] (unknown [9.152.222.224])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Jul 2025 15:53:07 +0000 (GMT)
Message-ID: <d0aa861d-e1bb-4ab4-8ccb-d9fdc39738a9@linux.ibm.com>
Date: Wed, 2 Jul 2025 17:53:05 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 07/14] unwind_user/deferred: Make unwind deferral
 requests NMI-safe
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
References: <20250701005321.942306427@goodmis.org>
 <20250701005451.737614486@goodmis.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20250701005451.737614486@goodmis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8koNIRB4XGfsbHXgfXDECKQMOD4e7nav
X-Proofpoint-GUID: 8koNIRB4XGfsbHXgfXDECKQMOD4e7nav
X-Authority-Analysis: v=2.4 cv=Ib6HWXqa c=1 sm=1 tr=0 ts=686555e8 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=yazbiPPT3PS1vEbXeL8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDEzMCBTYWx0ZWRfXy+OmPy/xqIQ1 2E0dcXZu0Cm8CupqOR5zUrGy115/Hfy36QAnvQjKNhd17eA6mVNY08i3UDck4207Ka8gCzY8j/E AkCUeVAegpnfURtjZuvRef9nh1QM3oFPyeKduEL+mB3sqRwUzSQG68EwiU861JMP6INc/5QZAqy
 ys5JEXKaQJrmlrU0FHIdOlNoj5Sivhlk3JW5kKLGLgaJDk0+ULJmkAMvC5Yb16I6RTbZk+cQlS3 H1jL430VO91K3KVJ859HZzMQCupPqRQ93x/jzte9eaTvQpTaMEXuqs5W+bELmS6DsL1gYCg3+Q1 R+zvCZTi+dxTscoMvHOx3Z3UgKsvFg9DOMr4mvq0bvhfkkX5MeXoA1wgh+U6MY4mv20rKnO5e4f
 zV189DnjZREklahV4FN/i0Xv2kPGXh2Ym/WaSmGCM0g/HoDmkYcp5GMTlq8mH+pJnZaLrIdL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_02,2025-07-02_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020130

Hello Steve!

On 01.07.2025 02:53, Steven Rostedt wrote:
> Make unwind_deferred_request() NMI-safe so tracers in NMI context can
> call it and safely request a user space stacktrace when the task exits.

> diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h

> @@ -2,6 +2,9 @@
>  #ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
>  #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
>  
> +#include <asm/local64.h>
> +#include <asm/local.h>

This creates the following circular dependency, that breaks the build on
s390 as follows, whenever local64.h is included first, so that local64_t
is not yet defined when unwind_deferred_types.h gets included down the
line:


Circular dependency:

include/linux/unwind_deferred_types.h
arch/<arch>/include/generated/asm/local64.h
include/asm-generic/local64.h
include/linux/percpu.h
include/linux/sched.h
include/linux/unwind_deferred_types.h


Compile error on s390:

  CC      net/ipv4/proc.o
In file included from ./include/linux/sched.h:49,
                 from ./include/linux/percpu.h:12,
                 from ./include/asm-generic/local64.h:5,
                 from ./arch/s390/include/generated/asm/local64.h:1,
                 from ./include/linux/u64_stats_sync.h:71,
                 from ./include/net/snmp.h:47,
                 from ./include/net/netns/mib.h:5,
                 from ./include/net/net_namespace.h:17,
                 from net/ipv4/proc.c:31:
./include/linux/unwind_deferred_types.h:17:9: error: unknown type name ‘local64_t’; did you mean ‘local_t’?
   17 |         local64_t               timestamp;
      |         ^~~~~~~~~
      |         local_t


Reason it fails on s390:

net/ipv4/proc.c
+- include/net/net_namespace.h
   +- include/net/netns/mib.h
      +- include/net/snmp.h
         +- include/linux/u64_stats_sync.h
            +- arch/s390/include/generated/asm/local64.h   <-- ISSUE: local64.h gets included before unwind_deferred_types.h
               +- include/asm-generic/local64.h
                  +- include/linux/percpu.h
                     +- include/linux/sched.h
                        +- include/linux/unwind_deferred_types.h   <-- ERROR: local64_t not yet defined


Reason it does not fail on x86:

net/ipv4/proc.c
+- include/net/net_namespace.h
   +- include/linux/workqueue.h
   |  +- include/linux/timer.h
   |     +- include/linux/ktime.h
   |        +- include/linux/jiffies.h
   |           +- include/linux/time.h
   |               +- include/linux/time32.h
   |                  +- include/linux/timex.h
   |                     +- arch/x86/include/asm/timex.h
   |                        +- arch/x86/include/asm/tsc.h
   |                           +- arch/x86/include/asm/msr.h
   |                              +- include/linux/percpu.h
   |                                 +- include/linux/sched.h
   |                                    +- include/linux/unwind_deferred_types.h   <-- OK: unwind_deferred_types.h gets included before local64.h
   |                                       +- arch/x86/include/generated/asm/local64.h
   |                                          +- include/asm-generic/local64.h
   |                                           [ +- include/linux/percpu.h ]
   +- include/net/netns/mib.h
      +- include/net/snmp.h
         +- include/linux/u64_stats_sync.h
            +- arch/x86/include/generated/asm/local64.h   <-- OK: local64.h comes after unwind_deferred_types.h
             [ +- include/asm-generic/local64.h ]
                [ +- include/linux/percpu.h ]
                   [ +- include/linux/sched.h ]
                      [ +- include/linux/unwind_deferred_types.h ]


My colleague Heiko Carstens (on Cc) suggested the following potential fix
that breaks the circular dependency, provided local[64].h does not ever
need percpu.h.  At least I verified that defconfig x86 and s390 builds
still work.

diff --git a/include/asm-generic/local.h b/include/asm-generic/local.h
index 7f97018df66f..3e7ce6a9e18e 100644
--- a/include/asm-generic/local.h
+++ b/include/asm-generic/local.h
@@ -2,7 +2,6 @@
 #ifndef _ASM_GENERIC_LOCAL_H
 #define _ASM_GENERIC_LOCAL_H
 
-#include <linux/percpu.h>
 #include <linux/atomic.h>
 #include <asm/types.h>
 
diff --git a/include/asm-generic/local64.h b/include/asm-generic/local64.h
index 14963a7a6253..1f9af89916cb 100644
--- a/include/asm-generic/local64.h
+++ b/include/asm-generic/local64.h
@@ -2,7 +2,6 @@
 #ifndef _ASM_GENERIC_LOCAL64_H
 #define _ASM_GENERIC_LOCAL64_H
 
-#include <linux/percpu.h>
 #include <asm/types.h>

> +
>  struct unwind_cache {
>  	unsigned int		nr_entries;
>  	unsigned long		entries[];
> @@ -10,8 +13,8 @@ struct unwind_cache {
>  struct unwind_task_info {
>  	struct unwind_cache	*cache;
>  	struct callback_head	work;
> -	u64			timestamp;
> -	int			pending;
> +	local64_t		timestamp;
> +	local_t			pending;
>  };
>  
>  #endif /* _LINUX_UNWIND_USER_DEFERRED_TYPES_H */

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
+49-7031-16-1128 Office
jremus@de.ibm.com

IBM

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/


