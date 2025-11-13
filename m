Return-Path: <bpf+bounces-74367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB18C57139
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 12:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBC784EA767
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 11:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203D53376BC;
	Thu, 13 Nov 2025 10:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ3gJ3CK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D28D2FE582
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 10:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031590; cv=none; b=EqeyPAHpQ5VMToDDJFrJdnyBqito5fwJ4+8vsYYKDkO0xiQB7/T8zS7vNm3J85jJTo8GlLSL0uqIOfFrBkXFsCtzn2Ekuu/JPpwX0nG/YzCTk4ftzio639TKtpUP00+JhGxvwmrGpgCcxmdnpgXIliBv9VNYQXV2Ut3vJOfMLF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031590; c=relaxed/simple;
	bh=ugZFlfc+l2S+0zWCSf1PxybsJPWJGmiF5NzWiKPgTzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o6+stalsECuk2D60NRB7R8nL7JwrRZSbzKXXcdoxsy3DTXsd+kc52yUk2bjJCbyUVxzkJekXqBP22XYzcroCoRDsmY8aTKvg3HAcePLSzR/pGBYoyi6Wh7waYPq9ZMhs2iafYNoQQ/mUx/2bNkV10GC3/iO2foMOD567jp0baPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQ3gJ3CK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4711810948aso4608055e9.2
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 02:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763031586; x=1763636386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DEJC7gRTebDUaxwAOnQ9BV9gIzheu37nMO4ePUyMYEM=;
        b=iQ3gJ3CK+EvoGocot/Chl1ETCyQHG6GXKwpS32/w52vYJtH8PF+c+cxZV/V6Y1PWxe
         qQBxxItLa7wBBe1zZ9JtuCwAePN8hF0IEfGpf7mwgZHswAUr5F5z5W2+oHO8d/5u8Kqn
         ZcpzG3QzVsMaDloGTcuam0H7i2Vx7Tf3pNPAOErn3+NNfXOeDcu5CkOla0vCNq6j0eRq
         kb7ALrEYpAPxkYAqzmZhzie7mwW91sUlFc0t5W5GEqiI2Wu+s3s92KmvLriUjGRIAv08
         Sp/gVpLYzBsC4LCG1dy2lrfz5a117+bAMyb8ZQCcKJw3j3+ZsX69A4qprDhlEiWVh4NE
         qEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763031586; x=1763636386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DEJC7gRTebDUaxwAOnQ9BV9gIzheu37nMO4ePUyMYEM=;
        b=fPtOEah/9mtxNwlF8ldfDJcZKNMif7N94WzU4ryKNYFEMYQ5/VWNl6w7Zwt+oj8C8P
         VvN3C2pF28gpUvyAA7pyeJuWS0EWAauspqe+LM6NPENUWlDpvLfmOsU23a7ntz+ikW2N
         F5UAAWtnBz+iZ3YPWHM42Jj/JQYoxAH/EGm/+NvRaE7ld2Rt+VvlFONXE5sQvXUGz0n3
         TFtIXCE7IA1pcS7k8clhOCDDlnQ8kIivkDsGifLWDyABv8jZkPHW/VjameuCw7Av6LTX
         Z3Iu7nbABoO5AXMIsVlcF2iMVPKZBrhchfIpNuBNiMjRlbQL4Qr/Hwb9qruAIejehmT6
         OPtg==
X-Forwarded-Encrypted: i=1; AJvYcCUPIFebiDasj2e1XKnPJNe/6a3mt5TaJc02RmyEs/HAlLEgs27dUhzGd0sbVBxrS+UruJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm5etJ+uT48oCeOlfaD7IV5dzWUPKQPRgStStIt2Thy8AtrTv/
	0AzvkukoyzKVFr7QXYZk7FLcVMSbsR4/7EmfKeg7CNDtj/ri8jBuifBD
X-Gm-Gg: ASbGncv+PDCRd5x0P3FOeknKdfm8dQVU0dEL0xY+Njg56LelXJ8XSWd/T8c58L9+zxv
	sloOuyBQBJqbZMhkCKmJYMBXo9v1tGQQ+VQw7waYquhhsOAFU9lXOkdwLNPC031YIVCKd43Wszw
	Klnh9uk7P2r48i4DUgObhEZzvQ/BS94yv8TOpwS3spoW/mVcorMYObwfmPZaOEs6Kcj2oGka0e9
	lfW31j+Xzf21ebj+aIfA+26s6XCWAM6KYsZaV3+7NeHpMkypqH1npayW4GCvNFiTycDFXyDdNBG
	VT11ltxQDDo5y0hX0x7YVihWGSiJxews35a0X9PpVnW9EudubD6QUf2boP9PRqtSQGWNI761yux
	ctbQib6BePc4IBP/cR3H9dwNU4nesS3renhz+yIgNSFNKyNlfmfFmEzciBmks98hGQPa+HdFZCP
	4KIHa1uPH7ilhJnMaG1Eub
X-Google-Smtp-Source: AGHT+IFCpVKEMNGa1TiGFz1du/mkrAjFihX7xaQjFh0qLSpjr6GgH+cPEzn+8D8uBc5acStTR7O0cA==
X-Received: by 2002:a05:600c:4694:b0:477:7f4a:44ae with SMTP id 5b1f17b1804b1-477870bf2fdmr57386475e9.39.1763031586191;
        Thu, 13 Nov 2025 02:59:46 -0800 (PST)
Received: from [10.158.36.109] ([72.25.96.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b513sm3255195f8f.30.2025.11.13.02.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 02:59:45 -0800 (PST)
Message-ID: <60c0b805-92e9-48c0-a4dc-5ea071728b3d@gmail.com>
Date: Thu, 13 Nov 2025 12:59:43 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/6] net/mlx5e: Speedup channel configuration
 operations
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 William Tu <witu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Nimrod Oren <noren@nvidia.com>, Alex Lazar <alazar@nvidia.com>
References: <1762939749-1165658-1-git-send-email-tariqt@nvidia.com>
 <874iqzldvq.fsf@toke.dk> <89e33ec4-051d-4ca5-8fcd-f500362dee91@gmail.com>
 <87ms4rjjm0.fsf@toke.dk>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <87ms4rjjm0.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/11/2025 18:33, Toke Høiland-Jørgensen wrote:
> Tariq Toukan <ttoukan.linux@gmail.com> writes:
> 
>> On 12/11/2025 12:54, Toke Høiland-Jørgensen wrote:
>>> Tariq Toukan <tariqt@nvidia.com> writes:
>>>
>>>> Hi,
>>>>
>>>> This series significantly improves the latency of channel configuration
>>>> operations, like interface up (create channels), interface down (destroy
>>>> channels), and channels reconfiguration (create new set, destroy old
>>>> one).
>>>
>>> On the topic of improving ifup/ifdown times, I noticed at some point
>>> that mlx5 will call synchronize_net() once for every queue when they are
>>> deactivated (in mlx5e_deactivate_txqsq()). Have you considered changing
>>> that to amortise the sync latency over the full interface bringdown? :)
>>>
>>> -Toke
>>>
>>>
>>
>> Correct!
>> This can be improved and I actually have WIP patches for this, as I'm
>> revisiting this code area recently.
> 
> Excellent! We ran into some issues with this a while back, so would be
> great to see this improved.
> 
> -Toke
> 

Can you elaborate on the test case and issues encountered?
To make sure I'm addressing them.

