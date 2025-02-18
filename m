Return-Path: <bpf+bounces-51826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E915A39C57
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 13:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C40716D6CF
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 12:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4AD243959;
	Tue, 18 Feb 2025 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="LYnOnoVz"
X-Original-To: bpf@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4AA243382
	for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739882118; cv=none; b=k+kLHGiQeBsUrGg9fpUXMcrKxvAXugfdAalSLBAcLOhO1Kyu60xKlA9XCyWzH22RFej86hhOwN/GIUi2yBNvuK17Ul61qH/Fq+9GuhBbv9yOYw3nOmXryPrqUNv5LX1FdJdFM/S+jQXTvFWCqPwbnFLg19vAwu2PZx7riur1XqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739882118; c=relaxed/simple;
	bh=YhCOzDgUX6Ndgo3HStvHEdN3KMsN1P0sllHKIUBhUIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hn5ZzdmBEmACBjWdO5fOnQGYP2kIwwtVQM5tKaZVh95cFdZ5lTc2J4ThbJ4wn4Z+zhUF/1HCTOXUS8W9DyqrU60qsf0I080tenYvCMVBMcR+ZfJ2k9++0hvpvNeCqOMa249NanGcBEAKwxVjgTAdKzzwtZ+NMHDqI80emP4hjHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=LYnOnoVz; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20250218122503e92f93a08c4a4ffa40
        for <bpf@vger.kernel.org>;
        Tue, 18 Feb 2025 13:25:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=G2Mmqb1Mk7iE4u/cA5jv4vjZ4vx0m26FAwwSyjZdlAQ=;
 b=LYnOnoVzgyvt12BzEBe4VCAtllZyzgApaONlStzl87LQ29SrPPal3so2Kv7HmCgq4Ld9S7
 4JEn/o4WmOcWz+1JMdwklNEOfmMGoLAEo0dAXatefHPXGhGsjnkKkJwuGIsgGd55oQKOGXRC
 RQm6nZI5WWfQBog8RYiB8xQ8xaXWnR1aNkCA/4UKRLB7xWOVrYVerS8q3NSW93NU2X97sB9+
 mcf1JZorJoE2dRh9W2+YgEea0iz23kjFC4C/IuOyhvRyKzjQxNQ8UBlqQDSaSBuVP+umSias
 BDTLqrMQfDqhz26QVFYf9tFU4sJqmeozUU5VMjiYWgCqPol3D0wtN8Kg==;
Message-ID: <c8bdd93d-5690-4b8a-819f-853756b57a71@siemens.com>
Date: Tue, 18 Feb 2025 12:24:59 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 1/3] net: ti: icssg-prueth: Use page_pool API
 for RX buffer allocation
To: "Malladi, Meghana" <m-malladi@ti.com>, Roger Quadros <rogerq@kernel.org>,
 danishanwar@ti.com, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 u.kleine-koenig@baylibre.com, krzysztof.kozlowski@linaro.org,
 dan.carpenter@linaro.org, schnelle@linux.ibm.com, glaroque@baylibre.com,
 rdunlap@infradead.org, jan.kiszka@siemens.com, john.fastabend@gmail.com,
 hawk@kernel.org, daniel@iogearbox.net, ast@kernel.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>, diogo.ivo@siemens.com
References: <20250210103352.541052-1-m-malladi@ti.com>
 <20250210103352.541052-2-m-malladi@ti.com>
 <152b032e-fcd9-4d49-8154-92a475c0670c@kernel.org>
 <615a2e1f-5ee5-4d80-a499-8ff06596a2fc@ti.com>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@siemens.com>
In-Reply-To: <615a2e1f-5ee5-4d80-a499-8ff06596a2fc@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328357:519-21489:flowmailer

Hi Meghana,

On 2/18/25 10:10 AM, Malladi, Meghana wrote:
> On 2/12/2025 7:26 PM, Roger Quadros wrote:
>> Can we get rid of SKB entirely from the management channel code?
>> The packet received on this channel is never passed to user space so
>> I don't see why SKB is required.
>>
> 
> Yes I do agree with you on the fact the SKB here is not passed to the 
> network stack, hence this is redundant. But honestly I am not sure how 
> that can be done, because the callers of this function access skb->data
> from the skb which is returned and the same can't be done with page (how 
> to pass the same data using page?)
> Also as you are aware we are not currently supporting SR1 devices 
> anymore, hence I don't have any SR1 devices handy to test these changes 
> and ensure nothing is broken if I remove SKB entirely.

I have some SR1 devices available and would be happy to test these
proposed changes in case they are feasible.

Best regards,
Diogo

