Return-Path: <bpf+bounces-31273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C85C8FA63E
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 01:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B4A4288D30
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 23:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AFD13CF97;
	Mon,  3 Jun 2024 23:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ca6KCx7a"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B416982D9C;
	Mon,  3 Jun 2024 23:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717456357; cv=none; b=aSzCBKbLISftVEzSFAOI1qEfb5oechzVEU+TwIIbaA2VF59YkaYD9FxP3JAM95looKhJJe/Icop4XRWsW6GbRb6JUbrxEmmhc3BOXVoXHc9IiEscIxcbf6AJ5Dn8KM3bRWjcMolRfCv55LFnaKrEb+GcHX8eRxG+eC4oOeD1sp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717456357; c=relaxed/simple;
	bh=jlMa/1KQP8AgPUAWk/zBkqIn2aacp2s+DjgzIqxPWDQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XK5R+MCyeKBhePV18DG+ncJlb6a1nb8o16IrUvmsG/xRa5sq4SyGE3QYC3Wg8a3KQimcAeorhVnZIEu2YwlLiFEE8ZD40Voqwi9tqXx+WzR3Wp3Njzg1RWhxt+2Odhszz/ibrW28jvc8JG7/aV5wLnqtLPiBu5N8nXxzqAAu1Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ca6KCx7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3704FC2BD10;
	Mon,  3 Jun 2024 23:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717456357;
	bh=jlMa/1KQP8AgPUAWk/zBkqIn2aacp2s+DjgzIqxPWDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ca6KCx7aqJRwWApIMM8vrwvbTX4Ut/P0HwSeC/htl1BQTTajA27H4YD7Z+Xaoet7A
	 sO5FwBevKqVeMkVJG6gSMVKADMrcXl5hBmZ+mW75wj3y1UB83Ft15FRaTDhBo/MYBG
	 Zs/0CKWlEhzYsta8V/LGbJWpeV1IFM69VGHixhji+61vB5H2TfqJxtWiMJOGq0nDnR
	 gbvDZV+Ze4dC4w8SbhjmhSYIdyMjtMLXwsH/F5m6EB61cWL06S2w/5Dic5ohwnWBY6
	 5aJ6jJFO1GfkS4lYrITdQaV4xdo36T/QqgfhMcHjGfwZGKikYlg7eO/2WSTJ2YnmvQ
	 ZM/TEkwCNZgTw==
Date: Tue, 4 Jun 2024 08:12:29 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
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
Subject: Re: [PATCH v2 11/27] ftrace: Allow subops filtering to be modified
Message-Id: <20240604081229.8d80bee75a29663f3b61322d@kernel.org>
In-Reply-To: <20240603105250.52ea24f2@gandalf.local.home>
References: <20240602033744.563858532@goodmis.org>
	<20240602033832.870736657@goodmis.org>
	<20240603113723.b192c8c346e0ed55cb94b61a@kernel.org>
	<20240603105250.52ea24f2@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Jun 2024 10:52:50 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 3 Jun 2024 11:37:23 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Sat, 01 Jun 2024 23:37:55 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > [...]
> > >  
> > > +static int ftrace_hash_move_and_update_subops(struct ftrace_ops *subops,
> > > +					      struct ftrace_hash **orig_subhash,
> > > +					      struct ftrace_hash *hash,
> > > +					      int enable)
> > > +{
> > > +	struct ftrace_ops *ops = subops->managed;
> > > +	struct ftrace_hash **orig_hash;
> > > +	struct ftrace_hash *save_hash;
> > > +	struct ftrace_hash *new_hash;
> > > +	int ret;
> > > +
> > > +	/* Manager ops can not be subops (yet) */
> > > +	if (WARN_ON_ONCE(!ops || ops->flags & FTRACE_OPS_FL_SUBOP))
> > > +		return -EINVAL;  
> > 
> > This does return if ops->flags & FTRACE_OPS_FL_SUBOP, but --> (1)
> 
> Yes, because what is passed in is "subops" and "ops" is subops->managed.

Ah, I missed that point. OK, I got it.


> 
> > 
> > > +
> > > +	/* Move the new hash over to the subops hash */
> > > +	save_hash = *orig_subhash;
> > > +	*orig_subhash = __ftrace_hash_move(hash);
> > > +	if (!*orig_subhash) {
> > > +		*orig_subhash = save_hash;
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	/* Create a new_hash to hold the ops new functions */
> > > +	if (enable) {
> > > +		orig_hash = &ops->func_hash->filter_hash;
> > > +		new_hash = append_hashes(ops);
> > > +	} else {
> > > +		orig_hash = &ops->func_hash->notrace_hash;
> > > +		new_hash = intersect_hashes(ops);
> > > +	}
> > > +
> > > +	/* Move the hash over to the new hash */
> > > +	ret = ftrace_hash_move_and_update_ops(ops, orig_hash, new_hash, enable);  

So this `ops` is managed ops of this subops.

> > 
> > This also a bit wired to me. maybe we need simple version like
> > 
> > `__ftrace_hash_move_and_update_ops()`
> > 
> > And call it from ftrace_hash_move_and_update_ops() and here?
> 
> We could do that. I almost did due to other issues but I reworked the code
> where I didn't need to.
> 
> > 
> > > +
> > > +	free_ftrace_hash(new_hash);
> > > +
> > > +	if (ret) {
> > > +		/* Put back the original hash */
> > > +		free_ftrace_hash_rcu(*orig_subhash);
> > > +		*orig_subhash = save_hash;
> > > +	} else {
> > > +		free_ftrace_hash_rcu(save_hash);
> > > +	}
> > > +	return ret;
> > > +}
> > > +
> > > +
> > >  static u64		ftrace_update_time;
> > >  unsigned long		ftrace_update_tot_cnt;
> > >  unsigned long		ftrace_number_of_pages;
> > > @@ -4770,8 +4823,33 @@ static int ftrace_hash_move_and_update_ops(struct ftrace_ops *ops,
> > >  {
> > >  	struct ftrace_ops_hash old_hash_ops;
> > >  	struct ftrace_hash *old_hash;
> > > +	struct ftrace_ops *op;
> > >  	int ret;
> > >  
> > > +	if (ops->flags & FTRACE_OPS_FL_SUBOP)
> > > +		return ftrace_hash_move_and_update_subops(ops, orig_hash, hash, enable);  
> > 
> > (1) This calls ftrace_hash_move_and_update_subops() if ops->flags & FTRACE_OPS_FL_SUBOP ?
> 
> Yes, because ops turns into subops, and the ops above it is its manager ops.

Ah, OK. This `ops` is a subops. 


Thank you,

> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

