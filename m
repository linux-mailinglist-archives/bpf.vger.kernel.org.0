Return-Path: <bpf+bounces-50215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFF9A23F19
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 15:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1027A1889E36
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 14:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33BF1CF284;
	Fri, 31 Jan 2025 14:25:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7678EAC6;
	Fri, 31 Jan 2025 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738333550; cv=none; b=Lq4JuWGIux1Fr448p3R1Y0JfwN3+PpcLs+dxA+NXClJvoSJ5qKsnTj8ufpZbdkktKspmituq6yo8lFegHlSx6t8IP49LmJ0cDaR0K/NtTuHH3ZVJ+3I9IsYHcbwW2f6fXtdXZIDhpUkDW/rZ4ZgDJKHAuloS7FYRfEPr2qVLJPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738333550; c=relaxed/simple;
	bh=OTi2cYqbLdgIpg/bZoI0phHJLMi9IzMbOP86LVeI23Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=VVqHTITyb0cAOwx4kq0AOQnRrWSNLPkudL8hmQObz1e1UDGsIzlucSU3crxbli5hIxeQyR6lzlKt0+MTS5aT/+P2+hFWDQEuMybGuhItiILTmvzLxrRiumeRmrFeTm1B77ROjomEDsXMzEsUBR7mjfwZxmjSTXMuskpErmcssbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tdrxf-000Lcb-9b; Fri, 31 Jan 2025 15:25:35 +0100
Received: from [2a0d:3344:1523:1f10:f118:b2d4:edbb:54af]
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tdrxf-0000uD-0F;
	Fri, 31 Jan 2025 15:25:35 +0100
Message-ID: <a1120039-b0a6-4882-be23-7ea1174f8ab7@hetzner-cloud.de>
Date: Fri, 31 Jan 2025 15:25:34 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com
References: <20250130171614.1657224-1-marcus.wichelmann@hetzner-cloud.de>
 <20250130171614.1657224-2-marcus.wichelmann@hetzner-cloud.de>
 <Z5wIZ2LAjz0wTWg5@mini-arch>
Content-Language: en-US
From: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Autocrypt: addr=marcus.wichelmann@hetzner-cloud.de; keydata=
 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
 wySmewx3h/yfMh0aFxHhvLPxrO2IEQ==
Subject: Re: [PATCH 1/1] net: tun: add XDP metadata support
In-Reply-To: <Z5wIZ2LAjz0wTWg5@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: marcus.wichelmann@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27535/Fri Jan 31 10:33:54 2025)

Am 31.01.25 um 00:16 schrieb Stanislav Fomichev:
> On 01/30, Marcus Wichelmann wrote:
>> Enable the support for bpf_xdp_adjust_meta for XDP buffers initialized
>> by the tun driver. This is useful to pass metadata from an XDP program
>> that's attached to a tap device to following XDP/TC programs.
>>
>> When used together with vhost_net, the batched XDP buffers were already
>> initialized with metadata support by the vhost_net driver, but the
>> metadata was not yet passed to the skb on XDP_PASS. So this also adds
>> the required skb_metadata_set calls.
> 
> Can you expand more on what kind of metadata is present with vhost_net
> and who fills it in? Is it virtio header stuff? I wonder how you
> want to consume it..

Hm, my commit message may have been a bit misleading.

I'm talking about regular support for the bpf_xdp_adjust_meta helper
function. This allows to reserve a metadata area that is useful to pass
any information from one XDP program to another one, for example when
using tail-calls.

Whether it can be used in an XDP program depends on how the xdp_buff
was initialized. Most net drivers initialize the xdp_buff in a way, that
allows bpf_xdp_adjust_meta to be used. In case of the tun driver, this is
not always the case.

There are two code paths in the tun driver that lead to a bpf_prog_run_xdp:

1. tun_build_skb, which is called by tun_get_user and is used when writing
    packets from userspace into the tap device. In this case, the xdp_buff
    created in tun_build_skb has no support for bpf_xdp_adjust_meta and calls
    of that helper function result in ENOTSUPP.

2. tun_xdp_one, which is called by tun_sendmsg which again is called by other
    drivers (e.g. vhost_net). When the TUN_MSG_PTR mode is used, another driver
    may pass a batch of xdp_buffs to the tun driver. In this case, that other
    driver is the one initializing the xdp_buff already. And in the case of
    vhost_net,  it already initializes the buffer with metadata support (see
    xdp_prepare_buff call).
    See 043d222f93ab ("tuntap: accept an array of XDP buffs through sendmsg()")
    for details.

This patch enables metadata support for the first code path.

It also adds the missing skb_metadata_set calls for both code paths. This is
important when the attached XDP program returns with XDP_PASS, because then
the code continues with creating an skb and that skb should be aware of the
metadata area's size. At a later stage, a TC program, for example, can then
access the metadata again using __sk_buff->data_meta.

So I'm doing not much new here but am rather enabling a feature that is
supported by other drivers already.

> Can you also add a selftest to use this new functionality?

Of course, I'll see what I can do.

>> Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
>> ---
>>   drivers/net/tun.c | 23 ++++++++++++++++++-----
>>   1 file changed, 18 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index e816aaba8..d3cfea40a 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -1600,7 +1600,8 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
>>   
>>   static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
>>   				       struct page_frag *alloc_frag, char *buf,
>> -				       int buflen, int len, int pad)
>> +				       int buflen, int len, int pad,
>> +				       int metasize)
>>   {
>>   	struct sk_buff *skb = build_skb(buf, buflen);
>>   
>> @@ -1609,6 +1610,8 @@ static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
>>   
>>   	skb_reserve(skb, pad);
>>   	skb_put(skb, len);
>> +	if (metasize)
>> +		skb_metadata_set(skb, metasize);
>>   	skb_set_owner_w(skb, tfile->socket.sk);
>>   
>>   	get_page(alloc_frag->page);
>> @@ -1668,6 +1671,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>>   	char *buf;
>>   	size_t copied;
>>   	int pad = TUN_RX_PAD;
>> +	int metasize = 0;
>>   	int err = 0;
>>   
>>   	rcu_read_lock();
>> @@ -1695,7 +1699,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>>   	if (hdr->gso_type || !xdp_prog) {
>>   		*skb_xdp = 1;
>>   		return __tun_build_skb(tfile, alloc_frag, buf, buflen, len,
>> -				       pad);
>> +				       pad, metasize);
>>   	}
>>   
>>   	*skb_xdp = 0;
>> @@ -1709,7 +1713,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>>   		u32 act;
>>   
>>   		xdp_init_buff(&xdp, buflen, &tfile->xdp_rxq);
>> -		xdp_prepare_buff(&xdp, buf, pad, len, false);
>> +		xdp_prepare_buff(&xdp, buf, pad, len, true);
>>   
>>   		act = bpf_prog_run_xdp(xdp_prog, &xdp);
>>   		if (act == XDP_REDIRECT || act == XDP_TX) {
>> @@ -1730,12 +1734,16 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>>   
>>   		pad = xdp.data - xdp.data_hard_start;
>>   		len = xdp.data_end - xdp.data;
>> +
>> +		metasize = xdp.data - xdp.data_meta;
> 
> [..]
> 
>> +		metasize = metasize > 0 ? metasize : 0;
> 
> Why is this part needed?

When an xdp_buff was initialized withouth metadata support (meta_valid
argument of xdp_prepare_buff is false), then data_meta == data + 1.
So this check makes sure that metadata was supported for the given xdp_buff
and metasize is not -1 (data - data_meta).

But you have a good point here: Because we have control over the
initialization of xdp_buff in the tun_build_skb function (first code path),
we know, that metadata is always supported for that buffer and metasize
is never < 0. So this check is redundant and I'll remove it.

But in the tun_xdp_one function (second code path), I'd prefer to keep that
check, as the xdp_buff is externally passed to tun_sendmsg and the tun driver
should probably not make assumptions about the metadata support of buffers
created by other drivers (e.g. vhost_net).

Thank you for taking a look, I hope things are more clear now.

Marcus

