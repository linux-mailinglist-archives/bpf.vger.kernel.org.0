Return-Path: <bpf+bounces-27055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C978A8798
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 17:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05BCA1C21B24
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 15:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6CD1482ED;
	Wed, 17 Apr 2024 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="se2Q5oyT"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526E7140E29;
	Wed, 17 Apr 2024 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367806; cv=none; b=jxfICum6kJhzf4BEfUa3H6MbxHg79OgHpAuWNJ74dF5VdZLGG00N9dXhJVlJh70U2c6NIrRpZs4GPMgjQSogGZoiWX7xJ2rIQrk6WF8j23u4u4+ev4ZoqqHssOQgPgxqxaGhK6uqpirrrHRQYg+CglveYxyGlpX07P5noADey8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367806; c=relaxed/simple;
	bh=XkH4g4DTe/chnyyem+t7TxDHFU5BkdWClQJ756pn9hU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DnBLG7d46aVBgn8eGWy3s2OFhhnpGw9aucC7m9caYONdrT+/YgDPN6Y81YWktGMPU57EdgrfyY49p3WWTe89UXuV4tv9FZzWtqhUWJ/s7NFti1WhpT/uUrmR5LHpbnZsPQbizOT4lCCXU4qxvJzHRTXNDc2N1BRAV2Xlkjq/3Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=se2Q5oyT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=z71MR9/FB4ZLioSpgSrKFmW/9gLRNuEnvteXucs//5s=; b=se2Q5oyTwGO5A10GW19iibXdJX
	2vm1ab+CjApvrXcmZbyd6fjRwHnPI1eEobHTO9OJvlpIpXILvRHyeN1fud9edIbk2nv6mhx6MoKdf
	kyPxYhkY97Fg31Fi49zDc38CY30gObZ68HaAhenQStO14BDseyhHhlJTFDwzAPQhhBfnTyXoHMOHM
	W628az/zUbLDjK2Si4P/cAzMULNAiLCiYZhnZJhKPBOnntgs6+JZ4oXVaFINEv9Mdi+DuJrTIkXa5
	j0THh6+kmi2KQIfxdMj6saaPA7pFydYV1auPPZm+J2ywqo2S85CyVF7KbR6qLy5HuwJw/3KG3Lriy
	GLIF6NUQ==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx7ES-0000000GabK-0bD4;
	Wed, 17 Apr 2024 15:29:56 +0000
Message-ID: <1c1bc9c3-978c-4e41-8a4b-66da25416304@infradead.org>
Date: Wed, 17 Apr 2024 08:29:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 03/10] net: create a dummy net_device
 allocator
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Johannes Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>,
 Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 elder@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, nbd@nbd.name, sean.wang@mediatek.com,
 Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, taras.chornyi@plvision.eu,
 ath11k@lists.infradead.org, ath10k@lists.infradead.org,
 linux-wireless@vger.kernel.org, geomatsi@gmail.com, kvalo@kernel.org,
 quic_jjohnson@quicinc.com, leon@kernel.org,
 dennis.dalessandro@cornelisnetworks.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, idosch@idosch.org,
 Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
 Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20240411135952.1096696-1-leitao@debian.org>
 <20240411135952.1096696-4-leitao@debian.org>
 <20240412191626.2e9bfb4a@kernel.org>
 <ebe80c29-4884-488d-ab83-c020f9c3bc81@intel.com>
 <e0d5741ee053c11fe078fc8afe6cf4a92e274095.camel@sipsolutions.net>
 <d4991f11-a527-429d-b71f-d4ca3a18f501@intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <d4991f11-a527-429d-b71f-d4ca3a18f501@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/17/24 4:19 AM, Alexander Lobakin wrote:
> From: Johannes Berg <johannes@sipsolutions.net>
> Date: Wed, 17 Apr 2024 13:11:38 +0200
> 
>> On Wed, 2024-04-17 at 12:51 +0200, Alexander Lobakin wrote:
>>> Just FYI: kdoc accepts only this pattern:
>>>
>>>  * @last_param: blah
>>>  *
>>>  * Return: blah
>>>
>>> NOT
>>>
>>>  * Returns: blah
>>
>> Actually, it does accept that, the regex is "returns?". It's just

ack (Return: is documented)

> Hmm, I was sure I had warnings on "Returns:"... Not sure now.
> 
Yes, either way is accepted.

> documented only as "Return" . IMHO it sometimes reads nicer as "Returns"
>> depending on how you phrase it, but ...

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

