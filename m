Return-Path: <bpf+bounces-49222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86321A15668
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 19:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA781188AAF2
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 18:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BDD1A3029;
	Fri, 17 Jan 2025 18:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JT1ywXok";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xVguczh5"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602031537AC
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 18:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737137977; cv=none; b=NvNQdWrnyXaknizR4E8z6Z/DG/CiLBAQsvJ9GSz35+2uILhpLCUWlaOHeEwIZQfhH76mt54Wk4rmo6g/WhoMrho7Gn0jI3e2fVHT7H8e8EaRJ7hpVj+263D/1G/dmeKclnU04mxXWFm3CNiDDkXTmQ0r44SZSCQbWN++VYcVb/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737137977; c=relaxed/simple;
	bh=xV68G9Hfkv/30dcJriQLQ1IoSOUvTEdduBRAHdWhqqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k46iqzS04I1o6+FvVggfi5wjQ8gz0D5RarhSm4/623XW7NgTCibYaJA4PAXQs04u5jlCc6nFrvtXbcOF3xZmwwavqXTqtSMS1CVBUfnMw3VM67bTrc5AAcgC2cg/kJI9c5bMrp6UqMOkYwoAcarddAfQ9gUe2SnMiMdNxq7pWx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JT1ywXok; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xVguczh5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 17 Jan 2025 19:19:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737137973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6XHn+3AlguhVOe5cKDPy5uHL2DKfIiFEU6eifK1hc2M=;
	b=JT1ywXokcV9mmWHLbCcFzuCx9poNQTl5VKTtp9c0ayzjaqhmxiMaz3mxyEXWnaZg2F6IVN
	JaqmWabMVoi3/NvDr579eZqA+9PonbvwupIED4D4emdJfiimj0oihGabde7rgHxkUndf8O
	kQRFF9YAv+Kh7wFk9b7s+Tj6tTP/QYIkJmWv1riYLleJYXNU0HhqeBkIqHhZW+IgP1XMBz
	PcwvwSOf5a76rQbSoiRUSWPgh14bKVQMi2VINM4g1qWoLGW7GkS5zI09+iQjXvIxTuOxh/
	621bCefLRyqoJC8+Xww5WHpJ8mW01rjuIrxCMypJ285eCt5xoefUfxxXCJYVRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737137973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6XHn+3AlguhVOe5cKDPy5uHL2DKfIiFEU6eifK1hc2M=;
	b=xVguczh5/z4+20GpZNGsj14I2xRfnCTImAZZB9VONr7HLEXaQzDOOWstLrSvGPpTjRCCXp
	g3yRV3XtK//aWIDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com,
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz,
	rostedt@goodmis.org, houtao1@huawei.com, hannes@cmpxchg.org,
	shakeel.butt@linux.dev, mhocko@suse.com, willy@infradead.org,
	tglx@linutronix.de, jannh@google.com, tj@kernel.org,
	linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v5 1/7] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
Message-ID: <20250117181931.54EJgni0@linutronix.de>
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
 <20250115021746.34691-2-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250115021746.34691-2-alexei.starovoitov@gmail.com>

On 2025-01-14 18:17:40 [-0800], Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Tracing BPF programs execute from tracepoints and kprobes where
> running context is unknown, but they need to request additional
> memory. The prior workarounds were using pre-allocated memory and
> BPF specific freelists to satisfy such allocation requests.
> Instead, introduce gfpflags_allow_spinning() condition that signals
> to the allocator that running context is unknown.
> Then rely on percpu free list of pages to allocate a page.
> try_alloc_pages() -> get_page_from_freelist() -> rmqueue() ->
> rmqueue_pcplist() will spin_trylock to grab the page from percpu
> free list. If it fails (due to re-entrancy or list being empty)
> then rmqueue_bulk()/rmqueue_buddy() will attempt to
> spin_trylock zone->lock and grab the page from there.
> spin_trylock() is not safe in RT when in NMI or in hard IRQ.
> Bailout early in such case.
>=20
> The support for gfpflags_allow_spinning() mode for free_page and memcg
> comes in the next patches.
>=20
> This is a first step towards supporting BPF requirements in SLUB
> and getting rid of bpf_mem_alloc.
> That goal was discussed at LSFMM: https://lwn.net/Articles/974138/
>=20
> Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

could you=E2=80=A6

> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
=E2=80=A6
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 1cb4b8c8886d..74c2a7af1a77 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7023,3 +7032,86 @@ static bool __free_unaccepted(struct page *page)
>  }
> =20
>  #endif /* CONFIG_UNACCEPTED_MEMORY */
> +
> +/**
> + * try_alloc_pages_noprof - opportunistic reentrant allocation from any =
context
> + * @nid - node to allocate from
> + * @order - allocation order size
> + *
> + * Allocates pages of a given order from the given node. This is safe to
> + * call from any context (from atomic, NMI, and also reentrant
> + * allocator -> tracepoint -> try_alloc_pages_noprof).
> + * Allocation is best effort and to be expected to fail easily so nobody=
 should
> + * rely on the success. Failures are not reported via warn_alloc().

Could you maybe add a pointer like "See AlwaysFailRestrictions below."
or something similar to make the user aware of the comment below where
certain always-fail restrictions are mentioned. Such as PREEMPT_RT + NMI
or deferred_pages_enabled().
It might not be easy to be aware of this.

I'm curious how this turns out in the long run :)

> + *
> + * Return: allocated page or NULL on failure.
> + */
> +struct page *try_alloc_pages_noprof(int nid, unsigned int order)
> +{
> +	/*
> +	 * Do not specify __GFP_DIRECT_RECLAIM, since direct claim is not allow=
ed.
> +	 * Do not specify __GFP_KSWAPD_RECLAIM either, since wake up of kswapd
> +	 * is not safe in arbitrary context.
> +	 *
> +	 * These two are the conditions for gfpflags_allow_spinning() being tru=
e.
> +	 *
> +	 * Specify __GFP_NOWARN since failing try_alloc_pages() is not a reason
> +	 * to warn. Also warn would trigger printk() which is unsafe from
> +	 * various contexts. We cannot use printk_deferred_enter() to mitigate,
> +	 * since the running context is unknown.
> +	 *
> +	 * Specify __GFP_ZERO to make sure that call to kmsan_alloc_page() below
> +	 * is safe in any context. Also zeroing the page is mandatory for
> +	 * BPF use cases.
> +	 *
> +	 * Though __GFP_NOMEMALLOC is not checked in the code path below,
> +	 * specify it here to highlight that try_alloc_pages()
> +	 * doesn't want to deplete reserves.
> +	 */
> +	gfp_t alloc_gfp =3D __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC;
> +	unsigned int alloc_flags =3D ALLOC_TRYLOCK;
> +	struct alloc_context ac =3D { };
> +	struct page *page;
> +
> +	/*
> +	 * In RT spin_trylock() may call raw_spin_lock() which is unsafe in NMI.
PREEMPT_RT please. s/may/will

> +	 * If spin_trylock() is called from hard IRQ the current task may be
> +	 * waiting for one rt_spin_lock, but rt_spin_trylock() will mark the
> +	 * task as the owner of another rt_spin_lock which will confuse PI
> +	 * logic, so return immediately if called form hard IRQ or NMI.
> +	 *
> +	 * Note, irqs_disabled() case is ok. This function can be called
> +	 * from raw_spin_lock_irqsave region.
> +	 */
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
> +		return NULL;
> +	if (!pcp_allowed_order(order))
> +		return NULL;
=E2=80=A6

Sebastian

