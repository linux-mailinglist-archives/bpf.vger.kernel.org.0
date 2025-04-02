Return-Path: <bpf+bounces-55176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B906A79528
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 20:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B6AA16CCBD
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 18:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2733C1D63D3;
	Wed,  2 Apr 2025 18:35:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77F619E826;
	Wed,  2 Apr 2025 18:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743618940; cv=none; b=u4f6WeP/WD/ZOxkaw4URKVv9f3Fjw6ltnRDFNECoOSZYUDqXJ8L9Gh13w3jiEtMH32IvT3fIMLlEZh3cKLl+pZrDdLzTmXdilBbNlqJX7pYmdUJCknWreUCwrjMsxY2/gyBtfFAHVNSPvbDPBapslMqSctWSRmrRte/qGOveVCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743618940; c=relaxed/simple;
	bh=1wYacUfE/oKy2FoxOI9tz0H1oX/1WnAFPVbBb0hXg38=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUrWjiEmdXsVjXa0ynN+TOxm/t2SE3MFgxNuPwHCVo75+gkzWt3xSYy0IzpZ4DHnPXaZOCcA2x2f2rxLtyMqUluWWnej+UFGx0Y+kw8vNaViOfSVOMnkLacozJoqNdpFRjWSoWv/x3rt1Y0awMyhfZ8oAf/57/iQVJ8gcw+w2ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD5AC4CEDD;
	Wed,  2 Apr 2025 18:35:38 +0000 (UTC)
Date: Wed, 2 Apr 2025 14:36:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
 mingo@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, mhocko@kernel.org, oleg@redhat.com,
 brauner@kernel.org, glider@google.com, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org
Subject: Re: [PATCH v2] exit: move and extend sched_process_exit()
 tracepoint
Message-ID: <20250402143641.4171ae3e@gandalf.local.home>
In-Reply-To: <20250402180925.90914-1-andrii@kernel.org>
References: <20250402180925.90914-1-andrii@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Apr 2025 11:09:25 -0700
Andrii Nakryiko <andrii@kernel.org> wrote:

> It is useful to be able to access current->mm at task exit to, say,
> record a bunch of VMA information right before the task exits (e.g., for
> stack symbolization reasons when dealing with short-lived processes that
> exit in the middle of profiling session). Currently,
> trace_sched_process_exit() is triggered after exit_mm() which resets
> current->mm to NULL making this tracepoint unsuitable for inspecting
> and recording task's mm_struct-related data when tracing process
> lifetimes.
> 
> There is a particularly suitable place, though, right after
> taskstats_exit() is called, but before we do exit_mm() and other
> exit_*() resource teardowns. taskstats performs a similar kind of
> accounting that some applications do with BPF, and so co-locating them
> seems like a good fit. So that's where trace_sched_process_exit() is
> moved with this patch.
> 
> Also, existing trace_sched_process_exit() tracepoint is notoriously
> missing `group_dead` flag that is certainly useful in practice and some
> of our production applications have to work around this. So plumb
> `group_dead` through while at it, to have a richer and more complete
> tracepoint.
> 
> Note that we can't use sched_process_template anymore, and so we use
> TRACE_EVENT()-based tracepoint definition. But all the field names and
> order, as well as assign and output logic remain intact. We just add one
> extra field at the end in backwards-compatible way.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/trace/events/sched.h | 28 +++++++++++++++++++++++++---
>  kernel/exit.c                |  2 +-
>  2 files changed, 26 insertions(+), 4 deletions(-)

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

