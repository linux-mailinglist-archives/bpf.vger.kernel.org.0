Return-Path: <bpf+bounces-19868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61958322D3
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 02:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59382863D5
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 01:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3315EC7;
	Fri, 19 Jan 2024 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUhs0stf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFD181F
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 01:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705626006; cv=none; b=LCqNZUqRM1QNCSGhTcoC5vzwFHGe5PQEt9Fl3WXhsYObR/XCOM9ohto9EUHPABpqGsnLhgYjI+jQU4EfS33kgWPEyRDCcjA8CWqL0RDg8/lgaRg8EybBBRfGWZcrPXvjFE2YFvD/jWn7uL5SYMlR+6GnXa1WfnawQ9UBWoa15/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705626006; c=relaxed/simple;
	bh=TkTCBA+7SbCI7t3UlsAYLBt0cu0BVjQRmL23N2Wpbtk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mDWj2p/ZDBkTRbcq1eUrV/2okRWNtPMhEs0r/RVbmr6ySb35K2QRYjFtfTTqfWCLU9Vwzr03INFp+tdSie7j6QEoxfrKYiG7cvvSjIH22guqB/mo93GXuYTw4KjSfY1spuoyD7ctd3AK2krDs6rahEW77612KX/wQ+S5V/vlYRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUhs0stf; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-337d6d7fbd5so544346f8f.0
        for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 17:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705626003; x=1706230803; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TkTCBA+7SbCI7t3UlsAYLBt0cu0BVjQRmL23N2Wpbtk=;
        b=RUhs0stfzo+SxQwLskxJpocdBk+haOYV1pTirG+mZtBY+DnFcRpYuND6YNGajFGose
         9VQmJOiOxvy6SAxj7/qBLwUgSx/5bQZahhVvaApybHP5KMoGgm7ifi18GhaquHiGdUYU
         6cF6+yyaFoBf5HxCHJjIkHeZbU8YiHtzJWC8B1or/UsF11p1yYmGV5i6x2BZmWhGukmQ
         BwHjDHtdgDTBcj5ixBwRjSH4Y1O0ZWTQGOszhCL1DjtnFwAjymOP406PB9+lbfW61l6n
         O4BJ+nw0eg3IS1tH4VjKJBRQx0BXi5s1M9CEV0FxozhLuOjbf4tTJKMB9LRHZdf773I+
         RtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705626003; x=1706230803;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TkTCBA+7SbCI7t3UlsAYLBt0cu0BVjQRmL23N2Wpbtk=;
        b=ET0nggCoJ+AmxEtVSrDkHtZ06wNT5u/7/RN97qVfUeC4tq1/C3b6hf1fvev+AHhlD1
         Ky+iZTGaW9TDnZx0qa5Kdl+R9CAzoASd4p3iqeYnx1U45prn/N5r7IsPGtwAVcus6eBt
         cNXl1nPb1BGflATWnh4d8Um/z760cHxMMZG873NUIAssYme8T+/q5ntZZk4kCb9Yg5u0
         yxVaM63A8d9SwDiRsc9oxbWikw+jroDLP/le+msZ9pUpFlVJDteRoxSh3zaHyCeAmoLo
         P9rG4ChMtnDxZSTvSlW4SWhLi++p9VHwBiKMc3ZYpt/2QidnVJ6L56ODM/VNQbKsTT7j
         Swzg==
X-Gm-Message-State: AOJu0YxDPVrHub+3unDXZO5L9Yrmd+ckgBZR5QJZ+qMEQ/9eZg5WrnqJ
	jeC8ttTU5WErr4bh9v5xXOedeXhHgPjg0yJ4RJnKwsdI7Pk4op+U
X-Google-Smtp-Source: AGHT+IEQwzqr6gNe7LV/y/eCfFTBpvND13duoSrGOEToB5OGX6kl6zri+Xwd9L27BpV5lt1Lz2/WRg==
X-Received: by 2002:a05:600c:43c3:b0:40c:6939:b470 with SMTP id f3-20020a05600c43c300b0040c6939b470mr93386wmn.53.1705626002807;
        Thu, 18 Jan 2024 17:00:02 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c198600b0040e48abec33sm31145277wmq.45.2024.01.18.17.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 17:00:02 -0800 (PST)
Message-ID: <b1b0c9d161ecb80df4385978a2fd770a8248691b.camel@gmail.com>
Subject: Re: [PATCH v2 bpf 5/5] libbpf: warn on unexpected __arg_ctx type
 when rewriting BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com
Date: Fri, 19 Jan 2024 03:00:01 +0200
In-Reply-To: <CAEf4BzbRfMx5s9YvjHkQ+yjAd8EB43Lk_jg3Jg8oEnt=pjr8FQ@mail.gmail.com>
References: <20240117223340.1733595-1-andrii@kernel.org>
	 <20240117223340.1733595-6-andrii@kernel.org>
	 <e4a6106a0b4247cbf83c2311e60f69b10ef1517b.camel@gmail.com>
	 <CAEf4BzbRfMx5s9YvjHkQ+yjAd8EB43Lk_jg3Jg8oEnt=pjr8FQ@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-18 at 16:53 -0800, Andrii Nakryiko wrote:

[...]

> yes, it's a slight deviation from what I ended up doing in the kernel,
> because I initially didn't know how to deal with arch-specific
> definitions of bpf_user_pt_regs_t. But at the last moment I figured
> out that __builtin_types_compatible_p and forward declaring structs
> works, so I'll do a small follow up to libbpf to match kernel logic
> completely

Understood, thank you.
I didn't know about __builtin_types_compatible_p() before seeing it in
your patch. Full 'Other-Builtins' page of GCC doc turned out to be
interesting.

