Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D782E6E7FD8
	for <lists+bpf@lfdr.de>; Wed, 19 Apr 2023 18:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbjDSQmA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 12:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbjDSQl7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 12:41:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CC246A9
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 09:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681922472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hlv123C+B2XbuevZfH+qzPUIEfiKhtHnPAxff1XZ5EU=;
        b=JUjPRpWCOdgIJS1Drvnw/QkbQ5ErlgJAFhWgWlTcEgQXfKIM4Xu0qBvF8Tops/uw7V8/Oc
        EhG/rQ4Makfkg/jBXhKfONdVIS6Xh+TXk0UFiXVtO+RFNKH+jWoIx1tl8XkMBRfFuw/l/V
        ZGvLEWNqMcoBYWgu9WceKxSZ8ihQxI0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-Qd7OeCnVMGmI3S51Gj0LTg-1; Wed, 19 Apr 2023 12:41:10 -0400
X-MC-Unique: Qd7OeCnVMGmI3S51Gj0LTg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a342f6516so224866b.0
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 09:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681922469; x=1684514469;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hlv123C+B2XbuevZfH+qzPUIEfiKhtHnPAxff1XZ5EU=;
        b=jfDpWz2KRKsA+ZJT1HKPpb5wXLZWa4aeq6qMtUL7t7wIsCUFkjQMplHDKvuc6F2XuA
         /ESRPYqKUd3vJI42M2HMJmjichX9RBRGZkZI5b4N01zIGU3W9ILf+5+byvt15+TaK2Pi
         2tUY/krmDBssXJzVyeM+I6JvPfq9bhpe8/M77fkbH714kMy8yWPV7NCpyWnx37a5B/69
         +Cc3Ra7XscTWhkuiIwvbX+FQCYa5ew4X85yi9UyMClNem0mjfZQ9G8DNImr4c5MsMPgT
         AzJW6e6Vly1gYF0rEmCJ0Mi3wgPBWN+rFMVPqgBOEjoxFl250u8c8B4D8ljsJkvamc2j
         YMfA==
X-Gm-Message-State: AAQBX9drwmvJSQTKb/fR1/x4nRxWNN9ee+RpgtMsHZ7hLsBjTZZl85dU
        xxAsejaBKEB1WmWGkyirG+xHi84GaR6bc/Be4MOQTBILxR7JZoaKwJu+S8RoDbL70QL1Rlp4aHe
        JtAHW1qzrtUmN
X-Received: by 2002:aa7:d882:0:b0:506:747f:3bf0 with SMTP id u2-20020aa7d882000000b00506747f3bf0mr6496247edq.8.1681922469333;
        Wed, 19 Apr 2023 09:41:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZhK35CXjndGgF5Spba/Mxq6IuaaMO7jT05DPVMg1qXuVeYR2ehgm+jxdc2+5FsBIsBaAX16g==
X-Received: by 2002:aa7:d882:0:b0:506:747f:3bf0 with SMTP id u2-20020aa7d882000000b00506747f3bf0mr6496218edq.8.1681922468996;
        Wed, 19 Apr 2023 09:41:08 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id g3-20020aa7c843000000b005029c47f814sm8170544edt.49.2023.04.19.09.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 09:41:08 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <925c8354-f3ba-53fb-3950-ec02d41a12a7@redhat.com>
Date:   Wed, 19 Apr 2023 18:41:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     brouer@redhat.com, bpf@vger.kernel.org,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org, martin.lau@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, alexandr.lobakin@intel.com,
        larysa.zaremba@intel.com, xdp-hints@xdp-project.net,
        yoong.siang.song@intel.com, intel-wired-lan@lists.osuosl.org,
        pabeni@redhat.com, jesse.brandeburg@intel.com, kuba@kernel.org,
        edumazet@google.com, john.fastabend@gmail.com, hawk@kernel.org,
        davem@davemloft.net
Subject: Re: [PATCH bpf-next V2 5/5] selftests/bpf: xdp_hw_metadata track more
 timestamps
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>
References: <168182460362.616355.14591423386485175723.stgit@firesoul>
 <168182466298.616355.2544377890818617459.stgit@firesoul>
 <ZD7HJ3hdDdOSm/lK@google.com>
In-Reply-To: <ZD7HJ3hdDdOSm/lK@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 18/04/2023 18.36, Stanislav Fomichev wrote:
> On 04/18, Jesper Dangaard Brouer wrote:
>> To correlate the hardware RX timestamp with something, add tracking of
>> two software timestamps both clock source CLOCK_TAI (see description in
>> man clock_gettime(2)).
>>
>> XDP metadata is extended with xdp_timestamp for capturing when XDP
>> received the packet. Populated with BPF helper bpf_ktime_get_tai_ns(). I
>> could not find a BPF helper for getting CLOCK_REALTIME, which would have
>> been preferred. In userspace when AF_XDP sees the packet another
>> software timestamp is recorded via clock_gettime() also clock source
>> CLOCK_TAI.
>>
[...]

>> More explanation of the output and how this can be used to identify
>> clock drift for the HW clock can be seen here[1]:
>>
>> [1]https://github.com/xdp-project/xdp-project/blob/master/areas/hints/xdp_hints_kfuncs02_driver_igc.org
>>
>> Signed-off-by: Jesper Dangaard Brouer<brouer@redhat.com>
> Acked-by: Stanislav Fomichev<sdf@google.com>
> 
>> ---
>>   .../testing/selftests/bpf/progs/xdp_hw_metadata.c  |    4 +-
>>   tools/testing/selftests/bpf/xdp_hw_metadata.c      |   47 ++++++++++++++++++--
>>   tools/testing/selftests/bpf/xdp_metadata.h         |    1
>>   3 files changed, 46 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
>> index e1c787815e44..b2dfd7066c6e 100644
>> --- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
>> +++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
>> @@ -77,7 +77,9 @@ int rx(struct xdp_md *ctx)
>>   	}
>>   
>>   	err = bpf_xdp_metadata_rx_timestamp(ctx, &meta->rx_timestamp);
>> -	if (err)
> [..]
> 
>> +	if (!err)
>> +		meta->xdp_timestamp = bpf_ktime_get_tai_ns();
> nit: why not set it unconditionally?

Because userspace application doesn't use it for anything, when
meta->rx_timestamp is zero.

--Jesper

