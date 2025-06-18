Return-Path: <bpf+bounces-60991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C495ADF6F1
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 21:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 118A11BC0599
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 19:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9DC217737;
	Wed, 18 Jun 2025 19:36:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8668E20296A;
	Wed, 18 Jun 2025 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750275394; cv=none; b=lBg9b9kMKrOQfdIyI5NclSTD9kzhB6/8I9xQzZZv5Tpd6YW1wWBCFDcevj37b5n966sKWEeM8gl+l6A62sZdGpaEc+99eXyS2DFwJ32ZRq6Lc/ozuBbCltpLLBtNCIueu/jPALRmnLwum2UJINJUfhNBr7NtT7XPE18x5lTFAcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750275394; c=relaxed/simple;
	bh=hpvx7+LNMHy5wJjUVF4JNZfUWjLNo09d2jPgigPF3g8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kHN87XyiwMkYxdHiwXd46NPWwMx0cqLgEpupy3qg88R1UCZ9oNNinWiiX4FeGvzbYwvM85VpT0pcGhcKm8q1i+xRvZN4yP+oAUXnoaj90K1rkJIFxtYETPCZnMt/DpeVNk1xOW1aAam8qs1ljpT8fZQ0JBGEiko9FfC6W4/iOf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 8FBB0C0AF3;
	Wed, 18 Jun 2025 19:36:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 7FA1840;
	Wed, 18 Jun 2025 19:36:19 +0000 (UTC)
Date: Wed, 18 Jun 2025 15:36:27 -0400
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
Subject: Re: [PATCH v10 06/14] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250618153627.784e1e8c@gandalf.local.home>
In-Reply-To: <20250618150915.3e811f4b@gandalf.local.home>
References: <20250611005421.144238328@goodmis.org>
	<20250611010428.770214773@goodmis.org>
	<20250618184620.GT1613376@noisy.programming.kicks-ass.net>
	<20250618150915.3e811f4b@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 54yemurb44o3up7c4wrehg3xi818qg4f
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 7FA1840
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1++f89SUhUbPsoAOou37tqKis5ND88YHDY=
X-HE-Tag: 1750275379-92755
X-HE-Meta: U2FsdGVkX1/va5w3Fr4pDtYj0fm4bYsG4SLFMjipM4vqyQRXWNf/Jhi/O+UdEuBAWBPrProTQpHyiOlTa9WfT66YRS7ekg+KLYNhzIgXVjbH8qYci/g1A8ojwNY1n6zT3sKnN8wHEBnHLT79yT58ZohWo0eB4JDhYwwc1VpuoKPo1v35wbjbYvJG/at5ekPbfM7t0Wi+F+O9M0fAAgGnix7HndAQMBsneNplO++g3LyYJAi0wQaXzPTCKuNavyIb7W59m1WkApB9qzreIwIuJtQ73BsE2kENeqx8fyucELlsFZuuw+aLTds3etlsZAhU8Y9ZIsmDy6qBoHI8XYOy8Yvs5vCIchEsY3CCz0FJnnjl0BklY60hgVhMitPP47CM

On Wed, 18 Jun 2025 15:09:15 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > So now you're globally serializing all return-to-user instances. How is
> > that not a problem?  
> 
> It was the original way we did things. The next patch changes this to SRCU.
> But it requires a bit more care. For breaking up the series, I preferred
> not to add that logic and make it a separate patch.

It's not the next patch but patch 9 (three away).

-- Steve

