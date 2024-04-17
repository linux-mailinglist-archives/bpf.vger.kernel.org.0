Return-Path: <bpf+bounces-27067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0708A8C46
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 21:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113E21F225F0
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 19:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E7D2D03D;
	Wed, 17 Apr 2024 19:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-braunschweig.de header.i=@tu-braunschweig.de header.b="fhrosDxa"
X-Original-To: bpf@vger.kernel.org
Received: from pmxout2.rz.tu-bs.de (pmxout2.rz.tu-bs.de [134.169.4.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CDF2134B
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.169.4.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713382937; cv=none; b=uEO4458YK5TTfuEW9DmVlQkPRF3kic31f07JIs0q6/DeqYdgFrieUsdS5zdYs36Ao3PfHJqDWWCTpH0WEJunbCFcMkeoykGoh7UDIP7fLpGXkcHGQPG/oEtbQyeBu45yPCdEwx/Y/qscz+oTmHGMj4E/G/DS5y6yaa2xdWWdDbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713382937; c=relaxed/simple;
	bh=XO2Q7TzKpE5epUMS/TwrUpxwAO6W/D5ssv7Ia+IK6Bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pwcZa2TEKeiSRw16SO8GIq7JmUbX9n/KE4aXoZKIvJkoc81SNZVMURThRPK4Zc/5BowrImsjqH1rzK8RxRxtYiGC6JYSa21/ldPQgsk7cFRcOe/IXdoLu/wMn9zHbL7fgF8f7WAudHpe9uhejWIfy72UiKHLCN9rlDqbDv+X+9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-braunschweig.de; spf=pass smtp.mailfrom=tu-braunschweig.de; dkim=pass (2048-bit key) header.d=tu-braunschweig.de header.i=@tu-braunschweig.de header.b=fhrosDxa; arc=none smtp.client-ip=134.169.4.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-braunschweig.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-braunschweig.de
Received: from Hermes12.ad.tu-bs.de (hermes12.rz.tu-bs.de [134.169.4.140])
	by pmxout2.rz.tu-bs.de (Postfix) with ESMTPS id 386504E03A0;
	Wed, 17 Apr 2024 21:42:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-braunschweig.de;
	s=exchange_neu; t=1713382933;
	bh=XO2Q7TzKpE5epUMS/TwrUpxwAO6W/D5ssv7Ia+IK6Bo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:From;
	b=fhrosDxaV+J7CrVmtGCieCXzxXNd1AZ3U5V9P5Bt58YlJLKz8yf4JB8fCr7ku6eiD
	 8MQLmsWI7FWyGlmEkvl3T0WG2jlSoANNnG9wrq8nkRguEGLJ2YcQ34tN81Z/xYd8Zt
	 PLKBwnHbGM8DH7Ejry/S8niNRHh74VFrQtXtnhgnQWRYKb0G4op78MnhtvOwXOiqWc
	 hhBJAv2h8hwEYLbP1t8VvfslfUYcR+Q9BdWieY0JS8DbrUahjpjK5RezODCOz5VkIo
	 +gHq4b3Oamc+S+IbqldYV3GUKyKukzBQC0nsIlBLetvwXl0q6f5/Gt6IieHB9xVKZA
	 BB9z1k+Dp6pHQ==
Received: from [192.168.178.142] (134.169.9.110) by Hermes12.ad.tu-bs.de
 (134.169.4.140) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.32; Wed, 17 Apr
 2024 21:42:12 +0200
Message-ID: <0f25d048-77fa-416c-b4ae-ddf7109deff1@tu-braunschweig.de>
Date: Wed, 17 Apr 2024 21:42:12 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: No direct copy from ctx to map possible, why?
To: Hengqi Chen <hengqi.chen@gmail.com>
CC: <bpf@vger.kernel.org>
References: <36c8d494-e1cf-4361-8187-05abe4698791@tu-braunschweig.de>
 <CAEyhmHQZD+F=dJTS8Pywp6vyKfo0Fo=O4Ww+8o=6+GwJ-WogLQ@mail.gmail.com>
Content-Language: de-DE, en-US
From: Fabian Pfitzner <f.pfitzner@tu-braunschweig.de>
Autocrypt: addr=f.pfitzner@tu-braunschweig.de; keydata=
 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
In-Reply-To: <CAEyhmHQZD+F=dJTS8Pywp6vyKfo0Fo=O4Ww+8o=6+GwJ-WogLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: Hermes04.ad.tu-bs.de (134.169.4.132) To
 Hermes12.ad.tu-bs.de (134.169.4.140)

> Have you tried bpf_xdp_output() helper ?
I haven't. Can I use that helper even though my program isn't related to 
perf at all?
I'll definitely give it a try. Thanks

On 4/16/24 7:12 AM, Hengqi Chen wrote:
> On Mon, Apr 15, 2024 at 5:41 AM Fabian Pfitzner
> <f.pfitzner@tu-braunschweig.de> wrote:
>> Hello,
>>
>> is there a specific reason why it is not allowed to copy data from ctx
>> directly into a map via the bpf_map_update_elem helper?
>> I develop a XDP program where I need to store incoming packets
>> (including the whole payload) into a map in order to buffer them.
>> I thought I could simply put them into a map via the mentioned helper
>> function, but the verifier complains about expecting another type as
>> "ctx" (R3 type=ctx expected=fp, pkt, pkt_meta, .....).
>>
>> I was able to circumvent this error by first putting the packet onto the
>> stack (via xdp->data) and then write it into the map.
>> The only limitation with this is that I cannot store packets larger than
>> 512 bytes due to the maximum stack size.
>>
>> I was also able to circumvent this by slicing chunks, that are smaller
>> than 512 bytes, out of the packet so that I can use the stack as a
>> clipboard before putting them into the map. This is a really ugly
>> solution, but I have not found a better one yet.
>>
> Have you tried bpf_xdp_output() helper ?
>
>> So my question is: Why does this limitation exist? I am not sure if its
>> only related to XDP programs as this restriction is defined inside of
>> the bpf_map_update_elem_proto struct (arg3_type restricts this), so I
>> think it is a general limitation that affects all program types.
>>
>> Best regards,
>> Fabian Pfitzner
>>
>>
>>
>>

