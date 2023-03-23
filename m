Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371F56C717E
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 21:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjCWUCo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 16:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjCWUCn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 16:02:43 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0DC28D3E
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 13:02:41 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id k2so23327058pll.8
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 13:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679601760;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVnYOIlNxsjcg33xrGr4cQAWvPV1ZayZ2dVrGFQdTgM=;
        b=dQVb9Z+TwlAaB4rBUqXhVjdsa0dSVFv5IYIhUsvYtaojF5sUCy0jMqsuvU6tJdvcFE
         HaB5m23xih+ifT1ZZhIsG1xW7HW6baLKuDX+0ywie9tLvG3QzHOh2PsNz/E50D0pmoDB
         +iKwK4n5S3ooDYJLBe+L5EJZuZ46fw+7v4JsvSXEXj77Xb6mwk1uJD2UNpkDaIziq2RC
         4DS8NufkV6+cQlkFJGqSjpYculcgrUvqPglfLqolprf9Bafh9Bzf9kMXmZyzmYFCDW2Q
         qxy4esQYVOB0nVuI8vwOqb04yQRJIOhhyikHInvhwRf7JjmRyY48U+hmTzRen+3gi3SL
         SKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679601760;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVnYOIlNxsjcg33xrGr4cQAWvPV1ZayZ2dVrGFQdTgM=;
        b=YHYAZ7ZL7dco0O5CDQ0LQopIOriOqQKWJGFiepftC+CnN5TiiX+lDhHLQXednmJlDy
         sv+L8se171kjH3/FvFQeh5P1Rz8SzOmslB589Tu69heKzd6NooPE23nsLsWGz0M29H+Y
         b5Xyou95lO6vJ6Rd+SW44hmYFkDxPJtfgkMrn3xOOoqfKulHQbY8RMeNsGuPSyObqZ4E
         74UUCzljHn763dGbDVvOpguOYBUcTwXWpx9i8OK7ircfw9K8rAtVdm4UJCV6ab9UzGxM
         a2ZqLeEI84FXp0GlgcBw/0nrhe5J+Fe4Ygb77qxG5vhOio2Um9JGWG5Y0rWtyYWLb+g0
         olCA==
X-Gm-Message-State: AO0yUKUw2xRibTcDMGV6Q3CoWUFLMSORqfnj0eeFMBVEMEZTZwu/NXu6
        mZs6cbgiHCbSYo06qYR88lnUvNZrVDd9TfMltp0=
X-Google-Smtp-Source: AK7set/TClJ1NntVanxoBqpqp4wpMg1lBTS9xOSzp1RdEeTrR9AKLdXXEWPa0hC0zeTYULPVwbKMDw==
X-Received: by 2002:a17:903:183:b0:19c:cf89:b7ee with SMTP id z3-20020a170903018300b0019ccf89b7eemr8099149plg.69.1679601760256;
        Thu, 23 Mar 2023 13:02:40 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:2893:7c18:2a69:fc69? ([2601:647:4900:1fbb:2893:7c18:2a69:fc69])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902758700b001a19196af48sm12693013pll.64.2023.03.23.13.02.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Mar 2023 13:02:39 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v3 bpf-next 2/5] bpf: Add bpf_sock_destroy kfunc
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <ZBobc8WSCmoUKvWc@google.com>
Date:   Thu, 23 Mar 2023 13:02:38 -0700
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F946AEF3-2E02-4932-9AB2-486245DDA743@isovalent.com>
References: <20230321184541.1857363-1-aditi.ghag@isovalent.com>
 <20230321184541.1857363-3-aditi.ghag@isovalent.com>
 <ZBobc8WSCmoUKvWc@google.com>
To:     Stanislav Fomichev <sdf@google.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Mar 21, 2023, at 2:02 PM, Stanislav Fomichev <sdf@google.com> =
wrote:
>=20
> On 03/21, Aditi Ghag wrote:
>> The socket destroy kfunc is used to forcefully terminate sockets from
>> certain BPF contexts. We plan to use the capability in Cilium to =
force
>> client sockets to reconnect when their remote load-balancing backends =
are
>> deleted. The other use case is on-the-fly policy enforcement where =
existing
>> socket connections prevented by policies need to be forcefully =
terminated.
>> The helper allows terminating sockets that may or may not be actively
>> sending traffic.
>=20
>> The helper is currently exposed to certain BPF iterators where users =
can
>> filter, and terminate selected sockets.  Additionally, the helper can =
only
>> be called from these BPF contexts that ensure socket locking in order =
to
>> allow synchronous execution of destroy helpers that also acquire =
socket
>> locks. The previous commit that batches UDP sockets during iteration
>> facilitated a synchronous invocation of the destroy helper from BPF =
context
>> by skipping taking socket locks in the destroy handler. TCP iterators
>> already supported batching.
>=20
>> The helper takes `sock_common` type argument, even though it expects, =
and
>> casts them to a `sock` pointer. This enables the verifier to allow =
the
>> sock_destroy kfunc to be called for TCP with `sock_common` and UDP =
with
>> `sock` structs. As a comparison, BPF helpers enable this behavior =
with the
>> `ARG_PTR_TO_BTF_ID_SOCK_COMMON` argument type. However, there is no =
such
>> option available with the verifier logic that handles kfuncs where =
BTF
>> types are inferred. Furthermore, as `sock_common` only has a subset =
of
>> certain fields of `sock`, casting pointer to the latter type might =
not
>> always be safe. Hence, the BPF kfunc converts the argument to a full =
sock
>> before casting.
>=20
>> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
>> ---
>>  include/net/udp.h |  1 +
>>  net/core/filter.c | 54 ++++++++++++++++++++++++++++++++++++++++++
>>  net/ipv4/tcp.c    | 16 +++++++++----
>>  net/ipv4/udp.c    | 60 =
+++++++++++++++++++++++++++++++++++++----------
>>  4 files changed, 114 insertions(+), 17 deletions(-)
>=20
>> diff --git a/include/net/udp.h b/include/net/udp.h
>> index de4b528522bb..d2999447d3f2 100644
>> --- a/include/net/udp.h
>> +++ b/include/net/udp.h
>> @@ -437,6 +437,7 @@ struct udp_seq_afinfo {
>>  struct udp_iter_state {
>>  	struct seq_net_private  p;
>>  	int			bucket;
>> +	int			offset;
>>  	struct udp_seq_afinfo	*bpf_seq_afinfo;
>>  };
>=20
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 1d6f165923bf..ba3e0dac119c 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -11621,3 +11621,57 @@ bpf_sk_base_func_proto(enum bpf_func_id =
func_id)
>=20
>>  	return func;
>>  }
>> +
>> +/* Disables missing prototype warnings */
>> +__diag_push();
>> +__diag_ignore_all("-Wmissing-prototypes",
>> +		  "Global functions as their definitions will be in =
vmlinux BTF");
>> +
>> +/* bpf_sock_destroy: Destroy the given socket with ECONNABORTED =
error code.
>> + *
>> + * The helper expects a non-NULL pointer to a socket. It invokes the
>> + * protocol specific socket destroy handlers.
>> + *
>> + * The helper can only be called from BPF contexts that have =
acquired the socket
>> + * locks.
>> + *
>> + * Parameters:
>> + * @sock: Pointer to socket to be destroyed
>> + *
>> + * Return:
>> + * On error, may return EPROTONOSUPPORT, EINVAL.
>> + * EPROTONOSUPPORT if protocol specific destroy handler is not =
implemented.
>> + * 0 otherwise
>> + */
>> +__bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
>> +{
>> +	struct sock *sk =3D (struct sock *)sock;
>> +
>> +	if (!sk)
>> +		return -EINVAL;
>> +
>> +	/* The locking semantics that allow for synchronous execution of =
the
>> +	 * destroy handlers are only supported for TCP and UDP.
>> +	 */
>> +	if (!sk->sk_prot->diag_destroy || sk->sk_protocol =3D=3D =
IPPROTO_RAW)
>> +		return -EOPNOTSUPP;
>=20
> What makes IPPROTO_RAW special? Looks like it locks the socket as =
well?

I haven't looked at the locking semantics for IPPROTO_RAW. These can be =
handled in a follow-up patch. Wdyt?

>=20
>> +
>> +	return sk->sk_prot->diag_destroy(sk, ECONNABORTED);
>> +}
>> +
>> +__diag_pop()
>> +
>> +BTF_SET8_START(sock_destroy_kfunc_set)
>> +BTF_ID_FLAGS(func, bpf_sock_destroy)
>> +BTF_SET8_END(sock_destroy_kfunc_set)
>> +
>> +static const struct btf_kfunc_id_set bpf_sock_destroy_kfunc_set =3D =
{
>> +	.owner =3D THIS_MODULE,
>> +	.set   =3D &sock_destroy_kfunc_set,
>> +};
>> +
>> +static int init_subsystem(void)
>> +{
>> +	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, =
&bpf_sock_destroy_kfunc_set);
>> +}
>> +late_initcall(init_subsystem);
>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>> index 33f559f491c8..59a833c0c872 100644
>> --- a/net/ipv4/tcp.c
>> +++ b/net/ipv4/tcp.c
>> @@ -4678,8 +4678,10 @@ int tcp_abort(struct sock *sk, int err)
>>  		return 0;
>>  	}
>=20
>> -	/* Don't race with userspace socket closes such as tcp_close. */
>> -	lock_sock(sk);
>> +	/* BPF context ensures sock locking. */
>> +	if (!has_current_bpf_ctx())
>> +		/* Don't race with userspace socket closes such as =
tcp_close. */
>> +		lock_sock(sk);
>=20
>>  	if (sk->sk_state =3D=3D TCP_LISTEN) {
>>  		tcp_set_state(sk, TCP_CLOSE);
>> @@ -4688,7 +4690,8 @@ int tcp_abort(struct sock *sk, int err)
>=20
>>  	/* Don't race with BH socket closes such as =
inet_csk_listen_stop. */
>>  	local_bh_disable();
>=20
> [..]
>=20
>> -	bh_lock_sock(sk);
>> +	if (!has_current_bpf_ctx())
>> +		bh_lock_sock(sk);
>=20
> These are spinlocks and should probably be grabbed in the bpf context =
as
> well?

Fixed in the next revision. Thanks!

>=20
>=20
>>  	if (!sock_flag(sk, SOCK_DEAD)) {
>>  		sk->sk_err =3D err;
>> @@ -4700,10 +4703,13 @@ int tcp_abort(struct sock *sk, int err)
>>  		tcp_done(sk);
>>  	}
>=20
>> -	bh_unlock_sock(sk);
>> +	if (!has_current_bpf_ctx())
>> +		bh_unlock_sock(sk);
>> +
>>  	local_bh_enable();
>>  	tcp_write_queue_purge(sk);
>> -	release_sock(sk);
>> +	if (!has_current_bpf_ctx())
>> +		release_sock(sk);
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL_GPL(tcp_abort);
>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>> index 545e56329355..02d357713838 100644
>> --- a/net/ipv4/udp.c
>> +++ b/net/ipv4/udp.c
>> @@ -2925,7 +2925,9 @@ EXPORT_SYMBOL(udp_poll);
>=20
>>  int udp_abort(struct sock *sk, int err)
>>  {
>> -	lock_sock(sk);
>> +	/* BPF context ensures sock locking. */
>> +	if (!has_current_bpf_ctx())
>> +		lock_sock(sk);
>=20
>>  	/* udp{v6}_destroy_sock() sets it under the sk lock, avoid =
racing
>>  	 * with close()
>> @@ -2938,7 +2940,8 @@ int udp_abort(struct sock *sk, int err)
>>  	__udp_disconnect(sk, 0);
>=20
>>  out:
>> -	release_sock(sk);
>> +	if (!has_current_bpf_ctx())
>> +		release_sock(sk);
>=20
>>  	return 0;
>>  }
>> @@ -3184,15 +3187,23 @@ static struct sock *bpf_iter_udp_batch(struct =
seq_file *seq)
>>  	struct sock *first_sk =3D NULL;
>>  	struct sock *sk;
>>  	unsigned int bucket_sks =3D 0;
>> -	bool first;
>>  	bool resized =3D false;
>> +	int offset =3D 0;
>> +	int new_offset;
>=20
>>  	/* The current batch is done, so advance the bucket. */
>> -	if (iter->st_bucket_done)
>> +	if (iter->st_bucket_done) {
>>  		state->bucket++;
>> +		state->offset =3D 0;
>> +	}
>=20
>>  	udptable =3D udp_get_table_afinfo(afinfo, net);
>=20
>> +	if (state->bucket > udptable->mask) {
>> +		state->bucket =3D 0;
>> +		state->offset =3D 0;
>> +	}
>> +
>>  again:
>>  	/* New batch for the next bucket.
>>  	 * Iterate over the hash table to find a bucket with sockets =
matching
>> @@ -3204,43 +3215,60 @@ static struct sock *bpf_iter_udp_batch(struct =
seq_file *seq)
>>  	iter->cur_sk =3D 0;
>>  	iter->end_sk =3D 0;
>>  	iter->st_bucket_done =3D false;
>> -	first =3D true;
>> +	first_sk =3D NULL;
>> +	bucket_sks =3D 0;
>> +	offset =3D state->offset;
>> +	new_offset =3D offset;
>=20
>>  	for (; state->bucket <=3D udptable->mask; state->bucket++) {
>>  		struct udp_hslot *hslot =3D =
&udptable->hash[state->bucket];
>=20
>> -		if (hlist_empty(&hslot->head))
>> +		if (hlist_empty(&hslot->head)) {
>> +			offset =3D 0;
>>  			continue;
>> +		}
>=20
>>  		spin_lock_bh(&hslot->lock);
>> +		/* Resume from the last saved position in a bucket =
before
>> +		 * iterator was stopped.
>> +		 */
>> +		while (offset-- > 0) {
>> +			sk_for_each(sk, &hslot->head)
>> +				continue;
>> +		}
>>  		sk_for_each(sk, &hslot->head) {
>>  			if (seq_sk_match(seq, sk)) {
>> -				if (first) {
>> +				if (!first_sk)
>>  					first_sk =3D sk;
>> -					first =3D false;
>> -				}
>>  				if (iter->end_sk < iter->max_sk) {
>>  					sock_hold(sk);
>>  					iter->batch[iter->end_sk++] =3D =
sk;
>>  				}
>>  				bucket_sks++;
>>  			}
>> +			new_offset++;
>>  		}
>>  		spin_unlock_bh(&hslot->lock);
>> +
>>  		if (first_sk)
>>  			break;
>> +
>> +		/* Reset the current bucket's offset before moving to =
the next bucket. */
>> +		offset =3D 0;
>> +		new_offset =3D 0;
>> +
>>  	}
>=20
>>  	/* All done: no batch made. */
>>  	if (!first_sk)
>> -		return NULL;
>> +		goto ret;
>=20
>>  	if (iter->end_sk =3D=3D bucket_sks) {
>>  		/* Batching is done for the current bucket; return the =
first
>>  		 * socket to be iterated from the batch.
>>  		 */
>>  		iter->st_bucket_done =3D true;
>> -		return first_sk;
>> +		goto ret;
>>  	}
>>  	if (!resized && !bpf_iter_udp_realloc_batch(iter, bucket_sks * 3 =
/ 2)) {
>>  		resized =3D true;
>> @@ -3248,19 +3276,24 @@ static struct sock *bpf_iter_udp_batch(struct =
seq_file *seq)
>>  		state->bucket--;
>>  		goto again;
>>  	}
>> +ret:
>> +	state->offset =3D new_offset;
>>  	return first_sk;
>>  }
>=20
>>  static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, =
loff_t *pos)
>>  {
>>  	struct bpf_udp_iter_state *iter =3D seq->private;
>> +	struct udp_iter_state *state =3D &iter->state;
>>  	struct sock *sk;
>=20
>>  	/* Whenever seq_next() is called, the iter->cur_sk is
>>  	 * done with seq_show(), so unref the iter->cur_sk.
>>  	 */
>> -	if (iter->cur_sk < iter->end_sk)
>> +	if (iter->cur_sk < iter->end_sk) {
>>  		sock_put(iter->batch[iter->cur_sk++]);
>> +		++state->offset;
>> +	}
>=20
>>  	/* After updating iter->cur_sk, check if there are more sockets
>>  	 * available in the current bucket batch.
>> @@ -3630,6 +3663,9 @@ static int bpf_iter_init_udp(void *priv_data, =
struct bpf_iter_aux_info *aux)
>>  	}
>>  	iter->cur_sk =3D 0;
>>  	iter->end_sk =3D 0;
>> +	iter->st_bucket_done =3D false;
>> +	st->bucket =3D 0;
>> +	st->offset =3D 0;
>=20
>>  	return ret;
>>  }
>> --
>> 2.34.1

