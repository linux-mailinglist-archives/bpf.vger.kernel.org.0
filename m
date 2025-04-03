Return-Path: <bpf+bounces-55234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2183A7A5EE
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 17:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B71188D81D
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 15:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD242505AE;
	Thu,  3 Apr 2025 15:05:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC75288A2;
	Thu,  3 Apr 2025 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743692712; cv=none; b=bJa5Iyihzf4OXmmA8uHVeX4U02ieP0RzKQ6h2drd01naDM/l1dwDZb5+kYITcr+2h9WH3xVtSQmrvefmIbRMcMbDhhcU5dHsorcE8NbEsqTTtKTLKU/6cNXUYR2/36UIQyepVWrzDzgCgp7NVneFpQB5eDK21wKUkY3+6/5cZt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743692712; c=relaxed/simple;
	bh=SMpFUIiEym7FAp7G/677xAHZhNHVi5Tv5IwIW4Xsd4I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PT9ZPDq3RggG2ticrBmbFM1ezCJVU8c48JZ5ES76O3s0/f3Sgp274JDidkkADU0rrPZuHHNYYc9pb944xnndvEPmciyOK7FA0zhdwAjWLRjPRYAh4GWbuCwq9dOxE7BKlgBBD5zlwddHfEuwDD09kkO5OoTofrPteYsFyAlV9fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CA2C4CEE3;
	Thu,  3 Apr 2025 15:05:09 +0000 (UTC)
Date: Thu, 3 Apr 2025 11:06:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 peterz@infradead.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, mhocko@kernel.org, oleg@redhat.com,
 brauner@kernel.org, glider@google.com, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org
Subject: Re: [PATCH v2] exit: move and extend sched_process_exit()
 tracepoint
Message-ID: <20250403110615.7a51b793@gandalf.local.home>
In-Reply-To: <Z-6TDh1MUT49lvjk@gmail.com>
References: <20250402180925.90914-1-andrii@kernel.org>
	<Z-6TDh1MUT49lvjk@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Apr 2025 15:54:22 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> This feels really fragile, could you please at least add a comment that 
> points out that this is basically an extension of 
> sched_process_template, and that it should remain a subset of it, or 
> something to that end?

Is there any dependency on this?

The reason to use the templates is because it saves memory. Each
TRACE_EVENT() can add ~5k (which a TRACE_EVENT() is really just a
DECLARE_EVENT_CLASS() + DEFINE_EVENT() for a single event).

Each DEFINE_EVENT() just adds around 250 bytes. Hence, if you have multiple
events that share the same fields and output, it's much more memory
efficient to use the CLASS and EVENT logic then making each their own
TRACE_EVENT().

I don't know of any other dependency to why this was a template other than
to save memory.

-- Steve

