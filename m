Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021396D29CA
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 23:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjCaVIm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 17:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjCaVIl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 17:08:41 -0400
Received: from out-22.mta1.migadu.com (out-22.mta1.migadu.com [IPv6:2001:41d0:203:375::16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B6B1D843
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 14:08:39 -0700 (PDT)
Message-ID: <acdafa2f-b127-5a5a-84f7-0a046e1ce0fa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680296918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ySMpXOZN3/XiDn62FRTJHRMoPTQijrA3xrT7wOPT29g=;
        b=pghRtHoCrtmvQ4h1k0YWHmbfrsFUC/fUhoTZsxXGlySrRxPIBwY2hTpoMXy93zf/WHCHNC
        jWbJVb7hhkI/0Hc9MJG/U1OttLDd8DI7ZmUw3seid/6x241OTh5uHQe2AY76o36s3Lbdft
        U5z0et3MIRj3WASeFfi4025Ax0phid8=
Date:   Fri, 31 Mar 2023 14:08:35 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v5 bpf-next 4/7] bpf: udp: Implement batching for sockets
 iterator
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20230330151758.531170-1-aditi.ghag@isovalent.com>
 <20230330151758.531170-5-aditi.ghag@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230330151758.531170-5-aditi.ghag@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/30/23 8:17 AM, Aditi Ghag wrote:
> +static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
> +				      unsigned int new_batch_sz);
>   
>   static inline bool seq_sk_match(struct seq_file *seq, const struct sock *sk)
>   {
> @@ -3151,6 +3163,149 @@ static inline bool seq_sk_match(struct seq_file *seq, const struct sock *sk)
>   		net_eq(sock_net(sk), seq_file_net(seq)));
>   }
>   
> +static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
> +{
> +	struct bpf_udp_iter_state *iter = seq->private;
> +	struct udp_iter_state *state = &iter->state;
> +	struct net *net = seq_file_net(seq);
> +	struct sock *first_sk = NULL;
> +	struct udp_seq_afinfo afinfo;
> +	struct udp_table *udptable;
> +	unsigned int batch_sks = 0;
> +	bool resized = false;
> +	struct sock *sk;
> +	int offset = 0;
> +	int new_offset;
> +
> +	/* The current batch is done, so advance the bucket. */
> +	if (iter->st_bucket_done) {
> +		state->bucket++;
> +		iter->offset = 0;
> +	}
> +
> +	afinfo.family = AF_UNSPEC;
> +	afinfo.udp_table = NULL;
> +	udptable = udp_get_table_afinfo(&afinfo, net);
> +
> +	if (state->bucket > udptable->mask) {

This test looks unnecessary. The for-loop below should take care of this case?

> +		state->bucket = 0;

Reset state->bucket here looks suspicious (or at least unnecessary) also. The 
iterator cannot restart from the beginning. or I am missing something here? This 
at least requires a comment if it is really needed.

> +		iter->offset = 0;
> +		return NULL;
> +	}
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
> +	first_sk = NULL;
> +	batch_sks = 0;
> +	offset = iter->offset;
> +
> +	for (; state->bucket <= udptable->mask; state->bucket++) {
> +		struct udp_hslot *hslot2 = &udptable->hash2[state->bucket];
> +
> +		if (hlist_empty(&hslot2->head)) {
> +			offset = 0;
> +			continue;
> +		}
> +		new_offset = offset;
> +
> +		spin_lock_bh(&hslot2->lock);
> +		udp_portaddr_for_each_entry(sk, &hslot2->head) {
> +			if (seq_sk_match(seq, sk)) {
> +				/* Resume from the last iterated socket at the
> +				 * offset in the bucket before iterator was stopped.
> +				 */
> +				if (offset) {
> +					--offset;
> +					continue;
> +				}
> +				if (!first_sk)
> +					first_sk = sk;
> +				if (iter->end_sk < iter->max_sk) {
> +					sock_hold(sk);
> +					iter->batch[iter->end_sk++] = sk;
> +				}
> +				batch_sks++;
> +				new_offset++;
> +			}
> +		}
> +		spin_unlock_bh(&hslot2->lock);
> +
> +		if (first_sk)
> +			break;
> +
> +		/* Reset the current bucket's offset before moving to the next bucket. */
> +		offset = 0;
> +	}
> +
> +	/* All done: no batch made. */
> +	if (!first_sk)

Testing !iter->end_sk should be the same?

> +		goto ret;
> +
> +	if (iter->end_sk == batch_sks) {
> +		/* Batching is done for the current bucket; return the first
> +		 * socket to be iterated from the batch.
> +		 */
> +		iter->st_bucket_done = true;
> +		goto ret;
> +	}
> +	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2)) {
> +		resized = true;
> +		/* Go back to the previous bucket to resize its batch. */
> +		state->bucket--;
> +		goto again;
> +	}
> +ret:
> +	iter->offset = new_offset;

hmm... updating iter->offset looks not right and,
does it need a new_offset?

afaict, either

a) it can resume at the old bucket. In this case, the iter->offset should not 
change.

or

b) it moved to the next bucket and iter->offset should be 0.

> +	return first_sk;

&iter->batch[0] is the first_sk. 'first_sk' variable is not needed then.

