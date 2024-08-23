Return-Path: <bpf+bounces-37944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D1395CC13
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 14:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3571F25970
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 12:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A780185922;
	Fri, 23 Aug 2024 12:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="iPI+BYN3"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF677469D;
	Fri, 23 Aug 2024 12:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414888; cv=none; b=uiptCs8D7BjkXcj4HJGkc99Ee8HQOH2db5TeSG1M/mnpHeCLVbgHPGdiZaoPZWkfEC18OcU3CGFXzB5Lj3wAkykV3BuNSwqDm9rBAe7agO5la/w2eLvriC8Cx0qiACiPkzsLKgOWQl6pT55wD+IBNLTi08cXA+K2BMvA7LzUWts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414888; c=relaxed/simple;
	bh=ZLHQc0IpZLg9q4x1Zu/43JVc/lyLKGgnVMcNtBKYDlo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ze0/gHYZNZpXqnQ+6vReoAwhDYCjWNrj5rYQYw0gpo/b93DLQqwVyfyM9R/8gxq/q5SJCiuUoFC+ybzMmy+oueP6Lstf6fUM3Mqn45wRl0wCx5HFDOqyGfUW+mMrBaeqsoUIzQsWsXYCBu8qhj0iWI++GN//jDNXcU84vZ2wA94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=iPI+BYN3; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=qOpiN0yfFcQklO8pw7LWA14dBrUyLAlm9Cq1gHMDPM4=; b=iPI+BYN3dTx2KXVDY5zCqRYwKi
	ruvtzsvl5jZ+sxjO5pm6nqqHUBZWvm5ArFalVZJnov788BxZ8EkpuL9eBrRPUBIyvPE0kxqWvEzuB
	QgGLgDNYHNjW8a/+h4eR+D9mPD6+QIJuSLR+BHj4JnOCuSOaa/k3rBrMvpJAv/CN6ncZaSEnmv8lH
	L8qkawPDP9yukC19xy4oG6OuB0Jmo/DcRMgBlmrLkSGFK0hrYHGRw6RyOKUXOWBfXwv6hD65M1UuE
	ryOaerXlKBOL422+wR1fmWaqLbnKLgYCjo+KfWMPANzPAjfSKiMss3kMhOaOAsMaoXIyw8DLm/DcT
	HvBVESQw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1shT51-000N3H-GY; Fri, 23 Aug 2024 14:07:47 +0200
Received: from [178.197.248.23] (helo=linux-2.home)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1shT4z-00076m-3C;
	Fri, 23 Aug 2024 14:07:46 +0200
Subject: Re: [PATCH bpf-next v2] net: Don't allow to attach xdp if bond slave
 device's upper already has a program
To: Jiri Pirko <jiri@resnulli.us>, Feng zhou <zhoufeng.zf@bytedance.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, bigeasy@linutronix.de, lorenzo@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
References: <20240823084204.67812-1-zhoufeng.zf@bytedance.com>
 <Zsh4vPAPBKdRUq8H@nanopsycho.orion>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6d38eaf5-0a13-9f85-3a5d-0ca354bc45d5@iogearbox.net>
Date: Fri, 23 Aug 2024 14:07:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zsh4vPAPBKdRUq8H@nanopsycho.orion>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27376/Fri Aug 23 10:47:45 2024)

On 8/23/24 1:55 PM, Jiri Pirko wrote:
> Fri, Aug 23, 2024 at 10:42:04AM CEST, zhoufeng.zf@bytedance.com wrote:
>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>
>> Cannot attach when an upper device already has a program, This
>> restriction is only for bond's slave devices or team port, and
>> should not be accidentally injured for devices like eth0 and vxlan0.
> 
> What if I attach xdp program to solo netdev and then I enslave it
> to bond/team netdev that already has xdp program attached?
> What prevents me from doing that?

In that case the enslaving of the device to bond(/team) must fail as
otherwise the latter won't be able to propagate the XDP prog downwards.

Feng, did you double check if we have net or BPF selftest coverage for
that? If not might be good to add.

>> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>> ---
>> Changelog:
>> v1->v2: Addressed comments from Paolo Abeni, Jiri Pirko
>> - Use "netif_is_lag_port" relace of "netif_is_bond_slave"
>> Details in here:
>> https://lore.kernel.org/netdev/3bf84d23-a561-47ae-84a4-e99488fc762b@bytedance.com/T/
>>
>> net/core/dev.c | 10 ++++++----
>> 1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index f66e61407883..49144e62172e 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -9502,10 +9502,12 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
>> 	}
>>
>> 	/* don't allow if an upper device already has a program */
>> -	netdev_for_each_upper_dev_rcu(dev, upper, iter) {
>> -		if (dev_xdp_prog_count(upper) > 0) {
>> -			NL_SET_ERR_MSG(extack, "Cannot attach when an upper device already has a program");
>> -			return -EEXIST;
>> +	if (netif_is_lag_port(dev)) {
>> +		netdev_for_each_upper_dev_rcu(dev, upper, iter) {
>> +			if (dev_xdp_prog_count(upper) > 0) {
>> +				NL_SET_ERR_MSG(extack, "Cannot attach when an upper device already has a program");
>> +				return -EEXIST;
>> +			}
>> 		}
>> 	}
>>
>> -- 
>> 2.30.2
>>
> 


