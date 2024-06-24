Return-Path: <bpf+bounces-32875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA0B9143A9
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 09:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78FC28170F
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 07:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF048446A2;
	Mon, 24 Jun 2024 07:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2+Gi9hqO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KaJEtS6o"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC201134B0;
	Mon, 24 Jun 2024 07:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719213976; cv=none; b=LyV4cgpQ+h1znDF8QKdUEwmIP5yE42wtRD16ojf+f3z6uAqd25kqtIhpbNC/mLr/rQdmJhld0j/ICqRZphlCCJrus9SjbZ9cNcQz4EUXYeFWiCKgzhY06AiS+xa7CmKqTGSLKllwJ0gDr76hNqwYVrebZohvH0PiI3lVE1nSd8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719213976; c=relaxed/simple;
	bh=Ipn6VWt1KydQ5UsSzFqa4LS7OAMRnPsDgUhLZn17a+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLs6jJJxLV0NBL8nfMfCHkNyE6X+SFmW9mY+xjpQj9ekr7ECL4J2iG1ceL73zeUiO9YL8H3zesHs5K6mZqXM/BwV+UngIE0fFNlDKcAvRcx/lo6eT3vutgLGLcXtuNBt4WoY3N1lk4vNSiisAKBieoGe8NfEQMlQB6pwOrDdVIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2+Gi9hqO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KaJEtS6o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Jun 2024 09:26:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719213973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+QgX1drsMWLHSVcJof2kPfDekMzcE4REsC6WYncxlXg=;
	b=2+Gi9hqO3y/UjAh6pSiV7nbdcvvOVulTTw3e/Lnu1qpPH2XEFEg0WVRbbxsY4NbOm3Yvn2
	+imW1GrhKCd/lIq7H4CJWkagAZMoy/To8xuyOeQXY5Zsh3fmW0cCL2+cwe1cYFD5S8qVK3
	9l6AmyUVcYpz8zn1tG2r86EDvLoIVksXEfIRcR9E9rjdElrmGVRYbGFTTHOuUWoaahoOUy
	PF1twEz1hIsxOzkt86+jCtO4KLEU7gBWn+L/dTqcfopkRk7C3r5Jw/pk/CDviNiQ1DDb5W
	C0vlMZ6plrRWRaY5nxeHuhfO11SP6tkfYScB0DdsMnKLJ1sUVW4Tf1i+KKy3uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719213973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+QgX1drsMWLHSVcJof2kPfDekMzcE4REsC6WYncxlXg=;
	b=KaJEtS6oLPJsBSV1OevUkkioXrVNd8UlrSpmH8JTZbpOkK6PBtj4ZOOSjuJCscTbbZlv0S
	ZvEFql4nguPEO7CQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v9 net-next 14/15] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Message-ID: <20240624072611.wnKkoUW9@linutronix.de>
References: <20240620132727.660738-1-bigeasy@linutronix.de>
 <20240620132727.660738-15-bigeasy@linutronix.de>
 <20240621190840.4da4b775@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240621190840.4da4b775@kernel.org>

On 2024-06-21 19:08:40 [-0700], Jakub Kicinski wrote:
> On Thu, 20 Jun 2024 15:22:04 +0200 Sebastian Andrzej Siewior wrote:
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 99076dbe27d83..f314bdd7e6108 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -2355,6 +2355,7 @@ __latent_entropy struct task_struct *copy_process(
> >  	RCU_INIT_POINTER(p->bpf_storage, NULL);
> >  	p->bpf_ctx = NULL;
> >  #endif
> > +	p->bpf_net_context =  NULL;
> 
> nit: double space after =
> 
> Out of curiosity, do we actually have to clear this pointer?

I don't think so. We never clone a thread within a redirect section so
this can probably go away.

Sebastian

