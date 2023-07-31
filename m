Return-Path: <bpf+bounces-6426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AD67692C7
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 12:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B1192812DC
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 10:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC2E17FE3;
	Mon, 31 Jul 2023 10:10:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A30017744
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 10:10:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730B6E3
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 03:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690798221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5xKuqYOqmlVZDJvMolVVhkUwvpv3MXvZb5ujWB1Ho20=;
	b=VnxOu1GCUy4IDpVPIEByr8C2wLfA9NvKuTh5fyaIkbLfkE7l5+N6NvV7UoBJZ4NDIaXouO
	kbwtnVb88NsbpB++qQQhc+KuLcb20FtMFvXYlCCNYItF4HX35o9fYd5RZhIhQ5AhHw/uI2
	K9Xr8d3+V/9tPcoLL8bm7QVzbxmtb5c=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-jbKCUeW-PN6_Vt3KLbB_-w-1; Mon, 31 Jul 2023 06:09:50 -0400
X-MC-Unique: jbKCUeW-PN6_Vt3KLbB_-w-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a34a0b75eso298043566b.1
        for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 03:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690798188; x=1691402988;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5xKuqYOqmlVZDJvMolVVhkUwvpv3MXvZb5ujWB1Ho20=;
        b=KpSss+NB+Q4vKeIGjz/F4APQY6VUrSKY+75ZbH+tzaiNnZ4noC1t+/Bqptv7E42NDj
         +7GcFT0ix3BJtzwQ76M9uXEJeidU1broASeLFwfnz3rNtOmm9asxxr2br/6xaBOJy0XC
         2VWXgT6eIeo//W3sftEnurUFqpc7Fn6rUDA4aCiUIAeBV2Dl0pkI+NWjsvUyAs+i6mAT
         vTubzQeduOPtHYe1a+7fpn13FhRPJChJQp1ai7DdnazBEW9psRr7SwwMna0cVXXCXcNR
         zpmsMIaB/ygQNUqecIh2eKQHG+CGughnYOsA8tdD5KyEVssH5djYzq/ZoN0qeD5SW1NS
         b4lA==
X-Gm-Message-State: ABy/qLblyIl1jD1lC6PCr6kBD6DdLYiTRoqIK7AJay4UMueJDWjd1W2/
	dGfi2WVWrTI9t7i1Xg74u4Hz3EXJ6DAw/Kry1vxjC17LIkg5GSu9SwL+sNplMpSuv92WGJvL7yr
	vxLK6MNBwekmI
X-Received: by 2002:a17:907:a072:b0:99b:efc8:51d with SMTP id ia18-20020a170907a07200b0099befc8051dmr5478321ejc.21.1690798188396;
        Mon, 31 Jul 2023 03:09:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFwwLkrWqLwBDKAZavwRn+ex00l9mHmODZ3T+ZMCcOof8Bri8pSKq+DYoIIVJlmKt3NEvOJuA==
X-Received: by 2002:a17:907:a072:b0:99b:efc8:51d with SMTP id ia18-20020a170907a07200b0099befc8051dmr5478291ejc.21.1690798187986;
        Mon, 31 Jul 2023 03:09:47 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id pw3-20020a17090720a300b00987e2f84768sm5899913ejb.0.2023.07.31.03.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 03:09:47 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <6e55ab8c-0b84-4de7-0f92-c8789732dbdb@redhat.com>
Date: Mon, 31 Jul 2023 12:09:45 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: brouer@redhat.com, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Pu Lehui <pulehui@huawei.com>, houtao1@huawei.com
Subject: Re: [PATCH bpf 2/2] bpf, cpumap: Handle skb as well when clean up
 ptr_ring
Content-Language: en-US
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
References: <20230729095107.1722450-1-houtao@huaweicloud.com>
 <20230729095107.1722450-3-houtao@huaweicloud.com>
In-Reply-To: <20230729095107.1722450-3-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 29/07/2023 11.51, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> The following warning was reported when running xdp_redirect_cpu with
> both skb-mode and stress-mode enabled:
> 
>    ------------[ cut here ]------------
>    Incorrect XDP memory type (-2128176192) usage

I'm happy to see that WARN "Incorrect XDP memory type" caught this.

>    WARNING: CPU: 7 PID: 1442 at net/core/xdp.c:405
>    Modules linked in:
>    CPU: 7 PID: 1442 Comm: kworker/7:0 Tainted: G  6.5.0-rc2+ #1
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>    Workqueue: events __cpu_map_entry_free
>    RIP: 0010:__xdp_return+0x1e4/0x4a0
>    ......
>    Call Trace:
>     <TASK>
>     ? show_regs+0x65/0x70
>     ? __warn+0xa5/0x240
>     ? __xdp_return+0x1e4/0x4a0
>     ......
>     xdp_return_frame+0x4d/0x150
>     __cpu_map_entry_free+0xf9/0x230
>     process_one_work+0x6b0/0xb80
>     worker_thread+0x96/0x720
>     kthread+0x1a5/0x1f0
>     ret_from_fork+0x3a/0x70
>     ret_from_fork_asm+0x1b/0x30
>     </TASK>
> 
> The reason for the warning is twofold. One is due to the kthread
> cpu_map_kthread_run() is stopped prematurely. Another one is
> __cpu_map_ring_cleanup() doesn't handle skb mode and treats skbs in
> ptr_ring as XDP frames.
> 
> Prematurely-stopped kthread will be fixed by the preceding patch and
> ptr_ring will be empty when __cpu_map_ring_cleanup() is called. But
> as the comments in __cpu_map_ring_cleanup() said, handling and freeing
> skbs in ptr_ring as well to "catch any broken behaviour gracefully".
> 
> Fixes: 11941f8a8536 ("bpf: cpumap: Implement generic cpumap")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

I think we should fix this code, even-though patch 1 have made it harder
to trigger.


>   kernel/bpf/cpumap.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 08351e0863e5..ef28c64f1eb1 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -129,11 +129,17 @@ static void __cpu_map_ring_cleanup(struct ptr_ring *ring)
>   	 * invoked cpu_map_kthread_stop(). Catch any broken behaviour
>   	 * gracefully and warn once.
>   	 */
> -	struct xdp_frame *xdpf;
> +	void *ptr;
>   
> -	while ((xdpf = ptr_ring_consume(ring)))
> -		if (WARN_ON_ONCE(xdpf))
> -			xdp_return_frame(xdpf);
> +	while ((ptr = ptr_ring_consume(ring))) {
> +		WARN_ON_ONCE(1);
> +		if (unlikely(__ptr_test_bit(0, &ptr))) {
> +			__ptr_clear_bit(0, &ptr);
> +			kfree_skb(ptr);
> +			continue;
> +		}
> +		xdp_return_frame(ptr);
> +	}
>   }
>   
>   static void put_cpu_map_entry(struct bpf_cpu_map_entry *rcpu)


