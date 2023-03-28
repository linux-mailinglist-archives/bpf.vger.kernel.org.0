Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298586CCC20
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 23:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjC1VeD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 17:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC1VeC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 17:34:02 -0400
Received: from out-38.mta1.migadu.com (out-38.mta1.migadu.com [IPv6:2001:41d0:203:375::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D065826BE
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 14:34:00 -0700 (PDT)
Message-ID: <d03ee937-5c78-1c7a-c487-4fae508627aa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680039239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nc9ECcjUwazLFupUuxnVwyMddwwHCNc2HHq3hxpZjVY=;
        b=MrqQmjowRsNmGnS/06bz4S2WUGMUqzGwZObp0vUnmLqyzj0uVNWdiiORUfgPFC0VRmnZn8
        RgbHdzm5rx1ir7jCsj9h4JBITbmAqrSdo5e8/kdzFnjxCquYr9bejT9F9Q5fVtKjTdACZK
        IzvdrqCe4Cte/fbORjoTQjrzLO1bOPQ=
Date:   Tue, 28 Mar 2023 14:33:55 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next 1/4] bpf: Implement batching in UDP iterator
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     sdf@google.com, edumazet@google.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20230323200633.3175753-1-aditi.ghag@isovalent.com>
 <20230323200633.3175753-2-aditi.ghag@isovalent.com>
 <c77f069e-69a4-bc0a-dc92-c77cd0f7df08@linux.dev>
 <FF565E79-7C76-4525-8835-931146319F21@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <FF565E79-7C76-4525-8835-931146319F21@isovalent.com>
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

On 3/28/23 10:06 AM, Aditi Ghag wrote:
>>> +static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>>> +{
>>> +	struct bpf_udp_iter_state *iter = seq->private;
>>> +	struct udp_iter_state *state = &iter->state;
>>> +	struct net *net = seq_file_net(seq);
>>> +	struct udp_seq_afinfo *afinfo = state->bpf_seq_afinfo;
>>> +	struct udp_table *udptable;
>>> +	struct sock *first_sk = NULL;
>>> +	struct sock *sk;
>>> +	unsigned int bucket_sks = 0;
>>> +	bool resized = false;
>>> +	int offset = 0;
>>> +	int new_offset;
>>> +
>>> +	/* The current batch is done, so advance the bucket. */
>>> +	if (iter->st_bucket_done) {
>>> +		state->bucket++;
>>> +		state->offset = 0;
>>> +	}
>>> +
>>> +	udptable = udp_get_table_afinfo(afinfo, net);
>>> +
>>> +	if (state->bucket > udptable->mask) {
>>> +		state->bucket = 0;
>>> +		state->offset = 0;
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
>>> +	bucket_sks = 0;
>>> +	offset = state->offset;
>>> +	new_offset = offset;
>>> +
>>> +	for (; state->bucket <= udptable->mask; state->bucket++) {
>>> +		struct udp_hslot *hslot = &udptable->hash[state->bucket];
>>
>> Use udptable->hash"2" which is hashed by addr and port. It will help to get a smaller batch. It was the comment given in v2.
> 
> I thought I replied to your review comment, but looks like I didn't. My bad!
> I already gave it a shot, and I'll need to understand better how udptable->hash2 is populated. When I swapped hash with hash2, there were no sockets to iterate. Am I missing something obvious?

Take a look at udp_lib_lport_inuse2() on how it iterates.

> 
>>
>>> +
>>> +		if (hlist_empty(&hslot->head)) {
>>> +			offset = 0;
>>> +			continue;
>>> +		}
>>> +
>>> +		spin_lock_bh(&hslot->lock);
>>> +		/* Resume from the last saved position in a bucket before
>>> +		 * iterator was stopped.
>>> +		 */
>>> +		while (offset-- > 0) {
>>> +			sk_for_each(sk, &hslot->head)
>>> +				continue;
>>> +		}
>>
>> hmm... how does the above while loop and sk_for_each loop actually work?
>>
>>> +		sk_for_each(sk, &hslot->head) {
>>
>> Here starts from the beginning of the hslot->head again. doesn't look right also.
>>
>> Am I missing something here?
>>
>>> +			if (seq_sk_match(seq, sk)) {
>>> +				if (!first_sk)
>>> +					first_sk = sk;
>>> +				if (iter->end_sk < iter->max_sk) {
>>> +					sock_hold(sk);
>>> +					iter->batch[iter->end_sk++] = sk;
>>> +				}
>>> +				bucket_sks++;
>>> +			}
>>> +			new_offset++;
>>
>> And this new_offset is outside of seq_sk_match, so it is not counting for the seq_file_net(seq) netns alone.
> 
> This logic to resume iterator is buggy, indeed! So I was trying to account for the cases where the current bucket could've been updated since we release the bucket lock.
> This is what I intended to do -
> 
> +loop:
>                  sk_for_each(sk, &hslot->head) {
>                          if (seq_sk_match(seq, sk)) {
> +                               /* Resume from the last saved position in the
> +                                * bucket before iterator was stopped.
> +                                */
> +                               while (offset && offset-- > 0)
> +                                       goto loop;

still does not look right. merely a loop decrementing offset one at a time and 
then go back to the beginning of hslot->head?

A quick (untested and uncompiled) thought :

				/* Skip the first 'offset' number of sk
				 * and not putting them in the iter->batch[].
				 */
				if (offset) {
					offset--;
					continue;
				}

>                                  if (!first_sk)
>                                          first_sk = sk;
>                                  if (iter->end_sk < iter->max_sk) {
> @@ -3245,8 +3244,8 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>                                          iter->batch[iter->end_sk++] = sk;
>                                  }
>                                  bucket_sks++ > +                              new_offset++;
>                          }
> 
> This handles the case when sockets that weren't iterated in the previous round got deleted by the time iterator was resumed. But it's possible that previously iterated sockets got deleted before the iterator was later resumed, and the offset is now outdated. Ideally, iterator should be invalidated in this case, but there is no way to track this, is there? Any thoughts?

I would not worry about this update in-between case. race will happen anyway 
when the bucket lock is released. This should be very unlikely when hash"2" is used.


