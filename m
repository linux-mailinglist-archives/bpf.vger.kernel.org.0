Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC5F588B11
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 13:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbiHCLYJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 07:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiHCLYI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 07:24:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E59E1D339
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 04:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659525845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3FOcvqJbUoGHDDUFPqQYrb80yq1QgKC3KQgj7v11X3w=;
        b=Hl+mtnJq8XhFOI/TaStsdooCYoaOsihsJ6nEUm8i/TV6E8+WXjXZMoAu/J2Kb/p1DJWFcR
        IuEet6Mo8w7FB05fEwAnZIkeexGyGOLKyX+0U/mCpHPEm2z3tk4813Vkq461FpTV3SqB1X
        Qj4ijYlBYbZiRkxoZbCbAwzVD827WRI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-x4HgasFSN_-SDZqTdb6l_A-1; Wed, 03 Aug 2022 07:24:01 -0400
X-MC-Unique: x4HgasFSN_-SDZqTdb6l_A-1
Received: by mail-qk1-f199.google.com with SMTP id bl27-20020a05620a1a9b00b0069994eeb30cso13255451qkb.11
        for <bpf@vger.kernel.org>; Wed, 03 Aug 2022 04:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3FOcvqJbUoGHDDUFPqQYrb80yq1QgKC3KQgj7v11X3w=;
        b=RWnH+qj1HYoCKzWkhERG07I6P51KSfH3mWeBblKL7RwoJ7mg0WEJqZ2gqcETFn4tZP
         KsHpoaiiQV5oFkdgsB2qz/z0HUYav7rj+KCr4a8z3rIfmDYqj2e9ODMt0HRCpiXJp/vY
         F8PNNSOT/FcMuIgW6KnFrBfSdOl3CxHwmaiCc3t6RF8LCDZ9QB8rGTNR7b7VCkydo+JG
         yW3t/uCCekAX+r762y5myLyzqyBWaAVPvG1ncKcslNc8/P0V189pzJ7FY7J6PAIT/58k
         waYESCwtoTKpm5Wz6XLAbGJ7/A8Y3uUxwjfkL//pbYPpdatZQPxJ1NyOUiahhiGTXCbm
         BhOQ==
X-Gm-Message-State: AJIora9TX7uGq7CwYIHZjlqG2isGzH0hrTPam5kSlAlOFxrQxoy4iMdS
        NfRTa+JTm+VGbQboNOcQJBZtoy/CubX5GWB0bKjiTvFFpIEAlsKJ7eOdxd2cnlYMXmq8pb8smN5
        6AXAriss1greo
X-Received: by 2002:a05:622a:247:b0:31f:1ede:840b with SMTP id c7-20020a05622a024700b0031f1ede840bmr21715040qtx.564.1659525841368;
        Wed, 03 Aug 2022 04:24:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tz5KSr5SVrnhkcL1Hcg5mE7G3xX8TvBx1o0yHreZukVEWfYCkszcC3wldnfhHBqw0mSOSLXA==
X-Received: by 2002:a05:622a:247:b0:31f:1ede:840b with SMTP id c7-20020a05622a024700b0031f1ede840bmr21715005qtx.564.1659525841139;
        Wed, 03 Aug 2022 04:24:01 -0700 (PDT)
Received: from pc-4.home (2a01cb058918ce00dd1a5a4f9908f2d5.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dd1a:5a4f:9908:f2d5])
        by smtp.gmail.com with ESMTPSA id m26-20020ac866da000000b00339163a06fcsm3147288qtp.6.2022.08.03.04.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 04:24:00 -0700 (PDT)
Date:   Wed, 3 Aug 2022 13:23:54 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Matthias May <matthias.may@westermo.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, roopa@nvidia.com,
        eng.alaamohamedsoliman.am@gmail.com, bigeasy@linutronix.de,
        saeedm@nvidia.com, leon@kernel.org, roid@nvidia.com,
        maord@nvidia.com, lariel@nvidia.com, vladbu@nvidia.com,
        cmi@nvidia.com, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-rdma@vger.kernel.org, nicolas.dichtel@6wind.com,
        eyal.birger@gmail.com, jesse@nicira.com, linville@tuxdriver.com,
        daniel@iogearbox.net, hadarh@mellanox.com, ogerlitz@mellanox.com,
        willemb@google.com, martin.varghese@nokia.com
Subject: Re: [PATCH v2 net 1/4] geneve: do not use RT_TOS for IPv6 flowlabel
Message-ID: <20220803112354.GA29408@pc-4.home>
References: <20220802120935.1363001-1-matthias.may@westermo.com>
 <20220802120935.1363001-2-matthias.may@westermo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802120935.1363001-2-matthias.may@westermo.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 02, 2022 at 02:09:32PM +0200, Matthias May wrote:
> According to Guillaume Nault RT_TOS should never be used for IPv6.

While I obviously agree with this statement, I don't think it brings
much information to other people reading the commit message. Even
though the cover letter has more information, it won't be immediately
available to people reading the patch. Also the cover letter will be
lost if the patch gets picked up for the -stable trees.

Appart from that, I'm fine with the patch of course.

> Fixes: 3a56f86f1be6a ("geneve: handle ipv6 priority like ipv4 tos")
> Signed-off-by: Matthias May <matthias.may@westermo.com>
> ---
> v1 -> v2:
>  - Fix spacing of "Fixes" tag.
>  - Add missing CCs
> ---
>  drivers/net/geneve.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> index 4c380c06f178..e1a4480e6f17 100644
> --- a/drivers/net/geneve.c
> +++ b/drivers/net/geneve.c
> @@ -877,8 +877,7 @@ static struct dst_entry *geneve_get_v6_dst(struct sk_buff *skb,
>  		use_cache = false;
>  	}
>  
> -	fl6->flowlabel = ip6_make_flowinfo(RT_TOS(prio),
> -					   info->key.label);
> +	fl6->flowlabel = ip6_make_flowinfo(prio, info->key.label);
>  	dst_cache = (struct dst_cache *)&info->dst_cache;
>  	if (use_cache) {
>  		dst = dst_cache_get_ip6(dst_cache, &fl6->saddr);
> -- 
> 2.35.1
> 

