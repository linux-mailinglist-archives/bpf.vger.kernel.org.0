Return-Path: <bpf+bounces-5711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FE375F4F1
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 13:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357471C20B06
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 11:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B4C613C;
	Mon, 24 Jul 2023 11:29:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921E86127
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 11:29:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC47E74
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 04:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690198173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=InhFGz8uanSIgs0+fFMJq8jlwPkDmfV0e8PrU3sGEZo=;
	b=YIcUmZ55Z61qTEeBWmy+PO7NKoDb4nM+nNrhVQNQVhAsySR1hnJb4BfG7qbc/O+iNeluic
	AreOjCkpc7U5KT+MAw5jmApL9eGjJioIG/Xt4JyWJIpshKqS/V8ZLHFyL/LCb4dZpdqupT
	JOD+oimvn29uuIph4iRgMFfN/AUSbrs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-hbeW_ifHNai70uc9GGtXsw-1; Mon, 24 Jul 2023 07:29:32 -0400
X-MC-Unique: hbeW_ifHNai70uc9GGtXsw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fb76659d44so3586845e87.3
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 04:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690198171; x=1690802971;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=InhFGz8uanSIgs0+fFMJq8jlwPkDmfV0e8PrU3sGEZo=;
        b=IMIixLrtPCpcrIo5y/O7boqPCAgdI6cVbYG4mCn8GFKgkN4ovTedYwA7kOuD2K/mFU
         Z57aWASKaRpDq77KNNuNQfoRWun8JBUHnMcaQErVxtRd4GG+0bPjO6Usn02AkPBpMLsq
         GqMC1b/lEYORY6JM4+CwjsiIknlKg4n2bAOhwA+LCFCjvQ1cc/vKis44YvmstII0zH+Q
         vElgpzcvAGAR6UUFRmPsi0+v8tbXRocZaGbxxa0dYu/qGjbhWXUSxj68CY1yE2/dtbVg
         FkxmH8Sng8u5RKEIhuMXF/ylVyUmns4UN6SdnahU2n33aaFhJU5nWdQiaLYn9OG5bl3N
         0xPw==
X-Gm-Message-State: ABy/qLYCFmqyNzcVoVZpJvXOiHhccTzDPo0I/LGTbXByu/5O9V8I+9aB
	e/pdKfoghp0lz52SnMoyKzRlJtTtwQ3diSSMQyxnSLJZ+IAAHWUIBTiJs/1DKH9ED38zErhX7yW
	8RvetLpJqY20E
X-Received: by 2002:a19:7708:0:b0:4fd:b223:92c with SMTP id s8-20020a197708000000b004fdb223092cmr4153581lfc.60.1690198171131;
        Mon, 24 Jul 2023 04:29:31 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE/Qaqvb/UsxzMDAMEYFeHx61mrNS8kds4q2OpAV6QWXAx6bahvnTOQjiZk1W78xnsBZ0NUBg==
X-Received: by 2002:a19:7708:0:b0:4fd:b223:92c with SMTP id s8-20020a197708000000b004fdb223092cmr4153562lfc.60.1690198170787;
        Mon, 24 Jul 2023 04:29:30 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id b9-20020aa7c6c9000000b0051d9ee1c9d3sm6072307eds.84.2023.07.24.04.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 04:29:30 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <1af55bbb-7aff-e575-8dc1-8ba64b924580@redhat.com>
Date: Mon, 24 Jul 2023 13:29:28 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, decui@microsoft.com, kys@microsoft.com,
 paulros@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
 davem@davemloft.net, wei.liu@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, leon@kernel.org, longli@microsoft.com,
 ssengar@linux.microsoft.com, linux-rdma@vger.kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, bpf@vger.kernel.org,
 ast@kernel.org, sharmaajay@microsoft.com, hawk@kernel.org,
 tglx@linutronix.de, shradhagupta@linux.microsoft.com,
 linux-kernel@vger.kernel.org, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Re: [PATCH V3,net-next] net: mana: Add page pool for RX buffers
Content-Language: en-US
To: Haiyang Zhang <haiyangz@microsoft.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org
References: <1689966321-17337-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1689966321-17337-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 21/07/2023 21.05, Haiyang Zhang wrote:
> Add page pool for RX buffers for faster buffer cycle and reduce CPU
> usage.
> 
> The standard page pool API is used.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
> V3:
> Update xdp mem model, pool param, alloc as suggested by Jakub Kicinski
> V2:
> Use the standard page pool API as suggested by Jesper Dangaard Brouer
> 
> ---
>   drivers/net/ethernet/microsoft/mana/mana_en.c | 91 +++++++++++++++----
>   include/net/mana/mana.h                       |  3 +
>   2 files changed, 78 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index a499e460594b..4307f25f8c7a 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
[...]
> @@ -1659,6 +1679,8 @@ static void mana_poll_rx_cq(struct mana_cq *cq)
>   
>   	if (rxq->xdp_flush)
>   		xdp_do_flush();
> +
> +	page_pool_nid_changed(rxq->page_pool, numa_mem_id());

I don't think this page_pool_nid_changed() called is needed, if you do
as I suggest below (nid = NUMA_NO_NODE).


>   }
>   
>   static int mana_cq_handler(void *context, struct gdma_queue *gdma_queue)
[...]

> @@ -2008,6 +2041,25 @@ static int mana_push_wqe(struct mana_rxq *rxq)
>   	return 0;
>   }
>   
> +static int mana_create_page_pool(struct mana_rxq *rxq)
> +{
> +	struct page_pool_params pprm = {};

You are implicitly assigning NUMA node id zero.

> +	int ret;
> +
> +	pprm.pool_size = RX_BUFFERS_PER_QUEUE;
> +	pprm.napi = &rxq->rx_cq.napi;

You likely want to assign pprm.nid to NUMA_NO_NODE

  pprm.nid = NUMA_NO_NODE;

For most drivers it is recommended to assign ``NUMA_NO_NODE`` (value -1)
as the NUMA ID to ``pp_params.nid``. When ``CONFIG_NUMA`` is enabled
this setting will automatically select the (preferred) NUMA node (via
``numa_mem_id()``) based on where NAPI RX-processing is currently
running. The effect is that page_pool will only use recycled memory when
NUMA node match running CPU. This assumes CPU refilling driver RX-ring
will also run RX-NAPI.

If a driver want more control over the NUMA node memory selection,
drivers can assign (``pp_params.nid``) something else than
`NUMA_NO_NODE`` and runtime adjust via function ``page_pool_nid_changed()``.

I will update [1] with this info.
  - Docs [1] 
https://kernel.org/doc/html/latest/networking/page_pool.html#registration


> +
> +	rxq->page_pool = page_pool_create(&pprm);
> +
> +	if (IS_ERR(rxq->page_pool)) {
> +		ret = PTR_ERR(rxq->page_pool);
> +		rxq->page_pool = NULL;
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +


