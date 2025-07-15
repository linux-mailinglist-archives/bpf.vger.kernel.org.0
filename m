Return-Path: <bpf+bounces-63314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E40B057A9
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 12:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A960189B603
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 10:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D842D8370;
	Tue, 15 Jul 2025 10:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9Ovq6zU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728972D661D;
	Tue, 15 Jul 2025 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752574944; cv=none; b=rmZomX8n2gbOuN8oMnLp63kl7x2l6PFkrxTU+wFGjPNBw9Bnm77sUsjcBYhcgkpVZcWXSglpn8+XVNEro/z9Jh6xRWzWKRRRhfVJnwNtXKw4gzxEuGhuC9p2uSuM+o2/JnveAZQ1NpyRtXYx4HUhOMh92x8ooSB7oF6/lulyo2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752574944; c=relaxed/simple;
	bh=yEBbCY9oUZbDlS3ZBBT7sSaX45VBbabpp8PPuahDIIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ae6/9vhWNpioF8pBVldo3h4oVm+N5fiVqjtuioqBplAATSmHaxUlilCUDsSlTT4H/s9JC1xznpI8pWaRwQbEzSjUcsVewkSLV0jFE6fgdbYiBchI1mvBmxS2EUK4is7KCpyJfJoob/kA8Wm6O+3/xX51LbCVswzqBoaTmB3Rqps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9Ovq6zU; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60c6fea6742so10323969a12.1;
        Tue, 15 Jul 2025 03:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752574941; x=1753179741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2crJGfvy9Jnr87YgMI4zA0rz0NIO2gRU/WUVx+zJOAU=;
        b=I9Ovq6zU8PyywlNtcZKeu522Iq4CSqvOamQ6l0+9ymjytS01NS3H5ZP7lmOn3AoL8A
         gFYRyPySLzCDTtaG52g8vKYq0bpIsAHnMYoWQldeEzyZauZ13hLwPrOYWBjO2YuFFcdb
         PQLnXZ09jvzz15QktraKLiFqJ4xbmbAbnQsKA8oDDDmrCdeU2TplDWjHzuRMED+U8YEp
         BeHqqR7JXCYAJMiA7fGpHkNFdO5nPeHJgXYguBt5vxLLH1l/hWRHzliQ/iXDRGVtmZUX
         D4KdLtcss+YDJiD7h42AHo9SQNGactBX+4T8aZAWUERsbDnCRaNcM1iqcK9SZxudfAmx
         fK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752574941; x=1753179741;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2crJGfvy9Jnr87YgMI4zA0rz0NIO2gRU/WUVx+zJOAU=;
        b=D8aPLHaNojJKBjWZo+Tk56CjH5H3gCIfB0tiPzCXWxIIxKoGC70aQHpGuAbLF4Swpz
         c+pjQzf1WR91EOQBQL7XPFyfKH5itaT1FI5MEwgv1bLHriF72zboEGVOD2TpA5ToDeJ9
         pqN/fwRFd70lo6M8X7c/0gEHUtAjkg8TV7kWqeierENcHUMSxgUwEflJBKdLfiacCctR
         YJwo/GZv3/JUeZ8DWYQ8lcvHy/RgLh39XLWvjspJJ2ZJ+N6Ol4QPHtNwm1v9hml2hU+o
         SH3CbV9cAO72zpwpGcJ7D/zj3MSKyB+47BNHagX2ugHtdplBGAWaNslyiJvAfoFDi2T7
         4Ang==
X-Forwarded-Encrypted: i=1; AJvYcCUDWI8toIMszEGriUcVM03KbOtrocl47NVA3la+ybXIPWfVFvHzbXWzV5EAmFWXLEEvz2k=@vger.kernel.org, AJvYcCUaQMO8pWpai8r8clDNoiU8vxvk7utW2WzBV6p7uEaXgrDfFFde9eIG+W0a1PF072RfJkg/KsV4@vger.kernel.org, AJvYcCVKp+DuoxI2YDALvIy8i9GQCtYhZDPIqPtFASbmPxrghebiYOJF6k+OZ4K7kZr3bKXIataQpibtpn+N7ZVU@vger.kernel.org, AJvYcCXrofpzRYgeG8NkQmXqFLf8sI/vLDqdeYUIb+FulTHQloOITypmbhP8kDTAuDsH2noS2NtPuGG52flBMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXs8CfVM6qduixTYQpJLtCIBeFCXA837cCrcL4n64Ci4HfSpjY
	fzkgKxNrvJB8y/jrY4jBaWYbEC3xMV3Hh5RzW6scJ9ZFqeecwXx3BWwL
X-Gm-Gg: ASbGncu/DNidOI1z9OgZm7X7Hs/Uq2cbzEv8aJniynWKmYqfbxZixgeWxvRcgukdypO
	yvdiTaIAfNKq7XHEI4nmSsiDFeMzPc1wjy992GjPzXweN8SV9Ve6KPzWjO+X+5m8knlL8oSb5b3
	0ywRBEGh2dIg/GH8M/kxMw9HbmGxS3PdO9YbUq3YMhcKukjmJp9aOpO1AXMLRANSO+TUXLVWUw3
	ndbNQQazPI0mXWLC0R1fbQ9pflOqEakRuz1BhlN/O3/rZI6Etxi5GvW2OD32TaBMhd9nHzBNnYE
	U1qxCY1ugni8jCMlzt5kADY/YtblFQdGuLOI262Ms+yTLqvCu0Wby7/Fzvs7+5ruMnZYcjVVvxX
	AUTR29dBf3h49Nnj/wVMVyXqzrZld0nyqBmw=
X-Google-Smtp-Source: AGHT+IH2Fp/Hb7ISJckZNbpE6kxbt03ub1njSzKQw/Kjz/TN3XGfF0/RC3z3jw0kIXpvnI8LNZUctg==
X-Received: by 2002:a05:6402:3485:b0:608:64ff:c9b5 with SMTP id 4fb4d7f45d1cf-611e76580bbmr14606034a12.8.1752574940393;
        Tue, 15 Jul 2025 03:22:20 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::1ac? ([2620:10d:c092:600::1:a4c1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611d8d54112sm6292085a12.1.2025.07.15.03.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 03:22:19 -0700 (PDT)
Message-ID: <839d5486-a92a-4ae8-a536-b4a0e3d595ea@gmail.com>
Date: Tue, 15 Jul 2025 11:23:47 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 1/7] netmem: introduce struct netmem_desc
 mirroring struct page
To: Jakub Kicinski <kuba@kernel.org>, Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Byungchul Park <byungchul@sk.com>,
 willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel_team@skhynix.com, almasrymina@google.com,
 ilias.apalodimas@linaro.org, hawk@kernel.org, akpm@linux-foundation.org,
 davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch,
 toke@redhat.com, tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com,
 hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
References: <20250625043350.7939-1-byungchul@sk.com>
 <20250625043350.7939-2-byungchul@sk.com> <20250626174904.4a6125c9@kernel.org>
 <20250627035405.GA4276@system.software.com>
 <20250627173730.15b25a8c@kernel.org> <aGHNmKRng9H6kTqz@hyeyoo>
 <20250701164508.0738f00f@kernel.org> <aHTQrso2Klvcwasf@hyeyoo>
 <92073822-ab60-40ca-9ff5-a41119c0ad3d@suse.cz> <aHUMwHft71cB8PFY@hyeyoo>
 <20250714184743.4acd7ead@kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250714184743.4acd7ead@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 02:47, Jakub Kicinski wrote:
> On Mon, 14 Jul 2025 22:58:31 +0900 Harry Yoo wrote:
>>>> Could you please share your thoughts on why it's hard to judge them and
>>>> what's missing from the series, such as in the comments, changelog, or
>>>> the cover letter?
> 
> My main concern (as shared on earlier revisions) is the type hierarchy

Quick overview. struct netmem_desc is a common denominator b/w pp pages
and net_iov, and contains fields used by the pp generic path, e.g.
refcount, dma_addr. Before, pp was using type casting hacks to keep
code generic with some overhead on bit masking, now it'll be able to
look up netmem_desc from a netmem and use it directly.

That's pretty much what I was suggesting niov / page aliasing to be
1+ years ago, but unfortunately that didn't happen. It definitely
removes some type casting hackiness.

> exposed to the drivers. 

v10 adds a bunch of "pp_page_to_nmdesc(page)->pp" in the drivers,
Not sure I have a strong opinion, but it can be turned into a helper.

Converting things back and forth or blindly
> downcasting to netmem and upcasting back to the CPU-readable type is
> no good.

-- 
Pavel Begunkov


