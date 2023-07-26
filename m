Return-Path: <bpf+bounces-5923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 735147631BA
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 11:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F13C281C8C
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 09:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C20BA3A;
	Wed, 26 Jul 2023 09:22:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7EABA31
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 09:22:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD27919A0
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 02:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690363366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sk/PJvGKnh/DBuIKg5Yct3fF7G6zPABpNJl6TJTyRnA=;
	b=ITu2is//lD4TPdlCgZ32ZjDEsT9zNFyvzv65I4pTiqCsuHJJ057OLMHkP7977Zllotc9Dk
	woJVIcDq3StJKPeQlgSNrrCxwFha9D9milJd0g6xtI6KkA5w3+/ByElG470PfAAqYtcemF
	8PPhxMpvbl+C2m76YgWgpEbbwgKOVYE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-XOZa6VieO5q-fZEZGOmhCg-1; Wed, 26 Jul 2023 05:22:44 -0400
X-MC-Unique: XOZa6VieO5q-fZEZGOmhCg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a355cf318so533393166b.2
        for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 02:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690363363; x=1690968163;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sk/PJvGKnh/DBuIKg5Yct3fF7G6zPABpNJl6TJTyRnA=;
        b=Df0568E8878CeBoBg5L9NrWx0mFDDN4FJFFREDQ664JC5jCaO5AVcegTLoFku4SC9S
         TZrhyaCAFghmJ8GuLwzHJu+ws27C+bGRF7wR32c7m9dt7VrzqXvDPJtt7bt+jXe0nq6F
         9nYNdhS2VBEUtKBh12pPIY51pNLA9kSol4UL1HyVWOkVZocZtNTrKCwjyE6XMD6ftgEf
         ikgVnwWNCt9cjjnDdbusDlwuThi7UTi6RIMzGXgXuO9lY+0R1qbSeN7ULfN0WyzqeC0w
         jwkXQZ5/nerWs8xThgGTlubys6MsRnR5MPEkrircE2vpXN8wxt3zJLT0D/4/AZ3cz7j5
         I44A==
X-Gm-Message-State: ABy/qLa0taelscPlb5LkzJn9gm7voXAm8esid+YnAkegkedxcoyQa44M
	6s5gk8hcwkXZpK1qX7TWLu9UECdrjlL7Ofo4xVLQictzgOqsc7OhIviu0RlxQLmZthO/lqXzjWl
	vSm3ULVHHThln
X-Received: by 2002:a17:906:7a57:b0:994:4e16:d430 with SMTP id i23-20020a1709067a5700b009944e16d430mr1366801ejo.20.1690363363454;
        Wed, 26 Jul 2023 02:22:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFxJiPkcQtMLhAVgg8mHrSnrgOR7Jaaj/757VyQ9wgV7p4JZKyo7863vYBZ/msQVa/a9QHdjw==
X-Received: by 2002:a17:906:7a57:b0:994:4e16:d430 with SMTP id i23-20020a1709067a5700b009944e16d430mr1366773ejo.20.1690363363145;
        Wed, 26 Jul 2023 02:22:43 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090629c700b009887f4e0291sm9211263eje.27.2023.07.26.02.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 02:22:42 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <6396223c-6008-0e1b-e6ed-79c04c87a5e0@redhat.com>
Date: Wed, 26 Jul 2023 11:22:40 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, Dexuan Cui <decui@microsoft.com>,
 KY Srinivasan <kys@microsoft.com>, Paul Rosswurm <paulros@microsoft.com>,
 "olaf@aepfle.de" <olaf@aepfle.de>, "vkuznets@redhat.com"
 <vkuznets@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "leon@kernel.org" <leon@kernel.org>,
 Long Li <longli@microsoft.com>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org"
 <ast@kernel.org>, Ajay Sharma <sharmaajay@microsoft.com>,
 "hawk@kernel.org" <hawk@kernel.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>,
 "shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH V3,net-next] net: mana: Add page pool for RX buffers
Content-Language: en-US
To: Haiyang Zhang <haiyangz@microsoft.com>,
 Jesper Dangaard Brouer <jbrouer@redhat.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <1689966321-17337-1-git-send-email-haiyangz@microsoft.com>
 <1af55bbb-7aff-e575-8dc1-8ba64b924580@redhat.com>
 <PH7PR21MB3116F8A97F3626AB04915B96CA02A@PH7PR21MB3116.namprd21.prod.outlook.com>
 <PH7PR21MB311675E57B81B49577ADE98FCA02A@PH7PR21MB3116.namprd21.prod.outlook.com>
 <729b360c-4d79-1025-f5be-384b17f132d3@redhat.com>
 <PH7PR21MB3116F5612AA8303512EEBA4CCA03A@PH7PR21MB3116.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB3116F5612AA8303512EEBA4CCA03A@PH7PR21MB3116.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 25/07/2023 21.02, Haiyang Zhang wrote:
> 
>> -----Original Message-----
>> From: Jesper Dangaard Brouer <jbrouer@redhat.com>
>> Sent: Tuesday, July 25, 2023 2:01 PM
>>>>
>>>> Our driver is using NUMA 0 by default, so I implicitly assign NUMA node id
>>>> to zero during pool init.
>>>>
>>>> And, if the IRQ/CPU affinity is changed, the page_pool_nid_changed()
>>>> will update the nid for the pool. Does this sound good?
>>>>
>>>
>>> Also, since our driver is getting the default node from here:
>>> 	gc->numa_node = dev_to_node(&pdev->dev);
>>> I will update this patch to set the default node as above, instead of implicitly
>>> assigning it to 0.
>>>
>>
>> In that case, I agree that it make sense to use dev_to_node(&pdev->dev),
>> like:
>> 	pprm.nid = dev_to_node(&pdev->dev);
>>
>> Driver must have a reason for assigning gc->numa_node for this hardware,
>> which is okay. That is why page_pool API allows driver to control this.
>>
>> But then I don't think you should call page_pool_nid_changed() like
>>
>> 	page_pool_nid_changed(rxq->page_pool, numa_mem_id());
>>
>> Because then you will (at first packet processing event) revert the
>> dev_to_node() setting to use numa_mem_id() of processing/running CPU.
>> (In effect this will be the same as setting NUMA_NO_NODE).
>>
>> I know, mlx5 do call page_pool_nid_changed(), but they showed benchmark
>> numbers that this was preferred action, even-when sysadm had
>> "misconfigured" the default smp_affinity RX-processing to happen on a
>> remote NUMA node.  AFAIK mlx5 keeps the descriptor rings on the
>> originally configured NUMA node that corresponds to the NIC PCIe slot.
> 
> In mana_gd_setup_irqs(), we set the default IRQ/CPU affinity to gc->numa_node
> too, so it won't revert the nid initial setting.
> 
> Currently, the Azure hypervisor always indicates numa 0 as default. (In
> the future, it will start to provide the accurate default dev node.) When a
> user manually changes the IRQ/CPU affinity for perf tuning, we want to
> allow page_pool_nid_changed() to update the pool. Is this OK?
> 

If I were you, I would wait with the page_pool_nid_changed()
"optimization" and do a benchmark mark to see if this actually have a
benefit.  (You can do this in another patch).  (In a Azure hypervisor
environment is might not be the right choice).

This reminds me, do you have any benchmark data on the improvement this
patch (using page_pool) gave?

--Jesper


