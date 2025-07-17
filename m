Return-Path: <bpf+bounces-63628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CB4B09174
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 18:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332C1585563
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 16:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D042FA620;
	Thu, 17 Jul 2025 16:10:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46322798F8;
	Thu, 17 Jul 2025 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752768622; cv=none; b=ThvXc98qduV7m9id+VcvVqH79141DOxT9eo5dCFfUgm6ikyeg3hexyzXXVu392yu+YXQLXRYkYDw9AX3yKwqtYiSszNIp8sbrzK0eqIbteeG4vha+OvYvoG9ZI75GVcj7Tkh0QjvvEr7Xln5VLvPe3+9aJ8A47SBvG9Rzjnil5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752768622; c=relaxed/simple;
	bh=MEE7jUnILcqy02mFh59Pt3b8dmrhQ15xcoDXSJtbSHU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7JEgJryiUXP9xyFtAzN3ug+tyqIQnLax9msBqAdfiOvDzj7+ODxrQPLs4hi3eCOhCpN3SOuDItw+wPcNhzdt81PphGqazMfxj9a6BgjXl9gp0WUBx/ReQ53ARL4TsSLKCaUthLJHrFE7R63j8qvhMfBO3URz/iLm6AWiInzjuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id A07601A015A;
	Thu, 17 Jul 2025 16:10:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 926121A;
	Thu, 17 Jul 2025 16:10:11 +0000 (UTC)
Date: Thu, 17 Jul 2025 12:10:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu
 Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>, Sam James <sam@gentoo.org>
Subject: Re: [PATCH v14 09/12] unwind deferred: Use SRCU
 unwind_deferred_task_work()
Message-ID: <20250717121010.4246366a@batman.local.home>
In-Reply-To: <41c204c0-eabc-4f4f-93f4-2568e2f962a9@paulmck-laptop>
References: <20250717004910.297898999@kernel.org>
	<20250717004957.918908732@kernel.org>
	<47c3b0df-9f11-4e14-97e2-0f3ba3b09855@paulmck-laptop>
	<20250717082526.7173106a@gandalf.local.home>
	<41c204c0-eabc-4f4f-93f4-2568e2f962a9@paulmck-laptop>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: kdknodp68bw95bn3nquegp911ku4afyt
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 926121A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19I34z/YVXYuCJ3MjtZncdDCod0DMq55jI=
X-HE-Tag: 1752768611-991244
X-HE-Meta: U2FsdGVkX1/UwkCZQDm25iYOuhSZ2rZcAaq3zn9cQi5QJCA1fCyyGm0tMkPx0MoBQVLxJ1qTso7VU0Lnu+8CbOaBi629CWWX/4fwXyzTtvxXVeI1jOZAOgWhGNF4OD0fmB/7jkFyiEs3pmEMeQw4Nzvu+SUGUBVixLnFEdaqwpfkp9JAJOFER3pHSNLNmCQV2zDn1Mg5idJwm5YZ+QQdNWAlJFFzKzbD6C4rt1fdyhVslLbMlmOavVjkgExAUxmCNBIMIY0bXdsR0NXqKo32zg/83YJDoQGzw63usR1pQLD3scMwSpWOf5eUlgXvgSqX+KbFuNKzhdGWZwmohq6MfxHEqlwxqQXV

On Thu, 17 Jul 2025 08:48:40 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> So if there is some reason that you absolutely cannot immediately convert
> to SRCU-fast, let's please discuss.

There's two reasons I wouldn't add it immediately.

One, is the guard(srcu_fast) isn't in mainline yet. I would either need
to open code it, or play the tricks of basing code off your tree.

Two, I'm still grasping at the concept of srcu_fast (and srcu_lite for
that matter), where I rather be slow and safe than optimize and be
unsafe. The code where this is used may be faulting in user space
memory, so it doesn't need the micro-optimizations now.

-- Steve

