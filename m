Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5156E96A5
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 16:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjDTOIQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 10:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjDTOIP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 10:08:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2461BD1
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 07:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681999647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bd94SkBOdf4pAa7yMPFEsRuhF2EaUdw5+9dO5NREBgA=;
        b=i8SQ2ftoSwDElmYUzK2gJ13wnN8zrQGVK+OVgfoivCJDzKJoROPMQQXi43lzlhX/oj+eOj
        s5ObYUhWj559TsNQPqBhHqM3Zh3hEc1ksGvI2KmDozVkL+CPXBeNLYNRddRtn52CGBJaLI
        cBvJCyU35c0nZ2quyTUMxzUviEBBVw4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-iKAAYmPgOOWt08GrsygcqA-1; Thu, 20 Apr 2023 10:07:26 -0400
X-MC-Unique: iKAAYmPgOOWt08GrsygcqA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-74e29a14d5aso3355785a.1
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 07:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681999645; x=1684591645;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bd94SkBOdf4pAa7yMPFEsRuhF2EaUdw5+9dO5NREBgA=;
        b=biFVk72Oy6Caa7IERevgRhxA2RWSUBggq3URg0i/yE9/wwEq4u+gvkVL521k1R3HMk
         ZMQFP355tBcEdb0OwzuVZuwXRjKUND6GSPmbn2dZZYHOidyJhv6kD+t3Qi25kTPfbt9K
         JEF/FMVxqAC3tmwp/zuKKFEY8FceI8uMjy6rEKa/ORRa73XY4rOq9q6x3KfDGWQSesKf
         0gCCIJUbRrXnaTIL30bD6MQ/XRsFjBXMzXdoNuqWFbPP1AbOSVKTXK/WuxbYObSvzInj
         KEXQCjnTMqzVazPQKGso2ecPGiEaz4Zx0ypX2Y2OqdfybudvE6FLSBLRX7qyIfO30xxz
         CHRw==
X-Gm-Message-State: AAQBX9fIaws36CpDflFjztXPDcl6IO/5WWuMIHzkBZxVqPbqe0lzB/tM
        RiieSHBmjuKOlf4AQhxKxHRpcRWVVHDSQKFFYPsHSNmimqupVVmRT1CgUawRDXREsWvh3VF6xup
        q1oy60GZVUUBZ
X-Received: by 2002:a05:6214:4109:b0:5ed:c96e:ca4a with SMTP id kc9-20020a056214410900b005edc96eca4amr2053525qvb.1.1681999645202;
        Thu, 20 Apr 2023 07:07:25 -0700 (PDT)
X-Google-Smtp-Source: AKy350a3HlOq2lA1V9VaKVBWeL0N+gHwAdGpPGlfrghNY+2PBhq8iDt5KkRvz5S6W0bwFP71z2muFw==
X-Received: by 2002:a05:6214:4109:b0:5ed:c96e:ca4a with SMTP id kc9-20020a056214410900b005edc96eca4amr2053493qvb.1.1681999644835;
        Thu, 20 Apr 2023 07:07:24 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-230-117.dyn.eolo.it. [146.241.230.117])
        by smtp.gmail.com with ESMTPSA id a4-20020a0ce384000000b005ef658e65b8sm414974qvl.121.2023.04.20.07.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 07:07:24 -0700 (PDT)
Message-ID: <95b367cb42365a7afa9d19c3d4ec23b8e7b0837f.camel@redhat.com>
Subject: Re: [PATCH 4/7] bpf: udp: Implement batching for sockets iterator
From:   Paolo Abeni <pabeni@redhat.com>
To:     Aditi Ghag <aditi.ghag@isovalent.com>, bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Date:   Thu, 20 Apr 2023 16:07:21 +0200
In-Reply-To: <20230418153148.2231644-5-aditi.ghag@isovalent.com>
References: <20230418153148.2231644-1-aditi.ghag@isovalent.com>
         <20230418153148.2231644-5-aditi.ghag@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2023-04-18 at 15:31 +0000, Aditi Ghag wrote:
> Batch UDP sockets from BPF iterator that allows for overlapping locking
> semantics in BPF/kernel helpers executed in BPF programs.  This facilitat=
es
> BPF socket destroy kfunc (introduced by follow-up patches) to execute fro=
m
> BPF iterator programs.
>=20
> Previously, BPF iterators acquired the sock lock and sockets hash table
> bucket lock while executing BPF programs. This prevented BPF helpers that
> again acquire these locks to be executed from BPF iterators.  With the
> batching approach, we acquire a bucket lock, batch all the bucket sockets=
,
> and then release the bucket lock. This enables BPF or kernel helpers to
> skip sock locking when invoked in the supported BPF contexts.
>=20
> The batching logic is similar to the logic implemented in TCP iterator:
> https://lore.kernel.org/bpf/20210701200613.1036157-1-kafai@fb.com/.
>=20
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
> ---
>  net/ipv4/udp.c | 209 +++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 203 insertions(+), 6 deletions(-)
>=20
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 8689ed171776..f1c001641e53 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -3148,6 +3148,145 @@ struct bpf_iter__udp {
>  	int bucket __aligned(8);
>  };
> =20
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
> +	struct bpf_udp_iter_state *iter =3D seq->private;
> +	struct udp_iter_state *state =3D &iter->state;
> +	struct net *net =3D seq_file_net(seq);
> +	struct udp_seq_afinfo afinfo;
> +	struct udp_table *udptable;
> +	unsigned int batch_sks =3D 0;
> +	bool resized =3D false;
> +	struct sock *sk;
> +
> +	/* The current batch is done, so advance the bucket. */
> +	if (iter->st_bucket_done) {
> +		state->bucket++;
> +		iter->offset =3D 0;
> +	}
> +
> +	afinfo.family =3D AF_UNSPEC;
> +	afinfo.udp_table =3D NULL;
> +	udptable =3D udp_get_table_afinfo(&afinfo, net);
> +
> +again:
> +	/* New batch for the next bucket.
> +	 * Iterate over the hash table to find a bucket with sockets matching
> +	 * the iterator attributes, and return the first matching socket from
> +	 * the bucket. The remaining matched sockets from the bucket are batche=
d
> +	 * before releasing the bucket lock. This allows BPF programs that are
> +	 * called in seq_show to acquire the bucket lock if needed.
> +	 */
> +	iter->cur_sk =3D 0;
> +	iter->end_sk =3D 0;
> +	iter->st_bucket_done =3D false;
> +	batch_sks =3D 0;
> +
> +	for (; state->bucket <=3D udptable->mask; state->bucket++) {
> +		struct udp_hslot *hslot2 =3D &udptable->hash2[state->bucket];
> +
> +		if (hlist_empty(&hslot2->head)) {
> +			iter->offset =3D 0;
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
> +					iter->batch[iter->end_sk++] =3D sk;
> +				}
> +				batch_sks++;
> +			}
> +		}
> +		spin_unlock_bh(&hslot2->lock);
> +
> +		if (iter->end_sk)
> +			break;
> +
> +		/* Reset the current bucket's offset before moving to the next bucket.=
 */
> +		iter->offset =3D 0;
> +	}
> +
> +	/* All done: no batch made. */
> +	if (!iter->end_sk)
> +		return NULL;
> +
> +	if (iter->end_sk =3D=3D batch_sks) {
> +		/* Batching is done for the current bucket; return the first
> +		 * socket to be iterated from the batch.
> +		 */
> +		iter->st_bucket_done =3D true;
> +		goto ret;
> +	}
> +	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2)) {
> +		resized =3D true;
> +		/* Go back to the previous bucket to resize its batch. */
> +		state->bucket--;
> +		goto again;
> +	}
> +ret:
> +	return iter->batch[0];
> +}
> +
> +static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t=
 *pos)
> +{
> +	struct bpf_udp_iter_state *iter =3D seq->private;
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
> +		sk =3D iter->batch[iter->cur_sk];
> +	} else {
> +		// Prepare a new batch.

Minor nit: please use /* */ even for single line comments.

Thanks

Paolo

