Return-Path: <bpf+bounces-59506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 762DCACC8ED
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 16:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD283A7992
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 14:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC748239562;
	Tue,  3 Jun 2025 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dITUHu60"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DF52745E;
	Tue,  3 Jun 2025 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748960343; cv=none; b=NO9lwd86dxKkqd9mC3Ucx42FIPHpxjCp0LzgPzyKbNvMr7EYl21O15iyqj9LZfYquBJUunOkIVT3jsadODfZMa6FEJ0r7M+fuqe9MqsbNckN63eUf6qJ32UuGhTV5hkg8frjjzioCcy+wCC7l/GowczKIEuxYrjGbeiqA+4M6KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748960343; c=relaxed/simple;
	bh=YTMw6hVIJ4tac7hSIaKesh8CBYHWVGFRHULIjD0JYGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ms3yf3e7nZo4WG0WNhdZb/0daXWuAgOe4EA4AIjwqZz6vYXxN5swGelD0jt1+2BvN/YU/UvPIN85hb45nzO7up4No8QTz1msDxs3vY0zSBl8EeBQPd2BNOjkXESRm7U8QkbNWXiCkoJ/qDjzf8a5EDEW4bBT/iNXn71Iy7+QzCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dITUHu60; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-312b0d83a10so2005953a91.0;
        Tue, 03 Jun 2025 07:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748960341; x=1749565141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2GiI1DpFumaOXkG4kd/ldNkXDNVlluff0coHT3pCkZ4=;
        b=dITUHu60229YOarjMVdidOth43jeDYVesniMGVELsH+qDf758GllvfEoG/8viwgpbb
         Lw6+PYaGCZIX7lv3nt/yKeqGs+G8h78irkbslbc4ofyWpmOrhJOMjCcwEgKHOW4RdNgJ
         utQrwSBOK4HYSD+kf0O8GacEqM9oe8bjj58L6JnAWd78sspG32ffrDIBqkVq48VZm7yr
         5qqzRp/s44kauNbaCmqmZYvQN82W1m7S9dTgNVrX8p5+mc5OkbKF/+JKP5UOQoCHGHL+
         1yA/zz4Ss4Ny9ExugYWbeWHyScLNUgw2AAj93j8JRnVcjjFezxSrLmOoqeEx/F5sOzBq
         fhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748960341; x=1749565141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2GiI1DpFumaOXkG4kd/ldNkXDNVlluff0coHT3pCkZ4=;
        b=FvbUbOlMwdoB+6vsiAO2SF/F520j2magf2WSSk7zzPeyL3zsWhVFSiFw/HW3Q6cofF
         kJUr1kabQIwPnMr3t2I3NSbI1jVyaXnrHLQ3Be/qQWUbWHA1pJwgjVzGMrnrKN3CHFoi
         cYZMnogbmNazaZyVaPR8RJQc6bGVOYrtJPmHagOqm5125vqQygkBuuTIFPUBXrQ8SUHv
         qS59SSsTvCHbG1dOj3vEjbyxgzM2eCYjBX7TBdQjwiiNEZkiFFJ/j2z2TzuVpiLSwXGv
         goYxKJn7Cpu5+b+eu4KMeL2U6G5ZTOrn7MoDkoHtbn4R8KzgMKvWimqNlfwBLuYlaA7v
         /2Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVZJlyFpmu9XVDVnDbJZuD+t1XiAlExF9cv9ESKasC0iOk7wMA8jgMW2MsOGBj0+yghIR8QzK++6WwFg+dB@vger.kernel.org, AJvYcCVbpbPtwgodeC4ZqH18Xlzb4erZGbJLWEcBuVfj4nK1aRzOXu63S7nuA0jHxywvcyeTGsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz066e0OjesEqEVZHTynmkeP7xBRGXZ4mfBv0L7frQn8Fe5YWoE
	Ks6rWfU8DBErrrK5Vzk5RSIpwyw9U1fhvS3sgeRypQIUYx5mV2YpgsK1
X-Gm-Gg: ASbGnct0WdqbuQ+/1dA7Bmep5Hy2RvINDCO1R46GctIfwu0+26oyGtcbT8Y7R+R4K7/
	1bd/Pqi6x1BJFoM78fshj4XORsdu7yopY5V76W2DBy5n9GHClAQKpkcc3yO8p1Qr0w+xbiHSycw
	pmd4+lkLi41T48GcCAYICmkC54K7FezLkVimpUjC0Rkpbmh/kejj4W64kCrZM1SWbVwcuUzWhT8
	Q8tDHw4BhZgIwk4MTzDLhymKCG0J9bSNbGmlmeEZj1MMRjlIXadV87WyurfIPUavYwPiKN3l9zJ
	L7vrTJNXuh4q/qUV8l9DCcBZfK8UZFSSx9tWri8x4hd6/HTXqWo6cFpG7tEI7NaimvuGNR+lobo
	Jq7dvpH+gXq96Ot0MCW+6w1w1hDLVpbVG3vvGTnaz
X-Google-Smtp-Source: AGHT+IHYn7hiu2Jk3QqyG7TaSkPhOS5JI0kLYniE4Gj2hpCCxy1DnFsfHd9qOhBb9winlm+9+7HBEw==
X-Received: by 2002:a17:90b:2251:b0:311:d05c:947 with SMTP id 98e67ed59e1d1-3125044928bmr25109627a91.24.1748960340534;
        Tue, 03 Jun 2025 07:19:00 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:c672:ef11:a97b:5717? ([2001:ee0:4f0e:fb30:c672:ef11:a97b:5717])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-312db8eb19asm2158390a91.44.2025.06.03.07.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 07:19:00 -0700 (PDT)
Message-ID: <5c6323fc-e147-457a-98ae-df1d1fa7cd7e@gmail.com>
Date: Tue, 3 Jun 2025 21:18:51 +0700
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
 <ef4ac528-3f91-4004-b47b-e758a5712d28@gmail.com> <aD3JjgW2oxdal5lE@boxer>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <aD3JjgW2oxdal5lE@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/2/25 22:55, Maciej Fijalkowski wrote:
> On Sat, May 31, 2025 at 03:51:57PM +0700, Bui Quang Minh wrote:
>> On 5/30/25 18:45, Maciej Fijalkowski wrote:
>>> On Thu, May 29, 2025 at 09:29:14PM +0700, Bui Quang Minh wrote:
>>>> On 5/29/25 18:18, Maciej Fijalkowski wrote:
>>>>> On Tue, May 27, 2025 at 11:19:04PM +0700, Bui Quang Minh wrote:
>>>>>> This adds a test to test the virtio-net rx when there is a XDP socket
>>>>>> bound to it. There are tests for both copy mode and zerocopy mode, both
>>>>>> cases when XDP program returns XDP_PASS and XDP_REDIRECT to a XDP socket.
>>>>>>
>>>>>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>>>>> Hi Bui,
>>>>>
>>>>> have you considered adjusting xskxceiver for your needs? If yes and you
>>>>> decided to go with another test app then what were the issues around it?
>>>>>
>>>>> This is yet another approach for xsk testing where we already have a
>>>>> test framework.
>>>> Hi,
>>>>
>>>> I haven't tried much hard to adapt xskxceiver. I did have a look at
>>>> xskxceiver but I felt the supported topology is not suitable for my need. To
>>>> test the receiving side in virtio-net, I use Qemu to set up virtio-net in
>>>> the guest and vhost-net in the host side. The sending side is in the host
>>>> and the receiving is in the guest so I can't figure out how to do that with
>>>> xskxceiver.
>>> I see - couldn't the python side be executing xdpsock then instead of your
>>> own app?
>> I'm not aware of xdpsock. Could you give the path to that file?
> https://github.com/xdp-project/bpf-examples/tree/main/AF_XDP-example
>
> this is our go-to app side of AF_XDP.

Thanks, I'll take a look at it and try to use it for selftest if 
possible in next version.

Quang Minh.

