Return-Path: <bpf+bounces-55366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D64CA7C6B5
	for <lists+bpf@lfdr.de>; Sat,  5 Apr 2025 01:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28F61784A0
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 23:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B2521D5AF;
	Fri,  4 Apr 2025 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ktLwtKT9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A04EAE7;
	Fri,  4 Apr 2025 23:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743808965; cv=none; b=oWxzzX8iLHT1CyHtudkbBcXxGN8/4oo4qRlA3dFrQVU9YhJzp/GXI6DKl2YC4DipcYo8wQ0EXiDCFvPek8bcBuDlQPzvC8RKH9u57qUtdHbkvZTjwVdoLuLOrYjlNneaI1CLfw0Zb8JcS6zMOOtoXOOdJlP1dW5z7zDkq9pktuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743808965; c=relaxed/simple;
	bh=DCJwockPjSgSVANznGr7bP1PlhZ+H2HmQ5bKVxniXmc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqTfWP8RJIrQMcM6uMN+G9+zeuABx0pVsdJjYF0UU1TKfDuCj12KVwgSP5aBdXTJwLeyxMxlqMvIkUmVVeLU2jxl/5BtCi+jYXzgSc2buvcITx2mNPba5TrueIIWFMaqMlBXTs+9nNpqM58+S0/SFJwT1ApnV754f6CwIiLgE4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ktLwtKT9; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743808964; x=1775344964;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gJi8rWyshj50rrKLyog0iuMa0CsLBBx8twMR4u7SJZw=;
  b=ktLwtKT97O7lEjOL1zDcVeQeR//Eyq7VtzoZYejQJDhUCVnl6ylgZ72+
   8yB+9VHRMHfGeJNVt0mR+uyfQIbfsz2M4tt+4gDMNIlziphAzKZMLl+DO
   yCB8BR+0NV3RIsD8BHzX+gPmHPeqRZN6f9E/eydjLP+P2lqpp7p4S6PeS
   s=;
X-IronPort-AV: E=Sophos;i="6.15,189,1739836800"; 
   d="scan'208";a="285813698"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 23:22:41 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:30356]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.132:2525] with esmtp (Farcaster)
 id 6efb1a96-6546-4e5e-9043-43f6918ee385; Fri, 4 Apr 2025 23:22:40 +0000 (UTC)
X-Farcaster-Flow-ID: 6efb1a96-6546-4e5e-9043-43f6918ee385
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 4 Apr 2025 23:22:39 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 4 Apr 2025 23:22:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jordan@jrife.io>
CC: <aditi.ghag@isovalent.com>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
	<martin.lau@linux.dev>, <netdev@vger.kernel.org>,
	<willemdebruijn.kernel@gmail.com>, <kuniyu@amazon.com>
Subject: Re: [RFC PATCH bpf-next 2/3] bpf: udp: Avoid socket skips and repeats during iteration
Date: Fri, 4 Apr 2025 16:20:26 -0700
Message-ID: <20250404232228.99744-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250404220221.1665428-3-jordan@jrife.io>
References: <20250404220221.1665428-3-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jordan Rife <jordan@jrife.io>
Date: Fri,  4 Apr 2025 15:02:17 -0700
> Replace the offset-based approach for tracking progress through a bucket
> in the UDP table with one based on socket cookies. Remember the cookies
> of unprocessed sockets from the last batch and use this list to
> pick up where we left off or, in the case that the next socket
> disappears between reads, find the first socket after that point that
> still exists in the bucket and resume from there.
> 
> In order to make the control flow a bit easier to follow inside
> bpf_iter_udp_batch, introduce the udp_portaddr_for_each_entry_from macro
> and use this to split bucket processing into two stages: finding the
> starting point and adding items to the next batch. Originally, I
> implemented this patch inside a single udp_portaddr_for_each_entry loop,
> as it was before, but I found the resulting logic a bit messy. Overall,
> this version seems more readable.
> 
> Signed-off-by: Jordan Rife <jordan@jrife.io>
> ---
>  include/linux/udp.h |  3 ++
>  net/ipv4/udp.c      | 78 ++++++++++++++++++++++++++++++++++-----------
>  2 files changed, 63 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/udp.h b/include/linux/udp.h
> index 0807e21cfec9..a69da9c4c1c5 100644
> --- a/include/linux/udp.h
> +++ b/include/linux/udp.h
> @@ -209,6 +209,9 @@ static inline void udp_allow_gso(struct sock *sk)
>  #define udp_portaddr_for_each_entry(__sk, list) \
>  	hlist_for_each_entry(__sk, list, __sk_common.skc_portaddr_node)
>  
> +#define udp_portaddr_for_each_entry_from(__sk) \
> +	hlist_for_each_entry_from(__sk, __sk_common.skc_portaddr_node)
> +
>  #define udp_portaddr_for_each_entry_rcu(__sk, list) \
>  	hlist_for_each_entry_rcu(__sk, list, __sk_common.skc_portaddr_node)
>  
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 59c3281962b9..00cec269c149 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -93,6 +93,7 @@
>  #include <linux/inet.h>
>  #include <linux/netdevice.h>
>  #include <linux/slab.h>
> +#include <linux/sock_diag.h>
>  #include <net/tcp_states.h>
>  #include <linux/skbuff.h>
>  #include <linux/proc_fs.h>
> @@ -3386,6 +3387,7 @@ struct bpf_iter__udp {
>  
>  union bpf_udp_iter_batch_item {
>  	struct sock *sock;
> +	__u64 cookie;
>  };
>  
>  struct bpf_udp_iter_state {
> @@ -3393,26 +3395,42 @@ struct bpf_udp_iter_state {
>  	unsigned int cur_sk;
>  	unsigned int end_sk;
>  	unsigned int max_sk;
> -	int offset;
>  	union bpf_udp_iter_batch_item *batch;
>  	bool st_bucket_done;
>  };
>  
>  static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
>  				      unsigned int new_batch_sz);
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

We may need to iterate all visited sockets again in this bucket if all
unvisited sockets disappear from the previous iteration.

When the number of the unvisited sockets is small like 1, the duplicated
records will not be rare and rather more often than before ?


> +}
> +
>  static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>  {
>  	struct bpf_udp_iter_state *iter = seq->private;
>  	struct udp_iter_state *state = &iter->state;
> +	unsigned int find_cookie, end_cookie = 0;
>  	struct net *net = seq_file_net(seq);
> -	int resume_bucket, resume_offset;
>  	struct udp_table *udptable;
>  	unsigned int batch_sks = 0;
>  	bool resized = false;
> +	int resume_bucket;
>  	struct sock *sk;
>  
>  	resume_bucket = state->bucket;
> -	resume_offset = iter->offset;
>  
>  	/* The current batch is done, so advance the bucket. */
>  	if (iter->st_bucket_done)
> @@ -3428,6 +3446,8 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>  	 * before releasing the bucket lock. This allows BPF programs that are
>  	 * called in seq_show to acquire the bucket lock if needed.
>  	 */
> +	find_cookie = iter->cur_sk;
> +	end_cookie = iter->end_sk;
>  	iter->cur_sk = 0;
>  	iter->end_sk = 0;
>  	iter->st_bucket_done = false;
> @@ -3439,18 +3459,26 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>  		if (hlist_empty(&hslot2->head))
>  			continue;
>  
> -		iter->offset = 0;
>  		spin_lock_bh(&hslot2->lock);
> -		udp_portaddr_for_each_entry(sk, &hslot2->head) {
> +		/* Initialize sk to the first socket in hslot2. */
> +		udp_portaddr_for_each_entry(sk, &hslot2->head)
> +			break;
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
>  			if (seq_sk_match(seq, sk)) {
> -				/* Resume from the last iterated socket at the
> -				 * offset in the bucket before iterator was stopped.
> -				 */
> -				if (state->bucket == resume_bucket &&
> -				    iter->offset < resume_offset) {
> -					++iter->offset;
> -					continue;
> -				}
>  				if (iter->end_sk < iter->max_sk) {
>  					sock_hold(sk);
>  					iter->batch[iter->end_sk++].sock = sk;
> @@ -3494,10 +3522,8 @@ static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>  	/* Whenever seq_next() is called, the iter->cur_sk is
>  	 * done with seq_show(), so unref the iter->cur_sk.
>  	 */
> -	if (iter->cur_sk < iter->end_sk) {
> +	if (iter->cur_sk < iter->end_sk)
>  		sock_put(iter->batch[iter->cur_sk++].sock);
> -		++iter->offset;
> -	}
>  
>  	/* After updating iter->cur_sk, check if there are more sockets
>  	 * available in the current bucket batch.
> @@ -3567,8 +3593,19 @@ static int bpf_iter_udp_seq_show(struct seq_file *seq, void *v)
>  
>  static void bpf_iter_udp_put_batch(struct bpf_udp_iter_state *iter)
>  {
> -	while (iter->cur_sk < iter->end_sk)
> -		sock_put(iter->batch[iter->cur_sk++].sock);
> +	union bpf_udp_iter_batch_item *item;
> +	unsigned int cur_sk = iter->cur_sk;
> +	__u64 cookie;
> +
> +	/* Remember the cookies of the sockets we haven't seen yet, so we can
> +	 * pick up where we left off next time around.
> +	 */
> +	while (cur_sk < iter->end_sk) {
> +		item = &iter->batch[cur_sk++];
> +		cookie = __sock_gen_cookie(item->sock);
> +		sock_put(item->sock);
> +		item->cookie = cookie;
> +	}
>  }
>  
>  static void bpf_iter_udp_seq_stop(struct seq_file *seq, void *v)
> @@ -3839,6 +3876,11 @@ static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
>  		return -ENOMEM;
>  
>  	bpf_iter_udp_put_batch(iter);
> +	WARN_ON_ONCE(new_batch_sz < iter->max_sk);
> +	/* Make sure the new batch has the cookies of the sockets we haven't
> +	 * visited yet.
> +	 */
> +	memcpy(new_batch, iter->batch, iter->end_sk);
>  	kvfree(iter->batch);
>  	iter->batch = new_batch;
>  	iter->max_sk = new_batch_sz;
> -- 
> 2.43.0
> 

