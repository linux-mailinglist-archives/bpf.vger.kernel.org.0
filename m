Return-Path: <bpf+bounces-60985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CACA3ADF605
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 20:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 225943AB5EE
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 18:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCC12F4A1E;
	Wed, 18 Jun 2025 18:37:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C5770830;
	Wed, 18 Jun 2025 18:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750271848; cv=none; b=Im7ZmlG8Bf7MPuoKc+B7ES+ppucsyaddsDIH4/PA6Z+glpwOXS695pVFbkT0BwJw+dWU408ZarWtgVcDfJeq6iH+LCAmmGfc/OrkkQYdSVTt5Hfbq5lwsB6ZoIdN/c5I6BpvCMJMAcfm9++4f4Cm3CPie3LogHdx7aqbCd01gkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750271848; c=relaxed/simple;
	bh=f+VRcUrtfNfbsVlJGbX2ScwKmROUjzBgQf0qso+uhm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7REBSZFj71USOZ2fs65Mg5IfrouCbD+Y1f+lApmcZ0+qcwi08SqaEFiajHAUkTVfOAza30z2YOiRgqIpNLkFwLw91gEkoSFwvFfekRT5PuTqFkwKcNkkpeASGkwWnYD0Nj8/U18/dglCHm5asC367cT/oOsHpo4BvUrJjCz09w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 33E5F14014E;
	Wed, 18 Jun 2025 18:37:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 5E7D43D;
	Wed, 18 Jun 2025 18:37:19 +0000 (UTC)
Date: Wed, 18 Jun 2025 14:37:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 03/14] unwind_user: Add compat mode frame pointer
 support
Message-ID: <20250618143727.1a406e41@gandalf.local.home>
In-Reply-To: <CAHk-=whGWM50Qq3Dgha8ByU7t_dqvrCk3JFBSw2+X0KUAWuT1g@mail.gmail.com>
References: <20250611005421.144238328@goodmis.org>
	<20250611010428.261095906@goodmis.org>
	<20250618134641.GJ1613376@noisy.programming.kicks-ass.net>
	<20250618111046.793870b8@gandalf.local.home>
	<CAHk-=whGWM50Qq3Dgha8ByU7t_dqvrCk3JFBSw2+X0KUAWuT1g@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: kaft8otmjzhueip7qahnbp88fsp9xi8f
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 5E7D43D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+UN8JBSQYqAgIPNeKriITrNSMcFBTyWhk=
X-HE-Tag: 1750271839-295078
X-HE-Meta: U2FsdGVkX18zLH47Eoc93NUEohNXYdPh4EqpqXsDDd3ZFtgkChU+zs5S/zd5x9G439Qu9QeJWkfk0FiGsn92CPKmYEbX7AWZvDSoBXRRf3zEae49Te6jlvhoVimCjaWAz8vIeLwJTFpX4ccJ/OjOZK/CR+xhe/fBp1SF+mQ6ZHtQu19Uj3TuzjHCJkrPh52728T/xIBEMVdIQmsQTu6R0xwO4MWzKa35i92O6QUfw3lZJEPucRX/bqdqs5FCVOcS8UAGtuRdZsMOSiWFY02g9dXXmxb3UMeyK+GdQAZ0OeZ0arEYSx1J0ETUOROdz1owLQ9S7cM/53KwkIBQb+mBffv9nUDIk+vILmZDT8z16frKmok3lqbd4y+Bho2RQuy3

On Wed, 18 Jun 2025 10:52:22 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> In this case, I have to agree with PeterZ that this just looks odd:
> 
> -       if (get_user(ra, (unsigned long *)(cfa + frame->ra_off)))
> +       if (UNWIND_GET_USER_LONG(ra, cfa + frame->ra_off, state))
> 
> why is UNWIND_GET_USER_LONG() so loud when it just replaces "get_user()"?
> 
> Note that "get_user()" itself is a macro, and is lower-case, even
> though you couldn't actually do it as a function (because it changes
> its first argument in place).

OK, I'll make it lower case.

Thanks!

-- Steve

