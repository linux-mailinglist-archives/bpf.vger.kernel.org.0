Return-Path: <bpf+bounces-62149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396EEAF5E9B
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 18:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43BA44E6C69
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 16:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355B32FF48D;
	Wed,  2 Jul 2025 16:28:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C7D1E8338;
	Wed,  2 Jul 2025 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751473733; cv=none; b=CzL8TJcPuU+eDGnn1sELTnDW4xk3WKsMy/xRoifkrH0jEuDIT8At5uiSTjCdenRBofFKpxva5cAa5KIKZps5gdkyJrUdw9PWmrQ5Dn6/aBBS+IiqohW56w5IL+gO9KSVMnkoujAL1R4VCiAmaEe0/uuYouDuc6DB0OwerGaX8rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751473733; c=relaxed/simple;
	bh=O78i3PtYhDv6nhyXLLngxRq6HcuIuz811l6iEc8QL50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOPKdggoSBvfTHyn3OxgwAhjPoxc/4ryLuS4vsUwK7zigJIQOy5seP+RFMjxgQAE0D9wqOgBnlAu3MzOwGMoFl8FiR4+r4w4M1b+CZ8sCRZIXwstX6iWaHUX6Lm/jA7ts9Ng2rfT6b97/gREHEFqDvKlrsdWMoRYRYzjH8S9oBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id DAD3D1602BE;
	Wed,  2 Jul 2025 16:28:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 2B2DB20025;
	Wed,  2 Jul 2025 16:28:38 +0000 (UTC)
Date: Wed, 2 Jul 2025 12:28:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v12 08/11] perf tools: Minimal CALLCHAIN_DEFERRED
 support
Message-ID: <20250702122837.4bb6f259@batman.local.home>
In-Reply-To: <51903e66-56bc-42a4-b80c-9c3223e2a48a@linux.ibm.com>
References: <20250701180410.755491417@goodmis.org>
	<20250701180456.884974538@goodmis.org>
	<51903e66-56bc-42a4-b80c-9c3223e2a48a@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: hrz3gr8g8fnuszqbuqb6g7193rtpwyne
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 2B2DB20025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19STW27tMHZTYbWFvw7VDDjMIJafpmxz8w=
X-HE-Tag: 1751473718-90826
X-HE-Meta: U2FsdGVkX19qOqy4HoAPzJi9tpj2DHOur5zvbjBtGWXEhvfNsWPD0KDCFYiPR4CkwkQ/ooiR8NESddj/qft5mDm4IdNoqp3V4wBKp24XYQWpoLRCsLAlZ4jvr3LzyLKZ3GjuwUqlimtshFO80UcXhVoqEayyxTlkagitb2hc613XuGtjeFqncew5yn/9dK6m94OoUDvNAlgL5mAV++k88I0zlFSSGn4lZTmhBCQ00HUialrop1Ml7rkRf29Qzq56ZWCmz7tAZ+voi/r5jCuwB33TfYsDhjyK9ZI6UZLegM6PKOSA2iScAoj2FCqscd4gAVlMcZ6jFS1YNwcVmuV8pdg+OMaVyOJv

On Wed, 2 Jul 2025 14:23:24 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> > +struct perf_record_callchain_deferred {
> > +	struct perf_event_header header;  
> 
> At minimum the timestamp field added to perf with "[PATCH v12 07/11]
> perf: Support deferred user callchains for per CPU events" needs to be
> added here as well:

Thanks for the review.

> 
> 	__u64			 timestamp;
> 
> Otherwise this and any subsequent enhancements of the perf tools do no
> longer work at all.  But probably the timestamp field also needs to be
> used for some purpose?

OK, so this may be part of the discussion about using this as a
timestamp. The timestamp is the timestamp given by the deferred trace
infrastructure. It holds the time that this stack trace is valid for.
But that's assuming that the timestamp is the same as what perf is
using.

In case of dropped events, we could have the case of:

  system_call() {
    <nmi> {
      take kernel stack trace
      ask for deferred trace.

   [EVENTS START DROPPING HERE]
    }
    Call deferred callback to record trace [ BUT IS DROPPED ]
  }

  system_call() {
    <nmi> {
      take kernel stack trace
      ask for deferred trace [ STILL DROPPING ]
    }
    [ READER CATCHES UP AND STARTS READING EVENTS AGAIN]

    Call deferred callback to record trace
  }

The user space tool will see that kernel stack traces of the first
system call, then it will see events dropped, and then it will see the
deferred user space stack trace of the second call.

If the timestamps are in sync with perf and what is passed in, then the
tool will see that the kernel stack traces from the first system call
are older than the timestamp of the user stack trace and know that they
are not related.

Without either saving the timestamp along with the kernel stack traces,
or having the timestamps in sync, user space will not know whether or
not if the user space stack trace of the second system call belongs to
the kernel stack traces that were recorded in the first system call.

I guess the question is, do we just not associate stack traces beyond
where events are dropped? If so, we don't even need to save the
timestamp.

-- Steve


> 
> > +	__u64			 nr;
> > +	__u64			 ips[];
> > +};

