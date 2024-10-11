Return-Path: <bpf+bounces-41670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 507919995EE
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 02:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D801C210C4
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 00:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38151567D;
	Fri, 11 Oct 2024 00:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiHS1hbN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A70C184;
	Fri, 11 Oct 2024 00:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728604888; cv=none; b=cInAM7rV9yhyozWSxDI3UH8AQJvw84B9nhEu/x3fQ9yy0gzqcmNpurNshhN+UBLXgMN1Rq/HBjd3T7EjAocUR/wWfYFnGkfYWXs1srd37YGgQlLNlknhbUwEkEKiOGWRhkH7GTlWcx6PXb6anTLdso1TzY7YLDPM/3I688vrGpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728604888; c=relaxed/simple;
	bh=DjIteSTidZSiBek/ASoFKrjQrBLhLEaVQuyEHfwMivY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhaRrYzNNhSqUBngWvA2XVepyDDyKDd5xtvdrTz1X9+f9ygs3t+kAa/ovpiBo+h/Al6lHNMTv6+a3o8K8UGPjt9nr7fQKFqOdV4NP3NpFsXLXMPD9wAaicSeL5WCeON++pHZzeF+TKcPQU/RjPR/fBqVNMj6ZAj97/7Do6b8H3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiHS1hbN; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5398a26b64fso1499577e87.3;
        Thu, 10 Oct 2024 17:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728604885; x=1729209685; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QR7eQHErdNfHLZS6BtpfLJOhVgMy01okWLFsgrPJ2+w=;
        b=fiHS1hbNSrKSl47D5QmaI6HcIgDb4RbnhHI1SG7hG6VnivFsgtckqCEe+0SjFxrR39
         waTTrMTX2TH0vEJ+eoOW5145cCEjuevI9OvLACq6awP9qHiT62ABb8ZUjWJCi5ufQT4t
         EKjhWlvaF9q9sLiyoU51gUwl4vJuY3Egb6D/S2lC0e9CXxt2ev5kZOrMzk0Pv6Rxmi2K
         HX7sbgrex2FiQQ5wSppP7D6WS0UekzSo2wMdrWpXVZyfZp4lEdJ8uBgkeFO3RIf/I+xb
         /vTQOZm7Qz+5iLUpCkJxYkwnuuAUaHwRxekv4XdZf5AI2+PfI3F2Ki4TCBwjJnp5vqIG
         cWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728604885; x=1729209685;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QR7eQHErdNfHLZS6BtpfLJOhVgMy01okWLFsgrPJ2+w=;
        b=i+3IZXX0bwG4LyKmXfArEZ3xytRnLzk2wL7zmSNAJyCCow2iSpmM/DTbEw+Gf5vthj
         J8MOl+OFQFnod98WLKzF+7GPAEEVDM++XV+8u142U5fGKaDyIW0sRWeSQzBiXAMhs0Jp
         WFQkJGunVHbSv69wgpHJKLA46HPXr4K+pXjMJR9M8x1vQPK8FCr21dts1s0tFwX+aRSZ
         fdP5GRi3Is7kBm2veR9G8i8UHe4ig+oeV/K563iTmhdehk0863/DNe+vdEL3LGkY1Gmq
         lMGmHJ56YDcv4xSQv35C3xx10uEtQaK36TL4M+D8IsAZG6pE7nQbqHlSlfUgTmuYwfzz
         3vyw==
X-Forwarded-Encrypted: i=1; AJvYcCU8DOsmU10LT8GyBTmJqKjJWQxlpvSfrI0EaH1Lrt2Sn9Yr3AYSwYaD1jrfUoPcFU6qgnTYjeoJZgaTSu6A@vger.kernel.org, AJvYcCXKyERLv+FtS3SNfQzSfMlMoU6u34k5hNkeSygAtVN+7ZO31cwPMeVwYQU3EYDXZYPnCtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5WQ3S9LYyPsKRbVVqQq7Sbjuj9F5ZYP12OpRAVeRFu0AlP4YG
	0U8d+sSZa99OIaYIRUJ+xmxRogxc6+5fB+KloeJDwtQVtg7bsHp2
X-Google-Smtp-Source: AGHT+IE4cooIMQfC+OmH1uy5ckkJ9Tp1lCSmPVvSLo7PeJxTYUKT/COn7zRsZE/36GgHwgQ8ylic2w==
X-Received: by 2002:ac2:4c43:0:b0:536:7cfb:6998 with SMTP id 2adb3069b0e04-539da4e1f18mr271377e87.35.1728604884838;
        Thu, 10 Oct 2024 17:01:24 -0700 (PDT)
Received: from mobilestation ([85.249.18.22])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb8d7fadsm424885e87.169.2024.10.10.17.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 17:01:23 -0700 (PDT)
Date: Fri, 11 Oct 2024 03:01:19 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, rmk+kernel@armlinux.org.uk, ahalaney@redhat.com, 
	xiaolei.wang@windriver.com, rohan.g.thomas@intel.com, Jianheng.Zhang@synopsys.com, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, andrew@lunn.ch, linux@armlinux.org.uk, 
	horms@kernel.org, florian.fainelli@broadcom.com
Subject: Re: [PATCH net-next v5 2/5] net: stmmac: Add basic dw25gmac support
 in stmmac core
Message-ID: <wufpbnsa7w4bk57drsjywnbz2di63yfn7qrmkxfmdh57zuoaeh@6j4xgyonjy6l>
References: <20240904054815.1341712-1-jitendra.vegiraju@broadcom.com>
 <20240904054815.1341712-3-jitendra.vegiraju@broadcom.com>
 <mhfssgiv7unjlpve45rznyzr72llvchcwzk4f7obnvp5edijqc@ilmxqr5gaktb>
 <CAMdnO-+CcCAezDXLwTe7fEZPQH6_B1zLD2g1J6uWiKi12vOxzg@mail.gmail.com>
 <CAMdnO-JZ2crBaOEtvgMupQs7nTZ8r0_7TTQdX3B3n6F_owAMZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMdnO-JZ2crBaOEtvgMupQs7nTZ8r0_7TTQdX3B3n6F_owAMZA@mail.gmail.com>

Hi Jitendra

On Fri, Oct 04, 2024 at 09:05:36AM GMT, Jitendra Vegiraju wrote:
> Hi Serge,
> 
> On Mon, Sep 16, 2024 at 4:32 PM Jitendra Vegiraju
> <jitendra.vegiraju@broadcom.com> wrote:
> >
> ...
> 
> When you get a chance, I would like to get your input on the approach we need
> to take to incrementally add dw25gmac support.
> 
> In the last conversation there were some open questions around the case of
> initializing unused VDMA channels and related combination scenarios.
> 
> The hdma mapping provides flexibility for virtualization. However, our
> SoC device cannot use all VDMAs with one PCI function. The VDMAs are
> partitioned for SRIOV use in the firmware. This SoC defaults to 8 functions
> with 4 VDMA channels each. The initial effort is to support one PCI physical
> function with 4 VDMA channels.
> Also, currently the stmmac driver has inferred one-to-one relation between
> netif channels and physical DMAs. It would be a complex change to support
> each VDMA as its own netif channel and mapping fewer physical DMAs.
> Hence, for initial submission one-to-one mapping is assumed.
> 
> As you mentioned, a static one-to-one mapping of VDMA-TC-PDMA doesn't
> require the additional complexity of managing these mappings as proposed
> in the current patch series with *struct stmmac_hdma_cfg*.
> 
> To introduce dw25gmac incrementally, I am thinking of two approaches,
>   1. Take the current patch series forward using *struct stmmac_hdma_cfg*,
>      keeping the unused VDMAs in default state. We need to fix the
> initialization
>      loops to only initialize the VDMA and PDMAs being used.

>   2. Simplify the initial patch by removing *struct hdma_cfg* from the patch
>      series and still use static VDMA-TC-PDMA mapping.
> Please share your thoughts.
> If it helps, I can send patch series with option 2 above after
> addressing all other
> review comments.

IMO approach 2 seems more preferable. Please find my comments to your
previous email in this thread:
https://lore.kernel.org/netdev/sn5epdl4jdwj4t6mo55w4poz6vkdcuzceezsmpb7447hmaj2ot@gmlxst7gdcix/

> 
> Appreciate your guidance!

Always welcome. Thank you for submitting the patches and your patience
to proceed with the review process.

-Serge(y)

> -Jitendra

