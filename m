Return-Path: <bpf+bounces-31174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 359428D79CE
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 03:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963D61F21D99
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 01:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA3B4688;
	Mon,  3 Jun 2024 01:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDJfZrfC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80DB15D1;
	Mon,  3 Jun 2024 01:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717378403; cv=none; b=DRvz1hVMJfNzK5wxlkxQ90NL8dQIfBeLgBgHvHmMyWkWVhBlWBZVOoksm280G9G1iii51UQolLN9+kDGvdst2BAypyG/juTweN1IWlH6/8PEW208yTEky+tk61K0fuz9EGKK45Tou07Ly+ydMxERdu6/Wzp9Eix0+z1ck6XmYXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717378403; c=relaxed/simple;
	bh=lVDE88Qb+/GrOkAnpTN63Uoia9YOV0ChEGvGNZ5FMD0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Jq2Wo32TXx4Ar+3hLlxv9rQ1EQnmZ/7hv7/kGv3Uh8IcC0+2KmDdmO6OkolLbHgjWDX+X7ienuBbyvltjB03z15U0sYt+fKtInaaXfYZUhCQ+yBpQOpTY/ksprXH+FDNXkz4AmexOzQj9NMN97QaRS7VPDHADZd7MAEU6EGA/LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDJfZrfC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DD3C2BBFC;
	Mon,  3 Jun 2024 01:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717378402;
	bh=lVDE88Qb+/GrOkAnpTN63Uoia9YOV0ChEGvGNZ5FMD0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dDJfZrfCVVIE36wD1Ywx1u8BL4mLlMGdRdHlMb5Sjkh8hrik7ZSxmWq17xC/u9nai
	 /csNuwWengEFBJLhqWeh2HlFSmePc6jbQBXvBPERz/CUP+/q+7ztt75+MNkVBLprhB
	 ZicxOb3j7EXmZGGTOpSJBdguXyn3uqcDgeZECJQxTFT5gjopNL6RM05/n/6UAA/og5
	 op/IxG5+mmRQiXVBP7n+rCqhFX9CHn63ZWoSFv177L5t88m6LcsXB6wsJFj7rjFNe5
	 CfCTGFyFJ89LTTm182xvTPhH2SRcrXrvSkwGyUFbXHbimib5xqdRdmY723yjN5ReCl
	 YIkqvY59HnWQw==
Date: Mon, 3 Jun 2024 10:33:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
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
Message-Id: <20240603103316.3af9dea3214a5d2bde721cd8@kernel.org>
In-Reply-To: <20240602033832.709653366@goodmis.org>
References: <20240602033744.563858532@goodmis.org>
	<20240602033832.709653366@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Steve,

On Sat, 01 Jun 2024 23:37:54 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

I think this is a new patch, correct? I'm a bit confused.

And I have some comments below;
[..]
> @@ -3164,6 +3166,392 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
>  	return 0;
>  }
>  
> +/* Simply make a copy of @src and return it */
> +static struct ftrace_hash *copy_hash(struct ftrace_hash *src)
> +{
> +	if (!src || src == EMPTY_HASH)
> +		return EMPTY_HASH;
> +
> +	return alloc_and_copy_ftrace_hash(src->size_bits, src);
> +}
> +
> +/*
> + * Append @new_hash entries to @hash:
> + *
> + *  If @hash is the EMPTY_HASH then it traces all functions and nothing
> + *  needs to be done.
> + *
> + *  If @new_hash is the EMPTY_HASH, then make *hash the EMPTY_HASH so
> + *  that it traces everything.

This lacks the most important comment, this function is only for
filter_hash, not for notrace_hash. :)

> + *
> + *  Otherwise, go through all of @new_hash and add anything that @hash
> + *  doesn't already have, to @hash.
> + */
> +static int append_hash(struct ftrace_hash **hash, struct ftrace_hash *new_hash)
> +{
> +	struct ftrace_func_entry *entry;
> +	int size;
> +	int i;
> +
> +	/* An empty hash does everything */
> +	if (!*hash || *hash == EMPTY_HASH)
> +		return 0;
> +
> +	/* If new_hash has everything make hash have everything */
> +	if (!new_hash || new_hash == EMPTY_HASH) {
> +		free_ftrace_hash(*hash);
> +		*hash = EMPTY_HASH;
> +		return 0;
> +	}
> +
> +	size = 1 << new_hash->size_bits;
> +	for (i = 0; i < size; i++) {
> +		hlist_for_each_entry(entry, &new_hash->buckets[i], hlist) {
> +			/* Only add if not already in hash */
> +			if (!__ftrace_lookup_ip(*hash, entry->ip) &&
> +			    add_hash_entry(*hash, entry->ip) == NULL)
> +				return -ENOMEM;
> +		}
> +	}
> +	return 0;
> +}
> +
> +/* Add to @hash only those that are in both @new_hash1 and @new_hash2 */

Ditto, this is only for the notrace_hash.

> +static int intersect_hash(struct ftrace_hash **hash, struct ftrace_hash *new_hash1,
> +			  struct ftrace_hash *new_hash2)
> +{
> +	struct ftrace_func_entry *entry;
> +	int size;
> +	int i;
> +
> +	/*
> +	 * If new_hash1 or new_hash2 is the EMPTY_HASH then make the hash
> +	 * empty as well as empty for notrace means none are notraced.
> +	 */
> +	if (!new_hash1 || new_hash1 == EMPTY_HASH ||
> +	    !new_hash2 || new_hash2 == EMPTY_HASH) {
> +		free_ftrace_hash(*hash);
> +		*hash = EMPTY_HASH;
> +		return 0;
> +	}
> +
> +	size = 1 << new_hash1->size_bits;
> +	for (i = 0; i < size; i++) {
> +		hlist_for_each_entry(entry, &new_hash1->buckets[i], hlist) {
> +			/* Only add if in both @new_hash1 and @new_hash2 */
> +			if (__ftrace_lookup_ip(new_hash2, entry->ip) &&
> +			    add_hash_entry(*hash, entry->ip) == NULL)
> +				return -ENOMEM;
> +		}
> +	}
> +	return 0;
> +}
> +
> +/* Return a new hash that has a union of all @ops->filter_hash entries */
> +static struct ftrace_hash *append_hashes(struct ftrace_ops *ops)
> +{
> +	struct ftrace_hash *new_hash;
> +	struct ftrace_ops *subops;
> +	int ret;
> +
> +	new_hash = alloc_ftrace_hash(ops->func_hash->filter_hash->size_bits);
> +	if (!new_hash)
> +		return NULL;
> +
> +	list_for_each_entry(subops, &ops->subop_list, list) {
> +		ret = append_hash(&new_hash, subops->func_hash->filter_hash);
> +		if (ret < 0) {
> +			free_ftrace_hash(new_hash);
> +			return NULL;
> +		}
> +		/* Nothing more to do if new_hash is empty */
> +		if (new_hash == EMPTY_HASH)
> +			break;
> +	}
> +	return new_hash;
> +}
> +
> +/* Make @ops trace evenything except what all its subops do not trace */
> +static struct ftrace_hash *intersect_hashes(struct ftrace_ops *ops)
> +{
> +	struct ftrace_hash *new_hash = NULL;
> +	struct ftrace_ops *subops;
> +	int size_bits;
> +	int ret;
> +
> +	list_for_each_entry(subops, &ops->subop_list, list) {
> +		struct ftrace_hash *next_hash;
> +
> +		if (!new_hash) {
> +			size_bits = subops->func_hash->notrace_hash->size_bits;
> +			new_hash = alloc_and_copy_ftrace_hash(size_bits, ops->func_hash->notrace_hash);
> +			if (!new_hash)
> +				return NULL;

If the first subops has EMPTY_HASH, this allocates small empty hash (!= EMPTY_HASH)
on `new_hash`.

> +			continue;
> +		}
> +		size_bits = new_hash->size_bits;
> +		next_hash = new_hash;

And it is assigned to `next_hash`.

> +		new_hash = alloc_ftrace_hash(size_bits);
> +		ret = intersect_hash(&new_hash, next_hash, subops->func_hash->notrace_hash);

Since the `next_hash` != EMPTY_HASH but it is empty, this keeps `new_hash`
empty but allocated.

> +		free_ftrace_hash(next_hash);
> +		if (ret < 0) {
> +			free_ftrace_hash(new_hash);
> +			return NULL;
> +		}
> +		/* Nothing more to do if new_hash is empty */
> +		if (new_hash == EMPTY_HASH)

Since `new_hash` is empty but != EMPTY_HASH, this does not pass. Keep looping on.

> +			break;
> +	}
> +	return new_hash;

And this will return empty but not EMPTY_HASH hash.


So, we need;

#define FTRACE_EMPTY_HASH_OR_NULL(hash)	(!(hash) || (hash) == EMPTY_HASH)

if (FTRACE_EMPTY_HASH_OR_NULL(subops->func_hash->notrace_hash)) {
	free_ftrace_hash(new_hash);
	new_hash = EMPTY_HASH;
	break;
}

at the beginning of the loop.
Also, at the end of the loop,

if (ftrace_hash_empty(new_hash)) {
	free_ftrace_hash(new_hash);
	new_hash = EMPTY_HASH;
	break;
}

> +}
> +
> +/* Returns 0 on equal or non-zero on non-equal */
> +static int compare_ops(struct ftrace_hash *A, struct ftrace_hash *B)

nit: Isn't it better to be `bool hash_equal()` and return true if A == B ?

Thank you,

> +{
> +	struct ftrace_func_entry *entry;
> +	int size;
> +	int i;
> +
> +	if (!A || A == EMPTY_HASH)
> +		return !(!B || B == EMPTY_HASH);
> +
> +	if (!B || B == EMPTY_HASH)
> +		return !(!A || A == EMPTY_HASH);
> +
> +	if (A->count != B->count)
> +		return 1;
> +
> +	size = 1 << A->size_bits;
> +	for (i = 0; i < size; i++) {
> +		hlist_for_each_entry(entry, &A->buckets[i], hlist) {
> +			if (!__ftrace_lookup_ip(B, entry->ip))
> +				return 1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

