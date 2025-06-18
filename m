Return-Path: <bpf+bounces-60949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8A0ADF0C1
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 17:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9967B4A0EF1
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 15:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E6A2EE980;
	Wed, 18 Jun 2025 15:09:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961562EE969;
	Wed, 18 Jun 2025 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750259357; cv=none; b=VBsN8NeTC6VRn1neEWUkud61T96KeAD+SzjMJLhos70uLTOpgua9pC44056+y3T3qGZDC0zxX8f2w/XZJjSN4ygjYq/4uWIGn4Xcgad8ABzNuRXv+B6mtaxJfIJ2OXc4badFK1l8SWlttJXdrlX3n2QnJ9XKYMMM00ZaKuBke+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750259357; c=relaxed/simple;
	bh=NM0uIEIBmKPjssAbv5WPcgFwThslLyP/kq/2pIREebo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aECsHcEyM1Z53ylkAz/5lHMVKda4/L6tsMe/nIFrO4QyQxA5Rqds38xxoJOiycnJ01A97MfLmTSfhPbyiyTX2qDUvj9mYc3lLc/Djz36fXmMt+ce4XMJ4OYisC8wh8L+xWL6PzHuhqsw5AaWFxkArgyK4xo+n8e94eXWMfwArJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id B9DB91CF622;
	Wed, 18 Jun 2025 15:09:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id C60036000C;
	Wed, 18 Jun 2025 15:09:07 +0000 (UTC)
Date: Wed, 18 Jun 2025 11:09:15 -0400
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
Subject: Re: [PATCH v10 02/14] unwind_user: Add frame pointer support
Message-ID: <20250618110915.754e604f@gandalf.local.home>
In-Reply-To: <20250618135201.GM1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
	<20250611010428.092934995@goodmis.org>
	<20250618135201.GM1613376@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C60036000C
X-Stat-Signature: 73r1rkxrmzpy3cjc799wwjicbegsdwmk
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18/w7XWFVjVdAceVbXFYHMY+StonkwTq24=
X-HE-Tag: 1750259347-837396
X-HE-Meta: U2FsdGVkX197pXU/+eJz5G9JDPn2gxiuB/VN7TILucKUgp0Vnd9b6s73QPwXmg6ohDGCwYBS52e+9HpjdgLM6UJDHhmfGD8lFNQbjAttS0AM957ejc0xPDuNLLF2yVd4AKMq55l3cmgddlyI3DTPPEdLqMuZDxvB1mZxvXTXfaJnlqpbMRXAeF4DdDott21EN5T6bbEMXgAqkFFJVPK6lv0kolDbiC0WnAUgOCiL4IWws4n/VZCmgkAg90BYDKkvapyojxv6mq0ZSlW/i/voyuZOQldY/HxCwuOilyKXyfLB7kkMxgXeYoJpGoV11YuajigkFMuvq/xLq/s/Mhw+1gYxuDmx4ajXsXDRvRv0FnA4uo+NoLSpatpuBh+e8z8Q

On Wed, 18 Jun 2025 15:52:01 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > +the_end:
> > +	state->done = true;
> >  	return -EINVAL;
> >  }  
> 
> I'm thinking 'the_end' might be better named 'done' ?

I thought it was cute ;-) (BTW, I didn't name it).

But sure, I can update it to be something more common.

> 
> Also, CFA here is Call-Frame-Address and RA Return-Address ?

I believe so. Do you want me to add a comment?

-- Steve

