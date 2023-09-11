Return-Path: <bpf+bounces-9642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB1F79A882
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 16:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D79B1C20953
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 14:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBC41171C;
	Mon, 11 Sep 2023 14:16:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021ED1170E
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 14:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A3BC433C7;
	Mon, 11 Sep 2023 14:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694441766;
	bh=KXMxuh2b3iJk8T/pEtBjYdbcbrbdQSKwgRi4Ihd42Cc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NsiA08LeJ2l2QqaF2Mc6EPGMtZH+dDzcgipfV7b7nC0+R82itaFMgvZHm/PC3Ag/8
	 wOkdRAEiJhReJPG82IycnW2brztwBd70iPPejBKp1KgNyVGDJxhcQd0z8yIjZNRwUX
	 R8ujtKfFqjA0bT3CTjlYrXErPATtpmyBqwOuokY3EdPHaoawjT4bZt0o1fE0IybKo/
	 8QB3w7+XEI/s2YMx3Qmg7R5zIpsUOgjdCVSy6o2eb+/Rwr/TMKBrwVPNXD124U9OCr
	 ObNs/a+bbt/g7xKzgPTtvGSapBb3o+vGb7u7T3o1wYB8NJ7Dpir2rLEwMATY/k2+gp
	 CdSFXxmQUopOQ==
Date: Mon, 11 Sep 2023 23:15:59 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 4/9] fprobe: rethook: Use ftrace_regs in fprobe exit
 handler and rethook
Message-Id: <20230911231559.67dc02ec42995042b7e92c58@kernel.org>
In-Reply-To: <yt9dy1hdi1pe.fsf@linux.ibm.com>
References: <169280372795.282662.9784422934484459769.stgit@devnote2>
	<169280377434.282662.7610009313268953247.stgit@devnote2>
	<20230904224038.4420a76ea15931aa40179697@kernel.org>
	<yt9d5y4pozrl.fsf@linux.ibm.com>
	<20230905223633.23cd4e6e8407c45b934be477@kernel.org>
	<yt9dzg1zokyg.fsf@linux.ibm.com>
	<20230909232435.dfa15f93f1c5eef5b229a7d2@kernel.org>
	<yt9dy1hdi1pe.fsf@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Sep 2023 09:55:09 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> Masami Hiramatsu (Google) <mhiramat@kernel.org> writes:
> 
> >> > IOW, it is ftrace save regs/restore regs code issue. I need to check how the
> >> > function_graph implements it.
> >> 
> >> gpr2-gpr14 are always saved in ftrace_caller/ftrace_regs_caller(),
> >> regardless of the FTRACE_WITH_REGS flags. The only difference is that
> >> without the FTRACE_WITH_REGS flag the program status word (psw) is not
> >> saved because collecting that is a rather expensive operation.
> >
> > Thanks for checking that! So s390 will recover those saved registers
> > even if FTRACE_WITH_REGS flag is not set? (I wonder what is the requirement
> > of the ftrace_regs when returning from ftrace_call() without
> > FTRACE_WITH_REGS?)
> 
> Yes, it will recover these in all cases.

Thanks for the confirmation!

> 
> >> 
> >> I used the following commands to test rethook (is that the correct
> >> testcase?)
> >> 
> >> #!/bin/bash
> >> cd /sys/kernel/tracing
> >> 
> >> echo 'r:icmp_rcv icmp_rcv' >kprobe_events
> >> echo 1 >events/kprobes/icmp_rcv/enable
> >> ping -c 1 127.0.0.1
> >> cat trace
> >
> > No, the kprobe will path pt_regs to rethook.
> > Cna you run
> >
> > echo "f:icmp_rcv%return icmp_rcv" >> dynamic_events
> 
> Ah, ok. Seems to work as well:
> 
>   ping-481     [001] ..s2.    53.918480: icmp_rcv: (ip_protocol_deliver_rcu+0x42/0x218 <- icmp_rcv)
>   ping-481     [001] ..s2.    53.918491: icmp_rcv: (ip_protocol_deliver_rcu+0x42/0x218 <- icmp_rcv)

Nice!
OK, then s390 is safe to use ftrace_regs :) 

Thanks!


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

