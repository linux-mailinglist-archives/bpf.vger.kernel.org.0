Return-Path: <bpf+bounces-7560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E2477938F
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 17:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670491C21695
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 15:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCA52AB4D;
	Fri, 11 Aug 2023 15:57:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466455692
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 15:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C67C433C8;
	Fri, 11 Aug 2023 15:57:15 +0000 (UTC)
Date: Fri, 11 Aug 2023 11:57:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Florent Revest <revest@chromium.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH v2 4/6] tracing/fprobe: Enable fprobe events with
 CONFIG_DYNAMIC_FTRACE_WITH_ARGS
Message-ID: <20230811115714.171163fc@gandalf.local.home>
In-Reply-To: <20230810093845.7ebbe1ada897a4afe861e331@kernel.org>
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
	<169139095066.324433.15514499924371317690.stgit@devnote2>
	<CABRcYm+8-zYRGjKSPtWQ8_Vq2649=vi71fGvFx2aWM1tnOMYQQ@mail.gmail.com>
	<20230809234512.e3c39b8fffcc6297262f8fc8@kernel.org>
	<CABRcYm+24OLedwiLGj1RyvVg22R5NduORVsYZfXSA_OX5F+riA@mail.gmail.com>
	<20230810093845.7ebbe1ada897a4afe861e331@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Aug 2023 09:38:45 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > Or even just above this function if there are low chances it would get
> > used elsewhere :)  
> 
> Thanks, but since regs_get_kernel_stack_nth() is defined in asm/ptrace.h,
> I think ftrace_regs_get_kernel_stack_nth() is better defined in
> linux/ftrace.h. :)

I agree with Masami.

Thanks,

-- Steve

