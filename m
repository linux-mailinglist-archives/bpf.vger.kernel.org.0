Return-Path: <bpf+bounces-60955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6BEADF108
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 17:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43BAF7A44E8
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 15:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DAB2EF289;
	Wed, 18 Jun 2025 15:20:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CCC1F9A8B;
	Wed, 18 Jun 2025 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750260017; cv=none; b=iQ3gvsPV+jL/HdR+wu7saawK7IGNw2Ozsv9QJtrWeKmFxPDcNmYlwAw60yBy6Li5uFCp/aW0NZt6UQOYzpEs9ZQOSEKesHVjtZofeahZTjh3OasZ8+S8h0E9Vwkt0p/NK6eVRaUroC1AHto8deNlGOM0NCsW5/LroLpdIsEwgbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750260017; c=relaxed/simple;
	bh=M5lnijI13V/qYoxT9osq8y5e8Gbr0yn0hqjpvJdZJ7g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lv+1cunUjEPrQkA1lMMNxqrNfjFOaMC1/qr1CDAul69tbWAFmysLfY/tFTADaZFBbO6wgzUQ+l0AdoGzqTOuVZkZR00dWLeT8YFh1Tx3kRbJ4N3nuzTLRC29OmEB5J0VXyK8Jcarih4FMKxV4BJWQdSOpvkFoyyVF8Slvl78VIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id A85711601A2;
	Wed, 18 Jun 2025 15:20:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id A28892F;
	Wed, 18 Jun 2025 15:20:07 +0000 (UTC)
Date: Wed, 18 Jun 2025 11:20:15 -0400
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
Subject: Re: [PATCH v10 04/14] unwind_user/deferred: Add
 unwind_deferred_trace()
Message-ID: <20250618112015.56507e6f@gandalf.local.home>
In-Reply-To: <20250618135907.GO1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
	<20250611010428.433111891@goodmis.org>
	<20250618135907.GO1613376@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: r7eq6e89kmdqg5zdnibfs9qjqfqw8xno
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: A28892F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/v39Vor/fXhiByYy9BWsvEhl9lM6az1FQ=
X-HE-Tag: 1750260007-255307
X-HE-Meta: U2FsdGVkX19ieS+6nHd0Bg4L7pE7eBCmTgEZV/wJWkDKBF698hzLF/yVfqQwTRtLew6nDayy7fTN8lnz5JqAcKAGrxI+x+7sAm9F2/X1ppk4XivKFTUR3fp8q1/tI/IV8186HaFmEVAgVc34GFleedu03Lsw6i/zi2tLF0kHlJd/qiKfdTHwt1Q7sahaFw9+pFrnjc2oI0oaKioCBVkFzkablL30WOlj6qcA31PBDTzuLqI9uPoI8WW0h79kqCBiuqfHykEup6t3USNqT3MgzHenfE5B26pbpS13rvK8a09MFqdBvX1WAvqlm2GDXN2/lMBKrE3KZB2yrFzN6PeEgoDO03Gh7nal9YkO5AE66V0tOTw3Wdun5vHFKKgSavec

On Wed, 18 Jun 2025 15:59:07 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Jun 10, 2025 at 08:54:25PM -0400, Steven Rostedt wrote:
> > diff --git a/kernel/unwind/Makefile b/kernel/unwind/Makefile
> > index 349ce3677526..6752ac96d7e2 100644
> > --- a/kernel/unwind/Makefile
> > +++ b/kernel/unwind/Makefile
> > @@ -1 +1 @@
> > - obj-$(CONFIG_UNWIND_USER) += user.o
> > + obj-$(CONFIG_UNWIND_USER)		+= user.o deferred.o  
> 
> We really needed that extra whitespace? :-)

Oops, I have no idea how that happened. Especially since emacs doesn't do
tabs well.

-- Steve

