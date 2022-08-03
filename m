Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76784588B3C
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 13:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbiHCLaz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 07:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236412AbiHCLav (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 07:30:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FE4D2BB3C
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 04:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659526249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ACliQ9oJqgCoHX8Ef7C87bGSwzNCX201dby99j7oUC8=;
        b=P1pXfb0p8rGSq/Zm/1FllzqVcQkOMkXuv/JBIxh4577DovpaC80Dw3FKLrAEsnI+B3SBPt
        GJd3AeYQo5n++gZwiRiXRGNmYR1Pk0hqjwR85HnPQA8BDUp/ABH6ZMEp1v90N9KMOlp1yx
        Wqy2Qb19xlwuAoS8Azm3sFurQ4gMMFk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-CIleEItkODS9clxPga6u7g-1; Wed, 03 Aug 2022 07:30:48 -0400
X-MC-Unique: CIleEItkODS9clxPga6u7g-1
Received: by mail-qv1-f69.google.com with SMTP id cz12-20020a056214088c00b004763e7e7d81so5858342qvb.21
        for <bpf@vger.kernel.org>; Wed, 03 Aug 2022 04:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ACliQ9oJqgCoHX8Ef7C87bGSwzNCX201dby99j7oUC8=;
        b=eDuW0D0WRHGe24bJPpCCRhq7lUGzentRGj8dTOqQdSivOLkM3H8OzPsWouC+DDGlQa
         ETW1R2dpu1OB7abcZrR7bJ1YUCdAGETAmj0HLWnblAOpGAYsihFJNC6Iqj2PFGIhNgko
         NVBSNS/vdsipKCKIw/NSQXeEHJAqL5NO0dqGqMv8GOEB+lyBVh+Tt0K/BAMOSXAod2qE
         1Eo5LZ9rBoZF/G0gBYfTNEIAfcobBJ6KZESyofipxRUIRt9JzOjesKHjMYzD89Wz1qX5
         oxrUk6CYqhl2Zg+gJFZ8+kvHodJam413zIqNk4TnGAzEPPNdFw39jezvEzRhCUGSVXOL
         gk1A==
X-Gm-Message-State: AJIora+0c+nGYsuaC3ptnxXKBMmmI1AIojNfJezcRO0GRWPXoz7FAWiz
        bSp2Mknbs9JBP7+jYvnQcF1r6ngOpOnVHyWCREYnXQKV6IGTx6LR9MuOPwflwylO2hiEsrYyV/5
        SJAd/9RqwKbj2
X-Received: by 2002:ac8:59d5:0:b0:31f:dde:fca8 with SMTP id f21-20020ac859d5000000b0031f0ddefca8mr22345838qtf.86.1659526247494;
        Wed, 03 Aug 2022 04:30:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sN0PZbJQ7Njk6l2cfsYiD8YZMh9JnksyXTAlgE0zWDCVaHwC+6GHlYXN2nC/9NqFsBWxtlVQ==
X-Received: by 2002:ac8:59d5:0:b0:31f:dde:fca8 with SMTP id f21-20020ac859d5000000b0031f0ddefca8mr22345807qtf.86.1659526247297;
        Wed, 03 Aug 2022 04:30:47 -0700 (PDT)
Received: from pc-4.home (2a01cb058918ce00dd1a5a4f9908f2d5.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dd1a:5a4f:9908:f2d5])
        by smtp.gmail.com with ESMTPSA id n15-20020a05620a294f00b006b5cc25535fsm12275757qkp.99.2022.08.03.04.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 04:30:46 -0700 (PDT)
Date:   Wed, 3 Aug 2022 13:30:41 +0200
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
Message-ID: <20220803113041.GC29408@pc-4.home>
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
> 
> Fixes: 3a56f86f1be6a ("geneve: handle ipv6 priority like ipv4 tos")

While I'm at it, the SHA1 is normally truncated to 12 charaters, not 13.

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

