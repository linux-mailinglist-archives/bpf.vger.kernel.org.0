Return-Path: <bpf+bounces-51990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 748CEA3CB48
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 22:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22074189BDCF
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 21:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AF6257425;
	Wed, 19 Feb 2025 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnqTsfIG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DC3256C9D
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 21:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740000025; cv=none; b=ne5Nv4S1pn/azDa0XH7q8dRvlMD6yWEjBXIyAeNnDmaOjbzoa5KmjmmLtpBLf6D0FItMEDiA3Z9fgbTrvh+mqesGMeP3aDxcNXStQQ9QPdhDrL5A5TeqYl590s7++e6wplCRdA62WzF+QUnmkK2kMJ3DfBJnt7VB+NQToZCZNK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740000025; c=relaxed/simple;
	bh=1U1wwVvqeULvDXQvc25yATsf3QOi1fC2Y30n1Q0dRxw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fQ1wqYdMOgJHTI+3xIEYhgFohTAP/KfpJBWyrc8ADBAV+OCOmayAlZ4GeCw/SPZmDt4Dj9volGRkxdBV1624JCCs2L0YowCZMxu2TYHcfcooTDkkl6P364ZZ/N0kBKKzoGORkwTBqD9/7cXr8toyp1OMcyDw8G+Zes1sfvRL/OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnqTsfIG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220c2a87378so2916235ad.1
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 13:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740000024; x=1740604824; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1U1wwVvqeULvDXQvc25yATsf3QOi1fC2Y30n1Q0dRxw=;
        b=CnqTsfIG9ROHpKqARG2/FXEjGDLPq6oonY06z7gQCVEkuHFAw6Vdu9m8Rqt56xJYYD
         4zOlT+42Yz2IFzgcHRhRvH2c/Nclo1l4Cmr3jvZ9teqy7PbE69/cta04aoETNX+O5y7U
         IbghAAfJlltqJF0zdspUT7st2QZTJs/n4B/ya1aJFM8UBrTcwaA3TLdCHfc5GCkXV109
         d7+IKInx15I5kIpRKxrFBpc1mjd9f7xjf+XqURxz9KopSV1qwXzFKXdfLc8lrCS6N3Ei
         o8Tp5Aeqm8XvHsjzTqRt9myAsdR54x+gH78F/ES3H7mW7f0s7cjhsMa/pDXLrl5EcBJw
         tBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740000024; x=1740604824;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1U1wwVvqeULvDXQvc25yATsf3QOi1fC2Y30n1Q0dRxw=;
        b=U2nFU87U7gsTcIK8/jTwMUicMHD6FW0seESE0s7QKvsc77chPtC2FIqYFa4/Z44xGi
         zatxxd6O9Or6tYnab9oxLdXG4R9z6o2SiM1AzW9e9smwq8cR4MSLj6NVc1hzr5bi1lXP
         OvbABP/MyMLA50r9ANNm+pclHEwgUsMqWviO/J3DjCO0qSj/0d507TcBNKMo/su95CFs
         Bh3vQBCyu9aUYrFWLLgAbdvpfWOQrWchh6uGNoFqrtIFbNhL9TLMblLc+ffWO3mxuOka
         vuFSZzwbh8zRvWrm2qM4qqkw4fLOl9FpEe8Y/XLgAzqAdXjv3hWaKT9tRCVUg/58iJYT
         REJw==
X-Forwarded-Encrypted: i=1; AJvYcCUKCcwLPetmAPTPsL2LrwYm3vTxPt9C1WnWlSJMi5DqHqEmeD8F41XTEPl+QuUm1VCO7tA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPqm1mJdUKY51ErVFyzOGZGhwMhEDwHNtw4VexG2YlIfOxBNch
	vWUb85jO+g5/jaMKQrnYaRSQzZuLdYvB6CjRMRxxT2QbYVBaDE7N
X-Gm-Gg: ASbGncsbsI6cRWIjScai8b0wlJCzxB8zfqNKokSOUkmG+WcqONnimhjDpeuR1NILNCY
	o0gwxhJld1spDCubUZZ6EVYZwBkeL87LQVdbRiupb49I2KobZRgCby19AQrqSyMSWESzpZvDCZN
	HMlRFullFWBmVZ7I2tUTXrY8JB0MQ6iXfzhfpNTCbn6TzImQqaaYJ4w29ImIfB6oHUYT24hvf9C
	dVSNOzHIhpvEkH0G9IWnBb4ov1sxc4b+9HUHdBeSYmCTVBaOU/GXjPkATvXcLOD54iOHCAwNdzd
	q1cfQAzguQAD
X-Google-Smtp-Source: AGHT+IHCMqHeDA1ield8LQS2nkpqUtOYd6f42v0g58+hkS9EhjktCNGNs9jYWoekYMFlHyH8seA3Yg==
X-Received: by 2002:a05:6a00:1903:b0:730:75b1:721b with SMTP id d2e1a72fcca58-732618b7d2amr32979986b3a.18.1740000023655;
        Wed, 19 Feb 2025 13:20:23 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732547af8acsm10542578b3a.71.2025.02.19.13.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 13:20:23 -0800 (PST)
Message-ID: <c947f2bc7348c62810e398f9a8322abf5ae27ac6.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 1/2] bpf: Explore PTR_TO_STACK as R0 for
 bpf_dynptr_slice_rdwr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, kkd@meta.com, 	kernel-team@meta.com
Date: Wed, 19 Feb 2025 13:20:18 -0800
In-Reply-To: <CAP01T76aV+2Y-U79Csf4+-scG92jc2ZwJUhDC1MQcx1ZJ4vwkw@mail.gmail.com>
References: <20250219125117.1956939-1-memxor@gmail.com>
	 <20250219125117.1956939-2-memxor@gmail.com>
	 <CAP01T76aV+2Y-U79Csf4+-scG92jc2ZwJUhDC1MQcx1ZJ4vwkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-19 at 13:56 +0100, Kumar Kartikeya Dwivedi wrote:

[...]

> It also leads to veristat regression (+80-100% in states) in two selftest=
s.
>=20
> We probably want to avoid doing push_stack due to the states increase,
> and instead mark the stack slot instead whenever the returned
> PTR_TO_MEM is used for writing, but we'll have to keep remarking
> whenever writes happen, so it requires stashing some stack slot state
> in the register.
> The other option is invalidating the returned PTR_TO_MEM when the
> buffer on the stack is written to (i.e. the stack location gets
> reused).

Would it be wrong, to always consider r0 to be a pointer to stack if
buffer is provided? It's like modelling the PTR_TO_MEM with some
additional precision.

Otherwise, I think push_stack() is fine, as it keeps implementation simple.


