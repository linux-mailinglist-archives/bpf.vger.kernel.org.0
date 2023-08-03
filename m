Return-Path: <bpf+bounces-6830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B622B76E4A2
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 11:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75AA1C214AB
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 09:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB719156EE;
	Thu,  3 Aug 2023 09:37:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12387E
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 09:37:22 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090E549C5
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 02:37:03 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9b5ee9c5aso11043631fa.1
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 02:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1691055422; x=1691660222;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gxxp4r3SLmVXwd7QLESwzGmLVMkeoSmrpwS9UI/62t0=;
        b=acEQPoObNLR7tVSVXXSQ555mxs8lxpcIuwtpflobSdEj//y/UjbxT7u7RqLVm9Nv5R
         svvVCLf67TqVuxI/XmGs7SVYWEOxye2vpfsairjf+RHTiQyTKSviu5Cz4gHwu28imxYj
         YaIfm6Qc0Q96ToFQNd0mIb7o5eavaiCarDLXIzaqScTeyem5wPXI556/Jkxp+zfCkx1t
         74iQpVKtBvrr45QgQBFOgUwu3VjnT/xmyS8NNPUv1qifkHq98NbivLvO3fc2rtWVvP1s
         nVkJOtzIdIhhRd8ZVR1ciIrIIPwCpEpku4o1olb58Ute8EImuuet+KaCOosMGyz0/Gnm
         tiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691055422; x=1691660222;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxxp4r3SLmVXwd7QLESwzGmLVMkeoSmrpwS9UI/62t0=;
        b=faiyhg+6chDDn4u2PkPhSu5daPl4hP0WJqmkvwmzvD/U5f2SKNP40ZdmZME1AhihgG
         rLem1+eooS8yBtRfvO4Gh6gEfLlLnzaek+zQU9Zuxne2zjolrWVsUa9XBLQ2crEvbtfe
         RKnrybtmJLdtKmKTwLL/b7Eg1zbibXrY7iqUq237yjFVajUJpXSNIvpRpFjOos3fQ5NP
         Cb//t1PznhKMkxsJo9RwAPNtT1j1dyfMdRGa754GJHgh8yDBHdfbXIg3Rt47wXmvmwGU
         aHnknf3XzANIh4kMYJLrCPrEveiKlNiEHTFcVIk3y3pe+3Z3RAaXajavnG1CGk26r/He
         cJwQ==
X-Gm-Message-State: ABy/qLZ1umSMkLfOpoo7P52OBLWX0S4wEjMQ/jQAhmAXvvP7EeHWhMKu
	P6+0MRZ8Xt2hvJPQ7R2stW9DyQ==
X-Google-Smtp-Source: APBJJlEs8YzTQttp3hUrbLEDyf9NAMl6vSv/PbMAAFVYnpx1fJeaxkw7Fehwg6kpmFFPc3sx7x40aA==
X-Received: by 2002:a05:651c:106:b0:2b5:80e0:f18e with SMTP id a6-20020a05651c010600b002b580e0f18emr6697660ljb.3.1691055422157;
        Thu, 03 Aug 2023 02:37:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:715:a86c:f2f5:a28? ([2a01:e0a:b41:c160:715:a86c:f2f5:a28])
        by smtp.gmail.com with ESMTPSA id m14-20020a7bce0e000000b003fbc9b9699dsm3760781wmc.45.2023.08.03.02.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 02:37:01 -0700 (PDT)
Message-ID: <34f246ba-3ebc-1257-fe8d-5b7e0670a4a6@6wind.com>
Date: Thu, 3 Aug 2023 11:37:00 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v2] net: handle ARPHRD_PPP in dev_is_mac_header_xmit()
Content-Language: en-US
To: Guillaume Nault <gnault@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, stable@vger.kernel.org,
 Siwar Zitouni <siwar.zitouni@6wind.com>
References: <20230802122106.3025277-1-nicolas.dichtel@6wind.com>
 <ZMtpSdLUQx2A6bdx@debian>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <ZMtpSdLUQx2A6bdx@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Le 03/08/2023 à 10:46, Guillaume Nault a écrit :
> On Wed, Aug 02, 2023 at 02:21:06PM +0200, Nicolas Dichtel wrote:
>> This kind of interface doesn't have a mac header.
> 
> Well, PPP does have a link layer header.
It has a link layer, but not an ethernet header.

> Do you instead mean that PPP automatically adds it?
> 
>> This patch fixes bpf_redirect() to a ppp interface.
> 
> Can you give more details? Which kind of packets are you trying to
> redirect to PPP interfaces?
My ebpf program redirect an IP packet (eth / ip) from a physical ethernet device
at ingress to a ppp device at egress. In this case, the bpf_redirect() function
should remove the ethernet header from the packet before calling the xmit ppp
function. Before my patch, the ppp xmit function adds a ppp header (protocol IP
/ 0x0021) before the ethernet header. It results to a corrupted packet. After
the patch, the ppp xmit function encapsulates the IP packet, as expected.

> 
> To me this looks like a hack to work around the fact that
> ppp_start_xmit() automatically adds a PPP header. Maybe that's the
It's not an hack, it works like for other kind of devices managed by the
function bpf_redirect() / dev_is_mac_header_xmit().

Hope it's more clear.


Regards,
Nicolas

> best we can do given the current state of ppp_generic.c, but the
> commit message should be clear about what the real problem is and
> why the patch takes this approach to fix or work around it.
> 
>> CC: stable@vger.kernel.org
>> Fixes: 27b29f63058d ("bpf: add bpf_redirect() helper")
>> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>> Tested-by: Siwar Zitouni <siwar.zitouni@6wind.com>
>> ---
>>
>> v1 -> v2:
>>  - I forgot the 'Tested-by' tag in the v1 :/
>>
>>  include/linux/if_arp.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/if_arp.h b/include/linux/if_arp.h
>> index 1ed52441972f..8efbe29a6f0c 100644
>> --- a/include/linux/if_arp.h
>> +++ b/include/linux/if_arp.h
>> @@ -53,6 +53,7 @@ static inline bool dev_is_mac_header_xmit(const struct net_device *dev)
>>  	case ARPHRD_NONE:
>>  	case ARPHRD_RAWIP:
>>  	case ARPHRD_PIMREG:
>> +	case ARPHRD_PPP:
>>  		return false;
>>  	default:
>>  		return true;
>> -- 
>> 2.39.2
>>
>>
> 

