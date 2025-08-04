Return-Path: <bpf+bounces-65006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14056B1A477
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 16:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E613B64B9
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 14:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1049526B77D;
	Mon,  4 Aug 2025 14:20:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DDB271447;
	Mon,  4 Aug 2025 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754317199; cv=none; b=QDZdNMyfM8Aue/s7jxMbgIO0g8WgF7q6xqVC4Z0FXsaC3kCPMMFKhK9WV8Cb5jobwOJbXPw9wfxQ0q/9ux8BhsyPso0OB/np2kkReRV6oAsv5gKQZOZRI/IUGXqPSLntwL8fNGxHam0KRp8EHSu+/wkeV07Zc9h3AI71GFct2n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754317199; c=relaxed/simple;
	bh=IkL0aQ0TXz/5QDS9mG1gICaMCKnP3GiD44DhGW8hPWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pNjUhhU5Tdvmtm6M0Bto0pMHMX3FoVIB5OxjsoldyfF6gXWwdJX3TcldMCCDV1MkEkFyREQF83zo6dckW3wcAD0ahe/0orGDIhlhRs0AJwnTCcLuVIs4y9myO0a8olajXrwAeC+HbKGMMMG8b47qxUxz220F0pQrgAFvMb1VMW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id AF66DBA664;
	Mon,  4 Aug 2025 14:19:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id F1F5120024;
	Mon,  4 Aug 2025 14:19:50 +0000 (UTC)
Date: Mon, 4 Aug 2025 10:20:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH] btf: Simplify BTF logic with use of __free(btf_put)
Message-ID: <20250804102018.56efd19a@gandalf.local.home>
In-Reply-To: <20250804222645.5d8dd9895812b31e7a6963e9@kernel.org>
References: <20250801071622.63dc9b78@gandalf.local.home>
	<20250804222645.5d8dd9895812b31e7a6963e9@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F1F5120024
X-Stat-Signature: 5y16tm8gqoobir9f73pbuqsxr4xx831j
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19EASpjnGh3TQzX5NV61YEmRHdu/P3eZfM=
X-HE-Tag: 1754317190-634624
X-HE-Meta: U2FsdGVkX18sYlVraLvBBBKXS6SHzKkzNUg6PKk8L66kYIayefzkkmMe0ychg7ysbwJ+hH9LZB8gcmgOK7n4ZaB9NJiGe6nqrGsiftqSvuaL3tRufJHhby9lVmgLby4RrwMPz0PztUDgG3pncX0X32bSiTsCzg7w66ItboZV0Uoqe9ZHqvGpN904mlQb9JaH4jJH6Bt5iEAi4BKsamPMouY9M10bmo+Gbd2Z/0thl+GdGENLvyVLjDk3t2GTdipI3nctRPhW3XgQsUQ1fWjDjVSNA2pfw6USVLn7oLXaKgxRHofFebb9fO/OMZAtsIlTImAm0QB+kyVBtA00ytlt6PoQkVb21bAsy6ua2kmSP4NG9JFwC/y3rmtTowYkUECX9HaFvMn13N7wwHHkujugQw==

On Mon, 4 Aug 2025 22:26:45 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Fri, 1 Aug 2025 07:16:22 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > Several functions need to call btf_put() on the btf pointer before it
> > returns leading to using "goto" branches to jump to the end to call
> > btf_put(btf). This can be simplified by introducing DEFINE_FREE() to allow
> > functions to define the btf descriptor with:
> > 
> >    struct btf *btf __free(btf_put) = NULL;
> > 
> > Then the btf descriptor will always have btf_put() called on it if it
> > isn't NULL or ERR before exiting the function.
> > 
> > Where needed, no_free_ptr(btf) is used to assign the btf descriptor to a
> > pointer that will be used outside the function.
> >   
> 
> Yeah, this looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks but Alexei already declined it.

I'm gonna respin where it is only used in the tracing code.

Thanks!

-- Steve

