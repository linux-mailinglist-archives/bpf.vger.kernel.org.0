Return-Path: <bpf+bounces-37561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CB995784C
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 01:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1E71C22FA1
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 23:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782FB1E2110;
	Mon, 19 Aug 2024 22:59:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A293C482;
	Mon, 19 Aug 2024 22:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724108391; cv=none; b=h370V11pymE6S1w+t55Gmnbq2uyp21yR4jmtjHL7+9zlismpkVKqvWIm/zhsl3bhS9chWkOcIcrO6N9EbFbAbCKQpZne8i1VEzq2ydt1CBm3b0JLilDYcgfkZBF1pAug/3NCzwQ/XwMZEGZM4Lv7Q0CPI6RKrsyw/LcF0Vxvl74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724108391; c=relaxed/simple;
	bh=goE9FASlTR08YPoTrpnjiOKgWeMuOdfR18sy63+kd4k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQmdJ2LQJnZ1qI+E5Xrjr7aylD7337NgU7amXWBVRi1b+in6GkIA6E7QuR+2nHA962GQmnxZBIo4X8s51PAI/3+BheQqaMUWBZizbTEIBCD38WYAfbP4DRJQNZONu0wCXKA3ebSwXFKZZZDnbdU37lo35x2ZhSuVNzHoo5+V4mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C68C4AF12;
	Mon, 19 Aug 2024 22:59:48 +0000 (UTC)
Date: Mon, 19 Aug 2024 19:00:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Peter
 Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org, Joel Fernandes
 <joel@joelfernandes.org>, Ingo Molnar <mingo@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Greg KH
 <gregkh@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v5 3/8] cleanup.h: Introduce DEFINE_INACTIVE_GUARD and
 activate_guard
Message-ID: <20240819190014.31ab74d8@gandalf.local.home>
In-Reply-To: <20240627152340.82413-4-mathieu.desnoyers@efficios.com>
References: <20240627152340.82413-1-mathieu.desnoyers@efficios.com>
	<20240627152340.82413-4-mathieu.desnoyers@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 11:23:35 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> To cover scenarios where the scope of the guard differs from the scope
> of its activation, introduce DEFINE_INACTIVE_GUARD() and activate_guard().
> 
> Here is an example use for a conditionally activated guard variable:
> 
> void func(bool a)
> {
> 	DEFINE_INACTIVE_GUARD(preempt_notrace, myguard);
> 
> 	[...]
> 	if (a) {
> 		might_sleep();
> 		activate_guard(preempt_notrace, myguard)();
> 	}
> 	[ protected code ]
> }
> 

Hi Mathieu,

The three cleanup patches fail to apply (I believe one has already been
fixed by Ingo too). Could you have the clean up patches be a separate
series that is likely to get in, especially since it's more of a moving
target.

Thanks,

-- Steve

