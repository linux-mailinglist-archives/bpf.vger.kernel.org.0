Return-Path: <bpf+bounces-71705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 692F6BFBA2C
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 13:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0CAB5018D5
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 11:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149B0337119;
	Wed, 22 Oct 2025 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="AdXFcp0b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E982857FC
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761132311; cv=none; b=s3j70rGnAJX8GXvk/xYfbaigeuBeYLMuOJ2uXliyjdEJ3mwZzY92hkCm7MYmgJxlmIcrZ6VskX/yyKHpcspaeEsh98ij5RoW5pOfq4nglK3OaAmuR3TG6plkUqOlc87QgJQLj9IkVwWiS+scO5Pq0E6aiPyYluJXwqDQkXB8ZZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761132311; c=relaxed/simple;
	bh=1hZeMj0UWQeHgoCLfE+UEl3jPzN6ojQ+GDfqG96KVpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYQF5mCycpDVRkPtAxLiVkriOmnvdLU4PsxJlqpexYxEOYjiotHS+tTTdGcv+1iaO3r2UzGBGfFHu56LfMXwrxsPHWd032s+6LL8FtXQ9b3RVrLD4jRWHEcax9DVv+0OB0c7TYTqryMCjahU365LQ0auOLFBBcQMzGxGb8ZamHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=AdXFcp0b; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b4539dddd99so1222601766b.1
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 04:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1761132308; x=1761737108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ONq7np9g9MrEqjFwbGijwelPGFlfBJwFO8dPJaIhZSU=;
        b=AdXFcp0bmC/jfvYbJvLic2wEMCzmIBKo55PEipmfgsPNtfi+04LaH9A3Cq4zyXzGKA
         xv0LVb0i1B9Km6DugXOpg0niYGG2ZhFJ3jeL5X1gZzhBvqTMAoinIvur82NXLTFOfCmf
         HVlo47otF/9anzfFB9UInUce+1Rq92pO35xN0/nAKnBEWYn1DwXETfKHE4j5E/JZ6nPj
         n5zVBlt0g/orJXHUgB7VDB4kxp/2rLvjopH4TlrRDvggiUCKPTPF4Pm9t3vgm9FjEfEv
         vIIMy1VLrMDPjydW5AkMxUSRJTeJLlurUuzjstyi+oW1Bico9XUUbXlrXvGmVimyPiY+
         bYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761132308; x=1761737108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ONq7np9g9MrEqjFwbGijwelPGFlfBJwFO8dPJaIhZSU=;
        b=nQqxjsxUsMBfBx0HaManBA59VAQQqAz1zN36/hLxpg2q71dhimAkxwxEE3kIoK6kx6
         EZRJrBFLuf9m/Zm+uLNJrmAuRZbDMqXS4mgtuHe/L4lYVzYpf8MD8z1vD+AJS5Z9BdVJ
         IuyvBAloVb5yiXxkzdZfQ9GWCt1HmyxFL8/cL+IiWj6eDqXAT2RYRDaaBNdp/s7L+VC8
         fS48LYy8FG8Ye9wNnhPjZUZWlH9nMvil1jDSu7B1mmqOqE6P2PbGL8pQUJt+/e5Tbd5m
         F2qsL0ctdLAidEfkTwN/WCBJWKBX0VZVJHif8+59TeNYm6kOw+BlGPlUvW3IBFSLwR9x
         0uzA==
X-Gm-Message-State: AOJu0YztWj6W4gHL5csFq933TjHAHazCV16po8GirtmL8EbhgETP/zqp
	eF2sFcw5RWUEftn2a5ri8alU1aXUo8VaCJ+cFwX3cchFYtNT5E0qNwlYy0O0ADLbKic=
X-Gm-Gg: ASbGncswF/Myg66Jc4wK/ocn/JDCSlAhEWtz8WQTemuaCXvlqdVlrll8GPnHkbyKQfL
	FmsHb/77JIQvI4/SNmkeIwBEoppLgVUY+CwyfDP3Tq6iqFPeI8+8p+3G/bV+taOgkVLshviOd8u
	WFpdGwwYHCrOfRjjIJ4miZW6TgDujpGY3YGu3mNqvvxmCa+l4JVxYsVUiN0wTaoM/GVF1E2WTcv
	4ZxdjUI29U0L9gO1Of924h3H93kjKH09D97pCfhrnSy50X0xPW/AIYFjKSDWGg2dbJSLLl+68/e
	giFhL0CggLxJASfkz9eyODRtOHE04wiMTPB9i8YK9uleCLAoaW5LX6KZ2U+jDJhXipoTdrcm9Ml
	cFA63bmcbrtzRrBbJPgVcr2WtU3jnUHtnj5hbvdqgRwFGUcdDM746N8I1O6llXAdoOjVlx1TCu6
	KyAMBF1Nkp/TbeC12S4C6lYpzAxxJ6SqTg5gbBBmouVng=
X-Google-Smtp-Source: AGHT+IEwfchOwO7QAOkGnebZSJknlHDr5gYvUmxRoRxGN1hZq727CipU0K75R8kJYGQI9qDDsgmIUQ==
X-Received: by 2002:a17:907:6d25:b0:b41:abc9:6135 with SMTP id a640c23a62f3a-b647493fa65mr2475676966b.41.1761132307639;
        Wed, 22 Oct 2025 04:25:07 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c494301aasm11939759a12.24.2025.10.22.04.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 04:25:07 -0700 (PDT)
Message-ID: <9e707899-9d51-4eeb-95c0-3b7f02cb2fa2@blackwall.org>
Date: Wed, 22 Oct 2025 14:25:06 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 04/15] net, ethtool: Disallow peered real rxqs
 to be resized
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-5-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251020162355.136118-5-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 19:23, Daniel Borkmann wrote:
> Similar to AF_XDP, do not allow queues in a physical netdev to be
> resized by ethtool -L when they are peered.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  include/linux/ethtool.h |  1 +
>  net/ethtool/channels.c  | 12 ++++++------
>  net/ethtool/common.c    | 10 +++++++++-
>  net/ethtool/ioctl.c     |  4 ++--
>  4 files changed, 18 insertions(+), 9 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


