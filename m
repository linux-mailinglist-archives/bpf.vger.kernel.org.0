Return-Path: <bpf+bounces-42166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C379A0425
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 10:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B701F23BA4
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 08:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460BD1D2710;
	Wed, 16 Oct 2024 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="CAJ0wJON"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69224C8C;
	Wed, 16 Oct 2024 08:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067071; cv=none; b=C6ew63lr5fUcKhBDlZcRxZSEohPHlqhNRLMWUWWyncaN711S+ZcBz4imf1mE4tQ7u0QoRLrmHnPyu4uuoguIA4DbfPHk77liNmubCqleP8Hk/R9i/vCiwWc77opDW3iF2NZ5jl3jrl7LX5qH/uPaqvyxHJL4sQv+RGmvGf+WXSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067071; c=relaxed/simple;
	bh=QZt969p5EX6OQ8iJpSVADmTW4xlNva+/MteDI2Hu6+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGcXONKP+pEesyJwA2gJVSZGIvPRWB9i2HDTb0v0nN/yvR7myiGaEs5wB9AK2wuKJ10/y2feZm0jIBdKs1PLoseKy8L+D6XQZGnmLuLuASTBzbACRTMtnxmxDS1edUs/2nUbVtkuDb4oIQVgwK99T90lFkUxT95FUr8+08H3DhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=CAJ0wJON; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=MzADUjcxPilKtWYEYzM9Kru86HPJglHZ7KNTxhTum4c=; b=CAJ0wJONvZJZ4P2FptykkMoBCq
	M4fpDDnCy7F9puznnYkLiSDM+sxDPjIfvXiwktiR8r4gF1sUxZUt7PR2f2vgGUclR/FGOSsh0QadU
	690neWLmJQRLjOeLnFtysfDJ/Y41zG0oQ3A6EQ2d6VuldMPFkwjAuiH7UAbiE8/obphmR7aQYuqlb
	TFy4CLKS8cOmZn9E5gQoMkKL2ISkMDFWpNZAZ+FG8eVxMkm1CfeIXZyl43GfUmncI9foHeZbw9TRV
	Vq8rv/pZ1/5uh9FvTOv4tu1V8dFrz5l4qxsdfdmuT9AXirTaxSU8+P30qCgBdFJzbjJSdfGN3jQlZ
	0Qpjrx3A==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1t0zKT-0008Bp-GQ; Wed, 16 Oct 2024 10:24:25 +0200
Received: from [178.197.248.44] (helo=[192.168.1.114])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1t0zKS-000CAE-1Z;
	Wed, 16 Oct 2024 10:24:24 +0200
Message-ID: <8c530793-a9cf-4178-a5a0-bf9dd264ad20@iogearbox.net>
Date: Wed, 16 Oct 2024 10:24:23 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] bonding: return detailed error when loading
 native XDP fails
To: Nikolay Aleksandrov <razor@blackwall.org>,
 Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrii Nakryiko <andriin@fb.com>,
 Jussi Maki <joamaki@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>,
 Andy Gospodarek <andy@greyhouse.net>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20241016031649.880-1-liuhangbin@gmail.com>
 <20241016031649.880-2-liuhangbin@gmail.com>
 <b223add3-169a-4753-bdac-9f4cfc95eb97@iogearbox.net>
 <87ebd401-ddb3-4cb8-9e62-424b5497c33e@blackwall.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <87ebd401-ddb3-4cb8-9e62-424b5497c33e@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27428/Tue Oct 15 10:32:14 2024)

On 10/16/24 10:13 AM, Nikolay Aleksandrov wrote:
> On 16/10/2024 10:59, Daniel Borkmann wrote:
>> On 10/16/24 5:16 AM, Hangbin Liu wrote:
>>> Bonding only supports native XDP for specific modes, which can lead to
>>> confusion for users regarding why XDP loads successfully at times and
>>> fails at others. This patch enhances error handling by returning detailed
>>> error messages, providing users with clearer insights into the specific
>>> reasons for the failure when loading native XDP.
>>>
>>> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>>> ---
>>>    drivers/net/bonding/bond_main.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>>> index b1bffd8e9a95..f0f76b6ac8be 100644
>>> --- a/drivers/net/bonding/bond_main.c
>>> +++ b/drivers/net/bonding/bond_main.c
>>> @@ -5676,8 +5676,11 @@ static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>>>          ASSERT_RTNL();
>>>    -    if (!bond_xdp_check(bond))
>>> +    if (!bond_xdp_check(bond)) {
>>> +        BOND_NL_ERR(dev, extack,
>>> +                "No native XDP support for the current bonding mode");
>>>            return -EOPNOTSUPP;
>>> +    }
>>>          old_prog = bond->xdp_prog;
>>>        bond->xdp_prog = prog;
>>
>> LGTM, but independent of these I was more thinking whether something like this
>> could do the trick (only compile tested). That way you also get the fallback
>> without changing anything in the core XDP code.
>>
>> Thanks,
>> Daniel
>>
>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>> index b1bffd8e9a95..2861b3a895ff 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -5915,6 +5915,10 @@ static const struct ethtool_ops bond_ethtool_ops = {
>>       .get_ts_info        = bond_ethtool_get_ts_info,
>>   };
>>   
>> +static const struct device_type bond_type = {
>> +    .name = "bond",
>> +};
>> +
>>   static const struct net_device_ops bond_netdev_ops = {
>>       .ndo_init        = bond_init,
>>       .ndo_uninit        = bond_uninit,
>> @@ -5951,9 +5955,20 @@ static const struct net_device_ops bond_netdev_ops = {
>>       .ndo_hwtstamp_set    = bond_hwtstamp_set,
>>   };
>>   
>> -static const struct device_type bond_type = {
>> -    .name = "bond",
>> -};
>> +static struct net_device_ops bond_netdev_ops_noxdp __ro_after_init;
>> +
>> +static void __init bond_setup_noxdp_ops(void)
>> +{
>> +    memcpy(&bond_netdev_ops_noxdp, &bond_netdev_ops,
>> +           sizeof(bond_netdev_ops));
>> +
>> +    /* Used for bond device mode which does not support XDP
>> +     * yet, see also bond_xdp_check().
>> +     */
>> +    bond_netdev_ops_noxdp.ndo_bpf = NULL;
>> +    bond_netdev_ops_noxdp.ndo_xdp_xmit = NULL;
>> +    bond_netdev_ops_noxdp.ndo_xdp_get_xmit_slave = NULL;
>> +}
>>   
>>   static void bond_destructor(struct net_device *bond_dev)
>>   {
>> @@ -5978,7 +5993,9 @@ void bond_setup(struct net_device *bond_dev)
>>       /* Initialize the device entry points */
>>       ether_setup(bond_dev);
>>       bond_dev->max_mtu = ETH_MAX_MTU;
>> -    bond_dev->netdev_ops = &bond_netdev_ops;
>> +    bond_dev->netdev_ops = bond_xdp_check(bond) ?
>> +                   &bond_netdev_ops :
>> +                   &bond_netdev_ops_noxdp;
> 
> This will have to be done safely on bond mode change as well.
> If all slaves are released we can switch modes without destroying
> the device.

Ah fair, yeah perhaps not worth the added complexity. Tbh, if someone
loads an XDP program with the fallback to generic, it feels super fragile
in the first place and I wouldn't do this ever for production workloads.
Meaning, fixed to native for production, generic XDP for testing where
native is not available (e.g. CI), at least that's how we use it.

Thanks,
Daniel

