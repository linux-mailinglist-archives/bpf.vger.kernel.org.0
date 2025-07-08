Return-Path: <bpf+bounces-62701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C53AFD6BE
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 20:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A606D1C20DF9
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 18:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D772E5B10;
	Tue,  8 Jul 2025 18:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXrxV8oc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D272DEA94;
	Tue,  8 Jul 2025 18:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752001028; cv=none; b=kkiPe+hkQVmfwj0xt6/Vfbh5vHOeH1p9k+c7D4zprsHFctWtpTA8TCGGGWcUocxuvV2iyNvbXk6+MuXXkAjSjnIgeEhDQwASn8vPzGTbLbxdRbQEw7bArRdYoXSOUyxW0WM9fvuYPUEtS6QRTfY6+le3CoEoi5y+piYaA6K2EhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752001028; c=relaxed/simple;
	bh=PLLsfG8ZvEpm/ilZVqKkOaZOqwtsVW8A2/GjCMKxRy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DD8r+HDtqxujh9YYcjyFcC4SpCkeOdzlrZn3Lt08t9gAg1xummz1PciDdbWwrUKnYRq+mICOrH3a8yQd1TUau0vlR389T9eEqhg/PeW/Cres/1/UKCHjLSoatAkmD50IFmPm/hl0+SYLC3a0Qrm7wNQ4Ue4e80ZGrpc3DkHZUmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXrxV8oc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1A1C4CEF5;
	Tue,  8 Jul 2025 18:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752001027;
	bh=PLLsfG8ZvEpm/ilZVqKkOaZOqwtsVW8A2/GjCMKxRy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kXrxV8oc18QDaJ9IkHL27dNGToyQUV8kv6e+lLflf+9G16ixlmifg+4GCLygqGLMa
	 W704AgDmZldR9Cw0j4E02fecxYyoRZDl6DhcLf+MeXvL0ifxEbNYpSWzlcxRNkxwAa
	 jTWZYsRc6DSin1DAquBkYWORMSJ3saX6qsY1E/5tthbIHJiktTSqmaoPdvwp8sUmRV
	 NXrRt7HeRfdaeyVdFkP1pnMSUD9+RDElN+OGTkFQRqZol4xErknnfNvIoX3t7NQy1v
	 FOUxC4T+kMdMDn8k94o4Y1g0THjSmQ2YoqurXqQuQ2RxmRVoz3OLL053lnqRCw+k0a
	 uKA9LEWEzltzA==
Date: Tue, 8 Jul 2025 11:57:04 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, 
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>
Subject: Re: [PATCH v8 10/12] unwind_user/sframe: Enable debugging in uaccess
 regions
Message-ID: <3mf3ytjmoanrfjcyz7qjljwrbxolqrkocqy4asmunqeiqxpqbj@mqkeuyan67q5>
References: <20250708021115.894007410@kernel.org>
 <20250708021200.058879671@kernel.org>
 <CAHk-=widGT2M=kJJr6TwWsMjfYSghL9k3LgxJvRard0wtiP62A@mail.gmail.com>
 <20250708092351.4548c613@gandalf.local.home>
 <orpxec72lzxzkwhcu3gateqbcw6cdlojxvxmvopa2jxr67d4az@rvgfflvrbzk5>
 <20250708104130.25b76df9@gandalf.local.home>
 <CAHk-=wgXcc99EXKfK++FEQzMQc8S16WOwvn=1DcP_ns1jCCYeA@mail.gmail.com>
 <20250708123120.7862c458@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250708123120.7862c458@gandalf.local.home>

On Tue, Jul 08, 2025 at 12:31:20PM -0400, Steven Rostedt wrote:
> On Tue, 8 Jul 2025 08:53:56 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Tue, 8 Jul 2025 at 07:41, Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > Would something like this work? If someone enables the config to enable the
> > > validation, I don't think we need dynamic printk to do it (as that requires
> > > passing in the format directly and not via a pointer).  
> > 
> > I really think you should just not use 'user_access_begin()" AT ALL if
> > you need to play these kinds of games.
> > 
> 
> Looking at the code a bit deeper, I don't think we need to play these games
> and still keep the user_read_access_begin().
> 
> The places that are more performance critical (where it reads the sframe
> during normal stack walking during profiling) has no debug output, and
> there's nothing there that needs to take it out of the user_read_access
> area.
> 
> It's the validator that adds these hacks. I don't think it needs to. It can
> just wrap the calls to the code that requires user_read_access and then
> check the return value. The validator is just a debugging feature and
> performance should not be an issue.
> 
> But I do think performance is something to care about during normal
> operations where the one big user_read_access_begin() can help.
> 
> What about something like this? It adds "safe" versions of the user space
> access functions and uses them only in the slow (we don't care about
> performance) validator:

Looks good to me, thanks!

-- 
Josh

