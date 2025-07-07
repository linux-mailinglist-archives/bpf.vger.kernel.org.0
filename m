Return-Path: <bpf+bounces-62560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAB8AFBD58
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 23:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BC0165BFD
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 21:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1AE287260;
	Mon,  7 Jul 2025 21:17:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403B6285CB3;
	Mon,  7 Jul 2025 21:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751923069; cv=none; b=ETO8whqf5uYFXlItPGcMgc0qEOw8fT1W0nawAf9OwYOR8wQNlwZC+A18Bzv4s8Td2swVrH714KufcaA6ECBlz6cx4qQbzxG4myw8Rqlu1RUaaZiyMtibzlXCq/l5l3puJrdj0FAdXI8EYwg+pFQspxR11p65svqQkfOt6lacZ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751923069; c=relaxed/simple;
	bh=6w1dVPixiY3k13k17rtRyUsCZzgPtumdTmATn1RT6BU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LoPoQoLRC3JD4iih/VhiJz0c71wLTj5bSMtIKX7nItXV+sxh65ma35eZwjCeezk1M/iuJnZ9DAII/AVYzdrThvLUNlUPsgJA5F6Lm4ifWD2EUlrdTi2xFw+m9aCm/tyCsNZuTQaBBeolxtqxX00a22o92/0OFCAXb+EpEEYLHTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id ECC2D8037B;
	Mon,  7 Jul 2025 21:01:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 5AD786000F;
	Mon,  7 Jul 2025 21:01:06 +0000 (UTC)
Date: Mon, 7 Jul 2025 17:01:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>
Subject: Re: [PATCH v12 01/14] unwind_user: Add user space unwinding API
Message-ID: <20250707170105.1ea1ccd5@batman.local.home>
In-Reply-To: <20250707154245.7eeeb448@batman.local.home>
References: <20250701005321.942306427@goodmis.org>
	<20250701005450.721228270@goodmis.org>
	<12c620ea-4bee-4019-8143-8ecbaeeafc11@efficios.com>
	<20250707154245.7eeeb448@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5AD786000F
X-Rspamd-Server: rspamout02
X-Stat-Signature: t8cy4pfn5kbywkbtcd3fwte3h7einzic
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/hJGEJuHvQAlzXM3nyahxqw5XL3ZPesbc=
X-HE-Tag: 1751922066-394350
X-HE-Meta: U2FsdGVkX184maHp6AbgAf/k2jFaTcaeSpS3K9TchigjJp+AUwA/uPIZxrsWq7w+ozKsT2CHLZtdR/CMMdEZsv1i16RlIkZ3Whg0lthKOJcoNFa0x7FuSkemuK4mA0+U8bZuj/O51FHf+WNP1GIjLiW7wPxUeDVpTZmok2m+9aPbm1I4hEWS+uOWaWIyd5V54lInMb9k6AH42l8AEwtbpPgUmNFWTuLi5+2Su6KN+wFZejFeA4XWH36aDSjowkMB+UJjVp0UDuLZ1KLiLOSGrjhiu8uNgeS95bn+njQz+L/NPoC+dzquqoBguOOpBvdM8Uxx3Rfz6O6M1oC2du4HLTFx2lVrFt6GpeZGY9hN6x1QyknJ6BqBptV48fHoSaN5pahZ+k18pqtE38ILr/yfnJ07mKf2V+5hvzpnN7isVTDnmpmM9z/clCEPpEaUhbc/

On Mon, 7 Jul 2025 15:42:45 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 4 Jul 2025 14:20:54 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> > > None of the structures introduced will be exposed to user space tooling.    
> > 
> > Would it be possible to make those unwind APIs EXPORT_SYMBOL_GPL
> > so they are available for GPL kernel modules ?  
> 
> I'm OK with that, but others tend to complain about EXPORT_SYMBOL_GPL
> for functions not used by modules in the kernel. But I personally feel
> that LTTng should get an exception for that rule ;-)

I just noticed that this was to patch 1. The functions here probably
shouldn't be exported as they are more internal to the infrastructure.

In fact, I think I'll move that macro into the user.c code. I don't
think it should be used outside that function. And the
unwind_user_start/next() could also be static functions.

-- Steve

