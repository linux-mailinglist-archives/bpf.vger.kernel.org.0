Return-Path: <bpf+bounces-26309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 295F189E020
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 18:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7361F22196
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 16:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C5F13D8AF;
	Tue,  9 Apr 2024 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZEwP/ci"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5E84F883;
	Tue,  9 Apr 2024 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679312; cv=none; b=d1UXhMEAuBtb9gUspcswAjK909hfmlhKHjUCy1gPGh/IOzuEy6wcdB3nGx3m3NpoyJdZCLm+kzbPPjN87ght+JNCQptMPCRkesiWDpigpsqjTjdRZ8pg0gltFrgni+YdrNvANhuus3OQVXgheRa32cYfe15zBPUn8inXQY13VXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679312; c=relaxed/simple;
	bh=GctYHvPeKVpuxt2D+ZotCon7pgUXv3bhxrOGr4ni9qQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dAi81JnvflxMcf/MnFz+CD9qJwUnzFvDOpYkAegr2oW9kNBm6VccgickW2EACRfyOH5ZoISgFzFjYMSoG7j0QPMbMtR0avQwXyRedR4pGLdhhZ657Ma64UVB8kUG7TMsqlcYrxRG/pdp7D+tEvZvbVYcL65GKPgqh+ot04xVrtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZEwP/ci; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34560201517so715621f8f.1;
        Tue, 09 Apr 2024 09:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712679307; x=1713284107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=psn6Ri/4HxTIEa5og+2LF06wxFvUe/WNtpM1VRSHt8A=;
        b=DZEwP/ciuAbkYdKNcAidzt8tG70U2YKWnLb9necNhDJTvrLBo0zFf3yeOCb7oPZyr9
         pWqN5Yu/ON3k5bZ4eyPCb5m1pzILck1WaYIFr53BoMKusajf9GYqEGXw4ZFXL90OYgGf
         IDBx2zEB7KYbA9tSegUPDm/gNLRE3OQeyc5DORSNlOgY1FxqsJuJvZohXbUEjVwatiFz
         LBA+wR0Y2KzMcQjga3WlzTOlF9p1JgfErhD06511jD5jCB8vT7gJ/EDr2OWgVnzK1K15
         ZG0nS87DegbNquL6Z59sIxypjMdfTv0LRjSA/Bq7UEWNNVzJhD2B0Z/qQ1u2rK4u+tam
         MjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712679307; x=1713284107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=psn6Ri/4HxTIEa5og+2LF06wxFvUe/WNtpM1VRSHt8A=;
        b=bJiNczF0/QZWDStZasJL9YcovbG6x4g1QxydTZTPUiWxuaNSrRG/xjwZ6nxEONDrno
         /EHk7jTg5ZXbFrIhM01U8MuCou0BHUFzYBMpVLE2G20r+ThF5V0Dix34hJ6NwNHLUEft
         KdpUyPY62E8q3bGcpprmxI8U/84cRsccxRZK0RPJ+xQamZUmS7naw7Rkqz6fk2HF0Xla
         mMMqxsCTM/0pMP/N+CgjtlWlaS5TXnIuPjMJDzBTq8x/Tc9M2ovjq5l82ECcjTGpHCdf
         x1JW0H8jSeJNcGCkcHrrDzEuk8Ykvi6qf2qHsSgfG6DOZVmEFASWqFIlZ2kMPhnNaAgx
         HkTA==
X-Forwarded-Encrypted: i=1; AJvYcCWDjfVWSYgKMGUsfrV9IU/7vfOS8JKj3g5ecRLcbJpBiUo4XpsLnppUpgd/djOCwW5E5rEj6y709Qf01F/weP0VnsYwbtCnilavN+9qGSvYW9GnB0Odb1/9xWXZQcP9IHcOb33KirMNRgss53FauAjCO6mUr3rafVzu
X-Gm-Message-State: AOJu0Yy9+21339L+7puQrFE6iAmA65iFvVKl03WxRx19qvNhqXLXZJ7q
	qpCU8I8cHTRV5hska60vWZfbCQaPCvCk3nLzkrDeDq0JpuHWqmC1
X-Google-Smtp-Source: AGHT+IFasR5KHT/RfHFpUn+unrYHSNBNbApu2QweV2uZ+6XSihzXw0UAUe2Jc+88L4ogJ5/5cIBFtg==
X-Received: by 2002:adf:a347:0:b0:346:5051:1c6d with SMTP id d7-20020adfa347000000b0034650511c6dmr84719wrb.5.1712679307221;
        Tue, 09 Apr 2024 09:15:07 -0700 (PDT)
Received: from [10.0.0.4] ([37.170.252.166])
        by smtp.gmail.com with ESMTPSA id c18-20020adffb52000000b00346266b612csm1854185wrs.81.2024.04.09.09.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 09:15:06 -0700 (PDT)
Message-ID: <49344fc4-a524-4c54-b75a-f094adf90353@gmail.com>
Date: Tue, 9 Apr 2024 18:15:05 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netfilter: x_tables: fix incorrect parameter length
 before call copy_from_sockptr
To: Edward Adam Davis <eadavis@qq.com>, netdev@vger.kernel.org,
 edumazet@google.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@google.com, song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
References: <tencent_2325B98DEC12765D8CDDF9996BCFD78DAA07@qq.com>
Content-Language: en-US
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <tencent_2325B98DEC12765D8CDDF9996BCFD78DAA07@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/9/24 17:00, Edward Adam Davis wrote:
> If len < sizeof(tmp) it will trigger oob, so take the min of them.
>
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>   net/ipv4/netfilter/arp_tables.c | 4 ++--
>   net/ipv4/netfilter/ip_tables.c  | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)

Hi Edward

Already fixed in net tree


https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=0c83842df40f86e529db6842231154772c20edcc

Also a followup has been sent today

https://lore.kernel.org/netdev/20240409120741.3538135-1-edumazet@google.com/T/#u

Thanks.





