Return-Path: <bpf+bounces-59709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF34ACED8E
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 12:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B7FC1897E30
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 10:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0D4214A91;
	Thu,  5 Jun 2025 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfGLdAW7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095A91A2C25;
	Thu,  5 Jun 2025 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749119241; cv=none; b=KxUdTw8zg0bqEPXRTTat+STR8h710eAVQBQnseuVJK9D0xHD9qqsZcnK/c72jOJRjg71p4bccYaBDYuBKW1IejpvtNgM80o3QgRhh8YNxihi8d2YO+LfQm1GAD4chMcJxL4C/yZfSSdx1NRReuorhQ2VFSjNyUw5FNdGVOz5kFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749119241; c=relaxed/simple;
	bh=T2RvDihfMsBhnDg7XgaOL8G2jtNVR2PNfbYnqzehYbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MbcZmBRKZHVpOfOOnRzP/FNI4MSquKH1qk/JAOkOXwywIq2I62bJuCJgkbN+s0sqr1got7JMzF2STnFU5LW0c+CfI+tFdbsADg5H5QUgENB0uJoImNowarJe8rDEjeJ0FiuM6j2tz+jaNKJkVId/kxPzDp8Rlqp8/Sv/XHQC8Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfGLdAW7; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-addfe17ec0bso297779666b.1;
        Thu, 05 Jun 2025 03:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749119235; x=1749724035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6K6zVWh/fSOB26gnxsw1kPu/aC8aflRNQt65lkssL7Y=;
        b=FfGLdAW7kgAA+UMqhhb227soITfdxvzVTex601JfgflfukBaGX3AwKi1KZzt7XYfk+
         pLx3VM8EtCF2eudZrkbRuG8B5eQbe+4qQ4Q0Fn7FWVMZxf0Kg96SsGQEQwr0FMBxYszY
         0JC43YsEG+vT84R4bnwE2LivVqcPsGv7W9+yrVEg3S9aqscSiMN7NFvC4LjUaBm9mOeD
         aukmoFTAIYMK7DK6tmsTwxPp1HkwSVClZ4IWjqhf+EhI4e4lClivPQcLCcxLk4t2WO/3
         JSptr8v8vds+I32VSVZYI5HyOw8qMSJkiEjalbzk5UM+ZaG/BDBAoaii0p6ny9yXF4aX
         jHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749119235; x=1749724035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6K6zVWh/fSOB26gnxsw1kPu/aC8aflRNQt65lkssL7Y=;
        b=cbl/HcboB2AbdmM1RpjxGb1FGpC9ouRYP+AQAKJSEZiDIWhjKzSCTq08QWy5pWw387
         Xs6ftWO8QE2+1Fs6OaWb8n9GBuIkmAa2nKgvWm/7DKiWeVoUFe6KkOmRkBQzWF/J1ey8
         Wrsg/8bgczr0aQRQ7aTxVQYXfh4gVoHhfA09fe0uZFw72DyT/6uc/+QT9k7Uz8uar4am
         dfk40p45yfKfwlsd4iUHlsWpfkl8oe6qYYmTMAxGxPoXQBHhbXRBvlzqsAC+8E32f8Dm
         F0iTC04RhsuhshTIo130+krCnGpIdwo4WOaPPelV5do0Ans2rtcPoYvKhru6WZaul8Ch
         23DQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5HOYpvWQvlpEoGVQ6ZO+dBZP/4WWoY3l968sskfgNlvsFYUUNakZA5pYcCTI6ssnF8i4=@vger.kernel.org, AJvYcCVAFNhDZs6ys+4vmsoLOwL8WVXKdRKEguiXoumm3Qkrfs5iub6RFN582nCsBytk+uCng0j/0MI9FeooAg==@vger.kernel.org, AJvYcCWALENq39Twl44qrCEwuHRda2eodrvbRYyTcqXfXUYirrAngwdLu9llHadAqPEFQ7aaJvU4lyyd@vger.kernel.org
X-Gm-Message-State: AOJu0YzOxR98i0IgWIqBygyA59eyt73/CEDe40T9Kqx3YwyhIowM1Rwx
	gUincjWmJKfRYGocoGtmHb1CmWuiNVUq0Eu1g7PlVdkiDRm0CHMsr1xJ
X-Gm-Gg: ASbGncvDU6XRZzvHXw3oKDDEILdzUUULi5Pm1hT2IDZ8n6kymGFt9aePpKgjj64OpNl
	E2vzrqq3gvBgx0XNzndFEAKC0s7jSXrGxIRluWr0Gck/PWAsVCeXpBAwej79H4mQqCJwByuCFZ+
	II4f/LussO1gY493UoSIy1D5CAe1oFmn3MtGFI9UiqdRNepiw3xj2ooF/22KWvlHwvqB22mOy6d
	pLG5n/Kms2liHgg7w1Mn7VIZo9E8INSXoF3A8RhlfWT07szGrUZ6nBsYp5650t2v7JhXusmyDwy
	DaF327zg/d7UXHjYFZFaZcQFe6XRZvF2ML5SaiU+vwtLbV1xmCJ0C5hrHZ84zttp
X-Google-Smtp-Source: AGHT+IGO8amneLjgex789Nk40DoxGq3hiObG1iea0WjWoUCm27zoS5Sxzso9fdzxau8K1h8g4FxM8A==
X-Received: by 2002:a17:907:3e08:b0:ad8:ace9:e280 with SMTP id a640c23a62f3a-ade075bc502mr274245966b.5.1749119235159;
        Thu, 05 Jun 2025 03:27:15 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::22f? ([2620:10d:c092:600::1:d66f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d84e75fsm1231639866b.81.2025.06.05.03.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 03:27:14 -0700 (PDT)
Message-ID: <1a9757ea-b54c-4320-91eb-e875cf95f455@gmail.com>
Date: Thu, 5 Jun 2025 11:28:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 04/18] page_pool: rename __page_pool_alloc_page_order()
 to __page_pool_alloc_netmem_order()
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, toke@redhat.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-5-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250604025246.61616-5-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/25 03:52, Byungchul Park wrote:
> Now that __page_pool_alloc_page_order() uses netmem alloc/put APIs, not
> page alloc/put APIs, rename it to __page_pool_alloc_netmem_order() to
> reflect what it does.

FWIW, I think the current name is better, the function allocates pages,
even if it wraps them as netmems.

-- 
Pavel Begunkov


