Return-Path: <bpf+bounces-56447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C89A97774
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 22:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E03AA5A23B4
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 20:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA412BD587;
	Tue, 22 Apr 2025 20:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ve718Vhs"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F962BEC2C
	for <bpf@vger.kernel.org>; Tue, 22 Apr 2025 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745353548; cv=none; b=Qi/lbQwRX/t78j8cZv3LxfrDx+SQW6819Fc2h+vnJNLG2+z0SIHXPyF7hMKkDBtX5eyAT8SNFzaVW5PqvyFw4DnClt+O5ZCSyWdC9KE9NVqf2AgDM9Svi84gEoov3tbH46NcANFT6nw6+cCdGGXK3AtDwThWmXmBL1k/goPob4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745353548; c=relaxed/simple;
	bh=6klD8wp1SFY/CFMGSwYePzxz+z6f6TyvjdzcrehprFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qBTCO6uGcOvqlDQCQ7Javf3u+PUQknhz+q76jW2i+gFudAXX9oZkIsJlTO0mycLeqhKI5we8ADK3S3O/XEpr0FfkjdawLze6JcrkKtlcZZqt8DwvBe2Ea1EUStC/h8Diwbxz4po5itRyV7ukyIeOL4YnnNdQ/2T7GuAoYUADZRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ve718Vhs; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fa0a7936-145a-4f47-a858-66e46b829486@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745353533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XU3DmKNINxhHsP8L71cNqoNvT7XK2YvZkCZb/yPj3g=;
	b=ve718VhsPd+PWPv/t9BN8J7iJy/6HZjhykuCWdptCFS1s5xwN5K9vVm1GG+kVccAkaytCp
	nMeHbVLV1FfjAX+xGavO+/xqreVQicmtBoQRAkLXR9jG1rnANx/f0fIO/srEa63/zh3qQc
	SY1GKL3yRrhmDZWm46WMmeTJOxPayQM=
Date: Tue, 22 Apr 2025 13:25:28 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next 2/6] bpf: udp: Make sure iter->batch always
 contains a full bucket snapshot
To: Jordan Rife <jordan@jrife.io>
Cc: Aditi Ghag <aditi.ghag@isovalent.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250419155804.2337261-1-jordan@jrife.io>
 <20250419155804.2337261-3-jordan@jrife.io>
 <e3b08fdc-8a10-4491-a7a3-c11fed6d15ae@linux.dev>
 <CABi4-ojzWBaKBFDvu_aO2mRppYz46BZxybRXJ8d7sgzqaGtM_Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CABi4-ojzWBaKBFDvu_aO2mRppYz46BZxybRXJ8d7sgzqaGtM_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/22/25 11:02 AM, Jordan Rife wrote:
>> I found the "if (lock)" changes and its related changes make the code harder
>> to follow. This change is mostly to handle one special case,
>> avoid releasing the lock when "resizes" reaches the limit.
>>
>> Can this one case be specifically handled in the "for(bucket)" loop?
>>
>> With this special case, it can alloc exactly the "batch_sks" size
>> with GFP_ATOMIC. It does not need to put the sk or get the cookie.
>> It can directly continue from the "iter->batch[iter->end_sk - 1].sock".
>>
>> Something like this on top of this set. I reset the "resizes" on each new bucket,
>> removed the existing "done" label and avoid getting cookie in the last attempt.
>>
>> Untested code and likely still buggy. wdyt?
> 
> Overall I like it, and at a glance, it seems correct. The code before

Thanks for checking!

> (with the if (lock) stuff) made it harder to easily verify that the
> lock was always released for every code path. This structure makes it
> more clear. I'll adopt this for the next version of the series and do
> a bit more testing to make sure everything's sound.
> 
>>
>> #define MAX_REALLOC_ATTEMPTS 2
>>
>> static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>> {
>>        struct bpf_udp_iter_state *iter = seq->private;
>>        struct udp_iter_state *state = &iter->state;
>>        unsigned int find_cookie, end_cookie = 0;
>>        struct net *net = seq_file_net(seq);
>>        struct udp_table *udptable;
>>        unsigned int batch_sks = 0;
>>        int resume_bucket;
>>        struct sock *sk;
>>        int resizes = 0;
>>        int err = 0;
>>
>>        resume_bucket = state->bucket;
>>
>>        /* The current batch is done, so advance the bucket. */
>>        if (iter->st_bucket_done)
>>                state->bucket++;
>>
>>        udptable = udp_get_table_seq(seq, net);
>>
>> again:
>>        /* New batch for the next bucket.
>>         * Iterate over the hash table to find a bucket with sockets matching
>>         * the iterator attributes, and return the first matching socket from
>>         * the bucket. The remaining matched sockets from the bucket are batched
>>         * before releasing the bucket lock. This allows BPF programs that are
>>         * called in seq_show to acquire the bucket lock if needed.
>>         */
>>        find_cookie = iter->cur_sk;
>>        end_cookie = iter->end_sk;
>>        iter->cur_sk = 0;
>>        iter->end_sk = 0;
>>        iter->st_bucket_done = false;
>>        batch_sks = 0;
>>
>>        for (; state->bucket <= udptable->mask; state->bucket++) {
>>                struct udp_hslot *hslot2 = &udptable->hash2[state->bucket].hslot;
>>
>>                if (hlist_empty(&hslot2->head)) {
>>                        resizes = 0;
> 
> 
> 
>>                        continue;
>>                }
>>
>>                spin_lock_bh(&hslot2->lock);
>>
>>                /* Initialize sk to the first socket in hslot2. */
>>                sk = hlist_entry_safe(hslot2->head.first, struct sock,
>>                                      __sk_common.skc_portaddr_node);
>>                /* Resume from the first (in iteration order) unseen socket from
>>                 * the last batch that still exists in resume_bucket. Most of
>>                 * the time this will just be where the last iteration left off
>>                 * in resume_bucket unless that socket disappeared between
>>                 * reads.
>>                 *
>>                 * Skip this if end_cookie isn't set; this is the first
>>                 * batch, we're on bucket zero, and we want to start from the
>>                 * beginning.
>>                 */
>>                if (state->bucket == resume_bucket && end_cookie)
>>                        sk = bpf_iter_udp_resume(sk,
>>                                                 &iter->batch[find_cookie],
>>                                                 end_cookie - find_cookie);
>> last_realloc_retry:
>>                udp_portaddr_for_each_entry_from(sk) {
>>                        if (seq_sk_match(seq, sk)) {
>>                                if (iter->end_sk < iter->max_sk) {
>>                                        sock_hold(sk);
>>                                        iter->batch[iter->end_sk++].sock = sk;
>>                                }
>>                                batch_sks++;
>>                        }
>>                }
>>
>>                if (unlikely(resizes == MAX_REALLOC_ATTEMPTS)  &&
>>                    iter->end_sk && iter->end_sk != batch_sks) {
> 
> While iter->end_sk == batch_sks should always be true here after goto
> last_realloc_retry, I wonder if it's worth adding a sanity check:
> WARN_*ing and bailing out if we hit this condition twice? Not sure if
> I'm being overly paranoid here.

hmm... I usually won't go with WARN if the case is impossible.

The code is quite tricky here, so I think it is ok to have a WARN_ON_ONCE.

May be increment the "retries" in this special case also and it can stop hitting 
this case again for the same bucket. WARN outside of the for loop. Like:

> 
>>                        /* last realloc attempt to batch the whole
>>                         * bucket. Keep holding the lock to ensure the
>>                         * bucket will not be changed.
>>                         */
>>                        err = bpf_iter_udp_realloc_batch(iter, batch_sks, GFP_ATOMIC);
>>                        if (err) {
>>                                spin_unlock_bh(&hslot2->lock);
>>                                return ERR_PTR(err);
>>                        }
>>                        sk = iter->batch[iter->end_sk - 1].sock;
>>                        sk = hlist_entry_safe(sk->__sk_common.skc_portaddr_node.next,
>>                                              struct sock, __sk_common.skc_portaddr_node);
>>                        batch_sks = iter->end_sk;

			  /* and then WARN outside of the for loop */
                           retries++;


>>                        goto last_realloc_retry;
>>                }
>>
>>                spin_unlock_bh(&hslot2->lock);
>>
>>                if (iter->end_sk)
>>                        break;
>>
>>                /* Got an empty bucket after taking the lock */
>>                resizes = 0;
>>        }
>>
>>        /* All done: no batch made. */
>>        if (!iter->end_sk)
>>                return NULL;
>>
>>        if (iter->end_sk == batch_sks) {
>>                /* Batching is done for the current bucket; return the first
>>                 * socket to be iterated from the batch.
>>                 */
>>                iter->st_bucket_done = true;
>>                return iter->batch[0].sock;
>>        }

	  if (WARN_ON_ONCE(retries > MAX_REALLOC_ATTEMPTS))
                 return iter->batch[0].sock;

>>
>>        err = bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2, GFP_USER);
>>        if (err)
>>                return ERR_PTR(err);
>>
>>        resizes++;
>>        goto again;
>> }
>> static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
>>                                      unsigned int new_batch_sz, int flags)
>> {
>>        union bpf_udp_iter_batch_item *new_batch;
>>
>>        new_batch = kvmalloc_array(new_batch_sz, sizeof(*new_batch),
>>                                   flags | __GFP_NOWARN);
>>        if (!new_batch)
>>                return -ENOMEM;
>>
>>        if (flags != GFP_ATOMIC)
>>                bpf_iter_udp_put_batch(iter);
>>
>>        /* Make sure the new batch has the cookies of the sockets we haven't
>>         * visited yet.
>>         */
>>        memcpy(new_batch, iter->batch, sizeof(*iter->batch) * iter->end_sk);
>>        kvfree(iter->batch);
>>        iter->batch = new_batch;
>>        iter->max_sk = new_batch_sz;
>>
>>        return 0;
>> }
> 
> Jordan


