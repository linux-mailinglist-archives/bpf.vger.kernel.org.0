Return-Path: <bpf+bounces-74406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D55C578D5
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 14:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354133AD601
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 13:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBEB352929;
	Thu, 13 Nov 2025 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lvk+IzY+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF780351FD3;
	Thu, 13 Nov 2025 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038941; cv=none; b=QS+KhB4Zya3ZaQNx1vy/ei55kkwrLJYbQJDasSHDQzpgqMB1EPRvIp6ZYLf6/j9PDD+SKCZgoMt8Bq7ui8/Xpzw5PnDtzFneXcFDETIusYuo+K/pAqQ8sn8vwLGOzC0b0nMqXe99F2yDn48Ae15hDPPEpm1GakDUaH0DJSwYf7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038941; c=relaxed/simple;
	bh=DAkhzIUlG7glLtApG0JL3Nzp/VCQH1OHCGnfSmY2w+A=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DtW/hOtYYk+heNLrIPw3LZqlHnRRVT13wQeVOMxSW4n/VXbmz+EX/v5c366lnI5LYo0OTEQ05lONfbw1M8gTc8g89I1ob5MA6Lf8RJcKl/FHRk8+C0MHxd57UpkuFg45XfwvYdIap5uHp9dYjh0IBXD6LQOSHZwHNM7P5PVxp0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lvk+IzY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB07C4CEF8;
	Thu, 13 Nov 2025 13:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038941;
	bh=DAkhzIUlG7glLtApG0JL3Nzp/VCQH1OHCGnfSmY2w+A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Lvk+IzY+lB1vXAiV3KiK/Dl+SooaiijPPGGZX7BqCq5K/P6OhksFdbSdOhWHl5Jby
	 Cxk9xl9C2WaNalvHvFdPt9cQKgHflLxl5xFQ507KNhLAFLDIQSZN9KhwryG07WM4uk
	 C/ObKhgdZFKgSMdPKHLif6IOYcdWY8YHOlW9aNSozldLaOoN1DjzXNU5wfo27lDzCR
	 w8U7r4/EpeYxGXBMuWMeUl7X6xVabSWoz1Eofc20iBbz//jBB4vy1hG9yzv8PqxFKf
	 w962dj6qYhXTQhb3iMg+WL/iV0ErG8t1OfR7C+Txk/JbA0BWOvKnfmJIS+S019Fbtj
	 M+cyXHOjQGlog==
Content-Type: multipart/mixed; boundary="===============2663991294437569515=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <367c6cc9ffa12937ce18f37fc1271e3d17a3f7aa6ea6d1152cc8a41539994865@mail.kernel.org>
In-Reply-To: <20251113123750.2507435-5-jolsa@kernel.org>
References: <20251113123750.2507435-5-jolsa@kernel.org>
Subject: Re: [PATCHv2 bpf-next 4/8] ftrace: Add update_ftrace_direct_del function
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,rostedt@kernel.org,revest@google.com,mark.rutland@arm.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-arm-kernel@lists.infradead.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,menglong8.dong@gmail.com,song@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Nov 2025 13:02:21 +0000 (UTC)

--===============2663991294437569515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index ded3a306a..433c36c3a 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -543,6 +543,7 @@ int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
>  int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr);
>
>  int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash);
> +int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash);
>
>  void ftrace_stub_direct_tramp(void);

[ ... ]

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 311ce6406..345f3fdd2 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c

[ ... ]

> +int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
> +{
> +	struct ftrace_hash *new_hash = NULL, *filter_hash = NULL, *free_hash = NULL;
> +	struct ftrace_func_entry *del, *entry;
> +	unsigned long size, i;
> +	int err = -EINVAL;
> +
> +	if (!hash_count(hash))
> +		return 0;
> +	if (check_direct_multi(ops))
> +		return -EINVAL;
> +	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
> +		return -EINVAL;
> +	if (direct_functions == EMPTY_HASH)
> +		return -EINVAL;
> +
> +	mutex_lock(&direct_mutex);
> +
> +	/* Make sure requested entries are already registered. */
> +	size = 1 << hash->size_bits;
> +	for (i = 0; i < size; i++) {
> +		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
> +			del = __ftrace_lookup_ip(direct_functions, entry->ip);
> +			if (!del || del->direct != entry->direct)
> +				goto out_unlock;
> +		}
> +	}
> +
> +	err = -ENOMEM;
> +	filter_hash = hash_sub(ops->func_hash->filter_hash, hash);
> +	if (!filter_hash)
> +		goto out_unlock;
> +
> +	new_hash = hash_sub(direct_functions, hash);
> +	if (!new_hash)
> +		goto out_unlock;

Can this leak new_hash?  If hash_sub() succeeds for both filter_hash
and new_hash, but then either unregister_ftrace_function() or
ftrace_update_ops() fails below, we goto out_unlock without freeing
new_hash.  The cleanup code only frees filter_hash:

> +
> +	/* If there's nothing left, we need to unregister the ops. */
> +	if (ftrace_hash_empty(filter_hash)) {
> +		err = unregister_ftrace_function(ops);
> +		/* cleanup for possible another register call */
> +		ops->func = NULL;
> +		ops->trampoline = 0;
> +		ftrace_free_filter(ops);
> +		ops->func_hash->filter_hash = NULL;
> +	} else {
> +		err = ftrace_update_ops(ops, filter_hash, EMPTY_HASH);
> +	}
> +
> +	if (!err) {
> +		free_hash = direct_functions;
> +		rcu_assign_pointer(direct_functions, new_hash);
> +	}
> +
> + out_unlock:
> +	mutex_unlock(&direct_mutex);
> +
> +	if (free_hash && free_hash != EMPTY_HASH)
> +		call_rcu_tasks(&free_hash->rcu, register_ftrace_direct_cb);
> +	if (filter_hash)
> +		free_ftrace_hash(filter_hash);
> +
> +	return err;
> +}

If err != 0, new_hash remains allocated but is never freed.  Should the
cleanup code add free_ftrace_hash(new_hash) when it's non-NULL?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19332026793

--===============2663991294437569515==--

