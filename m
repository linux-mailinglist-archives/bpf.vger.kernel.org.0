Return-Path: <bpf+bounces-64960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820A1B18ECA
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 15:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99CB16571E
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 13:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AACE23D291;
	Sat,  2 Aug 2025 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TCQWu93P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74F41A316C
	for <bpf@vger.kernel.org>; Sat,  2 Aug 2025 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754142876; cv=none; b=aREjimGNuCD3ENDBfn5YPl5XZjOuadBvG1OxZyhDMCc2hCU7Q1S6K+ANotfafCkHP3NhKGfl6QLtHJJyrRZCYAHmyLqiU3UbnMRS2l/Xsqoz6+xUd59G78pky2lQcVNhlv4EdYBc7pF1NXgDFbL/JSYO+KNrr7bJ8h8ILZVPfQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754142876; c=relaxed/simple;
	bh=jNu4z5LlkFnuZWJ51rGZZ5XmCwlEwXOl8Nta3Z3Wvn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OTYu28OUQ1c+7OhxVGH0PAT+rfNxRHEZlzIeVfg+hhK3LCCz1rOj9MNYAab9VnrE/2fU9Ylbel92X/Yh6ObRlZ5UrGOVlWaWl7KFfJZmdVR6RGBYziwxzMnriEmzVQBOotmwpzapG3N96kDLNnWES789fL4HXPfWNL75MvOjPKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TCQWu93P; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3e40ac40940so10649915ab.0
        for <bpf@vger.kernel.org>; Sat, 02 Aug 2025 06:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754142872; x=1754747672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qt3QMnbQi4N+EycuZl75D2uXQiTKPfngptfcrsgcbKY=;
        b=TCQWu93P+Bc9lUktai1qbvpnzHzdqP47vkMY/gvodXsEXDeG/BVPMabTiNyIZshUgp
         H8oXxsVgtPkVYvJky4af/cBuV91M48zSAL2Bgdc5KUbY0/Aq/quEdQDTm6NHejSUOBu7
         OBHbeb9vOVyKu8yDek8uU7NvWo35D2HCDT36dNJQPltQOmoRgfzfno5z5FO9ZkCFBIfr
         8TrVZ78LKuhosoDDmEzuOaHw8PZRl+0DQHK4L1RTLhCOh7jXgyooG+p6qWsr3Xn03C9M
         vXEJPj7jYX9Wq9Rto+hb8H/FLbGHNWo9lrslN+TvTAM9o5T6/0IuZBg586aGEAeielzj
         HOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754142872; x=1754747672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qt3QMnbQi4N+EycuZl75D2uXQiTKPfngptfcrsgcbKY=;
        b=QohJSV6UiKTdR84205kp+3I/MfX5vVViNsPTupLSuw51LRfyrPTDyVhDjMxTansfjC
         vgobkazI+OQ8HD7Ct4g2dvt9tADdiELGnetGjAwsBmEzbftlnZfOhye38TNzwZZj2b3P
         bl6dVQEZK02HiK+Kr1x9SGeLZBfHPkGVTzPw/GgNpmYzAkbvo43Jddpa2vx/FAntlZkN
         +T5oTI43W/DT3e84yOvXm6ysmqz/h2EuwowXVo333vr4aS681NG5EUgaDE7FSnqmG4wn
         rKDmFcIn9k63ugyYBxYgsMrp02Di6qW/YQU9jZmkoW7qclxGUskgQEjRDKhmIPtRes3h
         QHqg==
X-Forwarded-Encrypted: i=1; AJvYcCUymG0MFmb4Zb4/3LcEAoElrMPpsMiigVJPOSNfUmB+VCHFxNQzmBe+jcshErg2RAk763k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl+HZCJMW2O01C15amMyPZt+yAd+ed9ppC1ZLan8SArGK/CyOz
	Vy8jPR2Uvs8zQEnQe2ZodxSH9URRYyXYHsEJx3uwSJBddiBuY4lVmL5TRFuYOH5WjFQ=
X-Gm-Gg: ASbGncvMLYYW3WaC1i1MK2y0+4IQzF4lbvjVH5yysjFV7zp4vJt1eP5ov5q3taDV5Vy
	l+okTYBX+AMzYf16rWgqEBuFQZnoHFp7XbMimQP90cEsQwqiShjpSyv9nRIT/CjrkxeLZAGy88z
	+5wbEf4ySl/AlV4/6ZGXAPxiW+DEaNkDJrZgIkvLENnhUlq8KGR5FVoVkh8Fa4qsNkb0fQAEIr5
	YJOdSMXiH+Qi2QJHztoT4JxZcfTXoiD2p93YxqPY6ZokbRiOOjWepFqSOClvS5SlIIFRcbJikZg
	y3pRGtJiOpipFwoFLEvSCqhbeY09axHh1P9J3SpUQBPkXUBpCnA6HzxkAQrrn317Y2SpwkPg+L3
	MW4H36wdb2c+CGp22zUPfivLIGdpzJw==
X-Google-Smtp-Source: AGHT+IH/LPOY6EdLpQ4WZyr4CFwwWgcwPIfhph7cY1yr7qBNUx6wNAaF1jfUGY6TXLaEzfxnRy9LdQ==
X-Received: by 2002:a05:6e02:3f08:b0:3e3:d822:f180 with SMTP id e9e14a558f8ab-3e415c763a9mr66919595ab.0.1754142872030;
        Sat, 02 Aug 2025 06:54:32 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e4029a2ad8sm25556635ab.15.2025.08.02.06.54.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Aug 2025 06:54:31 -0700 (PDT)
Message-ID: <96de1bd4-2272-42ef-a1b5-1c944c3da988@kernel.dk>
Date: Sat, 2 Aug 2025 07:54:30 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v1] bpf: correctly free bpf_scc_info objects
 referenced in env->scc_info
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, yonghong.song@linux.dev,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20250801232330.1800436-1-eddyz87@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250801232330.1800436-1-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/1/25 5:23 PM, Eduard Zingerman wrote:
> env->scc_info array contains references to bpf_scc_info objects
> allocated lazily in verifier.c:scc_visit_alloc().
> env->scc_cnt was supposed to track env->scc_info array size
> in order to free referenced objects in verifier.c:free_states().
> Initialization of env->scc_cnt was omitted in
> verifier.c:compute_scc(), which is fixed by this commit.
> 
> To reproduce the bug:
> - build with CONFIG_DEBUG_KMEMLEAK
> - boot and load bpf program with loops, e.g.:
>   ./veristat -q pyperf180.bpf.o
> - initiate memleak scan and check results:
>   echo scan > /sys/kernel/debug/kmemleak
>   cat /sys/kernel/debug/kmemleak

Thanks for fixing this. Even though it's already applied, I did test it:

Tested-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

