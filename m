Return-Path: <bpf+bounces-61881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA37AEE6CB
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 20:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C36F17FC4A
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 18:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E93F28EA63;
	Mon, 30 Jun 2025 18:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMfg2bID"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5A672633;
	Mon, 30 Jun 2025 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751308351; cv=none; b=huOWqTebpeRxeb1iLeqA7P2g/DHZWkfpvceWaQIjJire35T8bS8Lgvrih50z6Z7yXRKaW/QxblQJqBVBbgGaT5guxR6+3mC6+4HMaG8i0ZE15PzJOOCg8hhnfDaPmy8azaoFE4Jqn6lNT/ytugaqAFse+ijV8Nya/jlvGEiKqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751308351; c=relaxed/simple;
	bh=Salh/VHMbtycSzoPqIajkabOPs07fOqfmzyqls6BrmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JntJz1SeWwR7KxbYjx9ixYU5OEIGVkCBqXqvlGX77HwrAtRFbaNWWGe3n2GNRYwpi/YXdvJY5DDs13JrvnQC8zOEJVmUweQXzW/raBUq7qR8JjecvZTewfNey0RxTf5cPm6cnfBXo8cK2SARTdrUamFFGAgbQzybdYbgIsX9TiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMfg2bID; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3139027b825so1565655a91.0;
        Mon, 30 Jun 2025 11:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751308349; x=1751913149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nzHppzHF1hYK3tcQHZ7vGbIhpCCI6RBfGbgRX3g2/7k=;
        b=BMfg2bIDK3vmPwB7NU/nn3PVH7wDWfzSvoliGGqV8ktbisd5IM0vIrGzYan7WR0ms5
         C/EIL3C9x/zrMicUHprzWMmzTXFjujzq0kmlhjEnOmuQOWBZWsg6NJZToLgvRBQK4fp2
         BAZvZ41vads7CBItEqS8hceqkLrafpcitiNphC4/T28TWE9pzpgJ+Ee9dx/ZQ7XO/HXw
         wy3RHt9DwHF+Tkyt2DT+drAj21NuPvCEzAQNXfUgLjW4vN7cOWrhngvaqptSz9PYRPJJ
         YJrtdF20AxX9/R+qqAbAfgef/Nai6JNIK3zeSg+IbmaD/Eo5AHrKVdXzt61SIYMVrE+J
         /Feg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751308349; x=1751913149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzHppzHF1hYK3tcQHZ7vGbIhpCCI6RBfGbgRX3g2/7k=;
        b=kXX4MZanDO9oriW8lOcoqX150GbLzkPY/2X7m8pWWTzKnHetINXV37TciLc+O8m1sz
         Mn9VfFPprx3Eyv46VoZaucIigbktfMVrtsoupgX/YwIKn0rIdQgXDwTtN0rnPAuu8IRt
         vnzxdB1O/p953Ao0p6IUUAYa0U7thvNVKuqCnLPBAyKCvXQmWFOC+IlO/1pAKD6wSj0s
         kK2+2YlJwhx32ubBEIl8UAwNPBuIjKlGlhRnPzfTIcQX+qRUG+MRYBM81DW8pu890kgW
         I4QKY6QTejw1Ime5P1jPRQOYJ8gNiT0jiATW088AAxZeid5/oQ3VpkaKZQ3J6GHKGeX8
         gopg==
X-Forwarded-Encrypted: i=1; AJvYcCWpWURtcOVDRvm8Fb1JCpu0YYaq8gNMOfEkEKeuT6QZPoH2HVI7UzH2hEsIbXx562zxyC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtEz8uzwHdwxADPAae6OAoyAa+3YRJdSvManbvVuH9HLSWSWaO
	DvrZlV4jRUxAudGvmBTOUgkl68EGtBAxlBGCqi4fjxhESPi7WryoettQoOU6
X-Gm-Gg: ASbGncsEigR3mYaoLyEmrY0K4v2c1lo2La8JR7EQTTipHQM1SjzCeZID69orriS4maz
	zH4uzkJ/AgvoKtHt23cJLh40HhcXRHPhvtyHOhwkZYNzVGndmeG5HDiMmiAtl2ecrk4MKMy9c5O
	Qizmwn0oa6Gkd1d4krUXq2i5kR3Z+XHxM8MUpDeV5KO6dSgY7PDw6+TUGUfGRc7CZCHgqINV1Pk
	RONRh+6ECxHQ4UrJEdmAvT4K+xkSyP6/1v1G8lmBykG5MyjlzCJ/bmm8rAoxYT5OOKvGfL4D3uc
	iN0bmKzLl7dcZwnCXwOHZL9r+yPw9wqpZrcGytZ+9EoXXE7MLZKv8C6qn6X44rQdO+6dWRZ19Hl
	6oVy5Q74VbM+MdrgrfbuoZNs=
X-Google-Smtp-Source: AGHT+IEowxIEzMOW7TPbht1Hn/XpSUFDDDaz8MtqCvCHszWs498CHygHhno7tPH/jhlxr3ikeov/qw==
X-Received: by 2002:a17:90b:3d12:b0:313:15fe:4c13 with SMTP id 98e67ed59e1d1-318c92f8000mr19926906a91.27.1751308348592;
        Mon, 30 Jun 2025 11:32:28 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-318c14fbebdsm9978987a91.33.2025.06.30.11.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 11:32:28 -0700 (PDT)
Date: Mon, 30 Jun 2025 11:32:27 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jordan Rife <jordan@jrife.io>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v3 bpf-next 05/12] bpf: tcp: Avoid socket skips and
 repeats during iteration
Message-ID: <aGLYO7XRafb9ROQi@mini-arch>
References: <20250630171709.113813-1-jordan@jrife.io>
 <20250630171709.113813-6-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630171709.113813-6-jordan@jrife.io>

On 06/30, Jordan Rife wrote:
> Replace the offset-based approach for tracking progress through a bucket
> in the TCP table with one based on socket cookies. Remember the cookies
> of unprocessed sockets from the last batch and use this list to
> pick up where we left off or, in the case that the next socket
> disappears between reads, find the first socket after that point that
> still exists in the bucket and resume from there.
> 
> This approach guarantees that all sockets that existed when iteration
> began and continue to exist throughout will be visited exactly once.
> Sockets that are added to the table during iteration may or may not be
> seen, but if they are they will be seen exactly once.
> 
> Signed-off-by: Jordan Rife <jordan@jrife.io>
> ---
>  net/ipv4/tcp_ipv4.c | 147 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 115 insertions(+), 32 deletions(-)
> 
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index bb51d62066a4..510053836a3c 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -58,6 +58,7 @@
>  #include <linux/times.h>
>  #include <linux/slab.h>
>  #include <linux/sched.h>
> +#include <linux/sock_diag.h>
>  
>  #include <net/net_namespace.h>
>  #include <net/icmp.h>
> @@ -3016,6 +3017,7 @@ static int tcp4_seq_show(struct seq_file *seq, void *v)
>  #ifdef CONFIG_BPF_SYSCALL
>  union bpf_tcp_iter_batch_item {
>  	struct sock *sk;
> +	__u64 cookie;
>  };
>  
>  struct bpf_tcp_iter_state {
> @@ -3046,10 +3048,19 @@ static int tcp_prog_seq_show(struct bpf_prog *prog, struct bpf_iter_meta *meta,
>  
>  static void bpf_iter_tcp_put_batch(struct bpf_tcp_iter_state *iter)
>  {
> +	union bpf_tcp_iter_batch_item *item;
>  	unsigned int cur_sk = iter->cur_sk;
> +	__u64 cookie;
>  
> -	while (cur_sk < iter->end_sk)
> -		sock_gen_put(iter->batch[cur_sk++].sk);
> +	/* Remember the cookies of the sockets we haven't seen yet, so we can
> +	 * pick up where we left off next time around.
> +	 */
> +	while (cur_sk < iter->end_sk) {
> +		item = &iter->batch[cur_sk++];
> +		cookie = sock_gen_cookie(item->sk);
> +		sock_gen_put(item->sk);
> +		item->cookie = cookie;
> +	}
>  }
>  
>  static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
> @@ -3070,6 +3081,106 @@ static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
>  	return 0;
>  }
>  
> +static struct sock *bpf_iter_tcp_resume_bucket(struct sock *first_sk,
> +					       union bpf_tcp_iter_batch_item *cookies,
> +					       int n_cookies)
> +{
> +	struct hlist_nulls_node *node;
> +	struct sock *sk;
> +	int i;
> +
> +	for (i = 0; i < n_cookies; i++) {
> +		sk = first_sk;
> +		sk_nulls_for_each_from(sk, node) {
> +			if (cookies[i].cookie == atomic64_read(&sk->sk_cookie))
> +				return sk;
> +		}

nit: let's drop {} around sk_nulls_for_each_from?

> +	}
> +
> +	return NULL;
> +}
> +
> +static struct sock *bpf_iter_tcp_resume_listening(struct seq_file *seq)
> +{
> +	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
> +	struct bpf_tcp_iter_state *iter = seq->private;
> +	struct tcp_iter_state *st = &iter->state;
> +	unsigned int find_cookie = iter->cur_sk;
> +	unsigned int end_cookie = iter->end_sk;
> +	int resume_bucket = st->bucket;
> +	struct sock *sk;
> +
> +	if (end_cookie && find_cookie == end_cookie)
> +		++st->bucket;
> +
> +	sk = listening_get_first(seq);
> +	iter->cur_sk = 0;
> +	iter->end_sk = 0;
> +
> +	if (sk && st->bucket == resume_bucket && end_cookie) {
> +		sk = bpf_iter_tcp_resume_bucket(sk, &iter->batch[find_cookie],
> +						end_cookie - find_cookie);
> +		if (!sk) {
> +			spin_unlock(&hinfo->lhash2[st->bucket].lock);
> +			++st->bucket;
> +			sk = listening_get_first(seq);
> +		}
> +	}
> +
> +	return sk;
> +}
> +
> +static struct sock *bpf_iter_tcp_resume_established(struct seq_file *seq)
> +{
> +	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
> +	struct bpf_tcp_iter_state *iter = seq->private;
> +	struct tcp_iter_state *st = &iter->state;
> +	unsigned int find_cookie = iter->cur_sk;
> +	unsigned int end_cookie = iter->end_sk;
> +	int resume_bucket = st->bucket;
> +	struct sock *sk;
> +
> +	if (end_cookie && find_cookie == end_cookie)
> +		++st->bucket;
> +
> +	sk = established_get_first(seq);
> +	iter->cur_sk = 0;
> +	iter->end_sk = 0;
> +
> +	if (sk && st->bucket == resume_bucket && end_cookie) {
> +		sk = bpf_iter_tcp_resume_bucket(sk, &iter->batch[find_cookie],
> +						end_cookie - find_cookie);
> +		if (!sk) {
> +			spin_unlock_bh(inet_ehash_lockp(hinfo, st->bucket));
> +			++st->bucket;
> +			sk = established_get_first(seq);
> +		}
> +	}
> +
> +	return sk;
> +}
> +
> +static struct sock *bpf_iter_tcp_resume(struct seq_file *seq)
> +{
> +	struct bpf_tcp_iter_state *iter = seq->private;
> +	struct tcp_iter_state *st = &iter->state;
> +	struct sock *sk = NULL;
> +
> +	switch (st->state) {
> +	case TCP_SEQ_STATE_LISTENING:
> +		sk = bpf_iter_tcp_resume_listening(seq);
> +		if (sk)
> +			break;
> +		st->bucket = 0;
> +		st->state = TCP_SEQ_STATE_ESTABLISHED;
> +		fallthrough;
> +	case TCP_SEQ_STATE_ESTABLISHED:
> +		sk = bpf_iter_tcp_resume_established(seq);

nit: add break here for consistency?

