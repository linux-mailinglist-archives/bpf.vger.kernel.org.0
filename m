Return-Path: <bpf+bounces-41057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F4D991809
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 18:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B131C212B5
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 16:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67815156C6F;
	Sat,  5 Oct 2024 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="dZz2Cgnc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F3B14F126
	for <bpf@vger.kernel.org>; Sat,  5 Oct 2024 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728144178; cv=none; b=RoESwbhFr/um7HdcfRj1E/BMIJFZmvvYVFpYzO4FAp90hJT9ROcI2DDew/Dw+sXBq8E4F4RzinYdoGPOBIRI29VcUb4JnGsQvyB+oMTrr4Iw97FrhJfHJk2zeFU/BuUHqB3t9JfGGu80SIUXw7RzkQkoxvrq1yWL4MjYpPu1p1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728144178; c=relaxed/simple;
	bh=P96NNNXTpeZp+/TvYSSSMShLVn2wSDJIGBC9JsBXQaU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IyxJw+U5dazqiSjaPkyij9f6JJvrXVNGjpCI+A05EIoh2TeUGXlSGgEEQxObOAtu6+DBAA8RrsQ/DY2YlgQ98KCcZmPfDkUqmimGTNL5vZNwMIae00NU1AsoE2ETOpSby447ie4f86aMjKZdBT/vT/t6fxJMnYOAGl2rUutwBEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=dZz2Cgnc; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso2609157a12.1
        for <bpf@vger.kernel.org>; Sat, 05 Oct 2024 09:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1728144176; x=1728748976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLU03qWsoTGbgLowENUQTK9xntnjk1tBjyUQ2TfFmuM=;
        b=dZz2CgncGjOJmMpDN8ljjdl6e6p6tWCL89mEO9l1qPHheJab+Ms0SqokI64GuvNds6
         GxaUuH9EbN4F/z8QkOzfgIXlTINUbKffyaOTCIEAOuV3079SyghhpSmskOl1i++58h5w
         MLVkCpT0JW9LgN6+SP51xOGF1yNflowWwy4ZqC2y290w66qbMAueOCFTVwlN4eSvZRSH
         HvEbKvT9g1qVoPxavSxunCubng/eDDDcvkoZiwS/2Klranc8+aN/u1WjonUiJ72M/NRA
         /pBfaiqYdqyaGEx9H12RZ5tW2wm1BN9Fqm7sEY2Y9FhuZvGqMeXdzWx3TYlpJpBREejC
         vwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728144176; x=1728748976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLU03qWsoTGbgLowENUQTK9xntnjk1tBjyUQ2TfFmuM=;
        b=EYEqmu2UzTl9ExeUVgHxKIttd7s7Uu72nSDDQfO3dDvJTfY4WnTFoD6r99hZuHr6Qj
         iZl6Xtyh3G0lg0NyMW3H8dbCM4GV0hD7TfXIvq61GSXTFEUx3RWsL+Y77qGJkbo8VYdq
         vNvTr4c5UWTveeRdBBMjHAMZIT4kyetLCf6U4Co0qOu4o3asQQGg1NgK1knJVGK6lr/z
         gMoAM/NnI0+NbQeRtagQsDiKyeIwCtEYm+TStZX/iLBGrj6xf+Z2d/DanoHZphF+Cw+t
         dBjoz6GLtaOvt1nlbp7zBE6Ai3S4iOymufsI1k9l+oIDOEtajaxupHLAQ5F2CtijyUq6
         sWow==
X-Forwarded-Encrypted: i=1; AJvYcCWk/VPakwVKkEnrBrCLehsSPGJDRdsPoDf5iaSifOJAYVXHId0iPYf2JHsUJbclt2wsUJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyYQt1PLjgWUY8h5y8fSLNzCGxrDDSeK3UvSMdR98PWGN3BZrV
	iMhtcS5VJGZDNymvmnc5mtk3SlK0aVJH/ZxO+HX07v0osz7ZvD6m7YfPSg1K2L0=
X-Google-Smtp-Source: AGHT+IHLG1HZ+xjOKr/HI1dY3x26Hi/gIgjhVbKySgj3xyKKq/K+KzAFkE53nmeerzLzcxWvx4mUBg==
X-Received: by 2002:a05:6a20:7f95:b0:1d4:fb97:41b9 with SMTP id adf61e73a8af0-1d6d3b01314mr15366179637.22.1728144176258;
        Sat, 05 Oct 2024 09:02:56 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f683eddasm1635619a12.56.2024.10.05.09.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 09:02:56 -0700 (PDT)
Date: Sat, 5 Oct 2024 09:02:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@linux.dev, razor@blackwall.org, kuba@kernel.org,
 jrife@google.com, tangchen.1@bytedance.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 4/5] tools: Sync if_link.h uapi tooling
 header
Message-ID: <20241005090254.061c1317@hermes.local>
In-Reply-To: <20241004101335.117711-4-daniel@iogearbox.net>
References: <20241004101335.117711-1-daniel@iogearbox.net>
	<20241004101335.117711-4-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Oct 2024 12:13:34 +0200
Daniel Borkmann <daniel@iogearbox.net> wrote:

> Sync if_link uapi header to the latest version as we need the refresher
> in tooling for netkit device. Given it's been a while since the last sync
> and the diff is fairly big, it has been done as its own commit.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

It would be good to have a script to do this automatically, similar
to the 'make headers_install'. I use one for iproute and do it every kernel rc.

