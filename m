Return-Path: <bpf+bounces-74856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E786BC67536
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 06:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id A73262A197
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 05:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C142D060D;
	Tue, 18 Nov 2025 05:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5UF7fRv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B582C08A1;
	Tue, 18 Nov 2025 05:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763442836; cv=none; b=meezjYKsK4/VJNwa19dt+pxv3ceX0YjzafcEpwVnQXwX2THjyOoLwsx3uO2l4QDQPy8xlT1lUvO/vF1gIkn0GopTxXQjRLiy6U9Nxk7F4UzqPipt7JRXZ+gV9Ct/dewYvfjuR6CDwQb0EoRTSTJgm9+vCYGfTW8hekRjxaa9UIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763442836; c=relaxed/simple;
	bh=2gPD+JZO5mYYvMtl+rFT0Oc//WhuEptkcJHXgMy1Wi0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hYchwAIcwmPmdH9T1uuVy5CCrAxecOoA5FF02vyq8sFdaPoOtVHOUbUBP1m4nlwXdD1IhFUhNeMsIv90Z1p06f44Hlbxqb0se9W653EzaZQ5fJwu/wUgS9inOrNY9HLuQKHLWZPXoDZEClJPp2ah67J8Z2waR6xNfju5j1rP2Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5UF7fRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B55C4CEF1;
	Tue, 18 Nov 2025 05:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763442835;
	bh=2gPD+JZO5mYYvMtl+rFT0Oc//WhuEptkcJHXgMy1Wi0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M5UF7fRvFse5rwpW39QDN5PWRb2yW9u8RSB6DfCJKU5n8tYO1RkK+lh5tYoL7D/lI
	 wbidKhZyUZZk93KgzW6wyQxuWiuCWl5BgFNMmC5P78UORVyuiuWA/IKNv5z9W7KwII
	 ujf9NasgH8byb+pXZ/YS1c05W4Lg+TTPvUeIwqbBkR3Wyg9+t8j2WyNGIHcEstPh0c
	 JqHlfXg0VqFvVN5SL5MKHEXqsikH7E68HHTND4jFzUH6+pVX8c150G1lcPRy3sHBl0
	 /UhYqvyi5leuEX7LIhv5YLAze3tJOGYtv//89JtataSjSzHzIdB3lobjew2+8bopFn
	 0JY65+HT4ER1w==
Date: Tue, 18 Nov 2025 14:13:50 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Wander Lairson Costa <wander@redhat.com>, Tomas Glozar
 <tglozar@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, Crystal
 Wood <crwood@redhat.com>, John Kacur <jkacur@redhat.com>, Costa Shulyupin
 <costa.shul@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis
 (RTLA) tools), linux-kernel@vger.kernel.org (open list),
 bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: Re: [rtla 01/13] rtla: Check for memory allocation failures
Message-Id: <20251118141350.50662edbdf0a788b70e40e53@kernel.org>
In-Reply-To: <20251117220615.079bce82@batman.local.home>
References: <20251117184409.42831-1-wander@redhat.com>
	<20251117184409.42831-2-wander@redhat.com>
	<20251118110946.2e154e8c88b3edd31cc3113a@kernel.org>
	<20251117220615.079bce82@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Nov 2025 22:06:15 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 18 Nov 2025 11:09:46 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Mon, 17 Nov 2025 15:41:08 -0300
> > Wander Lairson Costa <wander@redhat.com> wrote:
> > 
> > > The actions_init() and actions_new() functions did not check the
> > > return value of calloc() and realloc() respectively. In a low
> > > memory situation, this could lead to a NULL pointer dereference.
> > > 
> > > Add checks for the return value of memory allocation functions
> > > and return an error in case of failure. Update the callers to
> > > handle the error properly.
> > > 
> > > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > > ---
> > >  tools/tracing/rtla/src/actions.c       | 26 +++++++++++++++++++++++---
> > >  tools/tracing/rtla/src/actions.h       |  2 +-
> > >  tools/tracing/rtla/src/timerlat_hist.c |  7 +++++--
> > >  tools/tracing/rtla/src/timerlat_top.c  |  7 +++++--
> > >  4 files changed, 34 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
> > > index 8945aee58d511..01648a1425c10 100644
> > > --- a/tools/tracing/rtla/src/actions.c
> > > +++ b/tools/tracing/rtla/src/actions.c
> > > @@ -11,11 +11,13 @@
> > >  /*
> > >   * actions_init - initialize struct actions
> > >   */
> > > -void
> > > +int
> > >  actions_init(struct actions *self)
> > >  {
> > >  	self->size = action_default_size;
> > >  	self->list = calloc(self->size, sizeof(struct action));
> > > +	if (!self->list)
> > > +		return -1;  
> > 
> > Can you return -ENOMEM?
> 
> Does it need to? This is user space not the kernel. Errno is already
> set by calloc() failing.

Ah, indeed! I agree to just return -1.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

