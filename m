Return-Path: <bpf+bounces-63595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EBBB08C71
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 14:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F081F7BCAB4
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 12:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B176529DB8F;
	Thu, 17 Jul 2025 12:05:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302922877C8;
	Thu, 17 Jul 2025 12:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753951; cv=none; b=sf6G/rk3LLX//u6XocxOzJkFLPi6noBs8kfv7y0kl9xgnpUX/R3WT9gOy/NqIR6wyy2PPMNocMdiEpeCMpL+sz9Ll1C4Yr0iHiGhYhToNasml+DXXtq96nqdEG48kBM+dJXgR1OyzxQWvHtps0Ik5k8EsNEV6UyNMtFLBsT/Qb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753951; c=relaxed/simple;
	bh=bdMErvXqnvFLupofuAuxGT85J4l/p6dZ+MKnVf9wb3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=no362YlqZwrEkXnop7tDcOFgdIA2ba7w0LTVKubnK0UnlUI66QPCBy8lKZOy9cCaUKeZruhPZ+YggUDI/bRhSCcJCrjBjeXALRUdstooWSLGG479nIg4lGm5Hspkp6poI1Qe5Z97E6yyAHmSw+HKfrRpJHY6ayhr0Q4tD1ID8W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 5A0CB80734;
	Thu, 17 Jul 2025 12:05:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 21DAA32;
	Thu, 17 Jul 2025 12:05:35 +0000 (UTC)
Date: Thu, 17 Jul 2025 08:05:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Steven Rostedt <rostedt@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>, Sam James <sam@gentoo.org>
Subject: Re: [RFC PATCH v1 08/16] unwind_user: Enable archs that save RA/FP
 in other registers
Message-ID: <20250717080555.4647863b@gandalf.local.home>
In-Reply-To: <nunn2n7geqbz7pra6x5wlpqxlqfkrolae22lqerk4klk4wfofy@wx5hquzmi527>
References: <20250710163522.3195293-1-jremus@linux.ibm.com>
	<20250710163522.3195293-9-jremus@linux.ibm.com>
	<oasyyga72yuiad7y2nzh7wcd7t7wmxnsbo2kuvsn5xsnuypewd@ukxxgdjbvegz>
	<20250716235751.119a1273@gandalf.local.home>
	<nunn2n7geqbz7pra6x5wlpqxlqfkrolae22lqerk4klk4wfofy@wx5hquzmi527>
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
X-Rspamd-Queue-Id: 21DAA32
X-Stat-Signature: amruy4oo5ftnnbo7n7bzn31wa3busn1a
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19z/QRmnIKVg6oAv6zk/ZSYPTiGQlvBuV8=
X-HE-Tag: 1752753935-794805
X-HE-Meta: U2FsdGVkX1/YlLKcXen6blpQMuhPTpLQVCTQsG8SxwELcGI0MuFabtDDbi4XbJDquWZ8q6HfzpE+extYo8V2QA6l2tX9m5X19ISAUPDN+722I88EIrQ51Mezj9Iu3Fk+jFnQpLO79J9JYK6U2sbaeltOOCgHPKToFJvw/Twl6InX2jLm2O/rnP8EfJuuYBJFb0jGag6nz9N6zvAb9aO5sno8jr3WHrd5N2CWzt22gRAC5+QJc3OfV1cSxI7x+APFnMcGGBWnktvLsKaLXVJBpDBf6fC56vauTYvVhVDdzIekrcIPjhIOqk5lk9Yy6D6D6sJX+u1i8tm/Wil8Qb2xJAnLpQdL57Gq

On Thu, 17 Jul 2025 00:24:47 -0700
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> > The only time I ever use BUG() is if it's too dangerous to continue (like a
> > function graph trampoline that gets corrupted and has no place to return
> > to). In general, usage of BUG() should be avoided.  
> 
> This is an unreachable code path, but __builtin_unreachable() is crap
> due to undefined behavior.  IMO, BUG() for unreachable paths is cleaner
> than WARN_ON_ONCE(), but it doesn't matter much either way I suppose.

Linus has stated that BUG() should be avoided too. If the code changes in
the future and this suddenly becomes a reachable path, would you rather
have a WARN or a BUG? If you don't have your system set up properly,
the BUG may not even show you why your system crashed.

-- Steve

