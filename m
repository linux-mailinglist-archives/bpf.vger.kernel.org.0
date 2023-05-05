Return-Path: <bpf+bounces-155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77966F8B93
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 23:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9458F2810C9
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 21:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967F6101D1;
	Fri,  5 May 2023 21:49:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2752ADF71
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 21:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A37C433EF;
	Fri,  5 May 2023 21:48:58 +0000 (UTC)
Date: Fri, 5 May 2023 17:48:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Florent Revest <revest@chromium.org>, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf@vger.kernel.org
Subject: Re: [PATCH v9.1 07/11] tracing/probes: Add $$args meta argument for
 all function args
Message-ID: <20230505174856.04ca1e6a@gandalf.local.home>
In-Reply-To: <168299390127.3242086.2714570777321787734.stgit@mhiramat.roam.corp.google.com>
References: <168299383880.3242086.7182498102007986127.stgit@mhiramat.roam.corp.google.com>
	<168299390127.3242086.2714570777321787734.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 May 2023 11:18:21 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add the '$$args' meta fetch argument for function-entry probe events. This

Hmm, couldn't we just use $args ? That would be different from $arg1,
$arg2, etc.

The $$ to me would be either the bash pid of current, or perhaps it would
be just to use a dollar sign. I don't see the precedence of $$args being a
"full expand".

-- Steve


> will be expanded to the all arguments of the function and the tracepoint
> using BTF function argument information.
> 
> e.g.
>  #  echo 'p vfs_read $$args' >> dynamic_events
>  #  echo 'f vfs_write $$args' >> dynamic_events
>  #  echo 't sched_overutilized_tp $$args' >> dynamic_events
>  # cat dynamic_events
> p:kprobes/p_vfs_read_0 vfs_read file=file buf=buf count=count pos=pos
> f:fprobes/vfs_write__entry vfs_write file=file buf=buf count=count pos=pos
> t:tracepoints/sched_overutilized_tp sched_overutilized_tp rd=rd overutilized=overutilized
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---

