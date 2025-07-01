Return-Path: <bpf+bounces-62020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 323DFAF06AC
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 00:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75EEC1C06F7A
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 22:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887C7289349;
	Tue,  1 Jul 2025 22:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQ24SAVX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048BE265CC8;
	Tue,  1 Jul 2025 22:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751410164; cv=none; b=acMI4S1OnOfclM5AI0cM6JVReEwuqVRIHqzbBCKY2neErVbbd1zuSyDF8S7wiyyoMXnmp8tAX5ocLQ1uoOYtFLz3Mm7zvCyJ6wKejSLXLib62Z6eOW6E2pJoS7w1ESPP94o6469XYGE0IrBHKh84W7c6RMfp0fxbwh6QM5VLz2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751410164; c=relaxed/simple;
	bh=yyNQz6Ao1JLzZXSuzYM28IyyWEtJcCrYhLFLzGGHcF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAX9Slg4ShmLyDs225mQVH0g9pF7EXo9+sgTUpEvY0FOVqGN8l4OtBxyEJbyeoRx/WJdUO8Nvu59u/RK+CO5a/fuVdqYfpPheptDKu0ld3XeS9eO7nfg/d8n8ncIiIe0udW1q/TeyhItq0eVhwfI412O2BGs4feT4aAekkHxudM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQ24SAVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721A2C4CEEB;
	Tue,  1 Jul 2025 22:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751410163;
	bh=yyNQz6Ao1JLzZXSuzYM28IyyWEtJcCrYhLFLzGGHcF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nQ24SAVXTTD+kWT+I6Bga/CXbcm8CUvXq9UEhRI1Czx1KAfXSU24E2AiZubg9i75K
	 OmDZlrx5LTNbHEWb6Vk+yPtUjDp6wLpO1FiMq+Dx+s6Du6mdjGQ01N0zps50Eoe2Aa
	 zDciXesua9KZ+cgnELFNmlaMPkVar8yKJK40ucWahFsBTGIcQcrDN3Qg+UuONaMCk6
	 kaXbgyEiRkXeL1EvPMTqNjQwUzcasnaw1LCIjLo4+HRw0BqbUhO+xzYT2V81xDkh2K
	 C8mMYG8oBSSvTrDQLQ5egF847IDuOU/ULq9W9p3WoKbCOOCbkJDfQDTIwHyntMt9VR
	 vIgf4/mWxSqWA==
Date: Tue, 1 Jul 2025 15:49:23 -0700
From: Kees Cook <kees@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v12 00/14] unwind_user: x86: Deferred unwinding
 infrastructure
Message-ID: <202507011547.D291476BE1@keescook>
References: <20250701005321.942306427@goodmis.org>
 <CAHk-=wijwK_idn0TFvu2NL0vUaQF93xK01_Rru78EMqUHj=b1w@mail.gmail.com>
 <20250630224539.3ccf38b0@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630224539.3ccf38b0@gandalf.local.home>

On Mon, Jun 30, 2025 at 10:45:39PM -0400, Steven Rostedt wrote:
> On Mon, 30 Jun 2025 19:06:12 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Mon, 30 Jun 2025 at 17:54, Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > This is the first patch series of a set that will make it possible to be able
> > > to use SFrames[1] in the Linux kernel. A quick recap of the motivation for
> > > doing this.  
> > 
> > You have a '[1]' to indicate there's a link to what SFrames are.
> [...]
>   [1] https://sourceware.org/binutils/wiki/sframe

Okay, I've read the cover letter and this wiki page, but I am dense: why
does the _kernel_ want to do this? Shouldn't it only be userspace that
cares about userspace unwinding? I don't use perf, ftrace, and ebpf
enough to make this obvious to me, I guess. ;)

-- 
Kees Cook

