Return-Path: <bpf+bounces-49223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8823A1566B
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 19:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23112166FA4
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 18:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B141A4E70;
	Fri, 17 Jan 2025 18:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kpHuPWCN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/Prf4bHd"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F2D1537AC
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737138059; cv=none; b=Kjlmcf4V1/mI8gJzNOIT6DHcXmZ6GdD7w1kLQ7xAZqm0WwspnsMi2Gsf9oRg+y5JsVB77R/LDU3iUVXyMv2eFV+MbU+DTtPyA/5JzTyHNxpVgSK8XTfgO93o1NPUENjfRuEOhvvzR77oAGg03TdJDwM733JDefoyEsi4CQN48dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737138059; c=relaxed/simple;
	bh=DtTYIsF38ILo9FNjGA1ocA+OzAmxmp1VLGiRDAXkseo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOGEq1DsQKGjdt/FGPGILIJRf2+JqoCbeglCKn797P98OwMisJnDKstSDW/L/Mk7YKEa7cBVYylJVokH4d37aCZ984V06UTciacS+EJRohV7t+YlGZxrv/KlKp2K8wWeAjYxXZ4laevivOAcz1ktYHLTSDiagu1dabtCVZfJSo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kpHuPWCN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/Prf4bHd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 17 Jan 2025 19:20:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737138056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P4HyUI1+i3xZ5o44sccRjqNftdH7ZQBrCdE+p3B9JWc=;
	b=kpHuPWCN4nImfa2i1UNomSq7VoGKweHTUMHo5F3haYQfOrtjRR2w4Rt+RV/6m8zYKiYgy0
	n6pMNVnX1fjCV766M1y08UA1G2eGZfaX4EHbHeCe7RrBaiJSg5btUDNO1UCtPk1jf3uZqn
	N0+5lfvwrmhsb4nhCxleTK3orbPwivrp/O65SF4HIBghDs89qJUHAfYp9kAuAOxoMoKMrD
	tDpkxUoR8+F3wZSWOFgTHHafQPLFfISDvF8MkNxN5AyJkgKWa5dOopT8DBTCm0KXB7Dn9i
	HKtWP/oh1e8C9noQvKbLlqAcWn0F6dsapbi7K2HKjp2Lb33CtDiG/qMscjhHCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737138056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P4HyUI1+i3xZ5o44sccRjqNftdH7ZQBrCdE+p3B9JWc=;
	b=/Prf4bHdPf/2+N8Tlp7gLA9QwfgWytOr7QheNDD4v0ZTQzzLX31iUDbfGtcWrRxfhWVJUK
	tadBVrOK7AzScADQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com,
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz,
	rostedt@goodmis.org, houtao1@huawei.com, hannes@cmpxchg.org,
	shakeel.butt@linux.dev, mhocko@suse.com, willy@infradead.org,
	tglx@linutronix.de, jannh@google.com, tj@kernel.org,
	linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v5 2/7] mm, bpf: Introduce free_pages_nolock()
Message-ID: <20250117182055._8lyYECm@linutronix.de>
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
 <20250115021746.34691-3-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250115021746.34691-3-alexei.starovoitov@gmail.com>

On 2025-01-14 18:17:41 [-0800], Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Introduce free_pages_nolock() that can free pages without taking locks.
> It relies on trylock and can be called from any context.
> Since spin_trylock() cannot be used in RT from hard IRQ or NMI
> it uses lockless link list to stash the pages which will be freed
> by subsequent free_pages() from good context.
>=20
> Do not use llist unconditionally. BPF maps continuously
> allocate/free, so we cannot unconditionally delay the freeing to
> llist. When the memory becomes free make it available to the
> kernel and BPF users right away if possible, and fallback to
> llist as the last resort.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
=E2=80=A6
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 74c2a7af1a77..a9c639e3db91 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1247,13 +1250,44 @@ static void split_large_buddy(struct zone *zone, =
struct page *page,
=E2=80=A6
>  static void free_one_page(struct zone *zone, struct page *page,
>  			  unsigned long pfn, unsigned int order,
>  			  fpi_t fpi_flags)
>  {
> +	struct llist_head *llhead;
>  	unsigned long flags;
> =20
> -	spin_lock_irqsave(&zone->lock, flags);
> +	if (!spin_trylock_irqsave(&zone->lock, flags)) {
> +		if (unlikely(fpi_flags & FPI_TRYLOCK)) {
> +			add_page_to_zone_llist(zone, page, order);
> +			return;
> +		}
> +		spin_lock_irqsave(&zone->lock, flags);
> +	}
> +
> +	/* The lock succeeded. Process deferred pages. */
> +	llhead =3D &zone->trylock_free_pages;
> +	if (unlikely(!llist_empty(llhead) && !(fpi_flags & FPI_TRYLOCK))) {
Thank you.

> +		struct llist_node *llnode;
> +		struct page *p, *tmp;
> +
> +		llnode =3D llist_del_all(llhead);
> +		llist_for_each_entry_safe(p, tmp, llnode, pcp_llist) {
> +			unsigned int p_order =3D p->order;
> +
> +			split_large_buddy(zone, p, page_to_pfn(p), p_order, fpi_flags);
> +			__count_vm_events(PGFREE, 1 << p_order);
> +		}
> +	}

Sebastian

