Return-Path: <bpf+bounces-36795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EB694D77C
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 21:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867C51C21EB6
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 19:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061E615FA8B;
	Fri,  9 Aug 2024 19:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwoifY9p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C6E381AD
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 19:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232449; cv=none; b=Pc9QEjbt9wyPDzBx70omwcnMXybYlpsiRSFN2q1lZnqzOmQM71kOg4VFhtSzYKwaj4UXFH13vWwoiqCZfw0GnhFhmxAFeClmYaAAOKWWjyvDmfCs8zxbymg6mTWxXJBtQwd9mW4UAPj/c4bryr2jQwnxPWnJL0PCsic7YxIwt9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232449; c=relaxed/simple;
	bh=46/orG4bpFtFfeOpB6M+RnXmSsCVB01OM69fYHTo51Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V9Xg7uXGE87xoUynDNhp8fuxq0WRrlcZihLJPi7T4JplxLa5WURy1Fc4md6r9e3hYkscgZbzIuqxWjvzfVzKdl1dYsUpmetU+cHBgPpoAv7F1t1HWnUrqCH+tuGl/sjvGwJVmJyDHPPmCodEtqYSlFEmEohLPsGcqN8yWgSN+HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwoifY9p; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-1fc47abc040so18279085ad.0
        for <bpf@vger.kernel.org>; Fri, 09 Aug 2024 12:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723232447; x=1723837247; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=46/orG4bpFtFfeOpB6M+RnXmSsCVB01OM69fYHTo51Q=;
        b=dwoifY9pvdFxbS/rDv6ET88WPk8L4kgtBNBKagkD9IdCa9qr8BwbTzbBEHya+sCDva
         W+JRRXFLq99ugBERELj42N3M3NddtzGAdOsdQNo9amuLEjStljzP6Y0JwOkAajH0K0La
         /j0rPOFmilDriZKK9yeHdj4ogAW8FqXRGFzhQg2w0Nuf5w0Q0R1KkDW/VyvvsmzkvLxK
         V25Q5awnPZd4tle+fBt8cLlrMgTSmAo19el2hnolNOH2FoaKqmClxDtWC+UHN1+z1Z1Z
         VkM3BIXXpD5FY4ZcL2h7aL/Y2I4TAUl3ikdUlfgWDL0dW1gYVPj86Z2Rg6d/e0r5wvFV
         LwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723232447; x=1723837247;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=46/orG4bpFtFfeOpB6M+RnXmSsCVB01OM69fYHTo51Q=;
        b=aClFjSE8s2qFBnhcd1pXN9QyVIFGGHbg1YNJjop/pXY/PBUGSzhKZZm1mrG1pmf0ua
         tADwrJSIh3r0xpxNa4X3E9NGa1YCNChrheUsp6/yfKIaIldz6IZoru0TtHr9x8bbW+xa
         a4nnLt8cS57RjuJLm63eoBsedry5mzmzTE+FDXxMyq+izCdJhdiOfppyMTvmglTMr1ta
         dqpFPGk8UVp+4CgGkh1grfSlf6vcwR6yzOC5VGsZMgpjQXHBmyx3hNcOifLAH1H5KbIL
         LkRU6icl3MVWLjEXMEOoBWulNUKMfG17kAyYAMrNqv94yG6liIQfCbk2G9n6CcH7bHjY
         JqNw==
X-Forwarded-Encrypted: i=1; AJvYcCX8NsUXEvRMX9wW5Xz+bMMHfJZg6DXpg3q3TyT5j7qryBZyk+pOc8eh3Ay+M05lq0uCpvpoEvcdGxe/Z1r342SBSv7V
X-Gm-Message-State: AOJu0Yz/J1n97aWodJ+odeAvJH3P/NxV5HQFw/prN+TZFeq6Yp8IjMcm
	5XJ+Lmt1soW54PNFdeFqc/GeXToW5P9cPFLmO6TdEGYFmRZQPjNz
X-Google-Smtp-Source: AGHT+IHwUhEk0rZlxO8a2lf/zJvqEaqkt1aUcFyb5SQL4nLQk/cJDmMioxo25BjpGcP3RnesUQ8w+Q==
X-Received: by 2002:a17:903:230a:b0:1fb:54d9:ebbb with SMTP id d9443c01a7336-200ae4f0399mr32105765ad.22.1723232447444;
        Fri, 09 Aug 2024 12:40:47 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb9b2d76sm1160725ad.162.2024.08.09.12.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 12:40:46 -0700 (PDT)
Message-ID: <e5d51074951cb9ff800f5255e9959c53dc4b2aa0.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: allow passing struct bpf_iter_<type>
 as kfunc arguments
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 tj@kernel.org, void@manifault.com
Date: Fri, 09 Aug 2024 12:40:42 -0700
In-Reply-To: <CAEf4BzZ+PKpcx+OXhr60MizW3x1dEGp5=FbC5ZUkfpg-b04hzw@mail.gmail.com>
References: <20240808232230.2848712-1-andrii@kernel.org>
	 <20240808232230.2848712-3-andrii@kernel.org>
	 <2689ece2c10e234a2326ad4406439ad7c8d35a03.camel@gmail.com>
	 <CAEf4BzZ+PKpcx+OXhr60MizW3x1dEGp5=FbC5ZUkfpg-b04hzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-09 at 12:28 -0700, Andrii Nakryiko wrote:

[...]

> I'm not sure I follow your question. Drained or not it's still a valid
> iterator state.

E.g. make sure that some such functions might be called only after a
call to next() that returned a value.

> I don't want to put any restrictions, the user is free
> to pass it at any point between new and destroy.

Ok, as you say.

[...]


