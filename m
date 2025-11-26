Return-Path: <bpf+bounces-75606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3EDC8B847
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 20:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E8A0F348F9A
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 19:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E24D3126BC;
	Wed, 26 Nov 2025 19:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TsysUKWx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEB0275AF0
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 19:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764183751; cv=none; b=WDQuiri6E00ZhbA7EUpWvHm/j9YhSbuArDoXDOzXeUtq6LpXWJK4eKApH8woKiBIqgKLzfKOiQtjri8VKj7u+Lc3vqC5V3Hs6YxX1c5dsXtzTJ8AehyDPIl70/RCHYgD9W4dlu3H7hjlb62Inyfypgs9IiVp9I4USesiguo3bF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764183751; c=relaxed/simple;
	bh=W1PUpo6dWXK0rPdCvTUaH9XRtZaF3K1p0u1nxp3Pq1s=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=EyymG/nCrA7csHQzjRbt/bVea0/o0PWalHwe259p0jt5Ch3LiOGnuz/n6TFTO7LBPwKtyyOg8PgXtSsnzina8Zy/BPMGxO/p/obaWxbzQdY2yIgfMtoa20SdVM7/nC6hDlkVR9mjjaSPfbgt7exO1Bkw5Sy1y/wysxdrwJ94BTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TsysUKWx; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8824ce9812cso905006d6.0
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 11:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1764183748; x=1764788548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYB8Y0KQsN9puq6yo3Lr/wYaKvJwald/f9jogb6pOMg=;
        b=TsysUKWxdUJupq6YIixEQOu5+96IpeBQLyLS6BRCZDgWwlkBBlmOheu+3iL9Ma8CjA
         uE/JV6FAt9R4h1XMqqBR8exmPTq4vfJn6uVj/vk56TKyN2ibAK1vI6gheOwkn2UMRk2F
         iMSH+wOZr4RAxw+s3SbgBL5g96AALO7TbLlQCoLtwv+zDsHGcO23N0yZcci2wwU/hdv5
         paQ+czesmKNWEyq3IL62nI3FsUNTLxw3BQOVQ4dEhb4nz63jLrH4sIHxY/4mhsK844WD
         +A12cVzXFOw696BRkWdl6iS0Zu+Pi+fHirCzE3JzOePJnYUwBQCXWy5m3Hb7FtWSzv6k
         cEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764183748; x=1764788548;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gYB8Y0KQsN9puq6yo3Lr/wYaKvJwald/f9jogb6pOMg=;
        b=vQ5xCaKXc2+rOaYzy6FtFDPOk0NBz/vRJpriCEiNt78gPKoi8erVtMR66TaFJ90ViY
         LR01ZPYOpgpuexoNnqT68EZlvqIxSVTUfLa0Ik6l7fDd/aMY03joP6ia8bDPaJ1XPOhY
         pkhSc2PgGBiE9oMBXqyvZ1y1qhxYPIY2lEZPYSrAdb43dcrY/ToL3N2+EUzTVi+K6lxV
         UTGZPzVUQbOhKJ+K4jXQi7ujcapMu20BgCwt3DVuBsxr07Ayic1EBEqwqmGiWhCiAlfK
         NtVhKZp70q4Tt2I7NAtGet2UnGamEwyF4EJb1drecaMfmxVO24xZdtHGNwLNMh6j8uUW
         dtPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWASMKlc9AsSfNW6wbiuBzjqW5EzPX0ISSts8pBc/dhNcwGC+33FkeBTz2urk6jqG9DfJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMnXo52ixociz7ABEKHQJ1EgEmhDVIUDrT31P62dcpAmOwm0op
	Bo1armCvjLC2nXdyX24OMQSxU+BWDfR7ANYngVQx9iUnGBjQ7qRXURcWhxSgG8wbnQ==
X-Gm-Gg: ASbGncu5CZegdQmSTTvH58rTP7bZmgSzD3+51iqP/uCbiTWUiUTfGCVs5kRbDKgDPLR
	QZftxH3mshj0XxKmB0wddJxKL5c+S6ONvh4qyuhHz1nUh4pjoYsfPPjiZymoYhtad8UaOYhi+Rw
	HWIcPHPQOAIFOmsIvvPwZnZmpxYf7YS68ADM4gXpdNB/Rx2I1DEn8u8dUIchiWOROT00duUv7x6
	lffJwDHw7biSq7ujQ2lgftB9NjPtWBQ7uOF/S6LzEXGBzLDSKQQNvaiiUZWgC3z03Nod/cz83Ox
	rh3e6i7nuEjX9/bDk5UWYna8daDm6OxekII7modINYIlYB9e7281+qWWogD2cR4UJHEhj0cP1Wq
	oGXbxqmmET+UXn10bs5UCcQF9Rp/okEbhrd82E2bFgF3pZ1+mnP7wIqmq3OSUT91WvlRILGgPD3
	NXFiwYnPr/80QWTdwHRQ==
X-Google-Smtp-Source: AGHT+IG8T4/wT7NJfYIQjI3dUrJmKBQ4SCJzyLCvci3Qg5iPaR/OrqDzMTS7pfIutp287vkMY/auVQ==
X-Received: by 2002:a05:6214:c84:b0:87c:a721:42f1 with SMTP id 6a1803df08f44-8847c535a4emr274443916d6.52.1764183747209;
        Wed, 26 Nov 2025 11:02:27 -0800 (PST)
Received: from [10.75.85.60] ([99.56.174.99])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e573338sm155075726d6.38.2025.11.26.11.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 11:02:25 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, KP Singh <kpsingh@kernel.org>
CC: <linux-security-module@vger.kernel.org>, <bpf@vger.kernel.org>, <ast@kernel.org>, <casey@schaufler-ca.com>, <andrii@kernel.org>, <keescook@chromium.org>, <daniel@iogearbox.net>, <renauld@google.com>, <revest@chromium.org>, <song@kernel.org>, <linux@roeck-us.net>, "Kui-Feng Lee" <sinquersw@gmail.com>, John Johansen <john.johansen@canonical.com>
Date: Wed, 26 Nov 2025 14:02:24 -0500
Message-ID: <19ac18b9e00.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <aSc1aAdOeSuuoKTH@black.igk.intel.com>
References: <20240816154307.3031838-1-kpsingh@kernel.org>
 <20240816154307.3031838-4-kpsingh@kernel.org>
 <aSc1aAdOeSuuoKTH@black.igk.intel.com>
User-Agent: AquaMail/1.55.2 (build: 105502562)
Subject: Re: [PATCH v15 3/4] lsm: count the LSMs enabled at compile time
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On November 26, 2025 12:14:21 PM Andy Shevchenko 
<andriy.shevchenko@intel.com> wrote:
> On Fri, Aug 16, 2024 at 05:43:06PM +0200, KP Singh wrote:
>> These macros are a clever trick to determine a count of the number of
>> LSMs that are enabled in the config to ascertain the maximum number of
>> static calls that need to be configured per LSM hook.
>>
>> Without this one would need to generate static calls for the total
>> number of LSMs in the kernel (even if they are not compiled) times the
>> number of LSM hooks which ends up being quite wasteful.
>
> ...
>
>> -/* This counts to 12. Any more, it will return 13th argument. */
>> -#define __COUNT_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, 
>> _12, _n, X...) _n
>> -#define COUNT_ARGS(X...) __COUNT_ARGS(, ##X, 12, 11, 10, 9, 8, 7, 6, 5, 4, 
>> 3, 2, 1, 0)
>> +/* This counts to 15. Any more, it will return 16th argument. */
>> +#define __COUNT_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, 
>> _12, _13, _14, _15, _n, X...) _n
>> +#define COUNT_ARGS(X...) __COUNT_ARGS(, ##X, 15, 14, 13, 12, 11, 10, 9, 8, 
>> 7, 6, 5, 4, 3, 2, 1, 0)
>
> You forgot to update _12 in the upper comment.

Do you plan to send a patch to fix this?

--
paul-moore.com




