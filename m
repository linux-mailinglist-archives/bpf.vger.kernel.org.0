Return-Path: <bpf+bounces-55313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A4EA7B861
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 09:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10A13B800A
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 07:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7917B194A6C;
	Fri,  4 Apr 2025 07:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CC5HlRub"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BB51552E3;
	Fri,  4 Apr 2025 07:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743752860; cv=none; b=DMpZd6uwwrK33E9hds6K3y4bwUy4jzmo1qZ0BTZM9+h9TgdMosVlFE94JEK/LlM9sB1RNm7exhkE4PSkWta0zUSD0xg7rtcU0PmWDbV5Lvs8u3VXwtKt4YJrEHW2yhq4V8Rb5Kr1x7kJ+CNPKTsAsY9psuWU0Ioqau6/dBBlEtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743752860; c=relaxed/simple;
	bh=n3WVEOSVyo5twplGrYfxLFXNkYDXkXuKVIkLlw7ygbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GeR0ot0eARwDW9owUf7TPHvIVAx1qg9Cd0IZvTj9sF4/UpqPOSTb23f6j0kiy7mr6vaj706IcKLMttEeRMElp3VYaMOZ9yVhQ/8ncb5r5ToKgw5kRxE8Y8QDLcI5inTO9By/GoAwUE2AJXuE610EzBY0d1GzOIweYVOM9J0t0O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CC5HlRub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648B5C4CEDD;
	Fri,  4 Apr 2025 07:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743752859;
	bh=n3WVEOSVyo5twplGrYfxLFXNkYDXkXuKVIkLlw7ygbk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CC5HlRubywiTUHDH3GzqNyIgC1CyFlxgDXREVTm98WIyeYzkFtFs1a/eZoA1kVwWy
	 OQury3Z2olmo+RsZFmcEkI9l2TlvcYevXb6UpYO36+NuZLGzgGohMhfUzUUkOeR3ZE
	 GsyjJqoQatJnwtYUJxI385nqicOS+N5RxwEyl3ayC7VhmCQYA+yQZIFc0njrKNU3Vt
	 bYaJjiUwN2dEOIEadffJuZIZ+TGdEkMwNpJ/EVOrzlgARVxCK6wTSh0jyurUNsP/it
	 7WkwttaqqGemqoIwLYqZvVcPffwhGG1EXh/aH9PJ/nKWsgAS2Cwi8c0wyf3bQgm/He
	 dVGBSaXr9RaRw==
Message-ID: <58d26423-04da-4491-9318-d4a7a1f12005@kernel.org>
Date: Fri, 4 Apr 2025 10:47:31 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/3] net: ti: icss-iep: Fix possible NULL pointer
 dereference for perout request
To: Paolo Abeni <pabeni@redhat.com>, "Malladi, Meghana" <m-malladi@ti.com>,
 dan.carpenter@linaro.org, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 namcao@linutronix.de, javier.carrasco.cruz@gmail.com, diogo.ivo@siemens.com,
 horms@kernel.org, jacob.e.keller@intel.com, john.fastabend@gmail.com,
 hawk@kernel.org, daniel@iogearbox.net, ast@kernel.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>, danishanwar@ti.com
References: <20250328102403.2626974-1-m-malladi@ti.com>
 <20250328102403.2626974-4-m-malladi@ti.com>
 <0fb67fc2-4915-49af-aa20-8bdc9bed4226@kernel.org>
 <b0a099a6-33b2-49f9-9af7-580c60b98f55@ti.com>
 <469fd8d0-c72e-4ca6-87a9-2f42b180276b@redhat.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <469fd8d0-c72e-4ca6-87a9-2f42b180276b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03/04/2025 14:25, Paolo Abeni wrote:
> On 4/2/25 2:37 PM, Malladi, Meghana wrote:
>> On 4/2/2025 5:58 PM, Roger Quadros wrote:
>>> On 28/03/2025 12:24, Meghana Malladi wrote:
>>>> ICSS IEP driver has flags to check if perout or pps has been enabled
>>>> at any given point of time. Whenever there is request to enable or
>>>> disable the signal, the driver first checks its enabled or disabled
>>>> and acts accordingly.
>>>>
>>>> After bringing the interface down and up, calling PPS/perout enable
>>>> doesn't work as the driver believes PPS is already enabled,
>>>
>>> How? aren't we calling icss_iep_pps_enable(iep, false)?
>>> wouldn't this disable the IEP and clear the iep->pps_enabled flag?
>>>
>>
>> The whole purpose of calling icss_iep_pps_enable(iep, false) is to clear 
>> iep->pps_enabled flag, because if this flag is not cleared it hinders 
>> generating new pps signal (with the newly loaded firmware) once any of 
>> the interfaces are up (check icss_iep_perout_enable()), so instead of 
>> calling icss_iep_pps_enable(iep, false) I am just clearing the 
>> iep->pps_enabled flag.
> 
> IDK what Roger thinks, but the above is not clear to me. I read it as
> you are stating that icss_iep_pps_enable() indeed clears the flag, so i
> don't see/follow the reasoning behind this change.
> 
> Skimmir over the code, icss_iep_pps_enable() could indeed avoid clearing
> the flag under some circumstances is that the reason?
> 
> Possibly a more describing commit message would help.

I would expect that modifying the xxx_enabled flag should be done only
in the icss_iep_xxx_enable() function. Doing it anywhere else will be difficult
to track/debug in the long term.

I don't see why the flag needs to be set anywhere else. Maye better to
improve logic inside icss_iep_pps_enable() like Paolo suggests.

> 
>>> And, what if you brought 2 interfaces of the same ICSS instances up
>>> but put only 1 interface down and up?
>>>
>>
>> Then the flag need not be disabled if only one interface is brought down 
>> because the IEP is still alive and all the IEP configuration (including 
>> pps/perout) is still valid.
> 
> I read the above as stating this fix is not correct in such scenario,
> leading to the wrong final state.
> 
> I think it would be better to either give a better reasoning about this
> change in the commit message or refactor it to handle even such scenario,
> 
> Thanks,
> 
> Paolo
> 

-- 
cheers,
-roger


