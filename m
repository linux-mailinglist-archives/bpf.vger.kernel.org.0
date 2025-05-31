Return-Path: <bpf+bounces-59408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DB5AC9A25
	for <lists+bpf@lfdr.de>; Sat, 31 May 2025 10:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD8D37A8273
	for <lists+bpf@lfdr.de>; Sat, 31 May 2025 08:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EE5BE5E;
	Sat, 31 May 2025 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfGgbmJX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B16F20F081;
	Sat, 31 May 2025 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748681528; cv=none; b=fB8NVB7wjKfDRAf7imm7S/RP+z/BOb4w7EScoe2v+4eBvVt5NIW1qDgvxF3B0Ke7lwcRhTIZTHszaa7SMznCEAnkr+WL0te99ZKaaaN0NP/uiB+xb6SDIsBPvEiB76j14baH/okzaT91yL7Galvc8tvAOX6k/WD2/DHQlum+8dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748681528; c=relaxed/simple;
	bh=REe60zlbqeu01BOJVePubuQZLx8kofDHdn8NxkEDkks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vblc3wbrUEjjHjqzV0r1WzwN+Y04r5kHgA7p1rpgEGfALyDD48/6jV5Myyh12mZ2vckt07UartyglysDrMVQ9vsSW/SIDfUHdTRTLkMvzULWzmcviqeaybNt3KzaEZ+JAhDBiMBENdYcXg7EORI2DSuOecixdJpJe8UnhPo9vwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfGgbmJX; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-747abb3cd0bso2271810b3a.1;
        Sat, 31 May 2025 01:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748681526; x=1749286326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=REe60zlbqeu01BOJVePubuQZLx8kofDHdn8NxkEDkks=;
        b=OfGgbmJXuMm78Aj4iSx6+p9leW+M+/20Imo7fyu9h5grrRJQGMyvrSu27mzEPEeJvI
         VaC1+o3Yxu8JAA3GK2DDXcAC7Yb6NsvikX+krkuFi1a/vmXs4U0YlOJhO2z2vjVbIOtk
         DBTpCMqE+DzNIWOYC5/5whoK5SFkcFuYDZVqYCwbpw6Yce1WJpG6o+verNUaXTE9nz33
         3ShA0cfM4XqNyKbAC7cJc9tFPA8O90kT0tXoclQkFSH9XTEFFpWnnwDYV0ag78gYQ5BS
         EghIYqx7y+J8dNBj4bRTlH+PxXMlACtzn/KOXBOvBqsL37JmlvyGHTpyo7vhSlu1xyLw
         gP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748681526; x=1749286326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=REe60zlbqeu01BOJVePubuQZLx8kofDHdn8NxkEDkks=;
        b=iJvlp402iaAbL+80dN4DcdB+Zh3EA2A7KQP6lFqqkBClhqWG85/whBGgexqyrp4Br4
         I5Ndy6EpkxAFI9IpQauggCUdoetyb6JTIMxVbJJDQhdbv1vu4/bbquDf04ST8pby2rXu
         6fy8PrjyjD+qGDWc1jZ+Efr1ASkNiDa3FIWAsasj+fSyUSynePvKoHWDTEx5S4zt+jyF
         VkqWoUp+WYC5zePNVQgedWVGroXUIL8c8anLEx/KjOWMH5XKoFG1RRwqEOjbH2/qbmkZ
         Yv1MQzKNoUsjXwbtkcGD3WsDrQZSAoX3T3gZNcTcyJPnwcLk1Q9lAZ0usa89I+byuMQm
         D0mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKpWehzOVBvFXctH/1P+wU/oTGWz52v2QNhdR7ecT3uwlmo4kEC1x4JLju7JilWP9yYY8=@vger.kernel.org, AJvYcCVsgL/LP2e6Cj3eaKEo8IEBOMirbOgg/hkkpLk3S8RoZqhYyLUpHJZ+2uMxao3ZkMrvQnn9Vbhe0/4MYoRJ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt73fvdcFU73J7YW2qQwRucRFBBSaDAyrFmcGdBj5jT/PHitHR
	PWbnHGZzVBPu76pVrDOXVGQzalCrYk5LotzbgKQEb/cT6bIgTah96JYH
X-Gm-Gg: ASbGnctsX+3POIXwDxLtWP552ax8BTj54CDhc7DvUVvLNCU8LLRxvZCu33WYUOptsq8
	YOSXBx5Z6bc3nC5XmKM8HbEEmaLqUOtqZlJt+qUzXKDMbt+HWG3yX2IWGsj4Eu2UCNUr5VfKGmL
	k3X7ekkl9D0J8ZLF1f2dlNi20f/gU4tPXE9YdYm0BJIp27FMM4P3J4ygpj5+f2mNe+0tVhDIHd2
	tuWJWAHnBiHWf1MFJqLEtsviMkLwOwazJyaPL3x5Md9K75ZwGnEh/JSc9qPgq8EDL+zXOrHFXtV
	SfNCqz09hDLr33FhP4b2841CeelhenzPYsc5g011PnbH7xMAv+RfR3KTtkS2tSMjrkvR3ObDbE4
	t721rVXI9FZ4JmH8/+y03nqGG/AThdzbwYDcnZslb
X-Google-Smtp-Source: AGHT+IFrK8g6/dGJ+qH8DK2puY7/mPl63dYSmPTZk3WE+0FNPHkZ94c11mvWpcO4rQ5k5aBxw+s1VQ==
X-Received: by 2002:a17:903:1a0b:b0:234:71c1:d34f with SMTP id d9443c01a7336-234f67a7c06mr152428215ad.8.1748681525735;
        Sat, 31 May 2025 01:52:05 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:af83:9564:6a79:4f18? ([2001:ee0:4f0e:fb30:af83:9564:6a79:4f18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd362fsm39298485ad.116.2025.05.31.01.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 May 2025 01:52:05 -0700 (PDT)
Message-ID: <ef4ac528-3f91-4004-b47b-e758a5712d28@gmail.com>
Date: Sat, 31 May 2025 15:51:57 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v2 2/2] selftests: net: add XDP socket tests
 for virtio-net
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250527161904.75259-1-minhquangbui99@gmail.com>
 <20250527161904.75259-3-minhquangbui99@gmail.com> <aDhCfxHo3M5dxlpH@boxer>
 <fe162eed-fd44-4c18-a541-8243ccfc4252@gmail.com> <aDmaT1cmoRa6PaqK@boxer>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <aDmaT1cmoRa6PaqK@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/30/25 18:45, Maciej Fijalkowski wrote:
> On Thu, May 29, 2025 at 09:29:14PM +0700, Bui Quang Minh wrote:
>> On 5/29/25 18:18, Maciej Fijalkowski wrote:
>>> On Tue, May 27, 2025 at 11:19:04PM +0700, Bui Quang Minh wrote:
>>>> This adds a test to test the virtio-net rx when there is a XDP socket
>>>> bound to it. There are tests for both copy mode and zerocopy mode, both
>>>> cases when XDP program returns XDP_PASS and XDP_REDIRECT to a XDP socket.
>>>>
>>>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>>> Hi Bui,
>>>
>>> have you considered adjusting xskxceiver for your needs? If yes and you
>>> decided to go with another test app then what were the issues around it?
>>>
>>> This is yet another approach for xsk testing where we already have a
>>> test framework.
>> Hi,
>>
>> I haven't tried much hard to adapt xskxceiver. I did have a look at
>> xskxceiver but I felt the supported topology is not suitable for my need. To
>> test the receiving side in virtio-net, I use Qemu to set up virtio-net in
>> the guest and vhost-net in the host side. The sending side is in the host
>> and the receiving is in the guest so I can't figure out how to do that with
>> xskxceiver.
> I see - couldn't the python side be executing xdpsock then instead of your
> own app?

I'm not aware of xdpsock. Could you give the path to that file?

> I wouldn't like to end up with several xsk tools for testing data path on
> different environments.

