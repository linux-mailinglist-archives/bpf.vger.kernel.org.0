Return-Path: <bpf+bounces-29859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DB78C79DD
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 17:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAE0F1F21F35
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 15:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEE814D6FE;
	Thu, 16 May 2024 15:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g2MMtuiR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FC214D433
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874907; cv=none; b=jRuOeBIKXbcr6EAC5WeDbU0t9ftliTYib1CCD4wxUJ+QKvZPunsN7bI8oW+B92rMMgEUz7JDuum68ahzyTFsTRLr1ZMVk5hIMVcLVBAkgD8OaWsZCrXFMCL2yqbl5o/C/biio+KhRM0tgr5wNxeyS4d634y8CgCYCYRfdzQecxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874907; c=relaxed/simple;
	bh=nN00p+BB6G3oXDgct+EBmEwHz4fIJMGD6RriYL6RGhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZP5yAL/tWQ9uQkwUg9LbJQnG48CjNABu1J+LWvP5irWBVBYzzsxqJ/XFlZ3eWAk3fCn19qKI9czCT4pgbyJHizDpQhEpXiaoImnr4PF+5BFsNPYzXRBKHVq2RMkS16chiwKZ5YXl3Ub1rAHh+xSBWf9bGAw75heDJBldEWHA36I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g2MMtuiR; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7e1e787d8d8so6616939f.2
        for <bpf@vger.kernel.org>; Thu, 16 May 2024 08:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1715874905; x=1716479705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ab4/9SXReNXDQjfL5I+PFsnXsCfrtKWnsASearG9QQU=;
        b=g2MMtuiRfR8eHXbLO01GoAyMEOgBmWwpF20hCztLiCp2zPTkPtmpSjvaUsPZUBsfaA
         BGotKNuX3/E07EZ4cDdg2Fb8ZTArNUIS2XHGHS0OgLdveMuodH/vKu9T6QCsARjYGgDE
         MLB5r4wc2CdpXcSXJQ0+NxE+SkJjRejGqo1fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715874905; x=1716479705;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ab4/9SXReNXDQjfL5I+PFsnXsCfrtKWnsASearG9QQU=;
        b=qIG753j8weeTFSS/PUWQ3JJMAiNTLNDqFvealQz7LQieH1nODbtQ2GQ1ZRa2Ge+0iW
         wwoS4pn2bzfydI6cPgQeN0+NtV/66XP/VcK0dQJUoqFkFXrX4On9aXlewcfqLUSIzXhr
         qAdZxqqw2M3gw6XGozVbRURZFB15dI5cEVphnDvIWJqyfPjrCudV8NTlPwrnATtEz/AI
         v1SChrT38IDfOGJue6vlWp8xKvBKjQomrPi1KMv0AYqhAZa+KeU7nFwS41QFQR4E40+z
         7J7htJqAvkvLGS3f7umAAdimCHpcT5OX5x8vXSptaOqjmFUfhSXqZznz/lbkm8uo2Bck
         WIcA==
X-Forwarded-Encrypted: i=1; AJvYcCXGLCt+MvLBRXUWkIpVO0FLvnnDC/FRgm5EdmIJAvtH2d7aa4pT6tXsCQYVWA/9qDFUn33l7jBbdQEylabIebm8nrC8
X-Gm-Message-State: AOJu0YzcW7fXc1iK2ESYnoz1zWJEc+N0vljNZqWvf2I4Px1GVvYuiO92
	UQzcOUgUwvdLADXTSWKYwOCq78yRBxBGWEYm3BZMixuucgp4hc9s//Krxy3wIbI=
X-Google-Smtp-Source: AGHT+IFkrQ63gFwV/5y3qWi0SsRylHli+g/GXjCSjbCIbAnwmlot3x2PILn1QDwIRhTHEUwb7pHpvA==
X-Received: by 2002:a6b:d203:0:b0:7e1:8bc8:8228 with SMTP id ca18e2360f4ac-7e1b501f23dmr1984498939f.0.1715874905028;
        Thu, 16 May 2024 08:55:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7e20378a041sm127028439f.26.2024.05.16.08.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 08:55:04 -0700 (PDT)
Message-ID: <bf762b3d-4776-4041-864f-03094a9bea66@linuxfoundation.org>
Date: Thu, 16 May 2024 09:55:03 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/66] Define _GNU_SOURCE for sources using
To: Edward Liaw <edliaw@google.com>, shuah@kernel.org,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Christian Brauner <brauner@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, linux-security-module@vger.kernel.org,
 netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
 bpf@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240510000842.410729-1-edliaw@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/9/24 18:06, Edward Liaw wrote:
> Centralizes the definition of _GNU_SOURCE into KHDR_INCLUDES and removes
> redefinitions of _GNU_SOURCE from source code.
> 
> 809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
> asprintf into kselftest_harness.h, which is a GNU extension and needs
> _GNU_SOURCE to either be defined prior to including headers or with the
> -D_GNU_SOURCE flag passed to the compiler.
> 
> v1: https://lore.kernel.org/linux-kselftest/20240430235057.1351993-1-edliaw@google.com/
> v2: https://lore.kernel.org/linux-kselftest/20240507214254.2787305-1-edliaw@google.com/
>   - Add -D_GNU_SOURCE to KHDR_INCLUDES so that it is in a single
>     location.
>   - Remove #define _GNU_SOURCE from source code to resolve redefinition
>     warnings.
> v3: https://lore.kernel.org/linux-kselftest/20240509200022.253089-1-edliaw@google.com/
>   - Rebase onto linux-next 20240508.
>   - Split patches by directory.
>   - Add -D_GNU_SOURCE directly to CFLAGS in lib.mk.
>   - Delete additional _GNU_SOURCE definitions from source code in
>     linux-next.
>   - Delete additional -D_GNU_SOURCE flags from Makefiles.
> v4:
>   - Rebase onto linux-next 20240509.
>   - Remove Fixes tag from patches that drop _GNU_SOURCE definition.
>   - Restore space between comment and includes for selftests/damon.
> > Edward Liaw (66):
>    selftests: Compile with -D_GNU_SOURCE when including lib.mk

This above change is causing some build problems - I didn't
notice them when I tested on linux-next. However some problems
are seen by Mark. He sent in a fix for ALSA and a change to
descalate build warn.

Please don't apply these for 6.10 for now. I will take all
of these together.

thanks,
-- Shuah

