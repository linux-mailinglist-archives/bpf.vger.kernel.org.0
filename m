Return-Path: <bpf+bounces-71583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A28A7BF7636
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 17:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A33F18927EE
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 15:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D4E3451DA;
	Tue, 21 Oct 2025 15:28:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www.nop.hu (www.nop.hu [80.211.201.218])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 46738343D8F
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.211.201.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060507; cv=none; b=mtDZrWAsx2j2xvsFyBofy3pnwmNHRu154mnmtddbiaXSd9oLE7goj3KCfRycTFx6L15SUvA59GBaCbSFr0Ovd7Q8Vgqow+ZeA4e43m3f7Q1lWWWBalSNhv4iuSDITjOhLiU7ImbOqCB1JBGqSl2DVM7ei8ZiAK5GPtMASFz5Xd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060507; c=relaxed/simple;
	bh=1suUE1u6GypwD1Ynv1u2Mk6Y8Z28xL35eub4UFoDswA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0kX5z4a2Xmr1D48A9gDqYNnycYld4dCgpke2GZWPw9srOXIqVierm/s0u2moGxd67anabjloeLpFQmzFZ8OaoBhuBZ1+rgp3KR2unbGeSCTQXdSnG0yXK3uc8S35ZXIU4FU6vDIiXqXiMmJ7tCPQYONd/tKLFjVqzL5HKtyTBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nop.hu; spf=pass smtp.mailfrom=nop.hu; arc=none smtp.client-ip=80.211.201.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nop.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nop.hu
Received: from 2001:db8:8319::200:11ff:fe11:2222 (helo [IPV6:2001:db8:8319:0:200:11ff:fe11:2222])
    (reverse as null)
    by 2001:db8:1101::18 (helo www.nop.hu)
    (envelope-from csmate@nop.hu) with smtp (freeRouter v25.10.21-cur)
    for maciej.fijalkowski@intel.com kerneljasonxing@gmail.com alekcejk@googlemail.com jonathan.lemon@gmail.com sdf@fomichev.me magnus.karlsson@intel.com bjorn@kernel.org 1118437@bugs.debian.org netdev@vger.kernel.org bpf@vger.kernel.org ; Tue, 21 Oct 2025 17:28:23 +0200
Message-ID: <495b042e-62f3-4eb5-9190-f39d082b1291@nop.hu>
Date: Tue, 21 Oct 2025 17:28:23 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: null pointer dereference in interrupt after receiving an ip
 packet on veth from xsk from user space
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jason Xing <kerneljasonxing@gmail.com>
Cc: alekcejk@googlemail.com, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Magnus Karlsson <magnus.karlsson@intel.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, 1118437@bugs.debian.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu>
 <CAL+tcoA5qDAcnZpmULsnD=X6aVP-ztRxPv5z1OSP-nvtNEk+-w@mail.gmail.com>
 <643fbe8f-ba76-49b4-9fb7-403535fd5638@nop.hu>
 <CAL+tcoDqgQbs20xV34RFWDoE5YPXS-ne3FBns2n9t4eggx8LAQ@mail.gmail.com>
 <d8808206-0951-4512-91cb-58839ba9b8c4@nop.hu>
 <CAL+tcoA0TKWQY4oP4jJ5BHmEnA+HzHRrgsnQL9vRpnaqb+_8Ag@mail.gmail.com>
 <aPedG99fdFBnbIqz@boxer>
Content-Language: en-US
From: mc36 <csmate@nop.hu>
In-Reply-To: <aPedG99fdFBnbIqz@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

hi,

On 10/21/25 16:47, Maciej Fijalkowski wrote:

> However, I do not understand why setting mac addr on one veth interface
> triggers this path.
> 

just my 10 cents but imho i saw a check for promisc while walking through the call

stack's small epsilon surroundings, maybe there is a for-us check somewhere earlier?

recall that we're setting the interface hw-address to the packet's destination mac...

br,

cs


