Return-Path: <bpf+bounces-30628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9668CF740
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 03:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840A71F21CA9
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 01:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AF520E6;
	Mon, 27 May 2024 01:17:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B35A1FAA;
	Mon, 27 May 2024 01:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716772678; cv=none; b=tjUQfdNMRWEzIkkqoNRe/QFmRh2jMre7ShFk1mjm3JU/plJ/6mruQ8POqKw146Gla4SlFm5mQ0kKpBXK+ZghjTU0696JgGKc4U0SbAvoOllLdzUP6K8NRoeCKKEmJ7NzTLEyNc9sHQ+pmyY472+vVQQ+ZjvM/CPdxzqYazF1Xxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716772678; c=relaxed/simple;
	bh=f42HeA3jftpumXESgptg132/8NjhZ1nGk3gaD46oh2o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nB8RCtRJxHWSchViZ9z9stnCyYWCWvIMeEqAy3E9K2y9EvhY0D+dkdVjShlilOZbdbNApRx2jio7BYr7megCHus+tlFwOLXa+SDvPO4DBXq/5xuRa9BrLQsHm7PWUJg+r/xNrqmSlk16BllQAFe2djm5GLBRRAar7XvX2gZ3JdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84366C2BD10;
	Mon, 27 May 2024 01:17:55 +0000 (UTC)
Date: Sun, 26 May 2024 21:18:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH 00/20] function_graph: Allow multiple users for function
 graph tracing
Message-ID: <20240526211847.22a23521@gandalf.local.home>
In-Reply-To: <20240527093747.cb9e49d660684158e8173133@kernel.org>
References: <20240525023652.903909489@goodmis.org>
	<20240527093747.cb9e49d660684158e8173133@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 May 2024 09:37:47 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > The diff between this and Masami's last update is at the end of this email.  
> 
> Thanks for update the patches!
> I think your changes are good. I just have some comments and replied.
> So, the plan is to push this series in the tracing/for-next? I will
> port my fprobe part on it and run some tests.

Yeah. I'll probably push it after -rc2 comes out and base it on top of
that. I usually wait till rc2 as it tends to be more stable than rc1.

I'll send an updated series later this week that addresses your comments.

-- Steve

