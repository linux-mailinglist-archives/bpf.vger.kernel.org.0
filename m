Return-Path: <bpf+bounces-63475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7FBB07CFC
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 20:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41FBF1723FE
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 18:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614C429AAFE;
	Wed, 16 Jul 2025 18:34:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16F77346F;
	Wed, 16 Jul 2025 18:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752690849; cv=none; b=W7wm/Jmg9JXmZvR3kxJKG988F4MB85fOXKfPs0G96oPcYt5am9SQSKajB1Qzl5pS4U4al0RaRZ6E1RqOdePmt31BP1BkbNJR6YxNvI38hTbJGFQjeHvYklk0zWCQDzxoDEfyNTV3dFswLIzj8LWs56ijGofkKGEI6rIqV6KLo+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752690849; c=relaxed/simple;
	bh=WdQf7QM2FMWgObuR3BeGiZlslFvfe2bArXxWlOl3Ahs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZSo81iHAjcI76ZyuwEJcpN/d6fwT1z8v10K5tBivyb4cce+vX93zbD8Si1A8AXqAd9Ma895grYnOvexCBEZewR+f7UREQBAJtE51uD6bZ+DZvHFkJH9ABJIxXWYXcvbQNeT5Fa3nFZpa4vV6NHY0qBX0TIZZ7Mp59a/XKUSZh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 273881DA3C3;
	Wed, 16 Jul 2025 18:33:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 5E6392000E;
	Wed, 16 Jul 2025 18:33:53 +0000 (UTC)
Date: Wed, 16 Jul 2025 14:33:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>, Sam
 James <sam@gentoo.org>
Subject: Re: [PATCH v13 10/14] unwind: Clear unwind_mask on exit back to
 user space
Message-ID: <20250716143352.54d9d965@batman.local.home>
In-Reply-To: <20250716142609.47f0e4a5@batman.local.home>
References: <20250708012239.268642741@kernel.org>
	<20250708012359.345060579@kernel.org>
	<20250715102912.GQ1613200@noisy.programming.kicks-ass.net>
	<20250716142609.47f0e4a5@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: k87dtutxg3xtrhr3rxxzxshw6n6xgjny
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 5E6392000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19/Dj5b1QVktjigvgyada44QrXAilyj1Hs=
X-HE-Tag: 1752690833-772434
X-HE-Meta: U2FsdGVkX18FrHndPEjUFj1CfoQitzzoGUMNTNyoctTd5ezvWX3PJlLfEoug0XRDb9bQZTdFvdu08S+8VstOOuT9tzUatP8mo66+uw/tl0h86bMa6zCKhp7Wk8XZy+3yeaB9nkP1+nz5NwVUYyiWTgc3U/NX0Fqjj1hXkQ9d7mSBPTUfT0N+jKT07L9c1kj/uK209soZT2d/jRXswh7vZQAdePaD/nzN2U8U07zxawaLEyd2MOfuRkHy7C7zcNJprsAreePSO+K/3AiruCxH3UKKy1mXYueC/BBmslb5iMT5kgVHa9w02+Y+xZJ5J7Y7ZOqraOn8Odk7jrwIETAFdojllxdZ1aHK5eUl1pocRzS282cgF2blyHlhDwfAZEb2

On Wed, 16 Jul 2025 14:26:09 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

>   Now before the task gets back to user space, ftrace requests the
>   deferred trace. To do so, it must set the pending bit and its bit,
>   but it must also clear the perf bit as it should not call perf's
>   callback again.

After ftrace clears the bits, it is possible that the first perf
program will request again and this time it will get another callback
with the same cookie. But at least it has a request between the last
callback and the next one.

That is, it would have:

[Task enters kernel]
  request -> add cookie
  request -> add cookie
  [..]
  callback -> add trace + cookie
 [ftrace clears bits]
  request -> add cookie
  callback -> add trace + cookie
[Task exits back to user space]

Which shouldn't be too confusing. But if we just do the fetch_or and it
didn't request a new trace, it would have:

[Task enters kernel]
  request -> add cookie
  request -> add cookie
  [..]
  callback -> add trace + cookie
 [ftrace clears bits]
  callback -> add trace + cookie
[Task exits back to user space]

Where there's two callbacks written to the perf buffer for the same
request.

Maybe this isn't a problem, but I was trying to avoid adding multiple
requests due to other tracers affecting the state.

-- Steve

