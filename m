Return-Path: <bpf+bounces-63600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35520B08CCF
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 14:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 975CA7A70E3
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 12:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F902BD590;
	Thu, 17 Jul 2025 12:25:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AD02264B1;
	Thu, 17 Jul 2025 12:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755116; cv=none; b=XUID6ZhI0EzsMoXcpk9T1ZXGb36oPHb3jKDo43eZUwu6ghBMRDTMXyEvnFLejwvWY8y+qgEvWiVAAPGK/14Qu2ydk+O1m6EIoAZiOm1Ht6cijXH5xgOY0h0MioBh1iv4LgUB0sEseIWiqTvx6GBgJ2rlieIyAZ84rqDBbT24efQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755116; c=relaxed/simple;
	bh=WpyHnG6Is/7L443QOHma13daWhpEaOHSVCQ53KQfHUk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKJSjSM2960vgrq7z0LSs9pxFJ1wq3UUEw7WjayaFEsWnoJDnM/jG4uyC8n6YmwfktQyFZmiOeg1vgO41FUyP8ZaLWPIGxjzXLQWBau0KyF+gLjP1l7VCfd1ARTnSzR5Udrz+4uNS3M+P2qa4FqorHRzm+lBV5OdeV05Rr3wLD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 469D712E298;
	Thu, 17 Jul 2025 12:25:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 0C3812002B;
	Thu, 17 Jul 2025 12:25:05 +0000 (UTC)
Date: Thu, 17 Jul 2025 08:25:26 -0400
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
Message-ID: <20250717082526.7173106a@gandalf.local.home>
In-Reply-To: <47c3b0df-9f11-4e14-97e2-0f3ba3b09855@paulmck-laptop>
References: <20250717004910.297898999@kernel.org>
	<20250717004957.918908732@kernel.org>
	<47c3b0df-9f11-4e14-97e2-0f3ba3b09855@paulmck-laptop>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0C3812002B
X-Stat-Signature: fpu363ytmhcu87h3oi58wmhojsfids9k
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18x0W+hhfZDN7/zGSuRaCHdrM2V6QvI8V8=
X-HE-Tag: 1752755105-153269
X-HE-Meta: U2FsdGVkX18c9dT0TTHtHGOmlLFUP9JpCqw8h8R+dg3gugOYz3e8kaSqnpjSD6TQPcf+iSOKCQGMxIbc4U5EePysxFQ9bagxiSP1HBg/Hh5tfADEnvyGcMo7s1KkESFZtB8XG9IW/91UzU5IVLHXlWJxiuqGclnshulQcfiUNd4k/GvhPCv/OmIlByIYQAB9TTKdlsp3zUY/Z40EE0y4nefrwy2MMMWoo2Qdw3R1Hfmr9qmzbQC+01mz5huLxTGry3iO/0XU5LDbNCK8mnArGKq3k3o/tPWH6R+BrHw10YQD+8T8qIDIo/QREgg3AKZSJqFc1yuLSaqaG1AN+uz3wAsFA/iQXuvu

On Wed, 16 Jul 2025 21:43:47 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > +DEFINE_LOCK_GUARD_1(srcu_lite, struct srcu_struct,  
> 
> You need srcu_fast because srcu_lite is being removed.  They are quite
> similar, but srcu_fast is faster and is NMI-safe.  (This last might or
> might not matter here.)
> 
> See https://lore.kernel.org/all/20250716225418.3014815-3-paulmck@kernel.org/
> for a srcu_fast_notrace, so something like this:

Yeah, I already saw that patch.

> 
> DEFINE_LOCK_GUARD_1(srcu_fast, struct srcu_struct,
> 		    _T->scp = srcu_read_lock_fast(_T->lock),
> 		    srcu_read_unlock_fast(_T->lock, _T->scp),
> 		    struct srcu_ctr __percpu *scp)
> 
> Other than that, it looks plausible.

Using srcu_lite or srcu_fast is an optimization here. And since I saw you
adding the guard for srcu_fast in that other thread, I'll just use normal
SRCU here for this series, and in the future we could convert it over to
srcu_fast.

Thanks!

-- Steve

