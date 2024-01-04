Return-Path: <bpf+bounces-19064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B75824985
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 21:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C25B7B24573
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 20:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D49B2C69B;
	Thu,  4 Jan 2024 20:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="WtsQL4Sl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D26F2C68F
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 20:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-35fb0dcec7aso3275645ab.3
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 12:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1704399686; x=1705004486; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWPnJkK2EvGcZ3Ya5buQPcpV9EdSnDZgPUe+jDZwtfo=;
        b=WtsQL4SlBswSg+m4LXvtaWgm4RpoPAh43TIaoHB56vKf30ner7TW5VYwwpuXaXa2Ln
         Pcfq10bMmiGIJ5JNXzVFCl6H/ILT5Gjnom1bcElwS5kHMZPH0CZb7tv1zah9zN5s5wMl
         p2yYRr33flJfwOesvDsmAZIUe0baEhHn+CFjPMvQ9j+SVQUxRCRkEexkcEfFIBtjj+vI
         +G/C+B+RHcqwk4+hXu9sv4902WPwElpm4lhpC4qPvxbJ2wy3YkiwgO5eIwbAiCOd2KM0
         vtjYNLFLBB6kCNU+0SnuPHbUFil0koRvcXn+CVZvIJGlkSMo+dYjfsxVo9w5wHH6zN3B
         iiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704399686; x=1705004486;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWPnJkK2EvGcZ3Ya5buQPcpV9EdSnDZgPUe+jDZwtfo=;
        b=OOb9SbTY8ssMkmLvD3gtDviD/NCgmbpRFJDUqN1n9I+aUukR6Rk/opzo9JHWIW3AkN
         00UAjKS1LWDVwz3bCivFGeecCdi5EpELU+i4led7BmXIoYbncuXA/IrB0Zp/Iz7H/l8Q
         wFzfLaFaNtRe9MbtiQEqTmBtc3GEeBo7vaTPvAkD8ExleToAIk1OtP7/OM2bEdZ5tmX0
         k3z1KoK7Ai5JwHWiJ6sCgdRC7o3afjSl068e3RMYEXUPPxOwC7uJEOEpL1QqidHhB036
         BGUxGt7akBL99tzKyiED4dcWe0QC9Z65sOm65OD7Z7yeiX1fsAyrBuXug74fbSDeup5d
         dxvg==
X-Gm-Message-State: AOJu0YxyuZwk1ZU0R/UPPHXEDyT6exc+phfubQ0GGMqW0PGRR5czjvfD
	D5RXn4+HH8hMax+AJM0YH0VqL2EFZ7q0AA==
X-Google-Smtp-Source: AGHT+IEPmxAc7c8GvNQJmvLk1vHjbHEZ23QEe0yI96aDdYUd8W0CSJSgYDvQ1PKKx40RRhcvbBQ7ig==
X-Received: by 2002:a05:6e02:148a:b0:35f:be89:a2d7 with SMTP id n10-20020a056e02148a00b0035fbe89a2d7mr1351326ilk.35.1704399686555;
        Thu, 04 Jan 2024 12:21:26 -0800 (PST)
Received: from ?IPv6:2601:647:4900:1fbb:a8d8:48c1:e100:f639? ([2601:647:4900:1fbb:a8d8:48c1:e100:f639])
        by smtp.gmail.com with ESMTPSA id d22-20020a63d656000000b005cdf0b46fecsm82704pgj.81.2024.01.04.12.21.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jan 2024 12:21:26 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH bpf 1/2] bpf: Avoid iter->offset making backward progress
 in bpf_iter_udp
From: Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <639b1f3f-cb53-4058-8426-14bd50f2b78f@linux.dev>
Date: Thu, 4 Jan 2024 12:21:25 -0800
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>,
 netdev@vger.kernel.org,
 kernel-team@meta.com,
 bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8AF6C653-61DB-4142-B2B3-5C6A7D966AF8@isovalent.com>
References: <20231219193259.3230692-1-martin.lau@linux.dev>
 <8d15f3a7-b7bc-1a45-0bdf-a0ccc311f576@iogearbox.net>
 <fc1b5650-72bb-4b09-bab4-f61b2186f673@linux.dev>
 <9f3697c1-ed15-4a3d-9113-c4437f421bb3@linux.dev>
 <8787f5c0-fed0-b8fa-997b-4d17d9966f13@iogearbox.net>
 <639b1f3f-cb53-4058-8426-14bd50f2b78f@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: Apple Mail (2.3608.120.23.2.7)



> On Dec 21, 2023, at 6:58 AM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>=20
> On 12/21/23 5:21 AM, Daniel Borkmann wrote:
>> On 12/21/23 5:45 AM, Martin KaFai Lau wrote:
>>> On 12/20/23 11:10 AM, Martin KaFai Lau wrote:
>>>> Good catch. It will unnecessary skip in the following batch/bucket =
if there is changes in the current batch/bucket.
>>>>=20
>>>>  =46rom looking at the loop again, I think it is better not to =
change the iter->offset during the for loop. Only update iter->offset =
after the for loop has concluded.
>>>>=20
>>>> The non-zero iter->offset is only useful for the first bucket, so =
does a test on the first bucket (state->bucket =3D=3D bucket) before =
skipping sockets. Something like this:
>>>>=20
>>>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>>>> index 89e5a806b82e..a993f364d6ae 100644
>>>> --- a/net/ipv4/udp.c
>>>> +++ b/net/ipv4/udp.c
>>>> @@ -3139,6 +3139,7 @@ static struct sock *bpf_iter_udp_batch(struct =
seq_file *seq)
>>>>       struct net *net =3D seq_file_net(seq);
>>>>       struct udp_table *udptable;
>>>>       unsigned int batch_sks =3D 0;
>>>> +    int bucket, bucket_offset;
>>>>       bool resized =3D false;
>>>>       struct sock *sk;
>>>>=20
>>>> @@ -3162,14 +3163,14 @@ static struct sock =
*bpf_iter_udp_batch(struct seq_file *seq)
>>>>       iter->end_sk =3D 0;
>>>>       iter->st_bucket_done =3D false;
>>>>       batch_sks =3D 0;
>>>> +    bucket =3D state->bucket;
>>>> +    bucket_offset =3D 0;
>>>>=20
>>>>       for (; state->bucket <=3D udptable->mask; state->bucket++) {
>>>>           struct udp_hslot *hslot2 =3D =
&udptable->hash2[state->bucket];
>>>>=20
>>>> -        if (hlist_empty(&hslot2->head)) {
>>>> -            iter->offset =3D 0;
>>>> +        if (hlist_empty(&hslot2->head))
>>>>               continue;
>>>> -        }
>>>>=20
>>>>           spin_lock_bh(&hslot2->lock);
>>>>           udp_portaddr_for_each_entry(sk, &hslot2->head) {
>>>> @@ -3177,8 +3178,9 @@ static struct sock *bpf_iter_udp_batch(struct =
seq_file *seq)
>>>>                   /* Resume from the last iterated socket at the
>>>>                    * offset in the bucket before iterator was =
stopped.
>>>>                    */
>>>> -                if (iter->offset) {
>>>> -                    --iter->offset;
>>>> +                if (state->bucket =3D=3D bucket &&
>>>> +                    bucket_offset < iter->offset) {
>>>> +                    ++bucket_offset;
>>>>                       continue;
>>>>                   }
>>>>                   if (iter->end_sk < iter->max_sk) {
>>>> @@ -3192,10 +3194,10 @@ static struct sock =
*bpf_iter_udp_batch(struct seq_file *seq)
>>>>=20
>>>>           if (iter->end_sk)
>>>>               break;
>>>> +    }
>>>>=20
>>>> -        /* Reset the current bucket's offset before moving to the =
next bucket. */
>>>> +    if (state->bucket !=3D bucket)
>>>>           iter->offset =3D 0;
>>>> -    }
>>>>=20
>>>>       /* All done: no batch made. */
>>>>       if (!iter->end_sk)
>>>=20
>>> I think I found another bug in the current bpf_iter_udp_batch(). The =
"state->bucket--;" at the end of the batch() function is wrong also. It =
does not need to go back to the previous bucket. After realloc with a =
larger batch array, it should retry on the "state->bucket" as is. I =
tried to force the bind() to use bucket 0 and bind a larger so_reuseport =
set (24 sockets). WARN_ON(state->bucket < 0) triggered.
>>>=20
>>> Going back to this bug (backward progress on --iter->offset), I =
think it is a bit cleaner to always reset iter->offset to 0 and advance =
iter->offset to the resume_offset only when needed. Something like this:
>> Hm, my assumption was.. why not do something like the below, and =
fully start over?
>> I'm mostly puzzled about the side-effects here, in particular, if for =
the rerun the sockets
>> in the bucket could already have changed.. maybe I'm still missing =
something - what do
>> we need to deal with exactly worst case when we need to go and retry =
everything, and what
>> guarantees do we have?
>> (only compile tested)
>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>> index 89e5a806b82e..ca62a4bb7bec 100644
>> --- a/net/ipv4/udp.c
>> +++ b/net/ipv4/udp.c
>> @@ -3138,7 +3138,8 @@ static struct sock *bpf_iter_udp_batch(struct =
seq_file *seq)
>>      struct udp_iter_state *state =3D &iter->state;
>>      struct net *net =3D seq_file_net(seq);
>>      struct udp_table *udptable;
>> -    unsigned int batch_sks =3D 0;
>> +    int orig_bucket, orig_offset;
>> +    unsigned int i, batch_sks =3D 0;
>>      bool resized =3D false;
>>      struct sock *sk;
>> @@ -3149,7 +3150,8 @@ static struct sock *bpf_iter_udp_batch(struct =
seq_file *seq)
>>      }
>>      udptable =3D udp_get_table_seq(seq, net);
>> -
>> +    orig_bucket =3D state->bucket;
>> +    orig_offset =3D iter->offset;
>>  again:
>>      /* New batch for the next bucket.
>>       * Iterate over the hash table to find a bucket with sockets =
matching
>> @@ -3211,9 +3213,15 @@ static struct sock *bpf_iter_udp_batch(struct =
seq_file *seq)
>>      if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 =
/ 2)) {
>>          resized =3D true;
>>          /* After allocating a larger batch, retry one more time to =
grab
>> -         * the whole bucket.
>> +         * the whole bucket. Drop the current refs since for the =
next
>> +         * attempt the composition could have changed, thus start =
over.
>>           */
>> -        state->bucket--;
>> +        for (i =3D 0; i < iter->end_sk; i++) {
>> +            sock_put(iter->batch[i]);
>> +            iter->batch[i] =3D NULL;
>> +        }
>> +        state->bucket =3D orig_bucket;
>> +        iter->offset =3D orig_offset;
>=20
> It does not need to start over from the orig_bucket. Once it advanced =
to the next bucket (state->bucket++), the orig_bucket is done. =
Otherwise, it may need to make backward progress here on the =
state->bucket. The batch size too small happens on the current =
state->bucket, so it should retry with the same state->bucket after =
realloc_batch(). If the state->bucket happens to be the orig_bucket =
(mean it has not advanced), it will skip the same orig_offset.


Thanks for the patch. I was on vacation, hence the delay in reviewing =
the patch. The changes around iter->offset match with what I had locally =
(the patch fell off my radar, sorry!).=20

I'm not sure about semantics of the resume operation for certain corner =
cases like these:

- The BPF UDP sockets iterator was stopped while iterating bucker #X, =
and the offset was set to 2. bpf_iter_udp_seq_stop then released =
references to the batched sockets, and marks the bucket X iterator state =
(aka iter->st_bucket_done) as false.=20
- Before the iterator is "resumed", the bucket #X was mutated such that =
the previously iterated sockets were removed, and new sockets were =
added.  With the current logic, the iterator will skip the first two =
sockets in the bucket, which isn't right. This is slightly different =
from the case where sockets were updated in the X -1 bucket *after* it =
was fully iterated. Since the bucket and sock locks are released, we =
don't have any guarantees that the underlying sockets table isn't =
mutated while the userspace has a valid iterator.
What do you think about such cases?=20


>=20
> If the orig_bucket had changed (e.g. having more sockets than the last =
time it was batched) after state->bucket++, it is arguably fine because =
it was added after the orig_bucket was completely captured in a batch =
before. The same goes for (orig_bucket-1) that could have changed during =
the whole udp_table iteration.
>=20
>>          goto again;
>>      }
>>  done:


