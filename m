Return-Path: <bpf+bounces-45369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DF29D4D09
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 13:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B322B1F22723
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 12:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E7E1D6DD1;
	Thu, 21 Nov 2024 12:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AQZ2dw3G"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A280C1D12E0;
	Thu, 21 Nov 2024 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732192838; cv=none; b=eDIUH5bHda6QTj4/d7zLsl+5lckYh1F/Et+s4uQqgWAJwb7nJJPDHKzANj9vawzDHvbdA0AAxIVcHm5Q6ac1oka+f0om9XoPQLgZJqxgtTaiWdB3kbhuWOEmmARpsBKpG2RWl5hf0/akhqaj3iXOU1VS6PCbWky3ZpC17/ENY84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732192838; c=relaxed/simple;
	bh=yIq/EMeFPW5kEsCkl9Aphuk7NiHKWxE+K7aOyaxDZzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfMPrFY8fE9Y2HHUu3xyYA8D9q85E3vbZtuX0zyxKAdnTkptC/0XDUBsoKtDmkVdKXCteAdo7d26VA8hoL3IR35oTGsmeTtlSQ/Hg2XleKxWKSX3gCDUjp5d8PBnrL6vTQczwyjf6uXQZYZ7XLX4Kjge3MWgsPB6j340JIASUJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AQZ2dw3G; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ikpAnH13gbp0BHe1sYaGxmFI2nIUUInCIR7xIHSqhjw=; b=AQZ2dw3G7cIbip5y5YOVoD0RtD
	927AGxDlm/cKkwl8CrIw8V7+iEJgbmopNa0dPo0Zsp4AdtEUj7FQ508lfvuTUhEWDud29AnRJB5vn
	iar09XeXACJREwkkIsnq9KmIXBafd4P1n0hlrwfjuHR4+akH2DOXJ++kkHlk16vSgjLp49hS5LXqD
	KMwdWMXDVPDFpTZj0kT1gOlOtYuEkZVfqf/S85vBqsjk2coQuXtvV7aoM+DsXkzB24IcAy0qq6qnT
	D++kovSxCKKB1EY2C2p9m2vSTrshUuugrr4x7V0UbTyYu9VslMnyzX3OTCjww98AVVQHX2ScvJiyD
	Yp9aWmuw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tE6Tk-00000000a0U-1YEf;
	Thu, 21 Nov 2024 12:40:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8FDC730068B; Thu, 21 Nov 2024 13:40:11 +0100 (CET)
Date: Thu, 21 Nov 2024 13:40:11 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, oleg@redhat.com, rostedt@goodmis.org,
	mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, mjguzik@gmail.com,
	brauner@kernel.org, jannh@google.com, mhocko@kernel.org,
	vbabka@suse.cz, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com,
	david@redhat.com, arnd@arndb.de, richard.weiyang@gmail.com,
	zhangpeng.00@bytedance.com, linmiaohe@huawei.com,
	viro@zeniv.linux.org.uk, hca@linux.ibm.com
Subject: Re: [PATCH v4 tip/perf/core 1/4] mm: Convert mm_lock_seq to a proper
 seqcount
Message-ID: <20241121124011.GK24774@noisy.programming.kicks-ass.net>
References: <20241028010818.2487581-1-andrii@kernel.org>
 <20241028010818.2487581-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028010818.2487581-2-andrii@kernel.org>

On Sun, Oct 27, 2024 at 06:08:15PM -0700, Andrii Nakryiko wrote:
> +/*
> + * Drop all currently-held per-VMA locks.
> + * This is called from the mmap_lock implementation directly before releasing
> + * a write-locked mmap_lock (or downgrading it to read-locked).
> + * This should normally NOT be called manually from other places.
> + * If you want to call this manually anyway, keep in mind that this will release
> + * *all* VMA write locks, including ones from further up the stack.
> + */
> +static inline void vma_end_write_all(struct mm_struct *mm)
> +{
> +	mmap_assert_write_locked(mm);
> +	/*
> +	 * Nobody can concurrently modify mm->mm_lock_seq due to exclusive
> +	 * mmap_lock being held.
> +	 */

You can write:

	ASSERT_EXCLUSIVE_WRITER(mm->mm_lock_seq);

instead of that comment. Then KCSAN will validate the claim.

> +	mm_lock_seqcount_end(mm);
> +}

