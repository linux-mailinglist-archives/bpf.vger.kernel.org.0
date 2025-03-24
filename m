Return-Path: <bpf+bounces-54611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17031A6DA27
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 13:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837771894B5A
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 12:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB3B25E834;
	Mon, 24 Mar 2025 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pHv9vGXx"
X-Original-To: bpf@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EA11D86F6;
	Mon, 24 Mar 2025 12:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742819558; cv=none; b=cbxeUKFRo8tP00iGl3IpOHNJ+m/9HlTrabwM839WVZriUAn7n5k/EliswknHCqXRqZnFw8kYCsf2mckXu8sBqwtSt9/YESxPMJFd7C96hFrKyJM+9OAp3tNjNH4oWibtHJeDKX2Ey+N1MIDDDPN54K65Q66FJ44LeCPhbLnt68w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742819558; c=relaxed/simple;
	bh=sH88f8ym43WIDjTd+scKnUxoR8sbwOQddCzehgss+1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PmJBwiDZwv2biRzXLSu4CiaL8PSweskiogRnsg8d4cbmQkJ1z0HensYsMpn/bCWJZd7WvsxbY+DUhnpBpd1Kw0ZgSWDTurZkvAgG/ssB8/81R90Zv6wHvNj+N5jSvwWCXhO5ncleOr7OmECR0XYenq6GwE1Et7Md/3am9YZevl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pHv9vGXx; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1EC2644268;
	Mon, 24 Mar 2025 12:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742819548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mf0KM9P9XxQ06MQ8Trv1n/2houiTkBeECwZYfuC7Ebo=;
	b=pHv9vGXxdc7PSNlUtSXA74cAwIZ4kvWZgcKoQ5soeVCG5QPCR/mXSSSgaLzdnTVP9aDpV0
	c3sciWxUTfF3Ffvi1NCGDbccCM2ldk/Y8HxTm2dQrFHkhaK/ja9dHSO1DCLGFfk8yOsjEM
	7VeBOJ1zMAH0SNYK1WgGsudpMPkHDAKBCAaK1bZP4eVQs9YKYSqTvFJAYspM9p+yBuSmJG
	PlSghwR9yJrNlwDb4vmojRMChXVRCjVd4MUlBmiSJqtaolnGgbF2EHLinAXsa7T8nyuIUH
	eGAtkFZ7hTaoomhuU4B1Jr3yQSh+627lzJf68usselgh3S5koU836NlL8P3oUQ==
Message-ID: <764f5e7a-4188-4952-9122-62d5bde3bc72@bootlin.com>
Date: Mon, 24 Mar 2025 13:32:25 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 2/2] selftests/xsk: Add tail adjustment tests
 and support check
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org,
 magnus.karlsson@intel.com, jonathan.lemon@gmail.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 tirthendu.sarkar@intel.com, =?UTF-8?Q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>
References: <20250321005419.684036-1-tushar.vyavahare@intel.com>
 <20250321005419.684036-3-tushar.vyavahare@intel.com> <Z963wAD8HhOKdcAG@boxer>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <Z963wAD8HhOKdcAG@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheeljeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegrshhtihgvnhcuvehurhhuthgthhgvthcuoegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefhheeggfetffekheevuedvkedvvdeufeegjeevgfelveevveetffevfefgheeijeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrddtrddugegnpdhmrghilhhfrhhomhepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudegpdhrtghpthhtohepmhgrtghivghjrdhfihhjrghlkhhofihskhhisehinhhtvghlrdgtohhmpdhrtghpthhtohepthhushhhrghrrdhvhigrvhgrhhgrrhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtt
 hhopegsjhhorhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghgnhhushdrkhgrrhhlshhsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnrdhlvghmohhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvth
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Maciej

On 3/22/25 2:14 PM, Maciej Fijalkowski wrote:
> On Fri, Mar 21, 2025 at 12:54:19AM +0000, Tushar Vyavahare wrote:
>> Introduce tail adjustment functionality in xskxceiver using
>> bpf_xdp_adjust_tail(). Add `xsk_xdp_adjust_tail` to modify packet sizes
>> and drop unmodified packets. Implement `is_adjust_tail_supported` to check
>> helper availability. Develop packet resizing tests, including shrinking
>> and growing scenarios, with functions for both single-buffer and
>> multi-buffer cases. Update the test framework to handle various scenarios
>> and adjust MTU settings. These changes enhance the testing of packet tail
>> adjustments, improving AF_XDP framework reliability.
>>
>> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> 
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> We carry the description of executed tests at the beginning of
> xskxceiver.c and you have not updated it with these adjust tail tests but
> it's not a show-stopper to me. I'm okay with current state of this patch.
> 
> Bastien, you probably would want to take into consideration these changes
> if they go in before your bigger work.
> 

Thanks for the pointer, I'll keep an eye on it.

Best regards,
Bastien

