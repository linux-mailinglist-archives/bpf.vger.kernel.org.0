Return-Path: <bpf+bounces-56210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 034CBA92E75
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 01:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2571B64670
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 23:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5733522257F;
	Thu, 17 Apr 2025 23:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="r1H5HKZc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5E91A7045
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 23:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744933895; cv=none; b=ATjXluhNkO68eZTtkAaODHlPgx2QniLx47ZQVo//UGeyhpPY1YLMHLPiKuciyJX9gC3MhTcSLsOO1ZT0Nl23Q8BqgRcP7XfwQPPf8/NFtAr6ftp4rFL9tvfKzFg53LFWf9iMB04xFnEVATdZRj4iQXKqotkjQug5mDecSoUDEEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744933895; c=relaxed/simple;
	bh=hM3ABLdRyopw0ewaS+2awyUUr3T3DfSD9iPcUc89vjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTdCTMwlu+482AYZbD9TYqeJ4VVnfZB9EhaIUtT6+uqdahpOEsTiIAV7rrPvBl/K0cifozoV5TXDj4OtpQyQQBKEOUarmdP93o/Yj4we2sJLeC/y92zg7lq5wjbmwVq793OdUZ6+MDv9Iwgy/togWTaGtSoyzpj+PV9po/Q4tjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=r1H5HKZc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22403c99457so1240015ad.3
        for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 16:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744933894; x=1745538694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nj/ToSb0r+plwqfjAdpVOCmQpT8fFXkYRr6EIF/VNg4=;
        b=r1H5HKZc5I6/b1+Uux2+KALv+zXmI+L2MtKpjV0kdjoS1jxYt1c4IauFmhZ59X5v4B
         k+pQhTSf9HsvUpbWc49+pB2xiDj24WEipWKx+TRqlAdsB7GMNlOCWhbxRSBg97dfpL33
         VtOsEa2Uc09LOdXH2/7XBvkCFlMMEkgXxff1DRGYhAo/dOfn+Pnu+CKKsR8jim36ay/7
         sqf32a9xEdXzoQWpajVXFQkWY42veFEPIhNZYnp6ztnQrnrRrlk+LqQp9eN3Opy8defw
         xqOYx0ADpxdq09hHvoxZWuDOvF6iUJA2X15kwnul5KHQzsZesXwWop69/tq3X3t0S2wB
         f3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744933894; x=1745538694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nj/ToSb0r+plwqfjAdpVOCmQpT8fFXkYRr6EIF/VNg4=;
        b=UUz9O7FyF2NnpsMai2J1ZWatoMdctouOlpDmjuUAu/HD2Sav+iqPr1apitbk9sly5o
         O020zVzxzXETE1EJWxASG0LvC0urcR39ycMw43eLmEJPJ4TY4U1xTEOOHjOPKfO+t0yI
         +SgEGx252949OO9IFwo4ly0MjFbkbC075zbbVsU8A+hSd5hpY+8wFsTlT0JT/G0qzM9H
         5Jte+MrCr+eZyx+4JFcjI32aN9RG44zcnHdcZWJxearGVM7FfoDs8668ecgo2DS/x4cP
         G8EOXg8lvCq/v+UE1Kb7vZL1495Kc9/10LS3DXIEw86LriiBSVc4bBKC6wXvVNX7xriP
         oWNA==
X-Forwarded-Encrypted: i=1; AJvYcCUgyoPxYPW5WaqV4+u5Oxz7DqqKX1x7foaOlaHEuL+gq/DASg5m6TKGlQGktZYsSgfsZn0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9lM2YwPDFaqmLHNVLlKK1lLXdshcQTY7YZWMuHTq+AySkbRxj
	Rq/7uznnHkfsbE+iGyDP1N5gQt6vwGdsX3spQxXtQ7wdI0hhCegOvAkXUVVJxkNV6mKsFBOdE/y
	OWFs=
X-Gm-Gg: ASbGncv0a/J2l4cmaOoKuMf7USwm9QPh0EPbYmtzGJ/Ru+mopa9dI8rqdSqTky2Y5mM
	l4vUDiakro5a2gmHxlUJrEiAeqxk+cLrEZuG1XvuP0PtOFAEMx+kqik4cqCR48fSNB18vfIMnDz
	RUwh6hzjuZn/Eni70mAJaMUaRJFNIMqciS47Se5JP7r4jJb+KmS3Xco17ZNDTt2i2VKjfyQY1C5
	MHg0OfBj1CsZOunkmoEU4N/zPBclh6ZXrbd6k+qvNNWGf7SVtbDIJIjFJQCkQuXilCrzft039IA
	VSqd5sLbulYc/K++4wunpocL51k=
X-Google-Smtp-Source: AGHT+IHVVZK0xNoZRKGq4tFkMJsALhDgnbfvJuRYqCyu3BJW3G50lfVa+gBBJrQVQLV34DFGBLXOQw==
X-Received: by 2002:a05:6a00:3984:b0:736:559f:eca9 with SMTP id d2e1a72fcca58-73dc15d8578mr347501b3a.3.1744933893572;
        Thu, 17 Apr 2025 16:51:33 -0700 (PDT)
Received: from t14 ([2001:5a8:4528:b100:2a7b:648e:57e0:a738])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaeb7e8sm471094b3a.179.2025.04.17.16.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 16:51:33 -0700 (PDT)
Date: Thu, 17 Apr 2025 16:51:31 -0700
From: Jordan Rife <jordan@jrife.io>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: martin.lau@linux.dev, aditi.ghag@isovalent.com, bpf@vger.kernel.org,
	daniel@iogearbox.net, netdev@vger.kernel.org,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH v3 bpf-next 2/6] bpf: udp: Make sure iter->batch always
 contains a full bucket snapshot
Message-ID: <aAGUAztJqwnDQquo@t14>
References: <42b84ea3-b3c1-4839-acfc-bd182e7af313@linux.dev>
 <20250417233303.37489-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417233303.37489-1-kuniyu@amazon.com>

> > If I read it correctly, the last retry with GFP_ATOMIC is not because of the 
> > earlier GFP_USER allocation failure but the size of the bucket has changed a lot 
> > that it is doing one final attempt to get the whole bucket and this requires to 
> > hold the bucket lock to ensure the size stays the same which then must use 
> > GFP_ATOMIC.
> 
> Ah exactly, when allocation fails, it always returned an error.
> 
> Sorry, I should've read code first.

I was about to type out a response, but Martin beat me to it :). Yep,
GFP_ATOMIC is a necessary side-effect of holding onto the lock to make
sure the bucket doesn't grow anymore. It's a last resort to make sure
the batch size is big enough to grab a full bucket snapshot not a last
resort to allocate memory.

-Jordan

