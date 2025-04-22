Return-Path: <bpf+bounces-56375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B38FA95C99
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 05:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A539F189786A
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 03:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE461A23A1;
	Tue, 22 Apr 2025 03:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AOyTYJ++"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3C71A0731
	for <bpf@vger.kernel.org>; Tue, 22 Apr 2025 03:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745292843; cv=none; b=Pc/qD7fNPCY43aDqOUp38cqZDEP8yaqAKUBRjulZB64j3oXX56hpWhaimyAFiZ4Ph5Bo8upAbjrnfp9TH3I4ojUo0ztOL2JhaihV1JyJDKLWsLmDyIGAIkMw6CjNLZRrzY9IN8UFS2YvyNpA6hO/YExd5iLxE4hAeurXK1J1Dh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745292843; c=relaxed/simple;
	bh=YOHinWUJrIZn0yEi+PczlhBeYrl0GIBlw9PxUC43raM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPym6AIx8HdSXRe36p5FfJ8MUJrOq0WLKUsoK3hYcOixbcJVZpuSgRtY1V+AHGnk2xGMQSs07E77tV50/mHI+uN9G6gf5cj5CCLiVEIh6/utDAq1VUaGdgi/lrhon5QzlGmzoxQVYb1HrN7z5KC2mZogO7wB0TrosmYoCasKxn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AOyTYJ++; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e3b08fdc-8a10-4491-a7a3-c11fed6d15ae@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745292828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aPZ1Xg/BSQsUZshzvDYT6XZ7YUU+zdwK7Xfh5sdYxo0=;
	b=AOyTYJ++P4X3k/9Tk3laRS5/EsUp4QPfYjTQhyadLgrnLWgdveaKv/OY5CHVHfxUXWE48r
	kmDGHjlV9Q5Ut25w6EcRGORI1iVh9YwpzCnhgtf1H0I1l7bp5YWZ4BhI67GLTgnKHSISNv
	nNHI+iEQ2r9Ys6D0FJ3/z4SF0bQZiXs=
Date: Mon, 21 Apr 2025 20:33:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next 2/6] bpf: udp: Make sure iter->batch always
 contains a full bucket snapshot
To: Jordan Rife <jordan@jrife.io>
Cc: Aditi Ghag <aditi.ghag@isovalent.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250419155804.2337261-1-jordan@jrife.io>
 <20250419155804.2337261-3-jordan@jrife.io>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250419155804.2337261-3-jordan@jrife.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/19/25 8:57 AM, Jordan Rife wrote:
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 0ac31dec339a..d3128261e4cb 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -3377,6 +3377,7 @@ int udp4_seq_show(struct seq_file *seq, void *v)
>   }
>   
>   #ifdef CONFIG_BPF_SYSCALL
> +#define MAX_REALLOC_ATTEMPTS 3
>   struct bpf_iter__udp {
>   	__bpf_md_ptr(struct bpf_iter_meta *, meta);
>   	__bpf_md_ptr(struct udp_sock *, udp_sk);
> @@ -3401,11 +3402,13 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>   	struct bpf_udp_iter_state *iter = seq->private;
>   	struct udp_iter_state *state = &iter->state;
>   	struct net *net = seq_file_net(seq);
> +	int resizes = MAX_REALLOC_ATTEMPTS;
>   	int resume_bucket, resume_offset;
>   	struct udp_table *udptable;
>   	unsigned int batch_sks = 0;
> -	bool resized = false;
> +	spinlock_t *lock = NULL;
>   	struct sock *sk;
> +	int err = 0;
>   
>   	resume_bucket = state->bucket;
>   	resume_offset = iter->offset;
> @@ -3433,10 +3436,13 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>   		struct udp_hslot *hslot2 = &udptable->hash2[state->bucket].hslot;
>   
>   		if (hlist_empty(&hslot2->head))
> -			continue;
> +			goto next_bucket;
>   
>   		iter->offset = 0;
> -		spin_lock_bh(&hslot2->lock);
> +		if (!lock) {
> +			lock = &hslot2->lock;
> +			spin_lock_bh(lock);
> +		}
>   		udp_portaddr_for_each_entry(sk, &hslot2->head) {
>   			if (seq_sk_match(seq, sk)) {
>   				/* Resume from the last iterated socket at the
> @@ -3454,15 +3460,28 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>   				batch_sks++;
>   			}
>   		}
> -		spin_unlock_bh(&hslot2->lock);
>   
>   		if (iter->end_sk)
>   			break;
> +next_bucket:
> +		/* Somehow the bucket was emptied or all matching sockets were
> +		 * removed while we held onto its lock. This should not happen.
> +		 */
> +		if (WARN_ON_ONCE(!resizes))
> +			/* Best effort; reset the resize budget and move on. */
> +			resizes = MAX_REALLOC_ATTEMPTS;
> +		if (lock)

I found the "if (lock)" changes and its related changes make the code harder
to follow. This change is mostly to handle one special case,
avoid releasing the lock when "resizes" reaches the limit.

Can this one case be specifically handled in the "for(bucket)" loop?

With this special case, it can alloc exactly the "batch_sks" size
with GFP_ATOMIC. It does not need to put the sk or get the cookie.
It can directly continue from the "iter->batch[iter->end_sk - 1].sock".

Something like this on top of this set. I reset the "resizes" on each new bucket,
removed the existing "done" label and avoid getting cookie in the last attempt.

Untested code and likely still buggy. wdyt?

#define MAX_REALLOC_ATTEMPTS 2

static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
{
	struct bpf_udp_iter_state *iter = seq->private;
	struct udp_iter_state *state = &iter->state;
	unsigned int find_cookie, end_cookie = 0;
	struct net *net = seq_file_net(seq);
	struct udp_table *udptable;
	unsigned int batch_sks = 0;
	int resume_bucket;
	struct sock *sk;
	int resizes = 0;
	int err = 0;

	resume_bucket = state->bucket;

	/* The current batch is done, so advance the bucket. */
	if (iter->st_bucket_done)
		state->bucket++;

	udptable = udp_get_table_seq(seq, net);

again:
	/* New batch for the next bucket.
	 * Iterate over the hash table to find a bucket with sockets matching
	 * the iterator attributes, and return the first matching socket from
	 * the bucket. The remaining matched sockets from the bucket are batched
	 * before releasing the bucket lock. This allows BPF programs that are
	 * called in seq_show to acquire the bucket lock if needed.
	 */
	find_cookie = iter->cur_sk;
	end_cookie = iter->end_sk;
	iter->cur_sk = 0;
	iter->end_sk = 0;
	iter->st_bucket_done = false;
	batch_sks = 0;

	for (; state->bucket <= udptable->mask; state->bucket++) {
		struct udp_hslot *hslot2 = &udptable->hash2[state->bucket].hslot;

		if (hlist_empty(&hslot2->head)) {
			resizes = 0;
			continue;
		}

		spin_lock_bh(&hslot2->lock);

		/* Initialize sk to the first socket in hslot2. */
		sk = hlist_entry_safe(hslot2->head.first, struct sock,
				      __sk_common.skc_portaddr_node);
		/* Resume from the first (in iteration order) unseen socket from
		 * the last batch that still exists in resume_bucket. Most of
		 * the time this will just be where the last iteration left off
		 * in resume_bucket unless that socket disappeared between
		 * reads.
		 *
		 * Skip this if end_cookie isn't set; this is the first
		 * batch, we're on bucket zero, and we want to start from the
		 * beginning.
		 */
		if (state->bucket == resume_bucket && end_cookie)
			sk = bpf_iter_udp_resume(sk,
						 &iter->batch[find_cookie],
						 end_cookie - find_cookie);
last_realloc_retry:
		udp_portaddr_for_each_entry_from(sk) {
			if (seq_sk_match(seq, sk)) {
				if (iter->end_sk < iter->max_sk) {
					sock_hold(sk);
					iter->batch[iter->end_sk++].sock = sk;
				}
				batch_sks++;
			}
		}

		if (unlikely(resizes == MAX_REALLOC_ATTEMPTS)  &&
		    iter->end_sk && iter->end_sk != batch_sks) {
			/* last realloc attempt to batch the whole
			 * bucket. Keep holding the lock to ensure the
			 * bucket will not be changed.
			 */
			err = bpf_iter_udp_realloc_batch(iter, batch_sks, GFP_ATOMIC);
			if (err) {
				spin_unlock_bh(&hslot2->lock);
				return ERR_PTR(err);
			}
			sk = iter->batch[iter->end_sk - 1].sock;
			sk = hlist_entry_safe(sk->__sk_common.skc_portaddr_node.next,
					      struct sock, __sk_common.skc_portaddr_node);
			batch_sks = iter->end_sk;
			goto last_realloc_retry;
		}

		spin_unlock_bh(&hslot2->lock);

		if (iter->end_sk)
			break;

		/* Got an empty bucket after taking the lock */
		resizes = 0;
	}

	/* All done: no batch made. */
	if (!iter->end_sk)
		return NULL;

	if (iter->end_sk == batch_sks) {
		/* Batching is done for the current bucket; return the first
		 * socket to be iterated from the batch.
		 */
		iter->st_bucket_done = true;
		return iter->batch[0].sock;
	}

	err = bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2, GFP_USER);
	if (err)
		return ERR_PTR(err);

	resizes++;
	goto again;
}
  
static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
				      unsigned int new_batch_sz, int flags)
{
	union bpf_udp_iter_batch_item *new_batch;

	new_batch = kvmalloc_array(new_batch_sz, sizeof(*new_batch),
				   flags | __GFP_NOWARN);
	if (!new_batch)
		return -ENOMEM;

	if (flags != GFP_ATOMIC)
		bpf_iter_udp_put_batch(iter);

	/* Make sure the new batch has the cookies of the sockets we haven't
	 * visited yet.
	 */
	memcpy(new_batch, iter->batch, sizeof(*iter->batch) * iter->end_sk);
	kvfree(iter->batch);
	iter->batch = new_batch;
	iter->max_sk = new_batch_sz;

	return 0;
}

> +			spin_unlock_bh(lock);
> +		lock = NULL;
>   	}
>   
>   	/* All done: no batch made. */
> -	if (!iter->end_sk)
> -		return NULL;
> +	if (!iter->end_sk) {
> +		sk = NULL;
> +		goto done;
> +	}
> +
> +	sk = iter->batch[0];
>   
>   	if (iter->end_sk == batch_sks) {
>   		/* Batching is done for the current bucket; return the first
> @@ -3471,16 +3490,30 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>   		iter->st_bucket_done = true;
>   		goto done;
>   	}
> -	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2,
> -						    GFP_USER)) {
> -		resized = true;
> -		/* After allocating a larger batch, retry one more time to grab
> -		 * the whole bucket.
> -		 */
> -		goto again;
> +
> +	/* Somehow the batch size still wasn't big enough even though we held
> +	 * a lock on the bucket. This should not happen.
> +	 */
> +	if (WARN_ON_ONCE(!resizes))
> +		goto done;
> +
> +	resizes--;
> +	if (resizes) {
> +		spin_unlock_bh(lock);
> +		lock = NULL;
>   	}
> +	err = bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2,
> +					 resizes ? GFP_USER : GFP_ATOMIC);
> +	if (err) {
> +		sk = ERR_PTR(err);
> +		goto done;
> +	}
> +
> +	goto again;
>   done:
> -	return iter->batch[0];
> +	if (lock)
> +		spin_unlock_bh(lock);
> +	return sk;
>   }
>   
>   static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)


