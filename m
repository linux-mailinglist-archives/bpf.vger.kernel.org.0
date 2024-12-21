Return-Path: <bpf+bounces-47518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8EA9F9F08
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 08:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE5E16BAF0
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 07:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F001EBFF8;
	Sat, 21 Dec 2024 07:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Ibav1y8J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914371DF986
	for <bpf@vger.kernel.org>; Sat, 21 Dec 2024 07:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734765766; cv=none; b=NqQzg5Sw72SDT6ZHWQ2hYK1JnmErHNk1vZ//ZI7os+C5z+9LxwjxaWfI0Evc/yd7gygC4/0pPakYyKDuQ9DpV7Ac+FqAbph1+ZhuxZ+mhcKoJNGYA0OeSketUds5junJ0+f00pSQW8aYbsop3dzTy9Vn1aXKz2IdYLA3NWQDJ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734765766; c=relaxed/simple;
	bh=0rAosgF3Ztuz5d8Yvh86KvdnQ2ufSZRKMNHOv7KYSTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rfM6y6B6IDyQzMdDqDp+prWAtHO8EFdSO3AGu8hCJEmtLIxjW/zltqLZvwaQAaswjtm9EqHalPKtevHwUT/kkq+77YtJNfS7xRrXQsRRXF3NDzj5SX2KE0WEDVSQ1naw5D3aFuqKdWhiWkqBQLgJxjIkIVRU7Ey414gKHCl67EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Ibav1y8J; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso1566135f8f.0
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 23:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734765763; x=1735370563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2EUlBe1ti783aJq8oYTzxxJuGG7AnBX8HC1zASLsrUg=;
        b=Ibav1y8Jf0i4VecL5JpNV3A72I3nXExj45em048cNfQN10o2pkTskbx5HFiZe57UfR
         AROUZLNPjXVKYBvNVa7JaL4yhH50/rM4v+9pu2ovYmm5nqIG52SfoqXzfuMlGhuvZFqM
         vtMoR63Mb5CptFh/T65Jf3PJXlkfwsOqc5SzfntXMAbx7285o7SPVzgjH5cGLeWOmO61
         QfD+XXCSWRhwFGmlg1b22VRqwM6EoWyyCWV0pA27I2p7Xjpm7e3vR6Gd24A05Rp/98WU
         YkwpzwCjPofyRpxTqhpXl9iFSU19rm+82Bvl4Zh4hsLb0n2WSBj5rUB+hcbveo+kuN56
         Au5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734765763; x=1735370563;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2EUlBe1ti783aJq8oYTzxxJuGG7AnBX8HC1zASLsrUg=;
        b=qvAnF97dWKxCdGxTou1cTJKW6wAfDrXSLo2iKNSI9+lFsfH53A436O1ATHz1HLV/66
         grWw0yiKmKRhzUKGQWHyxq6lWase2qfLwVeN7BbspkRpOP+yf7fBfcmQ4/w8+aC0aVRu
         XhGdMqeyLwtHHzSC3+7fBmBLXOYgAcRZ02FzfQQP3mxYHnqKS+xSWowlAurJCvkrj1Vq
         Sl5sxsyZxBq+ceDoCIQo1ekM6BjYJhvyPv2IFz2iOGiMMqYIVm4Bs/JCv73fCtjwFnhU
         4uL6RngND4qHWysFAiJKAjJbPC88cZ0trBqbLLARf7mOkp46/ud6p8oPlaNkrtd3N3ak
         bQwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPTtQwr3o+AlWad268cZInyRrTX+f7S66xXUDPts2hKf9NV3lKnmkqxI+Dj1oAKB/6nOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzigFaXXWETb3kmE9VC9rmOW8YW/uUx2LuMC+vZh6iXBh412GPv
	Y0rX6ZS52ivXyNTLlUrLzZJmvkn52F6xFs3xfVBoY1obFr4dEuYSdUjA7aXwUpU=
X-Gm-Gg: ASbGncuJ5bz94qw4s3jaMI3FUxfM/acNrKkA0ts6zXNDuMeWX1yBGe1B6F49QfGSJIe
	S7IEyfL77RfXahZZqQSZ+VzLMXnS9h7zQKrQ3hSxDlTNaxE043s8s1oWul5s9XD2S9+nF+FevPJ
	EZXVZ8pDuT2JCLpDLEgpxtW7+uShfSsEUp0vZkw2tsga6aHjZ212b/i2S7UeCpYwYKJC6kQXelb
	8Q3G5Zks6OYQC4KAZCrzpkgGEqUPVSqFWYYMSRjDy2juDHm+oW3WXbhI9o6Fvco9Bx/mv5TpVAw
	R5l5DUxrcABj
X-Google-Smtp-Source: AGHT+IEb7LQUNtCxYlO/uzup8sRen9gVLF0bzI6pmzmw36NSidzZZ11gwIBnl8/npx6c01D8spL8yA==
X-Received: by 2002:a5d:5f95:0:b0:385:dc45:ea06 with SMTP id ffacd0b85a97d-38a221fab2dmr4994638f8f.13.1734765762909;
        Fri, 20 Dec 2024 23:22:42 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8acb85sm5752647f8f.103.2024.12.20.23.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 23:22:42 -0800 (PST)
Message-ID: <960da366-baf5-4b27-9583-579534e5ee00@blackwall.org>
Date: Sat, 21 Dec 2024 09:22:41 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Extend netkit tests to
 validate set {head,tail}room
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@linux.dev
Cc: pabeni@redhat.com, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20241219173928.464437-1-daniel@iogearbox.net>
 <20241219173928.464437-3-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241219173928.464437-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/24 19:39, Daniel Borkmann wrote:
> Extend the netkit selftests to specify and validate the {head,tail}room
> on the netdevice:
> 
>   # ./vmtest.sh -- ./test_progs -t netkit
>   [...]
>   ./test_progs -t netkit
>   [    1.174147] bpf_testmod: loading out-of-tree module taints kernel.
>   [    1.174585] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
>   [    1.422307] tsc: Refined TSC clocksource calibration: 3407.983 MHz
>   [    1.424511] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x311fc3e5084, max_idle_ns: 440795359833 ns
>   [    1.428092] clocksource: Switched to clocksource tsc
>   #363     tc_netkit_basic:OK
>   #364     tc_netkit_device:OK
>   #365     tc_netkit_multi_links:OK
>   #366     tc_netkit_multi_opts:OK
>   #367     tc_netkit_neigh_links:OK
>   #368     tc_netkit_pkt_type:OK
>   #369     tc_netkit_scrub:OK
>   Summary: 7/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>  .../selftests/bpf/prog_tests/tc_netkit.c      | 31 ++++++++++++-------
>  .../selftests/bpf/progs/test_tc_link.c        | 15 +++++++++
>  2 files changed, 35 insertions(+), 11 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


