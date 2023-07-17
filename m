Return-Path: <bpf+bounces-5148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F01197570B5
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 02:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F512814F6
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 00:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C243A134C5;
	Tue, 18 Jul 2023 00:00:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CE6C2C2
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 00:00:06 +0000 (UTC)
Received: from out-58.mta0.migadu.com (out-58.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27F2EC
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 17:00:01 -0700 (PDT)
Message-ID: <062768e0-90d6-33dc-162a-c4adaa612f67@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1689638399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bhW9hWOzuPO3ascL2TqqhoQF4927LJi53dnYLFnBGSs=;
	b=SkzjRAxh0UkLbY0uBKTCS5sP9FXnWZKGihuXHKPOF1ffAqOWKdCsk6+ZpM+MVCPSmnPWo5
	Eyq9IItyWV8dpK/3lig2h85063nUWXxGqyieU99J9i6e67JcYKpJ4MAy7OdtVIor0iorQO
	JvxkaW6Bb575fVSKPCEETcayyHZlgF8=
Date: Tue, 18 Jul 2023 07:59:47 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: RE: [PATCH net-next] net: mana: Add page pool for RX buffers
To: Haiyang Zhang <haiyangz@microsoft.com>,
 Jesper Dangaard Brouer <jbrouer@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "brouer@redhat.com" <brouer@redhat.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Dexuan Cui <decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
 Paul Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "leon@kernel.org"
 <leon@kernel.org>, Long Li <longli@microsoft.com>,
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
References: <1689259687-5231-1-git-send-email-haiyangz@microsoft.com>
 <20230713205326.5f960907@kernel.org>
 <85bfa818-6856-e3ea-ef4d-16646c57d1cc@redhat.com>
 <PH7PR21MB31166EF9DB2F453999D2E92ECA34A@PH7PR21MB3116.namprd21.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <PH7PR21MB31166EF9DB2F453999D2E92ECA34A@PH7PR21MB3116.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

在 2023/7/14 20:51, Haiyang Zhang 写道:
> 
> 
>> -----Original Message-----
>> From: Jesper Dangaard Brouer <jbrouer@redhat.com>
>> On 14/07/2023 05.53, Jakub Kicinski wrote:
>>> On Thu, 13 Jul 2023 14:48:45 +0000 Haiyang Zhang wrote:
>>>> Add page pool for RX buffers for faster buffer cycle and reduce CPU
>>>> usage.
>>>>
>>>> Get an extra ref count of a page after allocation, so after upper
>>>> layers put the page, it's still referenced by the pool. We can reuse
>>>> it as RX buffer without alloc a new page.
>>>
>>> Please use the real page_pool API from include/net/page_pool.h
>>> We've moved past every driver reinventing the wheel, sorry.
>>
>> +1
>>
>> Quoting[1]: Documentation/networking/page_pool.rst
>>
>>    Basic use involves replacing alloc_pages() calls with the
>> page_pool_alloc_pages() call.
>>    Drivers should use page_pool_dev_alloc_pages() replacing
>> dev_alloc_pages().
>   
> Thank Jakub and Jesper for the reviews.
> I'm aware of the page_pool.rst doc, and actually tried it before this
> patch, but I got lower perf. If I understand correctly, we should call
> page_pool_release_page() before passing the SKB to napi_gro_receive().
> 

If I get this commit correctly, this commit is to use page pool to get 
better performance.

IIRC, folio is to make memory optimization. From the performance 
results, with folio, the performance will get about 10%.

So not sure if the folio can be used in this commit to get better 
performance.

That is my 2 cent.

Zhu Yanjun

> I found the page_pool_dev_alloc_pages() goes through the slow path,
> because the page_pool_release_page() let the page leave the pool.
> 
> Do we have to call page_pool_release_page() before passing the SKB
> to napi_gro_receive()? Any better way to recycle the pages from the
> upper layer of non-XDP case?
> 
> Thanks,
> - Haiyang
> 


