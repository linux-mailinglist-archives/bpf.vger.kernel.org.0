Return-Path: <bpf+bounces-6577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F5F76B883
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 17:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DAB0281A44
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 15:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB761ADC1;
	Tue,  1 Aug 2023 15:20:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57A84DC8F
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 15:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E81C433C7;
	Tue,  1 Aug 2023 15:20:38 +0000 (UTC)
Date: Tue, 1 Aug 2023 11:20:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a
 struct/union
Message-ID: <20230801112036.0d4ee60d@gandalf.local.home>
In-Reply-To: <20230802000228.158f1bd605e497351611739e@kernel.org>
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
	<169078863449.173706.2322042687021909241.stgit@devnote2>
	<CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
	<20230801085724.9bb07d2c82e5b6c6a6606848@kernel.org>
	<CAADnVQLaFpd2OhqP7W3xWB1b9P2GAKgrVQU1FU2yeNYKbCkT=Q@mail.gmail.com>
	<20230802000228.158f1bd605e497351611739e@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Aug 2023 00:02:28 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > If it diverges from that it's a big issue for bpf.
> > We'd have to remove all of fprobe usage.
> > I could be missing something, of course.  
> 
> Yes, so that's the discussion point. At first, I will disable fprobe on BPF
> if ftrace_regs is not compatible with pt_regs, but eventually it should be
> handled to support arm64. I believe BPF can do it since ftrace can do.

Note, for FYI let me give you a little history of where ftrace_regs came
from. When I realized that all function tracing had to save all the
registers that represent the arguments of a function as well as the stack
pointer, I wanted to change the non FTRACE_WITH_REGS to be able to have
access to those registers. This is where FTRACE_WITH_ARGS came from.

My first attempt was to pass a pt_regs that was partially filled, with only
the registers required for the arguments. But the x86 maintainers NACK'd
that. They refused to allow a partially filled pt_regs as that could cause
bugs in the future when a user may assume that the pt_regs is filled but is
not.

The solution was to come up with ftrace_regs, which just means it has all
the registers to extract the arguments of a function and nothing more. Most
implementations just have a partially filled pt_regs within it, but an API
needs to be used to get to the argument values.

When you say BPF uses pt_regs, is the pt_regs full or does it get passed a
partially filled structure?

For fast function entry, ftrace_regs is what should be used if the pt_regs
is not filled. As it is only for use for function entry. It supplies all
regs and stack pointer to get to all the arguments.

-- Steve

