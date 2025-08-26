Return-Path: <bpf+bounces-66533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B14B3593E
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 11:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8576B18948F1
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 09:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2C43002B4;
	Tue, 26 Aug 2025 09:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eO+JHLzQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535A73002B2
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756201317; cv=none; b=EjoqOQIWfiwXPyIVQbawaVIGypdCRws9z6JaBvTTSRbEqR1GoiFaYR03s1Iw6BFjzuWcv52h77rRkmmGhNI1EdCGVxS2PQ8EL88G5C4QVebVa51HidyeT65Ohj7qU1+HKWNPhb8psnItHvokslxseJKGB9kcnuX105Wz6LZ9dFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756201317; c=relaxed/simple;
	bh=6Yi/SP4F+vvFBMFt5ncu7Oa5rF7y/isevPXGyDleOEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7mv+ZYxrf5kmdKvjmCUxhHdkl8pDzRXK+RbjVZOLgioyRMTabYqS5nawugPtiDh+DjNEMZRW0R41rEa0upX0rTVexIM36FHb6ZlZNqkFSHkpoAMsfwpQQFAfB6C2vUk8/jUX+dC82jq+UoavDqrhmFdRhKHNECenclC/Eoa2dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eO+JHLzQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b5d49ae47so11820505e9.0
        for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 02:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756201314; x=1756806114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vqGMxN7g2FZ5I2ZlUxDFgeHjpV96AkI1v/ye9FVXZH8=;
        b=eO+JHLzQfHrTFNDIFZZesd0P0986RANzk6ZiuAemHTepCNtn8iDBzXWjjLhhdVu+EI
         eEOoLbOEnZIac4SmTSPqeWCQuqsP0LiRyD2P1/aGotpSEhb7jsqVqehcD4gp1erq5CZR
         ceT6YAMd9CfCnyih+YqGQeKYjU41ZO4XyHfNn7BXyB9ddxpHemC8hyu2qFYfUvxhfC+m
         0pxH4kygLFSzocwStiBc7h8B+5j0SuZm7t7jNKZkH3TeBieBf8mjcQ53zIMJNmXeb6VA
         M2C2qw1wybyv8D9Ym5w2BZgjBffXbKxgPwc+s+3aJRD9o4un0nQ0GjlszT+IIur+/dOO
         gHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756201314; x=1756806114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqGMxN7g2FZ5I2ZlUxDFgeHjpV96AkI1v/ye9FVXZH8=;
        b=FfiPwY4uHrje2Smpb/4udVSQooOQNjyvgIHXA279zXmKUvpNIVPLd1QrknPp5eiJxc
         wZksQYM4L37x5TS82ahSitR0qLO2bvv+FgGS8G/N3ZOyqDeGHqycGx9+8KfB+oUjJyzp
         f4rk6VJnEwB6/8ygovETN/bw3V7HezOHbHwUzuKPB+OZSWysJEXiehG5mHkeFHWOXy3u
         GFMEg0QS0dhlpt3llQ/FdNWiIXkBcsFYcv0ure3SkVguMr6vwkCUzd1GlDLb/EREyocn
         SUbrLjXNKFWUJTW+IKHhfcQRESbL+e0zAEDmiewH2Xf9Vp2RVShSZSuZY0zfY0WJPUzn
         aVMA==
X-Forwarded-Encrypted: i=1; AJvYcCWVjcHpP7sok4l/LV8crUoWhjvZG1egTneKg7EpL1SG0cMiAh1SRDgF+i3lgwiiSfhmWZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/N1RE7QNhsAhfBfZsQV0Pnruz8B6cpH3FvRtwvIQGdacDssvj
	909bfjrrgHZttXm6oBH2us4EkF/BrNVHRb+hcrgz+c7dBANueDEoU5c1D+bt3qY0GFc=
X-Gm-Gg: ASbGnctiZ97eip+T5Z7XIc+amL/BEFKlzFtoO/4okZHp6yW5dxuHgYsS8oPSUs8H1Ob
	xCrzhUzoitHS4wtxn2xIZOL8bMb3ko86rHoW6gSUoZvJ0yxFyW7HzTXM+Ii1ryJYVhPnSK5ExTC
	iqpreHh77QvdVXloKgoDBah0fjtVKZAX1s2MIlx257liFhvsZ9HgHSHZ69uqQOPAheUUwI3E/sm
	ZU7tX0OOsN2BFuiKyhRqqRBQYnkb9kOMFBnAGJOosbdaHYgzifyI8sJdT9qrIfgrdnXlvb0mQFn
	b4B1GnTMI4omqVrKled8KbqYol6d0SZz+c3VV55DRakP/JZ5to5RERHbs4m16th0CQBiQzAZtqW
	01qptQz4s/X40Sbdd7SDewsgnLoI=
X-Google-Smtp-Source: AGHT+IEvp//Eb3qaCZvE8rU15Km5LkdaAv1nzJiNdFb5H25Rx3A09MDCbXpDCLgp6CdR6xAWTv2TYQ==
X-Received: by 2002:a05:600c:4f86:b0:459:db80:c29f with SMTP id 5b1f17b1804b1-45b5178e84amr121305475e9.1.1756201313624;
        Tue, 26 Aug 2025 02:41:53 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b5753550esm143915905e9.5.2025.08.26.02.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 02:41:53 -0700 (PDT)
Date: Tue, 26 Aug 2025 12:41:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Huacai Chen <chenhuacai@gmail.com>,
	George Guo <guodongtai@kylinos.cn>,
	Chenghao Duan <duanchenghao@kylinos.cn>, loongarch@lists.linux.dev,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] LoongArch: BPF: Fix uninitialized symbol 'retval_off'
Message-ID: <aK2BXe_ADjY0WdAD@stanley.mountain>
References: <20250819111953.3197428-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819111953.3197428-1-chenhuacai@loongson.cn>

On Tue, Aug 19, 2025 at 07:19:53PM +0800, Huacai Chen wrote:
> In __arch_prepare_bpf_trampoline(), retval_off is meaningful only when
> save_ret is not 0, so the current logic is correct. But it may cause a
> build warning:

We pass uninitialized data to invoke_bpf_prog(), it's just that it isn't
used.

In the kernel, we would say that's not a bug if invoke_bpf_prog() is
inlined.  (The C standard doesn't differentiate between inlined and not
inlined, passing uninitialized variables is always considered undefined
behavior).  UBSan will complain about the uninitialized variable at
runtime as well depending on if it's inlined or not.

It's not marked as an __always_inline function...

regards,
dan carpenter


