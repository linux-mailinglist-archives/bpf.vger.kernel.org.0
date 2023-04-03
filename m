Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AEA6D513C
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 21:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjDCTV1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 15:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDCTV0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 15:21:26 -0400
Received: from out-28.mta0.migadu.com (out-28.mta0.migadu.com [91.218.175.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288B23AA6
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 12:20:52 -0700 (PDT)
Message-ID: <d7bb0535-f55f-317e-5073-6a36a88cb508@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680549633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/7hBTbJsfTR9QB96JLoNHp2l8RBU9tVDYO4pJS3wBvg=;
        b=Hcgd28QLsKk9cFw0c1oYK6LNRVwDD/obG/mpbChh33jhGp/D9JeWVykE3D4f9dNO4T3I/P
        fYL1z+gRwYjQDiq+UWwwwtni12zqHkX5zhDrkMv6zbkbOwiDLWABK88AjVjoSHNSiAj3DJ
        gu0wWEUfn8crNXxGu2h7qKQuUmq27Qg=
Date:   Mon, 3 Apr 2023 12:20:31 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v5 bpf-next 4/7] bpf: udp: Implement batching for sockets
 iterator
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     Stanislav Fomichev <sdf@google.com>, edumazet@google.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20230330151758.531170-1-aditi.ghag@isovalent.com>
 <20230330151758.531170-5-aditi.ghag@isovalent.com>
 <acdafa2f-b127-5a5a-84f7-0a046e1ce0fa@linux.dev>
 <B4E8E743-0098-4DB0-B280-EA7B2BC137CA@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <B4E8E743-0098-4DB0-B280-EA7B2BC137CA@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/3/23 8:54 AM, Aditi Ghag wrote:
> 
> 
>> On Mar 31, 2023, at 2:08 PM, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 3/30/23 8:17 AM, Aditi Ghag wrote:
>>> +static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
>>> +				      unsigned int new_batch_sz);
>>>     static inline bool seq_sk_match(struct seq_file *seq, const struct sock *sk)
>>>   {
>>> @@ -3151,6 +3163,149 @@ static inline bool seq_sk_match(struct seq_file *seq, const struct sock *sk)
>>>   		net_eq(sock_net(sk), seq_file_net(seq)));
>>>   }
>>>   +static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>>> +{
>>> +	struct bpf_udp_iter_state *iter = seq->private;
>>> +	struct udp_iter_state *state = &iter->state;
>>> +	struct net *net = seq_file_net(seq);
>>> +	struct sock *first_sk = NULL;
>>> +	struct udp_seq_afinfo afinfo;
>>> +	struct udp_table *udptable;
>>> +	unsigned int batch_sks = 0;
>>> +	bool resized = false;
>>> +	struct sock *sk;
>>> +	int offset = 0;
>>> +	int new_offset;
>>> +
>>> +	/* The current batch is done, so advance the bucket. */
>>> +	if (iter->st_bucket_done) {
>>> +		state->bucket++;
>>> +		iter->offset = 0;
>>> +	}
>>> +
>>> +	afinfo.family = AF_UNSPEC;
>>> +	afinfo.udp_table = NULL;
>>> +	udptable = udp_get_table_afinfo(&afinfo, net);
>>> +
>>> +	if (state->bucket > udptable->mask) {
>>
>> This test looks unnecessary. The for-loop below should take care of this case?
> 
> We could return early in case the iterator has reached the end of the hash table. I suppose reset of the bucket should only happen when user stops, and starts a new iterator round.

bucket should not go back because bpf-iter cannot lseek back. It is why I was 
confused in the following bucket reset back to zero.

It can just fall through to the following for-loop and...

> 
>>
>>> +		state->bucket = 0;
>>
>> Reset state->bucket here looks suspicious (or at least unnecessary) also. The iterator cannot restart from the beginning. or I am missing something here? This at least requires a comment if it is really needed.
>>
>>> +		iter->offset = 0;
>>> +		return NULL;
>>> +	}
>>> +
>>> +again:
>>> +	/* New batch for the next bucket.
>>> +	 * Iterate over the hash table to find a bucket with sockets matching
>>> +	 * the iterator attributes, and return the first matching socket from
>>> +	 * the bucket. The remaining matched sockets from the bucket are batched
>>> +	 * before releasing the bucket lock. This allows BPF programs that are
>>> +	 * called in seq_show to acquire the bucket lock if needed.
>>> +	 */
>>> +	iter->cur_sk = 0;
>>> +	iter->end_sk = 0;
>>> +	iter->st_bucket_done = false;
>>> +	first_sk = NULL;
>>> +	batch_sks = 0;
>>> +	offset = iter->offset;
>>> +
>>> +	for (; state->bucket <= udptable->mask; state->bucket++) {
>>> +		struct udp_hslot *hslot2 = &udptable->hash2[state->bucket];
>>> +
>>> +		if (hlist_empty(&hslot2->head)) {
>>> +			offset = 0;
>>> +			continue;
>>> +		}
>>> +		new_offset = offset;
>>> +
>>> +		spin_lock_bh(&hslot2->lock);
>>> +		udp_portaddr_for_each_entry(sk, &hslot2->head) {
>>> +			if (seq_sk_match(seq, sk)) {
>>> +				/* Resume from the last iterated socket at the
>>> +				 * offset in the bucket before iterator was stopped.
>>> +				 */
>>> +				if (offset) {
>>> +					--offset;
>>> +					continue;
>>> +				}
>>> +				if (!first_sk)
>>> +					first_sk = sk;
>>> +				if (iter->end_sk < iter->max_sk) {
>>> +					sock_hold(sk);
>>> +					iter->batch[iter->end_sk++] = sk;
>>> +				}
>>> +				batch_sks++;
>>> +				new_offset++;
>>> +			}
>>> +		}
>>> +		spin_unlock_bh(&hslot2->lock);
>>> +
>>> +		if (first_sk)
>>> +			break;
>>> +
>>> +		/* Reset the current bucket's offset before moving to the next bucket. */
>>> +		offset = 0;
>>> +	}
>>> +
>>> +	/* All done: no batch made. */
>>> +	if (!first_sk)
>>
>> Testing !iter->end_sk should be the same?
> 
> Sure, that could work too.
> 
>>
>>> +		goto ret;

... return NULL here because new_offset is not needed.

>>> +
>>> +	if (iter->end_sk == batch_sks) {
>>> +		/* Batching is done for the current bucket; return the first
>>> +		 * socket to be iterated from the batch.
>>> +		 */
>>> +		iter->st_bucket_done = true;
>>> +		goto ret;
>>> +	}
>>> +	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2)) {
>>> +		resized = true;
>>> +		/* Go back to the previous bucket to resize its batch. */
>>> +		state->bucket--;
>>> +		goto again;
>>> +	}
>>> +ret:
>>> +	iter->offset = new_offset;
>>
>> hmm... updating iter->offset looks not right and,
>> does it need a new_offset?
>>
> 
> This is a leftover from earlier versions. :( Sorry, I didn't do my due diligence here.
> 
>> afaict, either
>>
>> a) it can resume at the old bucket. In this case, the iter->offset should not change.
>>
>> or
>>
>> b) it moved to the next bucket and iter->offset should be 0.
> 
> Yes, that's the behavior I had in mind as well.
> 
>>
>>> +	return first_sk;
>>
>> &iter->batch[0] is the first_sk. 'first_sk' variable is not needed then.
> 
> It's possible that we didn't find any socket to return, or resized batch didn't go through. So we can't always rely on iter->batch[0]. As an alternative, we could return early when a socket is found. Anyway either option seems fine.

yeah, if it didn't find any socket, I was assuming the earlier !first_sk (or 
!iter->end_sk) check should just directly return NULL because there is no need 
to change the iter->offset.

If the resize fails, it will return whatever is in iter->batch[0] anyway.

I was asking to use iter->batch[0] instead of having a first_sk is because, when 
I was trying to understand why 'new_offset++' was needed at all, the 'if 
(!first_sk) first_sk = sk;' in the above 'udp_portaddr_for_each_entry' loop kept 
coming back to my head on why it needs to be done since first_sk is just an 
alias of iter->batch[0].
