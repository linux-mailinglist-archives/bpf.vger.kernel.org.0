Return-Path: <bpf+bounces-41572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAFD99883F
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 15:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E821F21CDF
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 13:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5AA1CB523;
	Thu, 10 Oct 2024 13:49:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A3B1CB309;
	Thu, 10 Oct 2024 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568161; cv=none; b=bVsH8g0JvvAVMk1tHhhC/zEXjIYQsqT/Hf33RC/QV3YsQzgXhUDBNUcfq/xMZFteBf01gyTSbfqjt5YsMXA4FWkKmEmEEJie6sjbyZum+6bHuo6t/nkEji3imoqcBpjLKQUd2jbxdXsKcKtbJMJFW0GeUPINoR0VZ/RZoo+g/DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568161; c=relaxed/simple;
	bh=MUZDI/UFfGGECYVXxsnrqEk2MO969Rn+aKLck0TcTks=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PBzueg39O0Dpn7JB4PaE0uhCCfiYAs12tr/Wn8V5bDezADE/GghD42L0czE5yICS8ucID1M7njX3SAb4MOyQlQBu/qm0dUCWxwsAItnpqxDTxoeyH+b7947jWxoGKDsxagtBfmSysPuxtY4zaonyQQb4EE8rsvUOVeIXZrUcEow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE263C4CEC5;
	Thu, 10 Oct 2024 13:49:19 +0000 (UTC)
Date: Thu, 10 Oct 2024 09:49:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Juri Lelli <juri.lelli@redhat.com>, bpf
 <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Jose E.
 Marchesi" <jose.marchesi@oracle.com>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: NULL pointer deref when running BPF monitor program
 (6.11.0-rc1)
Message-ID: <20241010094926.146c6b38@gandalf.local.home>
In-Reply-To: <ZweXrhopOmEb9rMx@krava>
References: <ZsMwyO1Tv6BsOyc-@krava>
	<20240819113747.31d1ae79@gandalf.local.home>
	<ZsRtOzhicxAhkmoN@krava>
	<20240820110507.2ba3d541@gandalf.local.home>
	<Zv11JnaQIlV8BCnB@krava>
	<Zwbqhkd2Hneftw5F@krava>
	<20241010003331.gsanhvqyl5g2kgiq@treble.attlocal.net>
	<20241009205647.1be1d489@gandalf.local.home>
	<20241009205750.43be92ad@gandalf.local.home>
	<20241010031727.zizrnubjrb25w4ex@treble.attlocal.net>
	<ZweXrhopOmEb9rMx@krava>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 11:00:30 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> > Unfortunately it's not that simple, the args could be moved around to
> > other registers.  And objtool doesn't have an emulator.
> > 
> > Also it's not clear how that would deal with >6 args, or IS_ERR() as
> > Jirka pointed out upthread.  

For the >6 args, I would say that the verifier just says any arg greater
than 6 can be NULL. There's not many trace events that have that (if any).

> 
> another complication might be that the code in tracepoint's fast assign
> can potentially call global function (?), that could do the argument NULL
> check and we won't have its code at objtool invocation time

I'm starting to think that the best thing to do is to have the verifier add
exception code in the bpf program that just kills the task if it faults on
reading a tracepoint parameter.

This all started because it was assumed (incorrectly, and I was never
asked) that trace point args can't be NULL. It was always the case that
they could be. This was not a regression.

Now that there's existing BPF programs that assume that tracepoint
arguments are not NULL, is a bug in user space. Not the kernel.

-- Steve

