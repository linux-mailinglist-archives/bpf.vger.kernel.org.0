Return-Path: <bpf+bounces-63993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D04C1B0D05F
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 05:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2136D16EAD7
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 03:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0C828B7F8;
	Tue, 22 Jul 2025 03:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSEAYWik"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AFDEEDE;
	Tue, 22 Jul 2025 03:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753155210; cv=none; b=lSgcb12+mGrBRsSTmlDVWv/r9AnPb1W3owydrgurfNp+wxOsOjYuqrl8oMGfokt7MmYTlpi2HerS8z4yM5IAqhg9v9P6ZJE1T0T5d9W+emBCtOyp/ka446+LVynPD+XaRQQ+NGwkjB0IQDOizz6Wouk7ESeJKy+cY2h9ChikD+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753155210; c=relaxed/simple;
	bh=q3hKmaMrZ0L5NaNR6ey9DaShjQVldI4T02wH0eSa5Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRYA0u0+5WB559XYj/T7d2/kiy1Za7KrG4DX6d4EvxIxmXY2pFOcGQKTJlol1RhzBA7sopCdKBPdWPUkbTGuQXn0aLIxkgV0B2YBYaRx/JxJEmO16yAPGVZxrAI3MrhsItzWBk6PaxV0CscxZ24oGDlnSB8veor4bE2+9indBFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSEAYWik; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2350fc2591dso48052535ad.1;
        Mon, 21 Jul 2025 20:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753155209; x=1753760009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8mqLPH+vvkTrp66iDC0pafoB/PxrdvC2+NALO7RkLns=;
        b=DSEAYWikO3fMTxJGAZCGWWiLOi2FnFLDTFrEP8qn0ByxXiQ2XODB/u8shJlRUWXUi9
         M+8WN22P55zaCHEcNnaR4gA1+poNLpyRLiGVFn07eL4jDDA2Ulieh4g99qcIy8OhYPHl
         JMfo8rpjHf1t5p962WBHP0GfRi+4IsgTesYLUBkevPq7VqiK+FyAyUtic1IKCBACHtwF
         GsuFNSN3Zfg5SFF7PYGmLa5t2XqbbkANoSRwPXfSOwCr2bWe6WZ6W/KZ3KAVCn0mV5Ho
         ZUW2wbcC6HzGPRg6qqNypvqOHEWAYECCZztP21oW6izmZxYRikEFQfoIUZSrpW5IMeF0
         l4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753155209; x=1753760009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mqLPH+vvkTrp66iDC0pafoB/PxrdvC2+NALO7RkLns=;
        b=CO519zY5bGRss+jBLRyff6sy33nP3c/8/IZTc+zJTk6GilHFuHGh2bcoNdPq5kXzwW
         7Uz4cPt2PcXXVAN0KfzL0SQuWhlyRUHvwuQj8VGFsm1Ci3+YV/R8mWxBJQAmh3wI8RYD
         YtLYmBX/aFuJ4aDB1qKY1U4/8phSZ7tUXYbnNZb1zXmizHAD4J9Pf3UF6G2n/43BHP8S
         OoPbI06JNA5j5s1ezbqqhP1W1XjkPNi40cXLOKjaHK6ywc6K968dI8AaF3Ls/O+1agVV
         72z1TX0uIfTaoVn9i3TQIJPHTNnJoMFTly1FDFyk2MDEHj5BHSoLErOu6FVjIJ6M1x5f
         77mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQQbFPDPbCGSgTA7pQhILFz8WPlHv0SD0CrHzqBdZpvEaCxLEm5akKuHK0h4NSdCVA9badvlve@vger.kernel.org, AJvYcCXaI9IIxWcYkKzt4OBFKaJ00O6+ajhJcDFU7sLm0V36kny9R6816jMuyCRs7JCblFPxja0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwfft8lxBeiWNjlEJBzLHTITUpGWuEEGasEIDHVOwVMfRO6UuS
	5BGL/joOw6a6Zf6qHMJcL6368qzahbF7vJpeWgbZ+JbqAhtISeMFRYRiqJZkYA==
X-Gm-Gg: ASbGncsyaSY/o/rwPLIPpMsNs2M64QWydYKFIahgY5otFsRH7u52NkRDyHdM3VRXmpw
	I8vzv9XihE5By8UfKQx6bXjUMGnlr+gSznv16Jup5VfFRk+w53BgJ6IE/wKZFy+LLimEdxQZla5
	Y//vmn2sKCkPasmwIFNPXlO6laiMmk9/Oxr15kdTRTMKdMtH460Q5DJiG2CbIlAxoN/IMuesgdJ
	QTn8STmj+iw1ds7XYSw5sMSH0ynwyoSaLkMfb9NEZtds87f2FwOiNueZCGl4p+OULamI1kdngh9
	e8f4SdjzfeZio3MwmPl8qa+OFfBA/fAqy81v+ja51FNPnleUV95tmTCIP1eZ0Du861I2tIQ+0Fw
	GJnvs6B9r2/v7LktRLX7XBpmNMB8F4zc/
X-Google-Smtp-Source: AGHT+IHV1yp8ldhAr9wCelUSHUXdCY7rvjNvQmXxZIVSyyDKFFWc6LabCe/zYvqXxmW6o1EZI00sMQ==
X-Received: by 2002:a17:902:c94d:b0:234:8a4a:ad89 with SMTP id d9443c01a7336-23f8ac4173amr25183385ad.1.1753155208647;
        Mon, 21 Jul 2025 20:33:28 -0700 (PDT)
Received: from gmail.com ([98.97.38.28])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d23b5sm66247595ad.146.2025.07.21.20.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 20:33:28 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:33:10 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vincent Whitchurch via B4 Relay <devnull+vincent.whitchurch.datadoghq.com@kernel.org>,
	vincent.whitchurch@datadoghq.com,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 0/5] sockmap: Fix reading with splice(2)
Message-ID: <20250722033310.geuc34ln2ie55zqq@gmail.com>
References: <20250709-sockmap-splice-v3-0-b23f345a67fc@datadoghq.com>
 <20250711160931.12ec952a@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711160931.12ec952a@kernel.org>

On 2025-07-11 16:09:31, Jakub Kicinski wrote:
> On Wed, 09 Jul 2025 14:47:56 +0200 Vincent Whitchurch via B4 Relay
> wrote:
> > I noticed that if the verdict callback returns SK_PASS, using splice(2)
> > to read from a socket in a sockmap does not work since it never sees the
> > data queued on to it.  As far as I can see, this is not a regression but
> > just something that has never worked, but it does make sockmap unusable
> > if you can't guarantee that the programs using the socket will not use
> > splice(2).
> 
> On v2 you should you can't replace ops for passively opened
> connections. Can that not be addressed instead of adding
> an indirect call on the data path?

I guess I missed above? We can create the psock and add the socket
to a map on the accept()?

It would be good to get some fix for this.

Thanks,
John

