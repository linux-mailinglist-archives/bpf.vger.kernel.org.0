Return-Path: <bpf+bounces-45776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6749DB092
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 02:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1D316391E
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 01:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A46E18638;
	Thu, 28 Nov 2024 00:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jajX3pYp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C27A17557;
	Thu, 28 Nov 2024 00:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732755530; cv=none; b=Lez2whGuNoaFVXc77+kZX6h6TCmS786osofz8acja8sI0j8Z3wn1s1GW1/xkE1ollgiAdJfwhqoqoGwpRl7r3zF/Tt4ov24GlWnZGVO9LeByEvv3Xkh8YVljK0IX7ITeqCAQnKkcLof7pIGLh/+IR88/hP1O6r8FeH7DWYB8KLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732755530; c=relaxed/simple;
	bh=5blE1A9Kn8XUlBJJA6u9dHT6buJUrLbL9a6/uglDLck=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=G6OFqVIuchsVJeOgfwhyl/wWglteZXXuAns/H56xhd0bWlVt9vggLkUOQIsXwSVmrDuEkIu6pxBxI1xnuyO3QBSNR7aevlxombocQ2AN+hfgtkpmWGN/Qhzjb2fGS6tPZn6mOQwU0lEu1t+q9utKZ2xfQ4ELNZYkgmuh8knP7Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jajX3pYp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D15C4CECC;
	Thu, 28 Nov 2024 00:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1732755529;
	bh=5blE1A9Kn8XUlBJJA6u9dHT6buJUrLbL9a6/uglDLck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jajX3pYpHhvhgkUyS7vzFqML3k+ESkZV3Q8FbcrvyGGSSKQPGNlz49SwkcslHtxXH
	 YTg5kW24bgXFCSN8WLP29fCWimuhQJCvJCZzBKbqpP+PamiJN5ZKRagXpiDudrAvw7
	 sXJsqRytxQ7yZaz/F3vuKzivvrGpfGvIrIsMytG8=
Date: Wed, 27 Nov 2024 16:58:48 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-mm@kvack.org, urezki@gmail.com, hch@infradead.org, vbabka@suse.cz,
 dakr@kernel.org, mhocko@suse.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, ast@kernel.org
Subject: Re: [PATCH mm/stable] mm: fix vrealloc()'s KASAN poisoning logic
Message-Id: <20241127165848.42331fd7078565c0f4e0a7e9@linux-foundation.org>
In-Reply-To: <20241126005206.3457974-1-andrii@kernel.org>
References: <20241126005206.3457974-1-andrii@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Nov 2024 16:52:06 -0800 Andrii Nakryiko <andrii@kernel.org> wrote:

> When vrealloc() reuses already allocated vmap_area, we need to
> re-annotate poisoned and unpoisoned portions of underlying memory
> according to the new size.

What are the consequences of this oversight?

When fixing a flaw, please always remember to describe the visible
effects of that flaw.

> Note, hard-coding KASAN_VMALLOC_PROT_NORMAL might not be exactly
> correct, but KASAN flag logic is pretty involved and spread out
> throughout __vmalloc_node_range_noprof(), so I'm using the bare minimum
> flag here and leaving the rest to mm people to refactor this logic and
> reuse it here.
> 
> Fixes: 3ddc2fefe6f3 ("mm: vmalloc: implement vrealloc()")

Because a cc:stable might be appropriate here.  But without knowing the
effects, it's hard to determine this.

> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4093,7 +4093,8 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
>  		/* Zero out spare memory. */
>  		if (want_init_on_alloc(flags))
>  			memset((void *)p + size, 0, old_size - size);
> -
> +		kasan_poison_vmalloc(p + size, old_size - size);
> +		kasan_unpoison_vmalloc(p, size, KASAN_VMALLOC_PROT_NORMAL);
>  		return (void *)p;
>  	}
>  


