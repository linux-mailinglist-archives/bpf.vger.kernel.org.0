Return-Path: <bpf+bounces-7595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 755EA7795D7
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 19:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E92281C0D
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 17:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ADE219CA;
	Fri, 11 Aug 2023 17:10:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55EA18AE1
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 17:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF09C433C8;
	Fri, 11 Aug 2023 17:10:03 +0000 (UTC)
Date: Fri, 11 Aug 2023 13:10:01 -0400
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
Subject: Re: [RFC PATCH v2 1/6] fprobe: Use fprobe_regs in fprobe entry
 handler
Message-ID: <20230811131001.7b22a17d@gandalf.local.home>
In-Reply-To: <20230810071330.d41a728f996f76e3243f469e@kernel.org>
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
	<169139091575.324433.13168120610633669432.stgit@devnote2>
	<CABRcYmKRAbOuqNQm5mCwC9NWbtcz1JJDYL_h5x6dK77SJ5FRkA@mail.gmail.com>
	<20230809231011.b125bd68887a5659db59905e@kernel.org>
	<CABRcYmKEd=zmriE8VUnSTvybwA962r60+QaRJZK=KNqYixd_eg@mail.gmail.com>
	<CABRcYmLHfQsjwf7dk+A0Q96iANhj60M0g_xRjVyMUY9LJPybNg@mail.gmail.com>
	<20230810071330.d41a728f996f76e3243f469e@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Aug 2023 07:13:30 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > 
> > I hope that makes my thoughts clearer? It's a hairy topic ahah  
> 
> Ah, I see your point.
> 
> static void fprobe_init(struct fprobe *fp)
> {
>         fp->nmissed = 0;
>         if (fprobe_shared_with_kprobes(fp))
>                 fp->ops.func = fprobe_kprobe_handler;
>         else
>                 fp->ops.func = fprobe_handler;
>         fp->ops.flags |= FTRACE_OPS_FL_SAVE_REGS; <---- This flag!
> }
> 
> So it should be FTRACE_OPS_FL_ARGS. Let me fix that.

Yes, this was the concern that I was bringing up, where I did not see an
advantage of fprobes over kprobes using ftrace, because they both were
saving all registers.

-- Steve

