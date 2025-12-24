Return-Path: <bpf+bounces-77420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81027CDCE1A
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 17:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B76273010E57
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 16:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35063271E5;
	Wed, 24 Dec 2025 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cz/La5V0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B2A1FC7FB
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766595009; cv=none; b=Yz4smiFRlSMQW8fKbH/EORWoYx3RrxTj+y3glXmFrB9xRUZvS087ikFW1Tkk0FJJ62Zen82dnRd8N1M2nWnVus6JtlV8N0ba81iv5+lFd0QHgE/RHuMdMkMXVSFcwAQZGfJXta00/XNT6pbTy1lIo/RLjGz9XA1TOONhdaxcuaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766595009; c=relaxed/simple;
	bh=pD8YfDZ8KDvIJ2txTMDBnlCOh6vlZTyz6vhh+e8d2W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uePpeaSjSneWguKg5MuSwXaLNptdRQZaAbaBvKuozfeubt0Rajg8bMdzXIKItbflj6wmN2W0oVlVrxStB4xT8FaRFYEaw7YwR+PNjE3gsblY2mBhcHmH3qNO7Tv6UbX2hhGxwUrAB1cJYNHmZvd3TuORMwgNm9RttWsl74F5WUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cz/La5V0; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34abc7da414so5138818a91.0
        for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 08:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766595007; x=1767199807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cnHqqpgJDbRv/a/D7gH1Mi4jXPMVJ5IBYITwv6FaifY=;
        b=Cz/La5V0IS2jWtSCTwPYxgGBPlIImyTU9hHDxzRUyWE1/AJ/Pk6VX4L4ax9ougmTOR
         +p8VEFCGM7DOpz87af4RVWlfK1yGgk5gYvV8PwH6QiIsNkHMrzz9DKWrBhrN+CAUCOpA
         GlZo4OWn/VooTBqxdjgnvdDngpOtQz5B0cFu5roID5Bv6kryrpdz8+lFHoMm0WNtwv7m
         4BGRgmneL04o967UkndgtTxfR42ft38hqPptGy1iK5D1CrxOzjbnxsoyumGG7wfuqgRA
         3JGMADqeb5k0pvl5PYG/FZDoPTI4fhbB9xyjvi15kkli/21w9Bph6F3LZmm44KDgqlV1
         QbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766595007; x=1767199807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnHqqpgJDbRv/a/D7gH1Mi4jXPMVJ5IBYITwv6FaifY=;
        b=mI6DP8DrD7mi9jQSjcrwu5SnorlRwK+IytsOry/Q/pYP4TAgbfbGX8Ys7UZWO+KEyH
         1DToscWcDvq1ycVl7Mx1YmplDAYI6u+2k+or9Yb4ue5az+2yyKJaZRI1ft7DdJyV5XvJ
         IbLl+oTObNcwfZCR4TMKgRrOaxVJQPxIXUTyHAQiFhgm0cYC/TdvsOryyO/zhmlG9YX+
         2fpCLlpTY5354qurKzsdi/YUvAzRHs2RzbdH8RBmmT4S4POb6/Ak01zVilMU2q23kTaJ
         A+qUqe5v/1jnI62EfEWpOAiOTxiO6T9na3QXll964qWsizZC6JVqhtH+q/jhcYMAvVGP
         SiCw==
X-Forwarded-Encrypted: i=1; AJvYcCWZV+8n6Gg36FCnpgHBVcYHouyINeiwYebIcuJDH0K2cphUkoXWFTBo2gl5/g6rl8IrZl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXVXv2u5lClhGumx5A/w+vXEbllpnnFpY4tZIZBhAlqIKHzA3f
	91BW8NZPPK2w1G/XQLHFqMRFfQ/bFK33NUW8OKGvTN30djkoZ1CwD3U0
X-Gm-Gg: AY/fxX7VHeOqyB8lzArdbPAzkSyprpyQnkGUNw+DyjU6gwfrZYRRYEy0IYaVLY6KiM/
	ZibWAre9PwnOdmcZ0vQLmGj01tPrvPyuYp6VZh3h/INRXifjetvy1jwVcSN0XV4AoJNKCy1Sbjx
	nkFWQqQDmBnWFY6E0V66OxmSFpbKCJJdvgSZKL+1kyPvbtmOy3QWZm7VgtZerF3oHdyAQjJ7tmA
	T8P8Uf5DAyz0cgmDSx6LNYuisMZcdv+pWnXDCBq7suLTUWGzPknjiFGInwv+H83vb5mn2UTBTZe
	XCxqqPe7YcRAm9Qrtxt7Q9Z5hfIhP7bohK3rVkwg7XPGD8HZEdTGvE5LU24n6PmBN9Pm9kW9qjY
	7Rxsd979+RNuNnxF8EZW0X30v28D5WF9FJ/bCEn1TMIuW9YzCVVg7DoWBX7T6WmZTgZGME81hPg
	eLQAg3T9B9wBOgB0P1SIJTwB7kLwkvPExruU1h+nt0n8Br6JgRyBTdo2twB5td20zudC7LOQ==
X-Google-Smtp-Source: AGHT+IFbzQ7yMQch0JLVgEhdJ9FTN364+UnyPdio+VpjXb21RfQOByyL0xWkrHKOy6iC60/tY4/H+A==
X-Received: by 2002:a17:90b:580e:b0:340:d511:e164 with SMTP id 98e67ed59e1d1-34e921ae4camr14319741a91.19.1766595007324;
        Wed, 24 Dec 2025 08:50:07 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:c711:242:cd10:6c98? ([2001:ee0:4f4c:210:c711:242:cd10:6c98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48f26asm17027776b3a.52.2025.12.24.08.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Dec 2025 08:50:05 -0800 (PST)
Message-ID: <75e32d60-51b1-4c46-bd43-d17af7440e74@gmail.com>
Date: Wed, 24 Dec 2025 23:49:59 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue
 work
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
 <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com>
 <20251223204555-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20251223204555-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 08:47, Michael S. Tsirkin wrote:
> On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
>> Hi Jason,
>>
>> I'm wondering why we even need this refill work. Why not simply let NAPI retry
>> the refill on its next run if the refill fails? That would seem much simpler.
>> This refill work complicates maintenance and often introduces a lot of
>> concurrency issues and races.
>>
>> Thanks.
> refill work can refill from GFP_KERNEL, napi only from ATOMIC.
>
> And if GFP_ATOMIC failed, aggressively retrying might not be a great idea.
>
> Not saying refill work is a great hack, but that is the reason for it.

In case no allocated received buffer and NAPI refill fails, the host 
will not send any packets. If there is no busy polling loop either, the 
RX will be stuck. That's also the reason why we need refill work. Is it 
correct?

Thanks,
Quang Minh.



