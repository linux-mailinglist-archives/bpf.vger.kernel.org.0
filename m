Return-Path: <bpf+bounces-1175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E59D770FBDE
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 18:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AEAF281338
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 16:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F49619517;
	Wed, 24 May 2023 16:42:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDC417FEA
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 16:42:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348C298
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 09:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684946560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/2B7F3M00+McC92sehlFDs+CO2Y7boezU8Ef7qqG54k=;
	b=VPUAB4LX5brO0Fe9MntY5FEjdz8DA6ezIl8zajTVKyADBJmvrNBfd5WbkcciHNKEBhIJYl
	3fHKY9Gn/EqE8gpPOXmJKzTtK2Y9HAEwxRHo7bMwd18p2DKZBpqzsOnWxE3+oPO8qx+k41
	9TNB1D4pJ3UKhATWK5qBHxHTMqHCXH4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-FB_4II_rPC20tu40J26DPg-1; Wed, 24 May 2023 12:42:39 -0400
X-MC-Unique: FB_4II_rPC20tu40J26DPg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-511b509b55bso1636408a12.0
        for <bpf@vger.kernel.org>; Wed, 24 May 2023 09:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684946558; x=1687538558;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/2B7F3M00+McC92sehlFDs+CO2Y7boezU8Ef7qqG54k=;
        b=ifE9XZolwQCyJH52V35xgbCl7Q/vRc48LnhQJW7xaF84Cbnm5LOmP4pVuQMbEA2m/j
         pmzgZR4Ckvx4oFgxMgId/TzgEjtn6vefyt3VKmaRclMa7DVCAdBRH2/O1pZg9D5NGriE
         IRmKEmOlhSUNB+yOuJ6a4j2XWKhM8+5JgEWfQwC0BW9OcoYzZpz0eqswL0UXEzf2fO8v
         q7J1/SnxjcSKWuIHTIVqvsNcqP0Zcr3EwfWSEQ/KZ+41odLL/kK+uM4wBi39mMI4WkTg
         1LnIqgnp+AQ0WBSME8Zfdz//DT98LjI1BJK4yaD615sssfQlbS+B8lE/SX4dCjiSj7o7
         W+ZQ==
X-Gm-Message-State: AC+VfDz8pnY2RXpnTXweoaDp2PyhP2ESO9YoIz3s/fl+6mNhhrjZFkcH
	c9n3YxtHTHK1ReY+UK6ZwGhTSXwxHK25mHugTMI41psczPaNdcnaWuunqHoJ4P5odMYjLLUH14n
	U3FmFnEC4EtYX
X-Received: by 2002:a17:907:26c3:b0:94f:2a13:4e01 with SMTP id bp3-20020a17090726c300b0094f2a134e01mr16908174ejc.74.1684946557866;
        Wed, 24 May 2023 09:42:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ74II5GwvSEw7I5JlQywPvZTw3pPPBDn1CoxlgtWKyNk7YpiSokSdYRyebPEoS8/p3MxttS+g==
X-Received: by 2002:a17:907:26c3:b0:94f:2a13:4e01 with SMTP id bp3-20020a17090726c300b0094f2a134e01mr16908157ejc.74.1684946557588;
        Wed, 24 May 2023 09:42:37 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id d5-20020a170906344500b0096f937b0d3esm5844588ejb.3.2023.05.24.09.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 09:42:36 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <13917453-bca3-82aa-e265-b652bda0d29d@redhat.com>
Date: Wed, 24 May 2023 18:42:35 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, lorenzo@kernel.org, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 willy@infradead.org
Subject: Re: [PATCH RFC net-next/mm V4 2/2] page_pool: Remove workqueue in new
 shutdown scheme
Content-Language: en-US
To: Yunsheng Lin <linyunsheng@huawei.com>,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>, linux-mm@kvack.org,
 Mel Gorman <mgorman@techsingularity.net>
References: <168485351546.2849279.13771638045665633339.stgit@firesoul>
 <168485357834.2849279.8073426325295894331.stgit@firesoul>
 <87h6s3nhv4.fsf@toke.dk> <1d4d9c47-c236-b661-4ac7-788102af8bed@huawei.com>
In-Reply-To: <1d4d9c47-c236-b661-4ac7-788102af8bed@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 24/05/2023 14.00, Yunsheng Lin wrote:
> On 2023/5/24 0:16, Toke Høiland-Jørgensen wrote:
>>>   void page_pool_destroy(struct page_pool *pool)
>>>   {
>>> +	unsigned int flags;
>>> +	u32 release_cnt;
>>> +	u32 hold_cnt;
>>> +
>>>   	if (!pool)
>>>   		return;
>>>   
>>> @@ -868,11 +894,45 @@ void page_pool_destroy(struct page_pool *pool)
>>>   	if (!page_pool_release(pool))
>>>   		return;
>>>   
>>> -	pool->defer_start = jiffies;
>>> -	pool->defer_warn  = jiffies + DEFER_WARN_INTERVAL;
>>> +	/* PP have pages inflight, thus cannot immediately release memory.
>>> +	 * Enter into shutdown phase, depending on remaining in-flight PP
>>> +	 * pages to trigger shutdown process (on concurrent CPUs) and last
>>> +	 * page will free pool instance.
>>> +	 *
>>> +	 * There exist two race conditions here, we need to take into
>>> +	 * account in the following code.
>>> +	 *
>>> +	 * 1. Before setting PP_FLAG_SHUTDOWN another CPU released the last
>>> +	 *    pages into the ptr_ring.  Thus, it missed triggering shutdown
>>> +	 *    process, which can then be stalled forever.
>>> +	 *
>>> +	 * 2. After setting PP_FLAG_SHUTDOWN another CPU released the last
>>> +	 *    page, which triggered shutdown process and freed pool
>>> +	 *    instance. Thus, its not safe to dereference *pool afterwards.
>>> +	 *
>>> +	 * Handling races by holding a fake in-flight count, via artificially
>>> +	 * bumping pages_state_hold_cnt, which assures pool isn't freed under
>>> +	 * us.  Use RCU Grace-Periods to guarantee concurrent CPUs will
>>> +	 * transition safely into the shutdown phase.
>>> +	 *
>>> +	 * After safely transition into this state the races are resolved.  For
>>> +	 * race(1) its safe to recheck and empty ptr_ring (it will not free
>>> +	 * pool). Race(2) cannot happen, and we can release fake in-flight count
>>> +	 * as last step.
>>> +	 */
>>> +	hold_cnt = READ_ONCE(pool->pages_state_hold_cnt) + 1;
>>> +	WRITE_ONCE(pool->pages_state_hold_cnt, hold_cnt);
>>> +	synchronize_rcu();
>>> +
>>> +	flags = READ_ONCE(pool->p.flags) | PP_FLAG_SHUTDOWN;
>>> +	WRITE_ONCE(pool->p.flags, flags);
>>> +	synchronize_rcu();
>>
>> Hmm, synchronize_rcu() can be quite expensive; why do we need two of
>> them? Should be fine to just do one after those two writes, as long as
>> the order of those writes is correct (which WRITE_ONCE should ensure)?
> 
> I am not sure rcu is the right scheme to fix the problem, as rcu is usually
> for one doing freeing/updating and many doing reading, while the case we
> try to fix here is all doing the reading and trying to do the freeing.
> 
> And there might still be data race here as below:
>       cpu0 calling page_pool_destroy()                cpu1 caling page_pool_release_page()
> 
> WRITE_ONCE(pool->pages_state_hold_cnt, hold_cnt);
>        WRITE_ONCE(pool->p.flags, flags);
>             synchronize_rcu();
>                                                               atomic_inc_return()
> 
>          release_cnt = atomic_inc_return();
>        page_pool_free_attempt(pool, release_cnt);
>          rcu call page_pool_free_rcu()
> 
> 				                     if (READ_ONCE(pool->p.flags) & PP_FLAG_SHUTDOWN)
>                                                                 page_pool_free_attempt()
> 
> As the rcu_read_[un]lock are only in page_pool_free_attempt(), cpu0
> will see the inflight being zero and triger the rcu to free the pp,
> and cpu1 see the pool->p.flags with PP_FLAG_SHUTDOWN set, it will
> access pool->pages_state_hold_cnt in __page_pool_inflight(), causing
> a use-after-free problem?
> 
> 
>>
>> Also, if we're adding this (blocking) operation in the teardown path we
>> risk adding latency to that path (network interface removal,
>> BPF_PROG_RUN syscall etc), so not sure if this actually ends up being an
>> improvement anymore, as opposed to just keeping the workqueue but
>> dropping the warning?
> 
> we might be able to remove the workqueue from the destroy path, a
> workqueue might be still needed to be trigered to call page_pool_free()
> in non-atomic context instead of calling page_pool_free() directly in
> page_pool_release_page(), as page_pool_release_page() might be called
> in atomic context and page_pool_free() requires a non-atomic context
> for put_device() and pool->disconnect using the mutex_lock() in
> mem_allocator_disconnect().
> 

I thought the call_rcu() callback provided the right context, but
skimming call_rcu() I think it doesn't.  Argh, I think you are right, we
cannot avoid the workqueue, as we need the non-atomic context.

Thanks for catching and pointing this out :-)

--Jesper


