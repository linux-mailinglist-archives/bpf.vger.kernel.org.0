Return-Path: <bpf+bounces-62166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09965AF5FB1
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 19:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB5D521218
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 17:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D794301132;
	Wed,  2 Jul 2025 17:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFa93k7p"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B488B2FF490;
	Wed,  2 Jul 2025 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476471; cv=none; b=uVs2Qv38RXWMTZFhpudcOqMm33EeM4dy3uhogjyxzlWLpOuvrR0LO6P0y8b9QPrhvuHJuUBla4GHEYkciVLJNpMpjC1amNVOjFKOEwIdVmXTHeMsjfz5HMDAMykHu+lcfXnbl0T/UXEIxOHfJZi8CCI/iGg26nJxa83kQVAmgn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476471; c=relaxed/simple;
	bh=PrCZpvNyjYfUaaLn7PMgQspsagzM2AeP465bCGdyST8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzkNVMQPmZ60TFbtwV+p+4Msyi2u6QwGgFEp242n5enDlczMKcdQXdxtRPVqFbjwLHuRD8B9MS9jNXXnHgrONem096s56uUeykdJ53K8k034cViRkFIl0Rh6eH4/L6TbpAxSB30cq2D9GldYO6yG3+mmTGhBn7c3YoTaohHFk7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFa93k7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B466C4CEE7;
	Wed,  2 Jul 2025 17:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751476471;
	bh=PrCZpvNyjYfUaaLn7PMgQspsagzM2AeP465bCGdyST8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZFa93k7pHQsnWvDkyWsuQF6QgXzetPQCMJskiOaJ1VM+3PLN4VXJQ4bG88BXOLydy
	 LtIjmllWrZrKlGpufY6hjlCSqekM8AR93RfG5wsuOU9SovGYci4NfHnM/MSajgnfn2
	 lVh4HU6KgiamaKrBIxtYbzC9ft22tyQsh1SWMlbfSG69FM4W2DfBpGR47gQdiBFxpv
	 5XNj7ghmU4PyomU5oL0Lak5EMRXnj5LpnVdrt8s1NCeQ1bz8zA0npppO6PbXmT2x11
	 Am8HBiWxOL25C2lDSHEZXulMrCCemm0wrksiAWoWlb8rTUdyFfVvdrh9nwhsqiIAbL
	 VWvua0nZaStPg==
Date: Wed, 2 Jul 2025 10:14:29 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sam James <sam@gentoo.org>, fweimer@redhat.com,
	akpm@linux-foundation.org, andrii@kernel.org, axboe@kernel.dk,
	beaub@linux.microsoft.com, bpf@vger.kernel.org,
	indu.bhagat@oracle.com, jemarch@gnu.org, jolsa@kernel.org,
	jpoimboe@kernel.org, jremus@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
	mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
	torvalds@linux-foundation.org, x86@kernel.org
Subject: Re: [PATCH v11 00/14] unwind_user: x86: Deferred unwinding
 infrastructure
Message-ID: <aGVo9b1xiT1Moq-P@google.com>
References: <878ql9mlzn.fsf@oldenburg.str.redhat.com>
 <87wm8qlsuk.fsf@gentoo.org>
 <20250702121502.6e9d6102@batman.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250702121502.6e9d6102@batman.local.home>

On Wed, Jul 02, 2025 at 12:15:02PM -0400, Steven Rostedt wrote:
> On Wed, 02 Jul 2025 12:44:51 +0100
> Sam James <sam@gentoo.org> wrote:
> 
> > In one of the commit messages in the perf series, Steven also gave
> > `perf record -g -vv true` which was convenient for making sure it's
> > correctly discovered deferred unwinding support.
> 
> Although I posted the patch, the command "perf record -g -vv true" was
> Namhyung's idea. Just wanted to give credit where credit was due.

Yep, it's to check if perf tool ask the deferred callchain to the
kernel.  To check if the kernel returns the callchain properly is:

  $ perf report -D | grep -A5 CALLCHAIN_DEFERRED

Thanks,
Namhyung


