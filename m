Return-Path: <bpf+bounces-73622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77865C35B39
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 13:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225901A241B5
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 12:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB60315D30;
	Wed,  5 Nov 2025 12:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVn2wPTi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7541305E38
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762346883; cv=none; b=MA3PaiKWiqvX397OXRUA5t8aYkSGn4EV7UHqelQMAWvpkRojYofJmeFlRoZj9vxvdwXaQFWQ1fD95tEPI3aToV/NwAl/pjaLopkvHeZGaHN3Xhg8BgGDIM4DMnFYPjWDe6N8tkFYGb1R919cF102pBIW+F9EpzRzxQb6Mqw6Jgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762346883; c=relaxed/simple;
	bh=uITf5cz2xqHm/ZQm2B6vRD+A2Et6+dmQIdzdkF5oMgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtML9HHSQh0/jGEsBAFx7Ch0xIMgyo11dF+y0c86qxLbmqC1gfqvdTlcAugRquytls6AI1O0KTRdEUrwQfS2DENA+N6NyfrV3zeWtjx4FVx+ByZL92RkhlyHWgGeprSkZ5V3dPC33W/XWEYjWZFTsczDf18AnO41hG78T/exlLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVn2wPTi; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-471b80b994bso83900455e9.3
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 04:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762346880; x=1762951680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EEw+Oxq6xNnZGC9654HJZ1EwEcMiVMmcBMqIAYuQWtY=;
        b=FVn2wPTiz6wqfRrhIXGa3HbVxBJdqhir0QK9lEt00VULLDMOhS8RhL6A5x0UN21AXJ
         TGGC+L8c/RbW+UHgb86g4PNibqq6x1BV4FrQN4MAT89wRFVtF9fnxejry0iVoZP1aGhe
         /rMsEII0QQT9+2WcRoNzYTqXaFPOfojDUj8rjNPQUvsfLPtSfeJaUu/orDopt/nJ+6L2
         wYE9jniSS9qIATwCgC8wr0/SYwhY1/4HT8eOOahhUTmrzuz/eYO7D/TjFIsqsFXgo6jk
         3CpRy51WLEd/JvePIo70S/uY95V2cKGGnkd7MYcrpksopOOx8pyKpX/BzONtWjTCyw3M
         JsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762346880; x=1762951680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEw+Oxq6xNnZGC9654HJZ1EwEcMiVMmcBMqIAYuQWtY=;
        b=ieLnbgteMWIRhyVFPxv8yTeKPl/bcHyo5Mg7j8RlOZmbxhzFork5vaP6mUJk5HnAIJ
         rHEK9FaiY7d8Gqh1oBnXpa2UoHrD3QMB6Ij6UnWuRW5rpjC4Db8eosvk+wg6Ugs0ll8g
         Zw2lEmBaKkIoGW1xJH2jHBbgn3ftCHswX6VAw+zbUBT/qYaWP60eTc1GgX4WnG0V42dA
         q/P12rM+RUEbJF/MFD/eiFcdP0at0tSg9UBaUiGpDXZKSnDNEzWbBqq6ctQS8Y/S4suJ
         DYuySk/loTD3L4Ao+2E4VL2vWcVmo/pEdhZ9m5dFVByV/y6A5qXzYxZWnyCQjG7qAtnF
         DabQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQam1SopvOr7oPzXA0eI7KhxUe5kOwWAb9pBu8UGSqaU7+/ZQAaFbOPK1UWofcAe55FfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx91kENcjgHUz8184D7lnDWx5PyHg9/YICQA1eaeL5+tjLf6ZqX
	Tnk4TAi023PSQdgdA9apEtIfmJR1kP1aapNK3m9XGoOZdDzJU7cn6eF3
X-Gm-Gg: ASbGncuF3u5y2UCv2L//LZqmGK2Ogl/lABRIecsXpFz94DA/fOlw+fd+EswkDosLpHO
	jxdBlTrbIdxy4WyvFjrEQX8c3sj9Z3BElz7Dfqrcad/CtfabbSfie3Ci4/cMBfednfi3m1WLHK7
	QspnOfdUPfT4L9JbJlrB9hLl7MXPhND7HEUFpGG8/yIEd5IqYfwnW5QmpgWge7PDgFm34ticEys
	ZwBKs/FxbukoKjHL2jDw9X2sOiKHUd+v5ssWHAkQ3iLRAgjV75G3BWlh5OTk0O3DrjF6y5bqFzV
	frEd6P4NQbWgODexA1qxdlyX4yQdi4DNb1zwn8n1J+SfIYKlb5wiyM1Q6DXZsAICXEcdOuEisQY
	BBmn5LZkDKmzQ+XESR9Ts7+ydoWsqvj7jQobcWU9XDnNNRcDxxJi46kgTf1C7o0nVgWU2d2bYeF
	D0L5wTVZud2e0fmPRCH47vTNZ8dYoo5SK6z0Yrykbp9bwvthSQAiE=
X-Google-Smtp-Source: AGHT+IFINos5ANaGYcgFtUYkq5WlLP4oVoAKIpDU6+DIih2zYDOnM3Vr4FolOBEF1w7JoKVEdzzFNQ==
X-Received: by 2002:a05:600c:4e88:b0:477:54cd:2021 with SMTP id 5b1f17b1804b1-4775cdad736mr25743725e9.8.1762346880061;
        Wed, 05 Nov 2025 04:48:00 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775fba5311sm25758435e9.13.2025.11.05.04.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 04:47:59 -0800 (PST)
Message-ID: <891f4413-9556-4f0d-87e2-6b452b08a83f@gmail.com>
Date: Wed, 5 Nov 2025 12:47:58 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] io_uring: add IORING_OP_BPF for extending io_uring
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 io-uring@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
 Akilesh Kailash <akailash@google.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>
References: <20251104162123.1086035-1-ming.lei@redhat.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251104162123.1086035-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/25 16:21, Ming Lei wrote:
> Hello,
> 
> Add IORING_OP_BPF for extending io_uring operations, follows typical cases:

BPF requests were tried long time ago and it wasn't great. Performance
for short BPF programs is not great because of io_uring request handling
overhead. And flexibility was severely lacking, so even simple use cases
were looking pretty ugly, internally, and for BPF writers as well.

I'm not so sure about your criteria, but my requirement was to at least
being able to reuse all io_uring IO handling, i.e. submitting requests,
and to wait/process completions, otherwise a lot of opportunities are
wasted. My approach from a few months back [1] controlling requests from
the outside was looking much better. At least it covered a bunch of needs
without extra changes. I was just wiring up io_uring changes I wanted
to make BPF writer lifes easier. Let me resend the bpf series with it.

It makes me wonder if they are complementary, but I'm not sure what
your use cases are and what capabilities it might need.

[1] https://lore.kernel.org/io-uring/cover.1749214572.git.asml.silence@gmail.com/

-- 
Pavel Begunkov


