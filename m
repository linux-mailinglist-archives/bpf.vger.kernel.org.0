Return-Path: <bpf+bounces-8356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E1B785B1E
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 16:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0FDD28132A
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 14:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1F1C2E0;
	Wed, 23 Aug 2023 14:51:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F63C2D4
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 14:51:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C812E6D
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 07:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692802307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ui6+MdQPBHClMUzt17Gxb4m37Amorx/TKujWGiY52KY=;
	b=blhen4WNWI9yf9U4FAra/gvRsZZT9eTnzlIK214su0rKtdvGJp59gGFLVwcepjm5tGfz/c
	Cj0EcMf1JCByjXv+GyWu+fjq2r690QNKA6QQwwo4uu5lROCz+tiLBGBeipCWwp0EQRMknp
	VXkP/h+3admA+WNYbvKlUKuebXdCecQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-RXJh7TX3PseJsGoIR3TCdg-1; Wed, 23 Aug 2023 10:51:45 -0400
X-MC-Unique: RXJh7TX3PseJsGoIR3TCdg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f42bcef2acso36432355e9.2
        for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 07:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692802304; x=1693407104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ui6+MdQPBHClMUzt17Gxb4m37Amorx/TKujWGiY52KY=;
        b=hm9WJ/HqrUcqAluUuO1Oim9n8MHmALdBuPHtNWTEm2ytJI01LznI4rRnCQKzG89z4p
         3Bdjm8BTLexnFepa5l5NcG5zLvOGQ/ljIFpQbUicIAMB3PQ38c5ShV1D4fiRVbKkDZK4
         o3QzLJmk3JRBnGt76LK5OnDt56/WlY1dNkdiwrkrxkjj9LPiSzZAYbr1j2CIXTRbUgeB
         f1YDU9pMgSVsoEumL2R0p9ptI7WoopkVOXkCXxPsedqB7bNEv+TM2tunEHT4mA2Z42AC
         07Vo1QpTIbq+vQLMTiSTgCzlcuPek16dUH1DxGe5HllUbMmScE1HPfB7lLRcPE7diCCb
         xW1g==
X-Gm-Message-State: AOJu0YyS745weqw7+jRyyUdbuQu3r6fLA+aVl0ZE7l2l6W3hNJr2hxlC
	8HtMt1Iqw7+E1o8ksaVYJl6/8gn7JDl68InlYWxvX0mIPBcEMvHozv8SqB5481D4raIicYaRqSC
	siWWNtJTP4hEy
X-Received: by 2002:a7b:c84d:0:b0:3fe:e8b4:436f with SMTP id c13-20020a7bc84d000000b003fee8b4436fmr8627004wml.14.1692802304780;
        Wed, 23 Aug 2023 07:51:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnVRBi8PK6/x0AzFBEPxF4kWcVG572OSwM5kYFDDA4dIEo8xQwVJCkjQc8s2Db/MeOg5WnoA==
X-Received: by 2002:a7b:c84d:0:b0:3fe:e8b4:436f with SMTP id c13-20020a7bc84d000000b003fee8b4436fmr8626984wml.14.1692802304433;
        Wed, 23 Aug 2023 07:51:44 -0700 (PDT)
Received: from debian (2a01cb058d23d6007d3729c79874bf87.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:7d37:29c7:9874:bf87])
        by smtp.gmail.com with ESMTPSA id l20-20020a7bc454000000b003feee8d8011sm11525804wmi.41.2023.08.23.07.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:51:43 -0700 (PDT)
Date: Wed, 23 Aug 2023 16:51:41 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org,
	Siwar Zitouni <siwar.zitouni@6wind.com>
Subject: Re: [PATCH net v3] net: handle ARPHRD_PPP in dev_is_mac_header_xmit()
Message-ID: <ZOYc/Uhb0RSUvi47@debian>
References: <20230823134102.1848881-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823134102.1848881-1-nicolas.dichtel@6wind.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 03:41:02PM +0200, Nicolas Dichtel wrote:
> The goal is to support a bpf_redirect() from an ethernet device (ingress)
> to a ppp device (egress).
> The l2 header is added automatically by the ppp driver, thus the ethernet
> header should be removed.

Reviewed-by: Guillaume Nault <gnault@redhat.com>

> CC: stable@vger.kernel.org
> Fixes: 27b29f63058d ("bpf: add bpf_redirect() helper")
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Tested-by: Siwar Zitouni <siwar.zitouni@6wind.com>
> ---
> 
> v2 -> v3:
>  - add a comment in the code
>  - rework the commit log
> 
> v1 -> v2:
>  - I forgot the 'Tested-by' tag in the v1 :/
> 
>  include/linux/if_arp.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/if_arp.h b/include/linux/if_arp.h
> index 1ed52441972f..10a1e81434cb 100644
> --- a/include/linux/if_arp.h
> +++ b/include/linux/if_arp.h
> @@ -53,6 +53,10 @@ static inline bool dev_is_mac_header_xmit(const struct net_device *dev)
>  	case ARPHRD_NONE:
>  	case ARPHRD_RAWIP:
>  	case ARPHRD_PIMREG:
> +	/* PPP adds its l2 header automatically in ppp_start_xmit().
> +	 * This makes it look like an l3 device to __bpf_redirect() and tcf_mirred_init().
> +	 */
> +	case ARPHRD_PPP:
>  		return false;
>  	default:
>  		return true;
> -- 
> 2.39.2
> 


