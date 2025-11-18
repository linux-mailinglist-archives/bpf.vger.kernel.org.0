Return-Path: <bpf+bounces-74852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B653C6716B
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 04:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF38935D94F
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 03:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A99F328607;
	Tue, 18 Nov 2025 03:06:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82F1749C;
	Tue, 18 Nov 2025 03:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763435183; cv=none; b=UlG01VEjrxMrZaqNB4vDP36X0O38+cKZfa3Q8GXduB5JOF+M4H4gHakGm8zaN/vPovjdxY92suSN8+LAA7j4QoeH8ul1Tr+WF8QOZxE3y5qfAiCnMBu3F6OMPqGeTC3I+cfuKJ5UYypWUjJVrWzI6YzW1/54Jmbq+2SPtSz2utU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763435183; c=relaxed/simple;
	bh=zC1huWH/fM5jeKOAKnLlB/GiaJs8JnRRXh1qVSl+Y2s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eEg0stGyob+4ZEV3XJ31CzHGoxFSYKJtpqr7VG3ONoUdPU4zz0yjAPxP1qXWUOpon7zc27fwOWQ6AZIjWZXPq6cn3e4qwh7IyNvs/oVzgMkQm7x8fxPM7TdqjbzkfYclaCDHHstN27ECDkQpKZNxZL2ud6p/LzBrSuE+qdVCKwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 1D2FF85C87;
	Tue, 18 Nov 2025 03:06:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id AC1992000E;
	Tue, 18 Nov 2025 03:06:16 +0000 (UTC)
Date: Mon, 17 Nov 2025 22:06:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Wander Lairson Costa <wander@redhat.com>, Tomas Glozar
 <tglozar@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, Crystal
 Wood <crwood@redhat.com>, John Kacur <jkacur@redhat.com>, Costa Shulyupin
 <costa.shul@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis
 (RTLA) tools), linux-kernel@vger.kernel.org (open list),
 bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: Re: [rtla 01/13] rtla: Check for memory allocation failures
Message-ID: <20251117220615.079bce82@batman.local.home>
In-Reply-To: <20251118110946.2e154e8c88b3edd31cc3113a@kernel.org>
References: <20251117184409.42831-1-wander@redhat.com>
	<20251117184409.42831-2-wander@redhat.com>
	<20251118110946.2e154e8c88b3edd31cc3113a@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: pfie39ukxujs5p1kodawzaorg7f584m6
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: AC1992000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18dqX27kvBQms8GFtqrVkHdUy8PwIr+4lo=
X-HE-Tag: 1763435176-718230
X-HE-Meta: U2FsdGVkX1+zv7+u5MK9ZyC9ZmB5U2QlOYl+MqXubg6FQEzoKZTAhoCxWR+038GztktLFUI2LvfHqpuqykRzEFNyYIK8hdZYeOq5ttBWgfDynAsd6MV8Ydu1zPEtij7chOOTPLOM4iREsqLMHx3fqMxzWKlkHXfi8Z1T3Hhs8Jyy7aFKl/VBgxXCAHdXV8fvWNDbA7cTsm3PVi/j/LytG1e1dn1Kbw1QyuVgv/xRbMCR46JeDsmKMAcXNuQArZsmEwX/S5zsA+aYYDXGg0GF7/lIXth/ldL427NchSzs+WBFZdqjSqzrgRGwKhsJuALSZdol0jOMZgx4I9yntFcr4SUA6vaXfQKfxQn2pf+WjwT3CC3eqm8ITg==

On Tue, 18 Nov 2025 11:09:46 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Mon, 17 Nov 2025 15:41:08 -0300
> Wander Lairson Costa <wander@redhat.com> wrote:
> 
> > The actions_init() and actions_new() functions did not check the
> > return value of calloc() and realloc() respectively. In a low
> > memory situation, this could lead to a NULL pointer dereference.
> > 
> > Add checks for the return value of memory allocation functions
> > and return an error in case of failure. Update the callers to
> > handle the error properly.
> > 
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > ---
> >  tools/tracing/rtla/src/actions.c       | 26 +++++++++++++++++++++++---
> >  tools/tracing/rtla/src/actions.h       |  2 +-
> >  tools/tracing/rtla/src/timerlat_hist.c |  7 +++++--
> >  tools/tracing/rtla/src/timerlat_top.c  |  7 +++++--
> >  4 files changed, 34 insertions(+), 8 deletions(-)
> > 
> > diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
> > index 8945aee58d511..01648a1425c10 100644
> > --- a/tools/tracing/rtla/src/actions.c
> > +++ b/tools/tracing/rtla/src/actions.c
> > @@ -11,11 +11,13 @@
> >  /*
> >   * actions_init - initialize struct actions
> >   */
> > -void
> > +int
> >  actions_init(struct actions *self)
> >  {
> >  	self->size = action_default_size;
> >  	self->list = calloc(self->size, sizeof(struct action));
> > +	if (!self->list)
> > +		return -1;  
> 
> Can you return -ENOMEM?

Does it need to? This is user space not the kernel. Errno is already
set by calloc() failing.

-- Steve

