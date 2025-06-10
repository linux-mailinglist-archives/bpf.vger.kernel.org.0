Return-Path: <bpf+bounces-60184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86976AD3A31
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 16:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081D9178B09
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 14:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566352BCF5C;
	Tue, 10 Jun 2025 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OW2qzXgA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E5125B30D;
	Tue, 10 Jun 2025 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749564175; cv=none; b=lDHQeoDBVkumg5HYkDCcH2tYUGDWWj2mzjbL1g4FVOdrdzoSRB+R/dgVrxeKC4/TLReHt735M1NWrRU/6a54SHSzLUlzkjV/BMu//7p8Xt7VmpM60in5IwA838ZSZrHnoBc6bzlv1x14yER3xXzEAuXcDOON/t78ZngB1g7p0vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749564175; c=relaxed/simple;
	bh=rR2+r5qNZldGyUCZ7EWqLJNYGGfGfQV4TCmD9BJ8pD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IVWAsZ03UwETgeFy7ZGEhRhaKQhFo2cAtC/L6ePEBloE/rvivB/MKkwEntUAcXSuqEWxMZs6tG72L8TFbfiRXJhxCrp7vYbN8/MSZ4AON5RohCR9kVq3CMimRUFAj70TnAsgn9gNfJFCCY/Pex/T1g2svgfn4v+CgCkokw8aV1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OW2qzXgA; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-313154270bbso5701300a91.2;
        Tue, 10 Jun 2025 07:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749564174; x=1750168974; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rR2+r5qNZldGyUCZ7EWqLJNYGGfGfQV4TCmD9BJ8pD0=;
        b=OW2qzXgAZlDINTdroA851sXZOYgJ2HxFdojff9YVT9CFzbwd/8EYIFn9t95ImIEIoI
         skcaCiuWb+2gsoeqGsJbm7maM4xTd0GRGOzr20UaXZ7IzMbt658h6opwKj9Fe3JNSB33
         IZw9hORs+jhv+/EGC0DJDAdC9FrNjF2QK+R73X3/CNe3M6nWnlrWw817ua+Dl1KiHTEl
         DzLvqe/mAaP91B3LUuwyk1ldLGlPbjctv+sGoaqNBh63Xfy0SeTHLu5KfKQTPRUa576Q
         JvANJQAMBYPSf3sjkV+QtxYtQAjyfMk/ROpS21tG8ZJLDruKEDbIuDLuK+TmqxTuLPTt
         8vIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749564174; x=1750168974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rR2+r5qNZldGyUCZ7EWqLJNYGGfGfQV4TCmD9BJ8pD0=;
        b=rUcoEXBblm9u5/WxM9sLxO/C82xbSOt/KFCvdCjcUI7WQx1ScSsgfZ32ndzgxJ7BPi
         pQY4a7nHurEHkfJlI7dH9J3w4ioe/kMf1SDON1LxCBMRRGmMddy6NiJBa4uuKl1Pmp4n
         RNhWiV6Sv8yyuHF6R+4aEKh6m/a7fEKiFCwDDiAf+Su4TGd/q/moGIhEiQBPQH0PBsXV
         32ooXEio1cbHk5ocZYaHTuqNCZzDfKUeD4n0fNXkfT017ltENUR2iVv2jWJAE2NRwSkm
         RUcmAdNXwpnjz4v15tEFEW6Rlf3F0QV+lBIfIvpc3buxPrUNxG21bWdfXKhsQpV8bLm3
         kuUA==
X-Forwarded-Encrypted: i=1; AJvYcCWWnYR6j4y+Uhl9xCderGsQwhlFoYLucNpuCkCMeIGD0r2nAxGfeP28qMrjQOSu/iY7Wdo=@vger.kernel.org, AJvYcCWysfW2CcPHl2xmmf/wvpws/sX1ygOqa0PRV5erSVJZ5Gud4bVasH6NNmbgPrZl/cNRhGAptVx+@vger.kernel.org, AJvYcCXS0SxiS05X72d9wFgR+LdzetHHPluIJziRO7A1VKA/CqhK6l7UVOJ9wF5OaZBdzP5wZWdhQjEUaD+pO3Rw@vger.kernel.org
X-Gm-Message-State: AOJu0YwVSWnpoEGtNTxSawUd/3ZaH4nPh91XNKaBZnl1wN6Yz4b640lx
	1m87eC2/zbr3SKthJ6rgHIAAEH0preD8m3LdNlRa2TecyUftIpXIIy49ckoH/Tx/6saBNyFLvju
	vEuEO5m1CmLlsLbfkFtg8485tfEDmSw==
X-Gm-Gg: ASbGncsPzZLg9zqCRrlCMouIqvsWg17uoX2SDPI8s6+4x0NY7bTdQIT2LYJTflm7nbz
	z9/PLSqoW4p702fxnnzCs7kZPzFKdtYbFv3/Jnc/OKy2lJBmNYKiQSSYaVINjNvHj6iMvUiASuN
	hMGF5MmgGjAfIvrBZ/GM8lGHQtl9AcIN29ABngTKFacSc/Ibsh+ohTHg==
X-Google-Smtp-Source: AGHT+IFt6O/F8LJeutdiPpaedvHBL+GurnehgGHHbAiwrPXXlKx3pwq3X47Mvfn6ggzqaLckHZKni2cumwmBeWQc7wA=
X-Received: by 2002:a17:90b:268d:b0:30e:3718:e9d with SMTP id
 98e67ed59e1d1-3134769bfbbmr27041075a91.35.1749564171758; Tue, 10 Jun 2025
 07:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609173851.778-1-ujwal.kundur@gmail.com> <05305f84-37ff-4345-803a-85c2025dd67b@intel.com>
In-Reply-To: <05305f84-37ff-4345-803a-85c2025dd67b@intel.com>
From: Ujwal Kundur <ujwal.kundur@gmail.com>
Date: Tue, 10 Jun 2025 19:32:37 +0530
X-Gm-Features: AX0GCFsmJxL0oLJw9jrPJRYkmar4Cb03jp8TbUi0T0LQIAMmGtBD9J8x6weufv0
Message-ID: <CALkFLLJpz2MxRZ8r+mGayU_BZE=2=ukXTzXcnmyhXeHB7Q6v3g@mail.gmail.com>
Subject: Re: [PATCH] bpf: cpumap: report Rx queue index to xdp_rxq_info
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, 
	hawk@kernel.org, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	aoluo@google.com, jolsa@kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> This looks wrong...
> I think this will always return index 0

> So passing dev->_rx to that function will always return 0; which is what
> the field is already initialised to...

I didn't realize that would always return 0, sorry I should've tried
to understand that statement better.

> I'll just add that you may want to take a look at Lorenzo's series[0].
> Rx queue index is sorta HW hint, so it shouldn't be a problem to add the
> corresponding field to xdp_rx_meta.
> Then, you can expand cpumap's code to try reading that HW meta if present.

Thank you! I also tried to work backwards to figure out how the
queue_index would be used if present in xdp_rxq_info but that wasn't
immediately apparent to me.
I'm keen on learning/contributing to the BPF part of the network stack
and this seemed like a good first patch to take up -- I'll understand
this better and try again.

Thanks for your time,
Ujwal

