Return-Path: <bpf+bounces-31178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB468D7A25
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 04:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B241280F88
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 02:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAB2B663;
	Mon,  3 Jun 2024 02:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyzFy5ZX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BC8AD35;
	Mon,  3 Jun 2024 02:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717382803; cv=none; b=q9kKsSWFoQNbW26VB/svcpzfnMFenuL4r7nPM8z+TWvi1aL3ml1U3O3qzhJ3dnWWFnwzLLwmn7MD5oH43d/EuXD3W7UKZkFUa1pnRfTwDcsPrp1qsFnkrnA8qG3qqxjaZTqDMKG1tl5C3bW1cUdWD+IIk8wTPA1xkmKaX+hiklc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717382803; c=relaxed/simple;
	bh=hUy2QzJqjW+BmS42fRWN5RITmP+ikPzZbR/VgKNapZ4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nDUMhMctd4JSCfPU2VnAJUJ24Vl/CJRsDHsfC0NGCMGbF+vhdoKCiPZymNx8tKY/QuOIbMAXDqJ6M5Sdwg1nqnIiocdXyHxz9U0hHqLOry4PefM5pU/jbq+U3eCya8tlz6OsFczaWnowPdwYrVjUT1IErusecu85EbqSNnCHqgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyzFy5ZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944DAC2BBFC;
	Mon,  3 Jun 2024 02:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717382802;
	bh=hUy2QzJqjW+BmS42fRWN5RITmP+ikPzZbR/VgKNapZ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YyzFy5ZXAdsf4yQwWKi/nxyorWVS+sxftkUFmJAA9Nkbq2yEkrazh8xULU7LqpH/o
	 NDv24cefagH8eTH2swd0ak/N4rQCDmL2d5nRONe1F+0cIvdV2BEOVYq4nwOZ8Pgh8T
	 Whqa49Pt6R5q7Eqa8dlpIru1eQdjYzHzT20v5ejHVH8Y9IeWTCELpO22NAoiTsVohh
	 gY9dyLlPy4duRUiBRehICnIn7EKIaYyVGVV/Vtvje/+IxKARVjKGz5Z3YrsF4Mfybp
	 KyahpqeSCcZi4bWpVkU9zMLap7s/IqQ2DtXUg+USMmpStzNxc9IrQv5Te9y3sj+Sum
	 20VD+amXMkCgw==
Date: Mon, 3 Jun 2024 11:46:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v2 10/27] ftrace: Add subops logic to allow one ops to
 manage many
Message-Id: <20240603114636.63b5abe2189cb732bec2474c@kernel.org>
In-Reply-To: <20240602220613.3f9eac04@gandalf.local.home>
References: <20240602033744.563858532@goodmis.org>
	<20240602033832.709653366@goodmis.org>
	<20240603103316.3af9dea3214a5d2bde721cd8@kernel.org>
	<20240602220613.3f9eac04@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Jun 2024 22:06:13 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > > +/* Make @ops trace evenything except what all its subops do not trace */
> > > +static struct ftrace_hash *intersect_hashes(struct ftrace_ops *ops)
> > > +{
> > > +	struct ftrace_hash *new_hash = NULL;
> > > +	struct ftrace_ops *subops;
> > > +	int size_bits;
> > > +	int ret;
> > > +
> > > +	list_for_each_entry(subops, &ops->subop_list, list) {
> > > +		struct ftrace_hash *next_hash;
> > > +
> > > +		if (!new_hash) {
> > > +			size_bits = subops->func_hash->notrace_hash->size_bits;
> > > +			new_hash = alloc_and_copy_ftrace_hash(size_bits, ops->func_hash->notrace_hash);
> > > +			if (!new_hash)
> > > +				return NULL;  
> > 
> > If the first subops has EMPTY_HASH, this allocates small empty hash (!= EMPTY_HASH)
> > on `new_hash`.
> 
> Could we just change the above to be: ?
> 
> 			new_hash = ftrace_hash_empty(ops->func_hash->notrace_hash) ? EMPTY_HASH :
> 				alloc_and_copy_ftrace_hash(size_bits, ops->func_hash->notrace_hash);
> 			if (!new_hash)
> 				return NULL;  

Yeah, and if new_hash is EMPTY_HASH, we don't need looping on the rest of
the hashes, right?

> 
> 
> > 
> > > +			continue;
> > > +		}
> > > +		size_bits = new_hash->size_bits;
> > > +		next_hash = new_hash;  
> > 
> > And it is assigned to `next_hash`.
> > 
> > > +		new_hash = alloc_ftrace_hash(size_bits);
> > > +		ret = intersect_hash(&new_hash, next_hash, subops->func_hash->notrace_hash);  
> > 
> > Since the `next_hash` != EMPTY_HASH but it is empty, this keeps `new_hash`
> > empty but allocated.
> > 
> > > +		free_ftrace_hash(next_hash);
> > > +		if (ret < 0) {
> > > +			free_ftrace_hash(new_hash);
> > > +			return NULL;
> > > +		}
> > > +		/* Nothing more to do if new_hash is empty */
> > > +		if (new_hash == EMPTY_HASH)  
> > 
> > Since `new_hash` is empty but != EMPTY_HASH, this does not pass. Keep looping on.
> > 
> > > +			break;
> > > +	}
> > > +	return new_hash;  
> > 
> > And this will return empty but not EMPTY_HASH hash.
> > 
> > 
> > So, we need;
> > 
> > #define FTRACE_EMPTY_HASH_OR_NULL(hash)	(!(hash) || (hash) == EMPTY_HASH)
> > 
> > if (FTRACE_EMPTY_HASH_OR_NULL(subops->func_hash->notrace_hash)) {
> > 	free_ftrace_hash(new_hash);
> > 	new_hash = EMPTY_HASH;
> > 	break;
> > }
> > 
> > at the beginning of the loop.
> > Also, at the end of the loop,
> > 
> > if (ftrace_hash_empty(new_hash)) {
> > 	free_ftrace_hash(new_hash);
> > 	new_hash = EMPTY_HASH;
> > 	break;
> > }

And we still need this (I think this should be done in intersect_hash(), we just
need to count the number of entries.) 

> > 
> > > +}
> > > +
> > > +/* Returns 0 on equal or non-zero on non-equal */
> > > +static int compare_ops(struct ftrace_hash *A, struct ftrace_hash *B)  
> > 
> > nit: Isn't it better to be `bool hash_equal()` and return true if A == B ?
> 
> Sure. I guess I was thinking too much of strcmp() logic :-p

Yeah, it's the curse of the C programmer :( (even it is good for sorting.)

Thank you,

> 
> > 
> > Thank you,
> 
> Thanks for the review.
> 
> -- Steve
> 
> > 
> > > +{
> > > +	struct ftrace_func_entry *entry;
> > > +	int size;
> > > +	int i;
> > > +
> > > +	if (!A || A == EMPTY_HASH)
> > > +		return !(!B || B == EMPTY_HASH);
> > > +
> > > +	if (!B || B == EMPTY_HASH)
> > > +		return !(!A || A == EMPTY_HASH);
> > > +
> > > +	if (A->count != B->count)
> > > +		return 1;
> > > +
> > > +	size = 1 << A->size_bits;
> > > +	for (i = 0; i < size; i++) {
> > > +		hlist_for_each_entry(entry, &A->buckets[i], hlist) {
> > > +			if (!__ftrace_lookup_ip(B, entry->ip))
> > > +				return 1;
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +  
> > 
> > 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

