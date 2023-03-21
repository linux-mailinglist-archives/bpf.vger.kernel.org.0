Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13286C3C66
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 22:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjCUVCs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 17:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjCUVCr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 17:02:47 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804B8574DF
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 14:02:45 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536a4eba107so167417867b3.19
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 14:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679432564;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QL2l9/uZDeVbmwuBLQeQTyI3BZiIxbJYLE+OKGZsYt8=;
        b=GzS29xzv8R+fcJn/FIJwkIAhfjmJ7CmPSICeNnO9uUTYp119U/CLj2XQrTWB8at5yC
         RqErhcXmQdhnRecivD4aBLVHDVIo80Qx8zq3UqwDoa1s4bR1tZvF8EjJvfbcz55qCv5X
         pSo9hczLTeMESR/TCa/6leLE/x2etl4veGWVo773k/aDqRNWhWV8rzRqlsV2su+kNHja
         GK4f7+z1usKae1cehXCLuDRcjBrpM4nyMdw9RSBxaMSr3ZDxopHZjRM0iRvvGtNiSszH
         2PUPKb0Gp0BuPMNNdmt3Bwz8+Y8uHzrJ59YYW4iQOKBCAu1JEaoypmLgPf6twlniK4bt
         0RYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679432564;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QL2l9/uZDeVbmwuBLQeQTyI3BZiIxbJYLE+OKGZsYt8=;
        b=ARsjpLTGn+l0dUkferUCMhuXWOCXP5GvWeOdlDcC4//mZD+bF7sTaNOjv40sQFOS99
         U+AiNHB6EDB8A+gNkhvHAS9Rn7nNO9CM0bTYlnMyttO4lTfi4PizF8m/5Y8xLQZ+LQgU
         asOeBF2aytId6zK7gyUyX4sG8czw8T3c5CtXkrX3eK60HqMGXT+7kFr/rH1I8oXJSF4P
         ZnPdJjIWA6D39FZ+XZnajbc4pk0pG2oanYOH8C9Aq05es3I1pwYFdN+jpXxcHPQxwsUp
         FAiwbb3bmReZszsQmrbmGwe65qAkCdWyh9r8F/cnZbduD/ltVM/MROVTwH+sjkv7JBex
         3Hxw==
X-Gm-Message-State: AAQBX9dfuRvDvn8z03kCJzuQ8LhMWBU5tNrICMv3lS8tzTXrkOItPsi/
        MHuJVSmnRSqS9RIWVsRB+uuPQIo=
X-Google-Smtp-Source: AKy350b61Ujld7WAzGUmpwehc7fStMtYqdI6u5BOjbpeaEVfkfeqrX3mmJw2vocEsYWBRpjbIWj5wCo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:ae0a:0:b0:533:9185:fc2c with SMTP id
 m10-20020a81ae0a000000b005339185fc2cmr1871347ywh.7.1679432564655; Tue, 21 Mar
 2023 14:02:44 -0700 (PDT)
Date:   Tue, 21 Mar 2023 14:02:43 -0700
In-Reply-To: <20230321184541.1857363-3-aditi.ghag@isovalent.com>
Mime-Version: 1.0
References: <20230321184541.1857363-1-aditi.ghag@isovalent.com> <20230321184541.1857363-3-aditi.ghag@isovalent.com>
Message-ID: <ZBobc8WSCmoUKvWc@google.com>
Subject: Re: [PATCH v3 bpf-next 2/5] bpf: Add bpf_sock_destroy kfunc
From:   Stanislav Fomichev <sdf@google.com>
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/21, Aditi Ghag wrote:
> The socket destroy kfunc is used to forcefully terminate sockets from
> certain BPF contexts. We plan to use the capability in Cilium to force
> client sockets to reconnect when their remote load-balancing backends are
> deleted. The other use case is on-the-fly policy enforcement where  
> existing
> socket connections prevented by policies need to be forcefully terminated.
> The helper allows terminating sockets that may or may not be actively
> sending traffic.

> The helper is currently exposed to certain BPF iterators where users can
> filter, and terminate selected sockets.  Additionally, the helper can only
> be called from these BPF contexts that ensure socket locking in order to
> allow synchronous execution of destroy helpers that also acquire socket
> locks. The previous commit that batches UDP sockets during iteration
> facilitated a synchronous invocation of the destroy helper from BPF  
> context
> by skipping taking socket locks in the destroy handler. TCP iterators
> already supported batching.

> The helper takes `sock_common` type argument, even though it expects, and
> casts them to a `sock` pointer. This enables the verifier to allow the
> sock_destroy kfunc to be called for TCP with `sock_common` and UDP with
> `sock` structs. As a comparison, BPF helpers enable this behavior with the
> `ARG_PTR_TO_BTF_ID_SOCK_COMMON` argument type. However, there is no such
> option available with the verifier logic that handles kfuncs where BTF
> types are inferred. Furthermore, as `sock_common` only has a subset of
> certain fields of `sock`, casting pointer to the latter type might not
> always be safe. Hence, the BPF kfunc converts the argument to a full sock
> before casting.

> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
> ---
>   include/net/udp.h |  1 +
>   net/core/filter.c | 54 ++++++++++++++++++++++++++++++++++++++++++
>   net/ipv4/tcp.c    | 16 +++++++++----
>   net/ipv4/udp.c    | 60 +++++++++++++++++++++++++++++++++++++----------
>   4 files changed, 114 insertions(+), 17 deletions(-)

> diff --git a/include/net/udp.h b/include/net/udp.h
> index de4b528522bb..d2999447d3f2 100644
> --- a/include/net/udp.h
> +++ b/include/net/udp.h
> @@ -437,6 +437,7 @@ struct udp_seq_afinfo {
>   struct udp_iter_state {
>   	struct seq_net_private  p;
>   	int			bucket;
> +	int			offset;
>   	struct udp_seq_afinfo	*bpf_seq_afinfo;
>   };

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 1d6f165923bf..ba3e0dac119c 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -11621,3 +11621,57 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)

>   	return func;
>   }
> +
> +/* Disables missing prototype warnings */
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +		  "Global functions as their definitions will be in vmlinux BTF");
> +
> +/* bpf_sock_destroy: Destroy the given socket with ECONNABORTED error  
> code.
> + *
> + * The helper expects a non-NULL pointer to a socket. It invokes the
> + * protocol specific socket destroy handlers.
> + *
> + * The helper can only be called from BPF contexts that have acquired  
> the socket
> + * locks.
> + *
> + * Parameters:
> + * @sock: Pointer to socket to be destroyed
> + *
> + * Return:
> + * On error, may return EPROTONOSUPPORT, EINVAL.
> + * EPROTONOSUPPORT if protocol specific destroy handler is not  
> implemented.
> + * 0 otherwise
> + */
> +__bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
> +{
> +	struct sock *sk = (struct sock *)sock;
> +
> +	if (!sk)
> +		return -EINVAL;
> +
> +	/* The locking semantics that allow for synchronous execution of the
> +	 * destroy handlers are only supported for TCP and UDP.
> +	 */
> +	if (!sk->sk_prot->diag_destroy || sk->sk_protocol == IPPROTO_RAW)
> +		return -EOPNOTSUPP;

What makes IPPROTO_RAW special? Looks like it locks the socket as well?

> +
> +	return sk->sk_prot->diag_destroy(sk, ECONNABORTED);
> +}
> +
> +__diag_pop()
> +
> +BTF_SET8_START(sock_destroy_kfunc_set)
> +BTF_ID_FLAGS(func, bpf_sock_destroy)
> +BTF_SET8_END(sock_destroy_kfunc_set)
> +
> +static const struct btf_kfunc_id_set bpf_sock_destroy_kfunc_set = {
> +	.owner = THIS_MODULE,
> +	.set   = &sock_destroy_kfunc_set,
> +};
> +
> +static int init_subsystem(void)
> +{
> +	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,  
> &bpf_sock_destroy_kfunc_set);
> +}
> +late_initcall(init_subsystem);
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 33f559f491c8..59a833c0c872 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4678,8 +4678,10 @@ int tcp_abort(struct sock *sk, int err)
>   		return 0;
>   	}

> -	/* Don't race with userspace socket closes such as tcp_close. */
> -	lock_sock(sk);
> +	/* BPF context ensures sock locking. */
> +	if (!has_current_bpf_ctx())
> +		/* Don't race with userspace socket closes such as tcp_close. */
> +		lock_sock(sk);

>   	if (sk->sk_state == TCP_LISTEN) {
>   		tcp_set_state(sk, TCP_CLOSE);
> @@ -4688,7 +4690,8 @@ int tcp_abort(struct sock *sk, int err)

>   	/* Don't race with BH socket closes such as inet_csk_listen_stop. */
>   	local_bh_disable();

[..]

> -	bh_lock_sock(sk);
> +	if (!has_current_bpf_ctx())
> +		bh_lock_sock(sk);

These are spinlocks and should probably be grabbed in the bpf context as
well?


>   	if (!sock_flag(sk, SOCK_DEAD)) {
>   		sk->sk_err = err;
> @@ -4700,10 +4703,13 @@ int tcp_abort(struct sock *sk, int err)
>   		tcp_done(sk);
>   	}

> -	bh_unlock_sock(sk);
> +	if (!has_current_bpf_ctx())
> +		bh_unlock_sock(sk);
> +
>   	local_bh_enable();
>   	tcp_write_queue_purge(sk);
> -	release_sock(sk);
> +	if (!has_current_bpf_ctx())
> +		release_sock(sk);
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(tcp_abort);
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 545e56329355..02d357713838 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2925,7 +2925,9 @@ EXPORT_SYMBOL(udp_poll);

>   int udp_abort(struct sock *sk, int err)
>   {
> -	lock_sock(sk);
> +	/* BPF context ensures sock locking. */
> +	if (!has_current_bpf_ctx())
> +		lock_sock(sk);

>   	/* udp{v6}_destroy_sock() sets it under the sk lock, avoid racing
>   	 * with close()
> @@ -2938,7 +2940,8 @@ int udp_abort(struct sock *sk, int err)
>   	__udp_disconnect(sk, 0);

>   out:
> -	release_sock(sk);
> +	if (!has_current_bpf_ctx())
> +		release_sock(sk);

>   	return 0;
>   }
> @@ -3184,15 +3187,23 @@ static struct sock *bpf_iter_udp_batch(struct  
> seq_file *seq)
>   	struct sock *first_sk = NULL;
>   	struct sock *sk;
>   	unsigned int bucket_sks = 0;
> -	bool first;
>   	bool resized = false;
> +	int offset = 0;
> +	int new_offset;

>   	/* The current batch is done, so advance the bucket. */
> -	if (iter->st_bucket_done)
> +	if (iter->st_bucket_done) {
>   		state->bucket++;
> +		state->offset = 0;
> +	}

>   	udptable = udp_get_table_afinfo(afinfo, net);

> +	if (state->bucket > udptable->mask) {
> +		state->bucket = 0;
> +		state->offset = 0;
> +	}
> +
>   again:
>   	/* New batch for the next bucket.
>   	 * Iterate over the hash table to find a bucket with sockets matching
> @@ -3204,43 +3215,60 @@ static struct sock *bpf_iter_udp_batch(struct  
> seq_file *seq)
>   	iter->cur_sk = 0;
>   	iter->end_sk = 0;
>   	iter->st_bucket_done = false;
> -	first = true;
> +	first_sk = NULL;
> +	bucket_sks = 0;
> +	offset = state->offset;
> +	new_offset = offset;

>   	for (; state->bucket <= udptable->mask; state->bucket++) {
>   		struct udp_hslot *hslot = &udptable->hash[state->bucket];

> -		if (hlist_empty(&hslot->head))
> +		if (hlist_empty(&hslot->head)) {
> +			offset = 0;
>   			continue;
> +		}

>   		spin_lock_bh(&hslot->lock);
> +		/* Resume from the last saved position in a bucket before
> +		 * iterator was stopped.
> +		 */
> +		while (offset-- > 0) {
> +			sk_for_each(sk, &hslot->head)
> +				continue;
> +		}
>   		sk_for_each(sk, &hslot->head) {
>   			if (seq_sk_match(seq, sk)) {
> -				if (first) {
> +				if (!first_sk)
>   					first_sk = sk;
> -					first = false;
> -				}
>   				if (iter->end_sk < iter->max_sk) {
>   					sock_hold(sk);
>   					iter->batch[iter->end_sk++] = sk;
>   				}
>   				bucket_sks++;
>   			}
> +			new_offset++;
>   		}
>   		spin_unlock_bh(&hslot->lock);
> +
>   		if (first_sk)
>   			break;
> +
> +		/* Reset the current bucket's offset before moving to the next bucket.  
> */
> +		offset = 0;
> +		new_offset = 0;
> +
>   	}

>   	/* All done: no batch made. */
>   	if (!first_sk)
> -		return NULL;
> +		goto ret;

>   	if (iter->end_sk == bucket_sks) {
>   		/* Batching is done for the current bucket; return the first
>   		 * socket to be iterated from the batch.
>   		 */
>   		iter->st_bucket_done = true;
> -		return first_sk;
> +		goto ret;
>   	}
>   	if (!resized && !bpf_iter_udp_realloc_batch(iter, bucket_sks * 3 / 2)) {
>   		resized = true;
> @@ -3248,19 +3276,24 @@ static struct sock *bpf_iter_udp_batch(struct  
> seq_file *seq)
>   		state->bucket--;
>   		goto again;
>   	}
> +ret:
> +	state->offset = new_offset;
>   	return first_sk;
>   }

>   static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t  
> *pos)
>   {
>   	struct bpf_udp_iter_state *iter = seq->private;
> +	struct udp_iter_state *state = &iter->state;
>   	struct sock *sk;

>   	/* Whenever seq_next() is called, the iter->cur_sk is
>   	 * done with seq_show(), so unref the iter->cur_sk.
>   	 */
> -	if (iter->cur_sk < iter->end_sk)
> +	if (iter->cur_sk < iter->end_sk) {
>   		sock_put(iter->batch[iter->cur_sk++]);
> +		++state->offset;
> +	}

>   	/* After updating iter->cur_sk, check if there are more sockets
>   	 * available in the current bucket batch.
> @@ -3630,6 +3663,9 @@ static int bpf_iter_init_udp(void *priv_data,  
> struct bpf_iter_aux_info *aux)
>   	}
>   	iter->cur_sk = 0;
>   	iter->end_sk = 0;
> +	iter->st_bucket_done = false;
> +	st->bucket = 0;
> +	st->offset = 0;

>   	return ret;
>   }
> --
> 2.34.1

