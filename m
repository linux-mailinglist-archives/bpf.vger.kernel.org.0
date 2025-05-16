Return-Path: <bpf+bounces-58379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49063AB9601
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 08:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1831890DE6
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 06:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE8F224885;
	Fri, 16 May 2025 06:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wqr4JEkB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D921FF7DC;
	Fri, 16 May 2025 06:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747377176; cv=none; b=Rf5hyJ4MHik0Ky87cH5XoPhG1uwIsbK97tMXmOV8u+M9eljuiFcNzhV0dDHh+1jeSb8QoF77oNHOLCli8H6paOHmE0S7/YczoNss+W+tYd2dpsNC73qkyBNJ39vQEuNM0k19z0Abmzg3mhF3imm34N2pbLnzN19KrFc2LuYbREA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747377176; c=relaxed/simple;
	bh=NtEGmOTZqNuMiz2OCMtuAQv0Feqa6Dit7H5OY+B8VmM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMYQPpnKCM3t0sSUkK6EMRTsIt4nQLOyBLpKnhOk1OZdVMIV3VrZj70rQSnUu9qF2wJw6LQ6+fBpaXymSNPn6d+jURd0eNMtyuexoNMi2r/5a5rHxvJwbj6F/egzeeuijJ+38J3pDZPk7u9m9/jNAsW7ieAIQAvUt7rfTk1fs8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wqr4JEkB; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-550d09d4daaso1669835e87.2;
        Thu, 15 May 2025 23:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747377173; x=1747981973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KUJKtPVwdVcpqXmFstCnFFaHnVm1C/pmwz6nmZZHgzI=;
        b=Wqr4JEkBgQvfK/neI+C1bIzjlWhCLxhRUmlxm8ixsHSQ61qJ9Ku+U69mbPyA1MAqdW
         DFmBoRjKdR6XucjBQMsGHaw0mRXsl7JHVG2MOnSBm3gehOIGbitrBYLRFAx8TmZFf/Xx
         OvdTMpDnumb6AR/InivmA1Nd3/28lj3k2c57454Vc6MbGNGiu9/HzQupPQewhFrIH+Ky
         VEE3XH3Obf9u6pg+okOatnVWxSEz8pbE+xB77J/60fcWrb75PciaNLaqYVsSs2Fp4uzO
         ID7Gk3ChFDF+dWAxteBhaNxHShnY303uDiUiKy7LhO9uVF3jrGeWj9akLZU4DVdTqXQk
         kwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747377173; x=1747981973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUJKtPVwdVcpqXmFstCnFFaHnVm1C/pmwz6nmZZHgzI=;
        b=GhW/7g5D0luU25JvO3IJSYXEHmXo8nRpEqRaboYWRS9oAFm+Ekd5WIM7H8O0xoeASS
         Pi/LO0GgsqwNAUPFOmQ04Cux91VRp3vaaQj4PqZygmHsNO+ayB0w7mM18Ie8bhK+Yj0G
         GjAwGFfuydD3ecw85wA/kaF0BTCD8JCNtmKHgc9naAvAa8jOj/aRKhxhri9qWfr+NeDM
         rNzFh8mWTPJQcmc+2o6FlMujjAMdzjVGsnmoTVVK/SaC3VXdQy4huGF/bJfsjzyozEb0
         hD+P46fY3nGG+uET87aitFVrJ39WgMZHdNxfWiy6dlPfm9N0OXB1ltqOqWSS6y67UKJP
         88EA==
X-Forwarded-Encrypted: i=1; AJvYcCUEG3ZuHSN4vEFmbr6AOKVVrEkv0XdT0wrPk2Eh1dt+GLYYb/SwmzZiI2U66ifhgDwMb0C621knmG2sllkQ5af7@vger.kernel.org, AJvYcCVjJz2/375EyI+jINf9FuBcmcVmwXwdiX3D3/FI7caCgQRjxdx5GbCYf8++hWCt4vsXO1g=@vger.kernel.org, AJvYcCWG7KygT2JqvUX6VMMDAoFgrCCGImT+SKiYNXb62Ic1tfg4MuwGwbOuaI39K/W7lc+//0QAwkW0wZP3naEL@vger.kernel.org
X-Gm-Message-State: AOJu0YzvIZZ4kD2ngrBWmyvCs2fQMmt/Xm2rIE+GgynfDJntzfTtTXW4
	GEVtJIXaf4QANJEdN9PDeqkX/9jEvayrqZbAKs8HPSm5Va214mNQ8lsF
X-Gm-Gg: ASbGncusXpTSnj2hvnR1Ao5DPckkYofLYXTIakgmOnNFc/ViesgZdr/5Dm2NnreAjem
	YL8c//xsx8taDZw+8LP9Lgde2BokGld1igwzFENB3CY2qzcFUVSh2H4CGXnLAMWIJt5PfERCKc5
	8m9se6XkGT714OLfE4ow053zjqVEiho8cscIPXTXnnwe+mlLpsq5+jaUPyPJVpyTTP9NUiLmJSO
	Xeaic5y5s5hZdIYK9hiMo+e0UIZUaUWf/nNQ2L/6Pf35Y1g/p3iS/LMowkl+E6cjIBdhtUA7nkj
	OuzyYuwyCgtZkCaT3A==
X-Google-Smtp-Source: AGHT+IFRP/vXmfI6lHLwDlzDmnD+1TtQ98Hefzc+j7BWdek+k9pG/xT4EAPbSUkky9UNn9GYhdpyww==
X-Received: by 2002:a05:6512:6501:b0:550:e147:8165 with SMTP id 2adb3069b0e04-550e71d0bf3mr569220e87.24.1747377172352;
        Thu, 15 May 2025 23:32:52 -0700 (PDT)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e703c2f3sm275344e87.214.2025.05.15.23.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 23:32:51 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 16 May 2025 08:32:49 +0200
To: Kees Cook <kees@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Erhard Furtner <erhard_f@mailbox.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/2] mm: vmalloc: Actually use the in-place vrealloc
 region
Message-ID: <aCbcEWR9RbjFjXV9@pc636>
References: <20250515214020.work.519-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515214020.work.519-kees@kernel.org>

On Thu, May 15, 2025 at 02:42:14PM -0700, Kees Cook wrote:
> Hi,
> 
> This fixes a performance regression[1] with vrealloc(). This needs to
> get into v6.15, which is where the regression originates, and then it'll
> get backport to the -stable releases as well.
> 
> Thanks!
> 
> -Kees
> 
> [1] https://lore.kernel.org/lkml/20250515-bpf-verifier-slowdown-vwo2meju4cgp2su5ckj@6gi6ssxbnfqg/
> 
> Kees Cook (2):
>   mm: vmalloc: Actually use the in-place vrealloc region
>   mm: vmalloc: Only zero-init on vrealloc shrink
> 
>  mm/vmalloc.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
Looks good to me both.

Reviewed-by: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

--
Uladzislau Rezki

