Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FB95A25FB
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 12:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245560AbiHZKkl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 06:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245632AbiHZKk0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 06:40:26 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69FCDFE5
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 03:40:23 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id tl26so1637417ejc.9
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 03:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=nfsAQp2OHcZwKprkZEs24IMM+iQYxe3xIY7tA0WFMko=;
        b=xIR+/ME4jvJ6JFwTaGY2rSSWxnwVs9tGS+2dPz1d5BeeTpi7nxywD+EbAH8Zxa9eiF
         dXUH9Z1APrMbadibgf/CX88VTdzDdwL02PHrbzWsptaaQS3tJvg2jm3Tm88E4k8kKFMH
         lfyFF6h8AN+FM+YiOm9z6EBNhV8vi12mgxvfB2vu4hE1X22qxTdUg1rD1vOMgTMtHn4d
         vPi9mw7ZpMAL6WWdjT4xtDOVRAVmvmgh1MT1BDthogEewHxcfdsviyk+lX2Hi6JREmjk
         NDyI9GNPqTvhZfdKiBPUGdSB4o8tSJ1H0ruof7CgfPty9QEk1ZkvQO9H/Zw2jUFAtL1H
         Gq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nfsAQp2OHcZwKprkZEs24IMM+iQYxe3xIY7tA0WFMko=;
        b=K7ACqYZsRB4xJejcUrLysqU/vc5Cv/ue2kxBAEbI6xIp6cqwGehDWKrcyGQHbLLC4D
         rTe5TuEesR/InpFCIyG+RmNxfwZQf2XWdmdJVbU6z67lD3sMY7BPxOO/wfBfGZeMZZ+H
         j4F8V9lc0aOAIHCYzdW8DQ14COnoiJoI4+pYRu1vLSmKFVMGn0qyUn3OFJyjXMJPUgam
         mmUul9ymyRTZt/Eg37hdxGGaARBQGLvBIDuMw82lyhGIQHik9NyUm3TBbXYAFrOUX/mE
         UsaxNzO8RK01UP4/EwLGHh9Eh3mUUaMz1vhX72zdeVdOfGnclqoefHUI5q6QRTAcMLFY
         dHow==
X-Gm-Message-State: ACgBeo3owqmK4yLvXuNR01M9BzodV3IJuQ5Sx+4n3Qe66AUOmT1ea3hQ
        e8g4f++9Y5j46sNrRYTXajqjSHDn9uK56xMifik=
X-Google-Smtp-Source: AA6agR4jv2f82zJfWadF4ZV7vC2HxcnVixJCZnORg1WIn0PDEHireAiwKiDsmoKozbPurauwBL/+Zg==
X-Received: by 2002:a17:907:8a01:b0:731:4316:b0ad with SMTP id sc1-20020a1709078a0100b007314316b0admr5233007ejc.477.1661510422078;
        Fri, 26 Aug 2022 03:40:22 -0700 (PDT)
Received: from [192.168.0.111] (87-243-81-1.ip.btc-net.bg. [87.243.81.1])
        by smtp.gmail.com with ESMTPSA id gg3-20020a170906e28300b0073dc3acfe26sm744396ejb.65.2022.08.26.03.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 03:40:21 -0700 (PDT)
Message-ID: <a851e2eb-9d21-bef8-ef14-d2001ff7a7a6@blackwall.org>
Date:   Fri, 26 Aug 2022 13:40:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH ipsec-next,v3 1/3] net: allow storing xfrm interface
 metadata in metadata_dst
Content-Language: en-US
To:     Eyal Birger <eyal.birger@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        dsahern@kernel.org, contact@proelbtn.com, pablo@netfilter.org,
        nicolas.dichtel@6wind.com, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20220825154630.2174742-1-eyal.birger@gmail.com>
 <20220825154630.2174742-2-eyal.birger@gmail.com>
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220825154630.2174742-2-eyal.birger@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 25/08/2022 18:46, Eyal Birger wrote:
> XFRM interfaces provide the association of various XFRM transformations
> to a netdevice using an 'if_id' identifier common to both the XFRM data
> structures (polcies, states) and the interface. The if_id is configured by
> the controlling entity (usually the IKE daemon) and can be used by the
> administrator to define logical relations between different connections.
> 
> For example, different connections can share the if_id identifier so
> that they pass through the same interface, . However, currently it is
> not possible for connections using a different if_id to use the same
> interface while retaining the logical separation between them, without
> using additional criteria such as skb marks or different traffic
> selectors.
> 
> When having a large number of connections, it is useful to have a the
> logical separation offered by the if_id identifier but use a single
> network interface. Similar to the way collect_md mode is used in IP
> tunnels.
> 
> This patch attempts to enable different configuration mechanisms - such
> as ebpf programs, LWT encapsulations, and TC - to attach metadata
> to skbs which would carry the if_id. This way a single xfrm interface in
> collect_md mode can demux traffic based on this configuration on tx and
> provide this metadata on rx.
> 
> The XFRM metadata is somewhat similar to ip tunnel metadata in that it
> has an "id", and shares similar configuration entities (bpf, tc, ...),
> however, it does not necessarily represent an IP tunnel or use other
> ip tunnel information, and also has an optional "link" property which
> can be used for affecting underlying routing decisions.
> 
> Additional xfrm related criteria may also be added in the future.
> 
> Therefore, a new metadata type is introduced, to be used in subsequent
> patches in the xfrm interface and configuration entities.
> 
> Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
> 
> ----
> 
> v2: add "link" property as suggested by Nicolas Dichtel
> ---
>  include/net/dst_metadata.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

