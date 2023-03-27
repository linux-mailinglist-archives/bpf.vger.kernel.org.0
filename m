Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4C56CB1CB
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 00:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjC0W2i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 18:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0W2i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 18:28:38 -0400
Received: from out-44.mta0.migadu.com (out-44.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F163E1997
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 15:28:35 -0700 (PDT)
Message-ID: <c77f069e-69a4-bc0a-dc92-c77cd0f7df08@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679956112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qNXZmzkfQu7AFIvuVw4d1vt9wu+hspBdl2iQD8FXFZU=;
        b=JNKqZrnVVhzIWiqxjEIwGLzCyCAsW/bifF/xQJcY0mvdrcOFTSHEP6goHipLG5cHD42bQZ
        KEhU+xGhWqUwWzkKb0F//gnF5u1pH1YHRVYlk37uV+lUdbe/g1QGkXl10nScNdoyW3j+2N
        CJV5CpI/1y7KPPF2B1x4Ih8Oi83J81I=
Date:   Mon, 27 Mar 2023 15:28:28 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next 1/4] bpf: Implement batching in UDP iterator
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20230323200633.3175753-1-aditi.ghag@isovalent.com>
 <20230323200633.3175753-2-aditi.ghag@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230323200633.3175753-2-aditi.ghag@isovalent.com>
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

On 3/23/23 1:06 PM, Aditi Ghag wrote:
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
>   include/net/udp.h |   1 +
>   net/ipv4/udp.c    | 255 ++++++++++++++++++++++++++++++++++++++++++++--
>   2 files changed, 247 insertions(+), 9 deletions(-)
> 
> diff --git a/include/net/udp.h b/include/net/udp.h
> index de4b528522bb..d2999447d3f2 100644
> --- a/include/net/udp.h
> +++ b/include/net/udp.h
> @@ -437,6 +437,7 @@ struct udp_seq_afinfo {
>   struct udp_iter_state {
>   	struct seq_net_private  p;
>   	int			bucket;
> +	int			offset;

offset should be moved to 'struct bpf_udp_iter_state' instead. It is specific to 
bpf_iter only.

>   	struct udp_seq_afinfo	*bpf_seq_afinfo;
>   };
>   
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index c605d171eb2d..58c620243e47 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -3152,6 +3152,171 @@ struct bpf_iter__udp {
>   	int bucket __aligned(8);
>   };
>   
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
> +	bool resized = false;
> +	int offset = 0;
> +	int new_offset;
> +
> +	/* The current batch is done, so advance the bucket. */
> +	if (iter->st_bucket_done) {
> +		state->bucket++;
> +		state->offset = 0;
> +	}
> +
> +	udptable = udp_get_table_afinfo(afinfo, net);
> +
> +	if (state->bucket > udptable->mask) {
> +		state->bucket = 0;
> +		state->offset = 0;
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
> +	bucket_sks = 0;
> +	offset = state->offset;
> +	new_offset = offset;
> +
> +	for (; state->bucket <= udptable->mask; state->bucket++) {
> +		struct udp_hslot *hslot = &udptable->hash[state->bucket];

Use udptable->hash"2" which is hashed by addr and port. It will help to get a 
smaller batch. It was the comment given in v2.

> +
> +		if (hlist_empty(&hslot->head)) {
> +			offset = 0;
> +			continue;
> +		}
> +
> +		spin_lock_bh(&hslot->lock);
> +		/* Resume from the last saved position in a bucket before
> +		 * iterator was stopped.
> +		 */
> +		while (offset-- > 0) {
> +			sk_for_each(sk, &hslot->head)
> +				continue;
> +		}

hmm... how does the above while loop and sk_for_each loop actually work?

> +		sk_for_each(sk, &hslot->head) {

Here starts from the beginning of the hslot->head again. doesn't look right also.

Am I missing something here?

> +			if (seq_sk_match(seq, sk)) {
> +				if (!first_sk)
> +					first_sk = sk;
> +				if (iter->end_sk < iter->max_sk) {
> +					sock_hold(sk);
> +					iter->batch[iter->end_sk++] = sk;
> +				}
> +				bucket_sks++;
> +			}
> +			new_offset++;

And this new_offset is outside of seq_sk_match, so it is not counting for the 
seq_file_net(seq) netns alone.

> +		}
> +		spin_unlock_bh(&hslot->lock);
> +
> +		if (first_sk)
> +			break;
> +
> +		/* Reset the current bucket's offset before moving to the next bucket. */
> +		offset = 0;
> +		new_offset = 0;
> +	}
> +
> +	/* All done: no batch made. */
> +	if (!first_sk)
> +		goto ret;
> +
> +	if (iter->end_sk == bucket_sks) {
> +		/* Batching is done for the current bucket; return the first
> +		 * socket to be iterated from the batch.
> +		 */
> +		iter->st_bucket_done = true;
> +		goto ret;
> +	}
> +	if (!resized && !bpf_iter_udp_realloc_batch(iter, bucket_sks * 3 / 2)) {
> +		resized = true;
> +		/* Go back to the previous bucket to resize its batch. */
> +		state->bucket--;
> +		goto again;
> +	}
> +ret:
> +	state->offset = new_offset;
> +	return first_sk;
> +}
> +
> +static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
> +{
> +	struct bpf_udp_iter_state *iter = seq->private;
> +	struct udp_iter_state *state = &iter->state;
> +	struct sock *sk;
> +
> +	/* Whenever seq_next() is called, the iter->cur_sk is
> +	 * done with seq_show(), so unref the iter->cur_sk.
> +	 */
> +	if (iter->cur_sk < iter->end_sk) {
> +		sock_put(iter->batch[iter->cur_sk++]);
> +		++state->offset;

but then,
if I read it correctly, this offset counting is only for netns specific to 
seq_file_net(seq) because batch is specific to seq_file_net(net). Is it going to 
work?

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
> @@ -3172,18 +3337,38 @@ static int bpf_iter_udp_seq_show(struct seq_file *seq, void *v)
>   	struct bpf_prog *prog;
>   	struct sock *sk = v;
>   	uid_t uid;
> +	bool slow;
> +	int rc;
>   
>   	if (v == SEQ_START_TOKEN)
>   		return 0;
>   
> +	slow = lock_sock_fast(sk);
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
> +	unlock_sock_fast(sk, slow);
> +	return rc;
> +}
> +
> +static void bpf_iter_udp_unref_batch(struct bpf_udp_iter_state *iter)

nit. Please use the same naming as in tcp-iter and unix-iter, so 
bpf_iter_udp_put_batch().

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
> @@ -3194,15 +3379,31 @@ static void bpf_iter_udp_seq_stop(struct seq_file *seq, void *v)
>   			(void)udp_prog_seq_show(prog, &meta, v, 0, 0);
>   	}
>   
> -	udp_seq_stop(seq, v);
> +	if (iter->cur_sk < iter->end_sk) {
> +		bpf_iter_udp_unref_batch(iter);
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
> +
> +static unsigned short seq_file_family(const struct seq_file *seq)
> +{
> +	const struct udp_seq_afinfo *afinfo;
> +
> +	/* BPF iterator: bpf programs to filter sockets. */
> +	if (seq->op == &bpf_iter_udp_seq_ops)
> +		return AF_UNSPEC;
> +
> +	/* Proc fs iterator */
> +	afinfo = pde_data(file_inode(seq->file));
> +	return afinfo->family;
> +}
>   #endif
>   
>   const struct seq_operations udp_seq_ops = {
> @@ -3413,9 +3614,30 @@ static struct pernet_operations __net_initdata udp_sysctl_ops = {
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
> +	bpf_iter_udp_unref_batch(iter);
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
> -	struct udp_iter_state *st = priv_data;
> +	struct bpf_udp_iter_state *iter = priv_data;
> +	struct udp_iter_state *st = &iter->state;
>   	struct udp_seq_afinfo *afinfo;
>   	int ret;
>   
> @@ -3427,24 +3649,39 @@ static int bpf_iter_init_udp(void *priv_data, struct bpf_iter_aux_info *aux)
>   	afinfo->udp_table = NULL;
>   	st->bpf_seq_afinfo = afinfo;
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
> +	iter->st_bucket_done = false;
> +	st->bucket = 0;
> +	st->offset = 0;

 From looking at the tcp and unix counter part, I don't think this zeroings is 
necessary.

> +
>   	return ret;
>   }
>   
>   static void bpf_iter_fini_udp(void *priv_data)
>   {
> -	struct udp_iter_state *st = priv_data;
> +	struct bpf_udp_iter_state *iter = priv_data;
> +	struct udp_iter_state *st = &iter->state;
>   
> -	kfree(st->bpf_seq_afinfo);

The st->bpf_seq_afinfo should no longer be needed. Please remove it from 'struct 
udp_iter_state'.

The other AF_UNSPEC test in the existing udp_get_{first,next,...} should be 
cleaned up to use the refactored seq_sk_match() also.

These two changes should be done as the first one (or two?) cleanup patches 
before the actual udp batching patch. The tcp-iter-batching patch set could be a 
reference point on how the patch set could be structured.

>   	bpf_iter_fini_seq_net(priv_data);
> +	kfree(st->bpf_seq_afinfo);
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

