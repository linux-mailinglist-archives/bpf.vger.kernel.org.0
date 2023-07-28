Return-Path: <bpf+bounces-6187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DA5766AFB
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 12:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F6328269A
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 10:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B6510960;
	Fri, 28 Jul 2023 10:48:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB41C8CA
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 10:48:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C577C1B8
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 03:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690541285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pr9ZveHG7QOtuyUbRPlw2YGb3UBxbgtuPwUC4Zy2TSc=;
	b=QwcitNovK4wZUoUw9q33SNCLXnVz4lNQYawRW1ROBD3HGOP0e/TeissNSKJk5s12tkK+TO
	aeZygNyFW+B6UbfhxlqOlbvNIwrXm02G6viuOyzf3m2keGd7agZAjW/GsKelsv82ftCJoU
	KuJc75lyPD7LLH7d/qFf5rFSkeoLxY4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-wl6WesItPQWTKPOE1OqFlg-1; Fri, 28 Jul 2023 06:48:03 -0400
X-MC-Unique: wl6WesItPQWTKPOE1OqFlg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-99bcf6ae8e1so110796066b.0
        for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 03:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690541282; x=1691146082;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pr9ZveHG7QOtuyUbRPlw2YGb3UBxbgtuPwUC4Zy2TSc=;
        b=LIGTiEEqxr9GR2VFr7IWKy3bKf+5CaJ1naFnr7KNrSvpmYWTUGABsww1kTLS9rcKba
         TJS1WB1qFCN6j80mz7l8aqr+3icHeQqUIyclMHs4CBmMthjCJbNbL+eQUuvJD/aWvzBj
         wcvoOyIoL1RSdKjQq4tda64BAqQiSdHfaaXto8zm0dmsnVUpGO+iwldyQg3OW/4ElqUc
         kUX0HKAE8iYtpmG3twmLx2hF8cXLIzlu+RzMo/TsnY7QNsy195v3onftzl3NaG4qrzLj
         zsUMUxx7UZhkMG1UmEyGupNSkQlYdueaxO6fjDBtvzsDHTTWPWgPGrNEmPkoT1Qof/Qk
         lhdg==
X-Gm-Message-State: ABy/qLbqCDaEh9tHeOt8qiyLIk1nida7Qf+QI9pXY9cuDLAsRs9+fgcD
	hOTLOXSjz/CX2BWJw5jM1wThSIyhMDHMXuasjyAO+OHuZE4HkMY/4cjHjTCL0QaKpTDx+pFK3bn
	pSgfhoq8MTgqM
X-Received: by 2002:a17:906:1089:b0:99b:cb7a:c164 with SMTP id u9-20020a170906108900b0099bcb7ac164mr1596721eju.62.1690541282731;
        Fri, 28 Jul 2023 03:48:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE6YVrwsxI2jPfqI5yPNns9lR9mTVsyFVoPPYcykgvHGU1qra0WsDFpUM0MwxwWV9vOGNvFKQ==
X-Received: by 2002:a17:906:1089:b0:99b:cb7a:c164 with SMTP id u9-20020a170906108900b0099bcb7ac164mr1596706eju.62.1690541282445;
        Fri, 28 Jul 2023 03:48:02 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090668ca00b009934b1eb577sm1928162ejr.77.2023.07.28.03.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 03:48:01 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <bc0c9d76-7184-4d61-5262-2ae9efd2a136@redhat.com>
Date: Fri, 28 Jul 2023 12:48:00 +0200
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
 Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 houtao1@huawei.com
Subject: Re: [PATCH bpf-next 1/2] bpf, cpumap: Remove unused cmap field from
 bpf_cpu_map_entry
Content-Language: en-US
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
References: <20230728014942.892272-1-houtao@huaweicloud.com>
 <20230728014942.892272-2-houtao@huaweicloud.com>
In-Reply-To: <20230728014942.892272-2-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 28/07/2023 03.49, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Since commit cdfafe98cabe ("xdp: Make cpumap flush_list common for all
> map instances"), cmap is no longer used, so just remove it.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---

LGTM

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>


>   kernel/bpf/cpumap.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 6ae02be7a48e..0a16e30b16ef 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -60,8 +60,6 @@ struct bpf_cpu_map_entry {
>   	/* XDP can run multiple RX-ring queues, need __percpu enqueue store */
>   	struct xdp_bulk_queue __percpu *bulkq;
>   
> -	struct bpf_cpu_map *cmap;
> -
>   	/* Queue with potential multi-producers, and single-consumer kthread */
>   	struct ptr_ring *queue;
>   	struct task_struct *kthread;
> @@ -588,7 +586,6 @@ static long cpu_map_update_elem(struct bpf_map *map, void *key, void *value,
>   		rcpu = __cpu_map_entry_alloc(map, &cpumap_value, key_cpu);
>   		if (!rcpu)
>   			return -ENOMEM;
> -		rcpu->cmap = cmap;
>   	}
>   	rcu_read_lock();
>   	__cpu_map_entry_replace(cmap, key_cpu, rcpu);


