Return-Path: <bpf+bounces-10878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F68C7AF03D
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 18:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CF40F281886
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 16:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4412430FB5;
	Tue, 26 Sep 2023 16:08:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F63B6AA3
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 16:08:03 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB1BFB
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 09:08:02 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-692c70bc440so4401532b3a.3
        for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 09:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1695744481; x=1696349281; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VsZxRY/uwkkYPV4D5/p+HrX7LrJ/okbVuPA8c+/p7U=;
        b=OFSKFAAfWXyqxnliwh80L1AWJjVZKRYlwn6KTCMXDUY7PCOaTnTg4Z1vE6olaY9Wev
         enTbPJa/AIMAPKf1GQulw8lt4MKduMUAndpdf/LkYcO5VRW9rDKGm1SSAEHgpadnednN
         2JruNs7F0c9Q+1LptLkyEpO0xQzupmdCK8sNf4joeVkkqQVoo5iVN3A2+Bhyia98wCRV
         XR+wJGLPyqS3WyPTJsqQ/0HtIWxkQ+ie9Qh13fjKIR/XgXOC3QLnUZ+6EnohywPO5pvE
         YAk/Fs2dg97dST6SzUxuMLJ2/aV3Z07d2XOxqdnNHGS3myWFz18BBghxJeRTpp48u1cg
         2Vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695744481; x=1696349281;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VsZxRY/uwkkYPV4D5/p+HrX7LrJ/okbVuPA8c+/p7U=;
        b=B/3v6VuF3X5ZEakJ8Mu8NNEqvKqMCHcKuJByYyym0b4DhK26L1fIYzwMBL7bYr2ATG
         1aSIC4SwEaaJMjypkC6Wg9rID7aLNUvx04rql5RTd8vUhweyiN0ZeqleAMj3NC76az2q
         2u0yTL+VelETcq+QgDnmJDVCZXNE/UZypYb3fOYWD/VII/680t4CrCL7hCVMullcSw7S
         pMiyYMEW14iIMbykNFzjbjAHqpIy9849BYnGE5Iyklx6l/AYjc611Ti/GIJEJXKzGn36
         vtNnLMRSmJTjWlINuL8KaYGZ9qh326zrfKvwJKpzEp9J1sVdZu2X5M8TZX344Skyqakp
         v9oA==
X-Gm-Message-State: AOJu0YyaxAxlqauZvK45+AHT0lC6UDJctkXzgnT79InlKXpfebdoX5pG
	O4i3pqChg7QnBXWyzOW7lsi6RQ==
X-Google-Smtp-Source: AGHT+IFDh76GGekuR8mvB5J/qaAASst09+B+SLDKyuwUZystRjxdt0H0IRkcc9q083TMwgo5QW38OQ==
X-Received: by 2002:a05:6a20:3ba8:b0:152:5f8b:359a with SMTP id b40-20020a056a203ba800b001525f8b359amr7334614pzh.28.1695744481416;
        Tue, 26 Sep 2023 09:08:01 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:8423:17b1:9f57:999f? ([2601:647:4900:1fbb:8423:17b1:9f57:999f])
        by smtp.gmail.com with ESMTPSA id n24-20020aa78a58000000b00690f662a1cbsm10143421pfa.0.2023.09.26.09.08.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Sep 2023 09:08:00 -0700 (PDT)
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
In-Reply-To: <7075f350-80c7-b3a9-c1e7-65b8546dbc1f@linux.dev>
Date: Tue, 26 Sep 2023 09:07:59 -0700
Cc: sdf@google.com,
 Martin KaFai Lau <martin.lau@kernel.org>,
 bpf@vger.kernel.org,
 Network Development <netdev@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4B5E1559-1538-462D-A6C5-1EF28DA2A4FD@isovalent.com>
References: <20230519225157.760788-1-aditi.ghag@isovalent.com>
 <20230519225157.760788-6-aditi.ghag@isovalent.com>
 <f85fbac6-a1d7-3f63-9d0f-8eaa261ddb26@linux.dev>
 <0B548508-C9AD-476C-A934-5D9D9B5DECB0@isovalent.com>
 <7075f350-80c7-b3a9-c1e7-65b8546dbc1f@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On Sep 25, 2023, at 10:02 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>=20
> On 9/25/23 4:34 PM, Aditi Ghag wrote:
>>> On Sep 19, 2023, at 5:38 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>>>=20
>>> On 5/19/23 3:51 PM, Aditi Ghag wrote:
>>>> +static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>>>> +{
>>>> +	struct bpf_udp_iter_state *iter =3D seq->private;
>>>> +	struct udp_iter_state *state =3D &iter->state;
>>>> +	struct net *net =3D seq_file_net(seq);
>>>> +	struct udp_table *udptable;
>>>> +	unsigned int batch_sks =3D 0;
>>>> +	bool resized =3D false;
>>>> +	struct sock *sk;
>>>> +
>>>> +	/* The current batch is done, so advance the bucket. */
>>>> +	if (iter->st_bucket_done) {
>>>> +		state->bucket++;
>>>> +		iter->offset =3D 0;
>>>> +	}
>>>> +
>>>> +	udptable =3D udp_get_table_seq(seq, net);
>>>> +
>>>> +again:
>>>> +	/* New batch for the next bucket.
>>>> +	 * Iterate over the hash table to find a bucket with sockets =
matching
>>>> +	 * the iterator attributes, and return the first matching socket =
from
>>>> +	 * the bucket. The remaining matched sockets from the bucket are =
batched
>>>> +	 * before releasing the bucket lock. This allows BPF programs =
that are
>>>> +	 * called in seq_show to acquire the bucket lock if needed.
>>>> +	 */
>>>> +	iter->cur_sk =3D 0;
>>>> +	iter->end_sk =3D 0;
>>>> +	iter->st_bucket_done =3D false;
>>>> +	batch_sks =3D 0;
>>>> +
>>>> +	for (; state->bucket <=3D udptable->mask; state->bucket++) {
>>>> +		struct udp_hslot *hslot2 =3D =
&udptable->hash2[state->bucket];
>>>> +
>>>> +		if (hlist_empty(&hslot2->head)) {
>>>> +			iter->offset =3D 0;
>>>> +			continue;
>>>> +		}
>>>> +
>>>> +		spin_lock_bh(&hslot2->lock);
>>>> +		udp_portaddr_for_each_entry(sk, &hslot2->head) {
>>>> +			if (seq_sk_match(seq, sk)) {
>>>> +				/* Resume from the last iterated socket =
at the
>>>> +				 * offset in the bucket before iterator =
was stopped.
>>>> +				 */
>>>> +				if (iter->offset) {
>>>> +					--iter->offset;
>>>=20
>>> Hi Aditi, I think this part has a bug.
>>>=20
>>> When I run './test_progs -t bpf_iter/udp6' in a machine with some =
udp so_reuseport sockets, this test is never finished.
>>>=20
>>> A broken case I am seeing is when the bucket has >1 sockets and =
bpf_seq_read() can only get one sk at a time before it calls =
bpf_iter_udp_seq_stop().
>> Just so that I understand the broken case better, are you doing =
something in your BPF iterator program so that "bpf_seq_read() can only =
get one sk at a time"?
>>>=20
>>> I did not try the change yet. However, from looking at the code =
where iter->offset is changed, --iter->offset here is the most likely =
culprit and it will make backward progress for the same bucket =
(state->bucket). Other places touching iter->offset look fine.
>>>=20
>>> It needs a local "int offset" variable for the zero test. Could you =
help to take a look, add (or modify) a test and fix it?
>>>=20
>>> The progs/bpf_iter_udp[46].c test can be used to reproduce. The =
test_udp[46] in prog_tests/bpf_iter.c needs to be changed though to =
ensure there is multiple sk in the same bucket. Probably a few =
so_reuseport sk should do.
>> The sock_destroy patch set had added a test with multiple =
so_reuseport sks in a bucket in order to exercise batching [1]. I was =
wondering if extending the test with an additional bucket should do it, =
or some more cases are required (asked for clarification above) to =
reproduce the issue.
>=20
> Number of bucket should not matter. It should only need a bucket to =
have multiple sockets.
>=20
> I did notice test_udp_server() has 5 so_reuseport udp sk in the same =
bucket when trying to understand how this issue was missed. It is enough =
on the hashtable side. This is the easier part and one =
start_reuseport_server() call will do. Having multiple sk in a bucket is =
not enough to reprod though.
>=20
> The bpf prog 'iter_udp6_server' in the sock_destroy test is not doing =
bpf_seq_printf(). bpf_seq_printf() is necessary to reproduce the issue. =
The read() buf from the userspace program side also needs to be small. =
It needs to hit the "if (seq->count >=3D size) break;" condition in the =
"while (1)" loop in the kernel/bpf/bpf_iter.c.
>=20
> You can try to add both to the sock_destroy test. I was suggesting =
bpf_iter/udp[46] test instead (i.e. the test_udp[46] function) because =
the bpf_seq_printf and the buf[] size are all aligned to reprod the =
problem already.  Try to add a start_reuseport_server(..., 5) to the =
beginning of test_udp6() in prog_tests/bpf_iter.c to ensure there is =
multiple udp sk in a bucket. It should be enough to reprod.


Gotcha! I think I understand the repro steps. The offset field in =
question was added for this scenario where an iterator is stopped and =
resumed that the sock_destroy test cases don't entirely exercise.=20
Thanks!=20

>=20
> In the final fix, I don't have strong preference on where the test =
should be.
> Modifying one of the two existing tests (i.e. sock_destroy or =
bpf_iter) or a completely new test.
>=20
> Let me know if you have problem reproducing it. Thanks.
>=20
>> [1] =
https://elixir.bootlin.com/linux/v6.5/source/tools/testing/selftests/bpf/p=
rog_tests/sock_destroy.c#L146
>>>=20
>>> Thanks.
>>>=20
>>>> +					continue;
>>>> +				}
>>>> +				if (iter->end_


