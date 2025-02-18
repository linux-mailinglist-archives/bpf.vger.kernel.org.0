Return-Path: <bpf+bounces-51863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D29CDA3A82E
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 20:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C550188B2A7
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 19:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831D91E520A;
	Tue, 18 Feb 2025 19:56:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BC31EB5CA;
	Tue, 18 Feb 2025 19:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739908578; cv=none; b=RmraS0ogjtdfBTTtt4iEsGkRI8HqBCpgG+NWZldNNbZfnO7Dypcmjl/y2JLjOC7GL4JjCRf+lHtVJpYOu3LmHjRY90SNyKCxfm3idoNRQ5Qmr0JypbKqP0CWgYGmRX4JgL177J7ok8ePpJhcBlT5Cxu5ZAmxmP94IdQ/FPxcfTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739908578; c=relaxed/simple;
	bh=b3eF94SX5VGUxW7FhU4wQjDEwsxC1ccA9mSA/cX4MMM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzD7+QJJGFAcHuUDMpAIgT9eEiE2gcytlLfixBE2qwPeIfbj3Rh0Wl5ysbXYwMu3oHf57i9H+QF+btGpPwyy6jaNnqB+MQTm3eazvs8ksJx0q/n8Kt9Zssf7c410dwXs3pPzqCw13owdGhai6t1+P9cjVv0tiEnupHMN9slLUMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB33BC4CEE2;
	Tue, 18 Feb 2025 19:56:14 +0000 (UTC)
Date: Tue, 18 Feb 2025 14:56:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Heiko Carstens <hca@linux.ibm.com>
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
 <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>
Subject: Re: [PATCH v4 0/6] scripts/sorttable: ftrace: Remove place holders
 for weak functions in available_filter_functions
Message-ID: <20250218145636.37a1df08@gandalf.local.home>
In-Reply-To: <20250218145836.7740B3b-hca@linux.ibm.com>
References: <20250217153401.022858448@goodmis.org>
	<20250218145836.7740B3b-hca@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 15:58:36 +0100
Heiko Carstens <hca@linux.ibm.com> wrote:

> Hi Steven,
> 
> > This series removes the place holder __ftrace_invalid_address___ from
> > the available_filter_functions file.
> > 
> > The rewriting of the sorttable.c code to make it more manageable
> > has already been merged:
> > 
> >   https://git.kernel.org/torvalds/c/c0e75905caf368e19aab585d20151500e750de89
> > 
> > Now this is only for getting rid of the ftrace invalid function place holders.  
> 
> Since you asked me to test this on s390: seems to work with
> HAVE_BUILDTIME_MCOUNT_SORT enabled; the ftrace selftests still
> work as before.

My tests found a bug (forgot to initialize a variable) and I will be
sending a v5 soon.

You may also want to enable: CONFIG_FTRACE_SORT_STARTUP_TEST

That will make ftrace test to see if the mcount table is indeed sorted at
boot up.

-- Steve

