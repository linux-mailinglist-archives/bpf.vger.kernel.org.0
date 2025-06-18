Return-Path: <bpf+bounces-60986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B44F3ADF626
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 20:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1506B1BC0506
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 18:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814922F949E;
	Wed, 18 Jun 2025 18:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fz5h4i5N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8352F5467;
	Wed, 18 Jun 2025 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750272290; cv=none; b=I4PEq+I9GrXDmjVkHB8iQi4eXRf9XOYQeFT2vpPUjtva2FAqwG6ZTU0bqOSjE/cAPky2rQAK+C3d2+8OUoDWd+B7ZpTTfUA1rh3Ecuim9Qed9kFQQHUR7WQaD9VIYMoN6rv2PMOsxvi0LMbDjqs2nXov2BZGdubuiXhu215xPPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750272290; c=relaxed/simple;
	bh=IF+QHC1hqJsnLz4/uI/7psIsJIdjMC/q+fKeyfjOUyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLDfBvYInHJXLeL78MI30oxhNfixAdEbeP5i/W+ZJ4hwITOgnjq82axm+mZHgSQkn56S+yrSxl0zmyt+cIFmpYKGCUi6pI6da2EEmszEAllv03E25sOd3dFr99PPb0moF+s42jQerWFrzcAHjmPiZlYS73pGQE8d3mjRWCPgFN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fz5h4i5N; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-748ece799bdso657877b3a.1;
        Wed, 18 Jun 2025 11:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750272287; x=1750877087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lfxAip8IqJCM1oH0nU7XeBePxqLCBFbrrrG86sn/KK8=;
        b=Fz5h4i5Nixl/YIxgv4grkEv57EvLOVk6Q/yxjiGQ/w0LSonciQjg9xlrRlTmlx+62X
         bnU/IlNalRK3l/uM6FsTxl70Wa1OTWrboRVpv0w77EGkirzlHKBMrGqWs5+6STdxCG36
         gv7uw9L6grrgfLCh1lD6MlHOmJ66qDZdipczWPbQZw3QJvxk6OB3ZmxWF7a0kp8czq4H
         lpCShjOBNV0EyJ0qFVaB8TYZ1U2p/hhqgM1P4jPwAKQnZZOaHYPQdVKI1Mte3ALANraw
         YlamxtONmvr6PahIWJ0oF2kq7FXndM8jjd224w1M5uP6Tv84Jo4KyniRMPTa2h9vnRc1
         vwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750272287; x=1750877087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfxAip8IqJCM1oH0nU7XeBePxqLCBFbrrrG86sn/KK8=;
        b=CbpPYn3ZGUYCqcZqCmtQ26xL9rF8wFiCVrl/8G63+9fU5RxHFEND0VBfGeP87nZIAT
         94gOBYPZ265MPAGIzMZb6i5GrAkkbBCoOvQ+bxJd2O+Erm+VRzJiHPJjlkaoL484YhjC
         Yk3R/Gg+WoAcRNLy+HlRIKlZT18DLylwD58ACgoX+Hbuz6pDxmprXKSLXhNKYK2loGF5
         J6THxr2nCdeJjwTpVKSj/aKs71GHDrHfleh8N78XrgRRG4R3jBQL4uHS8S7XDL50YNl3
         WiICbmVw7hrwVTWkx3qjLN2Dqeg2PO+7ZSE8QfAy3v1AfeNq254J/ehykwHhlEKCdyN3
         3XFA==
X-Forwarded-Encrypted: i=1; AJvYcCUq4vjnsXQLRtyvfGzsfdUyGOGIsEESIQC7bdBV7RpMdZK9uJP1qiYRF0tss76h6kJCbpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhnKsKnEm688A2lIJK5OKK7i14OumJwiQ8SwfQUw2389RfvlxL
	tRVRNRQr12+LVt/hoae9U2cxoL0mkZaF5I4FIbc5fpMzLBn2CWL1jO0=
X-Gm-Gg: ASbGnct7uAyly7I3GHzkg647aBes3/i2kW/uWSEjxdE/0Cop/vRK1DxpzpL+u4fEDFT
	dV4/INFvxUn1gMAxAxV8Uh49dT0VVWXzX2Gcgf0iGKbJYTMavjhbd1RYdMlvtX9PJvPdiAHr4fE
	yta3Rv587u6KZ7/GolS77/tHwY1U5FBj2v9CVt9gd5x5hIiJAA5KGbryrb32iq0dEOhXWDReMV3
	DrHA3CfSQazNhkaPHgexQnME2EV/WGpdIfAhgvCknzW9O7+P93ZY6xWt3cG/KMO8pnnap0laoFI
	nPLMajexZQpJICiLrKjTy15sfJkjOn5skQkZAjlQb5blgG9bygOkmKASXwrjw8AP8lHiDw6qA/Y
	DtDvCFAz7fQbEb8SxW3x/xbo=
X-Google-Smtp-Source: AGHT+IHgUWHhMp60x3Ry5mbAwE5jMeIO/TBgIb7bpCThFlc22fwjDxS3HmrwkLT1tmhjc/vYEkz3pw==
X-Received: by 2002:a05:6a00:478c:b0:748:e0ee:dcff with SMTP id d2e1a72fcca58-748e0eee3a9mr4940243b3a.11.1750272287238;
        Wed, 18 Jun 2025 11:44:47 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-748e5b620f2sm2248409b3a.50.2025.06.18.11.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 11:44:46 -0700 (PDT)
Date: Wed, 18 Jun 2025 11:44:46 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jordan Rife <jordan@jrife.io>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [RESEND PATCH v2 bpf-next 02/12] bpf: tcp: Make sure iter->batch
 always contains a full bucket snapshot
Message-ID: <aFMJHoasszw3x2kX@mini-arch>
References: <20250618162545.15633-1-jordan@jrife.io>
 <20250618162545.15633-3-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250618162545.15633-3-jordan@jrife.io>

On 06/18, Jordan Rife wrote:
> Require that iter->batch always contains a full bucket snapshot. This
> invariant is important to avoid skipping or repeating sockets during
> iteration when combined with the next few patches. Before, there were
> two cases where a call to bpf_iter_tcp_batch may only capture part of a
> bucket:
> 
> 1. When bpf_iter_tcp_realloc_batch() returns -ENOMEM.
> 2. When more sockets are added to the bucket while calling
>    bpf_iter_tcp_realloc_batch(), making the updated batch size
>    insufficient.
> 
> In cases where the batch size only covers part of a bucket, it is
> possible to forget which sockets were already visited, especially if we
> have to process a bucket in more than two batches. This forces us to
> choose between repeating or skipping sockets, so don't allow this:
> 
> 1. Stop iteration and propagate -ENOMEM up to userspace if reallocation
>    fails instead of continuing with a partial batch.
> 2. Try bpf_iter_tcp_realloc_batch() with GFP_USER just as before, but if
>    we still aren't able to capture the full bucket, call
>    bpf_iter_tcp_realloc_batch() again while holding the bucket lock to
>    guarantee the bucket does not change. On the second attempt use
>    GFP_NOWAIT since we hold onto the spin lock.
> 
> I did some manual testing to exercise the code paths where GFP_NOWAIT is
> used and where ERR_PTR(err) is returned. I used the realloc test cases
> included later in this series to trigger a scenario where a realloc
> happens inside bpf_iter_tcp_batch and made a small code tweak to force
> the first realloc attempt to allocate a too-small batch, thus requiring
> another attempt with GFP_NOWAIT. Some printks showed both reallocs with
> the tests passing:
> 
> May 09 18:18:55 crow kernel: resize batch TCP_SEQ_STATE_LISTENING
> May 09 18:18:55 crow kernel: again GFP_USER
> May 09 18:18:55 crow kernel: resize batch TCP_SEQ_STATE_LISTENING
> May 09 18:18:55 crow kernel: again GFP_NOWAIT
> May 09 18:18:57 crow kernel: resize batch TCP_SEQ_STATE_ESTABLISHED
> May 09 18:18:57 crow kernel: again GFP_USER
> May 09 18:18:57 crow kernel: resize batch TCP_SEQ_STATE_ESTABLISHED
> May 09 18:18:57 crow kernel: again GFP_NOWAIT
> 
> With this setup, I also forced each of the bpf_iter_tcp_realloc_batch
> calls to return -ENOMEM to ensure that iteration ends and that the
> read() in userspace fails.
> 
> Signed-off-by: Jordan Rife <jordan@jrife.io>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/ipv4/tcp_ipv4.c | 96 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 68 insertions(+), 28 deletions(-)
> 
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 2e40af6aff37..69c976a07434 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -3057,7 +3057,10 @@ static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
>  	if (!new_batch)
>  		return -ENOMEM;
>  
> -	bpf_iter_tcp_put_batch(iter);
> +	if (flags != GFP_NOWAIT)
> +		bpf_iter_tcp_put_batch(iter);
> +
> +	memcpy(new_batch, iter->batch, sizeof(*iter->batch) * iter->end_sk);
>  	kvfree(iter->batch);
>  	iter->batch = new_batch;
>  	iter->max_sk = new_batch_sz;
> @@ -3066,69 +3069,85 @@ static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
>  }
>  
>  static unsigned int bpf_iter_tcp_listening_batch(struct seq_file *seq,
> -						 struct sock *start_sk)
> +						 struct sock **start_sk)
>  {
> -	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
>  	struct bpf_tcp_iter_state *iter = seq->private;
> -	struct tcp_iter_state *st = &iter->state;
>  	struct hlist_nulls_node *node;
>  	unsigned int expected = 1;
>  	struct sock *sk;
>  
> -	sock_hold(start_sk);
> -	iter->batch[iter->end_sk++] = start_sk;
> +	sock_hold(*start_sk);
> +	iter->batch[iter->end_sk++] = *start_sk;
>  
> -	sk = sk_nulls_next(start_sk);
> +	sk = sk_nulls_next(*start_sk);
> +	*start_sk = NULL;
>  	sk_nulls_for_each_from(sk, node) {
>  		if (seq_sk_match(seq, sk)) {
>  			if (iter->end_sk < iter->max_sk) {
>  				sock_hold(sk);
>  				iter->batch[iter->end_sk++] = sk;
> +			} else if (!*start_sk) {
> +				/* Remember where we left off. */
> +				*start_sk = sk;
>  			}
>  			expected++;
>  		}
>  	}
> -	spin_unlock(&hinfo->lhash2[st->bucket].lock);
>  
>  	return expected;
>  }
>  
>  static unsigned int bpf_iter_tcp_established_batch(struct seq_file *seq,
> -						   struct sock *start_sk)
> +						   struct sock **start_sk)
>  {
> -	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
>  	struct bpf_tcp_iter_state *iter = seq->private;
> -	struct tcp_iter_state *st = &iter->state;
>  	struct hlist_nulls_node *node;
>  	unsigned int expected = 1;
>  	struct sock *sk;
>  
> -	sock_hold(start_sk);
> -	iter->batch[iter->end_sk++] = start_sk;
> +	sock_hold(*start_sk);
> +	iter->batch[iter->end_sk++] = *start_sk;
>  
> -	sk = sk_nulls_next(start_sk);
> +	sk = sk_nulls_next(*start_sk);
> +	*start_sk = NULL;
>  	sk_nulls_for_each_from(sk, node) {
>  		if (seq_sk_match(seq, sk)) {
>  			if (iter->end_sk < iter->max_sk) {
>  				sock_hold(sk);
>  				iter->batch[iter->end_sk++] = sk;
> +			} else if (!*start_sk) {
> +				/* Remember where we left off. */
> +				*start_sk = sk;
>  			}
>  			expected++;
>  		}
>  	}
> -	spin_unlock_bh(inet_ehash_lockp(hinfo, st->bucket));
>  
>  	return expected;
>  }
>  
> +static void bpf_iter_tcp_unlock_bucket(struct seq_file *seq)
> +{
> +	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
> +	struct bpf_tcp_iter_state *iter = seq->private;
> +	struct tcp_iter_state *st = &iter->state;
> +
> +	if (st->state == TCP_SEQ_STATE_LISTENING)
> +		spin_unlock(&hinfo->lhash2[st->bucket].lock);
> +	else
> +		spin_unlock_bh(inet_ehash_lockp(hinfo, st->bucket));
> +}
> +
>  static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
>  {
>  	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
>  	struct bpf_tcp_iter_state *iter = seq->private;
>  	struct tcp_iter_state *st = &iter->state;
> +	int prev_bucket, prev_state;
>  	unsigned int expected;
> -	bool resized = false;
> +	int resizes = 0;
>  	struct sock *sk;
> +	int err;
>  
>  	/* The st->bucket is done.  Directly advance to the next
>  	 * bucket instead of having the tcp_seek_last_pos() to skip
> @@ -3149,29 +3168,50 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
>  	/* Get a new batch */
>  	iter->cur_sk = 0;
>  	iter->end_sk = 0;
> -	iter->st_bucket_done = false;
> +	iter->st_bucket_done = true;
>  
> +	prev_bucket = st->bucket;
> +	prev_state = st->state;
>  	sk = tcp_seek_last_pos(seq);
>  	if (!sk)
>  		return NULL; /* Done */
> +	if (st->bucket != prev_bucket || st->state != prev_state)
> +		resizes = 0;
> +	expected = 0;
>  
> +fill_batch:
>  	if (st->state == TCP_SEQ_STATE_LISTENING)
> -		expected = bpf_iter_tcp_listening_batch(seq, sk);
> +		expected += bpf_iter_tcp_listening_batch(seq, &sk);
>  	else
> -		expected = bpf_iter_tcp_established_batch(seq, sk);
> +		expected += bpf_iter_tcp_established_batch(seq, &sk);
>  
> -	if (iter->end_sk == expected) {
> -		iter->st_bucket_done = true;
> -		return sk;
> -	}

[..]

> +	if (unlikely(resizes <= 1 && iter->end_sk != expected)) {
> +		resizes++;
> +
> +		if (resizes == 1) {
> +			bpf_iter_tcp_unlock_bucket(seq);
>  
> -	if (!resized && !bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2,
> -						    GFP_USER)) {
> -		resized = true;
> -		goto again;
> +			err = bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2,
> +							 GFP_USER);
> +			if (err)
> +				return ERR_PTR(err);
> +			goto again;
> +		}
> +
> +		err = bpf_iter_tcp_realloc_batch(iter, expected, GFP_NOWAIT);
> +		if (err) {
> +			bpf_iter_tcp_unlock_bucket(seq);
> +			return ERR_PTR(err);
> +		}
> +
> +		expected = iter->end_sk;
> +		goto fill_batch;

Can we try to unroll this? Add new helpers to hide the repeating parts,
store extra state in iter if needed.

AFAIU, we want the following:
1. find sk, try to fill the batch, if it fits -> bail out
2. try to allocate new batch with GPU_USER, try to fill again -> bail
   out
3. otherwise, attempt GPF_NOWAIT and do that dance where you copy over
   previous partial copy

The conditional put in bpf_iter_tcp_put_batch does not look nice :-(
Same for unconditional memcpy (which, if I understand correctly, only
needed for GFP_NOWAIT case). I'm 99% sure your current version works,
but it's a bit hard to follow :-(

Untested code to illustrate the idea below. Any reason it won't work?

/* fast path */

sk = tcp_seek_last_pos(seq);
if (!sk) return NULL;
fits = bpf_iter_tcp_fill_batch(...);
bpf_iter_tcp_unlock_bucket(iter);
if (fits) return sk;

/* not enough space to store full batch, try to reallocate with GFP_USER */

bpf_iter_tcp_free_batch(iter);

if (bpf_iter_tcp_alloc_batch(iter, GFP_USER)) {
	/* allocated 'expected' size, try to fill again */

	sk = tcp_seek_last_pos(seq);
	if (!sk) return NULL;
	fits = bpf_iter_tcp_fill_batch(...);
	if (fits) {
		bpf_iter_tcp_unlock_bucket(iter);
		return sk;
	}
}

/* the bucket is still locked here, sk points to the correct one,
 * we have a partial result in iter->batch */

old_batch = iter->batch;

if (!bpf_iter_tcp_alloc_batch(iter, GFP_NOWAIT)) {
	/* no luck, bail out */
	bpf_iter_tcp_unlock_bucket(iter);
	bpf_iter_tcp_free_batch(iter); /* or put? */
	return ERR_PTR(-ENOMEM);
}

if (old_batch) {
	/* copy partial result from the previous run if needed? */
	memcpy(iter->batch, old_batch, ...);
	kvfree(old_batch);
}

/* TODO: somehow fill the remainder */

bpf_iter_tcp_unlock_bucket(iter);
return ..;

....

bool bpf_iter_tcp_fill_batch(...)
{
	if (st->state == TCP_SEQ_STATE_LISTENING)
		expected = bpf_iter_tcp_listening_batch(seq, sk);
	else
		expected = bpf_iter_tcp_established_batch(seq, sk);

	/* TODO: store expected into the iter for future resizing */
	/* TODO: make bpf_iter_tcp_xxx_batch store start_sk in iter */

	if (iter->end_sk == expected) {
		iter->st_bucket_done = true;
		return true;
	}

	return false;
}

bool bpf_iter_tcp_free_batch(...)
{
	bpf_iter_tcp_put_batch(iter);
	kvfree(iter->batch);
	iter->batch = NULL;
}




