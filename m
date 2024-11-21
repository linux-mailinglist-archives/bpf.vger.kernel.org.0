Return-Path: <bpf+bounces-45375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE4F9D4F2E
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 15:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64193282245
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 14:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA77C1DE2B5;
	Thu, 21 Nov 2024 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pWFH7iTO"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833DF1DE2B9;
	Thu, 21 Nov 2024 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200310; cv=none; b=uoTYpm4TcHT4g9LBm4JZ5NFBhb/yaDKkum59SSNNBivKBfXDYgL4Rmy97l105CafJ2uZHuU7mSA/Z5rZTB+ISqzknj57cYjsrXlRShhzpvq5dHTbBgmLt4az5R1ejFd5gA4/vnoiJry97/eyM/WtfprN6BeMEVsL/yvZAwakx2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200310; c=relaxed/simple;
	bh=k13+Z0iAE1ZBIopnXQJo5gb4V8hodmEWGpkEvyHUPjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgpYiYuVjf5daA5gxr8ywEtIkk8pCGzuF8ARKXS6ofK19wxRbPJs7ZmdgtMR4dR/cJgK3V20ah8fJlq3frASMgECqcW4JfszX7SihJ4rfwQozsKSr5LVUrmqjjmtQcfRLBUpFDUxq18D1z1fKiV0e01zsWICSEfIZ2FSsSdNVnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pWFH7iTO; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NoTVJMzmSr+7GvpbI9xoC6QlTWnogCWjAb08P6x+C6c=; b=pWFH7iTOkfeuTaDn9qkuWCzJg0
	XHTPtIPgIv0NKPfBaiNcQgjx5VeG+qplbW+uqkMCzsO8WUVMNh0LM3s0NflbTCaHkU8XxSyIWmz0M
	3knavxb0cxSgry9QZ9SeEcMZ6B4emjFgND5d2XsHTJ0UwXVHWb0CregP8xfqENcW1Xm4ATIKJ06jo
	16mG4ix63zcI4GNLP7f6r5S1r23mylfs7kVa9pxONSuSTYOR+wxkz9U7QF4/tBf9GMMuMMJoKhqW0
	F86eLEdxmxj8YbSHHSmXDGComlwB2Kntw/gWjyUe8f05ua8DU/E/WbVswICDD1zbtuafZiptNJ/pW
	FTx6bEag==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tE8QF-00000000ahp-2TBZ;
	Thu, 21 Nov 2024 14:44:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 902C730068B; Thu, 21 Nov 2024 15:44:42 +0100 (CET)
Date: Thu, 21 Nov 2024 15:44:42 +0100
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
Subject: Re: [PATCH v4 tip/perf/core 2/4] mm: Introduce
 mmap_lock_speculation_{begin|end}
Message-ID: <20241121144442.GL24774@noisy.programming.kicks-ass.net>
References: <20241028010818.2487581-1-andrii@kernel.org>
 <20241028010818.2487581-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028010818.2487581-3-andrii@kernel.org>

On Sun, Oct 27, 2024 at 06:08:16PM -0700, Andrii Nakryiko wrote:
> From: Suren Baghdasaryan <surenb@google.com>
> 
> Add helper functions to speculatively perform operations without
> read-locking mmap_lock, expecting that mmap_lock will not be
> write-locked and mm is not modified from under us.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/mmap_lock.h | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 

> @@ -86,11 +87,35 @@ static inline void mm_lock_seqcount_end(struct mm_struct *mm)
>  	do_raw_write_seqcount_end(&mm->mm_lock_seq);
>  }
>  
> -#else
> +static inline bool mmap_lock_speculation_begin(struct mm_struct *mm, unsigned int *seq)
> +{
> +	*seq = raw_read_seqcount(&mm->mm_lock_seq);
> +	/* Allow speculation if mmap_lock is not write-locked */
> +	return (*seq & 1) == 0;
> +}

At the very least this should have more comment; I don't think it
adequately explains the reason for being weird. Perhaps:

	/*
	 * Since mmap_lock is a sleeping lock, and waiting for it to
	 * become unlocked is more or less equivalent with taking it
	 * ourselves, don't bother with the speculative path and take
	 * the slow path, which takes the lock.
	 */
	*seq = raw_read_seqcount(&mm->mm_lock_seq);
	return !(*seq & 1);

But perhaps it makes even more sense to add this functionality to
seqcount itself. The same argument can be made for seqcount_mutex and
seqcount_rwlock users.

> +static inline bool mmap_lock_speculation_end(struct mm_struct *mm, unsigned int seq)
> +{
> +	return !do_read_seqcount_retry(&mm->mm_lock_seq, seq);
> +}

This naming is somewhare weird, begin/end do not typically imply boolean
return values.

Perhaps something like? can_speculate, or speculate_try_begin, paired
with speculated_success or speculate_retry ?


