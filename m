Return-Path: <bpf+bounces-69454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A28BB96C4F
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 18:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B76487F6D
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F3E30DD37;
	Tue, 23 Sep 2025 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="k6rLD0Jg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AF630F55D
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643985; cv=none; b=LapHFGN6K7ibJQHUGmyGAUt3Xmx0mIuZ0eUync2VnIdZmsKcPrJFjOHNEdHurEfTo7TvetTnCpAP53u8Jx3v9cTw1855wuaJKjs5qXRgUaVLqkUSksgxutXmvdTNetpRsHRkcZVxeZeoV17VSP/bT+OoFSf9WXuHei1QSmHjNNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643985; c=relaxed/simple;
	bh=OYyeA46rSCN1K1jiMKJz6BTJCzHtkaWIOI0UDQjqLqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XIvmmnmefcixIDSPvAnDTHVB5EWq3WQmoDIqH0KV8vFSx6/5KBTu7ni+v/NdysfXR30IHXHKw1+yDfjGY2vLRZv7VTk5BD9PEcTai9VnlelZlDZ/SJl4rvQa4j36TbXoJDoMQhjEXV5HMjNVVYItAcy4iUoV8fYnctcNTp0TAxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=k6rLD0Jg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-26c209802c0so41391375ad.0
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 09:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1758643981; x=1759248781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rfnPVSIhj4SwRPe2fDLCwwGn25F8/7TZaQuIesUJWuU=;
        b=k6rLD0JgZJEBiLAlobdF6rT3aQHDWQGQGqKh9kqUANGmygAgInAbBuscjbwJUas+es
         bN9YN/VEk8oEbXSMce88HqCA1vfeVIJmJQ3svSenyVzOLoQaYpq+xNRZEXjGJfY7NdRg
         WEBRCuTwd1Sve+dUBnoDxiKmAPllIQN9hmaj/WFbixLjB3SPiF+b6fULIOuaCyGzbpgM
         AqeP3b/51L4Q19xx6VId6yQn9mEzJGKLAzZa0PPDNxrvy9f/TSJFGrMs3uUUvziB3n0x
         fjxXLkdaD0GQ5oE0fSRG+LD5Q9QdRU5mt+nAxXTMpj86ZbbYsO2BFQ6PkuB4Yuc0cUEb
         PZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643981; x=1759248781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rfnPVSIhj4SwRPe2fDLCwwGn25F8/7TZaQuIesUJWuU=;
        b=sDPOnZVxxXha91k5u/LeEfJJHvIk8OheMKw43kU/Moselj+9SETc1SXDd5qMZb7k8K
         gUYM/PhKVKeE4p95vhvL7wWC57sOzj5elk9eNkJcQOHVkItAMoP/mLjnH9qU3Q6XJExR
         +PzKmlnTVV/fd0jX45EEmBTFT75MOyH0PQ7naOU6tKhRKRGBskI5ifsHnBrQX0p0Esv7
         WNIwKR+VUlf7bRC7VKcbLJk+w7e52MC1xGdP5RsmFkO/zPIOdtKyjAeGmnch1i6pMNLt
         2gZhLj9K1d8Y9LVdpCWwuXC/Behs7ZrGERhC3ZMDxZTSE9yj20JpFO1myoX5kKBAChba
         1aIA==
X-Forwarded-Encrypted: i=1; AJvYcCV0k4dSoghfTVWZvI3QMSdjAUph4FgXSLr4j/BolO4YBZb8xe4lTfUSRkb9YaMCmwNlhdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGQh9JFv9QkPc6mAd0c608q+fnN1N/Dk7coE9+uwSuhiVrWPGt
	3SxOQWDTfN8pcdqLotTzVke9RHTkFLpgWVA+6QUDQmWOqBx+2r5krLWEJd6S8CEgMfA=
X-Gm-Gg: ASbGncu4VPiWZuoUfk3CF88TPNZgJ/6lgLQr7FfxabGf5iQvbM3NukAMVd9ZKCLscLb
	gl1m+7md4Vwr2NIo/bjXJpNDxJEjMyLv1YL5FpuqjdLXUFYgSRPdzwszBqX0wb+ZRA3WonZENHD
	LJR30GMiAF5YvjeWKGZOSgxc9dnUq8qLl5G+ogJbZuZqqBUbZqUkbbM8a8m5tofJJUUC+RRpde5
	JT138YGOfDV13XTJY7Jft35hzIM5BWR/t43uxv0CVsVlP9OphPoKjjperFAYVi1WtryheKmPqzO
	K1//+MxWcgrLO4Y+lRKanrfiwiR/U1kiAN4QgpKeka2Gqn6xYYE1rr+R2Bzf0Xpd3rQPKxHZnnx
	2zqyWPjs7gzOKeoZMOYGza/6155s8l6eHMu7d4O59Ab8ZGMAiJVp3ew6jvDZAdgl1
X-Google-Smtp-Source: AGHT+IFWdxKMRkCe6/ykTYOrIxuKs/iiJgu0t2WDMo8y2oxE6vXpur1FEkfQ7hTRg4i+K4AWPkymmw==
X-Received: by 2002:a17:902:d607:b0:275:27ab:f6c8 with SMTP id d9443c01a7336-27cc2aac8f0mr29493405ad.20.1758643981385;
        Tue, 23 Sep 2025 09:13:01 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:ce1:3e76:c55d:88cf? ([2620:10d:c090:500::7:1c14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698034168csm162819225ad.135.2025.09.23.09.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 09:13:01 -0700 (PDT)
Message-ID: <9b75c782-90d6-41bc-8b8f-9067ffc7a3d2@davidwei.uk>
Date: Tue, 23 Sep 2025 09:12:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 20/20] tools, ynl: Add queue binding ynl sample
 application
To: Stanislav Fomichev <stfomichev@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
 willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
 martin.lau@kernel.org, jordan@jrife.io, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-21-daniel@iogearbox.net> <aNGCyWRneDXiUWjv@mini-arch>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <aNGCyWRneDXiUWjv@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-22 10:09, Stanislav Fomichev wrote:
> On 09/19, Daniel Borkmann wrote:
>> From: David Wei <dw@davidwei.uk>
>>
>> Add a ynl sample application that calls bind-queue to bind a real rxq
>> to a mapped rxq in a virtual netdev.
> 
> Any reason ynl python cli is not enough? Can we use it instead and update the
> respective instructions (example) in patch 19?

Easier and more portable for my testing to move this binary around
for... reasons. Happy to drop and use Python in v2.

