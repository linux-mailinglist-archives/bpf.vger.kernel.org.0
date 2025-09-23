Return-Path: <bpf+bounces-69372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA73B956F0
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 12:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ED024841A5
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 10:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B28E320CC9;
	Tue, 23 Sep 2025 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aejIdIAX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E123595C;
	Tue, 23 Sep 2025 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758623338; cv=none; b=MZ8CcbJiaerxLlIeyPMF6XfWM//ruPE4tH+dthwRt8kkeamz/ntLxd5d4rEARtQTLIZAfD6Bypbzl10eu6UykYA6+qloZQFPt+LNaEHvRROJav/myXYDFeSrRTxAFpDa1krqXnyL0/QIuI3mLlqvVY+zft18mIiN0L1dr86dp/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758623338; c=relaxed/simple;
	bh=aandL0IO1TEN8UynBwUTcT5P8YA24LOKifzprqPZ8eA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pcc23dDMJcLN6B2Vcw39u2otFPoh4nM7dDRyR9olsNdgqzE9QvsXUPq2BJlLoO9pMzpPpj2Tv76bM8iZouJB2N41j5ysKktPn8SRnqplrSut5lm01IpGAFqTsuNIWRm8w8KMF85Ev5Jg6/kZr8ZhnrQZVJ2U4eVvKoZ/yFH7Fkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aejIdIAX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3DDC116B1;
	Tue, 23 Sep 2025 10:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758623337;
	bh=aandL0IO1TEN8UynBwUTcT5P8YA24LOKifzprqPZ8eA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aejIdIAXP8cB8XbFVTn50JUyxMDaOme7tAshtuA32csDbVeYckRFJ0MIV8BSNOgXk
	 gjtw0QpWBTnEB/jQ96GSWvDf9eeSVldqBRkPpucPML5Yjy1fn7PypC1ZYyqcqYfGe8
	 UW65g3ee59xTiyAywusKQzlIR8xLjCrJ9BZkTyRhzM/MaqqqEzq/GvTljuxxJNDpkp
	 Yk9ZaroKQYxXLXH2w6+1lBP1D9mZRpSaPvBc6VFVV6GXixeQYvVacQWN018LsgtA3M
	 eVpOdtukynX9BX/yZ+brGDqfdMIyRh1f/Jc3hi7FmGMpbClTAX8pLxsGoibwM8vECa
	 0hJjYEBF/2TyA==
Date: Tue, 23 Sep 2025 06:28:48 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave
 <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, Linus
 Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, Sam James
 <sam@gentoo.org>, Kees Cook <kees@kernel.org>, Carlos O'Donell
 <codonell@redhat.com>
Subject: Re: [RESEND][PATCH v15 2/4] perf: Support deferred user
 callchainshttps://lore.kernel.org/linux-trace-kernel/20250827193644.527334838@kernel.org/
Message-ID: <20250923062848.0bc4ff2b@batman.local.home>
In-Reply-To: <20250923093821.GB3419281@noisy.programming.kicks-ass.net>
References: <20250908171412.268168931@kernel.org>
	<20250908171524.605637238@kernel.org>
	<20250923091935.GA3419281@noisy.programming.kicks-ass.net>
	<20250923053515.25a1713e@batman.local.home>
	<20250923093821.GB3419281@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 11:38:21 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Sep 23, 2025 at 05:35:15AM -0400, Steven Rostedt wrote:
> 
> > I even pushed this to a git tree. Not sure why it didn't get flagged.  
> 
> I've been looking at this... how do I enable CONFIG_UWIND_USER ?

Hmm, maybe that's why it wasn't flagged.

> 
> I suspect the problem is that its impossible to actually compile/use
> this code.

It needs an arch to enable it. Here's the x86 patches that I was hoping
would get in too:

  https://lore.kernel.org/linux-trace-kernel/20250827193644.527334838@kernel.org/

Hmm, but I had a branch that applied all the necessary patches :-/

-- Steve

