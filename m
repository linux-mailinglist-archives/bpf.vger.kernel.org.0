Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EF85B3447
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 11:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiIIJmp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 05:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiIIJmo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 05:42:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45853CAC72
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 02:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662716562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5iXKFaXwMwTj+qx5rpepg8IFprmEKxi1vIibj/a0OYc=;
        b=TkGpazJdZb8m/jdWtpHTS22qUA5Qa8oVIzU7OiAluyt2EOIvTG3QQaTKpd3ThsIdeATAm1
        +6QE+mRs4E4g1dOApWPZmp5oY6FLEuF1HvK/1AtEXPXayFOmqiGxwJNjF4BM78yptP59WV
        AD/G5ff2PpI4wSN7IZG2k0zOuxeNBfc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-410-CThf1UskOz2vZrJ_vSxdrg-1; Fri, 09 Sep 2022 05:42:41 -0400
X-MC-Unique: CThf1UskOz2vZrJ_vSxdrg-1
Received: by mail-ej1-f69.google.com with SMTP id sh44-20020a1709076eac00b00741a01e2aafso740150ejc.22
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 02:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:cc:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5iXKFaXwMwTj+qx5rpepg8IFprmEKxi1vIibj/a0OYc=;
        b=tzB/2Lvbpaj/nKvSGFXAacwq0royC8vLbC/dDHHuHu8zZ9izQntIneQ+FeT07+Vbz+
         Uj4IDh5HYiz8iTT45s4iCp0NSzDkGbOd2gGRaOxzIzFzC3Ru2NjQBmeChFt3Q6JTMjOz
         Hm76xWsH3ndxkC1tZQwfu19kzB3h0xOcoBthsJXVonSdc3Sn87pt8cL6MxdTIxxqpnBm
         /f34Nd42QUz0PiBObOcsTsaRIcAZiJeQS5seALNCM8x/WJtP3/REIk06WW+UQWq+e8xv
         c3n0h/SkBA97D5zZ+shW77+fsUFsK1jZU9imwXrCa20bKk/Y7+rPNVhYnRpL5rF/yTl/
         cTng==
X-Gm-Message-State: ACgBeo1ZuBe/r76nUh3YrnCCnAxQZoh6wbXMzI65yvgCk6lNgFB5ip5k
        HXtFSvKt8vieXZbJLa8k8QHLi82pmQ7Z084wDTrcfkFAy5CA0xy+5ZUhJpVs74jNukb8fB/Ylu8
        Gh0e1QY1TJtdo
X-Received: by 2002:a05:6402:351:b0:44e:1cd2:bd53 with SMTP id r17-20020a056402035100b0044e1cd2bd53mr10507086edw.364.1662716560194;
        Fri, 09 Sep 2022 02:42:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7VORBRl+U9ThWWjUQ2G9Wxzqu4Djdg56wVHmV/d5FLJ5A38wxS4QWjJ3t06dJtL6JweATOcw==
X-Received: by 2002:a05:6402:351:b0:44e:1cd2:bd53 with SMTP id r17-20020a056402035100b0044e1cd2bd53mr10507075edw.364.1662716559994;
        Fri, 09 Sep 2022 02:42:39 -0700 (PDT)
Received: from [192.168.41.81] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id c19-20020a056402121300b0044f0f51f813sm17379edw.83.2022.09.09.02.42.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 02:42:32 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <593cc1df-8b65-ae9e-37eb-091b19c4d00e@redhat.com>
Date:   Fri, 9 Sep 2022 11:42:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Cc:     brouer@redhat.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        xdp-hints@xdp-project.net, larysa.zaremba@intel.com,
        memxor@gmail.com, Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        dave@dtucker.co.uk, Magnus Karlsson <magnus.karlsson@intel.com>,
        bjorn@kernel.org
Subject: Re: [PATCH RFCv2 bpf-next 17/18] xsk: AF_XDP xdp-hints support in
 desc options
To:     Maryam Tahhan <mtahhan@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>
References: <166256538687.1434226.15760041133601409770.stgit@firesoul>
 <166256558657.1434226.7390735974413846384.stgit@firesoul>
 <CAJ8uoz3UcC2tnMtG8W6a3HpCKgaYSzSCqowLFQVwCcsr+NKBOQ@mail.gmail.com>
 <b5f0d10d-2d4e-34d6-1e45-c206cb6f5d26@redhat.com>
 <9aab9ef1-446d-57ab-5789-afffe27801f4@redhat.com>
 <CAJ8uoz0CD18RUYU4SMsubB8fhv3uOwp6wi_uKsZSu_aOV5piaA@mail.gmail.com>
 <e1ab2141-03cc-f97c-3788-59923a029203@redhat.com>
Content-Language: en-US
In-Reply-To: <e1ab2141-03cc-f97c-3788-59923a029203@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 09/09/2022 10.12, Maryam Tahhan wrote:
> <snip>
>>>>>
>>>>> * Instead encode this information into each metadata entry in the
>>>>> metadata area, in some way so that a flags field is not needed (-1
>>>>> signifies not valid, or whatever happens to make sense). This has the
>>>>> drawback that the user might have to look at a large number of entries
>>>>> just to find out there is nothing valid to read. To alleviate this, it
>>>>> could be combined with the next suggestion.
>>>>>
>>>>> * Dedicate one bit in the options field to indicate that there is at
>>>>> least one valid metadata entry in the metadata area. This could be
>>>>> combined with the two approaches above. However, depending on what
>>>>> metadata you have enabled, this bit might be pointless. If some
>>>>> metadata is always valid, then it serves no purpose. But it might if
>>>>> all enabled metadata is rarely valid, e.g., if you get an Rx timestamp
>>>>> on one packet out of one thousand.
>>>>>
>>>
>>> I like this option better! Except that I have hoped to get 2 bits ;-)
>>
>> I will give you two if you need it Jesper, no problem :-).
>>
> 
> Ok I will look at implementing and testing this and post an update.

Perfect if you Maryam have cycles to work on this.

Let me explain what I wanted the 2nd bit for.  I simply wanted to also
transfer the XDP_FLAGS_HINTS_COMPAT_COMMON flag.  One could argue that
is it redundant information as userspace AF_XDP will have to BTF decode
all the know XDP-hints. Thus, it could know if a BTF type ID is
compatible with the common struct.   This problem is performance as my
userspace AF_XDP code will have to do more code (switch/jump-table or
table lookup) to map IDs to common compat (to e.g. extract the RX-csum
indication).  Getting this extra "common-compat" bit is actually a
micro-optimization.  It is up to AF_XDP maintainers if they can spare
this bit.


> Thanks folks
> 
>>> The performance advantage is that the AF_XDP descriptor bits will
>>> already be cache-hot, and if it indicates no-metadata-hints the AF_XDP
>>> application can avoid reading the metadata cache-line :-).
>>
>> Agreed. I prefer if we can keep it simple and fast like this.
>>

Great, lets proceed this way then.

> <snip>
> 

Thinking ahead: We will likely need 3 bits.

The idea is that for TX-side, we set a bit indicating that AF_XDP have
provided a valid XDP-hints layout (incl corresponding BTF ID). (I would
overload and reuse "common-compat" bit if TX gets a common struct).

But lets land RX-side first, but make sure we can easily extend for the 
TX-side.

--Jesper

