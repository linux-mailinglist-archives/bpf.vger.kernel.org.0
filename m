Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C08F5A2744
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 13:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238115AbiHZL6T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 07:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237371AbiHZL6S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 07:58:18 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44C2A00F2
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 04:58:17 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id s23so757881wmj.4
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 04:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc;
        bh=CJragOxN0SWEL57l+z85qeXl9sYaycciV/nRbKo2HoE=;
        b=aW+XruSvZHNsNo6POYH1OPONSqmKs8E9Wf2dRN2RUwb5diiYsXCf2FxkshQLpByEOp
         bc6UiGAT7XG1XppUgQrmkqv07BQxiS4VjazErHPX7KMoyuEAseHM5yS44qdJPSbUocxP
         +onlPlBT74SX7LLKioSEwmfa2wvU1GfG2hTmMKJuIGAtIgOllJGa3T8VKE7psdxfrXrp
         2HJNTNOyXAyIHhhIYcUSCw/Mjs8YlCECFOQcpzztjbp69hnm6mqeEpZobyXF9fXgnub1
         Nuqq667/3Lh+s2FjrtolTO4F87xZi1uJrYYUgvbL4nkVJAKTB+XKd2lr1M9BScklzxql
         dzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc;
        bh=CJragOxN0SWEL57l+z85qeXl9sYaycciV/nRbKo2HoE=;
        b=NAlw8c+05spud1J+xcgI+EUrOmNS8Du3liQOuWL16L32WgyFnTejIh0tdgD6AeZaGl
         +VVzHgw037iggFtNZ5yoKjOClF80qyRoVpIMicf1mIgsBzoww1OwRbgVtalc3BtPaaZJ
         daFSAorOhFO05+T2Jcqb2gSjJT8yDD5DVCo4IJKUQltrAZYW9tNqtuHvgQCruo3FLD/V
         DhkWoRyS+RNAs6+4Qcv8oojNbGuZ2sZJz0pwcOchpY2jVFury0O/FfzZfKC8LzpXSuQ6
         b2F4U3Tj4YnflMUFqes5XEE1xWsANBsk+OMBp4jHInWXmgfBz3gPxzkhlLWh+Oq7xhxF
         YGBQ==
X-Gm-Message-State: ACgBeo1EttisRmxLoOPQVgF7QidJjw4oUsS0zITpFlVyeUa2lrnj4LiI
        Nw+dTwUwlaoOsKU8bTkjZ1wUuw==
X-Google-Smtp-Source: AA6agR5oMindnDneuk7m8igrbI3srNOQ+FqDIuK8LAh1Sbeva74weLLBmRYXPMW113r2Ps99BSbOYg==
X-Received: by 2002:a05:600c:3555:b0:3a5:d319:35cd with SMTP id i21-20020a05600c355500b003a5d31935cdmr5007375wmq.161.1661515096304;
        Fri, 26 Aug 2022 04:58:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:5d94:b816:24d3:cd91? ([2a01:e0a:b41:c160:5d94:b816:24d3:cd91])
        by smtp.gmail.com with ESMTPSA id k12-20020adff5cc000000b002250c35826dsm1668498wrp.104.2022.08.26.04.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 04:58:15 -0700 (PDT)
Message-ID: <05b2126c-1307-e866-9791-234426e3322a@6wind.com>
Date:   Fri, 26 Aug 2022 13:58:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH ipsec-next,v4 3/3] xfrm: lwtunnel: add lwtunnel support
 for xfrm interfaces in collect_md mode
Content-Language: en-US
To:     Eyal Birger <eyal.birger@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        dsahern@kernel.org, contact@proelbtn.com, pablo@netfilter.org,
        razor@blackwall.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20220826114700.2272645-1-eyal.birger@gmail.com>
 <20220826114700.2272645-4-eyal.birger@gmail.com>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20220826114700.2272645-4-eyal.birger@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Le 26/08/2022 à 13:47, Eyal Birger a écrit :
> Allow specifying the xfrm interface if_id and link as part of a route
> metadata using the lwtunnel infrastructure.
> 
> This allows for example using a single xfrm interface in collect_md
> mode as the target of multiple routes each specifying a different if_id.
> 
> With the appropriate changes to iproute2, considering an xfrm device
> ipsec1 in collect_md mode one can for example add a route specifying
> an if_id like so:
> 
> ip route add <SUBNET> dev ipsec1 encap xfrm if_id 1
> 
> In which case traffic routed to the device via this route would use
> if_id in the xfrm interface policy lookup.
> 
> Or in the context of vrf, one can also specify the "link" property:
> 
> ip route add <SUBNET> dev ipsec1 encap xfrm if_id 1 link_dev eth15
> 
> Note: LWT_XFRM_LINK uses NLA_U32 similar to IFLA_XFRM_LINK even though
> internally "link" is signed. This is consistent with other _LINK
> attributes in other devices as well as in bpf and should not have an
> effect as device indexes can't be negative.
> 
> Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
