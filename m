Return-Path: <bpf+bounces-21992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F05EE854EBF
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 17:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC02128D26A
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 16:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7863D60DEE;
	Wed, 14 Feb 2024 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KXwWjoRY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t6DTWNcr"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6273360DD7;
	Wed, 14 Feb 2024 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928574; cv=none; b=cGhIqLTyryEYsWpeWgds5gjN0KrjBrR8+39IBTTxEnQiVXjAvATDdPZYnC18Wtp/l9xAjlffVb5vXKSFJxD0GsMx/SwSAbqPQRMPSduqKAYIRO5xOcgJjSd89oM6Trh8pJLcPzBlt55LPNB+z/RrrVbGgcOI8wXXA/RTXj/y1uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928574; c=relaxed/simple;
	bh=WsY3Ur/foPCNEZ7U/F93RS64sAsZc3fOM8esZ2Qa3oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0VgXg7oSZGO/MoILH26MGmxcXCqHh7ukg7Daff85Sz7qpC8PcBvv2Xm7DiOkM7AXkSk3WK4B06SXMB414XW2k4uVHuCq0gU81KRjViraTqpohsLBVgQzdg6xbmX7PQDMIVOpwyAu1BvB5ahBI6J/WNJAwhg3AOqPQ5+dfc/fzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KXwWjoRY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t6DTWNcr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Feb 2024 17:36:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707928569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WsY3Ur/foPCNEZ7U/F93RS64sAsZc3fOM8esZ2Qa3oI=;
	b=KXwWjoRYUm70NG3zZcjzfqv18cbB9q5IOg8ZJR2DOIRWf+8NBzkPJ8qsrW7Gqly2D0JvEO
	h+/Az9CAE0wKKQJIy/x8qu1b7Zj/QDZEamXS+aMDWBW5FQbQxiP+3UpCt/2Y6CZMUqJ+5T
	VvLdB5KhX+lfbKDRxYLcngGsHlkSigCipNeLk9yfrXiYA9NaMEL0IwfdS3FIm8wBpPYpfi
	p5kQ4KhdyJcIGf+R3JVTARc74IFGB6gxonRZgb+GvBUl3Pxo2ydswPaRWj74AefX5ZULDE
	0vKaEH9z/oBECeowCUG5j9N6xZSXuy96EW1AOOL+rpKA215Vmr5PwSQjM594Zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707928569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WsY3Ur/foPCNEZ7U/F93RS64sAsZc3fOM8esZ2Qa3oI=;
	b=t6DTWNcrUNeTvFXzsIyiGBxpvtWSfFfyw/mw0JFLrl9ruGcD9wpYBGhlThOD5oUzlsHK3U
	ZucC3vfOgaY1JgAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>, Hao Luo <haoluo@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH RFC net-next 1/2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Message-ID: <20240214163607.RjjT5bO_@linutronix.de>
References: <20240213145923.2552753-1-bigeasy@linutronix.de>
 <20240213145923.2552753-2-bigeasy@linutronix.de>
 <66d9ee60-fbe3-4444-b98d-887845d4c187@kernel.org>
 <20240214121921.VJJ2bCBE@linutronix.de>
 <87y1bndvsx.fsf@toke.dk>
 <20240214142827.3vV2WhIA@linutronix.de>
 <87le7ndo4z.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87le7ndo4z.fsf@toke.dk>

On 2024-02-14 17:08:44 [+0100], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > During testing I forgot a spot in egress and the test module. You could
> > argue that the warning is enough since it should pop up in testing and
> > not production because the code is always missed and not by chance (go
> > boom, send a report). I *think* I covered all spots, at least the test
> > suite didn't point anything out to me.
>=20
> Well, I would prefer if we could make sure we covered everything and not
> have this odd failure mode where redirect just mysteriously stops
> working. At the very least, if we keep the check we should have a
> WARN_ON in there to make it really obvious that something needs to be
> fixed.

Agree.

> This brings me to another thing I was going to point out separately, but
> may as well mention it here: It would be good if we could keep the
> difference between the RT and !RT versions as small as possible to avoid
> having subtle bugs that only appear in one configuration.

Yes. I do so, too.

> I agree with Jesper that the concept of a stack-allocated "run context"
> for the XDP program makes sense in general (and I have some vague ideas
> about other things that may be useful to stick in there). So I'm
> wondering if it makes sense to do that even in the !RT case? We can't
> stick the pointer to it into 'current' when running in softirq, but we
> could change the per-cpu variable to just be a pointer that gets
> populated by xdp_storage_set()?

I *think* that it could be added to current. The assignment currently
allows nesting so that is not a problem. Only the outer most set/clear
would do something. If you run in softirq, you would hijack a random
task_struct. If the pointer is already assigned then the list and so one
must be empty because access is only allowed in BH-disabled sections.

However, using per-CPU for the pointer (instead of task_struct) would
have the advantage that it is always CPU/node local memory while the
random task_struct could have been allocated on a different NUMA node.

> I'm not really sure if this would be performance neutral (it's just
> moving around a few bits of memory, but we do gain an extra pointer
> deref), but it should be simple enough to benchmark.

My guess is that we remain with one per-CPU dereference and an
additional "add offset". That is why I kept the !RT bits as they are
before getting yelled at.

I could prepare something and run a specific test if you have one.

> -Toke

Sebastian

