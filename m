Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0893C6D4CBB
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 17:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjDCPzH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 11:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbjDCPyo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 11:54:44 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C1B3AAE
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 08:54:17 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id kc4so28441925plb.10
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 08:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680537257;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdR4vT91pnr0MWMg3wB2BHdXyoFS8auWWimU+/bGH9M=;
        b=ZzegZhyASM6d6lhWV9Rco7oomLfWsPPKIbo5x3rFmrCDPlHRV1VBv6FJB5qsKlDnWz
         aDSAHrNLrsaY/PyaCfBV1zeKDBjxwyv6BrevVzJmBmiU1ZcpbqSqIgvkm9baAX83n8PA
         2021UdJs0kuhPl/KezkuqXmbfERl/5IRlHzsyq4X7SSuVTIn9TQ7Gc8Ya4H5VuBIYIe9
         iLnwN1vNFXETpyhiJa4ZMbQrDxg9B+3+CqMHBWZfqkw4wTYkQ3dmnnJXY5gwVKY3kMDe
         G/Vq/QoVU/3NrM9hozKbnwuHZGMQ0oX5ZQyoBwns4AnJzjIP9qteKKIQRtQvnlm6DlVi
         mdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680537257;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdR4vT91pnr0MWMg3wB2BHdXyoFS8auWWimU+/bGH9M=;
        b=CYQfJQUE2TrL/RLeJafNTC5mtYq76HqQOzgpF5YG85J1aMcl5w/UmGBRvwDOGnWH/8
         jDPouk+YCvJEP4s4qrxApsxZFZMnfmy6cGUo4lXmULg9WFVbqM1x6CDsVF71HDcQM+fo
         RwfL4A9gvxFLKvzAlKN2yflTZX+/n9i9MqpgVHdh3mmWgNgygpxsRIlBzHSScFf4e3OZ
         /7v0kq+TOPoLEgn6hNK/Tq5ViYlj7cxCp3udHZMOhJTIlZuXKG8NCWUoo1jEjH1RXZ3x
         UCynArKHeQyA3PkzMk/UunIOrqGheADSpO+OuBcvCI3WfcNhdcKVFkAswOzSAovdxx7J
         cgiA==
X-Gm-Message-State: AAQBX9eR0S/FV4jIsvK8i1UaoDMQtLYAbIv3Jg5Q03Uj8nG7bm4YJiMf
        8WxzoAtt1iV+H6DzAkA0SdBCbQ==
X-Google-Smtp-Source: AKy350aPfPT2eqn4aUFDcJs3sfJiKSRkjWVdqkwsHzO36PNa9ve2AsmKU5Zao1I13WmT7g2aWPN+LQ==
X-Received: by 2002:a17:902:ec8f:b0:1a1:af34:ab35 with SMTP id x15-20020a170902ec8f00b001a1af34ab35mr48436466plg.2.1680537256883;
        Mon, 03 Apr 2023 08:54:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:b4b3:ae45:a8e8:1b15? ([2601:647:4900:1fbb:b4b3:ae45:a8e8:1b15])
        by smtp.gmail.com with ESMTPSA id jm23-20020a17090304d700b0019c91d3bdb4sm6782343plb.304.2023.04.03.08.54.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Apr 2023 08:54:16 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v5 bpf-next 4/7] bpf: udp: Implement batching for sockets
 iterator
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <acdafa2f-b127-5a5a-84f7-0a046e1ce0fa@linux.dev>
Date:   Mon, 3 Apr 2023 08:54:15 -0700
Cc:     kafai@fb.com, Stanislav Fomichev <sdf@google.com>,
        edumazet@google.com, Martin KaFai Lau <martin.lau@kernel.org>,
        bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B4E8E743-0098-4DB0-B280-EA7B2BC137CA@isovalent.com>
References: <20230330151758.531170-1-aditi.ghag@isovalent.com>
 <20230330151758.531170-5-aditi.ghag@isovalent.com>
 <acdafa2f-b127-5a5a-84f7-0a046e1ce0fa@linux.dev>
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



> On Mar 31, 2023, at 2:08 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>=20
> On 3/30/23 8:17 AM, Aditi Ghag wrote:
>> +static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state =
*iter,
>> +				      unsigned int new_batch_sz);
>>    static inline bool seq_sk_match(struct seq_file *seq, const struct =
sock *sk)
>>  {
>> @@ -3151,6 +3163,149 @@ static inline bool seq_sk_match(struct =
seq_file *seq, const struct sock *sk)
>>  		net_eq(sock_net(sk), seq_file_net(seq)));
>>  }
>>  +static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>> +{
>> +	struct bpf_udp_iter_state *iter =3D seq->private;
>> +	struct udp_iter_state *state =3D &iter->state;
>> +	struct net *net =3D seq_file_net(seq);
>> +	struct sock *first_sk =3D NULL;
>> +	struct udp_seq_afinfo afinfo;
>> +	struct udp_table *udptable;
>> +	unsigned int batch_sks =3D 0;
>> +	bool resized =3D false;
>> +	struct sock *sk;
>> +	int offset =3D 0;
>> +	int new_offset;
>> +
>> +	/* The current batch is done, so advance the bucket. */
>> +	if (iter->st_bucket_done) {
>> +		state->bucket++;
>> +		iter->offset =3D 0;
>> +	}
>> +
>> +	afinfo.family =3D AF_UNSPEC;
>> +	afinfo.udp_table =3D NULL;
>> +	udptable =3D udp_get_table_afinfo(&afinfo, net);
>> +
>> +	if (state->bucket > udptable->mask) {
>=20
> This test looks unnecessary. The for-loop below should take care of =
this case?

We could return early in case the iterator has reached the end of the =
hash table. I suppose reset of the bucket should only happen when user =
stops, and starts a new iterator round. =20

>=20
>> +		state->bucket =3D 0;
>=20
> Reset state->bucket here looks suspicious (or at least unnecessary) =
also. The iterator cannot restart from the beginning. or I am missing =
something here? This at least requires a comment if it is really needed.=20=

>=20
>> +		iter->offset =3D 0;
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
>> +	batch_sks =3D 0;
>> +	offset =3D iter->offset;
>> +
>> +	for (; state->bucket <=3D udptable->mask; state->bucket++) {
>> +		struct udp_hslot *hslot2 =3D =
&udptable->hash2[state->bucket];
>> +
>> +		if (hlist_empty(&hslot2->head)) {
>> +			offset =3D 0;
>> +			continue;
>> +		}
>> +		new_offset =3D offset;
>> +
>> +		spin_lock_bh(&hslot2->lock);
>> +		udp_portaddr_for_each_entry(sk, &hslot2->head) {
>> +			if (seq_sk_match(seq, sk)) {
>> +				/* Resume from the last iterated socket =
at the
>> +				 * offset in the bucket before iterator =
was stopped.
>> +				 */
>> +				if (offset) {
>> +					--offset;
>> +					continue;
>> +				}
>> +				if (!first_sk)
>> +					first_sk =3D sk;
>> +				if (iter->end_sk < iter->max_sk) {
>> +					sock_hold(sk);
>> +					iter->batch[iter->end_sk++] =3D =
sk;
>> +				}
>> +				batch_sks++;
>> +				new_offset++;
>> +			}
>> +		}
>> +		spin_unlock_bh(&hslot2->lock);
>> +
>> +		if (first_sk)
>> +			break;
>> +
>> +		/* Reset the current bucket's offset before moving to =
the next bucket. */
>> +		offset =3D 0;
>> +	}
>> +
>> +	/* All done: no batch made. */
>> +	if (!first_sk)
>=20
> Testing !iter->end_sk should be the same?

Sure, that could work too.

>=20
>> +		goto ret;
>> +
>> +	if (iter->end_sk =3D=3D batch_sks) {
>> +		/* Batching is done for the current bucket; return the =
first
>> +		 * socket to be iterated from the batch.
>> +		 */
>> +		iter->st_bucket_done =3D true;
>> +		goto ret;
>> +	}
>> +	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 =
/ 2)) {
>> +		resized =3D true;
>> +		/* Go back to the previous bucket to resize its batch. =
*/
>> +		state->bucket--;
>> +		goto again;
>> +	}
>> +ret:
>> +	iter->offset =3D new_offset;
>=20
> hmm... updating iter->offset looks not right and,
> does it need a new_offset?
>=20

This is a leftover from earlier versions. :( Sorry, I didn't do my due =
diligence here.=20

> afaict, either
>=20
> a) it can resume at the old bucket. In this case, the iter->offset =
should not change.
>=20
> or
>=20
> b) it moved to the next bucket and iter->offset should be 0.

Yes, that's the behavior I had in mind as well.=20

>=20
>> +	return first_sk;
>=20
> &iter->batch[0] is the first_sk. 'first_sk' variable is not needed =
then.

It's possible that we didn't find any socket to return, or resized batch =
didn't go through. So we can't always rely on iter->batch[0]. As an =
alternative, we could return early when a socket is found. Anyway either =
option seems fine.  =20=
