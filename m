Return-Path: <bpf+bounces-39076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 292A096E4A0
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 23:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C709A1F245CB
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 21:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BACB19FA81;
	Thu,  5 Sep 2024 21:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qWXcwdOh"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2FF165F0E
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725570452; cv=none; b=SaBtsHUgxPNsOzR58zw4N7zX9lMCcVbdsX2CNL0CjwwTrxI3AFBWac2VMUZlRxBDK1w7KCDHHg4GyGUFQPx7z/nhhH0JaKOLqiwyMVU+5SLowG2pYALMW4m4jkAOVj4GRrwEYmX7Uya39mlJBSodFHu1j/2HoxGBS6aNGO63PEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725570452; c=relaxed/simple;
	bh=6o3pL9RsyqSBjI8a2dkQJxNb0aUFdoroghwjPME2u8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krAueAyBrr4oDoR5y+3lUKKaoShNTagRE8ouNXOTEmyfGC70HHPb87mcTBERR5Ft58x/v6ztfz3WV5kuASH41SsmbXVv+uQ4b0YWqWQCwPT2uIQ7XeUj9aKxMYuTCI7rnQWiYSg2TUO4nXQLwuYlVC+o91FeXPvSxncJDyV0Vtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qWXcwdOh; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <571b7395-a816-42f2-8e76-64d02cbb9958@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725570448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eom5H4fzxFKh+2DVNwzRQMDGyCL74QwQjiWrmTchd5M=;
	b=qWXcwdOhTkGRMX0uiRQBLA43GjZQ3LyzBuOW6ena4E3f9xo6en7zGsXYobIO5AmlrX4ieJ
	gCms0KrbfalFu6MORbRL3VjQZsn+mxcG0jlVUExB704F8URDfF4ZHncNNKWO+FAjd4YEK+
	wERkVFjZHBAX98G3d/2JLyQroPcbfFE=
Date: Thu, 5 Sep 2024 14:07:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: tcp: prevent bpf_reserve_hdr_opt()
 from growing skb larger than MTU
To: Zijian Zhang <zijianzhang@bytedance.com>,
 Amery Hung <amery.hung@bytedance.com>
Cc: bpf@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, xiyou.wangcong@gmail.com, wangdongdong.6@bytedance.com,
 zhoufeng.zf@bytedance.com
References: <20240827013736.2845596-1-zijianzhang@bytedance.com>
 <20240827013736.2845596-2-zijianzhang@bytedance.com>
 <5186a69b-c53d-4afa-b3be-e6bd272d264f@linux.dev>
 <955cb3be-1dc4-4ebf-b0de-75c25f393c1e@bytedance.com>
 <c9cf1c15-5038-4c85-be80-5fff34a2df44@linux.dev>
 <3e387788-1f5a-4159-9ff5-e53e897ae41c@bytedance.com>
 <d89a6a41-c109-4033-8eba-1e11c3c6d1f6@linux.dev>
 <58d770f9-18c7-435b-b14f-215482ee151f@bytedance.com>
 <c56c516a-3e9d-4e42-b5e8-527d6f4cf74b@linux.dev>
 <7ce7a2f7-d1d5-43c1-9d44-97bfedc6c123@bytedance.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <7ce7a2f7-d1d5-43c1-9d44-97bfedc6c123@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/5/24 1:20 PM, Zijian Zhang wrote:
>>>
>>> Cases I can think of are as follows,
>>> - When it's not a GSO skb, tcp_skb_seglen will simply return skb->len,
>>> it might make `tp->mss_cache - tcp_skb_seglen(skb)` a large number.
>>>
>>> - When we are in tcp_mtu_probe, tp->mss_cache will be smaller than
>>> tcp_skb_seglen(skb), which makes the equation again a large number.
>>
>> In tcp_mtu_probe, mss_cache is (smaller) than the tcp_skb_seglen(skb)?
>>
> 
> ```
> tcp_init_tso_segs(nskb, nskb->len);
> if (!tcp_transmit_skb(sk, nskb, 1, GFP_ATOMIC)) ...
> ```
> 
> In the tcp_transmit_skb inside tcp_mtu_probe, it tries to send an skb
> with larger mss, so I assume mss_cache will be smaller than
> tcp_skb_seglen(skb). Sorry for the confusion here.

hmm... "mss_cache - tcp_skb_seglen(skb)" and mss_cache could be smaller...
This is another signal that this approach does not sound right. I am not 
positive tbh. Given that I have already suggested more than one other ways. If 
you really eager to pursue this route to improve bpf_reserve_hdr_opt(), the 
tests coverage has to be convincing enough to cover corner cases like this for 
example.

pw-bot: cr

