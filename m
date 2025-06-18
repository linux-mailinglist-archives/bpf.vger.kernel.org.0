Return-Path: <bpf+bounces-60941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E20DADEF13
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 16:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 353F73B66A3
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 14:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD122EACFC;
	Wed, 18 Jun 2025 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jg90iC/d"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40702980A1;
	Wed, 18 Jun 2025 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750256411; cv=none; b=NlbvW+QbnamMilAXZe8JA+HazXl+k7KKRFi+9w7Q3RKZoGphPP7MqanfOPD5XqVvAONnX+zOROLvpFMTVOGnDAgdbbwjdXnzmcCRO7Ut66D5+cMrtY8iK1ndOGkJh1rprKTyG0VuJ7HCowQqplwioXG/BDIXYtXuqbmMXHf3rcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750256411; c=relaxed/simple;
	bh=uRKG8lv6RJYmAqOvTk+z6wT0OMHIbCwNn7aWXPGcbUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+KL/loHwbfXteS5/GEoVvh0fHY3BrpqZrGhMTvNNwpCVT8k6spLDtbzgpSyIVGMyd7CI22Fbx7XKmWICppncirzh2Z37HiZUu6F4ZL1kZnVMff3HmPV42wmVJimbK0mJuF0GBUVxK6avxqnCTFel2i3T5A6nsF8ST6jJM0vI6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jg90iC/d; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4zN3bC4DkftlVvPBzBVft4YUqwC0P2GY66hdLYuFJ2s=; b=Jg90iC/dQ7eO51xKL6I7LV4Ks9
	/3fc3ZZvS6YogEPJkTsfxXXfGAe3oDHiXfJZtW3/U0pTJhnPWGdCgrjYEX0XEpjSPUdKBeWUh1kdq
	Q4F5KEF980pOhiRoB8oNPWmfznZciSn13bgKpROljCYjjTOdaetaa35aMvXE1+G7ljCSbmdTe4dQZ
	roONBtuKAZS1mBpWaZwKlBspZh8XzpmvFyDo2uS5zneyQRpHxdAqumhyFrRWNxDO4l6saLg180Tlp
	z41v4IU964t0QkJMvHMMc7d6TWK2NeBqSBHpTwDSlchNakqjHAriJNf+BElCE8TVy3O0qOLtSkxs1
	8pP0Rgzw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRtdx-000000045iT-1F7Y;
	Wed, 18 Jun 2025 14:20:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 38D53307FB7; Wed, 18 Jun 2025 16:20:00 +0200 (CEST)
Date: Wed, 18 Jun 2025 16:20:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 06/14] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250618142000.GS1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
 <20250611010428.770214773@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611010428.770214773@goodmis.org>

On Tue, Jun 10, 2025 at 08:54:27PM -0400, Steven Rostedt wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Add an interface for scheduling task work to unwind the user space stack
> before returning to user space. This solves several problems for its
> callers:
> 
>   - Ensure the unwind happens in task context even if the caller may be
>     running in interrupt context.
> 
>   - Avoid duplicate unwinds, whether called multiple times by the same
>     caller or by different callers.
> 
>   - Take a timestamp when the first request comes in since the task
>     entered the kernel. This will be returned to the calling function
>     along with the stack trace when the task leaves the kernel. This
>     timestamp can be used to correlate kernel unwinds/traces with the user
>     unwind.
> 
> The timestamp is created to detect when the stacktrace is the same. It is
> generated the first time a user space stacktrace is requested after the
> task enters the kernel.
> 
> The timestamp is passed to the caller on request, and when the stacktrace is
> generated upon returning to user space, it call the requester's callback
> with the timestamp as well as the stacktrace.

This whole story hinges on there being a high resolution time-stamp
available... Good thing we killed x86 !TSC support when we did. You sure
there's no other architectures you're interested in that lack a high res
time source?

What about two CPUs managing to request an unwind at exactly the same
time?


