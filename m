Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFE845F0C6
	for <lists+bpf@lfdr.de>; Fri, 26 Nov 2021 16:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377908AbhKZPiG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Nov 2021 10:38:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45972 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349699AbhKZPgF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Nov 2021 10:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637940772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t1+6lLBKzRsOvvoLZavbDMeX/0SVAxdl2+X6EFyhRfA=;
        b=Z0D2cbgl1d/O52LG6dk6OhwcvgBEDbsVFKAOObngv/X2zeiGKdy5f2zt/vic1SK8jADdY7
        CmMg+GlmxFS/KD7TRZBc5r7FKTKDX0T5UEmQ27EBfiDdEwtYrGK8LvodP2GyaAimwXYIDU
        VPvmao3r3M4o3nuUwv8j77hSTumG5Ws=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-Uf0zYklOOmeOe3O2WFQLEA-1; Fri, 26 Nov 2021 10:32:50 -0500
X-MC-Unique: Uf0zYklOOmeOe3O2WFQLEA-1
Received: by mail-wr1-f71.google.com with SMTP id d3-20020adfa343000000b0018ed6dd4629so1749296wrb.2
        for <bpf@vger.kernel.org>; Fri, 26 Nov 2021 07:32:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:in-reply-to
         :content-transfer-encoding;
        bh=t1+6lLBKzRsOvvoLZavbDMeX/0SVAxdl2+X6EFyhRfA=;
        b=LJXzu2VndBzH1E1xtVzd0J+IW7NzQiUs48Jk/mhahqYQJAg0L1pG3EvHGERbIYcC3E
         r0h8+aRbpKf3ywDewAI7WHxKKYPabTA4TngAa5/XxOKLDW74FMjt3cgqVODRxSxCatyQ
         QRUgaiDyb5baKEUv5YhjI6lz2kyM2tvzDOR3H1Lr9yLOjwA1EKW4D2mOdhX0+P5Za56z
         DC/9CcDqkGrPb0wcR+U/sdUPBkuWaR3gi9ctgfW+Izr+aFmpvYPEQ+3ZGhR03K4UbgjE
         wADLMqkf20GYPmm3bEOR97Ij5g1dT8S8TmZ8kwwiBFOBB6f6Dwnlo/9oz62odRlC3Z6r
         NJUA==
X-Gm-Message-State: AOAM530I650h4vh/jrCBp4cyrJWecDcGq5uNfn5PHZLFCRyDZIy2Zmme
        /BtK+YgVud7BIcmwlL0hIW+/lHQED1Bx9v5gJmar/kp8lG31eyUhivM+eqB4vvdEsf6jgUIjbr5
        yeiDfRDPh6DT+
X-Received: by 2002:adf:fb09:: with SMTP id c9mr14519911wrr.223.1637940769683;
        Fri, 26 Nov 2021 07:32:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgfSH4rBkDxJpw/E0R3JU0oHbTtNz0X3Ozh45JI/JWmFIsykZ0b2AySxDMJwQ9RLbXRKFf9Q==
X-Received: by 2002:adf:fb09:: with SMTP id c9mr14519899wrr.223.1637940769532;
        Fri, 26 Nov 2021 07:32:49 -0800 (PST)
Received: from [192.168.2.13] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id h17sm11479193wmb.44.2021.11.26.07.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 07:32:49 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <66f62ef7-f4c6-08df-a8e1-dbbe34b9b125@redhat.com>
Date:   Fri, 26 Nov 2021 16:32:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Cc:     brouer@redhat.com, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, bjorn@kernel.org,
        Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <borkmann@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>, magnus.karlsson@intel.com
Subject: Re: [Intel-wired-lan] [PATCH net-next 1/2] igc: AF_XDP zero-copy
 metadata adjust breaks SKBs on XDP_PASS
Content-Language: en-US
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>
References: <163700856423.565980.10162564921347693758.stgit@firesoul>
 <163700858579.565980.15265721798644582439.stgit@firesoul>
 <YaD8UHOxHasBkqEW@boxer>
In-Reply-To: <YaD8UHOxHasBkqEW@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 26/11/2021 16.25, Maciej Fijalkowski wrote:
> On Mon, Nov 15, 2021 at 09:36:25PM +0100, Jesper Dangaard Brouer wrote:
>> Driver already implicitly supports XDP metadata access in AF_XDP
>> zero-copy mode, as xsk_buff_pool's xp_alloc() naturally set xdp_buff
>> data_meta equal data.
>>
>> This works fine for XDP and AF_XDP, but if a BPF-prog adjust via
>> bpf_xdp_adjust_meta() and choose to call XDP_PASS, then igc function
>> igc_construct_skb_zc() will construct an invalid SKB packet. The
>> function correctly include the xdp->data_meta area in the memcpy, but
>> forgot to pull header to take metasize into account.
>>
>> Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
>> Signed-off-by: Jesper Dangaard Brouer<brouer@redhat.com>
> Acked-by: Maciej Fijalkowski<maciej.fijalkowski@intel.com>
> 
> Great catch. Will take a look at other ZC enabled Intel drivers if they
> are affected as well.

Thanks a lot for taking this task!!! :-)
--Jesper

