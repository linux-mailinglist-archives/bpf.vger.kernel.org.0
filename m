Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2470E6F19F2
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 15:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346270AbjD1Nsx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 09:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346205AbjD1Nsw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 09:48:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C884C10
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 06:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682689691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jmGtCEfUXv1Vp+ULFOpSFCFJecVFUn3MtTRtzSJL8k0=;
        b=SFwY5LaZzuen+qEKaEyIGwRRyXlauDx9L99P+lXpcb7Gs/DxeM7SQlMljKylKbq2pI8Kes
        0zEvwloj9p2Q8Gv8Z4gykPhLIdiBG9TuD4sO8otOHw5o4aLkCH9P0jr9fE672PswU1bbFp
        0kDIny9uRW9myvmNng37R/+eS8OdyII=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-dbp6zwcVPoGFwWXhEThwjA-1; Fri, 28 Apr 2023 09:48:09 -0400
X-MC-Unique: dbp6zwcVPoGFwWXhEThwjA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9532170e7d3so941543466b.0
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 06:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682689688; x=1685281688;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jmGtCEfUXv1Vp+ULFOpSFCFJecVFUn3MtTRtzSJL8k0=;
        b=QP8CMLsoynn1JfE1X1maEFuYzYJ/NCo2zBc2vzIUcd3nuP6FZmvBaYf1863079pC7z
         rwuJ0rqzDeXcnFX4g6x65ZRy3GPp2l3qZOMrcqXhcMd6eISZdEyU/y1VvllbF0SsGmyo
         02N1SN8ILXku3p6CVjLnmcqbpqJa0CgRgZxWQp7g8rpKysZiy12i6j2sc3jP1nn8WJwO
         NCzAYvVckMGE+FlRIONSSbhMVvkCM3P3feNf9jvFK4b9K9MbIQpJxlW7xOttNdvCzpgd
         dIoXzZjYK4CiLTjnAQV9ZKlpeNxUyjPf2OCFjHqPc096GzyQPzy0t9TvuQ5c2q/CG6Xk
         wIWw==
X-Gm-Message-State: AC+VfDwWnXDmTCIIC2kVbIJGH6Mw7AIdDC4BadBhOeNT5wUUKAEZWksc
        4wVnAg6wrp4zG0CuPikZYM9BOEFWvahEdjEfuVp5mB7lNv+ANguFfgf8BMpJ5CZwDCYTcdMxZw9
        02PdX1AeIpiEz
X-Received: by 2002:a17:907:7fa1:b0:94e:fe77:3f47 with SMTP id qk33-20020a1709077fa100b0094efe773f47mr7109102ejc.67.1682689688500;
        Fri, 28 Apr 2023 06:48:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5t1ePMr3EFTQiRFXhOYJ5rDjHjJLZ/nUd7rk/dh2ocoIyXuYny0i8hZmcckTd67WikHzfiIg==
X-Received: by 2002:a17:907:7fa1:b0:94e:fe77:3f47 with SMTP id qk33-20020a1709077fa100b0094efe773f47mr7109082ejc.67.1682689688144;
        Fri, 28 Apr 2023 06:48:08 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id g23-20020a170906395700b0094f16a3ea9csm11169383eje.117.2023.04.28.06.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 06:48:07 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <f671f5da-d9bc-a559-2120-10c3491e6f6d@redhat.com>
Date:   Fri, 28 Apr 2023 15:48:06 +0200
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 27/04/2023 22.53, Toke Høiland-Jørgensen wrote:
>> @@ -490,11 +508,15 @@ void page_pool_release_page(struct page_pool *pool, struct page *page)
>>   skip_dma_unmap:
>>   	page_pool_clear_pp_info(page);
>>   
>> -	/* This may be the last page returned, releasing the pool, so
>> -	 * it is not safe to reference pool afterwards.
>> -	 */
>> -	count = atomic_inc_return_relaxed(&pool->pages_state_release_cnt);
>> -	trace_page_pool_state_release(pool, page, count);
>> +	if (flags & PP_FLAG_SHUTDOWN)
>> +		hold_cnt = pp_read_hold_cnt(pool);
>> +
>> +	release_cnt = atomic_inc_return(&pool->pages_state_release_cnt);
>> +	trace_page_pool_state_release(pool, page, release_cnt);
>> +
>> +	/* In shutdown phase, last page will free pool instance */
>> +	if (flags & PP_FLAG_SHUTDOWN)
>> +		page_pool_free_attempt(pool, hold_cnt, release_cnt);
 >
> Since the assumption is that no new pages will be allocated once the
> PP_FLAG_SHUTDOWN is set (i.e., hold_count can not increase in the case),
> I don't think it matters what order you read the hold and release counts
> in? So you could simplify the above to just:
> 
>> +	if (flags & PP_FLAG_SHUTDOWN)
>> +		page_pool_free_attempt(pool, pp_read_hold_cnt(pool), release_cnt);
> and drop the second check of the flag further up?
> 
> You could probably even lose the hold_cnt argument entirely from
> page_pool_free_attempt() and just have it call pp_read_hold_cnt() directly?
>

I unfortunately think we have to keep this approach.

The purpose is to read out data from *pool, such that it is safe to call
page_pool_free_attempt() even when *pool memory have been freed.

I believe there is a race window between atomic_inc_return() and freeing
in page_pool_free_attempt(). (As we have tracepoints in this critical
section we might even be able to increase the chance of the race)

Imagine two CPUs freeing the last two PP pages.
Hold=2 which means when release_cnt reach 2 inflight is zero.

  CPU-1 : release_cnt 1 = atomic_inc_return();
  CPU-1 : gets preempted (or runs slow bpf-prog in tracepoint)
  CPU-2 : release_cnt 2 = atomic_inc_return();
  CPU-2 : page_pool_free_attempt(pool, 2, release_cnt=2);
  CPU-2 : find no-inflight -> calls page_pool_free(pool)
  CPU-1 : page_pool_free_attempt(pool, 2, release_cnt=1);
  CPU-1 : *use-after-free* deref pool->pages_state_hold_cnt


>>   }
>>   EXPORT_SYMBOL(page_pool_release_page);

