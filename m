Return-Path: <bpf+bounces-7992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD0D77FA37
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 17:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8A7228204C
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 15:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A3814F7F;
	Thu, 17 Aug 2023 15:05:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387A014F75
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 15:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10394C433C8;
	Thu, 17 Aug 2023 15:05:47 +0000 (UTC)
Date: Thu, 17 Aug 2023 11:05:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH RESEND v3 0/3] few fixes for synthetic trace events
Message-ID: <20230817110553.08dbd536@gandalf.local.home>
In-Reply-To: <20230816154928.4171614-1-svens@linux.ibm.com>
References: <20230816154928.4171614-1-svens@linux.ibm.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Aug 2023 17:49:25 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> Hi Steven,
> 
> I'm now sending these patches in one patchset, because the second patch
> has a dependeny on the union vs. cast fix.

Thanks. I'm currently waiting on some other fixes before running them all
through my tests before sending them off to Linus. If they are not ready by
tomorrow, I'll just kick off my tests without them.

-- Steve


> 
> Changes in v3:
> - remove superfluous struct around union trace_synth_field
> 
> Changes in v2:
> - cosmetic changes
> - add struct trace_dynamic_info to include/linux/trace_events.h
> 
> Sven Schnelle (3):
>   tracing/synthetic: use union instead of casts
>   tracing/synthetic: skip first entry for stack traces
>   tracing/synthetic: allocate one additional element for size
> 
>  include/linux/trace_events.h      |  11 ++++
>  kernel/trace/trace.h              |   8 +++
>  kernel/trace/trace_events_synth.c | 103 ++++++++++++------------------
>  3 files changed, 60 insertions(+), 62 deletions(-)
> 


