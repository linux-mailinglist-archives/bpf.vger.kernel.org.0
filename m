Return-Path: <bpf+bounces-51843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59722A3A206
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 17:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DDD418973FB
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 16:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331B626E15C;
	Tue, 18 Feb 2025 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKBVKgvP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F6E19F10A;
	Tue, 18 Feb 2025 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894586; cv=none; b=RK2THXIrUN7Mg979HuR/o7rdptT68k7oAn2dwUMWstiCOfYy9vw/OZ4MTRtl2wv4h6eZHNpAA/otfmsIwlc4FZN6m+fk5OP2E9wF1gDep/Y1g1MNLijkxYAUgteG5L5DEXKTF6RcFbTaXMR00lC8n8NyJ90T3/FdmIsp1kJ5QBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894586; c=relaxed/simple;
	bh=Qb2ewoBBdIkfatXZOY9Up8MK8RjKWh6vf/e+Ck7LFYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gt852aWjUELZDcKm/7b2Xeq+fw2QF1YEN/qnt81Q5JMM6LEtOrl4LzzcoQ9ih+Ay4/lEMz3RS3A0CLUXvz65rO51+xzb54YIAWLmps1iPCJx/osPFT5cgQ542nM6GFU3AUDU3gq2Zm1s05IQAuxxXR5rWQj78VoWyw4BaDD+mFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKBVKgvP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65627C4CEE2;
	Tue, 18 Feb 2025 16:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739894586;
	bh=Qb2ewoBBdIkfatXZOY9Up8MK8RjKWh6vf/e+Ck7LFYc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eKBVKgvPP5Cy1fgizplgS1AY2aj41oZ85GgtO14QskHv5mzh3yo8vmQo+EfhBOQaf
	 WsIM7eA2JOW8ZEMfZN+tPw6lUAXr1wuDoh+P77aTERJ6x3db9LqcjJZD/oLCsQ4AwB
	 CuflV6yS5nlvj0GlVJNh27JnrHW/xIx+dvPjLmvHBckedMhwNJwlxgW51i+zrzjaxU
	 ViO63I8XxAJZfKxKqNAO+mKiW4lfZlQhU6VvvAvrDfsT7Tszujpgxd786CU+MrKUCr
	 /Ba3sG/AtA+MUBuYJf0DtbHLWchnHSQV7U7ZgBvHdayMrWJz1z/f3ALrWFxh9EU5QY
	 902l45aMr4ISQ==
Message-ID: <285d1541-6af4-4dc3-bdcd-720bfc1f9aa4@kernel.org>
Date: Tue, 18 Feb 2025 17:02:58 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/3] Add native mode XDP support
To: Meghana Malladi <m-malladi@ti.com>, rogerq@kernel.org,
 danishanwar@ti.com, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 u.kleine-koenig@baylibre.com, krzysztof.kozlowski@linaro.org,
 dan.carpenter@linaro.org, schnelle@linux.ibm.com, glaroque@baylibre.com,
 rdunlap@infradead.org, diogo.ivo@siemens.com, jan.kiszka@siemens.com,
 john.fastabend@gmail.com, daniel@iogearbox.net, ast@kernel.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20250210103352.541052-1-m-malladi@ti.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250210103352.541052-1-m-malladi@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/02/2025 11.33, Meghana Malladi wrote:
> This series adds native XDP support using page_pool.

Please also describe *what driver* to adds XDP support for.

This cover letter will (by netdev maintainers) be part of the merge
commit text.  Thus, please mention the driver name in the text.

This also applies for the Subject line.  It should either be prefix with
"net: ti: icssg-prueth:" like you did for other patches, or be renamed
to e.g.: "Add native mode XDP support for driver ti/icssg-prueth".

Thanks,
--Jesper

