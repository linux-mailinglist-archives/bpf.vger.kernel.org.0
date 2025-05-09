Return-Path: <bpf+bounces-57853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1A0AB15CA
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 15:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ECF017672A
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 13:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A352920B3;
	Fri,  9 May 2025 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZJSFqaX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E502920A2;
	Fri,  9 May 2025 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746798490; cv=none; b=E8UxwKZPkjGstZdQl/aZsphkLZUeHj/QNYSzxf3OYElQ79KDWMvTUJDK1Y/n/1ubcsd9OrS2C3l5xEWnxf2XpGMqinnesQ6Aa9Aj2Yu7fpH+zi+hUnspMMtADvKHHo43TzGv6VmusLjdacCI6LNOSqSOgPTzbmhlOhhp4dMaQYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746798490; c=relaxed/simple;
	bh=ATcmr19BWEHQiEiyArZX2i3SQQ4xLQA7pNESNvveRrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvaXbnm/7ETdOZqAeiSazmAWT/3iMHP0cE44pLM4zP5NVdW9iGW58QjXOP5vBdiRgBc9+wNPYY1/pW8PHUiF4hSZxJVG7q7sxh+WpjMfrfeBGEVaHLjrA1u3S87VEsda1FRa7+6AeNE/DJVuGTwaUcRPW4ppbDNHiMY3Q6+T0LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZJSFqaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9664C4CEE4;
	Fri,  9 May 2025 13:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746798488;
	bh=ATcmr19BWEHQiEiyArZX2i3SQQ4xLQA7pNESNvveRrg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uZJSFqaXyI5J+qLsCzDiZTUeoYyIU+2VTjP/wq0tRSOqBfN5xiu/L/SDpkTKP2FRW
	 F/hNIdwkUD2cn+numvYETtp1AQvPwNvbSoSanYH925+f3BYT4guaGeo7DaYmjLymDz
	 zXac1cgQ5n+CCuaHXKfby5OxBlZSzQzFJ0sxxpgdWXcOiOH7eHNWswOPm8WqIqYkGm
	 KsWobh0WSkphIOIV2F7atml03fAPXbJeFw2wlxq6KyJsmML6Afm9KviS5yw/OXJfDt
	 zX/Exy3gZbJ/uPFGOPPuylxsE5aBIBnS6wIG75GQsiX4UtYXmJgzfIZOURXVzCoKnF
	 ytVsFCdZR+4eA==
Message-ID: <665a622b-cb6b-4647-a287-b1b03d78e02f@kernel.org>
Date: Fri, 9 May 2025 15:48:04 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V1] net: track pfmemalloc drops via
 SKB_DROP_REASON_PFMEMALLOC
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 kernel-team@cloudflare.com, mfleming@cloudflare.com
References: <174619899817.1075985.12078484570755125058.stgit@firesoul>
 <20250502161733.17fd0d60@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250502161733.17fd0d60@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 03/05/2025 01.17, Jakub Kicinski wrote:
> On Fri, 02 May 2025 17:16:38 +0200 Jesper Dangaard Brouer wrote:
>> @@ -142,15 +144,20 @@ int sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb, unsigned int cap)
>>   	 */
>>   	if (skb_pfmemalloc(skb) && !sock_flag(sk, SOCK_MEMALLOC)) {
>>   		NET_INC_STATS(sock_net(sk), LINUX_MIB_PFMEMALLOCDROP);
>> +		*reason = SKB_DROP_REASON_PFMEMALLOC;
>>   		return -ENOMEM;
>>   	}
>>   	err = BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb);
>> -	if (err)
>> +	if (err) {
>> +		*reason = SKB_DROP_REASON_SOCKET_FILTER;
>>   		return err;
>> +	}
>>   
>>   	err = security_sock_rcv_skb(sk, skb);
>> -	if (err)
>> +	if (err) {
>> +		*reason = SKB_DROP_REASON_SECURITY_HOOK;
>>   		return err;
>> +	}
>>   
>>   	rcu_read_lock();
>>   	filter = rcu_dereference(sk->sk_filter);
> 
> there is:
> 
> 	err = pkt_len ? pskb_trim(skb, max(cap, pkt_len)) : -EPERM;
> 
> later on, which I think may return error without touching drop reason.
> If caller didn't init it the reason will be undefined.

Good review, thanks for catching this.

In this (-EPERM) case should clearly set SKB_DROP_REASON_SOCKET_FILTER.
It is the original "main" reason for socket filter drop decision.
Thanks for catching my mistake.

The BPF-prog return value for type BPF_PROG_TYPE_SOCKET_FILTER is
different than more modern BPF-prog types (that usually returns an
action).  This confused me a bit when reading the code, so let link the
documentation here[1] to help reviewers and seed Google + AIs.

It states: "The return value from indicates how many bytes of the
message should be kept. Returning a value less then the side of the
packet will truncate it and returning 0 will discard the packet."

Will send a V2.

--Jesper

[1] https://docs.ebpf.io/linux/program-type/BPF_PROG_TYPE_SOCKET_FILTER/

