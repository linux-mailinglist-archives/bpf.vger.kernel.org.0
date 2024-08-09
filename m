Return-Path: <bpf+bounces-36802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF3594D8AB
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 00:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839A61C2287A
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 22:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399BC16B3AB;
	Fri,  9 Aug 2024 22:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aD+YBh+d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FED01684BA
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 22:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723241849; cv=none; b=Zvjyu+Ll1G8fdehJ3DFExG7Gn5lgvWcS9ZR4ylOMZHjZMlaQwMWkaUFJv3Mda/3l8N0sxnwktekuncCiwe0f7KHsEhLbRApf7s4tnpzAjE6O9mHWqsYpZa312w0F7ErAemMHZE/bgdtEoVHLqElIeZCN+M/zOfeVgEpRO1rD0Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723241849; c=relaxed/simple;
	bh=IkI9GJng3SPoqG0cbJlLuvKkdUA0vhJ3h3IFiOlPhQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gs2K+qr/pKnFiSoDrKNi5pyyRMp3GegQMiC/kWfLjKaIXZV/CCd/NB+GMWdUW8UMGcKRuVuk8F/7T54IHw8VDg61JXG/44RBfRuqasViv4GRAVUlOnB1K8m2JX0ImQUT54O/R8CfMaUGl7GeL+TBHyJjDwUf40pm8/jUetaCBWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aD+YBh+d; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3db157cb959so1715346b6e.0
        for <bpf@vger.kernel.org>; Fri, 09 Aug 2024 15:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723241847; x=1723846647; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5kEy5ImbuRfG3E8dfn7QOP7C4wiO9nk+hec1rC2Q+Qs=;
        b=aD+YBh+dUf+LkkLQ+7nH0pJDRuxl0K5qCudeK8KIpxH+CWJYiYLcji48dsnnJPugk8
         jeuu/O4cI8nhy4T99UEgXv1uP0nhb01I0g+Bz0nDZhpbBPXq1GDpvXCuQ730yn/Vb5nJ
         Zjr40Sw5MXVwCla2arkH7jGPq8VbUpdjegbRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723241847; x=1723846647;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kEy5ImbuRfG3E8dfn7QOP7C4wiO9nk+hec1rC2Q+Qs=;
        b=CfZHzBtykBRtKpPqHzowEWgwWgL3GADl9sLcCF5Qb9D+tTCqlYXnYhOFxNx8BtZR9Y
         MrT5UUpQ9ra8xaPcklE6KFVS6Ze1fwghNfbwnnX5cN0+CHpnQVyRD7JCtBwjqrpqXkbm
         Q1KHDxsuTERY3okNlgW/AfYqCM/3alnp8Ozfj9lCzKcIOwBi6eLikF48LfD6Rl4PGhJq
         Hhwu/j+olBBZ47DkIu1pZ68MoPnPZQ9rjs0qbrqMkGP+bXdvW5Bcx0p3Jkzirtfxn/4n
         lTFwnkbI/dJLeXAKlJT47f1HQ7S4qJirBIXaZkbMnlOjS1XawoD4RjheQ7baLbKhqd1Q
         +Mgw==
X-Forwarded-Encrypted: i=1; AJvYcCWDCjBOghY8VHRzHMvhCW3fmdwfAlJr8mESYohoyrsq6zYoXaf7kKjszdbpocInYd0Z6sTTPQw4FvLQHFbVS2AtHlVn
X-Gm-Message-State: AOJu0YyR4L0zDQZEvhgAbD+pvkDN51HYYTddkjXljxeFcP0cTM3795D8
	mM04d2jHd4y8v+RpmPrxjp7LBM7qrlF15ZuX3CuY6RPrHb4VPTr9d7YPv/sJXg==
X-Google-Smtp-Source: AGHT+IEHyKJiarzqZbT6Jlx8LoLMCgKFUq9SysPXMLOAh8UnpD4dLPkM0uDHd0fLaLzI4KXr6ykujw==
X-Received: by 2002:a05:6870:3924:b0:25e:1610:9705 with SMTP id 586e51a60fabf-26c62c4296emr3318640fac.2.1723241847267;
        Fri, 09 Aug 2024 15:17:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e589e8e7sm237580b3a.45.2024.08.09.15.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 15:17:26 -0700 (PDT)
Message-ID: <2c4a42ee-164b-447f-b51d-07b2585345b3@broadcom.com>
Date: Fri, 9 Aug 2024 15:17:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] net: stmmac: Add PCI driver support for
 BCM8958x
To: Andrew Lunn <andrew@lunn.ch>,
 Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, richardcochran@gmail.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 linux@armlinux.org.uk, horms@kernel.org
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
 <20240802031822.1862030-4-jitendra.vegiraju@broadcom.com>
 <c2e2f11a-89d8-42fa-a655-972a4ab372da@lunn.ch>
 <CAMdnO-JBznFpExduwCAm929N73Z_p4S4_nzRaowL9SzseqC6LA@mail.gmail.com>
 <de5b4d42-c81d-4687-b244-073142e2967b@lunn.ch>
 <CAMdnO-+_2Fy=uNgGevtnL8PGPvKyWXPvYaxOJwKcUZj+nnfqYg@mail.gmail.com>
 <5ff4a297-bafd-4b33-aae1-5a983f49119a@lunn.ch>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <5ff4a297-bafd-4b33-aae1-5a983f49119a@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/9/24 13:12, Andrew Lunn wrote:
> On Thu, Aug 08, 2024 at 06:54:51PM -0700, Jitendra Vegiraju wrote:
>> On Tue, Aug 6, 2024 at 4:15 PM Andrew Lunn <andrew@lunn.ch> wrote:
>>>
>>> On Mon, Aug 05, 2024 at 05:56:43PM -0700, Jitendra Vegiraju wrote:
>>>> On Fri, Aug 2, 2024 at 4:08 PM Andrew Lunn <andrew@lunn.ch> wrote:
>>>>>
>>>>>> Management of integrated ethernet switch on this SoC is not handled by
>>>>>> the PCIe interface.
>>>>>
>>>>> MDIO? SPI? I2C?
>>>>>
>>>> The device uses SPI interface. The switch has internal ARM M7 for
>>>> controller firmware.
>>>
>>> Will there be a DSA driver sometime soon talking over SPI to the
>>> firmware?
>>>
>> Hi Andrew,
> 
> So the switch will be left in dumb switch everything to every port
> mode? Or it will be totally autonomous using the in build firmware?
> 
> What you cannot expect is we allow you to manage the switch from Linux
> using something other than an in kernel driver, probably DSA or pure
> switchdev.

This looks reasonable as an advice about to ideally fit within the 
existing Linux subsystems, however that is purely informational and it 
should not impair the review and acceptance of the stmmac drivers.

Doing otherwise, and rejecting the stmmac changes because now you and 
other reviewers/maintainers know how it gets used in the bigger picture 
means this is starting to be overreaching. Yes silicon vendor companies 
like to do all sorts of proprietary things for random reasons, I think 
we have worked together long enough on DSA that you know my beliefs on 
that aspect.

I think the stmmac changes along have their own merit, and I would 
seriously like to see a proper DSA or switchdev driver for the switching 
silicon that is being used, but I don't think we need to treat the 
latter as a prerequisite for merging the former.

Thanks!
-- 
Florian


