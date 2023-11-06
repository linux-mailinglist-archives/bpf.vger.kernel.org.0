Return-Path: <bpf+bounces-14286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C797E1E22
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 11:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC8528148E
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 10:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B4E17985;
	Mon,  6 Nov 2023 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NGn9slIR"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BC64422;
	Mon,  6 Nov 2023 10:20:04 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0833493;
	Mon,  6 Nov 2023 02:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TNwnTF7pJUM5wUYf1C8g4YjArZwLod3mYB+unv05Tsc=; b=NGn9slIRFegsAwH8UGyOzYUMiY
	aRIUJUcWoNKfCGvzH/Am3HdI6k+uS84T/KtTE/JPwEMhR/S2qkTK91Yr9S/4P/vmbrjLXDLek/oIj
	x4EOjbYEnv1qt/LKWfhSuIT80HrEc00l4QAiGb165xYYZ+bCWB1GPJj2BMocAjL/JTIE/E+/AwqbU
	X9wQI8qqKoGx+9qvfBPZXKhGZQybfVEZk4iH1ZppUjzoBXO8KntsQGTnZNj9funTF+G72/++SC7fj
	eD2S+Bl5hAJVA/VrNvCwxwjFVlKOrHSgGrFSt6imr0kvTcc+0jedyoAHpcY/ux49iZbxcXLZKjla8
	Z6TP1WDg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qzwhf-005LVK-Uv; Mon, 06 Nov 2023 10:19:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4A31A30049D; Mon,  6 Nov 2023 11:19:32 +0100 (CET)
Date: Mon, 6 Nov 2023 11:19:32 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Florent Revest <revest@chromium.org>,
	linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [RFC PATCH 24/32] x86/ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
Message-ID: <20231106101932.GJ8262@noisy.programming.kicks-ass.net>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
 <169920068069.482486.6540417903833579700.stgit@devnote2>
 <20231105172536.GA7124@noisy.programming.kicks-ass.net>
 <20231105141130.6ef7d8bd@rorschach.local.home>
 <20231105231734.GE3818@noisy.programming.kicks-ass.net>
 <20231105183301.38be5598@rorschach.local.home>
 <20231105183409.424bc368@rorschach.local.home>
 <20231106093850.62702d5bf1779e30cdecf1eb@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106093850.62702d5bf1779e30cdecf1eb@kernel.org>

On Mon, Nov 06, 2023 at 09:38:50AM +0900, Masami Hiramatsu wrote:
> On Sun, 5 Nov 2023 18:34:09 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Sun, 5 Nov 2023 18:33:01 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > For x86_64, that would be:
> > > 
> > >   rdi, rsi, rdx, r8, r9, rsp
> > 
> > I missed rcx.
> 
> I would like to add rax to the list so that it can handle the return value too. :)

So something like so?


diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 897cf02c20b1..71bfe27594a5 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -36,6 +36,10 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 
 #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
 struct ftrace_regs {
+	/*
+	 * Partial, filled with:
+	 *  rax, rcx, rdx, rdi, rsi, r8, r9, rsp
+	 */
 	struct pt_regs		regs;
 };

