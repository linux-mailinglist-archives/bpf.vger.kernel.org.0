Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7B45A139E
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 16:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240358AbiHYObD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 10:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240078AbiHYObC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 10:31:02 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B8A7436E
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 07:31:01 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h24so24872327wrb.8
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 07:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc;
        bh=gnO2VDQRkpniG8hbnSb1r6bb7bLo2I3U2rugVNR/3I0=;
        b=CEgYqMjnHOUy4S9Z4CupSysPJHsYe/4S+5K107qdf41Ak38ThN+PDcIWrl2mKFyU9F
         uwi0O0jt25RymlVlHYzq43tne6qee7UHfbNqo3f6uSG8vYV4aQmwibqH6wk2w3A0+liF
         /fEIsjf3lUDsBpMrN20TyiV4YigrkObELRjs5sHWzKi+7ZE7gC9kB2DVrjZQF6/OW8B9
         BRJYz3IOfFsSMcd/4260EJhzV0Vv9hHOVhigqwOA0fTGb2zE+ScvC5bK19NUqQJV8+AG
         /P/G+jB7kGPa4gE2eQ9s8lNMmKypZ60QKkPnbt83FhB0uDk7XZuVVj/PxiyoQCqDAA2y
         FASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc;
        bh=gnO2VDQRkpniG8hbnSb1r6bb7bLo2I3U2rugVNR/3I0=;
        b=iNfrj0mwK6oQKKyDR2X4KnD+KMcN1iO/at2iwzznWSyDCvX0x0+RUgQC9DpgumiKrE
         xUhdbtUQJdh2jHN/m5iEs3w+K7b/eta4OAP7gPTtOmjoeq5VWMc9aMwerGdi2K7Tl+lU
         aV1oPtu/lOP9XvM9YD0qgo6PdBz9RcRpzdGgE2O+brInRXBF20NQKvkljSEsSpt4osNu
         gK3iBSND4hXs5yFxyk0biUxKWWtW+jCpHVOvB2XRttAykXePHwum3ISnF/iC9jQzDZVC
         7m6qrUgQXkBD37kT7Cjw8vCz1KozMIoZCbIfgcjBUjqez15QZXficJi/PiwI2nqgkHsx
         Lkcg==
X-Gm-Message-State: ACgBeo0lGRB/h95Y9iDM+3Y6jzq7XVe1kcWgvTOwx87hvZhyKsh7Rc6S
        GtFx1zqKzbIs4O2wIhDwO4Dz7y9lQAiKrg==
X-Google-Smtp-Source: AA6agR7WzDM0PHIshkJnsB9WPLjp0zOrq7QmZyWfVUuW+MwH1w42u6vQUtDaFzxvi8Qb9sHbQ1AnwA==
X-Received: by 2002:a5d:4204:0:b0:225:382f:a8be with SMTP id n4-20020a5d4204000000b00225382fa8bemr2610700wrq.379.1661437859612;
        Thu, 25 Aug 2022 07:30:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:e5a8:418:4b2a:1186? ([2a01:e0a:b41:c160:e5a8:418:4b2a:1186])
        by smtp.gmail.com with ESMTPSA id m6-20020a056000008600b0021d6dad334bsm20029151wrx.4.2022.08.25.07.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 07:30:59 -0700 (PDT)
Message-ID: <14509424-f34f-3bff-6236-cf0f1b81fa26@6wind.com>
Date:   Thu, 25 Aug 2022 16:30:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH ipsec-next,v2 3/3] xfrm: lwtunnel: add lwtunnel support
 for xfrm interfaces in collect_md mode
Content-Language: en-US
To:     Eyal Birger <eyal.birger@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        dsahern@kernel.org, contact@proelbtn.com, pablo@netfilter.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20220825134636.2101222-1-eyal.birger@gmail.com>
 <20220825134636.2101222-4-eyal.birger@gmail.com>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20220825134636.2101222-4-eyal.birger@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Le 25/08/2022 à 15:46, Eyal Birger a écrit :
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
> ip route add <SUBNET> dev ipsec1 encap xfrm if_id 1 dev eth15
> 
> Signed-off-by: Eyal Birger <eyal.birger@gmail.com>

[snip]

> +static int xfrmi_build_state(struct net *net, struct nlattr *nla,
> +			     unsigned int family, const void *cfg,
> +			     struct lwtunnel_state **ts,
> +			     struct netlink_ext_ack *extack)
> +{
> +	struct nlattr *tb[LWT_XFRM_MAX + 1];
> +	struct lwtunnel_state *new_state;
> +	struct xfrm_md_info *info;
> +	int ret;
> +
> +	ret = nla_parse_nested(tb, LWT_XFRM_MAX, nla, xfrm_lwt_policy, extack);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!tb[LWT_XFRM_IF_ID])
> +		return -EINVAL;
It would be nice  to add extack error message for all error cases, particularly
for EINVAL ;-)

> +
> +	new_state = lwtunnel_state_alloc(sizeof(*info));
> +	if (!new_state)
> +		return -ENOMEM;
> +
> +	new_state->type = LWTUNNEL_ENCAP_XFRM;
> +
> +	info = lwt_xfrm_info(new_state);
> +
> +	info->if_id = nla_get_u32(tb[LWT_XFRM_IF_ID]);
> +	if (!info->if_id) {
> +		ret = -EINVAL;
> +		goto errout;
> +	}
> +
> +	if (tb[LWT_XFRM_LINK]) {
> +		info->link = nla_get_u32(tb[LWT_XFRM_LINK]);
> +		if (!info->link) {
> +			ret = -EINVAL;
> +			goto errout;
> +		}
> +	}
> +
> +	*ts = new_state;
> +	return 0;
> +
> +errout:
> +	xfrmi_destroy_state(new_state);
> +	kfree(new_state);
> +	return ret;
> +}
