Return-Path: <bpf+bounces-57365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663D4AA9CA7
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 21:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FDAF17EA36
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 19:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E0A1A5BA0;
	Mon,  5 May 2025 19:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEt5ZYKv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFC613B7A3;
	Mon,  5 May 2025 19:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746473445; cv=none; b=oLZMm+jtp54zHKLKJFAm1aqb3dm5y50s39JSHEgck5mLM1KcORI3nRilSWk52es3nCnOajRI7VM1MJWc4T+KiGG24FIzxUWZcePvyTuRRZy1I8f+TpjxLFYKJ9X5qcTuKg38T9tMOMkN7vAAHS/dwVlP5oZPPK+WlgsIYVa+40w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746473445; c=relaxed/simple;
	bh=ZWQA9Eip+5TRbjl0M3wddAc2dh95Y5ulrOmh7WgfViU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+EjiSf4vCYC4B6TnWmtsR0HtH2Fw+D85vamNXr3KGRTrs0mN6oqqpen+nvTOFBp4utBTs4e2SVGRMhWDKJlwTexX+RJ2pZ1A8NZ6I50lU0LzYqqdoNmKPxq/8nNOzMni86YO42CQUUaN5aHvkoTBbXryMLoeBz647FZS92O0J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEt5ZYKv; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-ace333d5f7bso912241166b.3;
        Mon, 05 May 2025 12:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746473442; x=1747078242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFs5QyzX6n8wKAy33cxXaOoUxsPTiWA2+Alb6BozfJs=;
        b=KEt5ZYKvNaioVaD7T1SOrS2PemJfrfI6FX58sMNNBqMlUPO6jQkAmDQBIRsDR9iuz8
         5oA3wzJxEhaxe4/R9+cmPZe8pAmnOAwS+wAXzC0S9fAsWIJXzw9+Lao8r1tjoZi5QaLr
         r8z0h4cVH6mlfOpfgEgDkqMwpZR4y18IqCoX8MlYJxiUzb5rhhED5PzcVj3Y/WxEXM/8
         U1lA8Tmoga2dRxXvrIr+vwuPSB6d0yMIJOMse31VkvYCPwjJQOPh4XmQtS3ZMzCTYlON
         QfBEaZtg85chZWWT6zpx/OGoea4MaOrxGqA777PhcBgDa54Ac1Mtk+TlZC+CyaOVSEHi
         r6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746473442; x=1747078242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFs5QyzX6n8wKAy33cxXaOoUxsPTiWA2+Alb6BozfJs=;
        b=MCRur590XaVUaen+6rAlunIOQz897dVn2m+bSCotJR1D0ESx41nF89DpBcakoIFvNG
         SdCnVLIjsIJIsjN9RPeRvyfq6LYuy34dyUDdnA2j5EyTwFCgPqqM13KYCJY6U4xUywBG
         DyfHrZE4xbTUxNNDuK2UyhSkpoBBkuxSAlAgdxUvgi2PZKCufp/e3QDsPUSY5rQ8Jl84
         uCRuqpDNGnYuN4D0w9VsMg+merKXx8gT3WuKapJFnG/gx4QPTW+n9u49Yyr+vUt7Bzfs
         lVEDs3SGTMrGrM1WV8dUCzPby/3zSDcEfVkbIFKtV3BmsTJQ/ltHUaUFXYEE4DQ0Y7Ww
         q+1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAG1WJRZ9E1l9D9OZbxyXHXc59dzKmSZNSEBt+c3x3M0Pirc4es0XTbw/V7CQiZNRhiUflOFHZhSyVa0Ui@vger.kernel.org, AJvYcCUgNDaDdfYedxkC8JJW2TALF2MUs4kST/+45IWjp0PG9H/G4RIpVHz4ARlyJZsnUEguoyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylo2acbZKGGeKVTQZsvNqLYu0cdV9SSuaREUfyZKn4a9zz1rBC
	CogaUVj2FOPah+vAPt5t3fXmiWBitgR9KvcJl7wXlojOcsFvBWrDZdvZMQ5XXjaJXF26h41aPxU
	Wxy3WTuVwT7C5J9x4xauMGFIhfiI=
X-Gm-Gg: ASbGncsv2zeKdHms3M69qhFBc2XwLOq1+fMs9R6jkm2y+rv/6jWsYDQPklGVKsl5tjU
	5SOS1nhqbe6JAzM0+cLOMtjyYwWIBW9Ge/Eo6BXK2Fkr/IlzkrW9+RQLHKR3DpNo3UUqJV3/POq
	920r2+OXSIkhTG/W2Ar1s+J3kh7gue/MLM9ynv/FqJbZusHZu/Odf4jhrP
X-Google-Smtp-Source: AGHT+IG1qDuer+Pcp9w83kvxF/q+r10fEVW4bmvn2Q0oLaxdNUnVM8t4M3wXUl19QPn8Maz5B8AgJnG9ouLKz58te10=
X-Received: by 2002:a17:907:720b:b0:ace:3ede:9d16 with SMTP id
 a640c23a62f3a-ad1a48bbaa4mr666257066b.9.1746473441399; Mon, 05 May 2025
 12:30:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505063918.3320164-1-senozhatsky@chromium.org> <CAPhsuW7-jkU+KiunvZw9-NsxT+7ohcHQtJ6JSXNU4aDPxJLWwQ@mail.gmail.com>
In-Reply-To: <CAPhsuW7-jkU+KiunvZw9-NsxT+7ohcHQtJ6JSXNU4aDPxJLWwQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 5 May 2025 21:30:04 +0200
X-Gm-Features: ATxdqUENsEJMKv1mBGC8cfD81fqzoAiwy3wt93bHzMQc6J1aKV7SdaglJb4fm8E
Message-ID: <CAP01T74_fCpuqwPpqs0tVWAUwO3rm6D-PRC0MZjiGyqf=oXRPQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: add bpf_msleep_interruptible()
To: Song Liu <song@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 5 May 2025 at 21:07, Song Liu <song@kernel.org> wrote:
>
> On Sun, May 4, 2025 at 11:40=E2=80=AFPM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > bpf_msleep_interruptible() puts a calling context into an
> > interruptible sleep.  This function is expected to be used
> > for testing only (perhaps in conjunction with fault-injection)
> > to simulate various execution delays or timeouts.
>
> Please keep in mind that BPF programs run in not sleepable
> contexts, including NMIs. Maybe udelay() is a better option?

Or mark the kfunc KF_SLEEPABLE, IIUC the intention is to use it from
hooks which are sleepable.

>
> Thanks,
> Song
>

