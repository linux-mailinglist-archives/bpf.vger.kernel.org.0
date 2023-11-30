Return-Path: <bpf+bounces-16244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4510E7FEBCC
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 10:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75F511C20E5C
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 09:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C226738F83;
	Thu, 30 Nov 2023 09:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UUks07+c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339B88F
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 01:24:12 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6cdd4aab5f5so719004b3a.3
        for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 01:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701336251; x=1701941051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODGxd7/u71d/rY/1QUl5tXlqtMzlubsqrETh3ZFBIzc=;
        b=UUks07+cN6WPU+Lhz+jl8Ma+nNwYywdE99+qa7HjaTsNJimsVx0/8GBu1sm0fshzUY
         hPF9tRyE3bvdvhBG3AtCnFf8w99n/hGyDLYNZ+usmZcDZzOx4N1gEdkzOAe+z/bq5cyo
         LHAdlRQWuGva8NqWHaHPGUAU/YjM3ylTY3z/yMioGqGk5zFahPwLwi5T2f27XxsuOMPd
         l9VtUIGlZhX8FgnhHH78RUBFKYvAkbKYGTJ+C+sY09IohPcvOBDUQxCpfjQPFAvsxJyk
         pBD0BpQRibAkzihXWD5Pgh9meVfyhasD6Zq50mToidNbTgm3Fbo/Xnp1rhCzcfkmApUZ
         2h7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701336251; x=1701941051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ODGxd7/u71d/rY/1QUl5tXlqtMzlubsqrETh3ZFBIzc=;
        b=q6ZFpx01Rkx+HoBHLgBGIMECIeQlhtjOrUnG+lsp0x8XeCNaplvfqGdp7MnUkhUQih
         USmj+hRqRX17X0lFGt/u8cWNonQw8z1Gep2ARL1dy/34/ZwiWo+/7+1ZaxIc8R0oZzLN
         88esurV25E+RItoquDoUD1Nw9uIlhRRxfJ9QoCrZwzHTbys34guFMsy8YmVZBt5c0fRy
         8XUjBAyiwh7qgl3UbQjn5v6YViNU0Am+mio0YEOjz1KMWodaAWrOhX0Of+PUfGwZhFmU
         0oY7/hqOWTKGej6WhPXtWLklicFQO1xBtdgkawW/RvksTeHTk05MphcLlOf5KeBf/Xj8
         QwhQ==
X-Gm-Message-State: AOJu0YzjTCorGtbjWbsxa2m9rcF1whXNXm47JBCR16JJo2NSqy5Th8YD
	cDfsLx5rKzD626YXQDGbQNVAOg==
X-Google-Smtp-Source: AGHT+IGvtcp1PgtnVJr+WQ8C2U2NNcXXrpY/qCKSZGSEOFUMfOPyOa8gDqmrc3Yr78UCV+DX5EsG/Q==
X-Received: by 2002:a05:6a21:a58d:b0:18b:d99a:99bd with SMTP id gd13-20020a056a21a58d00b0018bd99a99bdmr25455213pzc.32.1701336251730;
        Thu, 30 Nov 2023 01:24:11 -0800 (PST)
Received: from [10.84.152.108] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id u8-20020a17090282c800b001cfc1b93179sm18516plz.232.2023.11.30.01.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 01:24:11 -0800 (PST)
Message-ID: <16b4d42d-2d62-460e-912f-6e3b86f3004d@bytedance.com>
Date: Thu, 30 Nov 2023 17:24:05 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH bpf-next] netkit: Add some ethtool ops to
 provide information to user
To: Nikolay Aleksandrov <razor@blackwall.org>, daniel@iogearbox.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com, tangchen.1@bytedance.com
References: <20231130075844.52932-1-zhoufeng.zf@bytedance.com>
 <51dd35c9-ff5b-5b11-04d1-9a5ae9466780@blackwall.org>
From: Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <51dd35c9-ff5b-5b11-04d1-9a5ae9466780@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2023/11/30 17:06, Nikolay Aleksandrov 写道:
> On 11/30/23 09:58, Feng zhou wrote:
>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>
>> Add get_strings, get_sset_count, get_ethtool_stats to get peer
>> ifindex.
>> ethtool -S nk1
>> NIC statistics:
>>       peer_ifindex: 36
>>
>> Add get_link, get_link_ksettings to get link stat.
>> ethtool nk1
>> Settings for nk1:
>>     ...
>>     Link detected: yes
>>
>> Add get_ts_info.
>> ethtool -T nk1
>> Time stamping parameters for nk1:
>> ...
>>
>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>> ---
>>   drivers/net/netkit.c | 53 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 53 insertions(+)
>>
> 
> Hi,
> I don't see any point in sending peer_ifindex through ethtool, even
> worse through ethtool stats. That is definitely the wrong place for it.
> You can already retrieve that through netlink. About the speed/duplex
> this one makes more sense, but this is the wrong way to do it.
> See how we did it for virtio_net (you are free to set speed/duplex
> to anything to please bonding for example). Although I doubt anyone will 
> use netkit with bonding, so even that is questionable. :)
> 
> Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>
> 
> Cheers,
>   Nik
> 

We use netkit to replace veth to improve performance, veth can be used 
ethtool -S veth to get peer_ifindex, so this part is added, as long as 
it is to keep the netkit part and veth unified, to ensure the same usage 
habits, and to replace it without perception.



