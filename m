Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9661E6A6009
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 20:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjB1T65 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 14:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjB1T64 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 14:58:56 -0500
Received: from out-10.mta0.migadu.com (out-10.mta0.migadu.com [IPv6:2001:41d0:1004:224b::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE62A21950
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 11:58:51 -0800 (PST)
Message-ID: <22705f9d-9b94-a4ec-3202-270fef1ed657@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677614330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dwqlDZm1FFyvhq2qKAm9Hyvy8dUaUZ1MsnNj2aCGRJg=;
        b=CeI+j4QX0rkubqTicN8PmgoWnM3GtT5C0TcLUdQqEEXjb6qtV2X6YLL/BXmwWyt0cNw/NK
        JRbgy4mRsVxhD16itS/Sh1/R5vxuftsfzXuDO7lL9VS6LZeKyNFHh+5OyMoOI+CwtCqaTq
        aigZAGWnlYtdd+d5Na/++Mi6B2lX5Gc=
Date:   Tue, 28 Feb 2023 11:58:46 -0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 1/3] bpf: Implement batching in UDP iterator
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20230223215311.926899-1-aditi.ghag@isovalent.com>
 <20230223215311.926899-2-aditi.ghag@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230223215311.926899-2-aditi.ghag@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/23/23 1:53 PM, Aditi Ghag wrote:
> +struct bpf_udp_iter_state {
> +	struct udp_iter_state state;
> +	unsigned int cur_sk;
> +	unsigned int end_sk;
> +	unsigned int max_sk;
> +	struct sock **batch;
> +	bool st_bucket_done;
> +};
> +
> +static unsigned short seq_file_family(const struct seq_file *seq);
> +static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
> +				      unsigned int new_batch_sz);
> +
> +static inline bool seq_sk_match(struct seq_file *seq, const struct sock *sk)
> +{
> +	unsigned short family = seq_file_family(seq);
> +
> +	/* AF_UNSPEC is used as a match all */
> +	return ((family == AF_UNSPEC || family == sk->sk_family) &&
> +		net_eq(sock_net(sk), seq_file_net(seq)));
> +}
> +
> +static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
> +{
> +	struct bpf_udp_iter_state *iter = seq->private;
> +	struct udp_iter_state *state = &iter->state;
> +	struct net *net = seq_file_net(seq);
> +	struct udp_seq_afinfo *afinfo = state->bpf_seq_afinfo;
> +	struct udp_table *udptable;
> +	struct sock *first_sk = NULL;
> +	struct sock *sk;
> +	unsigned int bucket_sks = 0;
> +	bool first;
> +	bool resized = false;
> +
> +	/* The current batch is done, so advance the bucket. */
> +	if (iter->st_bucket_done)
> +		state->bucket++;
> +
> +	udptable = udp_get_table_afinfo(afinfo, net);
> +
> +again:
> +	/* New batch for the next bucket.
> +	 * Iterate over the hash table to find a bucket with sockets matching
> +	 * the iterator attributes, and return the first matching socket from
> +	 * the bucket. The remaining matched sockets from the bucket are batched
> +	 * before releasing the bucket lock. This allows BPF programs that are
> +	 * called in seq_show to acquire the bucket lock if needed.
> +	 */
> +	iter->cur_sk = 0;
> +	iter->end_sk = 0;
> +	iter->st_bucket_done = false;
> +	first = true;
> +
> +	for (; state->bucket <= udptable->mask; state->bucket++) {
> +		struct udp_hslot *hslot = &udptable->hash[state->bucket];

Since it is mostly separated from the proc's udp-seq-file now, may as well 
iterate the udptable->hash"2" which is hashed by both addr and port such that 
each batch should be smaller.

> +
> +		if (hlist_empty(&hslot->head))
> +			continue;
> +
> +		spin_lock_bh(&hslot->lock);
> +		sk_for_each(sk, &hslot->head) {
> +			if (seq_sk_match(seq, sk)) {
> +				if (first) {
> +					first_sk = sk;
> +					first = false;
> +				}
> +				if (iter->end_sk < iter->max_sk) {
> +					sock_hold(sk);
> +					iter->batch[iter->end_sk++] = sk;
> +				}
> +				bucket_sks++;
> +			}
> +		}
> +		spin_unlock_bh(&hslot->lock);
> +		if (first_sk)
> +			break;
> +	}
> +
> +	/* All done: no batch made. */
> +	if (!first_sk)
> +		return NULL;

I think first_sk and bucket_sks need to be reset on the "again" case also?

If bpf_iter_udp_seq_stop() is called before a batch has been fully processed by 
the bpf prog in ".show", how does the next bpf_iter_udp_seq_start() continue 
from where it left off? The bpf_tcp_iter remembers the bucket and the 
offset-in-this-bucket. I think bpf_udp_iter can do something similar.

> +
> +	if (iter->end_sk == bucket_sks) {
> +		/* Batching is done for the current bucket; return the first
> +		 * socket to be iterated from the batch.
> +		 */
> +		iter->st_bucket_done = true;
> +		return first_sk;
> +	}
> +	if (!resized && !bpf_iter_udp_realloc_batch(iter, bucket_sks * 3 / 2)) {
> +		resized = true;
> +		/* Go back to the previous bucket to resize its batch. */
> +		state->bucket--;
> +		goto again;
> +	}
> +	return first_sk;
> +}
> +

[ ... ]

>   static int bpf_iter_init_udp(void *priv_data, struct bpf_iter_aux_info *aux)
>   {
> -	struct udp_iter_state *st = priv_data;
> +	struct bpf_udp_iter_state *iter = priv_data;
> +	struct udp_iter_state *st = &iter->state;
>   	struct udp_seq_afinfo *afinfo;
>   	int ret;
>   
> @@ -3427,24 +3623,34 @@ static int bpf_iter_init_udp(void *priv_data, struct bpf_iter_aux_info *aux)
>   	afinfo->udp_table = NULL;
>   	st->bpf_seq_afinfo = afinfo;

Is bpf_seq_afinfo still needed in 'struct udp_iter_state'? Can it be removed?

>   	ret = bpf_iter_init_seq_net(priv_data, aux);
> -	if (ret)
> +	if (ret) {
>   		kfree(afinfo);
> +		return ret;
> +	}
> +	ret = bpf_iter_udp_realloc_batch(iter, INIT_BATCH_SZ);
> +	if (ret) {
> +		bpf_iter_fini_seq_net(priv_data);
> +		return ret;
> +	}
> +	iter->cur_sk = 0;
> +	iter->end_sk = 0;
> +
>   	return ret;
>   }
>   
>   static void bpf_iter_fini_udp(void *priv_data)
>   {
> -	struct udp_iter_state *st = priv_data;
> +	struct bpf_udp_iter_state *iter = priv_data;
>   
> -	kfree(st->bpf_seq_afinfo);
>   	bpf_iter_fini_seq_net(priv_data);
> +	kfree(iter->batch);
kvfree

