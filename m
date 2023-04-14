Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F2E6E2577
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 16:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjDNOT3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Apr 2023 10:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjDNOT3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 10:19:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D48A262
        for <bpf@vger.kernel.org>; Fri, 14 Apr 2023 07:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681481925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sX4uJHc1E4iUI/WZObcqqEuHDDY4tzWA7F305PZUU8s=;
        b=WjtV6vZ5IsECtSF9Rad7AejqERNrFJHaWDg4MxPjslCkLwysRL1fZehBSkw1eZx/FZygJ/
        5fQwzA0U/eplBOt6z3chkwL3JxR1lx6J5OFiPPWmMKFgcguyBbsjQ/29M7+4VTvUCZZrup
        PqlVxeIdtQJWVxoN6JqgF6y9iIyG33E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-zDL_akYtMcicTXiXL1VoXA-1; Fri, 14 Apr 2023 10:18:44 -0400
X-MC-Unique: zDL_akYtMcicTXiXL1VoXA-1
Received: by mail-ej1-f71.google.com with SMTP id ud12-20020a170907c60c00b0093c44a07ad1so6757428ejc.2
        for <bpf@vger.kernel.org>; Fri, 14 Apr 2023 07:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681481922; x=1684073922;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sX4uJHc1E4iUI/WZObcqqEuHDDY4tzWA7F305PZUU8s=;
        b=DBoeeReJ56aewtHG9dRWynvOBZSqT8Dp6dYy8n0fis7mv0/cxSyvIoUWzKFEXFg4vQ
         8swXc+mtKc7au/4hz2JDO6LvLKBU/IagG0n9G9KiqxYKrvVYL1hjASoxRVCm256r1Hg8
         c/seOZGfTYAvPYUVbSSaPprUP+6w5JKGq7+rL6MjV5hBzf5h2bm9j/m5gVk3VqRS/gqs
         kS7S1NAmDje+s11tCyw45lHbHkw6cwlLBbQQLbGmFeHVMwYYK9GX9sLHj6g3RJ0qHOZV
         2/rgve3MmApojP96tObwN69kbsmzrVXP2Ej/QfboNsEjdLpRu8xkQ6Dy4kqt4K6mbWJv
         Ri2w==
X-Gm-Message-State: AAQBX9e4U/3Tbhv5J2JCrwiL1lKt9yG5fdqzyyRmWu/JVFZxitTCfZEH
        bRFVt8qckhI7cuT9x19Md+PInxr9HU+VebPMy6cXEiCjlxg6nJVHeiOTb/c12m/4GGcmE16r/q+
        MBh5wolb0fy3b9T6QmoWE
X-Received: by 2002:a17:907:7241:b0:94a:643e:9e26 with SMTP id ds1-20020a170907724100b0094a643e9e26mr5922543ejc.14.1681481922652;
        Fri, 14 Apr 2023 07:18:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZGanoF3DPoBXFRBQWN2exgOX9hffPn/GzhyqL5JtNnAtLoKcw780bho7MF1qA/qcnMgOnwzA==
X-Received: by 2002:a17:907:7241:b0:94a:643e:9e26 with SMTP id ds1-20020a170907724100b0094a643e9e26mr5922524ejc.14.1681481922343;
        Fri, 14 Apr 2023 07:18:42 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906838900b009497509fda3sm2503755ejx.40.2023.04.14.07.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 07:18:41 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <a81e4d8e-c668-5238-225a-8223af45a063@redhat.com>
Date:   Fri, 14 Apr 2023 16:18:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     brouer@redhat.com,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>
Subject: Re: [PATCH net v2 1/1] igc: read before write to SRRCTL register
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        "'Song, Yoong Siang'" <yoong.siang.song@intel.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
        Vedang Patel <vedang.patel@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        Andre Guedes <andre.guedes@intel.com>,
        Stanislav Fomichev <sdf@google.com>,
        "Keller, Jacob E" <jacob.e.keller@intel.com>
References: <20230414020915.1869456-1-yoong.siang.song@intel.com>
 <8214fb10-8caa-4418-8435-85b6ac27b69e@redhat.com>
 <PH0PR11MB5830D3F9144B61A6959A4A0FD8999@PH0PR11MB5830.namprd11.prod.outlook.com>
 <4dc9ea6c77ff49138a49d7f73f7301fd@AcuMS.aculab.com>
In-Reply-To: <4dc9ea6c77ff49138a49d7f73f7301fd@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 14/04/2023 14.32, David Laight wrote:
> From: Song, Yoong Siang
>> Sent: 14 April 2023 12:16
> ...
>>> I have checked Foxville manual for SRRCTL (Split and Replication Receive
>>> Control) register and below GENMASKs looks correct.
>>>
>>>> -#define IGC_SRRCTL_BSIZEPKT_SHIFT		10 /* Shift _right_ */
>>>> -#define IGC_SRRCTL_BSIZEHDRSIZE_SHIFT		2  /* Shift _left_ */
>>>> +#define IGC_SRRCTL_BSIZEPKT_MASK	GENMASK(6, 0)
>>>> +#define IGC_SRRCTL_BSIZEPKT_SHIFT	10 /* Shift _right_ */
>>>
>>> Shift due to 1 KB resolution of BSIZEPKT (manual field BSIZEPACKET)
>>
>> Ya, 1K = BIT(10), so need to shift right 10 bits.
> 
> I bet the code would be easier to read if it did 'value / 1024u'.
> The object code will be (much) the same.

I agree. Code becomes more readable for humans and machine code will be 
the same.

>>>> +#define IGC_SRRCTL_BSIZEHDRSIZE_MASK	GENMASK(13, 8)
>>>> +#define IGC_SRRCTL_BSIZEHDRSIZE_SHIFT	2  /* Shift _left_ */
>>>
>>> This shift is suspicious, but as you inherited it I guess it works.
>>> I did the math, and it happens to work, knowing (from manual) value is in 64 bytes
>>> resolution.
>>
>> It is in 64 = BIT(6) resolution, so need to shift right 6 bits.
>> But it start on 8th bit, so need to shift left 8 bits.
>> Thus, total = shift left 2 bits.
>>
>> I didnt put the explanation into the header file because it is too lengthy
>> and user can know from databook.

Well, users usually don't have access to the databook (Programming
Interface) PDF.  Personally I have it, but I had to go though a lot of
red-tape to get it (under Red Hat NDA).


>>
>> How do you feel on the necessary of explaining the shifting logic?
> 
> Not everyone trying to grok the code will have the manual.
> Even writing (8 - 6) will help.
> Or (I think) if the value is in bits 13-8 in units of 64 then just:
> 	((value >> 8) & 0x1f) * 64
> gcc will do a single shift right and a mask 9at some point).
> You might want some defines, but if they aren't used much
> just comments that refer to the names in the manual/datasheet
> can be enough.
> 

After Alexander Lobakin opened my eyes for GENMASK, FIELD_PREP and
FIELD_GET, I find that easier to read and work-with these kind of
register value manipulations, see[1] include/linux/bitfield.h.  It will
also detect if the assigned value exceeds the mask (like David code
handled via mask). (thx Alex)

  [1] 
https://elixir.bootlin.com/linux/v6.3-rc6/source/include/linux/bitfield.h#L14

So, instead of:
   srrctl |= IGC_RX_HDR_LEN << IGC_SRRCTL_BSIZEHDRSIZE_SHIFT;

I would write

   /* BSIZEHDR value in 64 bytes resolution */
   srrctl |= FIELD_PREP(IGC_SRRCTL_BSIZEHDRSIZE_MASK, (IGC_RX_HDR_LEN / 
64));

--Jesper

