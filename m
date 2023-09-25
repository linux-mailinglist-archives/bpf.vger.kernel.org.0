Return-Path: <bpf+bounces-10818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 772577AE250
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 01:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DE94928175C
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 23:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E912262BC;
	Mon, 25 Sep 2023 23:34:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0221B26299
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 23:34:10 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78954101
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 16:34:09 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-690d9cda925so5718308b3a.3
        for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 16:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1695684849; x=1696289649; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k928c5B/SW0D5lenI2tI7Xku5YnRHi99kcL0QyA4ckQ=;
        b=E6l+yBitOxF5gsU3EQ7kDn5rRxHPK2p63YK616VuBeaYvo/z+RfJIqngEQyc8EnYHf
         gxD26AwtfjcVCRH7d7FpDUDpN6IJd2ndLj79LixrYOuAVSAUQ3r7Y76dHvJlgLZ+ZZ+7
         3j+OWmcUSRBzmP/17irffI9nX8Ey3tiWJlIBDCUwH2r6QOr7gffWvOk81dRWBL8BmPT6
         gIbmrdMgeeG1c0UxcGSYqLe475jbKyRnSYonjszLlCjjU9deslbAwf16JZePjPvYXHUy
         iQIdjyNKKZiyAysDYqVG184Nf6jYeHJaxB+hdH1LSelUteIAzIa1zP0Ih3AZHD3ztJKC
         yUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695684849; x=1696289649;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k928c5B/SW0D5lenI2tI7Xku5YnRHi99kcL0QyA4ckQ=;
        b=hhyRUs180QCZNrHjoDyLThYQJkgu+qpG5H+iVez7XPkgU9Vn7hBc2lNFePRdquyJkQ
         1MTvmo+AM2RVIhM2LqUdunxYdtPzp7Ugzx/WOYAJw8vnR7rlwXozACJpM3lnBblga4ZD
         ZlCFxAMCgqPa4C73FX7uKchUX1BP0CneV7qLV5QY9ZAKgoESjykDufd7K0tqW+qcxqtu
         QFjL4Q1H7XL68ulcNotPNIZJdqv0JPOPuMc8AiWdiR7p54Be2wUJYxZImmwxOBUb92WG
         QalOOHcSyWluWSCvg++pNHz6tdp6V/XsxCooHjorpQySN+nwOo64dt80QMfDBJieVSPj
         iLnQ==
X-Gm-Message-State: AOJu0YwHWcO6RdXrf2KmLigaAeVbAEqZTNkirKyDvpahg2btA6GH/cnF
	E87f+Z7Xcbm39ARWqjLrbV+wrL408QsFd9bxhwE=
X-Google-Smtp-Source: AGHT+IF2a/XiGuW4KVVaooEtACFI3mOT4QmTSe/i8UBeZRTJRsf3ApQsCfhuZdIKIn48RGb488StKA==
X-Received: by 2002:a05:6a00:2347:b0:690:42d5:3eea with SMTP id j7-20020a056a00234700b0069042d53eeamr6738414pfj.30.1695684848791;
        Mon, 25 Sep 2023 16:34:08 -0700 (PDT)
Received: from [192.168.86.239] (c-73-223-29-106.hsd1.ca.comcast.net. [73.223.29.106])
        by smtp.gmail.com with ESMTPSA id x52-20020a056a000bf400b0068fb8080939sm8677974pfu.65.2023.09.25.16.34.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Sep 2023 16:34:08 -0700 (PDT)
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
Date: Mon, 25 Sep 2023 16:34:06 -0700
Cc: sdf@google.com,
 Martin KaFai Lau <martin.lau@kernel.org>,
 bpf@vger.kernel.org,
 Network Development <netdev@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0B548508-C9AD-476C-A934-5D9D9B5DECB0@isovalent.com>
References: <20230519225157.760788-1-aditi.ghag@isovalent.com>
 <20230519225157.760788-6-aditi.ghag@isovalent.com>
 <f85fbac6-a1d7-3f63-9d0f-8eaa261ddb26@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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

Just so that I understand the broken case better, are you doing =
something in your BPF iterator program so that "bpf_seq_read() can only =
get one sk at a time"?=20

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


The sock_destroy patch set had added a test with multiple so_reuseport =
sks in a bucket in order to exercise batching [1]. I was wondering if =
extending the test with an additional bucket should do it, or some more =
cases are required (asked for clarification above) to reproduce the =
issue.=20


[1] =
https://elixir.bootlin.com/linux/v6.5/source/tools/testing/selftests/bpf/p=
rog_tests/sock_destroy.c#L146

>=20
> Thanks.
>=20
>> +					continue;
>> +				}
>> +				if (iter->end_
>=20


