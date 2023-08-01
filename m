Return-Path: <bpf+bounces-6578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9503F76B8A6
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 17:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1B21C20F65
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 15:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2501ADC4;
	Tue,  1 Aug 2023 15:32:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093FF20EA
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 15:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F159BC433C7;
	Tue,  1 Aug 2023 15:32:41 +0000 (UTC)
Date: Tue, 1 Aug 2023 11:32:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a
 struct/union
Message-ID: <20230801113240.4e625020@gandalf.local.home>
In-Reply-To: <20230801112036.0d4ee60d@gandalf.local.home>
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
	<169078863449.173706.2322042687021909241.stgit@devnote2>
	<CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
	<20230801085724.9bb07d2c82e5b6c6a6606848@kernel.org>
	<CAADnVQLaFpd2OhqP7W3xWB1b9P2GAKgrVQU1FU2yeNYKbCkT=Q@mail.gmail.com>
	<20230802000228.158f1bd605e497351611739e@kernel.org>
	<20230801112036.0d4ee60d@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Aug 2023 11:20:36 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> The solution was to come up with ftrace_regs, which just means it has all
> the registers to extract the arguments of a function and nothing more. Most

This isn't 100% true. The ftrace_regs may hold a fully filled pt_regs. As
the FTRACE_WITH_REGS callbacks still get passed a ftrace_regs pointer. They
will do:

	void callback(..., struct ftrace_regs *fregs) {
		struct pt_regs *regs = ftrace_get_regs(fregs);


Where ftrace_get_regs() will return the pt_regs only if it is fully filled.
If it is not, then it returns NULL. This was what the x86 maintainers
agreed with.

-- Steve


> implementations just have a partially filled pt_regs within it, but an API
> needs to be used to get to the argument values.


