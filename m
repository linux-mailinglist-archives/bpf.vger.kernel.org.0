Return-Path: <bpf+bounces-61046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73544AE0051
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 10:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200984A03DB
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 08:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D722266571;
	Thu, 19 Jun 2025 08:47:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414CF265CBB;
	Thu, 19 Jun 2025 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750322837; cv=none; b=be+hAeoVag1nHrV4Wigt/EC08plTjvb8ek1zW8cfsajKhz0lULe3xWpdmBgai3MgbNkv+FsLSQBRtQ1bRDS3G+djJC/8v9kpV7lsVSH/d1/f4IGtvANAF/W2ES2gQBGLGS20znBLMDiOe/BkEVTQ5QL0FxC1dWQr8H0eG6gsYXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750322837; c=relaxed/simple;
	bh=b0XWpvGm8wgW6A/uSiwkYOT2KLb+DLRb+ve9xFGOjd8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlD86U/aIWryqQnDblcvas44rqlOj3E0rG+fI8ocF5ICbDmCxKo5kvn2ZZWpS2OR2Niwkxf+EXXZFPk7C35m0HiW5JYnocb8z3sOMfDbzBYFia/2t3trJlBrhE4fcVZdY78ISjoP9GYiaXaGpjkkN7kL13FNUtBssSNY98agyjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id B99241A075C;
	Thu, 19 Jun 2025 08:47:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id D9D8C2000D;
	Thu, 19 Jun 2025 08:47:08 +0000 (UTC)
Date: Thu, 19 Jun 2025 04:47:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu
 Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 05/14] unwind_user/deferred: Add unwind cache
Message-ID: <20250619044714.5e676bf3@batman.local.home>
In-Reply-To: <20250619075611.GX1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
	<20250611010428.603778772@goodmis.org>
	<20250618141345.GR1613376@noisy.programming.kicks-ass.net>
	<20250618113359.585b3770@gandalf.local.home>
	<20250619075611.GX1613376@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D9D8C2000D
X-Stat-Signature: hdnso6s7b8h14ty8pwta4y6t1z4ps3a6
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18mL5Mp+KUi7te2UfafbcE31pupD+cnzTg=
X-HE-Tag: 1750322828-715024
X-HE-Meta: U2FsdGVkX1/6nmXO2xLOAzIpyS7FXKe4FiuacAkvz+FOe86TrNckB2C4V/DB0PqfuqCcIYSFlx7JIAKM8Sl1lCbwTmBopNN9hYbJhrGKJ5zwS8TG5y0SsSiybX4oYUoKi7R1VEG9MCmK1pnOdpwCAjSk0eObCETPMieQ2xZrRQVow61s0WfTp7bQye7vf9KsL2xFXydIb9H5q4GmlPLkjwbp9YAUOCpxoimMVgT/JuA03tf4+yQ51AIwY3pD7nI8eToHEESCgGFZljTyd6Scg1UoO07WBivLGtFmwzPTubHRHzJAav3GDewzhdMnDKrIwv+BjoYkx7qRFraknHjMtgibs3FafmEnOK8lUgMbFrK8R4fNj8SddH4rLYTGrv/c

On Thu, 19 Jun 2025 09:56:11 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Well, the trivial solution is to make it 511 and call it a day. Don't
> make things complicated if you don't have to.

I don't know if this is more complicated, but it should make it fit
nicely in a page:

  /* Make the cache fit in a page */
  #define UNWIND_MAX_ENTRIES                                      \
        ((PAGE_SIZE - sizeof(struct unwind_cache)) / sizeof(long))

-- Steve

