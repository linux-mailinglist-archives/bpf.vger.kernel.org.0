Return-Path: <bpf+bounces-57238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D708AA76BC
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 18:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCC877B0858
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 16:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E44425D526;
	Fri,  2 May 2025 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="piUpZvaz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D78425D53A
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746202119; cv=none; b=Ct25ONChp0lK4+uCeja4tuFLISdPgjZY4gqdanaXF7mj0MzREb9IT7kAnbq1i13Rpk2gXGhszZfmApr9L4M1XV5qzvEUyP82GFWUBj29RYZyyqQkfzj5ES0lY/r0Eb9ixBKcaLLpshvxx8QuWnYNf3Ikd3y/Q+wS42MTYTofsb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746202119; c=relaxed/simple;
	bh=qFW90J9T8RJ+7GYrvlnNFaoJarkTqvcieznVTo0kQ7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUNPuFcOfa27twrJBkMGNVcBA2edgSqzopPF33ubh3EfFJ5Kr6FrJgqZdGWUeK+zug4ZL89tO+LORznjJlPGVngf7VZcOMmiacyabXq66kh/dkTVrhu23780KqV8WriilYa/+Ktfq/UvTZzFuXV9EDQSQfV5VSmnwqAp+GdqYdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=piUpZvaz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-224104a9230so3660475ad.1
        for <bpf@vger.kernel.org>; Fri, 02 May 2025 09:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1746202116; x=1746806916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gj3NocPP0YximFiD8TQzgbDDNI2dofYflmIdPP6lA+Q=;
        b=piUpZvazM6bIO/u4AQnv+Oir0bi7zRpTo4vbWpksRqYNKyuDw9llfKA1DoWtTtR/wd
         Cp/8+JJpPSMd+L+IJ2ip7fvgjZVJG2s24jHjw+Dgh52kKPyDN6IUdbvD5fxMMyxWDYzK
         XsvInhh2bkDWdAFdGB7HwUSg6bbbmx7RLATPrc20yU79W8rilQ2Dp85C1dMu90nEiKHZ
         uVSh8SS1Kn9Ol9s9s7VzeDVajzvPIuP5GLbamX6cggzi/3koGsnnMICdu5QKxSaPsWIa
         +iky5jafM+m+aYTv8Q78ZqZjwAwzvPpDTI64wLNzrRe/MsbIQRO4a39+QLQzfPQMtlBA
         gbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746202116; x=1746806916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gj3NocPP0YximFiD8TQzgbDDNI2dofYflmIdPP6lA+Q=;
        b=NsnI5D3NUtMI8gS8TwYffR93Le2Ce37MHKiRYR8SAEDuGikQ7pQh0ANpB4jJRvama/
         mc3+NhFdUnryTWIpxzF7LoVmPEh/oflgRP+52xg34b0rlBYZN5z0Dqxh14Kng4g4TqFf
         ZudlDXZWpIMTZc05HIBAAlQZjIlfyy3telDRBkFLrN81+eEtx19m/xihPf06ILsUL6Ln
         FHUcENH31O6IbaAR2uEQs93baKwVqnWZOIldVvu/Tt9Efm3rlHiqq0cgW/VlKS6ZDDHz
         ryC0giUBfItkoK93vPQ9WJdmmDdEbOMVw17X8sxgcL/klBCf5gFk0L1PgT/4AJ9Lwg9a
         lBWA==
X-Forwarded-Encrypted: i=1; AJvYcCVpUUoriF+rjwbyks0uY32M5z7obJjlPSrt3Hj3Qf3QIbQSGeUFTIVMeLm5KpDJD3nWPWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbYACJCBXBO5wvsmoPLQYDqyR4qWkP4czSknEJESr+Be02JYmH
	KoydvgD5vMPGPQAOtKrcW7KkJiEQzO0CLhLRuogv9NzmUmHQuNqsi9hAOWKLSk8=
X-Gm-Gg: ASbGncuIdPD0+DPrjRiYWSsfxOcC/mDooIsxWZPZcouqeoYkxQyqCq8IE79N1Q7yacg
	AhPtOnfW0aMNej0fk4BbJ1DDBXXmV9Ctn15WAG5KaN79yvMW/nSqUV33KsnPocqxx2+sdWalqGB
	osA40jmpRkcPZylhZNahQkhaWnjjpmD8NqAoOi1gOOeEbuN82X9NKj3gEjr7biSdLUaAjNfgfGd
	NCfUuZ2/lrKwWtVAqw8PF/KIuYFCngWo8gm/X0Iy2s78OKIiMdkGXWXxwOXA9B6Cn4GjqecTKEa
	a4ynQKd/F9MZtVMifOONGUrs1pI=
X-Google-Smtp-Source: AGHT+IEx2hIRACQD4vGbjeB7Sd8QKVmVcIAMoL1DlBjtzG/ltHk7Rttj9zTdUNlhvywKnKU5ZyPKYQ==
X-Received: by 2002:a17:903:2343:b0:224:10b0:4ee5 with SMTP id d9443c01a7336-22e10236f31mr21466155ad.0.1746202116504;
        Fri, 02 May 2025 09:08:36 -0700 (PDT)
Received: from t14 ([2001:5a8:4528:b100:7676:294c:90a5:2828])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e151e98desm9439475ad.55.2025.05.02.09.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 09:08:36 -0700 (PDT)
Date: Fri, 2 May 2025 09:08:32 -0700
From: Jordan Rife <jordan@jrife.io>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Aditi Ghag <aditi.ghag@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v6 bpf-next 4/7] bpf: udp: Use bpf_udp_iter_batch_item
 for bpf_udp_iter_state batch items
Message-ID: <a4iluxons4k536rz3ynmlpuaqkjpyi2gt2acm4o7bcns43q64j@f5qmwmg3x5bf>
References: <20250428180036.369192-1-jordan@jrife.io>
 <20250428180036.369192-5-jordan@jrife.io>
 <2ccb3470-0218-4bca-af17-4f9bd1e758a3@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ccb3470-0218-4bca-af17-4f9bd1e758a3@linux.dev>

> A nit. just noticed this.
> 
> Since it needs a respin, rename the pointer from "sock" to "sk". It should
> be more consistent with most other places on the "struct socket *sock" /
> "struct sock *sk" naming.

Sure, will do.

Jordan

