Return-Path: <bpf+bounces-19082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DA8824BE4
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 00:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EFDD287890
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 23:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DB72D60E;
	Thu,  4 Jan 2024 23:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Guyxy8wL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01C72D601
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 23:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6d9b13fe9e9so757832b3a.2
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 15:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1704411518; x=1705016318; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/g9uKrV3NamBwWIpq1xIqWU3SPxdT/PAwy/nydibQE=;
        b=Guyxy8wLypmxecP1YDmYCM9zP+iyRbhRG2tHwD6WZZO8k2hcGydFNWg2wUKD6EqOuG
         L1LDSjUIYWcwEuOXG29Yhm17cfq7bwFBPoLHplkjPxTo1ideI6YJPJB0HHdvI/QkNS4z
         6cHLuwnUKI32hMbW/zm+jwoojkkgI5wvIk45vI64Fpvs85Ivf80NQzCUtIO9ep6KDiZD
         qmCFhENff89ou39JYWBy9O0BSKI55eyf6glsNGLwVlNych7E7CP3RYNN7/qQEqnw/b1n
         ajfNmxF5RA5WeNSIhj4fS//ROLirEUDhtvHo4xI2fxdmT45XmkU+c9xi74RGbcdqX2Vs
         B6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704411518; x=1705016318;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/g9uKrV3NamBwWIpq1xIqWU3SPxdT/PAwy/nydibQE=;
        b=D3l64Sr0sozP+38Qxya5n77YjZWoHTOGlgP+zqmpVBJ5Wn/LS+kW5QlS15xy+mIwoQ
         9mqDUWB2k5oICIS9Ze1+cP8b0mt88lUuGCzeWNwekCxP7YiGf7tqLr8k9WcUETxgr7IY
         I7d6nW83/ooAHD5Z8QopUj172cpVeeUgfZZ/2a3NCztpZ8aL7jOBLI7I14Kh0skVsLDT
         dLg3YUqVnuepXtpllqn90kxsmIVgUB/Ai98VRmv3tT3hLJ0Iye9QsSIoe4Baojk/URDp
         3CSwdSWNknYQXANpPlg23xiECLXHYICzfMkghiJUn7BaddRcYZ7A+qoMohYMMhye6HMJ
         gp9A==
X-Gm-Message-State: AOJu0YwGntvEThpB/2Z7dd71qahrS0onjfQepxPEdHVYJG5jnjLJRI8u
	lx6mDnN0z1cmziIao0bAKhJDyeZYZyUD7GWKhhcHUwfj7GCOmg==
X-Google-Smtp-Source: AGHT+IFdM0iipX8XUCMoUltbk3Shx4lJPdgmQF7HQbLxG1NKslQwzjnQqB3jUyINT6U3+Xw1svz1lg==
X-Received: by 2002:a05:6a21:a588:b0:199:2178:ae48 with SMTP id gd8-20020a056a21a58800b001992178ae48mr1183959pzc.99.1704411518115;
        Thu, 04 Jan 2024 15:38:38 -0800 (PST)
Received: from ?IPv6:2601:647:4900:1fbb:5949:35a7:f1f4:a7bc? ([2601:647:4900:1fbb:5949:35a7:f1f4:a7bc])
        by smtp.gmail.com with ESMTPSA id x185-20020a6263c2000000b006d996ce80a6sm228010pfb.0.2024.01.04.15.38.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jan 2024 15:38:37 -0800 (PST)
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
In-Reply-To: <41818988-af0e-4d61-8505-4a13782ad61c@linux.dev>
Date: Thu, 4 Jan 2024 15:38:36 -0800
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>,
 netdev@vger.kernel.org,
 kernel-team@meta.com,
 bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <61BFE697-3A12-4D0E-A5B9-FA2677D988E2@isovalent.com>
References: <20231219193259.3230692-1-martin.lau@linux.dev>
 <8d15f3a7-b7bc-1a45-0bdf-a0ccc311f576@iogearbox.net>
 <fc1b5650-72bb-4b09-bab4-f61b2186f673@linux.dev>
 <9f3697c1-ed15-4a3d-9113-c4437f421bb3@linux.dev>
 <8787f5c0-fed0-b8fa-997b-4d17d9966f13@iogearbox.net>
 <639b1f3f-cb53-4058-8426-14bd50f2b78f@linux.dev>
 <8AF6C653-61DB-4142-B2B3-5C6A7D966AF8@isovalent.com>
 <41818988-af0e-4d61-8505-4a13782ad61c@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: Apple Mail (2.3608.120.23.2.7)



> On Jan 4, 2024, at 2:27 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>=20
> On 1/4/24 12:21 PM, Aditi Ghag wrote:
>>> On Dec 21, 2023, at 6:58 AM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>>>=20
>>> On 12/21/23 5:21 AM, Daniel Borkmann wrote:
>>>> On 12/21/23 5:45 AM, Martin KaFai Lau wrote:
>>>>> On 12/20/23 11:10 AM, Martin KaFai Lau wrote:
>>>>>> Good catch. It will unnecessary skip in the following =
batch/bucket if there is changes in the current batch/bucket.
>>>>>>=20
>>>>>>  =46rom looking at the loop again, I think it is better not to =
change the iter->offset during the for loop. Only update iter->offset =
after the for loop has concluded.
>>>>>>=20
>>>>>> The non-zero iter->offset is only useful for the first bucket, so =
does a test on the first bucket (state->bucket =3D=3D bucket) before =
skipping sockets. Something like this:
>>>>>>=20
>>>>>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>>>>>> index 89e5a806b82e..a993f364d6ae 100644
>>>>>> --- a/net/ipv4/udp.c
>>>>>> +++ b/net/ipv4/udp.c
>>>>>> @@ -3139,6 +3139,7 @@ static struct sock =
*bpf_iter_udp_batch(struct seq_file *seq)
>>>>>>       struct net *net =3D seq_file_net(seq);
>>>>>>       struct udp_table *udptable;
>>>>>>       unsigned int batch_sks =3D 0;
>>>>>> +    int bucket, bucket_offset;
>>>>>>       bool resized =3D false;
>>>>>>       struct sock *sk;
>>>>>>=20
>>>>>> @@ -3162,14 +3163,14 @@ static struct sock =
*bpf_iter_udp_batch(struct seq_file *seq)
>>>>>>       iter->end_sk =3D 0;
>>>>>>       iter->st_bucket_done =3D false;
>>>>>>       batch_sks =3D 0;
>>>>>> +    bucket =3D state->bucket;
>>>>>> +    bucket_offset =3D 0;
>>>>>>=20
>>>>>>       for (; state->bucket <=3D udptable->mask; state->bucket++) =
{
>>>>>>           struct udp_hslot *hslot2 =3D =
&udptable->hash2[state->bucket];
>>>>>>=20
>>>>>> -        if (hlist_empty(&hslot2->head)) {
>>>>>> -            iter->offset =3D 0;
>>>>>> +        if (hlist_empty(&hslot2->head))
>>>>>>               continue;
>>>>>> -        }
>>>>>>=20
>>>>>>           spin_lock_bh(&hslot2->lock);
>>>>>>           udp_portaddr_for_each_entry(sk, &hslot2->head) {
>>>>>> @@ -3177,8 +3178,9 @@ static struct sock =
*bpf_iter_udp_batch(struct seq_file *seq)
>>>>>>                   /* Resume from the last iterated socket at the
>>>>>>                    * offset in the bucket before iterator was =
stopped.
>>>>>>                    */
>>>>>> -                if (iter->offset) {
>>>>>> -                    --iter->offset;
>>>>>> +                if (state->bucket =3D=3D bucket &&
>>>>>> +                    bucket_offset < iter->offset) {
>>>>>> +                    ++bucket_offset;
>>>>>>                       continue;
>>>>>>                   }
>>>>>>                   if (iter->end_sk < iter->max_sk) {
>>>>>> @@ -3192,10 +3194,10 @@ static struct sock =
*bpf_iter_udp_batch(struct seq_file *seq)
>>>>>>=20
>>>>>>           if (iter->end_sk)
>>>>>>               break;
>>>>>> +    }
>>>>>>=20
>>>>>> -        /* Reset the current bucket's offset before moving to =
the next bucket. */
>>>>>> +    if (state->bucket !=3D bucket)
>>>>>>           iter->offset =3D 0;
>>>>>> -    }
>>>>>>=20
>>>>>>       /* All done: no batch made. */
>>>>>>       if (!iter->end_sk)
>>>>>=20
>>>>> I think I found another bug in the current bpf_iter_udp_batch(). =
The "state->bucket--;" at the end of the batch() function is wrong also. =
It does not need to go back to the previous bucket. After realloc with a =
larger batch array, it should retry on the "state->bucket" as is. I =
tried to force the bind() to use bucket 0 and bind a larger so_reuseport =
set (24 sockets). WARN_ON(state->bucket < 0) triggered.

Good catch! This error case would be hit when a batch needs to be =
resized for the very first bucket during iteration.

>>>>>=20
>>>>> Going back to this bug (backward progress on --iter->offset), I =
think it is a bit cleaner to always reset iter->offset to 0 and advance =
iter->offset to the resume_offset only when needed. Something like this:
>>>> Hm, my assumption was.. why not do something like the below, and =
fully start over?
>>>> I'm mostly puzzled about the side-effects here, in particular, if =
for the rerun the sockets
>>>> in the bucket could already have changed.. maybe I'm still missing =
something - what do
>>>> we need to deal with exactly worst case when we need to go and =
retry everything, and what
>>>> guarantees do we have?
>>>> (only compile tested)
>>>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>>>> index 89e5a806b82e..ca62a4bb7bec 100644
>>>> --- a/net/ipv4/udp.c
>>>> +++ b/net/ipv4/udp.c
>>>> @@ -3138,7 +3138,8 @@ static struct sock *bpf_iter_udp_batch(struct =
seq_file *seq)
>>>>      struct udp_iter_state *state =3D &iter->state;
>>>>      struct net *net =3D seq_file_net(seq);
>>>>      struct udp_table *udptable;
>>>> -    unsigned int batch_sks =3D 0;
>>>> +    int orig_bucket, orig_offset;
>>>> +    unsigned int i, batch_sks =3D 0;
>>>>      bool resized =3D false;
>>>>      struct sock *sk;
>>>> @@ -3149,7 +3150,8 @@ static struct sock *bpf_iter_udp_batch(struct =
seq_file *seq)
>>>>      }
>>>>      udptable =3D udp_get_table_seq(seq, net);
>>>> -
>>>> +    orig_bucket =3D state->bucket;
>>>> +    orig_offset =3D iter->offset;
>>>>  again:
>>>>      /* New batch for the next bucket.
>>>>       * Iterate over the hash table to find a bucket with sockets =
matching
>>>> @@ -3211,9 +3213,15 @@ static struct sock =
*bpf_iter_udp_batch(struct seq_file *seq)
>>>>      if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * =
3 / 2)) {
>>>>          resized =3D true;
>>>>          /* After allocating a larger batch, retry one more time to =
grab
>>>> -         * the whole bucket.
>>>> +         * the whole bucket. Drop the current refs since for the =
next
>>>> +         * attempt the composition could have changed, thus start =
over.
>>>>           */
>>>> -        state->bucket--;
>>>> +        for (i =3D 0; i < iter->end_sk; i++) {
>>>> +            sock_put(iter->batch[i]);
>>>> +            iter->batch[i] =3D NULL;
>>>> +        }
>>>> +        state->bucket =3D orig_bucket;
>>>> +        iter->offset =3D orig_offset;
>>>=20
>>> It does not need to start over from the orig_bucket. Once it =
advanced to the next bucket (state->bucket++), the orig_bucket is done. =
Otherwise, it may need to make backward progress here on the =
state->bucket. The batch size too small happens on the current =
state->bucket, so it should retry with the same state->bucket after =
realloc_batch(). If the state->bucket happens to be the orig_bucket =
(mean it has not advanced), it will skip the same orig_offset.
>> Thanks for the patch. I was on vacation, hence the delay in reviewing =
the patch. The changes around iter->offset match with what I had locally =
(the patch fell off my radar, sorry!).
>=20
> No problem. I am hitting it one and off in my local testing for some =
time, so decided to post the fix and the test. I have added a few more =
tests in patch 2. I will post v2 similar to the diff in my last reply of =
this thread in the early next week.
>=20
>> I'm not sure about semantics of the resume operation for certain =
corner cases like these:
>> - The BPF UDP sockets iterator was stopped while iterating bucker #X, =
and the offset was set to 2. bpf_iter_udp_seq_stop then released =
references to the batched sockets, and marks the bucket X iterator state =
(aka iter->st_bucket_done) as false.
>> - Before the iterator is "resumed", the bucket #X was mutated such =
that the previously iterated sockets were removed, and new sockets were =
added.  With the current logic, the iterator will skip the first two =
sockets in the bucket, which isn't right. This is slightly different =
from the case where sockets were updated in the X -1 bucket *after* it =
was fully iterated. Since the bucket and sock locks are released, we =
don't have any guarantees that the underlying sockets table isn't =
mutated while the userspace has a valid iterator.
>> What do you think about such cases?
> I believe it is something orthogonal to the bug fix here but we could =
use this thread to discuss.

Yes, indeed! But I piggy-backed on the same thread, as one potential =
option could be to always start iterating from the beginning of a =
bucket. (More details below.)
>=20
> This is not something specific to the bpf tcp/udp iter which uses the =
offset as a best effort to resume (e.g. the inet_diag and the =
/proc/net/{tcp[6],udp} are using similar strategy to resume). To improve =
it, it will need to introduce some synchronization with the (potentially =
fast path) writer side (e.g. bind, after 3WHS...etc). Not convinced it =
is worth it to catch these cases.

Right, synchronizing fast paths with the iterator logic seems like an =
overkill.

If we change the resume semantics, and make the iterator always start =
from the beginning of a bucket, it could solve some of these corner =
cases (and simplify the batching logic). The last I checked, the TCP =
(BPF) iterator logic was tightly coupled with the file based iterator =
(/proc/net/{tcp,udp}), so I'm not sure if it's an easy change if we were =
to change the resume semantics for both TCP and UDP BFP iterators?
Note that, this behavior would be similar to the lseek operation with =
seq_file [1]. Here is a snippet -=20

The stop() function closes a session; its job, of course, is to clean =
up. If dynamic memory is allocated for the iterator, stop() is the place =
to free it; if a lock was taken by start(), stop() must release that =
lock. The value that *pos was set to by the last next() call before =
stop() is remembered, and used for the first start() call of the next =
session unless lseek() has been called on the file; in that case next =
start() will be asked to start at position zero

[1] https://docs.kernel.org/filesystems/seq_file.html

>=20
> For the cases described above, skipped the newer sockets is arguably =
ok. These two new sockets will not be captured anyway even the batch was =
not stop()-ed in the middle. I also don't see how it is different =
semantically if the two new sockets are added to the X-1 bucket: the =
sockets are added after the bpf-iter scanned it regardless they are =
added to an earlier bucket or to an earlier location of the same bucket.
>=20
> That said, the bpf_iter_udp_seq_stop() should only happen if the =
bpf_prog bpf_seq_printf() something AND hit the seq->buf (PAGE_SIZE) << =
3) limit or the count in "read(iter_fd, buf, count)" limit.

Thanks for sharing the additional context. Would you have a link for =
these set of conditions where an iterator can be stopped? It'll be good =
to document the API semantics so that users are aware of the =
implications of setting the read size parameter too low.=20


> For this case, bpf_iter.c may be improved to capture the whole batch's =
seq_printf() to seq->buf first even the userspace's buf is full. It =
would be a separate effort if it is indeed needed.

Interesting proposal... Other option could be to invalidate the =
userspace iterator if an entire bucket batch is not being captured, so =
that userspace can retry with a bigger buffer.=20


>=20
> For the bpf_setsockopt and bpf_sock_destroy use case where it probably =
does not need to seq_printf() anything, it should not need to worry =
about it. The bpf_iter_udp_batch() should be able to grab the whole =
bucket such that the bpf_prog will not miss a socket to do =
bpf_setsockopt or bpf_sock_destroy.
>=20

Yup, agreed, the setsockeopt and sock_destroy cases are not affected.=20

>>>=20
>>> If the orig_bucket had changed (e.g. having more sockets than the =
last time it was batched) after state->bucket++, it is arguably fine =
because it was added after the orig_bucket was completely captured in a =
batch before. The same goes for (orig_bucket-1) that could have changed =
during the whole udp_table iteration.
>>>=20
>>>>          goto again;
>>>>      }
>>>>  done:


