Return-Path: <bpf+bounces-52438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AE2A42F3A
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 22:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB85E171AD3
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 21:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63711DDC33;
	Mon, 24 Feb 2025 21:34:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479F5469D;
	Mon, 24 Feb 2025 21:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432881; cv=none; b=BLmwqga/xUsQFu8BtYUyjEpNiEezxDUivEy5NREfPqn9eybzne6s8EIaRNweaObhWuZY9trZpg8AT/cAH6WwfvbZhrM6JR1Nev8ZPxltaexL7xFMj6LxzzckWCY8cRXz3imQtSJeHRvrFCdwJ3WyV99ZKVIwJBFOqM8a+JKJTX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432881; c=relaxed/simple;
	bh=xJDyPX/kbtIszyonpoNVCKIWwERsN5Sbj1e5YYCc3vA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mif/dzXPMCRAVzxcx0sgGXmuFS6scXw+IVObz9qK0laRnYJrgW80P58ftOZ2Z/mnAFsBhJTHx4l02zPb8BWq1djg+JemVc7q9So+2ql0z9vZFmV7hRepIK1ArDvBd0QXQulElQNEEucKXdIVe6KaMKCKKfL08PCLmIiX/xEkSe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF62C4CED6;
	Mon, 24 Feb 2025 21:34:37 +0000 (UTC)
Date: Mon, 24 Feb 2025 16:35:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf <bpf@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Linus
 Torvalds <torvalds@linux-foundation.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas
 Schier <nicolas@fjasle.eu>, Zheng Yejian <zhengyejian1@huawei.com>, Martin
 Kelly <martin.kelly@crowdstrike.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@redhat.com>, Heiko
 Carstens <hca@linux.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v5 4/6] scripts/sorttable: Zero out weak functions in
 mcount_loc table
Message-ID: <20250224163513.1ea561b7@gandalf.local.home>
In-Reply-To: <5225b07b-a9b2-4558-9d5f-aa60b19f6317@sirena.org.uk>
References: <20250218195918.255228630@goodmis.org>
	<20250218200022.883095980@goodmis.org>
	<5225b07b-a9b2-4558-9d5f-aa60b19f6317@sirena.org.uk>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 20:06:28 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Tue, Feb 18, 2025 at 02:59:22PM -0500, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > When a function is annotated as "weak" and is overridden, the code is not
> > removed. If it is traced, the fentry/mcount location in the weak function
> > will be referenced by the "__mcount_loc" section. This will then be added
> > to the available_filter_functions list. Since only the address of the
> > functions are listed, to find the name to show, a search of kallsyms is
> > used.  
> 
> This breaks builds with ftrace on architectures without KASLR, one
> affected configuration is bcm2835_defconfig:
> 
> /home/broonie/git/bisect/kernel/trace/ftrace.c: In function 'ftrace_process_locs':
> /home/broonie/git/bisect/kernel/trace/ftrace.c:7057:24: error: implicit declaration of function 'kaslr_offset' [-Werror=implicit-function-declaration]
>  7057 |         kaslr = !mod ? kaslr_offset() : 0;
>       |                        ^~~~~~~~~~~~
> 
> since that happens to enable CONFIG_FUNCTION_TRACER but doesn't have
> KASLR, we don't have stubs for KASLR on architectures that don't have
> it.  It also looks like from a quick glance at least RISC-V will fail to
> link since it only provides kaslr_offset() with RANDOMIZE_BASE enabled.
> This all feels a bit footgunish.

Already reported:

  https://lore.kernel.org/all/20250224180805.GA1536711@ax162/

-- Steve

