Return-Path: <bpf+bounces-33976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D5B928F7C
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 01:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2C71F23472
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 23:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB011459FF;
	Fri,  5 Jul 2024 23:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJaGgKwE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ED0145B12;
	Fri,  5 Jul 2024 23:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720221055; cv=none; b=omvVrhBtsAkWgD3avtKBjmzPYQV2h1WS+WWNgFw9sOK7Rgla6mkAcI51Gzx7NT/W5Wa/rFcj3aO1rv7as5z6iJMtDzGeZKY0FGWHMCIi0EB49KPN+HahpAkys/GYZoqZC9Q7Z+8O1PbF7UOD1d5AUTp2VnGXt4sH6qaJQtGC0MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720221055; c=relaxed/simple;
	bh=xS7VcBK27sfR8bV43BCjPhUhK+xwxmamXbp7tcVxbE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4TQS5yO01Z3ahaA5fbEQ7xdukcDWgYmIGePu94GJM4FDM6THeHy59tlN1Z6K7TbTTVDU6eX2mi27J2koN11PcNsmaRG6Wdp7an2rKnDodQibDbDBuXCvFomGUlqZZY1T43uoC4IPKcWs9HgYDdGfiQx+OP4ZBuNQeWBNVNjPHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJaGgKwE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBEEC116B1;
	Fri,  5 Jul 2024 23:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720221054;
	bh=xS7VcBK27sfR8bV43BCjPhUhK+xwxmamXbp7tcVxbE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dJaGgKwEv7m9AUO5+9/KlAbm+lSmetXgHFTo3EP3/UOrcNyr6HtuZZtqZ0KcQOXDg
	 Si49IU7A0exScQD2PHzAuQ5Enkok09M2c4pSafl5l9Q2vondxxxLfuw6aImzYHgZ+r
	 6CINML8fU7DzMYPip4qb6QZmFnIlUetu+1QSS5LuhmSlCoGuCPQ2eJNrIR26t7njwU
	 xO2V/b/GkP/OJLwtvDRtwJPXjyMm8nVfb8Wn/5Cs3VQZZ16NnPtwuPvU8pB5ngSKA4
	 1tGSv/snfiH/GChZ4GzQRFbgtpEInUPh5PXB+/fGzuTpJeKCLtzjg7rZBVHPRWrm/1
	 oPrgSW+vWW0bQ==
Date: Fri, 5 Jul 2024 16:10:54 -0700
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 1/9] uprobe: Add support for session consumer
Message-ID: <202407051604.377EA59@keescook>
References: <20240701164115.723677-1-jolsa@kernel.org>
 <20240701164115.723677-2-jolsa@kernel.org>
 <CAEf4BzZaTNTDauJYaES-q40UpvcjNyDSfSnuU+DkSuAPSuZ8Qw@mail.gmail.com>
 <20240703081042.GM11386@noisy.programming.kicks-ass.net>
 <CAEf4BzY9zi7pKmSmrCAqJ2GowZmCZ0EnZfA5f8YvxHRk2Pj8Zw@mail.gmail.com>
 <202407031330.F9016C60B@keescook>
 <20240705071036.GW11386@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705071036.GW11386@noisy.programming.kicks-ass.net>

On Fri, Jul 05, 2024 at 09:10:36AM +0200, Peter Zijlstra wrote:
> On Wed, Jul 03, 2024 at 01:36:19PM -0700, Kees Cook wrote:
> 
> > Yes, please use struct_size_t(). This is exactly what it was designed for.
> 
> Kees, please, just let up, not going to happen. I'm getting really fed
> up having to endlessly repeat what a piece of shite struct_size() is.

I mean, okay, but the wrapper in the patch is basically the same thing.
*shrug*

> Put your time and effort into doing a proper language extension so we
> can go and delete all that __builtin_*_overflow() based garbage.

We are! That's in the future. Today, we have a saturating wrapper that
provides type checking for the calculation's operands, and is in common
use through-out the kernel. These are all things that the open-coded
does not provide, so I continue to see it as an improvement over what
else is available right now.

I got asked for my opinion about whether to use struct_size() or not. In
my opinion, this is a good place for it. I know you don't agree with me,
but that wasn't the question. :)

-Kees

-- 
Kees Cook

