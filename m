Return-Path: <bpf+bounces-42006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C13399E474
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 12:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F8F61C21B43
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 10:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4BC1E633B;
	Tue, 15 Oct 2024 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="wn4XhrL9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7921D2B21
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989219; cv=none; b=cp87OvrPd4IWD7u1y6TxgqXBmwPmuMVAJ+Pe/16Q+sUj+1Bpd7xafklZ2YBx8g8Luj3FByrdQWI9BAGGmaEKfZkGxC0m20XnThwcuny/Udnpn+59a/ij4gmaFZ4ZmkoqyX1gUJ/v41evBZqnSDuBLKyPv5pQg/un+CA+lXqZT+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989219; c=relaxed/simple;
	bh=JbGYC94SBTd36kaLgYONpoB5/edTGqERj6FLvw8mhTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=grO/V34g4qpzI7ljeJUzY5IK16JRZqYou+f+4IH9h+046z45HHo8U0Q5I+bZpP9I7HNWWVWeQ+LXoTEDk/3lcKYY56AaUFH5grEjFelzTV0cV7VV4F2kxUsTWhAyQYd5ZpB7ntPDpsyyMDf1KIVZD7fux9tcBznvhXNvYvmkwkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=wn4XhrL9; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a0c7abaa6so287458666b.2
        for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 03:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728989215; x=1729594015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=520DfjHdYRRP2GFNU0/yY3BItKCuA8awUDQGTCRwXIQ=;
        b=wn4XhrL9MzyE5n8dTaoMUuLsz46qXnHMgX4rnDetwZT+LzGAqgdcMLGRlZYTcFsb7F
         f7n0i3JXxEpXuJrinPOqmgdNp3Xag33AnbACdsCIol1VBJZ9YdHN8SjPo85tJU++9ZtH
         qEVIgzDiwewMB7RERWGGplQAdE69GtQl1ppHyOUZ4/pnvs0OzcrMqKTP/8I2Ok7/IB13
         ES5I0NqwqVx+Nd2QWt5DMvUmqqNnvxmSnr38R40oY6cp2pe5kc5pHTqGNTWeElYcmhv3
         z9CDCr6kMnxRpd6kCGK3tSm+2AeNGb/T16GCVqfE8fc6KJLPLIjlx8rwM1HPAN0UZ5CL
         bu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728989215; x=1729594015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=520DfjHdYRRP2GFNU0/yY3BItKCuA8awUDQGTCRwXIQ=;
        b=UIjlcpM2vj2C0V1TXPkeztmItYOAtQpoBsCcttEghIGITtzDedquOMWFsKZ7ZVXxm8
         RzuV4ZPtn8zEBkYQcTAPo4jExGoPuBht7o8JRrcPd0aRcZ4ChkhP1pWlc3v/ppcVMYta
         NaaRdeFFgo5DCooAzCx4DL9u6kjDapiaQgGfXh9Vz5pWsOkIP9VI8kSQlVn9MkpQtjwd
         Dmfu/gH1742VxXzGgXZPfmJ5w6eOi74qd1V9XA+5VNtN+6bR1JrBb2AOA9pvv/DlhHq/
         Cj3EOEl7wwLcL30kxZoR/CKCKvJEkqy7CanSRomLma7zJYfbqdoAwIwFRpJwi0gE6vYD
         Wtzw==
X-Forwarded-Encrypted: i=1; AJvYcCVs3Rc0DCUEbpd7vYW2buIcFIlC5NtIg/6VlMLtokfFSOT7Exjo3Sb7G0GHEVQ62QFwSuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiYI0NluSPSVLAbf74m4MzuThAHcR4AyJXec+b8vL6DS29OJgG
	olRetYTnghpxTZCWU3cV49T9NB9s95TruvsrQLaKcs93KX8PBKfjtXnkiJZfIOQ=
X-Google-Smtp-Source: AGHT+IFD6hmt8hzEHRuoWoYB8e9k1HX3rhZ3I7fiMF/ztMLUUs26xHrhkT81z761RfYRJPnjMCr2Bg==
X-Received: by 2002:a17:907:2cc2:b0:a8d:439d:5c3c with SMTP id a640c23a62f3a-a99e3b20d62mr1070172866b.8.1728989215149;
        Tue, 15 Oct 2024 03:46:55 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29717303sm56424566b.7.2024.10.15.03.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 03:46:54 -0700 (PDT)
Message-ID: <8088f2a7-3ab1-4a1e-996d-c15703da13cc@blackwall.org>
Date: Tue, 15 Oct 2024 13:46:53 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bpf: xdp: fallback to SKB mode if DRV flag is absent.
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrii Nakryiko <andriin@fb.com>,
 Jussi Maki <joamaki@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Liang Li <liali@redhat.com>
References: <20241015033632.12120-1-liuhangbin@gmail.com>
 <8ef07e79-4812-4e02-a5d1-03a05726dd07@iogearbox.net>
 <2cdcad89-2677-4526-8ab5-3624d0300b7f@blackwall.org>
 <Zw5GNHSjgut12LEV@fedora>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <Zw5GNHSjgut12LEV@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/10/2024 13:38, Hangbin Liu wrote:
> On Tue, Oct 15, 2024 at 12:53:08PM +0300, Nikolay Aleksandrov wrote:
>> On 15/10/2024 11:17, Daniel Borkmann wrote:
>>> On 10/15/24 5:36 AM, Hangbin Liu wrote:
>>>> After commit c8a36f1945b2 ("bpf: xdp: Fix XDP mode when no mode flags
>>>> specified"), the mode is automatically set to XDP_MODE_DRV if the driver
>>>> implements the .ndo_bpf function. However, for drivers like bonding, which
>>>> only support native XDP for specific modes, this may result in an
>>>> "unsupported" response.
>>>>
>>>> In such cases, let's fall back to SKB mode if the user did not explicitly
>>>> request DRV mode.
>>>>
>>
>> So behaviour changed once, now it's changing again.. 
> 
> This should not be a behaviour change, it just follow the fallback rules.
> 

hm, what fallback rules? I see dev_xdp_attach() exits on many errors
with proper codes and extack messages, am I missing something, where's the
fallback?

>> IMO it's better to explicitly
>> error out and let the user decide how to resolve the situation. 
> 
> The user feels confused and reported a bug. Because cmd
> `ip link set bond0 xdp obj xdp_dummy.o section xdp` failed with "Operation
> not supported" in stead of fall back to xdpgeneral mode.
> 

Where's the nice extack msg then? :)

We can tell them what's going on, maybe they'll want to change the bonding mode
and still use this mode rather than falling back to another mode silently.
That was my point, fallback is not the only solution.

>> The above commit
>> is 4 years old, surely everyone is used to the behaviour by now. If you insist
>> to do auto-fallback, then at least I'd go with Daniel's suggestion and do it
>> in the bonding device. Maybe it can return -EFALLBACK, or some other way to
>> signal the caller and change the mode, but you assume that's what the user
>> would want, maybe it is and maybe it's not - that is why I'd prefer the
>> explicit error so conscious action can be taken to resolve the situation.
>>
>> That being said, I don't have a strong preference, just my few cents. :)
>>
>>>> Fixes: c8a36f1945b2 ("bpf: xdp: Fix XDP mode when no mode flags specified")
>>>> Reported-by: Liang Li <liali@redhat.com>
>>>> Closes: https://issues.redhat.com/browse/RHEL-62339
>>>
>>> nit: The link is not accessible to the public.
> 
> I made it public now.
> 
>>>
>>> Also, this breaks BPF CI with regards to existing bonding selftest :
>>>
>>>   https://github.com/kernel-patches/bpf/actions/runs/11340153361/job/31536275257
> 
> The following should fix the selftest error.
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 18d1314fa797..0c380558a25d 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -5705,7 +5705,7 @@ static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>                 if (dev_xdp_prog_count(slave_dev) > 0) {
>                         SLAVE_NL_ERR(dev, slave_dev, extack,
>                                      "Slave has XDP program loaded, please unload before enslaving");
> -                       err = -EOPNOTSUPP;
> +                       err = -EEXIST;
>                         goto err;
>                 }
> 
> But it doesn't solve the problem if the slave has xdp program loaded while
> using an unsupported bond mode, which will return too early.
> 
> If there is not other driver has this problem. I can try fix this on
> bonding side.
> 
> Thanks
> Hangbin


