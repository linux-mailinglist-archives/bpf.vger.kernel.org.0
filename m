Return-Path: <bpf+bounces-13185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C167D5E7C
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 00:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733D41C20DAA
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 22:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB4F3E48E;
	Tue, 24 Oct 2023 22:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="PcCuI9p3"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ACEC8D8
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 22:50:57 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2959310C3
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 15:50:56 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cab2c24ecdso32615785ad.0
        for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 15:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1698187855; x=1698792655; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4qf+lnZLUo134Z1U6vfhy3eHRKbls5dDuPRaiWkOGc=;
        b=PcCuI9p3mJ5i9+uG1liizEby6RmEDweCv/QehBE34o0jpZSQ9R2NMYBuYTL3J0soQQ
         JIcDXVh/nG3fjs9+eK6ydUz04vb92bgMe3prTTYIrdc5h9I4QYjad0KuDzGuITvqeVDk
         z0yIts5TWlJtmZwiq6PNtxPDkuhxOym0zaooYsYMIxxrW2uhyLqyA0n6jtVpD+3SQTLY
         QB/wbQcyCwq5ov+MFfURmrzXL8Ik6hnkM09hrdOWlaNieuzH4oR26+k+GpHaQnwaFsyo
         COMENOuC64cda4M3683ESRhc7glHBqJOEyWmSD2MjYBdJXaV9Lnemld8b6xZfDciUlU3
         Eanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698187855; x=1698792655;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4qf+lnZLUo134Z1U6vfhy3eHRKbls5dDuPRaiWkOGc=;
        b=Vs2GhFIF7EJccd7c3Vy9Txd+SkXR3+rWtROCliPePUlrkItaS+tuB3PdfBP3XHD4zH
         BYezKbVWkJNp00ksYLTnDkxl6eNzR6H3AX5jx4Vb5s4gG0yKds2Kdze/Xj47EMl3QrWh
         NB3/0ZqKzCu3o/0UmrTX1A/pbbeunpgsi7ZV/AF5O2FV6WoQNPA4v5RBn163bJ13wiwY
         nnDBzkUpKhdJ+Xr/hqxTnEYyW19onTj27SqDqAQIb2S9VofgOcEKWSYtwD0IT9tC0lYA
         TtBBVnrt2Dr5WMPYRsc1N9ZSWWl7P0Z0CWepZCn/KdXLU60iU84eoZxdIiH/y8VqHWzS
         uimA==
X-Gm-Message-State: AOJu0YwsWnensHY6JhJOY7MucYOjIBmYU4ksSbMtxd3jma/01ncNVdze
	KXJxSRawXazHy1kfQgiO56XcTw==
X-Google-Smtp-Source: AGHT+IE8cdiUg6wfbfJtXVULFUAD+Iy8qApoFgsnsaCsaXTd//p+R6d7oefDi0oFMfgIt/y8//xi+Q==
X-Received: by 2002:a17:903:2115:b0:1b9:e937:9763 with SMTP id o21-20020a170903211500b001b9e9379763mr9547278ple.12.1698187855451;
        Tue, 24 Oct 2023 15:50:55 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:bce9:ff4c:45b0:ba99? ([2601:647:4900:1fbb:bce9:ff4c:45b0:ba99])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c20c00b001ab2b4105ddsm7893599pll.60.2023.10.24.15.50.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Oct 2023 15:50:55 -0700 (PDT)
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
In-Reply-To: <4B5E1559-1538-462D-A6C5-1EF28DA2A4FD@isovalent.com>
Date: Tue, 24 Oct 2023 15:50:53 -0700
Cc: Stanislav Fomichev <sdf@google.com>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 bpf@vger.kernel.org,
 Network Development <netdev@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B29BDD0D-0262-477A-8124-E6CD70820515@isovalent.com>
References: <20230519225157.760788-1-aditi.ghag@isovalent.com>
 <20230519225157.760788-6-aditi.ghag@isovalent.com>
 <f85fbac6-a1d7-3f63-9d0f-8eaa261ddb26@linux.dev>
 <0B548508-C9AD-476C-A934-5D9D9B5DECB0@isovalent.com>
 <7075f350-80c7-b3a9-c1e7-65b8546dbc1f@linux.dev>
 <4B5E1559-1538-462D-A6C5-1EF28DA2A4FD@isovalent.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: Apple Mail (2.3608.120.23.2.7)



> On Sep 26, 2023, at 9:07 AM, Aditi Ghag <aditi.ghag@isovalent.com> =
wrote:
>=20
>=20
>=20
>> On Sep 25, 2023, at 10:02 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>>=20
>> On 9/25/23 4:34 PM, Aditi Ghag wrote:
>>>> On Sep 19, 2023, at 5:38 PM, Martin KaFai Lau =
<martin.lau@linux.dev> wrote:
>>>>=20
>>>> On 5/19/23 3:51 PM, Aditi Ghag wrote:
>>>>> +static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>>>>> +{
>>>>> +	struct bpf_udp_iter_state *iter =3D seq->private;
>>>>> +	struct udp_iter_state *state =3D &iter->state;
>>>>> +	struct net *net =3D seq_file_net(seq);
>>>>> +	struct udp_table *udptable;
>>>>> +	unsigned int batch_sks =3D 0;
>>>>> +	bool resized =3D false;
>>>>> +	struct sock *sk;
>>>>> +
>>>>> +	/* The current batch is done, so advance the bucket. */
>>>>> +	if (iter->st_bucket_done) {
>>>>> +		state->bucket++;
>>>>> +		iter->offset =3D 0;
>>>>> +	}
>>>>> +
>>>>> +	udptable =3D udp_get_table_seq(seq, net);
>>>>> +
>>>>> +again:
>>>>> +	/* New batch for the next bucket.
>>>>> +	 * Iterate over the hash table to find a bucket with sockets =
matching
>>>>> +	 * the iterator attributes, and return the first matching socket =
from
>>>>> +	 * the bucket. The remaining matched sockets from the bucket are =
batched
>>>>> +	 * before releasing the bucket lock. This allows BPF programs =
that are
>>>>> +	 * called in seq_show to acquire the bucket lock if needed.
>>>>> +	 */
>>>>> +	iter->cur_sk =3D 0;
>>>>> +	iter->end_sk =3D 0;
>>>>> +	iter->st_bucket_done =3D false;
>>>>> +	batch_sks =3D 0;
>>>>> +
>>>>> +	for (; state->bucket <=3D udptable->mask; state->bucket++) {
>>>>> +		struct udp_hslot *hslot2 =3D =
&udptable->hash2[state->bucket];
>>>>> +
>>>>> +		if (hlist_empty(&hslot2->head)) {
>>>>> +			iter->offset =3D 0;
>>>>> +			continue;
>>>>> +		}
>>>>> +
>>>>> +		spin_lock_bh(&hslot2->lock);
>>>>> +		udp_portaddr_for_each_entry(sk, &hslot2->head) {
>>>>> +			if (seq_sk_match(seq, sk)) {
>>>>> +				/* Resume from the last iterated socket =
at the
>>>>> +				 * offset in the bucket before iterator =
was stopped.
>>>>> +				 */
>>>>> +				if (iter->offset) {
>>>>> +					--iter->offset;
>>>>=20
>>>> Hi Aditi, I think this part has a bug.
>>>>=20
>>>> When I run './test_progs -t bpf_iter/udp6' in a machine with some =
udp so_reuseport sockets, this test is never finished.
>>>>=20
>>>> A broken case I am seeing is when the bucket has >1 sockets and =
bpf_seq_read() can only get one sk at a time before it calls =
bpf_iter_udp_seq_stop().
>>> Just so that I understand the broken case better, are you doing =
something in your BPF iterator program so that "bpf_seq_read() can only =
get one sk at a time"?
>>>>=20
>>>> I did not try the change yet. However, from looking at the code =
where iter->offset is changed, --iter->offset here is the most likely =
culprit and it will make backward progress for the same bucket =
(state->bucket). Other places touching iter->offset look fine.
>>>>=20
>>>> It needs a local "int offset" variable for the zero test. Could you =
help to take a look, add (or modify) a test and fix it?
>>>>=20
>>>> The progs/bpf_iter_udp[46].c test can be used to reproduce. The =
test_udp[46] in prog_tests/bpf_iter.c needs to be changed though to =
ensure there is multiple sk in the same bucket. Probably a few =
so_reuseport sk should do.
>>> The sock_destroy patch set had added a test with multiple =
so_reuseport sks in a bucket in order to exercise batching [1]. I was =
wondering if extending the test with an additional bucket should do it, =
or some more cases are required (asked for clarification above) to =
reproduce the issue.
>>=20
>> Number of bucket should not matter. It should only need a bucket to =
have multiple sockets.
>>=20
>> I did notice test_udp_server() has 5 so_reuseport udp sk in the same =
bucket when trying to understand how this issue was missed. It is enough =
on the hashtable side. This is the easier part and one =
start_reuseport_server() call will do. Having multiple sk in a bucket is =
not enough to reprod though.
>>=20
>> The bpf prog 'iter_udp6_server' in the sock_destroy test is not doing =
bpf_seq_printf(). bpf_seq_printf() is necessary to reproduce the issue. =
The read() buf from the userspace program side also needs to be small. =
It needs to hit the "if (seq->count >=3D size) break;" condition in the =
"while (1)" loop in the kernel/bpf/bpf_iter.c.
>>=20
>> You can try to add both to the sock_destroy test. I was suggesting =
bpf_iter/udp[46] test instead (i.e. the test_udp[46] function) because =
the bpf_seq_printf and the buf[] size are all aligned to reprod the =
problem already.  Try to add a start_reuseport_server(..., 5) to the =
beginning of test_udp6() in prog_tests/bpf_iter.c to ensure there is =
multiple udp sk in a bucket. It should be enough to reprod.
>=20
>=20
> Gotcha! I think I understand the repro steps. The offset field in =
question was added for this scenario where an iterator is stopped and =
resumed that the sock_destroy test cases don't entirely exercise.=20
> Thanks!=20


Just a small update: I was able to reproduce the issue where the =
so_reuseport test hangs by modifying the read buffer in the existing =
sock_destroy test (test_udp_server). I have a fix, and verified that the =
test doesn't hang with the fixed code. Will send a patch soon.


>=20
>>=20
>> In the final fix, I don't have strong preference on where the test =
should be.
>> Modifying one of the two existing tests (i.e. sock_destroy or =
bpf_iter) or a completely new test.
>>=20
>> Let me know if you have problem reproducing it. Thanks.
>>=20
>>> [1] =
https://elixir.bootlin.com/linux/v6.5/source/tools/testing/selftests/bpf/p=
rog_tests/sock_destroy.c#L146
>>>>=20
>>>> Thanks.
>>>>=20
>>>>> +					continue;
>>>>> +				}
>>>>> +				if (iter->end_


