Return-Path: <bpf+bounces-52363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB21A42329
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 15:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08BA7167DC4
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 14:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2385E152E12;
	Mon, 24 Feb 2025 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="SqKLFB7Y"
X-Original-To: bpf@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBFB1386B4
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 14:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407182; cv=none; b=cn3zxVu7DUx9P7KzpEUsd3c+Fe80+2yLN0aBq5/WyTXRRC3ctzpYBWwqnN1U+n7WtBzCmGsPAuZZs58I931/3FMLRtcxsi9M7LWP5i/U622rYD5ZnKfbfgTkQ8cniiGjgz2++7QtUXDu2gr/HYHJuc8jQnJnv0fSEC3uKkndnOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407182; c=relaxed/simple;
	bh=YJn3woxK99j/HYFR7SrHcTgr8jkuAijYmO7yf5S97V8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AeO3+yPQSD+Ji4CDctwl8a4Go2ppDjLkApE+5YVM1ZyHE678yw5qaUXHquUqMcF+PD+uB3zsp4YfIjmzlvq1TgDs1VSpk+J9nbNk+IE2zJtEZ1F8Deg+uffwlGURwSBjNSZmiuwAhXTJrgsoq0mPmiZ5BGK0lp4swL3RITDqCU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=SqKLFB7Y; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202502241335168baa8ea9cb7d547078
        for <bpf@vger.kernel.org>;
        Mon, 24 Feb 2025 15:26:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=R1EHSTzEQ92GkWe5nywbq1cueM9EbdwXB/DLHyzBjiE=;
 b=SqKLFB7YwFbWWuEhr1MCqeKYnEQSz2VXFg7KrCFXnKFuDZY7mSc5YJYSAjU1wQvwlMMJCt
 fNUnP2QSV6I9EUzxZMEvc5SC3itYYCVA322Y0yr0He0gd13YDjKUYKUVfBI9wU3Gar9Jmkd/
 shcYOKByKL5tTG/tyK94Pr3Fe/6dmoIUIdMZWFabYfQPz2xhL4ksBMwnVwlTidc9jdC2M7Rc
 5w1/rq+g/gke1Wu0E8PBPBaKrgDfjFls5heEdYK9QE1dialj0BEepPoRtGhqcZzfFiWN3lVu
 AVGC7tefTMsEt9u5fWy2SjZtn268N3cIykNwJOv4uwyE0uNaJniZiucg==;
Message-ID: <b437f359-912f-4b9f-8de1-9c1122fee26e@siemens.com>
Date: Mon, 24 Feb 2025 13:35:14 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 0/3] net: ti: icssg-prueth: Add native mode
 XDP support
To: Meghana Malladi <m-malladi@ti.com>, rogerq@kernel.org,
 danishanwar@ti.com, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 u.kleine-koenig@baylibre.com, matthias.schiffer@ew.tq-group.com,
 dan.carpenter@linaro.org, schnelle@linux.ibm.com, glaroque@baylibre.com,
 macro@orcam.me.uk, john.fastabend@gmail.com, hawk@kernel.org,
 daniel@iogearbox.net, ast@kernel.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20250224110102.1528552-1-m-malladi@ti.com>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@siemens.com>
In-Reply-To: <20250224110102.1528552-1-m-malladi@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328357:519-21489:flowmailer

Hi Meghana,

On 2/24/25 11:00 AM, Meghana Malladi wrote:
> This series adds native XDP support using page_pool.
> XDP zero copy support is not included in this patch series.
> 
> Patch 1/3: Replaces skb with page pool for Rx buffer allocation
> Patch 2/3: Adds prueth_swdata struct for SWDATA for all swdata cases
> Patch 3/3: Introduces native mode XDP support
> 
> v2: https://lore.kernel.org/all/20250210103352.541052-1-m-malladi@ti.com/
> 

Just wanted to let you know that while I don't have access to the SR1.0
devices at the moment I will have access to them later this week, so I
will test these changes then.

Best regards,
Diogo

