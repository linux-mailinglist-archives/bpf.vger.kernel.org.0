Return-Path: <bpf+bounces-4963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FC27525DA
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 16:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78C91C20C05
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 14:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7378F1ED50;
	Thu, 13 Jul 2023 14:58:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBF91ED23
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 14:58:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215182D49
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 07:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689260289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1yeUU24M1Cr/H/q5AufjRRugY3qxn9kpYCYoGY/0wSk=;
	b=ApwCb0pFlOHD9odo9HHxdZsjrz2aiayqrqfCtmSYjOIH34ay3RWVQJTf3M6eTwWe/sMqrT
	3NK6BI3sAOFM1ZOaDra4nXP5+buhl79Ani0LoH0LujuYGer0vOA49WUApA9UeVgJ8WcfWd
	Nuwyv2Om36pbvi9nxJ/EeESYyWgBoPk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-kjdkd9yOMTOHKjwtwbivmg-1; Thu, 13 Jul 2023 10:58:07 -0400
X-MC-Unique: kjdkd9yOMTOHKjwtwbivmg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-978a991c3f5so57613566b.0
        for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 07:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689260286; x=1691852286;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:cc:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1yeUU24M1Cr/H/q5AufjRRugY3qxn9kpYCYoGY/0wSk=;
        b=L8VOFype8v2eCwe7Psf0qLbdKUC8dQyp7vpCiG1xZ0XOCvRp89egrcsa4LCU0RqALq
         yH4Ugg5Bk7X6FdveSW+r0PSviMJinDK6SLg9QF+WE2POTQSkaCSw+sJkUQkUSI28xG7F
         XFeVeFvkU3ni1lZxzy76RLq9C3zqPkW8w6UmUrfTJkT8wNVQDVyZtVQE/0QeDPU+sRHk
         NNugmhe3XmohWacTUwolAAjAOJGr4RvrNi2lMyqJeTTUUaloiROpMwrx7zm9ozCPRElY
         ScAdGliJI0wAnqssDf4OZ/nm5+GlAMwTOt5n8+wZquFTP5pf/I4FMD2zNFFsg6JUUkbo
         PDQw==
X-Gm-Message-State: ABy/qLb58iI5v6uriOm+AwXC2pfaOSHshraR53hoclEn4918bmVJm5Pl
	5J4gh9eUKiPLLDE6NhNn18F10Dgx3gY2ywMcvg0rEeNeMY9dfx2EpsnYL+ty+mGg5DKliyZ938d
	GkUgXElHs7Kmh
X-Received: by 2002:a17:906:535e:b0:993:d616:7ca9 with SMTP id j30-20020a170906535e00b00993d6167ca9mr1843794ejo.23.1689260286119;
        Thu, 13 Jul 2023 07:58:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHZobeO6oPczSiJVyjj7foC0jVAVp/YdlM3T11UqImDJuo6EYPhV5RJjqwMOkFkV93tomq+qA==
X-Received: by 2002:a17:906:535e:b0:993:d616:7ca9 with SMTP id j30-20020a170906535e00b00993d6167ca9mr1843782ejo.23.1689260285842;
        Thu, 13 Jul 2023 07:58:05 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id d21-20020a170906371500b009890e402a6bsm4056840ejc.221.2023.07.13.07.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 07:58:05 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <324a5a08-3053-6ab6-d47e-7413d9f2f443@redhat.com>
Date: Thu, 13 Jul 2023 16:58:04 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, "maxtram95@gmail.com" <maxtram95@gmail.com>,
 "lorenzo@kernel.org" <lorenzo@kernel.org>,
 "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>,
 "kheib@redhat.com" <kheib@redhat.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "mkabat@redhat.com" <mkabat@redhat.com>, "atzin@redhat.com"
 <atzin@redhat.com>, "fmaurer@redhat.com" <fmaurer@redhat.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "jbenc@redhat.com" <jbenc@redhat.com>,
 "linyunsheng@huawei.com" <linyunsheng@huawei.com>,
 "ttoukan.linux@gmail.com" <ttoukan.linux@gmail.com>
Subject: Re: mlx5 XDP redirect leaking memory on kernel 6.3
To: Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 "jbrouer@redhat.com" <jbrouer@redhat.com>, Saeed Mahameed
 <saeedm@nvidia.com>, "saeed@kernel.org" <saeed@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>
References: <d862a131-5e31-bd26-84f7-fd8764ca9d48@redhat.com>
 <00ca7beb7fe054a3ba1a36c61c1e3b1314369f11.camel@nvidia.com>
 <6d47e22e-f128-ec8f-bbdc-c030483a8783@redhat.com>
 <cc918a244723bffe17f528fc1b9a82c0808a22be.camel@nvidia.com>
Content-Language: en-US
In-Reply-To: <cc918a244723bffe17f528fc1b9a82c0808a22be.camel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 13/07/2023 12.11, Dragos Tatulea wrote:
> Gi Jesper,
> On Thu, 2023-07-13 at 11:20 +0200, Jesper Dangaard Brouer wrote:
>> Hi Dragos,
>>
>> Below you promised to work on a fix for XDP redirect memory leak...
>> What is the status?
>>
> The fix got merged into net a week ago:
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/drivers/net/ethernet/mellanox/mlx5/core?id=7abd955a58fb0fcd4e756fa2065c03ae488fcfa7
> 
> Just forgot to follow up on this thread. Sorry about that...
> 

Good to see it being fixed in net.git commit:
  7abd955a58fb ("net/mlx5e: RX, Fix page_pool page fragment tracking for 
XDP")

This need to be backported into stable tree 6.3, but I can see 6.3.13 is 
marked EOL (End-of-Life).
Can we still get this fix applied? (Cc. GregKH)

--Jesper

> 
>> On 23/05/2023 18.35, Dragos Tatulea wrote:
>>>
>>> On Tue, 2023-05-23 at 17:55 +0200, Jesper Dangaard Brouer wrote:
>>>>
>>>> When the mlx5 driver runs an XDP program doing XDP_REDIRECT, then memory
>>>> is getting leaked. Other XDP actions, like XDP_DROP, XDP_PASS and XDP_TX
>>>> works correctly. I tested both redirecting back out same mlx5 device and
>>>> cpumap redirect (with XDP_PASS), which both cause leaking.
>>>>
>>>> After removing the XDP prog, which also cause the page_pool to be
>>>> released by mlx5, then the leaks are visible via the page_pool periodic
>>>> inflight reports. I have this bpftrace[1] tool that I also use to detect
>>>> the problem faster (not waiting 60 sec for a report).
>>>>
>>>>     [1]
>>>> https://github.com/xdp-project/xdp-project/blob/master/areas/mem/bpftrace/page_pool_track_shutdown01.bt
>>>>
>>>> I've been debugging and reading through the code for a couple of days,
>>>> but I've not found the root-cause, yet. I would appreciate new ideas
>>>> where to look and fresh eyes on the issue.
>>>>
>>>>
>>>> To Lin, it looks like mlx5 uses PP_FLAG_PAGE_FRAG, and my current
>>>> suspicion is that mlx5 driver doesn't fully release the bias count (hint
>>>> see MLX5E_PAGECNT_BIAS_MAX).
>>>>
>>>
>>> Thanks for the report Jesper. Incidentally I've just picked up this issue
>>> today
>>> as well.
>>>
>>> On XDP redirect and tx, the page is set to skip the bias counter release
>>> with
>>> the expectation that page_pool_put_defragged_page will be called from [1].
>>> But,
>>> as I found out now, during XDP redirect only one fragment of the page is
>>> released in xdp core [2]. This is where the leak is coming from.
>>>
>>> We'll provide a fix soon.
>>>
>>> [1]
>>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c#n665
>>>
>>> [2]
>>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/net/core/xdp.c#n390
>>>
>>> Thanks,
>>> Dragos
>>>
>>>
>>
> 


