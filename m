Return-Path: <bpf+bounces-41296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8A7995825
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 22:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09FA31C2126E
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 20:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC70215029;
	Tue,  8 Oct 2024 20:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d71Dakmf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989D121501C
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 20:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728418145; cv=none; b=Hq9GiryvtWaCaD2p5nmKbsNpF7LXSwZcCWjibabbqUjyG+nY+eeulXRgifen4rZc6PI83xnwQJsfW7N6Cu0bY6bB38hlGopTmrl651bTzM6nkxCTqmbd+JmBCvzaIbvunKkpjOyYOpVd9ts/2CREzPwLS0HCwOoCj6mdX2Rjnfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728418145; c=relaxed/simple;
	bh=96/WBjjCEcTbhseVkSHqRdoAVNyBPwQ7jQ4AqTUbNrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qWJRdSOMH268s03DGHaggZpK48RHcsI8+lupPBFJmOugjSbZbWYgadvBL+vmL1yaH5xt3YKyXrrDUR/zsx2cRA6imAfOfgWUCDTcfjU+GX5n/eW+2znTFO9U4uRTLXtM3fZTQk7SQpFfgbuh3c49rA6+Q1fulgafjC+wUWDXMxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d71Dakmf; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-82cdb749598so257369939f.1
        for <bpf@vger.kernel.org>; Tue, 08 Oct 2024 13:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728418143; x=1729022943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9huRF/wNisHHqCSWMJS/4iRoGweiDoPtDUbse6lb6K4=;
        b=d71DakmfBmwNVz5JYQ9E6ssL596Ngaqa9W4eF7arqc1x4UzEKI0BH2DqhG/L5kHYeP
         FYm7lr39ALILaIcoy5PK6774YB1++A6w9jnAR3KWrtuzYGKtmSiWchDb9NsYAiW05jYF
         XWTgg315leIGR76gbMdVicAbp0RXXrx6TE2i0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728418143; x=1729022943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9huRF/wNisHHqCSWMJS/4iRoGweiDoPtDUbse6lb6K4=;
        b=jQSfJopiF6ZEsjp/lnCGKITbhVQ5mo/FV5zmYFPSNFVH8XLdPlwWsEQvGZ0gNJ/VsT
         Zsg0cZZLo+7apAnuOYXdBhTS7RIhKI/jiYF77Y1aBcwVgPYXLMdcPGn/CXLNeGWGXAwV
         9eCWLDQVwxHbqzfi0hkj1W3TW/NMT6Se+lR2+RGmmKQLmZHY1jOk+D9uz+yK58HWsgrU
         dIwavMnYmtsx930Vvkjgw00An81haVk1lGiUwXvIKqWS4oZBWHQRX4hxPwsQwECECVT0
         cacitoGHHS7d+ZEe9a7KdqDkhmGXUj14rAx41r2Bhn7XM0O/EXfYfxLyVnoeYudSxhG5
         p7dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCpnQBA/twk1XAHjGuybNa3U6AL5qWH6ZWqERB8JvgiIPsGNXyP0HS3hE0zHNp2tWmfYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0D3Bd4EkXYf+Z2Szcr00m+oayimWSc+2v4YcxpMiqqws+S5Cs
	2qnvhC2vU+eNyuDyyw9iW4tG8rVPIU1XEfAxE6FbPp6SzRTAxXsMUedqtU9m/n4=
X-Google-Smtp-Source: AGHT+IGHl7cgy6p1Go9Zcy53EN9p/6bAdeTKO57a6EqLNuq/Hk7nBTr1o35VUqdXGpWut7AJPDr5dw==
X-Received: by 2002:a05:6602:2b87:b0:82a:2a0b:1c7d with SMTP id ca18e2360f4ac-8353d484d1emr23105639f.5.1728418142626;
        Tue, 08 Oct 2024 13:09:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db83190a9asm1220476173.91.2024.10.08.13.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 13:09:02 -0700 (PDT)
Message-ID: <efee099b-f478-4bfb-8c6c-90934934477e@linuxfoundation.org>
Date: Tue, 8 Oct 2024 14:09:01 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests: sched_ext: Add sched_ext as proper selftest
 target
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 Anders Roxell <anders.roxell@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241008153519.1270862-1-bjorn@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241008153519.1270862-1-bjorn@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/8/24 09:35, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> The sched_ext selftests is missing proper cross-compilation support, a
> proper target entry, and out-of-tree build support.
> 
> When building the kselftest suite, e.g.:
> 
>    make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-  \
>      TARGETS=sched_ext SKIP_TARGETS="" O=/output/foo \
>      -C tools/testing/selftests install
> 
> or:
> 
>    make ARCH=arm64 LLVM=1 TARGETS=sched_ext SKIP_TARGETS="" \
>      O=/output/foo -C tools/testing/selftests install
> 
> The expectation is that the sched_ext is included, cross-built, the
> correct toolchain is picked up, and placed into /output/foo.
> 
> In contrast to the BPF selftests, the sched_ext suite does not use
> bpftool at test run-time, so it is sufficient to build bpftool for the
> build host only.
> 
> Add ARCH, CROSS_COMPILE, OUTPUT, and TARGETS support to the sched_ext
> selftest. Also, remove some variables that were unused by the
> Makefile.

Thank you for adding this to change log.
Maybe we need to add this to kselftest.rst at some point.

> 
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
> v3: * Always build a build host version of bpftool (Mark)
>      * Make sure LLVM style "ARCH only" cross-build works (Mark)
>      
> v2: * Removed the duplicated LLVM prefix parsing (David)
>      * Made sure make clean didn't do a complete mess (David)
>      * Added sched_ext to default skip (Shuah)

Thank you.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

