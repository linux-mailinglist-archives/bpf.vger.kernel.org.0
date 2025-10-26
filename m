Return-Path: <bpf+bounces-72213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCD8C0A505
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 09:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE4014E15A7
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 08:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13542877DE;
	Sun, 26 Oct 2025 08:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMon76BZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01359286D7C
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 08:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761469134; cv=none; b=fqMek2oUk+XI1B4RGHl4LjaKxLGSUg0wDxa0cUBWOumz6DvnPLhYStQyQrRrAAmGLtU1FcipHF7PLBtg6fAVzcYwK0L8U+cKO276yj70cc3WOya6WYI1SDj3QIRQS2H2K45hzyphsXasnZQaoTM9JI1aOQp3AwJkbWiFoiUzsMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761469134; c=relaxed/simple;
	bh=5K4B7s96EMwwaDVEBzoytBv7iE1q9RzEsf4agH12XZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJJJADYjCYhh8yE/inm4egSO+Dt7uDGLu2t9AIbH2RMCAuPEJCIAfMC1VeJmcvIvNdoTJ5hNxEnghOvBTNsa9YHFlVpF5JQcm+YLefXVlucgEGe7RtOkC0Ib6HVjH+oIMemD5GHcspmv1PIu8AQV7lgprmWKBgX/L8VIqNlBpdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMon76BZ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b6cf257f325so2993568a12.2
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 01:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761469132; x=1762073932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5K4B7s96EMwwaDVEBzoytBv7iE1q9RzEsf4agH12XZM=;
        b=KMon76BZA7iezln/XZHUxCJhQZRX9NLslCTWfW4lw5hmD2wCcGtMu4pKPaJ3VsdD9M
         7uhj9fYLjxEBKBiZNR+C0qvElKvses1AxCRZv8V4LpiK5vB08UyCWdW8Oxmh1m1ybR9J
         P4YbBSK5ZSr5ncBRV9s7d4eKpTIfWE4k4aLg6b8jphC+6CzzEXXM/lSjT5KN4j7ZGCma
         NvUp/jOhal7A3Of8+GF3/TAdI0o7Z199/l9hqgBQLODggg164fypvwuZlBEZGYP6P5Py
         qfb5tfmvzCWLni/vQ0rKyWlrQJIVtNJkXpJx2tYZrUyu0VZbtigNn/cEbgnAnZ9PM+/1
         GOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761469132; x=1762073932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5K4B7s96EMwwaDVEBzoytBv7iE1q9RzEsf4agH12XZM=;
        b=J3b6p4wS+fe7FGRVTiBLA8cWgV8Q/cbLLLCIhmv7c6X7wIhyG0UX8gRmJE6PB2LU3X
         pQW7ed2Sv+4B7Lnb2TE6jwVdlgEDqeM/PAruOuJxKqaG5hv8GZzCTd2QxCq54oQFssUa
         EfTE3ONcaqlT7+QG2dgdJFc2fJsa3azwzlpTMEpKeYrAGM4vNngvnpl8X491t+AYBeJk
         PltUB58cLM3h1qkYstIGFqIr/j2kgYCZrSZS8ONeqExbWIVwvDTiXMOFU7oSyCsfmXG3
         p8bJENLgN9fWCWTcXqro2dC2qavYigioHfQwy01DRSD6hyn4ip9gg1cqYsY1shqwIbWQ
         rz3g==
X-Forwarded-Encrypted: i=1; AJvYcCXO40t9x2yAMFXbxoTjRXKynd3LdAIl27x8Se0VzYVrcE2nu8E62TK2Qk61jVvqa9k8e/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6cNuUsJlFMmmpMljrx4kJ6XM787BbHyLH6xbUZCVERFdzo6rm
	Q34MH1xPv5WzhMgCo+PkaSHrRg6BWa8IzaEj5ERMPN3Wr6cVGFptrnsU
X-Gm-Gg: ASbGncvcq8nnmNfK+rbP1Y7ngo8h2S4yuT4u0UbZo7O109gd1hNkPsLYsQ4smIvbDPE
	BApeEgyvgpqV9dV8I1zpBVPOnA3octaCzhY4dYYrPnEHMZWM0H2YhT5A/qw9rOiNhBUAtU/iAal
	GYLqgl/KkRYie2bVpbH9ydmWhvr86+OOicPzRG8F4fgUQFYePkbiQw02K69k8Ly+XWumV/NIYob
	J2jy9gwIMFHSD38R4391Free/7uQW/BjpPLzK4tMr5bCjaIPAWx2R7sLrVGTXtJkRNdm7GSCIob
	pwv5tEUPY65eN0fmHt8O0KoSGOdS+YWSm8g/TlwmEGtenlLh8LwR4uDKhM2cCWrS4F7LxPlB9Ou
	JNYYK18Q8giFsKQBP7JNCGHpdUgtPxiwwg01pSEaRJlcaDVVNIUaVirKS7d79S24qalrbBe/mjU
	3e6eK9a43cpLepVfjpAzNv3zBqqeUi313152951O+Y2Dcdcr46kw66aCmBMSySeLAZyOCoZH3al
	yKebc4r0YDWUekwkiiBSlEw16LDlR679Q==
X-Google-Smtp-Source: AGHT+IHbY4zR+pxQ2HAXsXrhA3W5dSP1Wj+vZRqqpwWFOwc/lu9gHcqd7/GoXq4UV6YsapVAtB9Wiw==
X-Received: by 2002:a17:902:f690:b0:290:ac36:2ed6 with SMTP id d9443c01a7336-2948b97fd44mr101660985ad.14.1761469132156;
        Sun, 26 Oct 2025 01:58:52 -0700 (PDT)
Received: from ?IPV6:2606:4700:110:896a:5f1b:2412:be21:3a45? ([2a09:bac1:36e0:1c0::10c:2f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed70a83csm4611330a91.4.2025.10.26.01.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 01:58:51 -0700 (PDT)
Message-ID: <da05d1d1-c241-49af-bed8-7db5e9968396@gmail.com>
Date: Sun, 26 Oct 2025 14:28:46 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/seccomp: fix pointer type mismatch in UPROBE
 test
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, khalid@kernel.org, david.hunter.linux@gmail.com,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20251025184903.154755-2-nirbhay.lkd@gmail.com>
 <aP0-k3vlEEWNUtF8@krava>
Content-Language: en-US
From: Nirbhay Sharma <nirbhay.lkd@gmail.com>
In-Reply-To: <aP0-k3vlEEWNUtF8@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



Hi Jiri,

Thank you for the review and for catching that inaccuracy!

On 10/26/25 2:48 AM, Jiri Olsa wrote:
> just probed_uprobe right?

Yes, you're absolutely correct. Only probed_uprobe has the
__attribute__((nocf_check)) attribute. I apologize for the confusion
in my original commit message. I'll fix this in v2.

> curious what compiler do you see that with?

I am seeing this error with Clang 19.1.2 on Fedora, which enables
-fcf-protection=full by default. As Sam confirmed, the error occurs
specifically when CFI protection is enabled via -fcf-protection. GCC
without this flag treats it as a warning or ignores the nocf_check
attribute entirely.

I'll send v2 with the corrected commit message.

Thanks again for the review!

Best regards,
Nirbhay


