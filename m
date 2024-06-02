Return-Path: <bpf+bounces-31138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9118D737D
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 05:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 694881F23508
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 03:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C94AD21;
	Sun,  2 Jun 2024 03:44:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5D8AD2C;
	Sun,  2 Jun 2024 03:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717299854; cv=none; b=NexT8htWiHdlroAnOW1I5NbQFxvuSVcDoMipe2I7t0I3+aAfnTpjoqoUXRaYYmziH02OAjMV5Ku5n0walvvL5L/vHGqe6xdb/d/q9BtGLEehV1AcjM2AqCJell96Xxe2FWHcJmaG0bbqaVw8i2khxZXbOiSGkBAaTqE3cEnRx2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717299854; c=relaxed/simple;
	bh=sW1D5IMZwoXFgRb3cXGhYACHThgvInPjFTzdOzgY4FY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChhMIQPKE8hvj0jxbnuftGt7mGujltV3jvCapBAUTZA55TLCsJW1Qji/Vga2yRULlbXG1TlV65s5fQ0/aFDVWFhAQ/qc7iQc+xOq9kuhOw0Apt8Mq5xYTn1BKkzhIWTmFJ7YbMDaoXXuFpga+QKRJafUjV8W24P8/rEwHh/TFM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23573C32789;
	Sun,  2 Jun 2024 03:44:08 +0000 (UTC)
Date: Sat, 1 Jun 2024 23:44:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v2 00/27] function_graph: Allow multiple users for
 function graph tracing
Message-ID: <20240601234403.568bcb7e@rorschach.local.home>
In-Reply-To: <20240602033744.563858532@goodmis.org>
References: <20240602033744.563858532@goodmis.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 01 Jun 2024 23:37:44 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> hanges since v1: https://lore.kernel.org/linux-trace-kernel/20240525023652.903909489@goodmis.org/
> 
> - Added ftrace helpers to allow an ftrace_ops to be a subop of a
>   managing ftrace_op. That is, the managing ftrace_op will enable
>   functions based off of the filters of the subops beneath it.
>   This could be extended for kprobes and fprobes, as the managing
>   ops does the multiplexing for the subops. This allows for only
>   adding a single callback to ftrace but have multiple ops that
>   represent many users.
> 
> - At the end, I added static branch which also speeds up the
>   code quite a bit.

Also added:

- A couple of kselftests.

-- Steve

