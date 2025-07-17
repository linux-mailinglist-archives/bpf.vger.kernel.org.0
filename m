Return-Path: <bpf+bounces-63558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07311B08398
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 05:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DFD5A4596E
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 03:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C492C1F582C;
	Thu, 17 Jul 2025 03:57:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECAA4A11;
	Thu, 17 Jul 2025 03:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752724661; cv=none; b=jooYAejTznQMnr/acdhaxqaCuQSGGs4GulE0u7YtLEnnzSoifZCBcYBwWD2tPnmPnAnXHwGQUNnRoQJ4mwZ5YjY7o599A7Zoi6DL7lQ5xaD/pbOvzQ1G6Ks0t6gbkv+mwSvSg07Rr9IkDeM4xO4tqQSdOB9xanFcygJ/FC9Lf2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752724661; c=relaxed/simple;
	bh=/Wcq1ACFNdx2ow0ykhdjhlATIRdXhubEO21CSF4mXyA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bEi8XQN/gBpS4RrpFXk1OQJ3RzGc4LciMkZkuNwA0EH3SZv0jW0SdU14/H9N6CmODsffSL2hwenbkkEteAL/BEOhQbhsbhFd0qeIVyz0RWc0QpeHM0pqfCoIu/5iu/F0SQ0EYaZIwds5MK0zs01bbuFxX58RXBrHaxtHemjs85I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 3A1E412E2E9;
	Thu, 17 Jul 2025 03:57:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 336F020024;
	Thu, 17 Jul 2025 03:57:31 +0000 (UTC)
Date: Wed, 16 Jul 2025 23:57:51 -0400
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
Message-ID: <20250716235751.119a1273@gandalf.local.home>
In-Reply-To: <oasyyga72yuiad7y2nzh7wcd7t7wmxnsbo2kuvsn5xsnuypewd@ukxxgdjbvegz>
References: <20250710163522.3195293-1-jremus@linux.ibm.com>
	<20250710163522.3195293-9-jremus@linux.ibm.com>
	<oasyyga72yuiad7y2nzh7wcd7t7wmxnsbo2kuvsn5xsnuypewd@ukxxgdjbvegz>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 33jwewuerc8foyfcaek3xc5ekq3q1idq
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 336F020024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+CHvE0rseswar59cxqUuLAMJ6f+JgT6n4=
X-HE-Tag: 1752724651-985942
X-HE-Meta: U2FsdGVkX19CvRwyrQ8B55S+Wqqs+O/Ob9ObLkdMzkTFa/3d+qeI+avsV9Azxr28fsLrQXTUEx+M9LX/JkybAHkSwefbUhXZmjAzt9AwGZzMF3GRfcwMgGL8yQ0yLuFnwnWp0LFjqugzapGcXiLah9rKNWdhWWyzF/1Xhyv4jWv3AOVngGu0+lm1msfchmpbl/FWqzXQAvzRuoDhh+vXfPMl21bEbP6ra8GPFvodzZAfsXUgZHV2sp7r1/uy6de0R+Pdyr5+MMowDWueXn7Mp2jmZbGolGmHKoRABJfsb3tCoDxpdAZV/VZAkJsFWeGYs08tZFnGi5YjmBw4Y/7MLa0UYhNmtJzk

On Wed, 16 Jul 2025 19:01:06 -0700
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> > +		if (unwind_user_get_reg(&ra, frame->ra.regnum))
> > +			goto done;
> > +		break;
> > +	default:
> > +		WARN_ON_ONCE(1);
> > +		goto done;  
> 
> The default case will never happen, can we make it a BUG()?

Is this really serious enough to crash the system? WARN_ON_ONCE() *is* for
things that will never happen.

The only time I ever use BUG() is if it's too dangerous to continue (like a
function graph trampoline that gets corrupted and has no place to return
to). In general, usage of BUG() should be avoided.

-- Steve

