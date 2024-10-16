Return-Path: <bpf+bounces-42163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15359A03D8
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 10:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7AB28640C
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 08:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D861D2B3B;
	Wed, 16 Oct 2024 08:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="ZRwlek/D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F9D1B2193
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 08:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066404; cv=none; b=GQab5KGDiRYg6HELNsAKnAt9l621KyC3aF2nozuxRY01RBRtwIULXKLjFK71vA6OzkipgSl7EhzFYRXLVgaZS0TVwzMJZ1icqb+tZUdiQUEz36zM6zlRZSelt91bktCdnup738LPnvqAO8U6AU8Yerd6UvBuN+pasgvm772FiMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066404; c=relaxed/simple;
	bh=nssl3SYilnWVJ40tlUoPhqFzVGRlgsPn//Jw4/h4DNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gy19p8dJiDGvYU7h9xMzYV3MjvdSLzcQnCkdON4utD9i/hNtJNUacX683e2zgQTT/wzCqr2IlOPYRc16dIFsV6LJuz0xHFejygbcAaDeoNNoO4gSZOaC1McpsPTTM9+0XKS3+88T0GZfqaSB+0NZfU8n5iTZ/Jf/GyieFR2ogac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=ZRwlek/D; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a99650da839so1042771766b.2
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 01:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1729066401; x=1729671201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Cn1wIQyWLGynlfKCVlpsBWacDpmNH2hnvnNMUM8wB4=;
        b=ZRwlek/DIAJXjFOjctKrW0+/vAn5Mccx+/78skyhPfR6YQbguTrL0sJ0z6TzLmaTKu
         WTURHiM8uP87OsyGSZqPA7A1zMU0uVbeQCC3b3iGJAUuGTM1CETH3Ol/m+/lGA5QKTih
         IjHny4s66PXDemEuoVOxhTmJJXPs2bT/Sss2u4wqhfyStK8RBYdXN/AknDVorDbWrtxN
         4HueuYYCI3Gvzw/VY4kGvHMfw6YPs53JeCRG+ETkD/YjJKyGDm8Q9ykgsTqu28Jn4q/O
         ZHVpNr01g9Tha09LlSTY+8kGjW7d8PvImfG+WpWuKJ/QCOQu51ikSyXOLN7raukxZ3aH
         CGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729066401; x=1729671201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Cn1wIQyWLGynlfKCVlpsBWacDpmNH2hnvnNMUM8wB4=;
        b=hl/KFjp8pQRyS5DgRn4PrhvC9ZioLZ4KfzrWKJR4Ky4k3IbtYD+DNVkDjJDF65amvm
         MFZwNABYaBt8z1o8bBiyFaVQp8AC6nm2ghgUxoOEqWL56PYNYhmoZi0X50Uy5V+c98vG
         surUXwQlxsPPk6WRaxYzp7eZzk+4+axTeMr6OEr+f30OEPVMO2ugrareYSn5zNFSYfQK
         ufzxelPFcs5RFned2HMP6a/T+FfzNooz4wUuCWgpHJbB+3lfT2rmO1rbllJ0qGsoIWOZ
         kppt0cGQRPGYuSjPUXwZYCBnm6jx6duJZGVtWlKuchp9KVzUPxMPdkZ4sGhYLYzqteQy
         jevA==
X-Forwarded-Encrypted: i=1; AJvYcCUS3QdXfEC5tpLtaxkTobR2DVdENXJ9hlo67xJz3k6wIzpmMVue0W85YR/VB/XjiqpSsvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTDN/vTnTRZuBBtFEGOsxoERBeeDl0VCqN+EtqL0Da3WgpinD7
	O+mUxdcW863HItCltyqQvRtJ+ONPBq2oW+pFbwDwp6GySa+eIwcofKvuldkalHc=
X-Google-Smtp-Source: AGHT+IE1k1DMXwgADYwN4dp3IYBX0lX1WogcG6ds4IlQSb+TgJnFAwgx7DT19DgGECGmqpotWy7fIw==
X-Received: by 2002:a17:906:da83:b0:a7a:9144:e23a with SMTP id a640c23a62f3a-a99e3e437f4mr1409198066b.43.1729066401308;
        Wed, 16 Oct 2024 01:13:21 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29816bf8sm151707566b.101.2024.10.16.01.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 01:13:20 -0700 (PDT)
Message-ID: <87ebd401-ddb3-4cb8-9e62-424b5497c33e@blackwall.org>
Date: Wed, 16 Oct 2024 11:13:19 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] bonding: return detailed error when loading
 native XDP fails
To: Daniel Borkmann <daniel@iogearbox.net>, Hangbin Liu
 <liuhangbin@gmail.com>, netdev@vger.kernel.org
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
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <b223add3-169a-4753-bdac-9f4cfc95eb97@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/10/2024 10:59, Daniel Borkmann wrote:
> On 10/16/24 5:16 AM, Hangbin Liu wrote:
>> Bonding only supports native XDP for specific modes, which can lead to
>> confusion for users regarding why XDP loads successfully at times and
>> fails at others. This patch enhances error handling by returning detailed
>> error messages, providing users with clearer insights into the specific
>> reasons for the failure when loading native XDP.
>>
>> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>> ---
>>   drivers/net/bonding/bond_main.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>> index b1bffd8e9a95..f0f76b6ac8be 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -5676,8 +5676,11 @@ static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>>         ASSERT_RTNL();
>>   -    if (!bond_xdp_check(bond))
>> +    if (!bond_xdp_check(bond)) {
>> +        BOND_NL_ERR(dev, extack,
>> +                "No native XDP support for the current bonding mode");
>>           return -EOPNOTSUPP;
>> +    }
>>         old_prog = bond->xdp_prog;
>>       bond->xdp_prog = prog;
> 
> LGTM, but independent of these I was more thinking whether something like this
> could do the trick (only compile tested). That way you also get the fallback
> without changing anything in the core XDP code.
> 
> Thanks,
> Daniel
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index b1bffd8e9a95..2861b3a895ff 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -5915,6 +5915,10 @@ static const struct ethtool_ops bond_ethtool_ops = {
>      .get_ts_info        = bond_ethtool_get_ts_info,
>  };
>  
> +static const struct device_type bond_type = {
> +    .name = "bond",
> +};
> +
>  static const struct net_device_ops bond_netdev_ops = {
>      .ndo_init        = bond_init,
>      .ndo_uninit        = bond_uninit,
> @@ -5951,9 +5955,20 @@ static const struct net_device_ops bond_netdev_ops = {
>      .ndo_hwtstamp_set    = bond_hwtstamp_set,
>  };
>  
> -static const struct device_type bond_type = {
> -    .name = "bond",
> -};
> +static struct net_device_ops bond_netdev_ops_noxdp __ro_after_init;
> +
> +static void __init bond_setup_noxdp_ops(void)
> +{
> +    memcpy(&bond_netdev_ops_noxdp, &bond_netdev_ops,
> +           sizeof(bond_netdev_ops));
> +
> +    /* Used for bond device mode which does not support XDP
> +     * yet, see also bond_xdp_check().
> +     */
> +    bond_netdev_ops_noxdp.ndo_bpf = NULL;
> +    bond_netdev_ops_noxdp.ndo_xdp_xmit = NULL;
> +    bond_netdev_ops_noxdp.ndo_xdp_get_xmit_slave = NULL;
> +}
>  
>  static void bond_destructor(struct net_device *bond_dev)
>  {
> @@ -5978,7 +5993,9 @@ void bond_setup(struct net_device *bond_dev)
>      /* Initialize the device entry points */
>      ether_setup(bond_dev);
>      bond_dev->max_mtu = ETH_MAX_MTU;
> -    bond_dev->netdev_ops = &bond_netdev_ops;
> +    bond_dev->netdev_ops = bond_xdp_check(bond) ?
> +                   &bond_netdev_ops :
> +                   &bond_netdev_ops_noxdp;

This will have to be done safely on bond mode change as well.
If all slaves are released we can switch modes without destroying
the device.

>      bond_dev->ethtool_ops = &bond_ethtool_ops;
>  
>      bond_dev->needs_free_netdev = true;
> @@ -6591,6 +6608,8 @@ static int __init bonding_init(void)
>      int i;
>      int res;
>  
> +    bond_setup_noxdp_ops();
> +
>      res = bond_check_params(&bonding_defaults);
>      if (res)
>          goto out;


