Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6116F1BDD
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 17:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjD1Prm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 11:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjD1Prl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 11:47:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9066512B
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 08:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682696812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/hcBafirGtbsKs3va60aDlPh2Tf2tewUCDGORUeB8Xo=;
        b=gTTG4AUzvIoExTFRpqCutSIBPZX7N+di4B2GWiZ6sX/c7LauywgTtVqAA88AEEpvDeqfBZ
        hOsDGrALKQhqIvBn+bsXQBPrrBzNVIMwonfUNsY1yL7TslpdCox5l5Pliu2yC2p9SYO6Tq
        HbXxrG5i7cgoyGxpWXeQZ6f4kgF1xh4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-FG5lAQmqMj-oDCAbKgSsYw-1; Fri, 28 Apr 2023 11:46:49 -0400
X-MC-Unique: FG5lAQmqMj-oDCAbKgSsYw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9532170e883so1223408066b.3
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 08:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682696808; x=1685288808;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/hcBafirGtbsKs3va60aDlPh2Tf2tewUCDGORUeB8Xo=;
        b=ATzQdebKmQuGKUOgvxYgJseNeqGascd4ulTU01I3BAeO26cI0rPTZYKmPgAcaGswN/
         wvIfOU17E6zHajpqP0g5h/5xMkvBmOy467f+/J8FmxLcS5b2zNpcFO/3PgKRasnSLOg7
         Ke7qdJC2IedHh+lYAWo+HFKYBbMn9HlbgCtgb/I30HcEYEq75zfB4e1v8tvOh5d+wSQF
         R4l9mRTZO1NiZBhWEn8Oru227IYVmh5xVPy047j+lkk6ahpqwzZWFJ5i0G2SzucOiYCY
         Qb86pPj8EmFMOsduXiqYYqLrEOrFELaVzmb46haa2S6l5CjaC+wGG31ahFe+VhKfvME5
         2uIw==
X-Gm-Message-State: AC+VfDyAbOtvTgx4AksBMKNIeBB3Rdvno/n5l6nJUR4uK5b5JsgF9uze
        02RRdQfvktXGGDwViU+0LnVNgZEeCp8vuDLZjQNs0P18UXauWcOSTzFoB9DsD+qqli9PhZ723/N
        ZRfzWbj0rN//t
X-Received: by 2002:a17:907:1629:b0:94a:5ecb:6ea7 with SMTP id hb41-20020a170907162900b0094a5ecb6ea7mr5527472ejc.43.1682696808500;
        Fri, 28 Apr 2023 08:46:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7rpAV07rm98ZXqi9U6WhnhyHfOeQi41kKjdlW0G3BuiV1Nj46oZf/7aUeX4PuytnJiOaiEjA==
X-Received: by 2002:a17:907:1629:b0:94a:5ecb:6ea7 with SMTP id hb41-20020a170907162900b0094a5ecb6ea7mr5527435ejc.43.1682696808186;
        Fri, 28 Apr 2023 08:46:48 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id o23-20020a170906769700b0094e9f87c6d4sm11191093ejm.192.2023.04.28.08.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 08:46:47 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <bc65340d-99cf-2971-3e4e-738d220b68de@redhat.com>
Date:   Fri, 28 Apr 2023 17:46:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Cc:     brouer@redhat.com, lorenzo@kernel.org, linyunsheng@huawei.com,
        bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org
Subject: Re: [PATCH RFC net-next/mm V2 1/2] page_pool: Remove workqueue in new
 shutdown scheme
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
        linux-mm@kvack.org, Mel Gorman <mgorman@techsingularity.net>
References: <168262348084.2036355.16294550378793036683.stgit@firesoul>
 <168262351129.2036355.1136491155595493268.stgit@firesoul>
 <871qk582tn.fsf@toke.dk>
In-Reply-To: <871qk582tn.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 27/04/2023 22.53, Toke Høiland-Jørgensen wrote:
>> @@ -868,11 +890,13 @@ void page_pool_destroy(struct page_pool *pool)
>>   	if (!page_pool_release(pool))
>>   		return;
>>   
>> -	pool->defer_start = jiffies;
>> -	pool->defer_warn  = jiffies + DEFER_WARN_INTERVAL;
>> +	/* PP have pages inflight, thus cannot immediately release memory.
>> +	 * Enter into shutdown phase.
>> +	 */
>> +	pool->p.flags |= PP_FLAG_SHUTDOWN;
 >
> I think there's another race here: once the flag is set in this line
> (does this need a memory barrier, BTW?), another CPU can return the last
> outstanding page, read the flag and call page_pool_empty_ring(). If this
> happens before the call to page_pool_empty_ring() below, you'll get a
> use-after-free.
> 
> To avoid this, we could artificially bump the pool->hold_cnt *before*
> setting the flag above; that way we know that the page_pool_empty_ring()
> won't trigger a release, because inflight pages will never go below 1.
> And then, below the page_pool_empty_ring() call below, we can add an
> artificial bump of the release_cnt as well, which means we'll get proper
> atomic semantics on the counters and only ever release once. I.e.,:
> 
>> -	INIT_DELAYED_WORK(&pool->release_dw, page_pool_release_retry);
>> -	schedule_delayed_work(&pool->release_dw, DEFER_TIME);
>> +	/* Concurrent CPUs could have returned last pages into ptr_ring */
>> +	page_pool_empty_ring(pool);
>          release_cnt = atomic_inc_return(&pool->pages_state_release_cnt);
>          page_pool_free_attempt(pool, release_cnt);
> 

I agree and I've implemented this solution (see V3 soon).

I've used smp_store_release() instead of WRITE_ONCE(), because AFAIK
smp_store_release() adds the memory barriers.

--Jesper

