Return-Path: <bpf+bounces-62152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E94E9AF5EF4
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 18:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D011C428A2
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 16:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46B5275112;
	Wed,  2 Jul 2025 16:47:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2302F50A8;
	Wed,  2 Jul 2025 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751474870; cv=none; b=N2diBuiJeuWygCRJlxsBl3OUMMh2ibI7kvdrSkHnLouvTn4IBOW0+BvH+L7ZrmNbIw1qfnhz7A2xiRMXIWw5EMBuAlbXHLmHllQwUlIaWhWXZ85ych5p6IgkWWh+6fv36n2ewzWgL9faKHZ+jpyjr/C1uBgBXTmK925YxNN0dZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751474870; c=relaxed/simple;
	bh=g1+k2nPM6RxeEUCvtw0vrTy0LPvjf9hZ6rmLV2y9xgU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QeP0IB3XWtZi6CzLh7kPAbjNQXgVRG9iYcMCEEYnszNR41TKLfyDLHJx+WWYE439HMvR3udW8QQj5fAtb4Edhov8bEiDWohqi73FSgEl3e55AjwGbnW7uTbykGTJgNHLVMmrqKFn9vWmthXB8zc77iFuwML1lOboGs9NFMLTtn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id B8157140367;
	Wed,  2 Jul 2025 16:47:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 1BC9B1A;
	Wed,  2 Jul 2025 16:47:39 +0000 (UTC)
Date: Wed, 2 Jul 2025 12:47:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>
Subject: Re: [PATCH v7 00/12] unwind_deferred: Implement sframe handling
Message-ID: <20250702124737.565934b5@batman.local.home>
In-Reply-To: <7eea50a5-e1b0-4319-9a25-cb8b327a836d@linux.ibm.com>
References: <20250701184939.026626626@goodmis.org>
	<7eea50a5-e1b0-4319-9a25-cb8b327a836d@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1BC9B1A
X-Stat-Signature: 6ab6bcboemhxxcrt1jugnewqbfujyn9q
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+RCYfk1ij87wG5Mg8mX6pSoPsPrUnbTOI=
X-HE-Tag: 1751474859-717133
X-HE-Meta: U2FsdGVkX1/xQcC/1vbjLDT42vnA5rZK0DJXCURp+LYg8DRsJ82VPBa8c9m0LqtAKwuu5W39stjZMdi2qQAA4h0SNVrkO4DH8HZfRi58Ha2QuWM+3w2SwhFZhM3C3hlCcNnhRd85h1AQemZyfLQxZJgM2eg2S8ivRlduwklYD8It9hB18FH1yVZJHEFrhVTZCjygyKVXwUU3ATdCKPxHTOHJtqgYE7a8CuLZYltQG+2p4WXgdPUVJK5h/RA42GtKtD944lR67kYGwUJyXZxkXdqNE/6x4vrCOCS5fssDUmUhIaspx9KOf2HNFrPyMylrtKKLhSRTFDLwd66YgtVMz2eByVMV9KviO6TT2QM9iGqiw0DrblOZcbRZRg9+haEyGawdPxklVxjawGkZ6V9WzYtD9GmQMbM2+87sz2hDTiZlnuAzc76R4IoPj3tpNpyxPP7ZKP3galnMvGI32EN8qkbLlSQVp+5icS7PpOyu/ZmauLO7jY7X4IrLMG4VFeHr

On Wed, 2 Jul 2025 14:57:22 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> Hello Steve!
> 
> On 01.07.2025 20:49, Steven Rostedt wrote:
> > This code is based on top of:
> > 
> >  https://lore.kernel.org/linux-trace-kernel/20250701005321.942306427@goodmis.org/
> >  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git unwind/core
> > 
> > This is the implementation of parsing the SFrame section in an ELF file.  
> 
> ...
> 
> > The code for this patch series can be found here:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git unwind/sframe  
> 
> Wouldn't it make sense to include your related perf (tools) series [1]
> in that branch to ease testing?  Provided you also include the minor
> fix [2] to make perf tools work. :-)

I was planning on making a branch with perf and sframe merged (haven't
pushed it out yet). Since sframe doesn't technically rely on it (I use
tracing too test it too) I'm keeping them separate.

> 
> Additionally it would make sense to include the patches from Josh that
> add SFrame information to the vDSO on x86 [3].
> 
> [1]: [PATCH v12 00/11] perf: Support the deferred unwinding infrastructure,
> https://lore.kernel.org/linux-trace-kernel/20250701180410.755491417@goodmis.org/
> 
> [2]: https://lore.kernel.org/linux-trace-kernel/51903e66-56bc-42a4-b80c-9c3223e2a48a@linux.ibm.com/
> 
> [3]: [PATCH v6 0/6] x86/vdso: VDSO updates and fixes for sframes,
> https://lore.kernel.org/all/20250425023750.669174660@goodmis.org/

I have them in separate branches too and will be posting them
separately. Again, the "merged" branch will contain them all.

> 
> > Changes since v6: https://lore.kernel.org/linux-trace-kernel/20250617225009.233007152@goodmis.org/  
> 
> > - Moved the addition of the prctl(), that allows libraries to add the elf
> >   sections to the kernel, to the last patch and labeled it as "DO NOT APPLY".
> >   This should instead be a proper system call and work to make it robust and
> >   flexible still needs to be done. The prctl() patch is added for debugging
> >   purposes only.  
> 
> Does PR_SET_VMA [4] create a precedent case for the SFrame prctls?
> 
> [4]: https://man7.org/linux/man-pages/man2/pr_set_vma.2const.html
> 

At the last sframe meeting we came to the decision to make it a proper
system call. Just seems cleaner that way. If others feel prctl() is the
way to go, we can definitely do that too.

-- Steve

