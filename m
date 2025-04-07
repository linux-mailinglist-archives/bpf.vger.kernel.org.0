Return-Path: <bpf+bounces-55426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 666D6A7F001
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 23:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A24C3ABE96
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 21:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E3A223335;
	Mon,  7 Apr 2025 21:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vmstxYt+"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499983AC1C
	for <bpf@vger.kernel.org>; Mon,  7 Apr 2025 21:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744063034; cv=none; b=IWXf0mbUVZKBkE6t/j/mlfg+UTVI9RvcOgKq1z9lleaiVap5j6ECkHwFvKmumnSzc3DQVVvx7Ap1GA4/SF7yvtNKvWdoSzuNy1nxRdHktVHHHe+CbCFpcEG7WUl2Z04GwJEE6ORsQGOUW26Y4/SjjLlkpeAunwWtRpAzLV3DTfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744063034; c=relaxed/simple;
	bh=CXUbkgdb+eusHq7P3yexbWwGbiubwHu070X1U3C8AjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BusPs9J/n7zNpP3MR74uEwCOpqZ6GwMfBka3cCB9FUWXbuuU0iLm5oQYtIr1E+Q10PONGhhZwrqiVvaWySV7CvL1qthkrpxu3hliq75a/R6ZEb+c/75z3G9qipAVFjdY5mts1XCYlJpml06BjcyOIvyjuFkoVlQEsWwoaxx0WJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vmstxYt+; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <58bfc722-5dc4-4119-9c5c-49fb6b3da6cd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744063020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8FSvbn3NUduRNn7N60McM+103mzS7lUNeC9xApBCbjI=;
	b=vmstxYt+fi0rwIR2KrnBgXKcNg51M2lgRaLXPQnSQQEhRPRjKZhnmqH/rrsiXl8b8Y8O3b
	A4PezGM35aUDehoj+xg5Es8XOsjlBDXIfwQOI4iiNpXmWR8SpHMSmTGJJ/OQXAe6gdO2ZC
	wrN/fyPvXQqB3rKOSgcNzx81BmgfVas=
Date: Mon, 7 Apr 2025 14:56:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 2/3] bpf: udp: Avoid socket skips and repeats
 during iteration
To: Jordan Rife <jordan@jrife.io>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 Aditi Ghag <aditi.ghag@isovalent.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <20250404220221.1665428-1-jordan@jrife.io>
 <20250404220221.1665428-3-jordan@jrife.io>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250404220221.1665428-3-jordan@jrife.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/4/25 3:02 PM, Jordan Rife wrote:
> +static struct sock *bpf_iter_udp_resume(struct sock *first_sk,
> +					union bpf_udp_iter_batch_item *cookies,
> +					int n_cookies)
> +{
> +	struct sock *sk = NULL;
> +	int i = 0;
> +
> +	for (; i < n_cookies; i++) {
> +		sk = first_sk;
> +		udp_portaddr_for_each_entry_from(sk)
> +			if (cookies[i].cookie == atomic64_read(&sk->sk_cookie))
> +				goto done;
> +	}
> +done:
> +	return sk;
> +}
> +
>   static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>   {
>   	struct bpf_udp_iter_state *iter = seq->private;
>   	struct udp_iter_state *state = &iter->state;
> +	unsigned int find_cookie, end_cookie = 0;
>   	struct net *net = seq_file_net(seq);
> -	int resume_bucket, resume_offset;
>   	struct udp_table *udptable;
>   	unsigned int batch_sks = 0;
>   	bool resized = false;
> +	int resume_bucket;
>   	struct sock *sk;
>   
>   	resume_bucket = state->bucket;
> -	resume_offset = iter->offset;
>   
>   	/* The current batch is done, so advance the bucket. */
>   	if (iter->st_bucket_done)
> @@ -3428,6 +3446,8 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>   	 * before releasing the bucket lock. This allows BPF programs that are
>   	 * called in seq_show to acquire the bucket lock if needed.
>   	 */
> +	find_cookie = iter->cur_sk;
> +	end_cookie = iter->end_sk;
>   	iter->cur_sk = 0;
>   	iter->end_sk = 0;
>   	iter->st_bucket_done = false;
> @@ -3439,18 +3459,26 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>   		if (hlist_empty(&hslot2->head))
>   			continue;
>   
> -		iter->offset = 0;
>   		spin_lock_bh(&hslot2->lock);
> -		udp_portaddr_for_each_entry(sk, &hslot2->head) {
> +		/* Initialize sk to the first socket in hslot2. */
> +		udp_portaddr_for_each_entry(sk, &hslot2->head)
> +			break;

nit. It is to get the first entry? May be directly do
hlist_entry_safe(hslot2->head.first, ... ) instead.

> +		/* Resume from the first (in iteration order) unseen socket from
> +		 * the last batch that still exists in resume_bucket. Most of
> +		 * the time this will just be where the last iteration left off
> +		 * in resume_bucket unless that socket disappeared between
> +		 * reads.
> +		 *
> +		 * Skip this if end_cookie isn't set; this is the first
> +		 * batch, we're on bucket zero, and we want to start from the
> +		 * beginning.
> +		 */
> +		if (state->bucket == resume_bucket && end_cookie)
> +			sk = bpf_iter_udp_resume(sk,
> +						 &iter->batch[find_cookie],
> +						 end_cookie - find_cookie);
> +		udp_portaddr_for_each_entry_from(sk) {
>   			if (seq_sk_match(seq, sk)) {
> -				/* Resume from the last iterated socket at the
> -				 * offset in the bucket before iterator was stopped.
> -				 */
> -				if (state->bucket == resume_bucket &&
> -				    iter->offset < resume_offset) {
> -					++iter->offset;
> -					continue;
> -				}
>   				if (iter->end_sk < iter->max_sk) {
>   					sock_hold(sk);
>   					iter->batch[iter->end_sk++].sock = sk;

I looked at the details for these two functions. The approach looks good to me. 
Thanks for trying it.

This should stop the potential duplicates during stop() and then re-start().

My understanding is that it may or may not batch something newer than the last 
stop(). This behavior should be similar to the current offset approach also. I 
think it is fine. The similar situation is true for the next bucket anyway.

