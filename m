Return-Path: <bpf+bounces-8160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F68782CF4
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 17:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A736E280EE8
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 15:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55DF846F;
	Mon, 21 Aug 2023 15:09:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE7D79F7
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 15:09:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9624EC433C8;
	Mon, 21 Aug 2023 15:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692630583;
	bh=FI4K6BFk3RcP+iLGylJ5QutVzletJNgfqF0MXLNwUf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dCKmpbvy7HJWTMFrBCj2/oKy5v78TCPMMm8WyuM+OEI+vYqq5+RaH3CnWLF7Y+df2
	 Okr8hYkNswmMkxJOH1vIFrT9YnSkvPJk818OI6D6uno1ZVz+PZpRYGoL3S+dQV+yHv
	 nWXIUNBh4HZf28mqMmWviX9yTVPJDCQbxl+YN5Pk/AasnLeNmY/RUsIEzxrq9SIuoJ
	 BR9kDsPsuhDTWQUq6DVp5JPiZC0iHOiuGCHvrNczDwBTEpEe47c9w849ea2lIbyrD9
	 GkeedOeN6HapZAa2Bcdna2Lvakkw3i1BUzBw/ZdEJ6Ec3nWSSnvWcVuhg01AozFdyz
	 dGHAukZZPMMMw==
Date: Tue, 22 Aug 2023 00:09:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v5 0/9] tracing: Improbe BTF support on probe events
Message-Id: <20230822000939.81897c0c904934bfb9156a59@kernel.org>
In-Reply-To: <169137686814.271367.11218568219311636206.stgit@devnote2>
References: <169137686814.271367.11218568219311636206.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Steve,

Can you review this series?
I would like to push this to for-next.

Thank you,

On Mon,  7 Aug 2023 11:54:28 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the 5th version of series to improve the BTF support on probe events.
> The previous series is here:
> 
> https://lore.kernel.org/all/169078860386.173706.3091034523220945605.stgit@devnote2/
> 
> This version introduces kernel/trace/trace_btf.c to separate the btf generic
> functions. These functions will be moved to btf.c next merge window.
> This fixes the member-search function to return the bit-offset of the
> parent anonymous union/structure. Thus the caller can calculate the real
> bit-offset from the root data structure.
> This also fixes the ftrace selftest issue which fails if the kernel
> supports only BTF args but not support field access.
> 
> This series can be applied on top of "probes/core" branch of
> https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/
> 
> You can also get this series from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git topic/fprobe-event-ext
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (Google) (9):
>       tracing/probes: Support BTF argument on module functions
>       tracing/probes: Move finding func-proto API and getting func-param API to trace_btf
>       tracing/probes: Add a function to search a member of a struct/union
>       tracing/probes: Support BTF based data structure field access
>       tracing/probes: Support BTF field access from $retval
>       tracing/probes: Add string type check with BTF
>       tracing/fprobe-event: Assume fprobe is a return event by $retval
>       selftests/ftrace: Add BTF fields access testcases
>       Documentation: tracing: Update fprobe event example with BTF field
> 
> 
>  Documentation/trace/fprobetrace.rst                |   64 ++-
>  include/linux/btf.h                                |    1 
>  kernel/bpf/btf.c                                   |    2 
>  kernel/trace/Makefile                              |    1 
>  kernel/trace/trace.c                               |    3 
>  kernel/trace/trace_btf.c                           |  109 ++++
>  kernel/trace/trace_btf.h                           |   11 
>  kernel/trace/trace_eprobe.c                        |    4 
>  kernel/trace/trace_fprobe.c                        |   59 ++
>  kernel/trace/trace_kprobe.c                        |    1 
>  kernel/trace/trace_probe.c                         |  499 +++++++++++++++-----
>  kernel/trace/trace_probe.h                         |   27 +
>  kernel/trace/trace_uprobe.c                        |    1 
>  .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   20 +
>  .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |   10 
>  15 files changed, 637 insertions(+), 175 deletions(-)
>  create mode 100644 kernel/trace/trace_btf.c
>  create mode 100644 kernel/trace/trace_btf.h
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

