Return-Path: <bpf+bounces-63003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8670B0149B
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 09:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D116D3A7046
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 07:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98201EB5E1;
	Fri, 11 Jul 2025 07:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1NeBlvT0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4A/h/3Vv"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93D11E9B08
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 07:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218812; cv=none; b=tvA7+DShYjoF5K5MkPmoMlllcUX/RwKAOG1w6x0UZ535zOU8Gf34Y1npboR813R80BZkpYjraArUZJNoqN2xAX2T7eASkAGAGQ7LJbkYpjbfryTXGPpVpIcl1nDBuB8DFpBdlKiV+tLQvhNYxkjPES5tpX8UId6CYu0H+zoQxtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218812; c=relaxed/simple;
	bh=k8wyxScyK/MbudzbBVlpiDabHMGAWhxSUKRCt0KOIXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuOE7ytaD/Em8hrXnpxuHgQqcQf7Hcd2ia9SI1BJ3bRU3D56O7jLeDhDnzfQfJoTB3nLY41h58mdmt5a9vK2w/Fm6vfHnv8+5261soAJc239w8X+abafiwZ8rIq/nw/yxWgmFjnxrOGfAuLq4Rj6OR/k2sX5uAqd7sgDPPClgeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1NeBlvT0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4A/h/3Vv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 09:26:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752218808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=axeX5rHO1v0WWqEDd6CO74/uGVzY0aLrSXsg3JOknM0=;
	b=1NeBlvT0YAe2FfUy5X9oDNf5b5P/VQ0NHEDFJabjBiaz1SNrlMfbSAVPMnZ5wBYtpd3RZB
	6WoDT04hBsUUO7RrmmqaGFdMN5Z7PuNIXQMJdpgkW3ROMOK39MCmKJ4IewS7z4IUK8ifp1
	FyN54r0m4dv6Y2FSTOpGE/J/JM3kz/A/GkHXAPraCk2l5+gVK4AqBH8zKWnCPNMI/tGjbU
	dYO3zik9dj5XNVa0zGiCaJQi1pk3bMUiHNTgjQk6RTST3LTX5Ia2S4dcOVLhwOiF9l71FE
	ArUkg5YKwmB44rIkpgR74qeWWe9D7MNzepxMUPSEx/CihSOiK36a9kyFG5WcEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752218808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=axeX5rHO1v0WWqEDd6CO74/uGVzY0aLrSXsg3JOknM0=;
	b=4A/h/3VvwkL2xRLm7rvrL8ASszAgLTOmPtgtI6lnWZDILs7nIdn2zKhDIbbdWppbLwhCGM
	XovhIKR+69S0+KBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
	harry.yoo@oracle.com, shakeel.butt@linux.dev, mhocko@suse.com,
	andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
	peterz@infradead.org, rostedt@goodmis.org, hannes@cmpxchg.org
Subject: Re: [PATCH v2 6/6] slab: Introduce kmalloc_nolock() and
 kfree_nolock().
Message-ID: <20250711072646.a63qm4tP@linutronix.de>
References: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
 <20250709015303.8107-7-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250709015303.8107-7-alexei.starovoitov@gmail.com>

On 2025-07-08 18:53:03 [-0700], Alexei Starovoitov wrote:
> @@ -4555,6 +4707,53 @@ static void __slab_free(struct kmem_cache *s, stru=
ct slab *slab,
>  	discard_slab(s, slab);
>  }
> =20
> +static DEFINE_PER_CPU(struct llist_head, defer_free_objects);
> +static DEFINE_PER_CPU(struct irq_work, defer_free_work);

static DEFINE_PER_CPU(struct llist_head, defer_free_objects) =3D LLIST_HEAD=
_INIT(defer_free_objects);
static DEFINE_PER_CPU(struct irq_work, defer_free_work) =3D IRQ_WORK_INIT(f=
ree_deferred_objects);

would allow you to avoid init_defer_work().

> +static void free_deferred_objects(struct irq_work *work)
> +{
> +	struct llist_head *llhead =3D this_cpu_ptr(&defer_free_objects);
> +	struct llist_node *llnode, *pos, *t;
=E2=80=A6
> +}
> +
> +static int __init init_defer_work(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		init_llist_head(per_cpu_ptr(&defer_free_objects, cpu));
> +		init_irq_work(per_cpu_ptr(&defer_free_work, cpu),
> +			      free_deferred_objects);
> +	}
> +	return 0;
> +}
> +late_initcall(init_defer_work);
> +
> +static void defer_free(void *head)
> +{
> +	if (llist_add(head, this_cpu_ptr(&defer_free_objects)))
> +		irq_work_queue(this_cpu_ptr(&defer_free_work));

If you group &defer_free_objects and &defer_free_work into a struct you
could avoid using this_cpu_ptr twice.
Having both in one struct would allow to use container_of() in
free_deferred_objects() to get the free list.

> +}
=E2=80=A6
> @@ -4844,6 +5064,62 @@ void kfree(const void *object)
>  }
>  EXPORT_SYMBOL(kfree);
> =20
> +/*
> + * Can be called while holding raw_spin_lock or from IRQ and NMI,
raw_spinlock_t

> + * but only for objects allocated by kmalloc_nolock(),
> + * since some debug checks (like kmemleak and kfence) were
> + * skipped on allocation. large_kmalloc is not supported either.
> + */
> +void kfree_nolock(const void *object)
> +{
=E2=80=A6

Sebastian

