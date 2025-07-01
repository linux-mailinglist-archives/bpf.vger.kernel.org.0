Return-Path: <bpf+bounces-61935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F455AEEC83
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 04:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D631A17E6E9
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 02:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4871547E7;
	Tue,  1 Jul 2025 02:45:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AD229D0D;
	Tue,  1 Jul 2025 02:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751337912; cv=none; b=hO88ypUFd3zojRCyOgZ34S/u7laNKDRXuxwXqkV/mmNdjjvTB0a4uJAehnWU65DSwDZwsj/0074UmuL4cyTtOOUoUiifebJLtg28tcdkvcl0U7OxZdS3SysPk+WxsQq9XNJptE+c8yknfNcmlHOMQPTNDiFgvOubNlFQRibtkT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751337912; c=relaxed/simple;
	bh=NuyoxN+wb4pOukzmbIFxFgL8wau2xfrRWDw8vNoyG/8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZkN62OdgMOF5wtwvH/10TPhSgQt6de7Ru05BBdfnuybtNQ8cJy70PNs/8AptTwjwdhzV7BrDY5x3kmuR1aJhKDnn6aWmHe9DsBkvB5qX9Eq03PYf55DVZ99xPCa8plwOfEucrYW7kd0Aco7f/Qmpb9Z4ivNMnYRNrwxyoglS2IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 1AC13104D2D;
	Tue,  1 Jul 2025 02:45:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id F35D62002A;
	Tue,  1 Jul 2025 02:45:02 +0000 (UTC)
Date: Mon, 30 Jun 2025 22:45:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v12 00/14] unwind_user: x86: Deferred unwinding
 infrastructure
Message-ID: <20250630224539.3ccf38b0@gandalf.local.home>
In-Reply-To: <CAHk-=wijwK_idn0TFvu2NL0vUaQF93xK01_Rru78EMqUHj=b1w@mail.gmail.com>
References: <20250701005321.942306427@goodmis.org>
	<CAHk-=wijwK_idn0TFvu2NL0vUaQF93xK01_Rru78EMqUHj=b1w@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: xsnj6my7totg6gyn5kswzzsm51nasdc3
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: F35D62002A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19SiACo16cJN248UoQpQZEr31BhlqXpqsA=
X-HE-Tag: 1751337902-996933
X-HE-Meta: U2FsdGVkX18Jye2GUfiNcy0SvWe50i6P5lr63s6hbfUZFtXJFMGCqIp4oHCjzy+AKcEJsLaWtJWREfX2V8y0BYad2Cy6A9eejIUH3Fno1Nwq0rkI+9RadkgJ/VDXiYwgYSiV5ECaN9e7NrVM+aLNTjzgcQM0VBgHZaiEK5AW+ZLoVFBWoFjdkSa0alAz6mxTF6RB8JbjNcIjdoFwwxV5wfBja+Y7joL4IJe8DJDUAYHN2hom0mN3IvcXmYT/7DCNr+AbAHGhzDOUe5VleNW+OwXiDW+aabWSCtmdZkFXZrML9O3x/2JkYej33L1gAjytLCNaO0JsK8ZKtrYwGpSv2eO7OnhrVBtS1g0uuXDDs7cdsNxWHQ6sFZdJyswpFP6egj+jcwspkci/EyZYETcPV4YM97rsD004AfOkoG+83fxo0PxsaesL8CgqBgfbeid0TFs8rhiTnLswpIEDm7WdQv1SiZWSzm6MfaHND3REckAeu/BQcLpA+xnP92A6yURK1oFMpkG/8gI=

On Mon, 30 Jun 2025 19:06:12 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 30 Jun 2025 at 17:54, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > This is the first patch series of a set that will make it possible to be able
> > to use SFrames[1] in the Linux kernel. A quick recap of the motivation for
> > doing this.  
> 
> You have a '[1]' to indicate there's a link to what SFrames are.
> 
> But no such link actually exists in this email. Hmm?
> 

Oops. I cut and pasted from v11:

  https://lore.kernel.org/linux-trace-kernel/20250625225600.555017347@goodmis.org/

But ended the cut too early. I stopped at my sig:

---
  Thanks!

  -- Steve


  [1] https://sourceware.org/binutils/wiki/sframe


-- Steve

