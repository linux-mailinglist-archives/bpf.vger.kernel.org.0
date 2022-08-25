Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0536D5A0749
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 04:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiHYC3F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 22:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbiHYC3F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 22:29:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF35923F9
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 19:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661394543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3jF59bnxqmLklAHzEtiDUVdu2dFyXPidcFRU+bKjDi8=;
        b=f1yLM5vIejZ1z+3hmbzk3HcrdK99Lt5vII3WUhj2wSzfSsBAw8ncC7/2Pzv6VZ5xEUlrWf
        wpad5KiwCitV26MOIKoxykbyFxt58PmdAwmxKOYptWw+OQY/jxwgFZ4It9TpEIIB28wX9k
        2VLITBikxd39V3zHAguRbA5qTmHtRJE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-518-E3EhWMyuM3aEB9dp4pUncg-1; Wed, 24 Aug 2022 22:29:02 -0400
X-MC-Unique: E3EhWMyuM3aEB9dp4pUncg-1
Received: by mail-qv1-f71.google.com with SMTP id o6-20020ad443c6000000b00495d04028a6so10762062qvs.18
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 19:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3jF59bnxqmLklAHzEtiDUVdu2dFyXPidcFRU+bKjDi8=;
        b=suVi/VVNz9NyJ4NpZZNr8AwGfgX+41dWtziaux6HRNKXdTHPL5QqNc9g2UgjSlAAC2
         jBynd2iIggcIaSozvJIosFNUmRA3jh7wk8TC9TXckvv0IkTky51eX3y5Dpo5cZwMQD+/
         G77425thhwDpzVPPQacHqIGv2PyJEBj4XWjhR3K6AseOJyFO+09ETGhfDcaqEYqUnxqO
         9ZIOts3O68vUevD9hnfO1ICIQzfrCw6TzK0LKfKFRefy/qSzc7CZg1MFtmICAGVroViY
         cQWI0a+CO/im58/yLbu9lfEZre4rvE0J00dG2g3ohLuq21c7o7y7TdL6uLhhA0X98WUQ
         dnrA==
X-Gm-Message-State: ACgBeo1yjI+G1ZY2gnzYdoWp3L6w2FlWUiDKkIbEjvFcYUQCJUoESiYr
        uL8zcxfokiEbBF6a0bpQ9ykS02WyFuyluufsrmeOAWarSZYD3ZspZZwCtFxli1su9bDTCKowKsE
        LCs08cmCQ+4TF
X-Received: by 2002:a05:620a:15d8:b0:6ba:c5e3:871c with SMTP id o24-20020a05620a15d800b006bac5e3871cmr1623895qkm.572.1661394540669;
        Wed, 24 Aug 2022 19:29:00 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7bG3MtOEQ+X7T87Nh1NCt7nYPw5iq5/sxiSvBa1Ay1+p2Ifdl6EoR7sD1MulRuITnPNRG2bw==
X-Received: by 2002:a05:620a:15d8:b0:6ba:c5e3:871c with SMTP id o24-20020a05620a15d800b006bac5e3871cmr1623874qkm.572.1661394540422;
        Wed, 24 Aug 2022 19:29:00 -0700 (PDT)
Received: from [192.168.98.18] ([107.12.98.143])
        by smtp.gmail.com with ESMTPSA id j12-20020a05620a288c00b006b61b2cb1d2sm16492780qkp.46.2022.08.24.19.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 19:28:59 -0700 (PDT)
Message-ID: <320c2a05-e99a-88b4-2f67-11210ae37903@redhat.com>
Date:   Wed, 24 Aug 2022 22:28:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH net-next v2] bonding: Remove unnecessary check
Content-Language: en-US
To:     Sun Shouxin <sunshouxin@chinatelecom.cn>
Cc:     vfalico@gmail.com, andy@greyhouse.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        huyd12@chinatelecom.cn, Jay Vosburgh <j.vosburgh@gmail.com>
References: <20220824111712.5999-1-sunshouxin@chinatelecom.cn>
 <CAAoacNmKa5oM10J6DTLJ6PANmdS8k80Lcxygv_vXd_0DduXM4A@mail.gmail.com>
From:   Jonathan Toppins <jtoppins@redhat.com>
In-Reply-To: <CAAoacNmKa5oM10J6DTLJ6PANmdS8k80Lcxygv_vXd_0DduXM4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/24/22 14:07, Jay Vosburgh wrote:
> On 8/24/22, Sun Shouxin <sunshouxin@chinatelecom.cn> wrote:
>> This code is intended to support bond alb interface added to
>> Linux bridge by modifying MAC, however, it doesn't work for
>> one bond alb interface with vlan added to bridge.
>> Since commit d5410ac7b0ba("net:bonding:support balance-alb
>> interface with vlan to bridge"), new logic is adapted to handle
>> bond alb with or without vlan id, and then the code is deprecated.
> 
> I think this could still be clearer; the actual changes relate to the stack of
> interfaces (e.g., eth0 -> bond0 -> vlan123 -> bridge0), not what VLAN tags
> incoming traffic contains.
> 
> The code being removed here is specifically for the case of
> eth0 -> bond0 -> bridge0, without an intermediate VLAN interface
> in the stack (because, if memory serves, netif_is_bridge_port doesn't
> transfer through to the bond if there's a VLAN interface in between).
> 
> Also, this code is for incoming traffic, assigning the bond's MAC to
> traffic arriving on interfaces other than the active interface (which bears
> the bond's MAC in alb mode; the other interfaces have different MACs).
> Commit d5410ac7b0ba affects the balance assignments for outgoing ARP
> traffic.  I'm not sure that d5410 is an exact replacement for the code this
> patch removes.

I would be more comfortable with a change like this if it can be 
demonstrated that an example test case functions as expected before and 
after the change. Could a selftests test be written with veths to 
demonstrate this code is indeed redundant?

-Jon

> 
>>
>> Suggested-by: Hu Yadi <huyd12@chinatelecom.cn>
>> Signed-off-by: Sun Shouxin <sunshouxin@chinatelecom.cn>
>> ---
>>   drivers/net/bonding/bond_main.c | 13 -------------
>>   1 file changed, 13 deletions(-)
>>
>> diff --git a/drivers/net/bonding/bond_main.c
>> b/drivers/net/bonding/bond_main.c
>> index 50e60843020c..6b0f0ce9b9a1 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -1578,19 +1578,6 @@ static rx_handler_result_t bond_handle_frame(struct
>> sk_buff **pskb)
>>
>>   	skb->dev = bond->dev;
>>
>> -	if (BOND_MODE(bond) == BOND_MODE_ALB &&
>> -	    netif_is_bridge_port(bond->dev) &&
>> -	    skb->pkt_type == PACKET_HOST) {
>> -
>> -		if (unlikely(skb_cow_head(skb,
>> -					  skb->data - skb_mac_header(skb)))) {
>> -			kfree_skb(skb);
>> -			return RX_HANDLER_CONSUMED;
>> -		}
>> -		bond_hw_addr_copy(eth_hdr(skb)->h_dest, bond->dev->dev_addr,
>> -				  bond->dev->addr_len);
>> -	}
>> -
>>   	return ret;
>>   }
>>
>> --
>> 2.27.0
>>
>>
> 

