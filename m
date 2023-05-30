Return-Path: <bpf+bounces-1438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB6371602A
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 14:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DC451C20C23
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 12:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9C819939;
	Tue, 30 May 2023 12:41:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9A619931
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 12:41:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259B2184
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 05:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685450430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NlDkHpuyYdZRAU6Xu+vMgwpbc5BKYdyO1aF+SH6i+JU=;
	b=JhnGrC+ETZok6wvlyYmxLpADQZiw5QVB5EzPzqi2xWIofeSe603tw+hBpj2nozrasmO3qR
	mbAZXRsIeXu19R6dTUeyP+eJLEZhYzQmznZPP/pof5nBr3xoTD3bGFhrHFwXYDZ9wheUnZ
	y35B6AOPXWbZ/mZ3+9m+mQxkAQdY4xY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-NIJFJqT2MpeGBd_3jQTiAw-1; Tue, 30 May 2023 08:40:29 -0400
X-MC-Unique: NIJFJqT2MpeGBd_3jQTiAw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a348facbbso478169566b.1
        for <bpf@vger.kernel.org>; Tue, 30 May 2023 05:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685450428; x=1688042428;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NlDkHpuyYdZRAU6Xu+vMgwpbc5BKYdyO1aF+SH6i+JU=;
        b=XAEvT/jkIS70dolHqkHSOimnTam3zBZ72TrrCVAAsp0W3EDkDLjHhrImafO/pmCeqI
         9XDSeyIuNHTRnH3itUBVpwQLKTLqav+78Hn+ASukj5J6UULeST0UY2iNkOSV1H2w6G1C
         cYxg8SXbOWuzeJjo0h9ha36+fYm65tZG/ffV4WR4Cv+svNdDtpEqJZJ3xZvKK6XM046H
         8E82i1jlQ/RGTTWVE+NSKuUHIIggthnmRMsj/snFCLzGOjHsxwGyZrDVBh5VyAIcnDah
         Fp3d2KgezY9jZ7gg7b3jwgUpVXqkoASzJeRIkig3w9t42BacoCJA8tJyt8ycAIuUoe6v
         F5dA==
X-Gm-Message-State: AC+VfDx1vP38ZgpnvxKWN86OjdvaodSBOAGsZZAE2Vrrc7UN9zj8cyEI
	srfnIUgrFp1RXy3wsR6hPatsJJOzJW3ikaopvarOQP7DB2YCb6jfBxt8LE1GatVqi5wk2lu8IYD
	mwJHpmpngMQMk
X-Received: by 2002:a17:907:7e83:b0:973:71c3:8b21 with SMTP id qb3-20020a1709077e8300b0097371c38b21mr2363856ejc.72.1685450428466;
        Tue, 30 May 2023 05:40:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ50tuvD9H/q6gKhuogk02PU1N5E8jEEjy37DBWgpAau0M57imp6ppOLrSl8l7nDdasE3lCsHQ==
X-Received: by 2002:a17:907:7e83:b0:973:71c3:8b21 with SMTP id qb3-20020a1709077e8300b0097371c38b21mr2363824ejc.72.1685450428110;
        Tue, 30 May 2023 05:40:28 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id w19-20020a17090652d300b0094f23480619sm7417647ejn.172.2023.05.30.05.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 05:40:27 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <3168b14c-c9c1-b11b-2500-2ff2451eb81c@redhat.com>
Date: Tue, 30 May 2023 14:40:26 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Nimrod Oren <noren@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, drosen@google.com,
 Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] samples/bpf: fixup xdp_redirect tool to be
 able to support xdp multibuffer
Content-Language: en-US
To: Tariq Toukan <ttoukan.linux@gmail.com>,
 Jesper Dangaard Brouer <jbrouer@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>
References: <20230529110608.597534-1-tariqt@nvidia.com>
 <20230529110608.597534-2-tariqt@nvidia.com>
 <63d91da7-4040-a766-dcd7-bccbb4c02ef4@redhat.com>
 <4ceac69b-d2ae-91b5-1b24-b02c8faa902b@gmail.com>
In-Reply-To: <4ceac69b-d2ae-91b5-1b24-b02c8faa902b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 30/05/2023 14.17, Tariq Toukan wrote:
> 
> On 30/05/2023 14:33, Jesper Dangaard Brouer wrote:
>>
>>
>> On 29/05/2023 13.06, Tariq Toukan wrote:
>>> Expand the xdp multi-buffer support to xdp_redirect tool.
>>> Similar to what's done in commit
>>> 772251742262 ("samples/bpf: fixup some tools to be able to support 
>>> xdp multibuffer")
>>> and its fix commit
>>> 7a698edf954c ("samples/bpf: Fix MAC address swapping in xdp2_kern").
>>>
>>
>> Have you tested if this cause a performance degradation?
>>
>> (Also found possible bug below)
>>
> 
> Hi Jesper,
> 
> This introduces the same known perf degradation we already have in xdp1 
> and xdp2.

Did a quick test with xdp1, the performance degradation is around 18%.

  Before: 22,917,961 pps
  After:  18,798,336 pps

  (1-(18798336/22917961))*100 = 17.97%


> Unfortunately, this is the API we have today to safely support 
> multi-buffer.
> Note that both perf and functional (noted below) degradation should be 
> eliminated once replacing the load/store operations with dynptr logic 
> that returns a pointer to the scatter entry instead of copying it.
> 

Well, should we use dynptr logic in this patch then?

Does it make sense to add sample code that does thing in a way that is 
sub-optimal and we want to replace?
... (I fear people will copy paste the sample code).

> I initiated a discussion on this topic a few months ago. dynptr was 
> accepted since then, but I'm not aware of any in-progress followup work 
> that addresses this.
> 

Are you saying some more work is needed on dynptr?

>>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>>> Reviewed-by: Nimrod Oren <noren@nvidia.com>
>>> ---
>>>   samples/bpf/xdp_redirect.bpf.c | 16 ++++++++++++----
>>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/samples/bpf/xdp_redirect.bpf.c 
>>> b/samples/bpf/xdp_redirect.bpf.c
>>> index 7c02bacfe96b..620163eb7e19 100644
>>> --- a/samples/bpf/xdp_redirect.bpf.c
>>> +++ b/samples/bpf/xdp_redirect.bpf.c
>>> @@ -16,16 +16,21 @@
>>>   const volatile int ifindex_out;
>>> -SEC("xdp")
>>> +#define XDPBUFSIZE    64
>>
>> Pktgen sample scripts will default send with 60 pkt length, because the
>> 4 bytes FCS (end-frame checksum) is added by hardware.
>>
>> Will this result in an error when bpf_xdp_load_bytes() tries to copy 64
>> bytes from a 60 bytes packet?
>>
> 
> Yes.
> 
> This can be resolved by reducing XDPBUFSIZE to 60.
> Need to check if it's OK to disregard these last 4 bytes without hurting 
> the XDP program logic.
> 
> If so, do you suggest changing xdp1 and xdp2 as well?
> 

I can take care of reducing XDPBUFSIZE to 60 on xpd1 and xdp2, as I
already had to make these changes for the above quick bench work ;-)
I'll send out patches shortly.


>>> +SEC("xdp.frags")
>>>   int xdp_redirect_prog(struct xdp_md *ctx)
>>>   {
>>> -    void *data_end = (void *)(long)ctx->data_end;
>>> -    void *data = (void *)(long)ctx->data;
>>> +    __u8 pkt[XDPBUFSIZE] = {};
>>> +    void *data_end = &pkt[XDPBUFSIZE-1];
>>> +    void *data = pkt;
>>>       u32 key = bpf_get_smp_processor_id();
>>>       struct ethhdr *eth = data;
>>>       struct datarec *rec;
>>>       u64 nh_off;
>>> +    if (bpf_xdp_load_bytes(ctx, 0, pkt, sizeof(pkt)))
>>> +        return XDP_DROP;
>>
>> E.g. sizeof(pkt) = 64 bytes here.
>>
>>> +
>>>       nh_off = sizeof(*eth);
>>>       if (data + nh_off > data_end)
>>>           return XDP_DROP;
>>> @@ -36,11 +41,14 @@ int xdp_redirect_prog(struct xdp_md *ctx)
>>>       NO_TEAR_INC(rec->processed);
>>>       swap_src_dst_mac(data);
>>> +    if (bpf_xdp_store_bytes(ctx, 0, pkt, sizeof(pkt)))
>>> +        return XDP_DROP;
>>> +
>>>       return bpf_redirect(ifindex_out, 0);
>>>   }
>>>   /* Redirect require an XDP bpf_prog loaded on the TX device */
>>> -SEC("xdp")
>>> +SEC("xdp.frags")
>>>   int xdp_redirect_dummy_prog(struct xdp_md *ctx)
>>>   {
>>>       return XDP_PASS;
>>
> 


