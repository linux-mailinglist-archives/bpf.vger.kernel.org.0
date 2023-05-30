Return-Path: <bpf+bounces-1433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64629715D4B
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 13:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F00F1C20BC3
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 11:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E1517FE9;
	Tue, 30 May 2023 11:33:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF82617FE5
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 11:33:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3559CE5
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 04:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685446393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nANOkXa+OCTUTsJxfDHR3XEF/SAtknXTe7GgZIejRNA=;
	b=CfiOKrsji0NSkf7VSgxHK5AGkMZh27lBj4OC/+PEPXr4eCxYf14r4OdJwUu0ZL9EZq/1k/
	g8e7PyOV2KV8Kbvi3lph9T36SPtSc2RV/ZLkqPN3XcDI3O9nLpaZMinhrIu+sjexJoJP+w
	W2A/RbUK+hTSdz6GXgNsFh1lteuK2Hw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-ffPAB04IOXyo7rbq0c5AnA-1; Tue, 30 May 2023 07:33:12 -0400
X-MC-Unique: ffPAB04IOXyo7rbq0c5AnA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-96fe843f61eso472663566b.2
        for <bpf@vger.kernel.org>; Tue, 30 May 2023 04:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685446391; x=1688038391;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:cc:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nANOkXa+OCTUTsJxfDHR3XEF/SAtknXTe7GgZIejRNA=;
        b=if0WuIg0m5lu2yt1G1fkgyFH8ZZ/D3RpXVKXem5jHxzsyuQwDz+N3d7FBugXbHiIBY
         WYHOo2MI4KKms66q4KczFg1cbi+toiXhxzqGOl2OD1GttCud+c2ISkhii/2So0dfy/Ui
         rMIgXsHEepLwfyKW1Q1p3d3YLe2VXAl1zfuLMA6x7bhDnshs/BtTdDBdVssbpFF1PoI3
         tPjOCALiiW0kXZv2902xUBTIy1PBurUYyQ/VcK4CWZ/GvDR63JWZsAMFWC+LdMtt1qFb
         Tc6iPEF0FrjdVWSr2eYzW/h+mlB0VNuWp0P7qtbgZh+n7BK7NP2Oj2YpVH6+0pyEN+lt
         R1ig==
X-Gm-Message-State: AC+VfDxlJkCzjhvRRDjs3WdDcIXl47A5xsm9jSf+b12OYI5ZYm/mcw9C
	fb4BIF6On6aiEPz1YwB+TEgudSvSoW6dAz0KNodZWxyUkdIKnAmNvofoZHbYC5y6bGqCb2Z3BA3
	I6daTwYxikLS3W9Qgux3Y
X-Received: by 2002:a17:907:86ab:b0:966:37b2:7354 with SMTP id qa43-20020a17090786ab00b0096637b27354mr1605360ejc.31.1685446390785;
        Tue, 30 May 2023 04:33:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4HaSdXGMfiBX8zlU+aXFwjPlw4qBtwkE7cV0evoReu1MLYdKqL0rwaoF5AKwPZdXsvn5k/1Q==
X-Received: by 2002:a17:907:86ab:b0:966:37b2:7354 with SMTP id qa43-20020a17090786ab00b0096637b27354mr1605340ejc.31.1685446390433;
        Tue, 30 May 2023 04:33:10 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id j15-20020a1709062a0f00b0096f8c4b1911sm7292483eje.130.2023.05.30.04.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 04:33:09 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <63d91da7-4040-a766-dcd7-bccbb4c02ef4@redhat.com>
Date: Tue, 30 May 2023 13:33:08 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Nimrod Oren <noren@nvidia.com>
Subject: Re: [PATCH bpf-next 1/2] samples/bpf: fixup xdp_redirect tool to be
 able to support xdp multibuffer
To: Tariq Toukan <tariqt@nvidia.com>, Alexei Starovoitov <ast@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>
References: <20230529110608.597534-1-tariqt@nvidia.com>
 <20230529110608.597534-2-tariqt@nvidia.com>
Content-Language: en-US
In-Reply-To: <20230529110608.597534-2-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 29/05/2023 13.06, Tariq Toukan wrote:
> Expand the xdp multi-buffer support to xdp_redirect tool.
> Similar to what's done in commit
> 772251742262 ("samples/bpf: fixup some tools to be able to support xdp multibuffer")
> and its fix commit
> 7a698edf954c ("samples/bpf: Fix MAC address swapping in xdp2_kern").
> 

Have you tested if this cause a performance degradation?

(Also found possible bug below)

> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Nimrod Oren <noren@nvidia.com>
> ---
>   samples/bpf/xdp_redirect.bpf.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/samples/bpf/xdp_redirect.bpf.c b/samples/bpf/xdp_redirect.bpf.c
> index 7c02bacfe96b..620163eb7e19 100644
> --- a/samples/bpf/xdp_redirect.bpf.c
> +++ b/samples/bpf/xdp_redirect.bpf.c
> @@ -16,16 +16,21 @@
>   
>   const volatile int ifindex_out;
>   
> -SEC("xdp")
> +#define XDPBUFSIZE	64

Pktgen sample scripts will default send with 60 pkt length, because the
4 bytes FCS (end-frame checksum) is added by hardware.

Will this result in an error when bpf_xdp_load_bytes() tries to copy 64
bytes from a 60 bytes packet?

> +SEC("xdp.frags")
>   int xdp_redirect_prog(struct xdp_md *ctx)
>   {
> -	void *data_end = (void *)(long)ctx->data_end;
> -	void *data = (void *)(long)ctx->data;
> +	__u8 pkt[XDPBUFSIZE] = {};
> +	void *data_end = &pkt[XDPBUFSIZE-1];
> +	void *data = pkt;
>   	u32 key = bpf_get_smp_processor_id();
>   	struct ethhdr *eth = data;
>   	struct datarec *rec;
>   	u64 nh_off;
>   
> +	if (bpf_xdp_load_bytes(ctx, 0, pkt, sizeof(pkt)))
> +		return XDP_DROP;

E.g. sizeof(pkt) = 64 bytes here.

> +
>   	nh_off = sizeof(*eth);
>   	if (data + nh_off > data_end)
>   		return XDP_DROP;
> @@ -36,11 +41,14 @@ int xdp_redirect_prog(struct xdp_md *ctx)
>   	NO_TEAR_INC(rec->processed);
>   
>   	swap_src_dst_mac(data);
> +	if (bpf_xdp_store_bytes(ctx, 0, pkt, sizeof(pkt)))
> +		return XDP_DROP;
> +
>   	return bpf_redirect(ifindex_out, 0);
>   }
>   
>   /* Redirect require an XDP bpf_prog loaded on the TX device */
> -SEC("xdp")
> +SEC("xdp.frags")
>   int xdp_redirect_dummy_prog(struct xdp_md *ctx)
>   {
>   	return XDP_PASS;


