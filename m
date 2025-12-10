Return-Path: <bpf+bounces-76420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E2CCB3D4F
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 20:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E5E13024E5C
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 19:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA65E16DC28;
	Wed, 10 Dec 2025 19:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdseGsrC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4322F2EB85B
	for <bpf@vger.kernel.org>; Wed, 10 Dec 2025 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765393757; cv=none; b=n/tT3q4DsEro+BeS5Ib9gdbfn3XhyeVdY93J/79tYsDz+tbYRjvU4SZZet/pG6BPj3fgWDzQE9FNy8D6pcNrTKf4bErfJlxnfjuE5NrTYgMD3s4Tde8SysnqOkyVrHCO8rzeAORmVh74pa0G7snxeAqik97CjpbzwUNsJYAkkuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765393757; c=relaxed/simple;
	bh=calyCJn7HCzDIZJYHFyyjL6bDhg5HBlqUnJKtZ4SEy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BssKGtB3f7w2s9HHrGSwSdlNhtu3J5VVMc3n/s3rYiyApEV227p7MAXAwSVwa2PaQFedk6I2UJhGBVPnAFdKP2ierSLR2QEBbA8UKvxJr4Jb701tYSuwX/HJmSCSehOduvymEY1oC9JM5A9LsZeimUvZTj6S0jdqm2LWj46QqyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdseGsrC; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so152459b3a.1
        for <bpf@vger.kernel.org>; Wed, 10 Dec 2025 11:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765393743; x=1765998543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ALnH7xZXyoaaX5d2lzICEZFSc7BpSTyBsbMHtfdCwVg=;
        b=OdseGsrCSDM17b91kRYpWg7MASTMjNySzWplWVxy8WXB3GCDlgd4rQ/LuFxo0i+xH4
         ySZXvvGhSgL4ndMO+kzoWwT3DuYz/e3Gdlr5wAn2PhHdA0fkKO6uTH3toxOH8+ZFK5Bj
         SP+I0NaqGoBIHmwixgLgrzwL8DVlBFxq0IXThbONLUOGvdDelPgA5Tl19P6UIvMV32YS
         +hv0cbteRuuZ4WslZLi7iq8u54GooPSuGXktig7kGMrO7pVZmp7LWqzs9gJhUBHZjcAt
         GS3uckjv8FSjnJAStA/3Bmeco8HPMw1f5I7+HsTus34SfmQ1vCmAZsk1g5OjFtApTdoB
         npTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765393743; x=1765998543;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALnH7xZXyoaaX5d2lzICEZFSc7BpSTyBsbMHtfdCwVg=;
        b=nqdQqr5A0838xKlETDfMV/s1/lpNWS8ru4fvED0CcKFkgXBJWsuT0XJ0Iu2UhBHHzu
         UQQ/GALLjIIT71ZOQXcj4lf/Fs1HgMHhin3tclgHYz6+NFQYGknsWvRb5+POn7HBwV3I
         kspnhqU9AhDw447WnK6/wOKeoY0PCWE7gYiMxqBIaCaBGxB6JXLz0elesi6OhQF+Tgiq
         I/p2pKyuPPRCIgjHhrR7mvMA9LAfch2axQiPiguKStNFjHLOVc9ObdvjlCXZ4f6oLgjl
         jI/jOXKcvH3eQ6gxHdUjqA7Cg9jQJS4IMQXoCXYXHhMPr756jOPukeNTCym5mMspodgS
         Q9LA==
X-Forwarded-Encrypted: i=1; AJvYcCUSzGKMUI0dO0OpMnR6Gj7y6O0GMYS65KgiAx8xnvtjgyo98KFtAKtVrVHTorkiOx3GSZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiciE/FsQkFrW3XPNR2X/AFkCueFeU3nNDrYZGXrTEEdXglPm+
	H6ilDrqmPM4P/mm481MG9l0fy2Pbwxk/23jxBHo1owYwszUZuqAMxMiV
X-Gm-Gg: ASbGncvhwDZJrfHnpxuGIHQIQNSdQ2sB0TbY9veHfmxrBYEA/f+LgElVqU/aQnrLYb2
	XYaQ2ovodgJuZUtTd8UxGG1uj7hFmIwxo5tkIXtshiyO/ohXjGdJJRfOeERnI72Dzu/xjws3ApA
	RyF4WVrxv7nd+y43x1hwUSUcnci0E3ax4Nx/sAOeWkJUFPnvlI1ZEb69jtcyIqpt0HG1JJqEvcx
	yo/Bf9y3gkJRlRweJsX2szDBXwmCft9ernUIialfEIzqw8NVU4P+lHto3kfTTb7Lx91KSJ3FfxJ
	GeWe7B0mnjprzIXGlsvyuNtoKhk2F7tuaqxO6c5X8iMchzi91hKchQsc/wNC3/uvQPDNRabkZDL
	YHdxMq//x4H51ezFvUr5zHxdEYpoWVFJht+ZIyPtRPfQ9ucBg9i9Rx8rLc0x6rZpRZDNfaCWToz
	NGZulvrWNxgkNDtP5z3dxesjiJ5pybEacmj3v+ElD5SQA1hbP1/0XEEyUw2U8=
X-Google-Smtp-Source: AGHT+IFkBdc4L7W2yURiGuumsGT4dEWPci/s+wZEabce7HtaPIrwKqnYk/48B/cwUZ1Bk5R/h+PAYg==
X-Received: by 2002:a05:6a20:3d82:b0:304:313a:4bcd with SMTP id adf61e73a8af0-366e120ef6fmr3658096637.30.1765393743391;
        Wed, 10 Dec 2025 11:09:03 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c25b7d59dsm248321a12.6.2025.12.10.11.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 11:09:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3682159f-05ff-417c-95e9-976f0a504c09@roeck-us.net>
Date: Wed, 10 Dec 2025 11:09:01 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] selftests: net: netlink-dumps: Avoid
 uninitialized variable warning
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 wine-devel@winehq.org, netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20251205171010.515236-1-linux@roeck-us.net>
 <20251205171010.515236-9-linux@roeck-us.net>
 <20251210181318.73075886@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251210181318.73075886@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/10/25 01:13, Jakub Kicinski wrote:
> On Fri,  5 Dec 2025 09:10:02 -0800 Guenter Roeck wrote:
>> The following warning is seen when building netlink-dumps.
>>
>> netlink-dumps.c: In function ‘dump_extack’:
>> ../kselftest_harness.h:788:35: warning: ‘ret’ may be used uninitialized
>>
>> Problem is that the loop which initializes 'ret' may exit early without
>> initializing the variable if recv() returns an error. Always initialize
>> 'ret' to solve the problem.
> 
> Are you sure you're working off the latest tree? I think this should
> already be fixed by 13cb6ac5b50
> 

Sorry for missing the fix. I was working off v6.18, which was the tip of
the tree when I wrote the patch.

> I applied the other 3 networking changes.

Thanks a lot!

Guenter


