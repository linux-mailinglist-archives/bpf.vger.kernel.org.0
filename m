Return-Path: <bpf+bounces-61049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD75AE005C
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 10:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76923B51DC
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 08:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E47265611;
	Thu, 19 Jun 2025 08:49:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101AA200127;
	Thu, 19 Jun 2025 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750322996; cv=none; b=q2bFzre3ECxVUdDm2yEunxhm7tShvuBEf5e66WVBV9yl+hBnNv/aNbwq5p3HIYpaPl3hG4gZYpZImggtUGUiDAEp+SjFhbrO4J2kjvlRCYOxNqlzxdDtoYfeQa9Z5zdIg484zgzJLIfMzu/zMqZpzhzmsdmjnrcjt6GT6jlQ8DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750322996; c=relaxed/simple;
	bh=n71zzM0zn0yiB0UuLeFSmpaT+ZOUy5bd8NLW3zJzq+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HVCApn2+23JKakkp6StPIZnQ1xst0Bk0fkAM9InBTuuXtVxsjKOkAJr0X3OHlTT4VZCHtMresB6pyZpw3s3NDLZi1USz3S2A36frHggYz0u5aGJmNdu3YDzwv+K1mo0zdAuaz3cfr3yHOqo7RC5guLpC2bONcv2aDunPq8ouUP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 688035B3C3;
	Thu, 19 Jun 2025 08:49:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 70A6B20011;
	Thu, 19 Jun 2025 08:49:48 +0000 (UTC)
Date: Thu, 19 Jun 2025 04:49:53 -0400
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
Message-ID: <20250619044953.630c349a@batman.local.home>
In-Reply-To: <20250619080108.GY1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
	<20250611010428.770214773@goodmis.org>
	<20250618142000.GS1613376@noisy.programming.kicks-ass.net>
	<20250618113706.2eb46544@gandalf.local.home>
	<20250619080108.GY1613376@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 70A6B20011
X-Stat-Signature: wm8mdhhxwsab9enitotenb1s4y6gfb3r
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+m9RaEQFiWcConn3hFsX2R58+fX92JsoU=
X-HE-Tag: 1750322988-760678
X-HE-Meta: U2FsdGVkX19ItN7KcrqT3FzBR8Bm28K8TnxtDsJL/KxHZ+vHOPUqMdz5SmRXrau124q3SQQJYemftlaLRX67QqjcHj4zpZRxdM8hF4lxz32ei7WwobXcl27K68b+tKhTZgbk+uPGmXrtVFMcWQSarkzIxwyuG2rrAU3Vh8+4D9F1ZdXqAyGdE/oj0PNUXXHEV4MPhOI1X8xsIi3PRwDivWX2pmpw5JK7+xny1u4m+3B0D1r+FEUscmLWESdNcdao3i2O9STRZlSK2US6KDZGcWuewZpDYUFzri1kugojVDcNBH7oHrYAce1tpYSedi8pupgvPLJ4o4ATd48DLfve/zK1FhityT+C7reWBTkrnQ3OwYQs3w9kq4b+r0fMuz3r

On Thu, 19 Jun 2025 10:01:08 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> If you want to rely on consecutive system calls never seeing the same
> timestamp, let alone PID reuse in the same timestamp -- for some generic
> infrastructure -- you need to go audit all the arch code.

I can drop the timestamp and go back to the original "cookie"
generation that guaranteed unique ids for something like 2^48 system
calls per task.

I thought the timestamps just made it easier. But having to audit every
arch, may make that not the case.

-- Steve

