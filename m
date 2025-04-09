Return-Path: <bpf+bounces-55492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4058FA819C3
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 02:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D784F3B6833
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 00:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFCF1C32;
	Wed,  9 Apr 2025 00:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="aQY+QTqo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11764431
	for <bpf@vger.kernel.org>; Wed,  9 Apr 2025 00:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744157494; cv=none; b=Km46TffDnhga/yAE1gNhuCjI+eV9l1+QJxbNGfSzEnV3/tP5QuHqO3PFoaAKSoOU8d2+UzieiBAtOxGTjvMauUEDwxTLN12jGszwLq6DAsf5KyREBD5xOvDEXh8e9lipTzJ9OOwg7Cbs+a/wXqfAs4VjCNI3vLZwbpXPEeTKE5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744157494; c=relaxed/simple;
	bh=IGrIh0oj6QcgaAVxI1Jr5iHoY3WwQRLUyJGmpJyReHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5F/ZOebp8JP+joojK0ruiYqd4gh+M1magiiMROIFci0W7WaecIyYL5FlpYuHvCSXE197Gs2BqY2S6K1R1ICi81TCfDoiGqXhsbdwmReJD/UyA7K8E0jbpKLjcmRYNP3nHTqHScCP5AUwXj5n5Nti4a5J4VHfpQ7l4Bk9r/mpmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=aQY+QTqo; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c53c6c28c4so97113885a.2
        for <bpf@vger.kernel.org>; Tue, 08 Apr 2025 17:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744157491; x=1744762291; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IGrIh0oj6QcgaAVxI1Jr5iHoY3WwQRLUyJGmpJyReHg=;
        b=aQY+QTqoYuFI/nNDUwHoSR7Hh/3zQAjxNbuBOsZzexzqk6GRhLr1dj6gStc8JIe4ys
         GejfeEaG8FcbMGU+fMB7oyUjbox8A4dpBJCSDahgLxBO4RrKSPYx/iB0NQ6eiTuNO8T3
         zx1Us+SX5+3WwAzlCZrFX1YF3SjYjN2bz/g/Ylj2RtwujFgrcbWOxSf2mNrTd8pPsyhb
         2F0G4SUkzuiJQDPvHLFOcn6zoOIyndwvKAAG+Cwg+NaSUL1vA4s/6Cbiu+3uaTAcgosl
         dt+4hvAwzTgzf+wWjO37+t8R4arMiZjtewxZjzUQfaIOkjhyhWx9/krBqIo4IhZykauh
         RWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744157491; x=1744762291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IGrIh0oj6QcgaAVxI1Jr5iHoY3WwQRLUyJGmpJyReHg=;
        b=XVr89TAkuTm7J7P1jPiSsk7jU3QUNpJOrP2CP/0y5u0Vpn9Va/OtUPqACHU5SNqVSQ
         /LfOpJw6wGerwtEjZwFNjqS6QPr0VBVwKyEv8CYKDstS66gCV5/piDIclFF9Y4m4gugg
         AVy0uVuVInt25BOeBm1HvSJu6EoTwHa4NrIwrF0lP8mibM7yW8OJD8NpEUsQC1yJhcy9
         1lKrN3ab6tJBbXYKBiqe6oay2IOGE9DyGOlDpxrqBjH9AjPlpzRewykw4ren5SkjuohX
         IaALVSysi71Y7TyUJ+ODSSsdNyFlnce624gO7PG7ZGZwPXVC99BGPCOCKdVRiJMkalvN
         ctCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtzD1d1xImJ600h6UJEmdbj5CFA9sMZ3+cTFuru49m2isbrV5HcZGgbeO+cYEwMejj+ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWTJCJ2f5zt05xkV5ueKZZxp/G+sryFQb6t1D6o1jKt9CV6XMH
	GUPjqo+KBTPMruXRW5GqgbhJHriw1PJ2az1oCMPqJqvqqnl+sSqE47FUHjx7J1mpHkDBGlE46hk
	hceLZy524WrnQHKiUzAqmAeR8IL0qCELwZ7nNYA==
X-Gm-Gg: ASbGncsEGUiB2VosGGivBdMv8ey3jHL8GdZW4mr9UhszESjz/1JKCt8yiUGjq+4X+ga
	0Vg0YB8IX6O4Ix0rO2afaXRjClf+VwzK+0KsPK7EP4MLXkZ2Z62y81InmsEdvaNZ50uu5+XAP8H
	fW4KgC4ybyGeCv9d+NXrcJEqwiCt9/SUQ4JjpecFxbZE3nMP24ZikwnCqR/dQ=
X-Google-Smtp-Source: AGHT+IHyd/e0WwHsSsXmA/rIS5elMkh/5M5LD6diadoxtBUswF4A2g96igG0yc9/p3nRuCk0cfAxrY7asTUIYoMcfqQ=
X-Received: by 2002:ad4:5c8d:0:b0:6e8:af1b:e70e with SMTP id
 6a1803df08f44-6f0dbc7d4admr6977786d6.8.1744157491661; Tue, 08 Apr 2025
 17:11:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABi4-ogLNdQw=gLTRZ4aJ8qiQWiovHaO19sx5uz29Es6du8GKg@mail.gmail.com>
 <20250408001649.5560-1-kuniyu@amazon.com> <CABi4-ogUtMrH8-NVB6W8Xg_F_KDLq=yy-yu-tKr2udXE2Mu1Lg@mail.gmail.com>
 <da0e43ef-4861-4541-951d-8d576fbaa069@linux.dev>
In-Reply-To: <da0e43ef-4861-4541-951d-8d576fbaa069@linux.dev>
From: Jordan Rife <jordan@jrife.io>
Date: Tue, 8 Apr 2025 17:11:21 -0700
X-Gm-Features: ATxdqUFIpcH5ylsr6kaKrr69hnZZXAQx6Ib_kzSVOyDlVM8d3bq7Yg4L5qQzZfs
Message-ID: <CABi4-ohyFtRAGfwjg9dGcdDTpgR6guyciijzr32YFbA0xsau2A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/3] bpf: udp: Avoid socket skips and repeats
 during iteration
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, aditi.ghag@isovalent.com, bpf@vger.kernel.org, 
	daniel@iogearbox.net, netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"

> Agree that this is better.
> The stop() may need to take care of the start()/next() may fail. Take a look at
> the bpf_seq_read() in bpf_iter.c. Please check.

Thanks, I will take a look.

-Jordan

