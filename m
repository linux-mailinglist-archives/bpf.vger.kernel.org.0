Return-Path: <bpf+bounces-75955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6A6C9E4D3
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 09:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C93EF349B81
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 08:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3502C2D3731;
	Wed,  3 Dec 2025 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hl5QYGaY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA04158535;
	Wed,  3 Dec 2025 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764751667; cv=none; b=opf7uMg/Q0XEYcu2Q0K8GkKGYdAyzDjRWuqR9qKKvV4LoZP44aE0rlSUne2yB4PR7L68GhFi8DiH6JTnMzuSUiTlGdwpEHp7Rzf67dbDDLXqerd/YhGOfKG5F2W56a6qA/GUss06un4/gtBJdod5lIhxa32Loxy+G601CsSyPac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764751667; c=relaxed/simple;
	bh=zZggOqyqpCFVEMcM9cHwsXefF4PRk8oAmhf5XqTg3nE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=oKLluY3tNtlPeSEX0j0ISIv61Vdul/Y3m26PVqv3nDAgu6xza/YCV1ggveGDCy6CKShvIf22FzvA3kOHnEcDgQs/Kq+yMPGBu1IdqaJZiLRerWxgFwDcBNfpKdkK0E/pkJu+23SkUBE6HASLpSwJ5bsxHCIEeg4Qtv9OshTATVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hl5QYGaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF6BC19422;
	Wed,  3 Dec 2025 08:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764751667;
	bh=zZggOqyqpCFVEMcM9cHwsXefF4PRk8oAmhf5XqTg3nE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Hl5QYGaYXkUGRQCpvqRKGGxwk72j/uZIW+2KInS5UiITtjd7fhh0KOWuqZkkqC0ch
	 RPOI7nYQr7R9cfdzxPZhjEoRat5tGEzxjZwv/RzOG9NLmbm2dtmtU6XNak89b59mqv
	 5TP7FnB8Z7P5GdMIMNghZcum0ZXDHrcnAUpMNboZR7sejeYjK+X8wWh9IncPmV7Mg9
	 nvbUgWWNnuleBsyBvknXHohHCAtLX0+IFgeQhnf0oJ9k+XZDmlIDhJfVvdxcG2PTfq
	 Pz96eqw+7b+h5fgUsAZyut+31r9AmaG2/I6KYhfJmLZLQLY5x4rpA8QnmBwqSkqmvL
	 xhdX17i0JyZQA==
Content-Type: multipart/mixed; boundary="===============9160476271581551712=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d0d8e0d78f614eb8b443772b50fb36093d48c7f43374316246ad3ad836b5c9ce@mail.kernel.org>
In-Reply-To: <20251203082402.78816-5-jolsa@kernel.org>
References: <20251203082402.78816-5-jolsa@kernel.org>
Subject: Re: [PATCHv4 bpf-next 4/9] ftrace: Add update_ftrace_direct_add function
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,rostedt@kernel.org,revest@google.com,mark.rutland@arm.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-arm-kernel@lists.infradead.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,menglong8.dong@gmail.com,song@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  3 Dec 2025 08:47:45 +0000 (UTC)

--===============9160476271581551712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 8c034b028..eb60d971e 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h

[ ... ]

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 84aee9096..1660a8754 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c

[ ... ]

> +int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash)
> +{
> +	struct ftrace_hash *old_direct_functions = NULL, *new_direct_functions = NULL;
> +	struct ftrace_hash *old_filter_hash = NULL, *new_filter_hash = NULL;
> +	struct ftrace_func_entry *entry;
> +	int i, size, err = -EINVAL;
> +	bool reg;
> +
> +	if (!hash_count(hash))
> +		return -EINVAL;
> +
> +	mutex_lock(&direct_mutex);
> +
> +	/* Make sure requested entries are not already registered. */
> +	size = 1 << hash->size_bits;
> +	for (i = 0; i < size; i++) {
> +		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
> +			if (__ftrace_lookup_ip(direct_functions, entry->ip))
> +				goto out_unlock;
> +		}
> +	}
> +
> +	old_filter_hash = ops->func_hash ? ops->func_hash->filter_hash : NULL;
> +	old_direct_functions = direct_functions;
> +
> +	/* If there's nothing in filter_hash we need to register the ops. */
> +	reg = hash_count(old_filter_hash) == 0;
> +	if (reg) {
> +		if (ops->func || ops->trampoline)
> +			goto out_unlock;
> +		if (ops->flags & FTRACE_OPS_FL_ENABLED)
> +			goto out_unlock;
> +	}
> +
> +	err = -ENOMEM;
> +	new_filter_hash = hash_add(old_filter_hash, hash);
> +	if (!new_filter_hash)
> +		goto out_unlock;
> +
> +	new_direct_functions = hash_add(old_direct_functions, hash);
> +	if (!new_direct_functions)
> +		goto out_unlock;

Can new_filter_hash leak here?  If the second hash_add() fails but the
first one succeeds, update_ftrace_direct_add() will goto out_unlock
with new_filter_hash pointing to allocated memory.  At out_unlock, only
old_filter_hash gets freed, not new_filter_hash.

register_ftrace_direct() handles this by freeing new_hash on error:

    out_unlock:
        mutex_unlock(&direct_mutex);

        if (free_hash && free_hash != EMPTY_HASH)
            call_rcu_tasks(&free_hash->rcu, register_ftrace_direct_cb);

        if (new_hash)
            free_ftrace_hash(new_hash);

        return err;

> +
> +	rcu_assign_pointer(direct_functions, new_direct_functions);
> +
> +	if (reg) {
> +		ops->func = call_direct_funcs;
> +		ops->flags |= MULTI_FLAGS;
> +		ops->trampoline = FTRACE_REGS_ADDR;
> +		ops->local_hash.filter_hash = new_filter_hash;
> +
> +		err = register_ftrace_function_nolock(ops);
> +		if (err) {
> +			/* restore old filter on error */
> +			ops->local_hash.filter_hash = old_filter_hash;
> +			old_filter_hash = new_filter_hash;
> +
> +			/* cleanup for possible another register call */
> +			ops->func = NULL;
> +			ops->trampoline = 0;
> +		}
> +	} else {
> +		err = ftrace_update_ops(ops, new_filter_hash, EMPTY_HASH);
> +		/*
> +		 * new_filter_hash is dup-ed, so we need to release it anyway,
> +		 * old_filter_hash either stays on error or is released already
> +		 */
> +		old_filter_hash = new_filter_hash;
> +	}
> +
> +	if (err) {
> +		/* reset direct_functions and free the new one */
> +		rcu_assign_pointer(direct_functions, old_direct_functions);
> +		old_direct_functions = new_direct_functions;
> +	}
> +
> + out_unlock:
> +	mutex_unlock(&direct_mutex);
> +
> +	if (old_direct_functions && old_direct_functions != EMPTY_HASH)
> +		call_rcu_tasks(&old_direct_functions->rcu, register_ftrace_direct_cb);
> +	if (old_filter_hash)
> +		free_ftrace_hash(old_filter_hash);
> +
> +	return err;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19887401362

--===============9160476271581551712==--

