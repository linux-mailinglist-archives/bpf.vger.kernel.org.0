Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82A66A7B76
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 07:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjCBGne (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 01:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjCBGnd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 01:43:33 -0500
Received: from out-60.mta1.migadu.com (out-60.mta1.migadu.com [IPv6:2001:41d0:203:375::3c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0BA20D38
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 22:43:31 -0800 (PST)
Message-ID: <9bafb2a2-288b-26c1-27c2-9a395e7f4894@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677739409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qrFTmeR9TTrb6KN4N0qDKqN8KYQf7zUVJW9appyA7xs=;
        b=BZqB+o0/kMJyWY5+ApaZlHRnS5845tcAWO3gbP3URWjObECzKW4s26scBG6fxNUzZw7gAE
        X6ZoLTu1le7dFFUcRcWU5a/uBZO62IdCs8vvYMjTDKdsbVviP+YX4nL5XbIZ/KEcYaQezU
        rjROcarIw5ApqYE7XK6bkqwK4/Cfx2g=
Date:   Wed, 1 Mar 2023 22:43:23 -0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 1/3] bpf: Implement batching in UDP iterator
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20230223215311.926899-1-aditi.ghag@isovalent.com>
 <20230223215311.926899-2-aditi.ghag@isovalent.com>
 <22705f9d-9b94-a4ec-3202-270fef1ed657@linux.dev>
 <67D9E31D-D45F-4C33-B354-2C9EC43ADD12@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <67D9E31D-D45F-4C33-B354-2C9EC43ADD12@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/28/23 6:40 PM, Aditi Ghag wrote:
> 
>>> +
>>> +		if (hlist_empty(&hslot->head))
>>> +			continue;
>>> +
>>> +		spin_lock_bh(&hslot->lock);
>>> +		sk_for_each(sk, &hslot->head) {
>>> +			if (seq_sk_match(seq, sk)) {
>>> +				if (first) {
>>> +					first_sk = sk;
>>> +					first = false;
>>> +				}
>>> +				if (iter->end_sk < iter->max_sk) {
>>> +					sock_hold(sk);
>>> +					iter->batch[iter->end_sk++] = sk;
>>> +				}
>>> +				bucket_sks++;
>>> +			}
>>> +		}
>>> +		spin_unlock_bh(&hslot->lock);
>>> +		if (first_sk)
>>> +			break;
>>> +	}
>>> +
>>> +	/* All done: no batch made. */
>>> +	if (!first_sk)
>>> +		return NULL;
>>
>> I think first_sk and bucket_sks need to be reset on the "again" case also?
>>
>> If bpf_iter_udp_seq_stop() is called before a batch has been fully processed by the bpf prog in ".show", how does the next bpf_iter_udp_seq_start() continue from where it left off? The bpf_tcp_iter remembers the bucket and the offset-in-this-bucket. I think bpf_udp_iter can do something similar.
> 
> Hmm, I suppose you are referring to the `tcp_seek_last_pos` logic? This was the [1] commit that added the optimization in v2.6, but only for TCP. Extending the same logic for UDP is out of the scope of this PR? Although reading the [1] commit description, the latency issue seems to be specific to the file based iterators, no? Of course, BPF iterators are quite new, and I'm not sure if we have the same "slowness" reported in that commit. Having said that, do we expect users to start from where they previously left off by stopping BPF iterators? Regardless, I'll do some testing to ensure that we at least don't crash.

It is about ensuring the bpf-udp-iter makes forward progress, although speeding 
up is another plus. The iteration may have to be stopped (ie. 
bpf_iter_udp_seq_stop) for other reasons. The bpf-(udp|tcp|unix)-iter is not 
only for doing bpf_setsockopt or bpf_sock_destroy. A major use case is to 
bpf_seq_printf. eg. when seq_has_overflowed() in bpf_seq_read, 
bpf_iter_udp_seq_stop will be called.

If I read this patch correctly, bpf_iter_udp_seq_start() always starts from the 
beginning of the current bucket. The bpf-iter cannot make forward progress if 
the bpf_iter_udp_seq_stop is called at the middle of the bucket.

The "resume" is currently done by udp_get_idx(, *pos..) but is taken away from 
bpf-udp-iter in this patch. udp_get_idx(...) starts counting from the very first 
bucket and could potentially be reused here. However, I believe this patch is 
easier to just resume from the current bucket. Everything is there, all it needs 
is to remember its previous position/offset of the bucket.

> 
> 
> [1] https://github.com/torvalds/linux/commit/a8b690f98baf9fb1902b8eeab801351ea603fa3a
> 
> 

