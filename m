Return-Path: <bpf+bounces-74542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EEEC5EE58
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 19:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 51A6635B5F3
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 18:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D686A34572F;
	Fri, 14 Nov 2025 18:29:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4697833FE28;
	Fri, 14 Nov 2025 18:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763144999; cv=none; b=C1ToYehYnQms5uTDVpfYfwadSOVjiQ/x12O8XTrZNesrotTiPoTdeGHOenXjfO4HGWYVljq2Lcw9+HV/pyN1Lk+Z8XNqxBpL0tpNEw1bfjbtXctgnN67BQvBCBFGnlsDFHMuA8kDhbbAWFyJvrtT/g96jDGQnX0STAqmczfr27Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763144999; c=relaxed/simple;
	bh=MuE00RlRt5TaXhbVb88Eon6dOwMEUNP6+OfSFtX3BL4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2nXn/96L6mGGaLCLHbQcMAmNxorDBo7rDyv6SgH35tbYfHWrqiT3IOGyZ8QuiMlY8uxRHqWuoK+0jhs1Qoc+ENI4KTOMsOJ+R8YEipMEja0i+Uba22zlzinduTlMnW9TBnpJJtZIxOhJ0rfPDP1duKEUEMUVc5noQH/KoPgW9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 0E0DD88D66;
	Fri, 14 Nov 2025 18:29:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id CC8D120019;
	Fri, 14 Nov 2025 18:29:51 +0000 (UTC)
Date: Fri, 14 Nov 2025 13:30:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, James Clark <james.clark@linaro.org>, Jiri Olsa
 <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Josh
 Poimboeuf <jpoimboe@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, Jens
 Remus <jremus@linux.ibm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH v3 3/5] perf record: Enable defer_callchain for user
 callchains
Message-ID: <20251114133009.7dd97625@gandalf.local.home>
In-Reply-To: <CAP-5=fU33sEARn0tc1hSMahBVCvs0cy+Cu-J6+BG0Cm-nuwKnA@mail.gmail.com>
References: <20251114070018.160330-1-namhyung@kernel.org>
	<20251114070018.160330-4-namhyung@kernel.org>
	<CAP-5=fVEuYXw+P-+Z7bU7Z-+7dsHPPfABh5pdnPtfvH-23u4Qw@mail.gmail.com>
	<CAP-5=fU33sEARn0tc1hSMahBVCvs0cy+Cu-J6+BG0Cm-nuwKnA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: CC8D120019
X-Stat-Signature: e4h1wsdthf3s8d6ipz5chnb3ec6jqm8a
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18GvnCPKnF36vsYyzn+Csf+m+zAY1sPZXQ=
X-HE-Tag: 1763144991-458139
X-HE-Meta: U2FsdGVkX1/z3/4C/Oq4/6qS9X+vWlEB1TJNGRfAaZuinb6TQH63CK25vD1MOjhdWYdQ81XYIf8/Ewog8Pk648f9WFO/md0suX8ejYp5mhg8K/yCpL8ohgBzSWSPhdZSVf8/wDxPeVpRECeo6/VqLvAwQHats8nKo3zXpAlL5qMLZ7e523rudNqyTsITjMIflgRCj/ZOioAN1GQHSueA0ZlopgY9hZSk/K7L4Ru2l6hBepI88GgmKpcy7MxTZOPBsm47j6Fz6lFiEXf9y+wQgFAmmtXICxmbrlM6eWcVB+J7g5ezLkE1J+IHENWjVZF61YW0w3Iqser6XqYMb5gLiRrR5yD14unE

On Fri, 14 Nov 2025 10:09:26 -0800
Ian Rogers <irogers@google.com> wrote:

> Just to be clear. I don't think the behavior of using frame pointers
> should change. Deferral has downsides, for example:
> 
>   $ perf record -g -a sleep 1

The biggest advantage of the deferred callstack is that there's much less
duplication of data in the ring buffer. Especially when you have deep
stacks and long system calls.

Now, if we have frame pointers enabled, we could possibly add a feature to
the deferred unwinder where it could try to do the deferred immediately and
if it faults it then waits until going back to user space. This means that
the frame pointer version should work (unless the user space stack was
swapped out).

> 
> Without deferral kernel stack traces will contain both kernel and user
> traces. With deferral the user stack trace is only generated when the
> system call returns and so there is a chance for kernel stack traces
> to be missing their user part. An obvious behavioral change. I think
> for what you are doing here we can have an option something like:
> 
>   $ perf record --call-graph fp-deferred -a sleep 1

I would be OK with this but I would prefer a much shorter name. Adding 20
characters to the command line will likely keep people from using it.

-- Steve

