Return-Path: <bpf+bounces-32874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C2291439E
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 09:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A501F21722
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 07:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11D73FE46;
	Mon, 24 Jun 2024 07:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jwcNCrCM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XiAPAn0Q"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64583BBE3;
	Mon, 24 Jun 2024 07:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719213889; cv=none; b=XsAQg3jGmuBHJ2PdRYjafo/0w5hJ+mqakQdeHOF7hIN/BXrG8qUJoAg+RqCvJB6Q4GbWgcQXxHravIN8TBv3h2KtA6sAcZjlAAXByHlTjtYYFrLjq0Qd8iJ2aH1RQ47kWkxriO0FxUMbXcCBKChvn1fcr5bAJLHqcajKrpXmhgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719213889; c=relaxed/simple;
	bh=Opu4lhVR8lJ6mtD6FuRzVfiSnZWK7g11uUjUT6HekyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XK2JYyJozqgsYPXV8ORIeGgOav/vLNCdNcMSXLrNyokwNEaW/62dbZhpbB5yppeJamnkvR46hMhSBrEXDjLHmdo/IljZmCuYGRcIEDWiMn/CNByTWszaCX2wsbzkoZkxtiRl+KS/ZmqgRxRALoIlpYyhIjqm2x0KRBw3JVgH/v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jwcNCrCM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XiAPAn0Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Jun 2024 09:24:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719213882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WjctQnB/c3bUB49eFGpZb8HZyFWycDbanOcyvrh497A=;
	b=jwcNCrCMezHi5FJ/vt8UmbTzvviEnoyLNSkrp1zcNXyZOPdciqmnGsZsLy3IcV0ilBMYRL
	m2l6zNB94nCfznotvHFjsG36eNxYHFR9ZPLz1dcEvQYIU5n4Q5Lh29usZIApVRaH/r8akC
	irRZ++D2htUkYGrSZxPafdFD3jtTw9wZTmn8bLrqV5rW2EeZ/rlCQaDynJXcO+XS0Kmgct
	1xH5GVEo5Ur9g7wAaJax6oRUd7LJ045s9Z4PQSGm37Wgsd67ASeAS48ZGD4zsgRFvNA+BM
	TWegRDLX3eY+Qd0FkqbFK308ukcIJWfrso93OjPZQul4/RGNUHQsUjDx7oqwAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719213882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WjctQnB/c3bUB49eFGpZb8HZyFWycDbanOcyvrh497A=;
	b=XiAPAn0QHEUrCfobJBpkD+qSkaOlhBnTA5At6PGxp+mfY7i4/4EiwYQA3TC18+m0TJY6gn
	nXVZGWnJUW8iE7Cg==
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
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v9 net-next 15/15] net: Move per-CPU flush-lists to
 bpf_net_context on PREEMPT_RT.
Message-ID: <20240624072440.bs6__kQw@linutronix.de>
References: <20240620132727.660738-1-bigeasy@linutronix.de>
 <20240620132727.660738-16-bigeasy@linutronix.de>
 <20240621190558.409d778c@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240621190558.409d778c@kernel.org>

On 2024-06-21 19:05:58 [-0700], Jakub Kicinski wrote:
> On Thu, 20 Jun 2024 15:22:05 +0200 Sebastian Andrzej Siewior wrote:
> >  void __cpu_map_flush(void)
> >  {
> > -	struct list_head *flush_list = this_cpu_ptr(&cpu_map_flush_list);
> > +	struct list_head *flush_list = bpf_net_ctx_get_cpu_map_flush_list();
> >  	struct xdp_bulk_queue *bq, *tmp;
> >  
> >  	list_for_each_entry_safe(bq, tmp, flush_list, flush_node) {
> 
> Most of the time we'll init the flush list just to walk its (empty)
> self. It feels really tempting to check the init flag inside
> xdp_do_flush() already. Since the various sub-flush handles may not get
> inlined - we could save ourselves not only the pointless init, but
> also the function calls. So the code would potentially be faster than
> before the changes?

Yeah. We have this lazy init now and the debug check forces the init. So
not only xdp_do_check_flushed() will initialize all three lists but also
xdp_do_flush() if only one was used by the caller.
Sure this can be optimized based on the init flag of the lists.

> Can be a follow up, obviously.
Will add it to my list.

Sebastian

