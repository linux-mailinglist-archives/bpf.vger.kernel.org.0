Return-Path: <bpf+bounces-4988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECD575335F
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 09:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577EE1C214D7
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 07:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3A4747B;
	Fri, 14 Jul 2023 07:43:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACC06AC2
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 07:43:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AF5213F
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 00:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689320588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8RV6VmoCSDJlQIGxTSc2C/ilkhOc2GYT+YQNbt5Ygqs=;
	b=aCStSF5wQvr7FnmzgLSldBu89KdtZwYFqQgls4TD1nd5l3MCZ9M+4l4y+pMNkm5LIUuP60
	I+T6In7qG+x4YawYzljk2CcADfcYtceA5h3Ze37G7lJZmYA2WhzDoKXm+1CWFxXKjevPPt
	tY4SGuZjCKem+Qj6VlCyh8FHh3at+8A=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-SXFCCjuWNliPAR5vkT_FDA-1; Fri, 14 Jul 2023 03:43:07 -0400
X-MC-Unique: SXFCCjuWNliPAR5vkT_FDA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-989249538a1so90887166b.1
        for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 00:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689320586; x=1691912586;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8RV6VmoCSDJlQIGxTSc2C/ilkhOc2GYT+YQNbt5Ygqs=;
        b=DhU42WwZtp951Ucd1BBnmL25jlLVNlKrAp1dTT6n65GsPeb0XwCBuFQNfGQ27eaGxp
         CBqewz5qbtztHpk6Fhoo0hOHLctOP1Mmyby8hvb5kcldphrFYdULO63K7WMTulBH3nLG
         MYs+LAmcSGpA9rqIYaH+R3X6uM1MKXZJF86HkrT66ghJzkL2J4+g9Qf+4Hbov9XXIzAk
         CcrpOcu5cS292wcr6wE/RnWucnIOe91NHeAWf9/7M4M9N+sUoXekrrr1W8G/5Mx3H4Kw
         /BJb3qUdpHLZEVabM0NZzLuU1g80jwCRaj264pZcpQbkr6yGSVhJOHrCcyqn+1Mwrymb
         9ptQ==
X-Gm-Message-State: ABy/qLZD7cg8Tm8h40jDYekA3oclTx9V5IxGMIEVcAE0T/RzhPTQ8HBl
	kCSR6EWiQv+E1/ljJ2AMcohnfKavs6Vhg4COiR7e287Q2n8TBN9jnc7zBozdKlHR8Uepr0hBtUA
	bMP3GLcSNVsqZ
X-Received: by 2002:a17:906:22db:b0:991:b613:9b65 with SMTP id q27-20020a17090622db00b00991b6139b65mr2766715eja.37.1689320586276;
        Fri, 14 Jul 2023 00:43:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGkVCdUgKT4CuozT1y45CBxqcp7kgkZtxRkxzueS/PYGMNLQEIkj3Ux6bf9a7KqgPcPlaagDg==
X-Received: by 2002:a17:906:22db:b0:991:b613:9b65 with SMTP id q27-20020a17090622db00b00991b6139b65mr2766691eja.37.1689320585955;
        Fri, 14 Jul 2023 00:43:05 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id d20-20020a170906371400b0098e2eaec395sm5074876ejc.130.2023.07.14.00.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 00:43:05 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <85bfa818-6856-e3ea-ef4d-16646c57d1cc@redhat.com>
Date: Fri, 14 Jul 2023 09:43:04 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com,
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
Subject: Re: [PATCH net-next] net: mana: Add page pool for RX buffers
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>
References: <1689259687-5231-1-git-send-email-haiyangz@microsoft.com>
 <20230713205326.5f960907@kernel.org>
In-Reply-To: <20230713205326.5f960907@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 14/07/2023 05.53, Jakub Kicinski wrote:
> On Thu, 13 Jul 2023 14:48:45 +0000 Haiyang Zhang wrote:
>> Add page pool for RX buffers for faster buffer cycle and reduce CPU
>> usage.
>>
>> Get an extra ref count of a page after allocation, so after upper
>> layers put the page, it's still referenced by the pool. We can reuse
>> it as RX buffer without alloc a new page.
> 
> Please use the real page_pool API from include/net/page_pool.h
> We've moved past every driver reinventing the wheel, sorry.

+1

Quoting[1]: Documentation/networking/page_pool.rst

  Basic use involves replacing alloc_pages() calls with the 
page_pool_alloc_pages() call.
  Drivers should use page_pool_dev_alloc_pages() replacing 
dev_alloc_pages().


[1] https://kernel.org/doc/html/latest/networking/page_pool.html


