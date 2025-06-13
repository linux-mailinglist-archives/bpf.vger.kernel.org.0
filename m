Return-Path: <bpf+bounces-60579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 483ABAD83AE
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 09:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12F317E1B4
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 07:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B738527467B;
	Fri, 13 Jun 2025 07:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaauCfom"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59A727466E
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 07:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749798549; cv=none; b=URr9wDTcFGskfRMv8GM5hCZlhJO4Jp8n1bx+lXzcwD2vOFMvkt+YEhzABSAPE20AiDVLo/EG56k+Pl+/9cmpsQ67BgQtJA9xkN9+v9avi5MKV86LMMJ3Rgp+C9qQ3iixocEACxKpTq1LUlc9FVogEnZFqKKqcxgzy/S0i9sZGf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749798549; c=relaxed/simple;
	bh=TwcNl73KYcBSIhJu6f1BDLLwwVgWgrImS0fxU5a13FY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uO7VRxCy+WqsL0YSPnz7QKB+TnbE+pQ5m1Cg+l98iaXZWle8xYt4kLH4jGyCyJY8JudIwEgUyZhKG93Fd1i6dA5rCh7W/SGFqpzVISVAgM7Lp5MFj9kh7dIIT/lxLHcC7mbZtRsHkvw921CpxCOAw+QfYAMTDC79U/F8BHRWp1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaauCfom; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso1586997b3a.3
        for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 00:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749798547; x=1750403347; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TwcNl73KYcBSIhJu6f1BDLLwwVgWgrImS0fxU5a13FY=;
        b=QaauCfom/uXWOw2u8XIkRticjYf49+jlQWfCuZC9BGwUirk6KX4HwFLSlxFBVRHPOn
         SfXNzwO+Jj5AMK9chT1rskyCA/c7ZMh8g3+uknYfvhFLr+mnW3m5ENWpdXaWYRfX75xz
         1pW1fbRWX7zfmoYx5mX4e+egCpSO/lae1owV0A9jtQytY2kSufZ3WWicS+CyfAwyH1Nk
         HdQZ5y5db0hNMi38zIK1lQjwhLL4yzq8XGSV+cD7Wf93bCYdk2DOxvmQwJ4nLhoAJoDk
         9gwSoTDgAUxth36YW0AkL0GxgXBWEErloWyq0g1NZIusRQO+9hIAr9T9aMe17e+OxC0m
         KoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749798547; x=1750403347;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TwcNl73KYcBSIhJu6f1BDLLwwVgWgrImS0fxU5a13FY=;
        b=UXuNxiAcZjvpCTYzx/tRb0cpy8pq0yjZe/sITrAKcY+64epus6/YhfeFJGrzqGtd90
         HkJeU3uI+ApTEcGyViKctrKxi+rWxbla43NmqVl74++8/wbMbHelUAqutNFa4XgDX8oG
         02/mdhEjPbEdtj7XV81Bb2iiilXl47RQ4AXP7J/i65efZA0K6QKWAvNmcjW8brHaYXuP
         qW3pV3BBdtz9dqq0qFyu2BenFMiq7sGsp7G3Qn/+noFpJRE6ybgahQEvLcJ14x0FD0fQ
         BFFIfw5oSiwPj/D880mHvDUYZV4qpxeIlHTtnPJ81OdNtwV6yEgoyvN7RX/RtLz2E9jg
         CTAw==
X-Gm-Message-State: AOJu0YxwiaMbAUl5qQxTMtbRZxOxkZDFJ6Ait2YPZOtIkseb6UCPKaaH
	+gkD1tpXTMFnZ8rg35Co8mj3am9CvPua60Qd1keAf0MJwnDMceonnfUB
X-Gm-Gg: ASbGnct/gaMtdvYjiB+tk7bV1YPjd6Ns3eWc4bhRq2aKKCHIXYhqzxfuP8noidRehmx
	k9VWWxE6RSA3CUsFA8AlBrUq7yWwE0by20dpGMvj2V6wAkAaEAuZ39I/WWvEED3xxcUw3jxedXJ
	3fAOZZErAtcT3K7MGLNLAJ09OSnptCUVcikM2NMy7igG4gPg/v/cORdV9dtqwz8RKwP5Z/QH47N
	b4RncCArkrDAOylupFIS1Wo0aHb1Jp8U+fjGayB4CSX0qT1hfJUBL3IBncTiOaR2VAPjlIsTdFF
	pDxKx0wsjhm/38AsldgCGW630L845uzheEB+cQosyst4CUX6QElG98Ygxts=
X-Google-Smtp-Source: AGHT+IHMXKoEWN7QpkFKiIPA2ADfpWB+DGJlXAd9hLyL25aaXCaykeWG/AL9B8TNMUvzxT+NcFVPKg==
X-Received: by 2002:a05:6a00:88d:b0:730:9946:5973 with SMTP id d2e1a72fcca58-7488f6eb0ffmr2564174b3a.5.1749798547158;
        Fri, 13 Jun 2025 00:09:07 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d29a2sm915430b3a.175.2025.06.13.00.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 00:09:06 -0700 (PDT)
Message-ID: <d6d6d2c5b28f64e130cf0340077681349a91cd9d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] veristat: memory accounting for bpf
 programs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev
Date: Fri, 13 Jun 2025 00:09:04 -0700
In-Reply-To: <CAEf4BzbTxyGXi=ZNU_yebe2a=zgNoeafRTK9pixJMihUwwo0Pg@mail.gmail.com>
References: <20250612130835.2478649-1-eddyz87@gmail.com>
	 <20250612130835.2478649-3-eddyz87@gmail.com>
	 <CAEf4BzbTxyGXi=ZNU_yebe2a=zgNoeafRTK9pixJMihUwwo0Pg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-12 at 17:01 -0700, Andrii Nakryiko wrote:

[...[

> do you think just hard-coding /sys/fs/cgroup would not work in
> practice? It just feels like we are trying to be a bit too flexible
> here...

There were some divergences in the past:
https://github.com/rkt/rkt/issues/1725

So I'd keep auto-detection.
If at some point reading /proc/self/mounts would cause trouble,
we'd know who to blame.

[...]

