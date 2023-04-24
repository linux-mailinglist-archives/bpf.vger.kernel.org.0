Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4B36EC504
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 07:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjDXFqy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 01:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDXFqx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 01:46:53 -0400
Received: from out-32.mta0.migadu.com (out-32.mta0.migadu.com [91.218.175.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4BD92
        for <bpf@vger.kernel.org>; Sun, 23 Apr 2023 22:46:48 -0700 (PDT)
Message-ID: <251b0a3f-47d6-d9ad-0c8e-b707fa286c7c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682315206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vDmcv6uyGAnhDJx5mX9MEy483v7hU9sc4J6YESMrcyE=;
        b=HomTK5dtFCTn38BqIUHZzseILB3HVhOvqt+t/yL6LkvLLRSHXEI++Sfw8MXID2oIdeaLRt
        o5MO3/a2K38pL6Vz7DBasYSd+VK6pOr9lL/dva+bStQRcH0++9Al1JhGO5FzXwRFxxv+S9
        Tgw1y3Pk0aJQot3n8vPbFflVC745I3I=
Date:   Sun, 23 Apr 2023 22:46:38 -0700
MIME-Version: 1.0
Subject: Re: [PATCH 4/7] bpf: udp: Implement batching for sockets iterator
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20230418153148.2231644-1-aditi.ghag@isovalent.com>
 <20230418153148.2231644-5-aditi.ghag@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230418153148.2231644-5-aditi.ghag@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/18/23 8:31 AM, Aditi Ghag wrote:
> Batch UDP sockets from BPF iterator that allows for overlapping locking
> semantics in BPF/kernel helpers executed in BPF programs.  This facilitates
> BPF socket destroy kfunc (introduced by follow-up patches) to execute from
> BPF iterator programs.
> 
> Previously, BPF iterators acquired the sock lock and sockets hash table
> bucket lock while executing BPF programs. This prevented BPF helpers that
> again acquire these locks to be executed from BPF iterators.  With the
> batching approach, we acquire a bucket lock, batch all the bucket sockets,
> and then release the bucket lock. This enables BPF or kernel helpers to
> skip sock locking when invoked in the supported BPF contexts.
> 
> The batching logic is similar to the logic implemented in TCP iterator:
> https://lore.kernel.org/bpf/20210701200613.1036157-1-kafai@fb.com/.
> 
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
> ---
>   net/ipv4/udp.c | 209 +++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 203 insertions(+), 6 deletions(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 8689ed171776..f1c001641e53 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -3148,6 +3148,145 @@ struct bpf_iter__udp {
>   	int bucket __aligned(8);
>   };
>   
> +struct bpf_udp_iter_state {
> +	struct udp_iter_state state;
> +	unsigned int cur_sk;
> +	unsigned int end_sk;
> +	unsigned int max_sk;
> +	int offset;
> +	struct sock **batch;
> +	bool st_bucket_done;
> +};
> +
> +static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
> +				      unsigned int new_batch_sz);
> +static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
> +{
> +	struct bpf_udp_iter_state *iter = seq->private;
> +	struct udp_iter_state *state = &iter->state;
> +	struct net *net = seq_file_net(seq);
> +	struct udp_seq_afinfo afinfo;
> +	struct udp_table *udptable;
> +	unsigned int batch_sks = 0;
> +	bool resized = false;
> +	struct sock *sk;
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
> +	batch_sks = 0;
> +
> +	for (; state->bucket <= udptable->mask; state->bucket++) {
> +		struct udp_hslot *hslot2 = &udptable->hash2[state->bucket];
> +
> +		if (hlist_empty(&hslot2->head)) {
> +			iter->offset = 0;
> +			continue;
> +		}
> +
> +		spin_lock_bh(&hslot2->lock);
> +		udp_portaddr_for_each_entry(sk, &hslot2->head) {
> +			if (seq_sk_match(seq, sk)) {
> +				/* Resume from the last iterated socket at the
> +				 * offset in the bucket before iterator was stopped.
> +				 */
> +				if (iter->offset) {
> +					--iter->offset;
> +					continue;
> +				}
> +				if (iter->end_sk < iter->max_sk) {
> +					sock_hold(sk);
> +					iter->batch[iter->end_sk++] = sk;
> +				}
> +				batch_sks++;
> +			}
> +		}
> +		spin_unlock_bh(&hslot2->lock);
> +
> +		if (iter->end_sk)
> +			break;
> +
> +		/* Reset the current bucket's offset before moving to the next bucket. */
> +		iter->offset = 0;
> +	}
> +
> +	/* All done: no batch made. */
> +	if (!iter->end_sk)
> +		return NULL;
> +
> +	if (iter->end_sk == batch_sks) {
> +		/* Batching is done for the current bucket; return the first
> +		 * socket to be iterated from the batch.
> +		 */
> +		iter->st_bucket_done = true;
> +		goto ret;

nit. "ret" is a variable name in some other changes in this patch. How about 
directly "return iter->batch[0];" here or change the label name to something 
else like "done"?

> +	}
> +	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2)) {
> +		resized = true;
> +		/* Go back to the previous bucket to resize its batch. */

nit. I found the "to resize its batch" part confusing. The resize has already 
been done in the above bpf_iter_udp_realloc_batch(). How about something like, 
"After getting a larger max_sk, retry one more time to grab the whole bucket" ?

> +		state->bucket--;
> +		goto again;
> +	}
> +ret:
> +	return iter->batch[0];
> +}
> +
> +static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
> +{
> +	struct bpf_udp_iter_state *iter = seq->private;
> +	struct sock *sk;
> +
> +	/* Whenever seq_next() is called, the iter->cur_sk is
> +	 * done with seq_show(), so unref the iter->cur_sk.
> +	 */
> +	if (iter->cur_sk < iter->end_sk) {
> +		sock_put(iter->batch[iter->cur_sk++]);
> +		++iter->offset;
> +	}
> +
> +	/* After updating iter->cur_sk, check if there are more sockets
> +	 * available in the current bucket batch.
> +	 */
> +	if (iter->cur_sk < iter->end_sk) {
> +		sk = iter->batch[iter->cur_sk];
> +	} else {
> +		// Prepare a new batch.
> +		sk = bpf_iter_udp_batch(seq);
> +	}

nit. remove "{ }" for one liner if-else statement.

> +
> +	++*pos;
> +	return sk;
> +}
> +
> +static void *bpf_iter_udp_seq_start(struct seq_file *seq, loff_t *pos)
> +{
> +	/* bpf iter does not support lseek, so it always
> +	 * continue from where it was stop()-ped.
> +	 */
> +	if (*pos)
> +		return bpf_iter_udp_batch(seq);
> +
> +	return SEQ_START_TOKEN;
> +}
> +
>   static int udp_prog_seq_show(struct bpf_prog *prog, struct bpf_iter_meta *meta,
>   			     struct udp_sock *udp_sk, uid_t uid, int bucket)
>   {
> @@ -3168,18 +3307,37 @@ static int bpf_iter_udp_seq_show(struct seq_file *seq, void *v)
>   	struct bpf_prog *prog;
>   	struct sock *sk = v;
>   	uid_t uid;
> +	int rc;

nit. be consistent with variable name. "ret" is used in other changes in this patch.

>   
>   	if (v == SEQ_START_TOKEN)
>   		return 0;
>   
> +	lock_sock(sk);
> +
> +	if (unlikely(sk_unhashed(sk))) {
> +		rc = SEQ_SKIP;
> +		goto unlock;
> +	}
> +
>   	uid = from_kuid_munged(seq_user_ns(seq), sock_i_uid(sk));
>   	meta.seq = seq;
>   	prog = bpf_iter_get_info(&meta, false);
> -	return udp_prog_seq_show(prog, &meta, v, uid, state->bucket);
> +	rc = udp_prog_seq_show(prog, &meta, v, uid, state->bucket);
> +
> +unlock:
> +	release_sock(sk);
> +	return rc;
> +}
> +
> +static void bpf_iter_udp_put_batch(struct bpf_udp_iter_state *iter)
> +{
> +	while (iter->cur_sk < iter->end_sk)
> +		sock_put(iter->batch[iter->cur_sk++]);
>   }
>   
>   static void bpf_iter_udp_seq_stop(struct seq_file *seq, void *v)
>   {
> +	struct bpf_udp_iter_state *iter = seq->private;
>   	struct bpf_iter_meta meta;
>   	struct bpf_prog *prog;
>   
> @@ -3190,12 +3348,15 @@ static void bpf_iter_udp_seq_stop(struct seq_file *seq, void *v)
>   			(void)udp_prog_seq_show(prog, &meta, v, 0, 0);
>   	}
>   
> -	udp_seq_stop(seq, v);
> +	if (iter->cur_sk < iter->end_sk) {
> +		bpf_iter_udp_put_batch(iter);
> +		iter->st_bucket_done = false;
> +	}
>   }
>   
>   static const struct seq_operations bpf_iter_udp_seq_ops = {
> -	.start		= udp_seq_start,
> -	.next		= udp_seq_next,
> +	.start		= bpf_iter_udp_seq_start,
> +	.next		= bpf_iter_udp_seq_next,
>   	.stop		= bpf_iter_udp_seq_stop,
>   	.show		= bpf_iter_udp_seq_show,
>   };
> @@ -3424,21 +3585,57 @@ static struct pernet_operations __net_initdata udp_sysctl_ops = {
>   DEFINE_BPF_ITER_FUNC(udp, struct bpf_iter_meta *meta,
>   		     struct udp_sock *udp_sk, uid_t uid, int bucket)
>   
> +static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
> +				      unsigned int new_batch_sz)
> +{
> +	struct sock **new_batch;
> +
> +	new_batch = kvmalloc_array(new_batch_sz, sizeof(*new_batch),
> +				   GFP_USER | __GFP_NOWARN);
> +	if (!new_batch)
> +		return -ENOMEM;
> +
> +	bpf_iter_udp_put_batch(iter);
> +	kvfree(iter->batch);
> +	iter->batch = new_batch;
> +	iter->max_sk = new_batch_sz;
> +
> +	return 0;
> +}
> +
> +#define INIT_BATCH_SZ 16
> +
>   static int bpf_iter_init_udp(void *priv_data, struct bpf_iter_aux_info *aux)
>   {
> -	return bpf_iter_init_seq_net(priv_data, aux);
> +	struct bpf_udp_iter_state *iter = priv_data;
> +	int ret;
> +
> +	ret = bpf_iter_init_seq_net(priv_data, aux);
> +	if (ret)
> +		return ret;
> +
> +	ret = bpf_iter_udp_realloc_batch(iter, INIT_BATCH_SZ);
> +	if (ret) {
> +		bpf_iter_fini_seq_net(priv_data);
> +		return ret;

nit. remove this "return ret;" statement.

Others lgtm. I will continue with the rest of the patchset tomorrow.

> +	}
> +
> +	return ret;
>   }
>   
>   static void bpf_iter_fini_udp(void *priv_data)
>   {
> +	struct bpf_udp_iter_state *iter = priv_data;
> +
>   	bpf_iter_fini_seq_net(priv_data);
> +	kvfree(iter->batch);
>   }
>   
>   static const struct bpf_iter_seq_info udp_seq_info = {
>   	.seq_ops		= &bpf_iter_udp_seq_ops,
>   	.init_seq_private	= bpf_iter_init_udp,
>   	.fini_seq_private	= bpf_iter_fini_udp,
> -	.seq_priv_size		= sizeof(struct udp_iter_state),
> +	.seq_priv_size		= sizeof(struct bpf_udp_iter_state),
>   };
>   
>   static struct bpf_iter_reg udp_reg_info = {

