Return-Path: <bpf+bounces-10478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD0B7A8A67
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 19:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A77F281C31
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 17:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0A91A590;
	Wed, 20 Sep 2023 17:17:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD87479EE
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 17:16:58 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C19FA9
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 10:16:56 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68fe2470d81so17343b3a.1
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 10:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1695230216; x=1695835016; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYwRvNZSIbVvYcsjP7/mGng1taIa+q8dT51QL9d0Cbk=;
        b=d5ZxicKwvYDzZDIyxpRwIU4j2QoleyiC0sqdknoYeqna7W4Ka5lIip6HgKJf8sAdpG
         hRb8HmEXkpH6mRPp7PO26opb0QHp7PkluolXLd+16YjJLsyAzP6bIbJ8OrK4/NlueDC+
         8T2eUAJJhJX6xx1kniQ1DCOuZGVCxdmfeiUOMj78zXn1V88DiHjBfcY9QQcuTAoyAD3d
         Ce5A3vlYvLq2SH9wtVQibt7sXMbmfuXR2DOCeAlGeaGa7fNtdHDgNGAns5cSbdtjfn2y
         WcPDw8B401fgmBQvXusOfWI5FjzhpX8fEmRfUkSWzyvAONPOaL/GFM/kwEPCUCnp5I5i
         WSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695230216; x=1695835016;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYwRvNZSIbVvYcsjP7/mGng1taIa+q8dT51QL9d0Cbk=;
        b=PEZWDkiyjjW0eNlY3oEzn1UjX4P5VMCFhZ3U5nN+2LBcwBHg8HcMU3sMqPIXgh6qdw
         zwN83FEXML5euQROQQTvR9BjBoMDW6wp6ppkATSjc/3eE20S5iZGRevxjXn64HCHhm/D
         F5zufuiU3x1mJQqKCPn33VxD35JfhqmHLzBLEUH9uyj/pUNVyaxXnEk/oIKB0miTfLz1
         1N4olQB6vcIb4zb8FEYZc0I1JbK+MCSxSV23utsi4n0U8t00cT7cyDNmfrCRwSMc6Iyi
         2fWHRRK9iYrEGnS71Ft/ml2yTFCexYFN7xVvMetErwFW0NO/5g707ZMQjlqAvbaA0REf
         YFAw==
X-Gm-Message-State: AOJu0YxI8ychBPTutrawv1LAwmlG7rPMAsQgoY+9DZnl6lWIg+dcZsUg
	Xa0/4OTsJ6v+Uu4t6LALIT6DLg==
X-Google-Smtp-Source: AGHT+IGX0hV6Wb1tBEtR/OuSD3hhWU88zk8Wq0jmh1WmOSi5rHqT2vrJgOaxBqatemI2DS1aANrBAQ==
X-Received: by 2002:a05:6a20:3ca7:b0:13a:59b1:c884 with SMTP id b39-20020a056a203ca700b0013a59b1c884mr3678913pzj.40.1695230215934;
        Wed, 20 Sep 2023 10:16:55 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:850f:189d:ef1b:52b8? ([2601:647:4900:1fbb:850f:189d:ef1b:52b8])
        by smtp.gmail.com with ESMTPSA id fk1-20020a056a003a8100b00690fb385ea9sm762825pfb.47.2023.09.20.10.16.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Sep 2023 10:16:55 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v9 bpf-next 5/9] bpf: udp: Implement batching for sockets
 iterator
From: Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <f85fbac6-a1d7-3f63-9d0f-8eaa261ddb26@linux.dev>
Date: Wed, 20 Sep 2023 10:16:54 -0700
Cc: Stanislav Fomichev <sdf@google.com>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 bpf@vger.kernel.org,
 Network Development <netdev@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A2130EF3-793F-4D4A-BA99-03F89EF38844@isovalent.com>
References: <20230519225157.760788-1-aditi.ghag@isovalent.com>
 <20230519225157.760788-6-aditi.ghag@isovalent.com>
 <f85fbac6-a1d7-3f63-9d0f-8eaa261ddb26@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On Sep 19, 2023, at 5:38 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>=20
> On 5/19/23 3:51 PM, Aditi Ghag wrote:
>> +static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>> +{
>> +	struct bpf_udp_iter_state *iter =3D seq->private;
>> +	struct udp_iter_state *state =3D &iter->state;
>> +	struct net *net =3D seq_file_net(seq);
>> +	struct udp_table *udptable;
>> +	unsigned int batch_sks =3D 0;
>> +	bool resized =3D false;
>> +	struct sock *sk;
>> +
>> +	/* The current batch is done, so advance the bucket. */
>> +	if (iter->st_bucket_done) {
>> +		state->bucket++;
>> +		iter->offset =3D 0;
>> +	}
>> +
>> +	udptable =3D udp_get_table_seq(seq, net);
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
>> +	batch_sks =3D 0;
>> +
>> +	for (; state->bucket <=3D udptable->mask; state->bucket++) {
>> +		struct udp_hslot *hslot2 =3D =
&udptable->hash2[state->bucket];
>> +
>> +		if (hlist_empty(&hslot2->head)) {
>> +			iter->offset =3D 0;
>> +			continue;
>> +		}
>> +
>> +		spin_lock_bh(&hslot2->lock);
>> +		udp_portaddr_for_each_entry(sk, &hslot2->head) {
>> +			if (seq_sk_match(seq, sk)) {
>> +				/* Resume from the last iterated socket =
at the
>> +				 * offset in the bucket before iterator =
was stopped.
>> +				 */
>> +				if (iter->offset) {
>> +					--iter->offset;
>=20
> Hi Aditi, I think this part has a bug.
>=20
> When I run './test_progs -t bpf_iter/udp6' in a machine with some udp =
so_reuseport sockets, this test is never finished.
>=20
> A broken case I am seeing is when the bucket has >1 sockets and =
bpf_seq_read() can only get one sk at a time before it calls =
bpf_iter_udp_seq_stop().
>=20
> I did not try the change yet. However, from looking at the code where =
iter->offset is changed, --iter->offset here is the most likely culprit =
and it will make backward progress for the same bucket (state->bucket). =
Other places touching iter->offset look fine.
>=20
> It needs a local "int offset" variable for the zero test. Could you =
help to take a look, add (or modify) a test and fix it?
>=20
> The progs/bpf_iter_udp[46].c test can be used to reproduce. The =
test_udp[46] in prog_tests/bpf_iter.c needs to be changed though to =
ensure there is multiple sk in the same bucket. Probably a few =
so_reuseport sk should do.

Hi Martin,

Thanks for the report. I'll take a look.


>=20
> Thanks.
>=20
>> +					continue;
>> +				}
>> +				if (iter->end_
>=20


