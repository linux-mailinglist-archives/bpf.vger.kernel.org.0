Return-Path: <bpf+bounces-47775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A22C89FFFB3
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 20:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51F0B7A1FAE
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 19:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8EB7E0E4;
	Thu,  2 Jan 2025 19:53:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28C01B4148;
	Thu,  2 Jan 2025 19:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735847628; cv=none; b=lpwjpnzGFJZewL0aG157wvhDgAtBFRzMVVQW3c1HF0FRy9qCZ2qSb5F6gNBEoKv7FfdkOUelG2l2CMcvkJO4AaxFKMjXwaL8PT44OvsbHCYS5RogjprL5qs8583sjLTmTX0If5PibGLpz8qRGXqwZY/jlU1VJ4p9+hPtP+uVe74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735847628; c=relaxed/simple;
	bh=gp0gVJ5kZU/Yyc5itsVs8Lcssz+x8bmc52klLozGeGY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TYyhpSyarSYErfX2Rd2a9KX1IEtDPLILdeoV7VYx7Xeq8TDDidVgBJ+a07Grc0aRSv/ZMi/poNJBF5L34SLdN8DovCC+Noe/17pkVkcRLVXvqPdlYYUYazDHGN6WS1jjjivd9I+CFGADaEAVaJMzzEkrRdeuit0D7fsy215e3fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7217C4CED0;
	Thu,  2 Jan 2025 19:53:45 +0000 (UTC)
Date: Thu, 2 Jan 2025 14:55:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf <bpf@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
 Zheng Yejian <zhengyejian1@huawei.com>, Martin Kelly
 <martin.kelly@crowdstrike.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 14/14] scripts/sorttable: ftrace: Do not add weak
 functions to available_filter_functions
Message-ID: <20250102145501.3e821c56@gandalf.local.home>
In-Reply-To: <20250102194814.GA7274@noisy.programming.kicks-ass.net>
References: <20250102185845.928488650@goodmis.org>
	<20250102190105.506164167@goodmis.org>
	<20250102194814.GA7274@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jan 2025 20:48:14 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> *sigh*.. can we please just either add the 'hole' symbols in symtab, or
> fix symtab to have entry size?
> 
> You're just fixing your one problem and leaving everybody else that has
> extra data inside the dead weak things up a creek :/
> 
> Eg. if might make sense to also ignore alternative / static_branch /
> static_call patching for such 'dead' code. Yes, that's not an immediate
> problem atm, but just fixing __mcount_loc seems very short sighted.

Read my reply to the email that I forgot to add to the cover letter (but
mention in the last patch). Fixing kallsyms does not remove the place
holders in the available_filter_functions. This has nothing to do with
kallsyms. I need to remove the fentry/mcount references in the mcount_loc
section.

The kallsyms is a completely different issue.

-- Steve

