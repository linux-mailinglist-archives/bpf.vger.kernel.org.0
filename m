Return-Path: <bpf+bounces-19092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335F0824C29
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 01:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C8E286A0A
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 00:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1270A47;
	Fri,  5 Jan 2024 00:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TTkRQ3qu"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E39185B
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 00:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9f3c86e9-111c-4cf0-ad8b-aafbd301bbb3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704414791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yNDHBXBIrjewK6yqLx3Z2BASgstxUcNngkXcOsFlrMM=;
	b=TTkRQ3qu/6i5Vu9Q8ixFv9B3ldADvT8A6NkNlFLH+PSGzUiooyD80czy/OBcYMeCnu5rRy
	C1p/x++5Xihcd64SolmqZHAx3XOVAvISoojxlUdYnXmuPepLitstJRzpQ4HK6BQs9O2i6n
	CiFzHvk168cOj10QWijzgvgZmihS24c=
Date: Thu, 4 Jan 2024 16:33:04 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/2] bpf: Avoid iter->offset making backward progress
 in bpf_iter_udp
Content-Language: en-US
To: Aditi Ghag <aditi.ghag@isovalent.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 netdev@vger.kernel.org, kernel-team@meta.com, bpf@vger.kernel.org
References: <20231219193259.3230692-1-martin.lau@linux.dev>
 <8d15f3a7-b7bc-1a45-0bdf-a0ccc311f576@iogearbox.net>
 <fc1b5650-72bb-4b09-bab4-f61b2186f673@linux.dev>
 <9f3697c1-ed15-4a3d-9113-c4437f421bb3@linux.dev>
 <8787f5c0-fed0-b8fa-997b-4d17d9966f13@iogearbox.net>
 <639b1f3f-cb53-4058-8426-14bd50f2b78f@linux.dev>
 <8AF6C653-61DB-4142-B2B3-5C6A7D966AF8@isovalent.com>
 <41818988-af0e-4d61-8505-4a13782ad61c@linux.dev>
 <61BFE697-3A12-4D0E-A5B9-FA2677D988E2@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <61BFE697-3A12-4D0E-A5B9-FA2677D988E2@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/4/24 3:38 PM, Aditi Ghag wrote:
>>> I'm not sure about semantics of the resume operation for certain corner cases like these:
>>> - The BPF UDP sockets iterator was stopped while iterating bucker #X, and the offset was set to 2. bpf_iter_udp_seq_stop then released references to the batched sockets, and marks the bucket X iterator state (aka iter->st_bucket_done) as false.
>>> - Before the iterator is "resumed", the bucket #X was mutated such that the previously iterated sockets were removed, and new sockets were added.  With the current logic, the iterator will skip the first two sockets in the bucket, which isn't right. This is slightly different from the case where sockets were updated in the X -1 bucket *after* it was fully iterated. Since the bucket and sock locks are released, we don't have any guarantees that the underlying sockets table isn't mutated while the userspace has a valid iterator.
>>> What do you think about such cases?
>> I believe it is something orthogonal to the bug fix here but we could use this thread to discuss.
> 
> Yes, indeed! But I piggy-backed on the same thread, as one potential option could be to always start iterating from the beginning of a bucket. (More details below.)
>>
>> This is not something specific to the bpf tcp/udp iter which uses the offset as a best effort to resume (e.g. the inet_diag and the /proc/net/{tcp[6],udp} are using similar strategy to resume). To improve it, it will need to introduce some synchronization with the (potentially fast path) writer side (e.g. bind, after 3WHS...etc). Not convinced it is worth it to catch these cases.
> 
> Right, synchronizing fast paths with the iterator logic seems like an overkill.
> 
> If we change the resume semantics, and make the iterator always start from the beginning of a bucket, it could solve some of these corner cases (and simplify the batching logic). The last I checked, the TCP (BPF) iterator logic was tightly coupled with the 

Always resume from the beginning of the bucket? hmm... then it is making 
backward progress and will hit the same bug again. or I miss-understood your 
proposal?

> file based iterator (/proc/net/{tcp,udp}), so I'm not sure if it's an easy change if we were to change the resume semantics for both TCP and UDP BFP iterators?
> Note that, this behavior would be similar to the lseek operation with seq_file [1]. Here is a snippet -

bpf_iter does not support lseek.

> 
> The stop() function closes a session; its job, of course, is to clean up. If dynamic memory is allocated for the iterator, stop() is the place to free it; if a lock was taken by start(), stop() must release that lock. The value that *pos was set to by the last next() call before stop() is remembered, and used for the first start() call of the next session unless lseek() has been called on the file; in that case next start() will be asked to start at position zero
> 
> [1] https://docs.kernel.org/filesystems/seq_file.html
> 
>>
>> For the cases described above, skipped the newer sockets is arguably ok. These two new sockets will not be captured anyway even the batch was not stop()-ed in the middle. I also don't see how it is different semantically if the two new sockets are added to the X-1 bucket: the sockets are added after the bpf-iter scanned it regardless they are added to an earlier bucket or to an earlier location of the same bucket.
>>
>> That said, the bpf_iter_udp_seq_stop() should only happen if the bpf_prog bpf_seq_printf() something AND hit the seq->buf (PAGE_SIZE) << 3) limit or the count in "read(iter_fd, buf, count)" limit.
> 
> Thanks for sharing the additional context. Would you have a link for these set of conditions where an iterator can be stopped? It'll be good to document the API semantics so that users are aware of the implications of setting the read size parameter too low.

Most of the conditions should be in bpf_seq_read() in bpf_iter.c.

Again, this resume on offset behavior is not something specific to 
bpf-{tcp,udp}-iter.

> 
> 
>> For this case, bpf_iter.c may be improved to capture the whole batch's seq_printf() to seq->buf first even the userspace's buf is full. It would be a separate effort if it is indeed needed.
> 
> Interesting proposal... Other option could be to invalidate the userspace iterator if an entire bucket batch is not being captured, so that userspace can retry with a bigger buffer.

Not sure how to invalidate the user buffer without breaking the existing 
userspace app though.

The earlier idea on seq->buf was a quick thought. I suspect there is still 
things that need to think through if we did want to explore how to provide 
better guarantee to allow seq_printf() for one whole batch. I still feel it is 
overkill.

