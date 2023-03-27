Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8E16CA991
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 17:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjC0Pwb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 11:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjC0Pwb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 11:52:31 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A961C2
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 08:52:29 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so9326803pjz.1
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 08:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679932349;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raV4WIMSbpc2jw09P6H7B+CWa3rwJq3ep9QzqHZeJB8=;
        b=T/FKzEBVFhTuW9QT+QFZYPAkMmGMx/fiVnuKyuLQpdk5BuHCGgtCA2z9vh2LHY9QLZ
         N4TVIFz5p9a/xnwB5WoSAhAmgyS8eNfZw39Iv8kcD3smZKoktsZeMruxP2H9/x9t2nuU
         2Ojn1u3FQSXKM+qpgWKuST1zKbWbR5P1tpp4jBELlK3vKjTN6/qP2FTPmhFQNZvpRuJx
         GgHDjq0XM0Dzvj7Zx4SfSt2S+vFAQgSqMVBOJox1Y1yw1n3QRGrOY35asIHAvR4kb+gg
         d4Jd3eNi5qeDNnEXVb5fKpTTsEmfKItobK2Vlb0YkUH3ahgkX9CIXqXZxCkkdfYpMe1v
         uvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679932349;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=raV4WIMSbpc2jw09P6H7B+CWa3rwJq3ep9QzqHZeJB8=;
        b=g09/p3Iq3SDmdeyqfRV5BlCAdQPfneS02sTGoX8/mYny9/tUQSL606INOC3826OLFz
         N/7aBZdM3gnrakBz+P/UCsqPx0Dn6tIGO4r4zznQPv3S1jchcLubS7tdSWysX9KEOSn5
         SLC7iZAx4CdOkis/SZdTTJLiqaNRsJ06ZxeBZ5EQaJk0VO/yUTuQvsm/Zj6Xz/u6Wdrz
         S2+LYU7INixFdFoVwvj/do1ssaorzm53BjRoNnXxaA2tiD3eXSGUimt2m0nx0qNEr9T1
         5DtCbspi5t+E8jOe5fUXJ4J/zWqGeq2Q3IS762L1+sTjfbwYkE9lT57RnZZR9Q9jTdAu
         YHGw==
X-Gm-Message-State: AAQBX9d1YB+LrK6Kiu0bhIFkEioQAHAS2DLvfZ3OmOydKNvcpi3i9Ew4
        hVlbua2MZi7aOI+RB1s0jbNd3mI6qrmngLSAxGE=
X-Google-Smtp-Source: AKy350acU7qGAzfqai8wajBSA1h3qSyzQcfYtAGZ8JfXp3hUNIM4tTpZz+C6haK0Rk8YtyH0dJlcjA==
X-Received: by 2002:a17:902:d48b:b0:1a0:4046:23f2 with SMTP id c11-20020a170902d48b00b001a0404623f2mr14784181plg.56.1679932348821;
        Mon, 27 Mar 2023 08:52:28 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:5869:bd44:1921:332? ([2601:647:4900:1fbb:5869:bd44:1921:332])
        by smtp.gmail.com with ESMTPSA id h20-20020a170902f7d400b001a0763fa8d6sm19393165plw.98.2023.03.27.08.52.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Mar 2023 08:52:28 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v4 bpf-next 1/4] bpf: Implement batching in UDP iterator
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <ZB4cprCBXc/eoDuL@google.com>
Date:   Mon, 27 Mar 2023 08:52:26 -0700
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AD3A4F59-CEB5-4849-9286-F3002A362E55@isovalent.com>
References: <20230323200633.3175753-1-aditi.ghag@isovalent.com>
 <20230323200633.3175753-2-aditi.ghag@isovalent.com>
 <ZB4cprCBXc/eoDuL@google.com>
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



> On Mar 24, 2023, at 2:56 PM, Stanislav Fomichev <sdf@google.com> =
wrote:
>=20
> On 03/23, Aditi Ghag wrote:
>> Batch UDP sockets from BPF iterator that allows for overlapping =
locking
>> semantics in BPF/kernel helpers executed in BPF programs.  This =
facilitates
>> BPF socket destroy kfunc (introduced by follow-up patches) to execute =
from
>> BPF iterator programs.
>=20
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
>=20
>> The batching logic is similar to the logic implemented in TCP =
iterator:
>> https://lore.kernel.org/bpf/20210701200613.1036157-1-kafai@fb.com/.
>=20
>> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
>> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
>> ---
>>  include/net/udp.h |   1 +
>>  net/ipv4/udp.c    | 255 =
++++++++++++++++++++++++++++++++++++++++++++--
>>  2 files changed, 247 insertions(+), 9 deletions(-)
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
>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>> index c605d171eb2d..58c620243e47 100644
>> --- a/net/ipv4/udp.c
>> +++ b/net/ipv4/udp.c
>> @@ -3152,6 +3152,171 @@ struct bpf_iter__udp {
>>  	int bucket __aligned(8);
>>  };
>=20
>> +struct bpf_udp_iter_state {
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
>> +		sk_for_each(sk, &hslot->head) {
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
>=20
>>  	if (v =3D=3D SEQ_START_TOKEN)
>>  		return 0;
>=20
>=20
> [..]
>=20
>> +	slow =3D lock_sock_fast(sk);
>> +
>> +	if (unlikely(sk_unhashed(sk))) {
>> +		rc =3D SEQ_SKIP;
>> +		goto unlock;
>> +	}
>> +
>=20
> Should we use non-fast version here for consistency with tcp?

We could, but I don't see a problem with acquiring fast version for UDP =
so we could just stick with it. The TCP change warrants a code comment =
though, I'll add it in the next reversion.=20

>=20
>=20
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
>> +{
>> +	while (iter->cur_sk < iter->end_sk)
>> +		sock_put(iter->batch[iter->cur_sk++]);
>>  }
>=20
>>  static void bpf_iter_udp_seq_stop(struct seq_file *seq, void *v)
>>  {
>> +	struct bpf_udp_iter_state *iter =3D seq->private;
>>  	struct bpf_iter_meta meta;
>>  	struct bpf_prog *prog;
>=20
>> @@ -3194,15 +3379,31 @@ static void bpf_iter_udp_seq_stop(struct =
seq_file *seq, void *v)
>>  			(void)udp_prog_seq_show(prog, &meta, v, 0, 0);
>>  	}
>=20
>> -	udp_seq_stop(seq, v);
>> +	if (iter->cur_sk < iter->end_sk) {
>> +		bpf_iter_udp_unref_batch(iter);
>> +		iter->st_bucket_done =3D false;
>> +	}
>>  }
>=20
>>  static const struct seq_operations bpf_iter_udp_seq_ops =3D {
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
>=20
>>  const struct seq_operations udp_seq_ops =3D {
>> @@ -3413,9 +3614,30 @@ static struct pernet_operations __net_initdata =
udp_sysctl_ops =3D {
>>  DEFINE_BPF_ITER_FUNC(udp, struct bpf_iter_meta *meta,
>>  		     struct udp_sock *udp_sk, uid_t uid, int bucket)
>=20
>> +static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state =
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
>=20
>> @@ -3427,24 +3649,39 @@ static int bpf_iter_init_udp(void *priv_data, =
struct bpf_iter_aux_info *aux)
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
>> +
>>  	return ret;
>>  }
>=20
>>  static void bpf_iter_fini_udp(void *priv_data)
>>  {
>> -	struct udp_iter_state *st =3D priv_data;
>> +	struct bpf_udp_iter_state *iter =3D priv_data;
>> +	struct udp_iter_state *st =3D &iter->state;
>=20
>> -	kfree(st->bpf_seq_afinfo);
>>  	bpf_iter_fini_seq_net(priv_data);
>> +	kfree(st->bpf_seq_afinfo);
>> +	kvfree(iter->batch);
>>  }
>=20
>>  static const struct bpf_iter_seq_info udp_seq_info =3D {
>>  	.seq_ops		=3D &bpf_iter_udp_seq_ops,
>>  	.init_seq_private	=3D bpf_iter_init_udp,
>>  	.fini_seq_private	=3D bpf_iter_fini_udp,
>> -	.seq_priv_size		=3D sizeof(struct udp_iter_state),
>> +	.seq_priv_size		=3D sizeof(struct bpf_udp_iter_state),
>>  };
>=20
>>  static struct bpf_iter_reg udp_reg_info =3D {
>> --
>> 2.34.1

