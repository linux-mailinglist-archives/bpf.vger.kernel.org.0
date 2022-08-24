Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351E759FE20
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 17:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239057AbiHXPVJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 11:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238564AbiHXPVI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 11:21:08 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EC772EED
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 08:21:05 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id d5so8930522wms.5
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 08:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc;
        bh=QNvm79OOQPbL0XIzyFu4UvOTyu1+5UwgVDjnZfGGBxQ=;
        b=TheTo66bZcyDf/KknhNsG4h9DflAb/b63gHhGs4HOHFysPqzsbdZhG7A0jySfDihMK
         bDWWJFNuHeDnGcmRRJiTnKSG6wdFg7U8s8ZT/VMYkdaSo+NJuIWPvmEB9f/vk9F1DoDq
         1AO/rXd1xYzi+FEN4uSa5qgpYsHGhDD0b01fIRjZGYpe4tdot0sNeCTrxlv2nJoARkVM
         rgZjAufClfRaayT2ry+niEfEvknEOyAACdO8U0RfSLBhGRDjqwreXglL2EWguKKKm/nw
         2tpDLhG/2zfI7ugoFTZRY6D0ciWFj5/VBe3Xs4LCLZNIR6RywMISUN7001NfURI8xDIl
         teOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc;
        bh=QNvm79OOQPbL0XIzyFu4UvOTyu1+5UwgVDjnZfGGBxQ=;
        b=puotHJkwvwPMqt6dlElt7a6y1YSxVw5o204Gu4z+iNC1qgqkCmCOIfo2HdOtOJiucs
         3M8PC5G14pNExxVIaCj4tQGYe485g8Zwal8/DoVVDFz+1JEcGXPN+bcCQSAhuupQO7bc
         0BZm2h/BniuZeY1JXR8+hHKIG1jNxPyY0TFkabsowZEik9VCQURk1NdG1fSzF2bSlblj
         tfiZfETViNrpB11v9JJQYPzsyYMxNHXmRK7WdWG58gWjlqh9n3gWSvBbRYFu8fab8R09
         /y0VvP3D+WQFMqvj1S9ixbrXNi0FjmK94tACHC0rGERDyyqbIx1uJM7QV+bb5sug7zJQ
         kbfw==
X-Gm-Message-State: ACgBeo0Qs2wRpdo7o8+0V4jKDDRxcbVy5lIRo4cz02cqRPVMedAC+G5+
        5qAbnUfLh4HUziYcHSCD3wonajZolNlphw==
X-Google-Smtp-Source: AA6agR6CWc6XnJWnr3tFe7Z1Wjdy3ph4MFxhIpMvdYeuK8OPIw/0QvFZVVkG5eDcHfGaQuICEGKWwQ==
X-Received: by 2002:a05:600c:a49:b0:3a6:673a:2a9b with SMTP id c9-20020a05600c0a4900b003a6673a2a9bmr5487698wmq.3.1661354464174;
        Wed, 24 Aug 2022 08:21:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:f097:bc8b:5ea1:f211? ([2a01:e0a:b41:c160:f097:bc8b:5ea1:f211])
        by smtp.gmail.com with ESMTPSA id f14-20020a5d568e000000b0021e4829d359sm16927261wrv.39.2022.08.24.08.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 08:21:03 -0700 (PDT)
Message-ID: <565cce1e-0890-dd35-7b26-362da2cde128@6wind.com>
Date:   Wed, 24 Aug 2022 17:21:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH ipsec-next 3/3] xfrm: lwtunnel: add lwtunnel support for
 xfrm interfaces in collect_md mode
Content-Language: en-US
To:     Eyal Birger <eyal.birger@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        pablo@netfilter.org, contact@proelbtn.com, dsahern@kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, devel@linux-ipsec.org
References: <20220823154557.1400380-1-eyal.birger@gmail.com>
 <20220823154557.1400380-4-eyal.birger@gmail.com>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20220823154557.1400380-4-eyal.birger@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Le 23/08/2022 à 17:45, Eyal Birger a écrit :
> Allow specifying the xfrm interface if_id as part of a route metadata
> using the lwtunnel infrastructure.
> 
> This allows for example using a single xfrm interface in collect_md
> mode as the target of multiple routes each specifying a different if_id.
> 
> With the appropriate changes to iproute2, considering an xfrm device
> ipsec1 in collect_md mode one can for example add a route specifying
> an if_id like so:
> 
> ip route add <SUBNET> dev ipsec1 encap xfrm if_id 1
It would be nice to be able to specify the link also. It may help to combine
this with vrf. Something like
ip route add <SUBNET> dev ipsec1 encap xfrm if_id 1 dev eth0
