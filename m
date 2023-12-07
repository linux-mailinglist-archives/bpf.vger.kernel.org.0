Return-Path: <bpf+bounces-16997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96069808508
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 10:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1AA283B0B
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 09:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE9F35289;
	Thu,  7 Dec 2023 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TfSDwBOx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A16D59
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 01:57:00 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6cb74a527ceso352047b3a.2
        for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 01:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701943019; x=1702547819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxtoXiW1GafKjWW917pS65soeBGEddpEWhKf7g8xPVI=;
        b=TfSDwBOxM9aIqA6bak5Q1MULDjr6tlr9fDPspQ7sbvWovcfTZ3DQSapwViG9G5og/I
         cEqqwL6UP5QMSq1XCm31hNrA3uXM+gD3YZexgbec9+oiQkB4pBkk8HN3vI/MR+rcGKMD
         f0v8lDjuAE9YTjnaxuL20T8d5b++bvlyZ+e710CaCwMry9LFyCloJfQcK0NmJZFNZYK3
         9SEl86bjDqQ7czCTi3ndTy+3lTPIZxonByG04nXgAbfwUIhm3A10n5k9zZu/vsE02+qE
         S1wvdDn+0NL5OZuDb4lORaiIJJZTo09qLfutRl14tTaN2uHjAdyuj1OpECrd7IRDhGqA
         UX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701943019; x=1702547819;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BxtoXiW1GafKjWW917pS65soeBGEddpEWhKf7g8xPVI=;
        b=VVPOU53/Ws26NWoaaOUrfLZy8OLbiq5kGZQpcqc/8xwJJ9cyXikyYJLJSwYie5Iv73
         4uK2t5Rx/XmNP2gaBgeHh0CRXYqMWPSO4eyo0YrEwFvWKg+RV2QEjFmFyrzzepyTzK2w
         Ow89hKZSQCkbMq/7S9PAYeCk7enhFzuTCyaFXJiT0O4ikLR6QcQ2Tm01VamMXggH9sLI
         xmvVl/Qc/wAOvD8ySSm6ZJgkYsFhLe4ZXDwpxPtAE7iJUC+JqqTbLaeEHNWPnTukRKZF
         +IWPPc2BoNEqmw8HwJhh+PUrNUOuiwBu2aSadC2QDBRwxtoM8JA6PxBhlGxHmDaNQ2jg
         qmGA==
X-Gm-Message-State: AOJu0Yxwzsd0ZAXgnIwC95RNfedSEjEC7H79NEtnWHLKsqR0IZwy7LNE
	sE/E4LbdM4xVs+zwbFfO27+lGA==
X-Google-Smtp-Source: AGHT+IGVYAtbjhU0+Vh9odI7cUMr50rN35LygNjdVcELx7W5mCm1/O9oXuTDZE6Wrh2nKpr/NAgHTw==
X-Received: by 2002:a05:6a00:2e99:b0:6ce:3388:20 with SMTP id fd25-20020a056a002e9900b006ce33880020mr2152052pfb.53.1701943019497;
        Thu, 07 Dec 2023 01:56:59 -0800 (PST)
Received: from [10.84.153.44] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id u22-20020aa78496000000b006ce742b6b1fsm902380pfn.63.2023.12.07.01.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 01:56:58 -0800 (PST)
Message-ID: <bb6c65de-1788-46a4-b913-5b1afa9c5cd7@bytedance.com>
Date: Thu, 7 Dec 2023 17:56:52 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH bpf-next] netkit: Add some ethtool ops to provide
 information to user
To: Daniel Borkmann <daniel@iogearbox.net>,
 Nikolay Aleksandrov <razor@blackwall.org>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com, tangchen.1@bytedance.com
References: <20231130075844.52932-1-zhoufeng.zf@bytedance.com>
 <51dd35c9-ff5b-5b11-04d1-9a5ae9466780@blackwall.org>
 <16b4d42d-2d62-460e-912f-6e3b86f3004d@bytedance.com>
 <94e335d4-ec90-ba78-b2b4-8419b25bfa88@iogearbox.net>
 <57587b74-f865-4b56-8d65-a5cbc6826079@bytedance.com>
 <2a829a9c-69a6-695d-d3df-59190b161787@iogearbox.net>
 <b7053425-65eb-46a0-abd9-59ade5e78211@bytedance.com>
 <d75ffdd9-203a-94a3-57c1-69b1561d808e@iogearbox.net>
From: Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <d75ffdd9-203a-94a3-57c1-69b1561d808e@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2023/12/6 18:57, Daniel Borkmann 写道:
> On 12/6/23 7:59 AM, Feng Zhou wrote:
>> 在 2023/12/4 23:22, Daniel Borkmann 写道:
>>> Thanks, so the netkit_get_link_ksettings is optional. 
>>
>> Yes, netkit_get_link_ksettings really not necessary, I just added it 
>> in line with veth.
>>
>> I don't quite
>>> follow what you
>>> mean with regards to your business logic in veth to obtain peer 
>>> ifindex. What does
>>> the script do exactly with the peer ifindex (aka /why/ is it needed), 
>>> could you
>>> elaborate some more - it's still somewhat too vague? 🙂 E.g. why it 
>>> does not suffice
>>> to look at the device type or other kind of attributes?
>>
>> The scripting logic of the business colleagues should just be simple 
>> logging records, using ethtool. Then they saw that netkit has this 
>> missing, so raised this requirement, so I sent this patch, wanting to 
>> hear your opinions. If you don't think it's necessary, let the 
>> business colleagues modify it.
> 
> So it is basically only logging the peer_ifindex data from ethtool but 
> nothing
> more is done with it? Meaning, this was raised as a requirement because 
> this was
> missing from the logging data, or was there anything more to it?
> 
> The peer ifindex is already available via IFLA_LINK (which does 
> dev_get_iflink()
> internally to fetch the peer's ifindex). This is also what you see in 
> iproute2:
> 
> # ip l
> [...]
> 163: nk0@nk1: <BROADCAST,MULTICAST,NOARP,M-DOWN> mtu 1500 qdisc noop 
> state DOWN group default qlen 1000
>      link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
> 164: nk1@nk0: <BROADCAST,MULTICAST,NOARP,M-DOWN> mtu 1500 qdisc noop 
> state DOWN group default qlen 1000
>      link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
> [...]
> # ip netns add blue
> # ip link set nk1 netns blue
> # ip l
> [...]
> 163: nk0@if164: <BROADCAST,MULTICAST,NOARP> mtu 1500 qdisc noop state 
> DOWN group default qlen 1000
>      link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff link-netns blue
> [...]
> 
> The `if164` denotes the peer's ifindex and `link-netns blue` provides 
> info on the netns of the peer.
> This is much better and more generic than the ethtool hack. I would 
> suggest changing the logic to
> rather look at data populated by rtnl_fill_link_netnsid() instead.
> 
> Thanks,
> Daniel

Yes, if veth supports ethtool -S to get the function of peer's ifindex, 
it is not necessary for netkit and can be replaced by other ways.




