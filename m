Return-Path: <bpf+bounces-69862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F37BA4FDC
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 21:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26E517A44CD
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 19:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C873280CC1;
	Fri, 26 Sep 2025 19:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k/AcasrE"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F145D1C28E;
	Fri, 26 Sep 2025 19:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758916133; cv=none; b=o4eMEhu2yM+hr8QqaDUmTS+4x6kr3PI5/5GGb7gwjOtlcHiC76p1SG1PuxHhEllD+utHWLAj9J0X6A0KWzDRGr+MaRDN1Fj6AAxhBSxz7njIQATFKtBSV/uvLV3Sv7XhADQnZ1Q/hRC4b3l5pO+zeBu7aJgiDCMIKrsOE7yztZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758916133; c=relaxed/simple;
	bh=FhdheiCx6y9dWrnfxpFizwfAVKjgxQ/Tk8JnwiOYYgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dxi/5dPCzMhM11YzKXiRhT4Wmy73zkJX5Uzqv9Zw+SJ2OKd1oxZxtTImpfDRuFz5cM1gGBctjXgvit/+OCU3QcNRzGpUnEaDGyLz4opIxecjn+MdqV/KhvGIRJYv2hNLQ/kCAkP+OH6B9GBFLdmHqWaVOYMyMOF+ACXqH6tMCnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k/AcasrE; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <13ddb0d3-7441-43d9-b8e4-2c8f4acf99bf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758916129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x0Gc7fMzAGdSTtjRNVq2wPxOldQCzIe6qbC4MgXh/4E=;
	b=k/AcasrEqK3rmtG3Oxhq/hAbbTdrOP4nuhApX/CTj4BA3UfQf4jA2YDVWyAkcTIRfbGJIW
	UsNsDhPaAMrH0AZo8FGFvq7HofijniQgxIoyIE5K0qS2L/wjZ3XN/uk739pNhG0SWEX4d6
	ZdblEH5JZ+NgVT3NbIatm/yvMguF+UM=
Date: Fri, 26 Sep 2025 12:48:34 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 0/3] xsk: refactors around generic xmit side
To: Jakub Kicinski <kuba@kernel.org>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 netdev@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kerneljasonxing@gmail.com
References: <20250925160009.2474816-1-maciej.fijalkowski@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250925160009.2474816-1-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/25/25 9:00 AM, Maciej Fijalkowski wrote:
> this small patchset is about refactoring code around xsk_build_skb() as
> it became pretty heavy. Generic xmit is a bit hard to follow so here are
> three clean ups to start with making this code more friendly.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

Hi Jakub, the bpf-next/net tree is currently empty for the upcoming merge 
window. Could you help by taking it directly to the net-next tree?
or I can also take it to bpf-next/master.

Thanks,
Martin

