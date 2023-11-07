Return-Path: <bpf+bounces-14347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448D87E3390
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 04:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1BAF280DA5
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 03:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0685020FB;
	Tue,  7 Nov 2023 03:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEFD138A;
	Tue,  7 Nov 2023 03:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CABC433CB;
	Tue,  7 Nov 2023 03:07:33 +0000 (UTC)
Date: Mon, 6 Nov 2023 22:07:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [RFC PATCH 18/32] function_graph: Fix to initalize ftrace_ops
 for fgraph with ftrace_graph_func
Message-ID: <20231106220735.5e218484@gandalf.local.home>
In-Reply-To: <20231107104924.d992919b8277be36d6fa8455@kernel.org>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
	<169920060974.482486.15664806338999944098.stgit@devnote2>
	<20231106190416.cbd04fdd5bb9cdff72563e64@kernel.org>
	<20231107104924.d992919b8277be36d6fa8455@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Nov 2023 10:49:24 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > I've changed this, because fprobe entry handler is not called via
> > fgraph without this. But maybe I have to set correct gops->ops.func
> > after init?  
> 
> I confirmed that this is right because it is introduced by
> 0c0593b45c9b ("x86/ftrace: Make function graph use ftrace directly")
> which replaces ftrace_stub with ftrace_graph_func (which automatically
> switched by architecture)

Agreed.

-- Steve

