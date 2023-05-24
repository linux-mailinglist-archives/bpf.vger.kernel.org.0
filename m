Return-Path: <bpf+bounces-1171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE5370FA18
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 17:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15AE5281432
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 15:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF16D1992A;
	Wed, 24 May 2023 15:28:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF8818AE4
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 15:28:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DFBF5
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 08:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684942107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k9RNoBk3t8o3+Yw6yCwCINniWi+wBoMO5uu67chzOIU=;
	b=LAY4lQp16EWsYFyfBPqC1IrgslctGxTDizZMOYeWGBQmTMCiNw9f0GiUSsdH/kEHU3tCpu
	eoTRIWdg9koqhaGe2X8TLBMfTyrJzSCPHQcaSy+RRPKo4BtZB9bVAXohoxtBxYE/kitIQv
	47AkCxESyI0oS5tk2DiZR+hNIKIY+00=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-b3rnNoCSOq60YWDgfgyIPg-1; Wed, 24 May 2023 11:28:26 -0400
X-MC-Unique: b3rnNoCSOq60YWDgfgyIPg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9715654ab36so108796866b.0
        for <bpf@vger.kernel.org>; Wed, 24 May 2023 08:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684942105; x=1687534105;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k9RNoBk3t8o3+Yw6yCwCINniWi+wBoMO5uu67chzOIU=;
        b=DZsfdNooufm4iXaCmhQDxp5FU2vg5EOcK31JWx+QIE0vKadx0g4aVdpdOR0sg+DLqs
         KRxXmLxlg2i8Ed0t/rU7EUBnPYtY1yfrykyrcFL894XZrj4pq/Os39PS/m3zL95wxTSp
         lIybt0iN8EX/KINsxtpPCI8541WL1Xnl+yJ+kZY5hzn8A9pYHR8d2hoN7FLS8kWTTgMN
         qDRm4rp1NX5VqKbl9ul+dy7Bv1HA9ywq/hf75ZohQyf0K7a+8rbd0kzj/L5eswjNLjTS
         DDCokw/lXaD5w+Wo1OO9eT2kFjt4GusLrNK8qtHHLUOUeoXg1j52+iam+oUa9PpYwLvh
         /SWQ==
X-Gm-Message-State: AC+VfDzAzWWT5MspsTo067l6hv7xsWY2zhS81Vg1DtWxXGnNJwBrhhUj
	GmVQRAo+8Nccu9zBAX+jboXamjz5iMTLl+ACD0Zik64GEZWLeV1gqLE3o9bQgfOFqvGzZKckNvi
	FuC7kJ/Z2k850
X-Received: by 2002:a17:907:982:b0:968:db2f:383 with SMTP id bf2-20020a170907098200b00968db2f0383mr15927182ejc.53.1684942104934;
        Wed, 24 May 2023 08:28:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ucDsQoxS+88Mvs7p/IRLDBIinlT5jZr87tqMbyk5XEFCJ6qFoTeKSYyAyHaGDxMuV18aHWQ==
X-Received: by 2002:a17:907:982:b0:968:db2f:383 with SMTP id bf2-20020a170907098200b00968db2f0383mr15927153ejc.53.1684942104635;
        Wed, 24 May 2023 08:28:24 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id p18-20020a1709060e9200b00965ac8f8a3dsm5839944ejf.173.2023.05.24.08.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 08:28:24 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <6fef5ce8-c414-f182-f607-8ce199519dff@redhat.com>
Date: Wed, 24 May 2023 17:28:22 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, "maxtram95@gmail.com" <maxtram95@gmail.com>,
 "lorenzo@kernel.org" <lorenzo@kernel.org>,
 "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>,
 "kheib@redhat.com" <kheib@redhat.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "mkabat@redhat.com" <mkabat@redhat.com>, "atzin@redhat.com"
 <atzin@redhat.com>, "fmaurer@redhat.com" <fmaurer@redhat.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "jbenc@redhat.com" <jbenc@redhat.com>
Subject: Re: mlx5 XDP redirect leaking memory on kernel 6.3
Content-Language: en-US
To: Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 "ttoukan.linux@gmail.com" <ttoukan.linux@gmail.com>,
 "jbrouer@redhat.com" <jbrouer@redhat.com>, Saeed Mahameed
 <saeedm@nvidia.com>, "saeed@kernel.org" <saeed@kernel.org>,
 "linyunsheng@huawei.com" <linyunsheng@huawei.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <d862a131-5e31-bd26-84f7-fd8764ca9d48@redhat.com>
 <00ca7beb7fe054a3ba1a36c61c1e3b1314369f11.camel@nvidia.com>
In-Reply-To: <00ca7beb7fe054a3ba1a36c61c1e3b1314369f11.camel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 23/05/2023 18.35, Dragos Tatulea wrote:
> 
> On Tue, 2023-05-23 at 17:55 +0200, Jesper Dangaard Brouer wrote:
>>
>> When the mlx5 driver runs an XDP program doing XDP_REDIRECT, then memory
>> is getting leaked. Other XDP actions, like XDP_DROP, XDP_PASS and XDP_TX
>> works correctly. I tested both redirecting back out same mlx5 device and
>> cpumap redirect (with XDP_PASS), which both cause leaking.
>>
>> After removing the XDP prog, which also cause the page_pool to be
>> released by mlx5, then the leaks are visible via the page_pool periodic
>> inflight reports. I have this bpftrace[1] tool that I also use to detect
>> the problem faster (not waiting 60 sec for a report).
>>
>>    [1]
>> https://github.com/xdp-project/xdp-project/blob/master/areas/mem/bpftrace/page_pool_track_shutdown01.bt
>>
>> I've been debugging and reading through the code for a couple of days,
>> but I've not found the root-cause, yet. I would appreciate new ideas
>> where to look and fresh eyes on the issue.
>>
>>
>> To Lin, it looks like mlx5 uses PP_FLAG_PAGE_FRAG, and my current
>> suspicion is that mlx5 driver doesn't fully release the bias count (hint
>> see MLX5E_PAGECNT_BIAS_MAX).
>>
> 
> Thanks for the report Jesper. Incidentally I've just picked up this issue today
> as well.
> 
> On XDP redirect and tx, the page is set to skip the bias counter release with
> the expectation that page_pool_put_defragged_page will be called from [1]. But,
> as I found out now, during XDP redirect only one fragment of the page is
> released in xdp core [2]. This is where the leak is coming from.
> 

Ohh, I guess I see the problem now. (As Lin also says indirectly) the
page_pool_put_defragged_page() call is not allowed or not intended to be
invoked directly.

In [1] the driver actually free a PP page that have been fragmented (via
page_pool_fragment_page), but not "defragged" yet.  Meaning
page->pp_frag_count will still be 64 (MLX5E_PAGECNT_BIAS_MAX).

I though about catching this invalid API usage in page_pool, but due to
an (atomic_read) optimization (in page_pool_defrag_page), we cannot
detect this reliably.

> We'll provide a fix soon.
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c#n665
> 
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/net/core/xdp.c#n390


