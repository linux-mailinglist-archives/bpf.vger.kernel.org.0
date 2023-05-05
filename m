Return-Path: <bpf+bounces-79-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DC66F7B6C
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 05:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63F55280F75
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 03:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DCB1C05;
	Fri,  5 May 2023 03:20:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E321859
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 03:20:46 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5AA11DAB
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 20:20:44 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b5ce4f069so1431260b3a.1
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 20:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683256843; x=1685848843;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uab202Dnn1eDz/nkCMc9/SGSJeF/RNG3IPLG0FHPpw8=;
        b=YCMjZUIiDAdnuEBEXUnQSQDHdx4wWbeCnwCDg8iLh9HUR7ntN9nch50UknFKVbzOiD
         kckoNO9AJgAY4kVvTE2rcpTBWfZK1Z2/dXW7GSprkY/xxEpGaAyioyoHsGKG4nCrtgqg
         8YPZRvyrNlh9KKKjazPvJEeRxzF2J2S9WLH02PRzpltcDm+i0zE6u5f6PRZFep09No5a
         L45aZEHjZM7iDzi+EY+aHX/vzTYIv5gQrM8OjMCRiErzop2frYe1QpFdFzSXD/7mPdYP
         g1Cqwh+dfaYBl6sJHM30I0mdv2qAYE1p30VqXOEhj04fFQyIar5pYexfGu8qLZi579vL
         MiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683256843; x=1685848843;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uab202Dnn1eDz/nkCMc9/SGSJeF/RNG3IPLG0FHPpw8=;
        b=kvpi1/hKn5FeX5pqJQWPJPdPO587jwS5LItM9yvMzjjsjoozl+c2vkT1utkgP7JJte
         W6pEegGJ5nFEoK2XzYWi5wFWjb8EFwtfOvv/x+bm99ZVI9xWMG7nI/EOIf3xJLcyf5fJ
         ZCjNQu4LLXmx4XSATUEAHet9o0Y3pHZCn7VP1hn46PpLr7vzloAQQhJhwogwhHjZbWAE
         rTTiBrfGEYNmjSNfwcIQJVnuScYWjP2EOwAm9Elx5xI+0z9EwtdhNgKQfiQww1GTtJxq
         BPpfHXp4QMThz1PIwgMMJ7U1ZC43xlEp5ALpu5gyPNwnAl0BxyDCw+p8EZSKBQV7fA4K
         TVAQ==
X-Gm-Message-State: AC+VfDwo+VheC337i/FHNHx7beJ5wNQTK2ESRtT2FcjC+Uh7b4rWu/RY
	CuV5QjsQkZfTfUu6mF6+vSQH+Q==
X-Google-Smtp-Source: ACHHUZ53rIrj3+Txx+pQYi8n4x9Lolh+e+lbTw2OhE8kPCx9X7XF68GeoKW0zb+xh+zhbNBkTcXgKg==
X-Received: by 2002:a05:6a00:1346:b0:63b:4313:f8b5 with SMTP id k6-20020a056a00134600b0063b4313f8b5mr401131pfu.23.1683256842747;
        Thu, 04 May 2023 20:20:42 -0700 (PDT)
Received: from [10.71.57.173] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id r16-20020a62e410000000b006258dd63a3fsm465264pfh.56.2023.05.04.20.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 20:20:42 -0700 (PDT)
Message-ID: <1fd91fcf-f5b8-48af-f4d3-dfaf3a4f7c86@bytedance.com>
Date: Fri, 5 May 2023 11:20:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: Re: [PATCH bpf-next v5 1/2] bpf: Add bpf_task_under_cgroup()
 kfunc
To: Yonghong Song <yhs@meta.com>, martin.lau@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com,
 shuah@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20230504031513.13749-1-zhoufeng.zf@bytedance.com>
 <20230504031513.13749-2-zhoufeng.zf@bytedance.com>
 <72f73a40-d793-11dd-af34-f1491312d3b5@meta.com>
From: Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <72f73a40-d793-11dd-af34-f1491312d3b5@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

在 2023/5/4 22:29, Yonghong Song 写道:
> 
> 
> On 5/3/23 8:15 PM, Feng zhou wrote:
>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>
>> Add a kfunc that's similar to the bpf_current_task_under_cgroup.
>> The difference is that it is a designated task.
>>
>> When hook sched related functions, sometimes it is necessary to
>> specify a task instead of the current task.
>>
>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
> 
> You can carry my Ack from previous revision since there
> is no change to the patch.
> 
> Acked-by: Yonghong Song <yhs@fb.com>

Will do

