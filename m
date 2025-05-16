Return-Path: <bpf+bounces-58378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F4CAB95BD
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 08:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8745E4A5EE1
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 06:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426052222D0;
	Fri, 16 May 2025 06:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dwOsgyFC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA2D21FF3E
	for <bpf@vger.kernel.org>; Fri, 16 May 2025 06:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747375361; cv=none; b=BsFoVvxe1X+GUKG3Be5x1UmQxEy5LB3eurLggVD2DaRpzfVgiYOMYyH2mRqX5RnLjFah1OQxp3Xf2+3PVXPpjpYWdIUBo3uvH4dN0+OhN438abyB0TGkuqfbllWoAD869x0gQVqKWwkHVgYpJee+JrxJ67aQ86WWEzOwwnYy/w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747375361; c=relaxed/simple;
	bh=FFW0hqGTqpSSQEt0oM9VrJkvsbPrdiAwXszFH8NO5sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U74bKw9bHaAk84GhAImUI3Mcxjn9OkJjXJr8NlpbvraSTsJJ7RolcecZp6cekCIZq3AEwNMAO1hSCukfVnunq9Eh2q11jdNxPFbgVafXdWep33dSFcvTDdRHoQf8Kq301TloKm7CuwvK7aFAd6BsOl+bgCoDpOYQMiGD3miqh/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dwOsgyFC; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so13278265e9.1
        for <bpf@vger.kernel.org>; Thu, 15 May 2025 23:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747375358; x=1747980158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YRCpYLM2KigShkSCMx1Qo6LnPBeFu9CM55DsyR/vk34=;
        b=dwOsgyFCqUtAcxaArAly5u3HlrR0tZeCOZA5XgIZrvlgwqzqD8uisx2IOdMkXBU49w
         W1DzTjO/Hhg4Av5PY5hNm/SeQ1V5J6IH/7ZLOPBZJJ8g/2ZTcZuxIRqFOJW3J/Z/ZJH4
         ewH3fpXljxZToAHhvsKJ/AebACnS37CgT1HU8oJz7kNpDCpZF5MiYoJ2kTBkRn/VorzC
         0bQ0M+wUYBpa0WvNBbk8TJEGU2QItB0RNlqzb20EJ6wQ4dDrwQ5lTTgiWfUGZv0lN5Op
         ixN7sFbfiuQJONpzX9jtJegEwuserDLS6C233GiEx/Wh2F5fAjCE+IDslThlgd6QQScP
         HmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747375358; x=1747980158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRCpYLM2KigShkSCMx1Qo6LnPBeFu9CM55DsyR/vk34=;
        b=RfTzdjg2MRT88ocNSfHLDXWGTCYS0bEhP5AIRyYi2Jk7Saj7LrTjRKrYQJMmMFBHce
         R1QWyxHaM60Oh3WMuivnP+rzOXQjEIDKK5/IrnvCCSCNcTmBZ/I37nBxx6CFg8l+4+oa
         N6egESqh5/CRDi1i89s98pDvtF6Zkw6SLmaInMTVJvP2+ewLPya29aSCfkVWRAASDkME
         CMnStCCErT6PeZP4VG2hFAEJiARhiBkOi/AY0aM9rAHMVql+bxRcYSVmpTbPQ5bdGHdt
         xK4gaYht/VcP4bGDv1wEAg0+zQQP2O7KjYWwmbnp2XuaCBn4EmmXB75d8n41W3hHtqhk
         sRIg==
X-Forwarded-Encrypted: i=1; AJvYcCVQO/fkFBhQ3W2X5dkGWGjN3cKh/e4m29nF+wZpiVuG8Rs5bjGBGRByJBXiYeMTA5dWnsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF3aeFMrChcehwzhiDRJYG57iG5NJ3SJWux64tz7QIghZxGK0C
	1WrFlLAGlWww/P00RmhvdxLoUPEZ6ZqMDI09mC8j7EWzYfoCEK0x0L9CybV4YXPPu4k=
X-Gm-Gg: ASbGncu+QhSApt5UOktOhzBqGEdodMG1zFfqISPtTaPyD+thKmb3QrGR5qDChym2bT5
	yB+w4hEBuOIbv40z3MkpVeDVjo4uB37kHEm1oc1cqNivi05eJnqRuLDnirxdghA1+PGeYtQkZ08
	payTLjepHPw3jD9BOM+mt32LUtd3WKTxS+7zfUV0+GFxE3wWbp+ysCL2lp963pxXv4Xv3kspSWn
	hJsfHl8JCAU+EkKEJubNPKL4XMav8ilgAErcYsXhF0i4uu0XY/33pD0R/Z/Ty2XD32K6dBiQTmy
	sZO6XEeLzGtqwKTFyRIQtnRcmKghAA7rMfVfWB7VRIPWTWHaK/wuU36BE4dHvEokp8MJNsM=
X-Google-Smtp-Source: AGHT+IExAX5L6jhpudxoopt/jOxKXl18l7eevqO0BjrQScjyjlt4zB8dW0pf982EIRtAZl2LOgjSqw==
X-Received: by 2002:a5d:4567:0:b0:391:4999:778b with SMTP id ffacd0b85a97d-3a35c84428fmr1663501f8f.28.1747375357714;
        Thu, 15 May 2025 23:02:37 -0700 (PDT)
Received: from u94a (27-51-34-195.adsl.fetnet.net. [27.51.34.195])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87bec12287esm1112560241.10.2025.05.15.23.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 23:02:37 -0700 (PDT)
Date: Fri, 16 May 2025 14:02:22 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Kees Cook <kees@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Erhard Furtner <erhard_f@mailbox.org>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	bpf@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/2] mm: vmalloc: Actually use the in-place vrealloc
 region
Message-ID: <yw7aumjfrefi5cdejjgtjfeusaihfh5yjuhry3xvetjld36fgi@ob4a6lwdlqt4>
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

Thank you for the prompt fix! I'll remember to include a more thorough
note on reproducing the issue next time.

With the patchset applied, BPF selftests on both 6.15-rc6 and 6.14.7-rc2
passes successfully.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

