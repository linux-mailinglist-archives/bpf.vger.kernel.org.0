Return-Path: <bpf+bounces-19235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291BA827B95
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 00:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BEACB21AF9
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 23:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8D756751;
	Mon,  8 Jan 2024 23:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="HzR6Ew9u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B729156747
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 23:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5986d902ae6so400935eaf.3
        for <bpf@vger.kernel.org>; Mon, 08 Jan 2024 15:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1704756265; x=1705361065; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPSBbp9ZkK3DjLiJQ98AmTXwQJNlra7MUAA1GhykwOI=;
        b=HzR6Ew9uRkIiMxyfpKZWEaW5JMhlktGpVoRl321bQ8o7YxqjCCNXmJWOZFbBZQyBEc
         lk3xaqCzJb80H+39y6TS0RQ403aK6cWq3Hscy1iQiuTPlowja/NanjYWaiyX7YIo9WuK
         wL9/x8BfEsWnpwu2kBWg8KLW9XeJS8OazvGBVPL0PHwZLPLhNMioG4JX6P/bzD3Ms/wC
         pubcTPfVx2Wmz1nMAepVXmM4P6JUxU1hfOHVcJNQlFKWeSdc4zbshC6qR2RYmvk1T06E
         QDT8OXTOdMna9MXx/bIUZV+VeXUK5DXqgzh9EtM38RPQ/eZwEnjXd861c7hZyURQVEuM
         yaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704756265; x=1705361065;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPSBbp9ZkK3DjLiJQ98AmTXwQJNlra7MUAA1GhykwOI=;
        b=waacTiuAnaSOKdSEB/6CAaaJn45HWjxZrnonD17PXc0+/PgKqLfaIHiEQEOsNr7qx7
         G20E6RehdYw5izxWV/fXsFQznCctz3nu5/x9//WRbhzfAwUvWJZiA2RpmPIj01Lb9QVC
         iBA3CaRerR3OGC8ia85TzxDft1yyGMBxBKcvBa4CvqFvxFH7v+YudgufHGIe4i9keOzB
         33mjDDZk4fs1btZxcerxvcZD7H+YLxhFJmOp5kfGILdo56HgNUELU/FFJXRHMVWfxa7T
         qDXQ5iw6sLVdBjxEuPOS/qR7wGKCXI1uWFlsMdf8Laml0nZRjG5/H1MHvjMQK1tBGR+U
         tPoA==
X-Gm-Message-State: AOJu0YyDH+s1bGISCT1IjeqVq0wGtN/QD5yB1HcMjW94W8EKYhL9fktO
	8rUhWCrLqMY91UrDxuvSdPImMI437J+t1w==
X-Google-Smtp-Source: AGHT+IG6TjgDsF2/wiQZGTMuZxptSmvk3GWiEObIO6GHNnPzxuKZtxqFZlRulgKrzheBB4cQNX0BWQ==
X-Received: by 2002:a05:6358:919e:b0:175:5fcf:34c6 with SMTP id j30-20020a056358919e00b001755fcf34c6mr4611159rwa.43.1704756265456;
        Mon, 08 Jan 2024 15:24:25 -0800 (PST)
Received: from ?IPv6:2601:647:4900:1fbb:599e:4610:68fc:6ddd? ([2601:647:4900:1fbb:599e:4610:68fc:6ddd])
        by smtp.gmail.com with ESMTPSA id h16-20020a056a00001000b006cecaff9e29sm393892pfk.128.2024.01.08.15.24.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jan 2024 15:24:24 -0800 (PST)
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
In-Reply-To: <9f3c86e9-111c-4cf0-ad8b-aafbd301bbb3@linux.dev>
Date: Mon, 8 Jan 2024 15:24:22 -0800
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>,
 netdev@vger.kernel.org,
 kernel-team@meta.com,
 bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E12CF653-CCF3-497D-9B1F-AC8264390256@isovalent.com>
References: <20231219193259.3230692-1-martin.lau@linux.dev>
 <8d15f3a7-b7bc-1a45-0bdf-a0ccc311f576@iogearbox.net>
 <fc1b5650-72bb-4b09-bab4-f61b2186f673@linux.dev>
 <9f3697c1-ed15-4a3d-9113-c4437f421bb3@linux.dev>
 <8787f5c0-fed0-b8fa-997b-4d17d9966f13@iogearbox.net>
 <639b1f3f-cb53-4058-8426-14bd50f2b78f@linux.dev>
 <8AF6C653-61DB-4142-B2B3-5C6A7D966AF8@isovalent.com>
 <41818988-af0e-4d61-8505-4a13782ad61c@linux.dev>
 <61BFE697-3A12-4D0E-A5B9-FA2677D988E2@isovalent.com>
 <9f3c86e9-111c-4cf0-ad8b-aafbd301bbb3@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: Apple Mail (2.3608.120.23.2.7)



> On Jan 4, 2024, at 4:33 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>=20
> On 1/4/24 3:38 PM, Aditi Ghag wrote:
>>>> I'm not sure about semantics of the resume operation for certain =
corner cases like these:
>>>> - The BPF UDP sockets iterator was stopped while iterating bucker =
#X, and the offset was set to 2. bpf_iter_udp_seq_stop then released =
references to the batched sockets, and marks the bucket X iterator state =
(aka iter->st_bucket_done) as false.
>>>> - Before the iterator is "resumed", the bucket #X was mutated such =
that the previously iterated sockets were removed, and new sockets were =
added.  With the current logic, the iterator will skip the first two =
sockets in the bucket, which isn't right. This is slightly different =
from the case where sockets were updated in the X -1 bucket *after* it =
was fully iterated. Since the bucket and sock locks are released, we =
don't have any guarantees that the underlying sockets table isn't =
mutated while the userspace has a valid iterator.
>>>> What do you think about such cases?
>>> I believe it is something orthogonal to the bug fix here but we =
could use this thread to discuss.
>> Yes, indeed! But I piggy-backed on the same thread, as one potential =
option could be to always start iterating from the beginning of a =
bucket. (More details below.)
>>>=20
>>> This is not something specific to the bpf tcp/udp iter which uses =
the offset as a best effort to resume (e.g. the inet_diag and the =
/proc/net/{tcp[6],udp} are using similar strategy to resume). To improve =
it, it will need to introduce some synchronization with the (potentially =
fast path) writer side (e.g. bind, after 3WHS...etc). Not convinced it =
is worth it to catch these cases.
>> Right, synchronizing fast paths with the iterator logic seems like an =
overkill.
>> If we change the resume semantics, and make the iterator always start =
from the beginning of a bucket, it could solve some of these corner =
cases (and simplify the batching logic). The last I checked, the TCP =
(BPF) iterator logic was tightly coupled with the=20
>=20
> Always resume from the beginning of the bucket? hmm... then it is =
making backward progress and will hit the same bug again. or I =
miss-understood your proposal?

I presumed that the user would be required to pass a bigger buffer when =
seq_printf fails to capture the socket data being iterated (this was =
prior to when I wasn't aware of the logic that decided when to stop the =
sockets iterator).=20

Thanks for the code pointer in your last message, so I'll expand on the =
proposal below.

Also, we could continue to discuss if there are better ways to handle =
the cases where an iterator is stopped, but I would expect that we still =
need to fix the broken case in the current code, and get it backported. =
So I'll keep an eye out for your v2 patch.=20

>=20
>> file based iterator (/proc/net/{tcp,udp}), so I'm not sure if it's an =
easy change if we were to change the resume semantics for both TCP and =
UDP BFP iterators?
>> Note that, this behavior would be similar to the lseek operation with =
seq_file [1]. Here is a snippet -
>=20
> bpf_iter does not support lseek.
>=20
>> The stop() function closes a session; its job, of course, is to clean =
up. If dynamic memory is allocated for the iterator, stop() is the place =
to free it; if a lock was taken by start(), stop() must release that =
lock. The value that *pos was set to by the last next() call before =
stop() is remembered, and used for the first start() call of the next =
session unless lseek() has been called on the file; in that case next =
start() will be asked to start at position zero
>> [1] https://docs.kernel.org/filesystems/seq_file.html
>>>=20
>>> For the cases described above, skipped the newer sockets is arguably =
ok. These two new sockets will not be captured anyway even the batch was =
not stop()-ed in the middle. I also don't see how it is different =
semantically if the two new sockets are added to the X-1 bucket: the =
sockets are added after the bpf-iter scanned it regardless they are =
added to an earlier bucket or to an earlier location of the same bucket.
>>>=20
>>> That said, the bpf_iter_udp_seq_stop() should only happen if the =
bpf_prog bpf_seq_printf() something AND hit the seq->buf (PAGE_SIZE) << =
3) limit or the count in "read(iter_fd, buf, count)" limit.
>> Thanks for sharing the additional context. Would you have a link for =
these set of conditions where an iterator can be stopped? It'll be good =
to document the API semantics so that users are aware of the =
implications of setting the read size parameter too low.
>=20
> Most of the conditions should be in bpf_seq_read() in bpf_iter.c.

Ah! This is helpful.

>=20
> Again, this resume on offset behavior is not something specific to =
bpf-{tcp,udp}-iter.
>=20
>>> For this case, bpf_iter.c may be improved to capture the whole =
batch's seq_printf() to seq->buf first even the userspace's buf is full. =
It would be a separate effort if it is indeed needed.
>> Interesting proposal... Other option could be to invalidate the =
userspace iterator if an entire bucket batch is not being captured, so =
that userspace can retry with a bigger buffer.
>=20
> Not sure how to invalidate the user buffer without breaking the =
existing userspace app though.

By "invalidate the user buffer", I meant passing an error code to the =
userspace app, so that the userspace can allocate a bigger buffer =
accordingly. (I wasn't aware if/of how this was being done behind the =
scenes in bpf_seq_read, so thanks for the pointer.)
Based on my reading of the code, bpf_seq_read does seem to pass an error =
code when the passed buffer size isn't enough. When that happens, I =
would've expected the userspace iterator to be invalidated rather than =
resumed, and the BPF iterator program to be rerun with a larger buffer.

>=20
> The earlier idea on seq->buf was a quick thought. I suspect there is =
still things that need to think through if we did want to explore how to =
provide better guarantee to allow seq_printf() for one whole batch. I =
still feel it is overkill.

I'm still trying to fully grasp the logic in bpf_seq_read, but it seems =
like it's a generic function for all BPF iterators (and not just BPF =
TCP/UDP iterator). *sigh* So if we wanted to simplify the resume case =
such that we didn't have to keep track of offsets within a batch, we =
would have to tailor the bpf_seq_read specifically for the batching =
logic in BPF TCP/UDP iterator (being able to fully capture batched =
sockets printf). That would indeed be a separate effort, and would need =
more discussion. One possible solution could be to handle "resume" =
operation in seq->buf without involving the BPF TCP/UDP handlers, but I =
haven't fully thought of this proposal. /cc Daniel=20




