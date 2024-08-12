Return-Path: <bpf+bounces-36955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CF194FA1B
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 01:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BABFA1C21D8A
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 23:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2B518C92D;
	Mon, 12 Aug 2024 23:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iAFebA4Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA15416EBF7
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 23:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723503836; cv=none; b=Y4laghRQ7D9ehguyYEKl1hzIL/+rvqcvA6We2bYf5Iz50ZSb2jL/i/eT9UoZAYLBuOLg69CumxQwun3QFavvlKfNUTlHsC+OFA13lSV8L3d1ar20zl6jkJuha+VOkdNGp9mRf+NnNFBPwXWxvAAHoTbuH3tEkN8XwlN2Zd5jYf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723503836; c=relaxed/simple;
	bh=YBiLFaPZjjaRkrtUK9kyWuh07zpn3P9QXmFySdar89E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gN8ab5Vg5cpVFM7eWPJjjd+OOkyxVxXGAbZiUmQa6dc197lCfRo/Ah1eGeQRjfrQwFLpRzD8l6raXL2SREL21me5EujmXNAJt58wltvGk6/lg+UYiyqyCgaj856mCPTTAEywQDaAH0CPrrJZI2Unx8MjvTSmaU2os81/GuPWiXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iAFebA4Y; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2cb6b247db0so911220a91.2
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 16:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723503834; x=1724108634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QEKpiUP3xwZoC0DTSabt4UIs6f5YDF2qKl4QrqSYpJI=;
        b=iAFebA4YYfeUXURbdde47vTzC30mCbtVUlfCyD9cbim8LJsHWd8fOCXs6/WRZ5OkgA
         XXppdgnhG34TUyNxD5mg/fsIIrIzLHyDhqDUdjDI8aGEO8z33tiYOWvYp6FcwbkPTLiy
         K8EW73r6iIDo6w9pvU3nTOZGYEWQ26gI4yZE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723503834; x=1724108634;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QEKpiUP3xwZoC0DTSabt4UIs6f5YDF2qKl4QrqSYpJI=;
        b=MInpxJ3J1zGuN0U/XoBNcQQ9XC8Xahplf0p626/Iw0aJF8mwMmQ7f0Y/EbCQ6Rt16J
         RgYqISTzdef+zXN3G9iN1rC/vwHMnOUyq91Cr/70vkMoujCRWKYOQWkE8H0vsfty7gq2
         fRrPT2DCq8uL5pKkrDFWL/0+m31BSR6ShcuLiAqH3w0fwB0QxuWcV0kv4uv2lqX4clYI
         bLfVguV+sWvMIGmXQCuf0smcDnOew+xgoZMISiChobyvc1npg6B0mEjY5zuyvIxCQRfJ
         +/yMvvRoV5D1j7MU6+Gm9z/fFdtXwQR5OI7rpg0+X80N0sF4U4/zyTiYc+swW+zkKF5m
         wM/g==
X-Forwarded-Encrypted: i=1; AJvYcCXWZhueF3ud10EHoA5LAxD2VKKTDLgHFRoi0syDrj05PQ3gkab8CI3iRnOxVbfRafd96oY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3zHZN/THEK+kFTwhnHu/5c9gtoy4ZsU/HzkWqgREri34mjeJU
	Q860jwSp11vId5N6vtSaZQp/SqMw3cXFUrj68IRZ3bE6Hm+WDCXqO0fPuaRmNag=
X-Google-Smtp-Source: AGHT+IGb+9VJLkJYuRsUl48a3JmkbNs0x0SRG38sB9+apl0xp9rPYfz/uXrpREF3TxW5/mERjhINag==
X-Received: by 2002:a05:6a20:431e:b0:1c4:b62f:fec7 with SMTP id adf61e73a8af0-1c8ddfc652dmr266014637.9.1723503833885;
        Mon, 12 Aug 2024 16:03:53 -0700 (PDT)
Received: from [10.229.70.3] (p525182-ipngn902koufu.yamanashi.ocn.ne.jp. [61.207.159.182])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c697a06af5sm211486a12.45.2024.08.12.16.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 16:03:53 -0700 (PDT)
Message-ID: <3667e585-ecaa-4664-9e6e-75dc9de928e8@linuxfoundation.org>
Date: Mon, 12 Aug 2024 17:03:45 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: fix relative rpath usage
To: Eugene Syromiatnikov <esyr@redhat.com>, linux-kselftest@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240812165650.GA5102@asgard.redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240812165650.GA5102@asgard.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/24 10:56, Eugene Syromiatnikov wrote:
> The relative RPATH ("./") supplied to linker options in CFLAGS is resolved
> relative to current working directory and not the executable directory,
> which will lead in incorrect resolution when the test executables are run
> from elsewhere.  Changing it to $ORIGIN makes it resolve relative
> to the directory in which the executables reside, which is supposedly
> the desired behaviour.  This patch also moves these CFLAGS to lib.mk,
> so the RPATH is provided for all selftest binaries, which is arguably
> a useful default.

Can you elaborate on the erros you would see if this isn't fixed? I understand
that check-rpaths tool - howebver I would like to know how it manifests and
how would you reproduce this problem while running selftests?


> Discovered by the check-rpaths script[1][2] that checks for insecure
> RPATH/RUNPATH[3], such as relative directories, during an attempt
> to package BPF selftests for later use in CI:
> 
>      ERROR   0004: file '/usr/libexec/kselftests/bpf/urandom_read' contains an insecure runpath '.' in [.]
> 
> [1] https://github.com/rpm-software-management/rpm/blob/master/scripts/check-rpaths
> [2] https://github.com/rpm-software-management/rpm/blob/master/scripts/check-rpaths-worker
> [3] https://cwe.mitre.org/data/definitions/426.html
> 
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> ---
> v2:
>    - Consolidated the updated -L/-Wl,-rpath setting into lib.mk
>    - Described the testing done in the commit message
> v1: https://lore.kernel.org/lkml/20240808145639.GA20510@asgard.redhat.com/
>      https://lore.kernel.org/lkml/20240808151335.GA5495@asgard.redhat.com/
>      https://lore.kernel.org/lkml/20240808151621.GA10025@asgard.redhat.com/
>      https://lore.kernel.org/lkml/20240808151621.GA10025@asgard.redhat.com/
> ---
>   tools/testing/selftests/alsa/Makefile  | 1 -
>   tools/testing/selftests/bpf/Makefile   | 5 ++---
>   tools/testing/selftests/lib.mk         | 3 +++
>   tools/testing/selftests/rseq/Makefile  | 2 +-
>   tools/testing/selftests/sched/Makefile | 3 +--
>   5 files changed, 7 insertions(+), 7 deletions(-)

thanks,
-- Shuah


