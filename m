Return-Path: <bpf+bounces-78741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2E0D1A7EC
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 18:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD512302ADA1
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 16:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647D0350293;
	Tue, 13 Jan 2026 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="arPqkIoj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854B12F0685
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323506; cv=none; b=d42konpUR86v+1ROJcy48W+pOth06DDRpbzW9bgz+mS4PHDQEgyZ5OTIi9l9t8aJbb6FntadfgwhdXx+G47Rz0m9FWideXq6khWhduVQoMZy4O7Ov44p6W4bJ8FnUiMVw0Mp/LPRoNbxbIjC58ZK4fXN36++7RuyaZV0FWGzuDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323506; c=relaxed/simple;
	bh=6Qy9RFFnU7FhdGhT3OFG5W3FiZMln0ipNVP7RahSUfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZx4EcFeHqQHd4+cTjwgOGMr8hiWew6VwfcaNX5bH38zFf+vKgEWiWrI/9QNmSJ2rGWp2VBXYjUujrPXse9RJlK1fJXEXkyTF6y+/dCf8NEt6v8wDsfOhslcflCOvhXNlcsiObgyDw1ujhFw+v/1Oq7ppJgO+3NRL87F2iJsBJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=arPqkIoj; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ae255ac8bdso2888762eec.0
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 08:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1768323502; x=1768928302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n77cGqLpADKbmUH705Nn9XH804i7piONdOwkUPIPb3g=;
        b=arPqkIojm3BzWuNVp2unot0Dq1MnPVId9dYHXNjLMCDQTh+ob4APFE2WwP4l9Om5Jx
         Oeng1DFBi0Ez33Y7YL7r4w8QGzhhxrO8fbjZeblQPMaI+yLDl2L+MA2fSz5Np/aPayzV
         Zop8flHOiBM+7ypmlUG96uCWIPgxQWOU6NJcqPeKC4T8OuTq034w+p5nsu6YGjBaKC+d
         6M4uPLGr4bpd8wSTX+ArhjLM9zfDrV5N8wYyLjMWNvJhkQR8IrPNFyzu/njerrJNsn9V
         hGL98ph8uXRqGQCMNpaXenCJo2kHSPSrKkC2jIbBBEt22xrxJ6JRVvyzD6xWpcjOVFst
         n+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768323502; x=1768928302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n77cGqLpADKbmUH705Nn9XH804i7piONdOwkUPIPb3g=;
        b=raQecYD80MI1w53FmWhqdOFxVFSSc4HfLyKZVPas1qnzCGg60hi6VmB1GKA7zA/V8x
         voYDK10OC+VtreFri7C+2z4lPt7+U00dS5lBzq6ohJaoJ80RDsdDwJujSMn3lvqd2CRS
         zivT5vDgZw5Uq2UC0O73+Kk9h7kh9PhvV0AIRXkABcd7wJTa43w9APqj7QYEkRPC7rAG
         X8neTjl48wQLtFol9PXCVeSGnnxslCcdq05uzC5ujfU/nsOelC4kGjmZ0bxIzYv35gkX
         ZqJbHp5q1w2pWbRG7YHZkM0n78UGxVcpGSEEcistBoZ3s0hD3w7rwGiAm7/THOdGpcPM
         U1PA==
X-Forwarded-Encrypted: i=1; AJvYcCVTrEl4t8KpSkwlYCpqYFt5in4+YemoVCGdvRscZH+tCYYXzaX6cnOrjEqWPpH/n3y4V9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJJIWNwhswu8z+FTJz8M/H+mnIak2yQDy6qCQP8DMLQ6Vl9Inc
	VXWQYdx7MCBmdYeWLpiqH2+JDOdTq+gcFbBj3cYVeGVNB9Sy2r9mlrS4M33ErbbfLwc=
X-Gm-Gg: AY/fxX6bCiUfO6T9UEaE6+07Juo2SAuutv+yUBYKsSi0rP5m7fc/V/cLZ+Z6gHCUYKu
	92iWVfWmUhUAfOayvmrwaby1d58E9zh52Df8KnXSYRfZY6ibxyPW7r/AaKnxwoeO9EVpT2HYbW+
	PGzl6IzBdop2tr+p32VDfDapom5s629b1fnpWYaCOls03/SIJUSpCn4iEfPbO08MSGbfNyoFqsh
	keva0RqOnmk1m9tx6DThOOzkki6H8qPXPmwhu6UB+rcQqlEt4maAssd9AuL3NXxxp/5ayYD0xQ1
	jB6cNvW1fjVvRwGqLPfecTrYpZQkbUm7jAw2cFp0uriKeei3QDkL/bnlPrpkz+eJk6g+NMczLST
	mCnNF04AJolz5hMCBYSxzgNkrapQapWl75WYT2u8ZGrZcQOjTooLha/+B0vef2Gct68wFoD44cP
	hH8Bk8UfcD0chHnWc0BnsQMSz6ipqtwlO8/WqadDOmWUowdZ0RsPcIFcoZ1rw6NvdeCle6ilSyE
	tFg8RzWGKYqXI8FMHUj
X-Google-Smtp-Source: AGHT+IFPbxTriagZU/H3z0UHuDj2NqhqlCDbpNot88w6o+ZauEKhsAYhZNwxljY/4wB3cG8nkebtwQ==
X-Received: by 2002:a05:7300:5415:b0:2a4:3593:6453 with SMTP id 5a478bee46e88-2b17d2294f6mr23252353eec.3.1768323501600;
        Tue, 13 Jan 2026 08:58:21 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::7ecc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707d57aasm17121126eec.30.2026.01.13.08.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 08:58:21 -0800 (PST)
Message-ID: <745cf43b-05f5-4129-abea-117fe1c53a70@davidwei.uk>
Date: Tue, 13 Jan 2026 08:58:18 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 15/16] selftests/net: Make NetDrvContEnv
 support queue leasing
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260109212632.146920-1-daniel@iogearbox.net>
 <20260109212632.146920-16-daniel@iogearbox.net>
 <20260112195915.5af68b2d@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260112195915.5af68b2d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-12 19:59, Jakub Kicinski wrote:
> On Fri,  9 Jan 2026 22:26:31 +0100 Daniel Borkmann wrote:
>> -from lib.py import cmd, ethtool, ip, CmdExitFailure, bpftool
>> +from lib.py import cmd, defer, ethtool, ip, CmdExitFailure, bpftool
> 
> tools/testing/selftests/drivers/net/lib/py/env.py:10: [F401] `lib.py.defer` imported but unused

Will remove.

