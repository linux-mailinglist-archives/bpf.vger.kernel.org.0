Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A210D6CC8CD
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 19:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjC1RG0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 13:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjC1RGZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 13:06:25 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE17426A1
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 10:06:23 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id k2so12322655pll.8
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 10:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680023183;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxaIaUcEgCMD/Hz4U5tWJU0TDLilTa3EUf9tocaPD/Y=;
        b=SBvw4sOYm/l9yjHc0tXvM45g/Pdvc89L1nOfM5eMckxftvZJK7xKSgCI0BzP2+5o0l
         KE/vNM0gF1fZ7uOAFraIb/lsClhZv3fwKUMZtHJu3glTLVWGzPFlzNI2048sIET5DZFG
         QT1BCyalpJSYoW9FAJO0nAsvB/LgKTqJtEUp8OcIbBnWcYcuv4xDC8fbYFWhr/NpKQin
         K71yPiR/kuLVXvEau8a+lInGxwIJTc5bmoqcQ2xHY0QMhGsNza3GMt+Pu0sMz9hzZo9E
         srAPgH9seOR4pV6N5qD7EA7buNnpGO+nEt0tMeQHtI0tLPD3ilk3yN7qgvbJUKIitU5K
         V2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680023183;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxaIaUcEgCMD/Hz4U5tWJU0TDLilTa3EUf9tocaPD/Y=;
        b=nOicuAnPbbQxPo1XKOrHCm9p7xED1rakg9+rr9SH2YZgoJFsYNxrfXkbyBpg/LXxIQ
         j8GJyqu6iOJRJwcOj0n6kH4mMjzzd2AEX0WVC8JomWJVJbE4ZnlGUtkuMALrhN+ETcQi
         jdQNOAoJD5g4Ep6aOnmvXk5Cq4YDse4se2d/nnnbm1B4/23o5ZC7YW3vtv170TGym6yw
         oohUmJljJVHpMCgh8fUDsaK1a5WPy6MO3He+T6VdVmkQm+MD62w2Uq1QOfD1y6BWF40c
         dypbKKwQ8/HR7dmv9EJ/qbXrNoIJJQFz225MQHHyjgVWzbyQdtYbtgdr/Cna54NOBTET
         1QtQ==
X-Gm-Message-State: AAQBX9f4V1Ll+7xnnIUJ/h2S/v4elF2qnjoykiGQ8sghL1To5kzumOEj
        hcdUzSNQyeAfOS+TxNbwE2qwHw==
X-Google-Smtp-Source: AKy350ZbsrIYqqKOlduAb/gmeOpqpE8xYCdXiE/mCIo5wspwjEZHLYajf76msPHxDPqIvWiE6DHIcQ==
X-Received: by 2002:a17:90b:4c4a:b0:23b:bf03:397e with SMTP id np10-20020a17090b4c4a00b0023bbf03397emr18290766pjb.24.1680023182458;
        Tue, 28 Mar 2023 10:06:22 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:74d3:2bc6:6239:344c? ([2601:647:4900:1fbb:74d3:2bc6:6239:344c])
        by smtp.gmail.com with ESMTPSA id j9-20020a632309000000b0050be4ff460esm19854118pgj.4.2023.03.28.10.06.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Mar 2023 10:06:21 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v4 bpf-next 1/4] bpf: Implement batching in UDP iterator
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <c77f069e-69a4-bc0a-dc92-c77cd0f7df08@linux.dev>
Date:   Tue, 28 Mar 2023 10:06:19 -0700
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FF565E79-7C76-4525-8835-931146319F21@isovalent.com>
References: <20230323200633.3175753-1-aditi.ghag@isovalent.com>
 <20230323200633.3175753-2-aditi.ghag@isovalent.com>
 <c77f069e-69a4-bc0a-dc92-c77cd0f7df08@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Mar 27, 2023, at 3:28 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>=20
> On 3/23/23 1:06 PM, Aditi Ghag wrote:
>> Batch UDP sockets from BPF iterator that allows for overlapping =
locking
>> semantics in BPF/kernel helpers executed in BPF programs.  This =
facilitates
>> BPF socket destroy kfunc (introduced by follow-up patches) to execute =
from
>> BPF iterator programs.
>> Previously, BPF iterators acquired the sock lock and sockets hash =
table
>> bucket lock while executing BPF programs. This prevented BPF helpers =
that
>> again acquire these locks to be executed from BPF iterators.  With =
the
>> batching approach, we acquire a bucket lock, batch all the bucket =
sockets,
>> and then release the bucket lock. This enables BPF or kernel helpers =
to
>> skip sock locking when invoked in the supported BPF contexts.
>> The batching logic is similar to the logic implemented in TCP =
iterator:
>> https://lore.kernel.org/bpf/20210701200613.1036157-1-kafai@fb.com/.
>> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
>> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
>> ---
>>  include/net/udp.h |   1 +
>>  net/ipv4/udp.c    | 255 =
++++++++++++++++++++++++++++++++++++++++++++--
>>  2 files changed, 247 insertions(+), 9 deletions(-)
>> diff --git a/include/net/udp.h b/include/net/udp.h
>> index de4b528522bb..d2999447d3f2 100644
>> --- a/include/net/udp.h
>> +++ b/include/net/udp.h
>> @@ -437,6 +437,7 @@ struct udp_seq_afinfo {
>>  struct udp_iter_state {
>>  	struct seq_net_private  p;
>>  	int			bucket;
>> +	int			offset;
>=20
> offset should be moved to 'struct bpf_udp_iter_state' instead. It is =
specific to bpf_iter only.

Sure, I'll move it.

>=20
>>  	struct udp_seq_afinfo	*bpf_seq_afinfo;
>>  };
>>  diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>> index c605d171eb2d..58c620243e47 100644
>> --- a/net/ipv4/udp.c
>> +++ b/net/ipv4/udp.c
>> @@ -3152,6 +3152,171 @@ struct bpf_iter__udp {
>>  	int bucket __aligned(8);
>>  };
>>  +struct bpf_udp_iter_state {
>> +	struct udp_iter_state state;
>> +	unsigned int cur_sk;
>> +	unsigned int end_sk;
>> +	unsigned int max_sk;
>> +	struct sock **batch;
>> +	bool st_bucket_done;
>> +};
>> +
>> +static unsigned short seq_file_family(const struct seq_file *seq);
>> +static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state =
*iter,
>> +				      unsigned int new_batch_sz);
>> +
>> +static inline bool seq_sk_match(struct seq_file *seq, const struct =
sock *sk)
>> +{
>> +	unsigned short family =3D seq_file_family(seq);
>> +
>> +	/* AF_UNSPEC is used as a match all */
>> +	return ((family =3D=3D AF_UNSPEC || family =3D=3D sk->sk_family) =
&&
>> +		net_eq(sock_net(sk), seq_file_net(seq)));
>> +}
>> +
>> +static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>> +{
>> +	struct bpf_udp_iter_state *iter =3D seq->private;
>> +	struct udp_iter_state *state =3D &iter->state;
>> +	struct net *net =3D seq_file_net(seq);
>> +	struct udp_seq_afinfo *afinfo =3D state->bpf_seq_afinfo;
>> +	struct udp_table *udptable;
>> +	struct sock *first_sk =3D NULL;
>> +	struct sock *sk;
>> +	unsigned int bucket_sks =3D 0;
>> +	bool resized =3D false;
>> +	int offset =3D 0;
>> +	int new_offset;
>> +
>> +	/* The current batch is done, so advance the bucket. */
>> +	if (iter->st_bucket_done) {
>> +		state->bucket++;
>> +		state->offset =3D 0;
>> +	}
>> +
>> +	udptable =3D udp_get_table_afinfo(afinfo, net);
>> +
>> +	if (state->bucket > udptable->mask) {
>> +		state->bucket =3D 0;
>> +		state->offset =3D 0;
>> +		return NULL;
>> +	}
>> +
>> +again:
>> +	/* New batch for the next bucket.
>> +	 * Iterate over the hash table to find a bucket with sockets =
matching
>> +	 * the iterator attributes, and return the first matching socket =
from
>> +	 * the bucket. The remaining matched sockets from the bucket are =
batched
>> +	 * before releasing the bucket lock. This allows BPF programs =
that are
>> +	 * called in seq_show to acquire the bucket lock if needed.
>> +	 */
>> +	iter->cur_sk =3D 0;
>> +	iter->end_sk =3D 0;
>> +	iter->st_bucket_done =3D false;
>> +	first_sk =3D NULL;
>> +	bucket_sks =3D 0;
>> +	offset =3D state->offset;
>> +	new_offset =3D offset;
>> +
>> +	for (; state->bucket <=3D udptable->mask; state->bucket++) {
>> +		struct udp_hslot *hslot =3D =
&udptable->hash[state->bucket];
>=20
> Use udptable->hash"2" which is hashed by addr and port. It will help =
to get a smaller batch. It was the comment given in v2.

I thought I replied to your review comment, but looks like I didn't. My =
bad!
I already gave it a shot, and I'll need to understand better how =
udptable->hash2 is populated. When I swapped hash with hash2, there were =
no sockets to iterate. Am I missing something obvious?=20

>=20
>> +
>> +		if (hlist_empty(&hslot->head)) {
>> +			offset =3D 0;
>> +			continue;
>> +		}
>> +
>> +		spin_lock_bh(&hslot->lock);
>> +		/* Resume from the last saved position in a bucket =
before
>> +		 * iterator was stopped.
>> +		 */
>> +		while (offset-- > 0) {
>> +			sk_for_each(sk, &hslot->head)
>> +				continue;
>> +		}
>=20
> hmm... how does the above while loop and sk_for_each loop actually =
work?
>=20
>> +		sk_for_each(sk, &hslot->head) {
>=20
> Here starts from the beginning of the hslot->head again. doesn't look =
right also.
>=20
> Am I missing something here?
>=20
>> +			if (seq_sk_match(seq, sk)) {
>> +				if (!first_sk)
>> +					first_sk =3D sk;
>> +				if (iter->end_sk < iter->max_sk) {
>> +					sock_hold(sk);
>> +					iter->batch[iter->end_sk++] =3D =
sk;
>> +				}
>> +				bucket_sks++;
>> +			}
>> +			new_offset++;
>=20
> And this new_offset is outside of seq_sk_match, so it is not counting =
for the seq_file_net(seq) netns alone.

This logic to resume iterator is buggy, indeed! So I was trying to =
account for the cases where the current bucket could've been updated =
since we release the bucket lock.=20
This is what I intended to do -

+loop:
                sk_for_each(sk, &hslot->head) {
                        if (seq_sk_match(seq, sk)) {
+                               /* Resume from the last saved position =
in the
+                                * bucket before iterator was stopped.
+                                */
+                               while (offset && offset-- > 0)
+                                       goto loop;
                                if (!first_sk)
                                        first_sk =3D sk;
                                if (iter->end_sk < iter->max_sk) {
@@ -3245,8 +3244,8 @@ static struct sock *bpf_iter_udp_batch(struct =
seq_file *seq)
                                        iter->batch[iter->end_sk++] =3D =
sk;
                                }
                                bucket_sks++;
+                              new_offset++;
                        }

This handles the case when sockets that weren't iterated in the previous =
round got deleted by the time iterator was resumed. But it's possible =
that previously iterated sockets got deleted before the iterator was =
later resumed, and the offset is now outdated. Ideally, iterator should =
be invalidated in this case, but there is no way to track this, is =
there? Any thoughts? =20


>=20
>> +		}
>> +		spin_unlock_bh(&hslot->lock);
>> +
>> +		if (first_sk)
>> +			break;
>> +
>> +		/* Reset the current bucket's offset before moving to =
the next bucket. */
>> +		offset =3D 0;
>> +		new_offset =3D 0;
>> +	}
>> +
>> +	/* All done: no batch made. */
>> +	if (!first_sk)
>> +		goto ret;
>> +
>> +	if (iter->end_sk =3D=3D bucket_sks) {
>> +		/* Batching is done for the current bucket; return the =
first
>> +		 * socket to be iterated from the batch.
>> +		 */
>> +		iter->st_bucket_done =3D true;
>> +		goto ret;
>> +	}
>> +	if (!resized && !bpf_iter_udp_realloc_batch(iter, bucket_sks * 3 =
/ 2)) {
>> +		resized =3D true;
>> +		/* Go back to the previous bucket to resize its batch. =
*/
>> +		state->bucket--;
>> +		goto again;
>> +	}
>> +ret:
>> +	state->offset =3D new_offset;
>> +	return first_sk;
>> +}
>> +
>> +static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, =
loff_t *pos)
>> +{
>> +	struct bpf_udp_iter_state *iter =3D seq->private;
>> +	struct udp_iter_state *state =3D &iter->state;
>> +	struct sock *sk;
>> +
>> +	/* Whenever seq_next() is called, the iter->cur_sk is
>> +	 * done with seq_show(), so unref the iter->cur_sk.
>> +	 */
>> +	if (iter->cur_sk < iter->end_sk) {
>> +		sock_put(iter->batch[iter->cur_sk++]);
>> +		++state->offset;
>=20
> but then,
> if I read it correctly, this offset counting is only for netns =
specific to seq_file_net(seq) because batch is specific to =
seq_file_net(net). Is it going to work?
>=20
>> +	}
>> +
>> +	/* After updating iter->cur_sk, check if there are more sockets
>> +	 * available in the current bucket batch.
>> +	 */
>> +	if (iter->cur_sk < iter->end_sk) {
>> +		sk =3D iter->batch[iter->cur_sk];
>> +	} else {
>> +		// Prepare a new batch.
>> +		sk =3D bpf_iter_udp_batch(seq);
>> +	}
>> +
>> +	++*pos;
>> +	return sk;
>> +}
>> +
>> +static void *bpf_iter_udp_seq_start(struct seq_file *seq, loff_t =
*pos)
>> +{
>> +	/* bpf iter does not support lseek, so it always
>> +	 * continue from where it was stop()-ped.
>> +	 */
>> +	if (*pos)
>> +		return bpf_iter_udp_batch(seq);
>> +
>> +	return SEQ_START_TOKEN;
>> +}
>> +
>>  static int udp_prog_seq_show(struct bpf_prog *prog, struct =
bpf_iter_meta *meta,
>>  			     struct udp_sock *udp_sk, uid_t uid, int =
bucket)
>>  {
>> @@ -3172,18 +3337,38 @@ static int bpf_iter_udp_seq_show(struct =
seq_file *seq, void *v)
>>  	struct bpf_prog *prog;
>>  	struct sock *sk =3D v;
>>  	uid_t uid;
>> +	bool slow;
>> +	int rc;
>>    	if (v =3D=3D SEQ_START_TOKEN)
>>  		return 0;
>>  +	slow =3D lock_sock_fast(sk);
>> +
>> +	if (unlikely(sk_unhashed(sk))) {
>> +		rc =3D SEQ_SKIP;
>> +		goto unlock;
>> +	}
>> +
>>  	uid =3D from_kuid_munged(seq_user_ns(seq), sock_i_uid(sk));
>>  	meta.seq =3D seq;
>>  	prog =3D bpf_iter_get_info(&meta, false);
>> -	return udp_prog_seq_show(prog, &meta, v, uid, state->bucket);
>> +	rc =3D udp_prog_seq_show(prog, &meta, v, uid, state->bucket);
>> +
>> +unlock:
>> +	unlock_sock_fast(sk, slow);
>> +	return rc;
>> +}
>> +
>> +static void bpf_iter_udp_unref_batch(struct bpf_udp_iter_state =
*iter)
>=20
> nit. Please use the same naming as in tcp-iter and unix-iter, so =
bpf_iter_udp_put_batch().

Ack
>=20
>> +{
>> +	while (iter->cur_sk < iter->end_sk)
>> +		sock_put(iter->batch[iter->cur_sk++]);
>>  }
>>    static void bpf_iter_udp_seq_stop(struct seq_file *seq, void *v)
>>  {
>> +	struct bpf_udp_iter_state *iter =3D seq->private;
>>  	struct bpf_iter_meta meta;
>>  	struct bpf_prog *prog;
>>  @@ -3194,15 +3379,31 @@ static void bpf_iter_udp_seq_stop(struct =
seq_file *seq, void *v)
>>  			(void)udp_prog_seq_show(prog, &meta, v, 0, 0);
>>  	}
>>  -	udp_seq_stop(seq, v);
>> +	if (iter->cur_sk < iter->end_sk) {
>> +		bpf_iter_udp_unref_batch(iter);
>> +		iter->st_bucket_done =3D false;
>> +	}
>>  }
>>    static const struct seq_operations bpf_iter_udp_seq_ops =3D {
>> -	.start		=3D udp_seq_start,
>> -	.next		=3D udp_seq_next,
>> +	.start		=3D bpf_iter_udp_seq_start,
>> +	.next		=3D bpf_iter_udp_seq_next,
>>  	.stop		=3D bpf_iter_udp_seq_stop,
>>  	.show		=3D bpf_iter_udp_seq_show,
>>  };
>> +
>> +static unsigned short seq_file_family(const struct seq_file *seq)
>> +{
>> +	const struct udp_seq_afinfo *afinfo;
>> +
>> +	/* BPF iterator: bpf programs to filter sockets. */
>> +	if (seq->op =3D=3D &bpf_iter_udp_seq_ops)
>> +		return AF_UNSPEC;
>> +
>> +	/* Proc fs iterator */
>> +	afinfo =3D pde_data(file_inode(seq->file));
>> +	return afinfo->family;
>> +}
>>  #endif
>>    const struct seq_operations udp_seq_ops =3D {
>> @@ -3413,9 +3614,30 @@ static struct pernet_operations __net_initdata =
udp_sysctl_ops =3D {
>>  DEFINE_BPF_ITER_FUNC(udp, struct bpf_iter_meta *meta,
>>  		     struct udp_sock *udp_sk, uid_t uid, int bucket)
>>  +static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state =
*iter,
>> +				      unsigned int new_batch_sz)
>> +{
>> +	struct sock **new_batch;
>> +
>> +	new_batch =3D kvmalloc_array(new_batch_sz, sizeof(*new_batch),
>> +				   GFP_USER | __GFP_NOWARN);
>> +	if (!new_batch)
>> +		return -ENOMEM;
>> +
>> +	bpf_iter_udp_unref_batch(iter);
>> +	kvfree(iter->batch);
>> +	iter->batch =3D new_batch;
>> +	iter->max_sk =3D new_batch_sz;
>> +
>> +	return 0;
>> +}
>> +
>> +#define INIT_BATCH_SZ 16
>> +
>>  static int bpf_iter_init_udp(void *priv_data, struct =
bpf_iter_aux_info *aux)
>>  {
>> -	struct udp_iter_state *st =3D priv_data;
>> +	struct bpf_udp_iter_state *iter =3D priv_data;
>> +	struct udp_iter_state *st =3D &iter->state;
>>  	struct udp_seq_afinfo *afinfo;
>>  	int ret;
>>  @@ -3427,24 +3649,39 @@ static int bpf_iter_init_udp(void =
*priv_data, struct bpf_iter_aux_info *aux)
>>  	afinfo->udp_table =3D NULL;
>>  	st->bpf_seq_afinfo =3D afinfo;
>>  	ret =3D bpf_iter_init_seq_net(priv_data, aux);
>> -	if (ret)
>> +	if (ret) {
>>  		kfree(afinfo);
>> +		return ret;
>> +	}
>> +	ret =3D bpf_iter_udp_realloc_batch(iter, INIT_BATCH_SZ);
>> +	if (ret) {
>> +		bpf_iter_fini_seq_net(priv_data);
>> +		return ret;
>> +	}
>> +	iter->cur_sk =3D 0;
>> +	iter->end_sk =3D 0;
>> +	iter->st_bucket_done =3D false;
>> +	st->bucket =3D 0;
>> +	st->offset =3D 0;
>=20
> =46rom looking at the tcp and unix counter part, I don't think this =
zeroings is necessary.

Ack

>=20
>> +
>>  	return ret;
>>  }
>>    static void bpf_iter_fini_udp(void *priv_data)
>>  {
>> -	struct udp_iter_state *st =3D priv_data;
>> +	struct bpf_udp_iter_state *iter =3D priv_data;
>> +	struct udp_iter_state *st =3D &iter->state;
>>  -	kfree(st->bpf_seq_afinfo);
>=20
> The st->bpf_seq_afinfo should no longer be needed. Please remove it =
from 'struct udp_iter_state'.
>=20
> The other AF_UNSPEC test in the existing udp_get_{first,next,...} =
should be cleaned up to use the refactored seq_sk_match() also.
>=20
> These two changes should be done as the first one (or two?) cleanup =
patches before the actual udp batching patch. The tcp-iter-batching =
patch set could be a reference point on how the patch set could be =
structured.

Ack for both the clean-up and reshuffling.=20

>=20
>>  	bpf_iter_fini_seq_net(priv_data);
>> +	kfree(st->bpf_seq_afinfo);
>> +	kvfree(iter->batch);
>>  }
>>    static const struct bpf_iter_seq_info udp_seq_info =3D {
>>  	.seq_ops		=3D &bpf_iter_udp_seq_ops,
>>  	.init_seq_private	=3D bpf_iter_init_udp,
>>  	.fini_seq_private	=3D bpf_iter_fini_udp,
>> -	.seq_priv_size		=3D sizeof(struct udp_iter_state),
>> +	.seq_priv_size		=3D sizeof(struct bpf_udp_iter_state),
>>  };
>>    static struct bpf_iter_reg udp_reg_info =3D {

