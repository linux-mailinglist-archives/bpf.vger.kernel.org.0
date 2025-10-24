Return-Path: <bpf+bounces-72100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC65C06991
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 15:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E123BB39E
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 13:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BF231E0FD;
	Fri, 24 Oct 2025 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k2l2pBeZ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABBA31AF3C;
	Fri, 24 Oct 2025 13:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761314337; cv=none; b=d6/1UMuGfZVJAPOXqsQ/97PwIeAyoATQlkibt3rHN9Rwt+d8TxQyiB9RO0szAMywXZ1+F5z3Z+rQzkrQDPir9GFaQYWi9UGNBrixIGFzKXg9sX1EdfeBZtw0a7gZYx8pQNn8Ax+JPmYaqYTOdjQeYdPPPEJZbl/nJPdaUKiTuHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761314337; c=relaxed/simple;
	bh=ti2YlCdg7/IX3KwnAS6Sf4dgIxinxb5TfF+v7HA9BA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DOZikqwrli0nHrhSc2RvMdy8jHys+RPAn6uZYXqyhMpq/lErZTkWtrDN1wMj73SVjssXBwZKBlD/Xya602Ay81YaRgrrxeqUePw62UDnS3HyDpYktnLR7zRQCO1SjkjjN0nXBTJT0gTZ4y5oJG3q8z7ZYq+dsSAVHzLXDhWZNUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k2l2pBeZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O6L97P021232;
	Fri, 24 Oct 2025 13:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SBCmPs
	cs3S5INCGzC8+i3ANW+h7O9UXTcpzHoDRgfLs=; b=k2l2pBeZIMEYzKH+cXrBtg
	7Xhu6kw6FCS8z1SxjMlEKpnc3n425+Xyevk7DgtVFw06PUOvTQSab78QwWd58OJ9
	ABOv5VqvCa1l8pmq7yfc4g7dAICWt1cnMNXdVwRrM0/lpbSQNK3pP6aZHc9FVWfA
	fJW5gznSBogfRtzndPEtRIxX8WeKHO4GJAhQ0FgbqCmCpUKlwC/L212gizUqhbeA
	SD3eLjeVCVUVz2BdSJ8G7NwMS+LqY5RsSt4pZz9L9rY7xoGfkMe2V6KvP7nvRQ+v
	GApXVnZEa8Lv+l5g29WTYLxSzUbrI6Mqn+L6yrnZwEFs9d5oiyi0ULdhivlPNxFw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cp5an-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 13:58:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59OADM7D024953;
	Fri, 24 Oct 2025 13:58:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqkb9pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 13:58:26 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59ODwMEW40304958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 13:58:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D3A220043;
	Fri, 24 Oct 2025 13:58:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7BE620040;
	Fri, 24 Oct 2025 13:58:20 +0000 (GMT)
Received: from [9.111.177.85] (unknown [9.111.177.85])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Oct 2025 13:58:20 +0000 (GMT)
Message-ID: <a59509f0-5888-4663-9e82-98e27fc3e813@linux.ibm.com>
Date: Fri, 24 Oct 2025 15:58:20 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 0/4] perf: Support the deferred unwinding
 infrastructure
To: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, x86@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
        Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
References: <20251007214008.080852573@kernel.org>
 <20251023150002.GR4067720@noisy.programming.kicks-ass.net>
 <20251024092926.GI4068168@noisy.programming.kicks-ass.net>
 <20251024104119.GJ4068168@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20251024104119.GJ4068168@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YqzE08SslWcLdVlgQuKDR0Iho8i3YFD5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX9Ot2KV0wySba
 b0q234bJt151fWw9ksnBlWC/BXnl9SbFfqnBUCqGxzQbbhDMSMURkb0rulPA+bAKpnbX17OHGI8
 SpTw6OZPn9YNPFVGZhvWlb0OnB9+ZF9vEaY+NilQHETjMWfJ5wv6jyU6rzKvli8ACPdKfkm8Vbl
 TVjI+2YKH/OjXK9uHuN32CaeWryM8hK6thZa4kHRNszfutEsDvq3wZBkerrkfYnZ6E/LIwIQjPc
 NecalS1FCmPSdUDPld7ONBgdD1fReViF++bfRhIrREzeqCxXQ+Stxi/DPirsqvmsEoMNdIvwXM0
 uOkLHNEC7Upwz3Gr9oY5XH2Eey2E7RkrzHWY36y+S9NEboSh2x+5oSeJ9vwp2cpcHGedE2SE6hQ
 C9/16obwvP3YoPWXCWwfskLEpIg4vw==
X-Proofpoint-GUID: YqzE08SslWcLdVlgQuKDR0Iho8i3YFD5
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68fb8603 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=AVpJfSmXYWXoPBcYQzwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

Hello Peter!

On 10/24/2025 12:41 PM, Peter Zijlstra wrote:
> On Fri, Oct 24, 2025 at 11:29:26AM +0200, Peter Zijlstra wrote:
>> On Thu, Oct 23, 2025 at 05:00:02PM +0200, Peter Zijlstra wrote:
>>
>>> Trouble is, pretty much every unwind is 510 entries long -- this cannot
>>> be right. I'm sure there's a silly mistake in unwind/user.c but I'm too
>>> tired to find it just now. I'll try again tomorrow.
>>
>> PEBKAC
> 
> Anyway, while staring at this, I noted that the perf userspace unwind
> code has a few bits that are missing from the new shiny thing.
> 
> How about something like so? This add an optional arch specific unwinder
> at the very highest priority (bit 0) and uses that to do a few extra
> bits before disabling itself and falling back to whatever lower prio
> unwinder to do the actual unwinding.

unwind user sframe does not need any of this special handling, because
it knows for each IP whether the SP or FP is the CFA base register
and whether the FP and RA have been saved.

Isn't this actually specific to unwind user fp?  If the IP is at
function entry, then the FP has not been setup yet.  I think unwind user
fp could handle this using an arch specific is_uprobe_at_func_entry() to
determine whether to use a new frame_fp_entry instead of frame_fp.  For
x86 the following frame_fp_entry should work, if I am not wrong:

#define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)	\
	.cfa_off	=  1*(ws),		\
	.ra_off		= -1*(ws),		\
	.fp_off		= 0,			\
	.use_fp		= false,

Following roughly outlines the required changes:

diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c

-static int unwind_user_next_fp(struct unwind_user_state *state)
+static int unwind_user_next_common(struct unwind_user_state *state,
+                                  const struct unwind_user_frame *frame,
+                                  struct pt_regs *regs)

@@ -71,6 +83,7 @@ static int unwind_user_next_common(struct unwind_user_state *state,
        state->sp = sp;
        if (frame->fp_off)
                state->fp = fp;
+       state->topmost = false;
        return 0;
 }
@@ -154,6 +167,7 @@ static int unwind_user_start(struct unwind_user_state *state)
        state->sp = user_stack_pointer(regs);
        state->fp = frame_pointer(regs);
        state->ws = compat_user_mode(regs) ? sizeof(int) : sizeof(long);
+       state->topmost = true;

        return 0;
 }

static int unwind_user_next_fp(struct unwind_user_state *state)
{
	const struct unwind_user_frame fp_frame = {
		ARCH_INIT_USER_FP_FRAME(state->ws)
	};
	const struct unwind_user_frame fp_entry_frame = {
		ARCH_INIT_USER_FP_ENTRY_FRAME(state->ws)
	};
	struct pt_regs *regs = task_pt_regs(current);

	if (state->topmost && is_uprobe_at_func_entry(regs))
		return unwind_user_next_common(state, &fp_entry_frame, regs);
	else
		return unwind_user_next_common(state, &fp_frame, regs);
}

diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
@@ -43,6 +43,7 @@ struct unwind_user_state {
        unsigned int                            ws;
        enum unwind_user_type                   current_type;
        unsigned int                            available_types;
+       bool                                    topmost;
        bool                                    done;
 };

What do you think?

> +++ b/arch/x86/kernel/unwind_user.c
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <linux/unwind_user.h>
> +#include <linux/uprobes.h>
> +#include <linux/uaccess.h>
> +#include <linux/sched/task_stack.h>
> +#include <asm/processor.h>
> +#include <asm/tlbflush.h>
> +
> +int unwind_user_next_arch(struct unwind_user_state *state)
> +{
> +	struct pt_regs *regs = task_pt_regs(current);
> +
> +	/* only once, on the first iteration */
> +	state->available_types &= ~UNWIND_USER_TYPE_ARCH;
> +
> +	/* We don't know how to unwind VM86 stacks. */
> +	if (regs->flags & X86_VM_MASK) {
> +		state->done = true;
> +		return 0;
> +	}
> +
> +	/*
> +	 * If we are called from uprobe handler, and we are indeed at the very
> +	 * entry to user function (which is normally a `push %rbp` instruction,
> +	 * under assumption of application being compiled with frame pointers),
> +	 * we should read return address from *regs->sp before proceeding
> +	 * to follow frame pointers, otherwise we'll skip immediate caller
> +	 * as %rbp is not yet setup.
> +	 */
> +	if (!is_uprobe_at_func_entry(regs))
> +		return -EINVAL;
> +
> +#ifdef CONFIG_COMPAT
> +	if (state->ws == sizeof(int)) {
> +		unsigned int retaddr;
> +		int ret = get_user(retaddr, (unsigned int __user *)regs->sp);
> +		if (ret)
> +			return ret;
> +
> +		state->ip = retaddr;
> +		return 0;
> +	}
> +#endif
> +	unsigned long retaddr;
> +	int ret = get_user(retaddr, (unsigned long __user *)regs->sp);
> +	if (ret)
> +		return ret;
> +
> +	state->ip = retaddr;
> +	return 0;
> +}

Above would then not be needed, as the unwind_user_next_fp() logic would
do the right thing.

> +++ b/arch/x86/kernel/uprobes.c
> @@ -1791,3 +1791,35 @@ bool arch_uretprobe_is_alive(struct retu
>  	else
>  		return regs->sp <= ret->stack;
>  }
> +
> +/*
> + * Heuristic-based check if uprobe is installed at the function entry.
> + *
> + * Under assumption of user code being compiled with frame pointers,
> + * `push %rbp/%ebp` is a good indicator that we indeed are.
> + *
> + * Similarly, `endbr64` (assuming 64-bit mode) is also a common pattern.
> + * If we get this wrong, captured stack trace might have one extra bogus
> + * entry, but the rest of stack trace will still be meaningful.
> + */
> +bool is_uprobe_at_func_entry(struct pt_regs *regs)
> +{
> +	struct arch_uprobe *auprobe;
> +
> +	if (!current->utask)
> +		return false;
> +
> +	auprobe = current->utask->auprobe;
> +	if (!auprobe)
> +		return false;
> +
> +	/* push %rbp/%ebp */
> +	if (auprobe->insn[0] == 0x55)
> +		return true;
> +
> +	/* endbr64 (64-bit only) */
> +	if (user_64bit_mode(regs) && is_endbr((u32 *)auprobe->insn))
> +		return true;
> +
> +	return false;
> +}
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


