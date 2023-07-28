Return-Path: <bpf+bounces-6198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E15D3766DEC
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 15:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6F11C218BC
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 13:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48019101FE;
	Fri, 28 Jul 2023 13:14:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F255134BD
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 13:14:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF6F3A9C
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 06:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690550051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLiIZeTYjRO0s/LEHdCCleUVzGxQ50bQYg01pbBTxpo=;
	b=g/lz25cr5ABIb2Oo8+q9xF+pYZ6ZtKp9bq8w/snQTQgPgplwJUuUBEYVxw9X1Zn2Jmx1FQ
	+qToofApRuzJJhzHIBlYAVPRBoKFTKCEsPVJN+2uYpelFXwhs50kxdKImrjMLdY90nW6gW
	ttVvvOfqw4w51ZkFfItH5QGk5rpfuFU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-HaVRfSURNz6d2bpr9R1XBw-1; Fri, 28 Jul 2023 09:14:10 -0400
X-MC-Unique: HaVRfSURNz6d2bpr9R1XBw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-99bcf56a2e9so134990766b.2
        for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 06:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690550049; x=1691154849;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pLiIZeTYjRO0s/LEHdCCleUVzGxQ50bQYg01pbBTxpo=;
        b=XaU+PMWNKdNlryedc6bOluYIfnVymqflTCbhfyi7rymDoW7Q71EqcsoTO3VCccqlvh
         VjWfEgeWp5O0ALF3YXCrODs6RWhm8kzam6cGQTChJX1hO1XgQ7Svd55VGISxf6fxmKt3
         Vjks5QndLrb7qgKFa+jkNdQBbXFBAvpSAGrZveqePof49lQdZDCYQDMSqVgIhLn+Xina
         xIHwpUSo+QizUzlp70zvf7BT/fdk4xBT+QQs4ZZogSoT/BuYrQmea+ySlRhfmRuPp1xt
         mR6bPEdDZGaTebNZGWX4miYqvGS+70vswbP09h7l5wjl9OTMtdcVKJii4k8Hz+BkT7oK
         qMVw==
X-Gm-Message-State: ABy/qLZJ85qtUGeByEK2j1swHFMQf9GqMKhDDgyGYSSa/6yh+Th8UjSk
	QIthJE9Z+fgCNZEqHN4hjoPb95uy3RW0u8iqrZUnzngdj/kDlQ86/nqTV/C4RdPPsKxrL8QXAph
	XxcrnvT04ImmN
X-Received: by 2002:a17:906:d7:b0:973:fd02:a41f with SMTP id 23-20020a17090600d700b00973fd02a41fmr2819203eji.40.1690550048961;
        Fri, 28 Jul 2023 06:14:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHDJOGU2IgCXp9wkrtJWVk+oJ9oO/CC4frD4+EcqSZ/Vn3Qq/IBOHAWtlNyLSG8QImCON2ELQ==
X-Received: by 2002:a17:906:d7:b0:973:fd02:a41f with SMTP id 23-20020a17090600d700b00973fd02a41fmr2819170eji.40.1690550048646;
        Fri, 28 Jul 2023 06:14:08 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id f5-20020a1709064dc500b0098f33157e7dsm2067557ejw.82.2023.07.28.06.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 06:14:07 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <d13bc032-6ad0-368d-42ab-c4965a22a2ba@redhat.com>
Date: Fri, 28 Jul 2023 15:14:06 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: brouer@redhat.com, "atzin@redhat.com" <atzin@redhat.com>,
 "linyunsheng@huawei.com" <linyunsheng@huawei.com>,
 "saeed@kernel.org" <saeed@kernel.org>,
 "ttoukan.linux@gmail.com" <ttoukan.linux@gmail.com>,
 "maxtram95@gmail.com" <maxtram95@gmail.com>,
 "jbrouer@redhat.com" <jbrouer@redhat.com>,
 "kheib@redhat.com" <kheib@redhat.com>, "jbenc@redhat.com"
 <jbenc@redhat.com>, "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 Saeed Mahameed <saeedm@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "fmaurer@redhat.com" <fmaurer@redhat.com>,
 "mkabat@redhat.com" <mkabat@redhat.com>, Tariq Toukan <tariqt@nvidia.com>,
 "lorenzo@kernel.org" <lorenzo@kernel.org>
Subject: Re: mlx5 XDP redirect leaking memory on kernel 6.3
Content-Language: en-US
To: Dragos Tatulea <dtatulea@nvidia.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
References: <d862a131-5e31-bd26-84f7-fd8764ca9d48@redhat.com>
 <00ca7beb7fe054a3ba1a36c61c1e3b1314369f11.camel@nvidia.com>
 <6d47e22e-f128-ec8f-bbdc-c030483a8783@redhat.com>
 <cc918a244723bffe17f528fc1b9a82c0808a22be.camel@nvidia.com>
 <324a5a08-3053-6ab6-d47e-7413d9f2f443@redhat.com>
 <2023071357-unscrew-customary-fbae@gregkh>
 <32726772de5996305d0cfd4b6948933c47cb7927.camel@nvidia.com>
 <2023071705-senorita-unafraid-25b8@gregkh>
 <99774260e7e0f5f21215d6f4b00c5d8a7102f4ce.camel@nvidia.com>
In-Reply-To: <99774260e7e0f5f21215d6f4b00c5d8a7102f4ce.camel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Correction: mlx5 XDP redirect leaking memory on kernel 6.4
  - Explained below

On 17/07/2023 17.15, Dragos Tatulea wrote:
> On Mon, 2023-07-17 at 16:42 +0200, gregkh@linuxfoundation.org wrote:
>> On Mon, Jul 17, 2023 at 02:37:44PM +0000, Dragos Tatulea wrote:
>>> On Thu, 2023-07-13 at 17:31 +0200, Greg KH wrote:
>>>> On Thu, Jul 13, 2023 at 04:58:04PM +0200, Jesper Dangaard Brouer wrote:
>>>>>
>>>>>
>>>>> On 13/07/2023 12.11, Dragos Tatulea wrote:
>>>>>> Gi Jesper,
>>>>>> On Thu, 2023-07-13 at 11:20 +0200, Jesper Dangaard Brouer wrote:
>>>>>>> Hi Dragos,
>>>>>>>
>>>>>>> Below you promised to work on a fix for XDP redirect memory leak...
>>>>>>> What is the status?
>>>>>>>
>>>>>> The fix got merged into net a week ago:
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/drivers/net/ethernet/mellanox/mlx5/core?id=7abd955a58fb0fcd4e756fa2065c03ae488fcfa7
>>>>>>
>>>>>> Just forgot to follow up on this thread. Sorry about that...
>>>>>>
>>>>>
>>>>> Good to see it being fixed in net.git commit:
>>>>>   7abd955a58fb ("net/mlx5e: RX, Fix page_pool page fragment tracking for XDP")
>>>>>
>>>>> This need to be backported into stable tree 6.3, but I can see 6.3.13 is
>>>>> marked EOL (End-of-Life).
>>>>> Can we still get this fix applied? (Cc. GregKH)
>>>>
>>>> <formletter>
>>>>
>>>> This is not the correct way to submit patches for inclusion in the
>>>> stable kernel tree.  Please read:
>>>>     
>>>> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>>>> for how to do this properly.
>>>>
>>>> </formletter>
[...]
>>> to the stable submission rules or is it too late?
>>
[...]
>> If you mean the "6.3.y" tree, yes, there is nothing to do here as that
>> tree is end-of-life and you should have moved to the 6.4.y kernel tree
>> at this point in time.
>>
>> What is preventing you from moving?
>>
> I am fine with the state of things. But Jesper was asking. I suppose
> the answer to his question is "it's too late".
I was looking for the answer "it is too late for 6.3.y".

This exercise is just to make Google searches and distro people (like
myself and cc) aware that mlx5 XDP *redirect* is (intermediately) broken
and we should remember to backport 7abd955a58fb ("net/mlx5e: RX, Fix
page_pool page fragment tracking for XDP") to fix this.

Looking at git details, I notice that I (and subject) were wrong. The
buggy feature first landed in v6.4 and not v6.3.
Thus, true subject "mlx5 XDP redirect leaking memory on kernel 6.4".
Sorry for the stable confusion.  Greg will "automatically" pickup
Dragos's fix commit for 6.4.y as it have correct fixes tag.  Guess, I
damaged the Google search parameter, but I trying to correct it with
this update.

--Jesper


